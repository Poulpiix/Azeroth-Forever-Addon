#!/usr/bin/env python3
"""
Azeroth Forever : convertit les images de data/Textures/ (ou data/textures/,
au cas où) en TGA 32 bits (RGBA) pour l'addon, et écrit un manifeste Lua
listant ce qui a réellement été produit.

Usage :
    python3 tools/convert-textures.py

Entrée  : data/Textures/ en priorité, data/textures/ en repli si le premier
          n'existe pas (les deux sont vérifiés, jamais embarqués tels
          quels : ni .webp ni .jpg ne doivent finir dans l'addon).
Sortie  : addon/AzerothForever/Textures/*.tga
          addon/AzerothForever/Data/TextureManifest.lua

Le manifeste est ce que UI.lua consulte pour savoir si une texture
personnalisée existe réellement avant d'essayer de l'utiliser (WoW n'a pas
d'API pour tester si un fichier existe : SetTexture sur un chemin absent ne
plante pas, mais reste invisible sans qu'on puisse le distinguer d'une vraie
image transparente — le manifeste lève cette ambiguïté).

Un fichier qui ne s'ouvre pas (format non supporté, corrompu) est ignoré et
listé en fin d'exécution : rien ne s'arrête pour un seul fichier en échec.

Nommage (important) : un "class_<x>.jpg" (icône carrée) et un
"banner-<x>.webp" (bannière large) pour la MÊME classe sont deux images
différentes et ne doivent jamais écraser le même fichier de sortie. Le
préfixe de la source (class_ / banner_) est donc gardé dans le nom de
sortie, avec la classe normalisée sous le préfixe qui lui correspond déjà
dans le reste du code (icônes de classe : slug anglais, ex. "warrior" ;
bannières : slug français, ex. "guerrier", identique à cls.slug utilisé par
UI.lua pour retrouver la bannière de la classe affichée).
"""
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC_DIRS = [
    os.path.join(ROOT, "data", "Textures"),
    os.path.join(ROOT, "data", "textures"),
]
OUT_DIR = os.path.join(ROOT, "addon", "AzerothForever", "Textures")
MANIFEST_PATH = os.path.join(ROOT, "addon", "AzerothForever", "Data", "TextureManifest.lua")

# Icônes de classe (préfixe "class_") : slug ANGLAIS, ce que UI.lua construit
# depuis l'id de classe WoW (CLASS_FILE_BY_ID) — pas cls.slug, qui est en
# français.
CLASS_ICON_SLUG = {
    "warrior": "warrior", "guerrier": "warrior",
    "paladin": "paladin",
    "hunter": "hunter", "chasseur": "hunter",
    "rogue": "rogue", "voleur": "rogue",
    "priest": "priest", "pretre": "priest", "prêtre": "priest",
    "shaman": "shaman", "chaman": "shaman",
    "mage": "mage",
    "warlock": "warlock", "demoniste": "warlock", "démoniste": "warlock",
    "druid": "druid", "druide": "druid",
}

# Bannières d'arbre (préfixe "banner_") : slug FRANÇAIS, ce que cls.slug vaut
# réellement dans les données (data/talents-data.js), pour matcher tel quel
# la clé que UI.lua cherche déjà ("banner_" .. cls.slug).
BANNER_CLASS_SLUG = {
    "guerrier": "guerrier", "warrior": "guerrier",
    "paladin": "paladin",
    "chasseur": "chasseur", "hunter": "chasseur",
    "voleur": "voleur", "rogue": "voleur",
    "pretre": "pretre", "prêtre": "pretre", "priest": "pretre",
    "chaman": "chaman", "shaman": "chaman",
    "mage": "mage",
    "demoniste": "demoniste", "démoniste": "demoniste", "warlock": "demoniste",
    "druide": "druide", "druid": "druide",
}

# Fichiers exportés depuis le site sous un nom opaque (identifiant d'upload,
# pas de sens sémantique) : identifiés visuellement et confirmés par
# l'utilisateur comme les fonds de fenêtre Alliance/Horde. Correspondance par
# nom de fichier exact (sans extension, en minuscules), vérifiée avant toute
# autre règle de nommage.
FILENAME_OVERRIDE = {
    "hsi9s2easaaire0": "banner_alliance",
    "hsrp1mkxgaaa1ab": "banner_horde",
}


def try_import_pillow():
    try:
        from PIL import Image
        return Image
    except ImportError:
        print("Pillow n'est pas installé (pip install Pillow). Abandon.", file=sys.stderr)
        sys.exit(1)


