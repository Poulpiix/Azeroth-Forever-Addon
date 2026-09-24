#!/usr/bin/env python3
"""
Azeroth Forever : convertit data/textures/*.webp|*.jpg|*.jpeg|*.png en TGA
32 bits (RGBA) pour l'addon, et écrit un manifeste Lua listant ce qui a
réellement été produit.

Usage :
    python3 tools/convert-textures.py

Entrée  : data/textures/ (hors du dossier addon, jamais embarquée telle
          quelle : ni .webp ni .jpg ne doivent finir dans l'addon).
Sortie  : addon/AzerothForever/Textures/*.tga
          addon/AzerothForever/Data/TextureManifest.lua

Le manifeste est ce que UI.lua consulte pour savoir si une texture
personnalisée existe réellement avant d'essayer de l'utiliser (WoW n'a pas
d'API pour tester si un fichier existe : SetTexture sur un chemin absent ne
plante pas, mais reste invisible sans qu'on puisse le distinguer d'une vraie
image transparente — le manifeste lève cette ambiguïté).

Un fichier qui ne s'ouvre pas (format non supporté, corrompu) est ignoré et
listé en fin d'exécution : rien ne s'arrête pour un seul fichier en échec.
"""
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC_DIR = os.path.join(ROOT, "data", "textures")
OUT_DIR = os.path.join(ROOT, "addon", "AzerothForever", "Textures")
MANIFEST_PATH = os.path.join(ROOT, "addon", "AzerothForever", "Data", "TextureManifest.lua")

# Noms de sortie attendus (voir la demande) : mappés depuis des noms de
# fichiers sources plausibles, sans deviner un contenu qu'on n'a pas.
CLASS_SLUGS = {
    "warrior": "class_warrior", "guerrier": "class_warrior",
    "paladin": "class_paladin",
    "hunter": "class_hunter", "chasseur": "class_hunter",
    "rogue": "class_rogue", "voleur": "class_rogue",
    "priest": "class_priest", "pretre": "class_priest", "prêtre": "class_priest",
    "shaman": "class_shaman", "chaman": "class_shaman",
    "mage": "class_mage",
    "warlock": "class_warlock", "demoniste": "class_warlock", "démoniste": "class_warlock",
    "druid": "class_druid", "druide": "class_druid",
}
BANNER_SLUGS = {
    "alliance": "banner_alliance",
    "horde": "banner_horde",
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
    for key, out in {**CLASS_SLUGS, **BANNER_SLUGS}.items():
        if key in stem:
            return out
    # Nom court, sans espace, tel quel si on ne reconnaît pas le sujet -
    # on ne devine pas ce qu'il montre, on garde juste un nom propre.
    return stem[:40]


def main():
    Image = try_import_pillow()

    if not os.path.isdir(SRC_DIR):
        print(f"[convert-textures] {SRC_DIR} n'existe pas : rien à convertir.")
        print("[convert-textures] Déposez vos images dans data/textures/ puis relancez ce script.")
        write_manifest({})
        return

    candidates = [
        f for f in sorted(os.listdir(SRC_DIR))
        if os.path.splitext(f)[1].lower() in (".webp", ".jpg", ".jpeg", ".png")
    ]
    if not candidates:
        print(f"[convert-textures] Aucune image (.webp/.jpg/.jpeg/.png) trouvée dans {SRC_DIR}.")
        write_manifest({})
        return

    os.makedirs(OUT_DIR, exist_ok=True)
    converted = {}
    failed = []

    for filename in candidates:
        src_path = os.path.join(SRC_DIR, filename)
        out_name = resolve_output_name(filename)
        out_path = os.path.join(OUT_DIR, out_name + ".tga")
        try:
            with Image.open(src_path) as img:
                img = img.convert("RGBA")
                img.save(out_path, format="TGA")
            converted[out_name] = filename
            print(f"[convert-textures] OK  {filename} -> Textures/{out_name}.tga ({img.width}x{img.height})")
        except Exception as exc:
            failed.append((filename, str(exc)))
            print(f"[convert-textures] ECHEC {filename} : {exc}", file=sys.stderr)

    write_manifest(converted)

    print()
    print(f"[convert-textures] {len(converted)} fichier(s) converti(s), {len(failed)} en échec.")
    if failed:
        print("[convert-textures] Fichiers ignorés :")
        for filename, reason in failed:
            print(f"  - {filename} : {reason}")


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