def resolve_output_name(filename):
    stem = os.path.splitext(filename)[0].lower().replace(" ", "_").replace("-", "_")

    if stem in FILENAME_OVERRIDE:
        return FILENAME_OVERRIDE[stem]

    if stem.startswith("class_") or stem.startswith("classicon_"):
        rest = stem.split("_", 1)[1] if "_" in stem else stem
        for key, slug in CLASS_ICON_SLUG.items():
            if key in rest:
                return "class_" + slug
        return stem[:40]

    if stem.startswith("banner_"):
        rest = stem[len("banner_"):]
        for key, slug in BANNER_CLASS_SLUG.items():
            if key in rest:
                return "banner_" + slug
        for key in ("alliance", "horde", "heritage", "heritage"):
            if key in rest:
                return "banner_" + key
        return stem[:40]

    for key in ("alliance", "horde"):
        if key in stem:
            return "banner_" + key

    # Nom court, sans espace, tel quel si on ne reconnaît pas le sujet - on
    # ne devine pas ce qu'il montre, on garde juste un nom propre.
    return stem[:40]


def find_source_dir():
    for d in SRC_DIRS:
        if os.path.isdir(d):
            return d
    return None


def main():
    Image = try_import_pillow()

    existing_dirs = [d for d in SRC_DIRS if os.path.isdir(d)]
    if not existing_dirs:
        checked = " ni ".join(os.path.relpath(d, ROOT) for d in SRC_DIRS)
        print(f"[convert-textures] Ni {checked} n'existe : rien à convertir.")
        print("[convert-textures] Déposez vos images dans data/Textures/ puis relancez ce script.")
        write_manifest({})
        return

    os.makedirs(OUT_DIR, exist_ok=True)
    converted = {}   # out_name -> nom de fichier source (le premier gagne)
    failed = []
    skipped_dupes = []

    for src_dir in existing_dirs:
        candidates = sorted(
            f for f in os.listdir(src_dir)
            if os.path.splitext(f)[1].lower() in (".webp", ".jpg", ".jpeg", ".png")
        )
        for filename in candidates:
            src_path = os.path.join(src_dir, filename)
            out_name = resolve_output_name(filename)
            if out_name in converted:
                skipped_dupes.append((filename, out_name, converted[out_name]))
                continue
            out_path = os.path.join(OUT_DIR, out_name + ".tga")
            try:
                with Image.open(src_path) as img:
                    img = img.convert("RGBA")
                    img.save(out_path, format="TGA")
                converted[out_name] = filename
                rel_src = os.path.relpath(src_path, ROOT)
                print(f"[convert-textures] OK  {rel_src} -> Textures/{out_name}.tga ({img.width}x{img.height})")
            except Exception as exc:
                failed.append((os.path.relpath(src_path, ROOT), str(exc)))
                print(f"[convert-textures] ECHEC {os.path.relpath(src_path, ROOT)} : {exc}", file=sys.stderr)

    write_manifest(converted)

    print()
    print(f"[convert-textures] {len(converted)} fichier(s) converti(s), {len(failed)} en échec, {len(skipped_dupes)} doublon(s) ignoré(s).")
    if failed:
        print("[convert-textures] Fichiers ignorés (échec) :")
        for filename, reason in failed:
            print(f"  - {filename} : {reason}")
    if skipped_dupes:
        print("[convert-textures] Fichiers ignorés (même nom de sortie qu'un autre déjà converti) :")
        for filename, out_name, first_source in skipped_dupes:
            print(f"  - {filename} -> {out_name}.tga (déjà produit par {first_source})")


def write_manifest(converted):
    os.makedirs(os.path.dirname(MANIFEST_PATH), exist_ok=True)
    lines = [
        "-- Azeroth Forever : manifeste des textures personnalisées réellement",
        "-- présentes dans Textures/ (généré par tools/convert-textures.py).",
        "-- WoW n'a pas d'API pour tester si un fichier existe : ce manifeste",
        "-- permet à UI.lua de savoir AVANT d'essayer, plutôt que de deviner.",
        "local ADDON_NAME, AF = ...",
        "",
        "AF.Data = AF.Data or {}",
        "AF.Data.TextureManifest = {",
    ]
    for key in sorted(converted.keys()):
        lines.append(f'  ["{key}"] = true,')
    lines.append("}")
    lines.append("")
    with open(MANIFEST_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))
    print(f"[convert-textures] Manifeste écrit : {os.path.relpath(MANIFEST_PATH, ROOT)} ({len(converted)} entrée(s))")


if __name__ == "__main__":
    main()
