-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- Deutsch. Complete: same keys as enUS. Tone: short, WoW UI wording (Stufe, EP, Schlachtzüge, Ihr/Euch).
-- Tokens (%s, %d, %1$s, |cffRRGGBB, |r) are kept as in enUS. state.*_caps use normal German case on purpose.
-- The Legacy tree keeps its English name until the German Forever client term is known.
local ADDON_NAME, AF = ...

AF:RegisterLocale("deDE", {
  -- core
  ["core.loaded"] = "geladen%s. Gebt |cffffd100/af|r ein oder klickt auf den Minikarten-Button, um das Addon zu öffnen.",
  ["core.ui_missing"] = "Oberfläche nicht geladen.",

  -- path
  ["path.err.empty"] = "Pfad leer oder abgeschnitten.",
  ["path.err.version"] = "Unbekannte Pfadversion.",
  ["path.err.header"] = "Ungültiger Pfadkopf.",
  ["path.err.too_long"] = "Pfad zu lang (mehr als %d Punkte).",
  ["path.err.char"] = "Ungültiges Zeichen im Pfad.",
  ["path.err.unknown_talent"] = "Unbekanntes Talent in diesem Pfad.",
  ["path.err.maxed"] = "%s hat bereits den Höchstrang (%d).",
  ["path.err.cap"] = "Obergrenze von %d Punkten erreicht.",
  ["path.err.other_talent"] = "ein anderes Talent",
  ["path.err.prereq"] = "%s benötigt %s auf Rang %d.",
  ["path.err.tier"] = "%s benötigt %d Punkte im Baum %s (%d an dieser Stelle des Pfads).",
  ["path.err.cannot_remove"] = "%s kann nicht entfernt werden: %s",

  -- talents
  ["talents.err.class_unknown"] = "Unbekannte Klasse.",
  ["talents.err.talent_unknown"] = "Unbekanntes Talent.",
  ["talents.count"] = "%d Talente",
  ["talents.head_sub"] = "%s · %s, %d neu und %d geändert",
  ["talents.client_data"] = "Clientdaten %s",

  -- apply
  ["apply.err.unreadable"] = "Talente im Spiel nicht lesbar: gebt /af diag ein.",
  ["apply.err.not_found"] = "%s wurde im Client nicht gefunden.",
  ["apply.err.not_learnable"] = "%s kann noch nicht erlernt werden (Voraussetzung oder Baumpunkte).",
  ["apply.info.nothing_to_apply_learned"] = "Nichts anzuwenden: der Build ist im Spiel bereits erlernt.",
  ["apply.err.cannot_unlearn"] = "Das Spiel erlaubt nicht, einen einzelnen erlernten Punkt zu verlernen",
  ["apply.err.combat"] = "Im Kampf nicht möglich.",
  ["apply.err.locked"] = "Talente können gerade nicht geändert werden.",
  ["apply.err.no_points"] = "Keine Talentpunkte auf diesem Charakter verfügbar.",
  ["apply.err.no_more_points"] = "Keine Punkte mehr für den Rest des Builds verfügbar.",
  ["apply.err.refused"] = "Das Spiel hat %s abgelehnt.",
  ["apply.err.nothing"] = "Nichts anzuwenden.",
  ["apply.err.not_validated"] = "Das Spiel hat die Talente nicht bestätigt.",
  ["apply.err.none_learned"] = "Kein Punkt des Builds ist im Spiel erlernt.",
  ["apply.err.refused_remove"] = "Das Spiel hat das Entfernen von %s abgelehnt.",
  ["apply.ok.removed"] = "Im Spiel entfernt: %s.",
  ["apply.err.timeout"] = "Das Spiel hat die angeforderten Talente nicht erlernt.",
  ["apply.warn.learned.one"] = "%d Punkt erlernt. %s",
  ["apply.warn.learned.other"] = "%d Punkte erlernt. %s",
  ["apply.ok.build_applied"] = "Build im Spiel angewendet: %d Punkte erlernt.",
  ["apply.ok.learned"] = "Im Spiel erlernt: %s.",

  -- share
  ["share.err.empty_any"] = "Fügt einen Code ein, der mit AF1- (Klasse) oder AF1H- (Legacy) beginnt.",
  ["share.err.not_af_any"] = "Das ist kein Azeroth-Forever-Code: er muss mit AF1- oder AF1H- beginnen.",
  ["share.err.incomplete"] = "Code unvollständig: kopiert ihn ganz, bis zu den letzten 2 Zeichen.",
  ["share.err.corrupt"] = "Code beschädigt (falsche Prüfsumme): kopiert ihn ganz.",
  ["share.err.kind"] = "Unbekannter Codetyp.",
  ["share.err.class_in_code"] = "Unbekannte Klasse in diesem Code.",
  ["share.err.empty_class"] = "Fügt einen Code ein, der mit AF1- beginnt.",
  ["share.err.is_heritage"] = "Das ist ein Legacy-Code: lest ihn im Reiter Legacy.",
  ["share.err.not_af_class"] = "Das ist kein Azeroth-Forever-Code: er muss mit AF1- beginnen.",
  ["share.err.class_or_catalog"] = "Unbekannte Klasse in diesem Code (oder anderer Talentkatalog: aktualisiert das Addon).",
  ["share.err.catalog_changed"] = "Der Talentkatalog hat sich geändert: aktualisiert das Addon (%s)",
  ["share.err.impossible_order"] = "Dieser Code beschreibt eine unmögliche Reihenfolge (Schritt %d): %s",
  ["share.export_error"] = "Export nicht möglich: %s",
  ["share.copy_link"] = "Link kopieren",
  ["share.link_help_build"] = "Link zu dieser Seite (Build + Punktreihenfolge)",
  ["share.copy_code"] = "Addon-Code kopieren",
  ["share.code_help_class"] = "AF1-Code zum Einfügen im Addon oder auf der Seite",
  ["share.code_title"] = "Addon-Code",
  ["share.paste"] = "Code einfügen",
  ["share.paste_menu_help"] = "AF1-Code (Klasse) oder AF1H-Code (Legacy)",
  ["share.paste_popup_help"] = "AF1-Code (Klasse) oder AF1H-Code (Legacy), dann Importieren.",
  ["share.public_help"] = "Strg+C zum Kopieren, dann den Link im Browser öffnen.",
  ["share.public_title"] = "Öffentliche Builds %s",

  -- heritage
  ["heritage.err.is_class"] = "Das ist ein Klassencode (AF1-), kein Legacy-Code.",
  ["heritage.err.version"] = "Unbekannte Legacy-Codeversion: aktualisiert die Seite.",
  ["heritage.err.unreadable"] = "Legacy-Code nicht lesbar (%d Ränge statt %d).",
  ["heritage.err.rank_max"] = "%s kann Rang %d nicht überschreiten.",
  ["heritage.err.too_many"] = "Dieser Code verteilt mehr als %d Legacy-Punkte.",
  ["heritage.err.tiers"] = "Dieser Code hält die Punktstufen des Baums nicht ein.",
  ["heritage.err.node_unknown"] = "Unbekannter Knoten.",
  ["heritage.err.cap"] = "Legacy-Obergrenze von %d Punkten erreicht.",
  ["heritage.err.tier_locked"] = "Stufe für %s nicht erreicht.",
  ["heritage.err.preset_invalid"] = "Ungültige Vorlage.",
  ["heritage.err.preset_unknown"] = "Unbekannte Vorlage.",
  ["heritage.title"] = "Legacy-Baum",
  ["heritage.sub"] = "Berufe · Abenteuer · Einfallsreichtum · %s",
  ["heritage.total_points"] = "%d Punkte",
  ["heritage.stat.spent_caps"] = "PUNKTE VERTEILT",
  ["heritage.stat.left_caps"] = "PUNKTE ÜBRIG",
  ["heritage.reset_done"] = "Legacy zurückgesetzt.",
  ["heritage.view_at"] = "Meinen Legacy-Build bei %s verteilten Punkten zeigen",
  ["heritage.unknown_skill"] = "Unbekannte Fähigkeit",
  ["heritage.unknown_skill_hint"] = "Folgt in einem späteren Update.",
  ["heritage.tip.rank_meta"] = "Rang %d/%d · %s",
  ["heritage.tip.passive"] = "Passiv",
  ["heritage.tip.at_points"] = "Bei %d verteilten Punkten: Rang %d/%d",
  ["heritage.tip.requires"] = "Benötigt %d verteilte Legacy-Punkte in %s.",
  ["heritage.imported"] = "Legacy importiert (%d Punkte).",
  ["heritage.link_help"] = "Link zu dieser Seite (?hbuild=)",
  ["heritage.code_help"] = "AF1H-Code zum Einfügen im Addon oder auf der Seite",
  ["heritage.talented_note"] = "Eure Klassentalente beginnen auf Stufe 9.",
  ["heritage.tree.professions"] = "Berufe",
  ["heritage.col.professions.sub"] = "Herstellung, Sammeln und Gold.",
  ["heritage.node.travail-acharne.name"] = "Harte Arbeit",
  ["heritage.node.travail-acharne.desc"] = "Erhöht Eure Chance, beim Ausüben eines Haupt-, Neben- oder Klassenberufs einen Fertigkeitspunkt zu erhalten, um 4%.",
  ["heritage.node.marchandage.name"] = "Feilschen",
  ["heritage.node.marchandage.desc"] = "Verringert den Goldpreis von Gegenständen bei allen Händlern um 5%.",
  ["heritage.node.chef-etoile.name"] = "Sternekoch",
  ["heritage.node.chef-etoile.desc"] = "Eure Kochrezepte haben eine Chance von 10%, ein zusätzliches Ergebnis herzustellen.",
  ["heritage.node.etude-assidue.name"] = "Fleißiges Studium",
  ["heritage.node.etude-assidue.desc"] = "Erhöht Eure niedrigste Fertigkeit unter Euren aktuellen Haupt- und Nebenberufen um 1 Punkt. Habt Ihr bereits 300 in beiden Hauptberufen und allen drei Nebenberufen erreicht, erhaltet Ihr 2 bis 4 zufällige Elementaressenzen.",
  ["heritage.node.etude-assidue.meta"] = "25 Sek. Zauberzeit, 23 Std. Abklingzeit",
  ["heritage.node.recolte-abondante.name"] = "Reiche Ernte",
  ["heritage.node.recolte-abondante.desc"] = "Ihr findet 20% mehr ungewöhnliche Materialien beim Bergbau, bei der Kräuterkunde und beim Kürschnern.",
  ["heritage.node.prime-de-rendement.name"] = "Ertragsprämie",
  ["heritage.node.prime-de-rendement.desc"] = "Ihr habt eine Chance von 5%, 100% mehr Händlergunst zu erhalten, wenn Ihr eine Kiste an die Handelsbehörde von Azeroth oder an Durotar Logistik liefert.",
  ["heritage.node.maitre-appateur.name"] = "Meisterköderer",
  ["heritage.node.maitre-appateur.desc"] = "Beim Angeln mit einem aktiven Köder habt Ihr eine Chance von 25%, einen zusätzlichen Fisch zu fangen.",
  ["heritage.tree.adventure"] = "Abenteuer",
  ["heritage.col.adventure.sub"] = "Fortschritt, Erkundung und Nützliches.",
  ["heritage.node.haute-vigilance.name"] = "Höchste Wachsamkeit",
  ["heritage.node.haute-vigilance.desc"] = "Verbessert Eure Fähigkeit, getarnte Ziele in der Nähe zu entdecken, als wäre Eure Stufe um 1 höher. Wirkungslos auf Schlachtfeldern.",
  ["heritage.node.bien-repose.name"] = "Gut ausgeruht",
  ["heritage.node.bien-repose.desc"] = "Euer Erholungsbonus sammelt sich 4% schneller an und seine Obergrenze ist um 4% erhöht.",
  ["heritage.node.talentueux.name"] = "Talentiert",
  ["heritage.node.talentueux.desc"] = "Ihr erhaltet ab Stufe 9 statt ab Stufe 10 bei jedem Stufenaufstieg einen Talentpunkt, insgesamt nie mehr als 51 Talentpunkte.",
  ["heritage.node.frisson-aventure.name"] = "Nervenkitzel des Abenteuers",
  ["heritage.node.frisson-aventure.desc"] = "Ihr stellt im Verlauf von 10 Sek. 1% Eurer maximalen Gesundheit und Eures maximalen Manas wieder her, wenn Ihr einem nicht unbedeutenden Gegner den Todesstoß versetzt. Wirkungslos in Dungeons, Schlachtzügen und auf Schlachtfeldern.",
  ["heritage.node.guide-de-terrain.name"] = "Feldführer",
  ["heritage.node.guide-de-terrain.desc"] = "Verringert die Abklingzeit zum Hinzufügen von Lagerelementen um 8%.",
  ["heritage.node.grand-voyageur.name"] = "Erfahrener Reisender",
  ["heritage.node.grand-voyageur.desc"] = "Ihr erhaltet 50% Rabatt auf alle Flugrouten, und Euer Flugreittier fliegt 20% schneller.",
  ["heritage.node.medecine-de-terrain.name"] = "Feldmedizin",
  ["heritage.node.medecine-de-terrain.desc"] = "Verringert die Dauer des Effekts \"Kürzlich bandagiert\" um 5 Sek., wenn Ihr einen Verband benutzt. Wirkungslos in Dungeons, Schlachtzügen und auf Schlachtfeldern.",
  ["heritage.tree.ingenuity"] = "Einfallsreichtum",
  ["heritage.col.ingenuity.sub"] = "Unterhalt, Ruf und Ehre.",
  ["heritage.node.pour-un-plus-grand-honneur.name"] = "Für größere Ehre",
  ["heritage.node.pour-un-plus-grand-honneur.desc"] = "Erhöht die erhaltenen Ehrenpunkte um 2%.",
  ["heritage.node.gourmet.name"] = "Gourmet",
  ["heritage.node.gourmet.desc"] = "Erhöht die Dauer der positiven Effekte von Essen um 33%.",
  ["heritage.node.permanence.name"] = "Beständigkeit",
  ["heritage.node.permanence.desc"] = "Lang anhaltende Werte- oder Attributsboni, die Eure Klassenfähigkeiten der Gruppe oder dem Schlachtzug gewähren, halten 50% länger, ebenso die Vorteile durch das Rasten an einem Lager.",
  ["heritage.node.les-vifs-et-les-morts.name"] = "Die Schnellen und die Toten",
  ["heritage.node.les-vifs-et-les-morts.desc"] = "Erhöht Euer Bewegungstempo als Toter um 5%, und Eure hilfreichen Zauber und Fähigkeiten kosten 1 Min. lang nach einer Wiederbelebung oder bis zum Kampfbeginn keine Ressourcen.",
  ["heritage.node.economie-de-reactifs.name"] = "Reagenzienersparnis",
  ["heritage.node.economie-de-reactifs.desc"] = "Eure Klassenfähigkeiten benötigen keine beim Händler erhältlichen Reagenzien mehr, und Eure Lagerelemente des Rangs 1 kosten keine Reagenzien zur Herstellung.",
  ["heritage.node.renforcement.name"] = "Verstärkung",
  ["heritage.node.renforcement.desc"] = "Ihr verliert beim Tod 8% weniger Haltbarkeit.",
  ["heritage.node.diplomate.name"] = "Diplomat",
  ["heritage.node.diplomate.desc"] = "Erhöht Euren Rufgewinn um 2%.",

  -- tab
  ["tab.talents"] = "Talente",
  ["tab.heritage"] = "Legacy",
  ["tab.dungeons"] = "Dungeons & Schlachtzüge",

  -- faction
  ["faction.alliance_caps"] = "ALLIANZ",
  ["faction.horde_caps"] = "HORDE",
  ["faction.alliance"] = "Allianz",
  ["faction.horde"] = "Horde",
  ["faction.both"] = "Neutral",

  -- ui
  ["ui.err_section"] = "Oberflächenfehler (%s): %s",
  ["ui.err"] = "Oberflächenfehler: %s",
  ["ui.tagline"] = "WERKZEUGE FÜR WOW FOREVER",
  ["ui.close"] = "Schließen (Esc)",
  ["ui.site_tip"] = "Link zur Seite kopieren",
  ["ui.site_title"] = "Website Azeroth Forever",
  ["ui.site_hint"] = "Strg+C zum Kopieren des Links, dann im Browser einfügen.",

  -- cmd
  ["cmd.scale"] = "Fenstergröße: %s",
  ["cmd.diag_saved"] = "Diagnose nach /reload in SavedVariables\\AzerothForever.lua gespeichert.",
  ["cmd.debug"] = "Debugmodus: %s",
  ["cmd.help"] = "Befehle: /af, /af talents, /af legacy, /af dungeons, /af scale 0.8, /af diag, /af survey, /af loot, /af minimap, /af locale, /af debug",
  ["cmd.locale_current"] = "Aktive Sprache: %s (Client: %s). Ändern: /af locale frFR, /af locale auto.",
  ["cmd.locale_set"] = "Sprache: %s. Gebt /reload ein, um sie anzuwenden.",
  ["cmd.locale_auto"] = "Automatische Sprache (%s). Gebt /reload ein, um sie anzuwenden.",
  ["cmd.locale_bad"] = "Unbekannte Sprache: %s. Mögliche Werte: %s.",

  -- state
  ["state.on"] = "aktiviert",
  ["state.off"] = "deaktiviert",
  ["state.done"] = "Abgeschlossen",
  ["state.log"] = "In Bearbeitung",
  ["state.avail"] = "Verfügbar",
  ["state.locked"] = "Nicht verfügbar",
  ["state.done_caps"] = "Abgeschlossen",
  ["state.log_caps"] = "In Bearbeitung",
  ["state.avail_caps"] = "Verfügbar",
  ["state.locked_caps"] = "Nicht verfügbar",

  -- minimap
  ["minimap.tip.left"] = "Linksklick: öffnen / schließen",
  ["minimap.tip.right"] = "Rechtsklick: Dungeons & Schlachtzüge",
  ["minimap.tip.drag"] = "Ziehen: Button verschieben",
  ["minimap.tip.cmd"] = "/af minimap: ausblenden / einblenden",
  ["minimap.hidden"] = "Minikarten-Button ausgeblendet. Gebt /af minimap ein, um ihn wieder anzuzeigen.",
  ["minimap.shown"] = "Minikarten-Button eingeblendet.",

  -- common
  ["common.close"] = "Schließen",
  ["common.import"] = "Importieren",
  ["common.cancel"] = "Abbrechen",
  ["common.ok"] = "OK",
  ["common.confirm"] = "Bestätigung",
  ["common.lvl"] = "St. %s",
  ["common.lvl_lower"] = "St. %s",
  ["common.level_n"] = "Stufe %s",
  ["common.required_n"] = "benötigt %s",
  ["common.show"] = "Zeigen",

  -- popup
  ["popup.copy_help"] = "Strg+C zum Kopieren, Esc zum Schließen.",
  ["popup.code_unreadable"] = "Code nicht lesbar.",

  -- status
  ["status.new"] = "Neu",
  ["status.changed"] = "Geändert",
  ["status.unchanged"] = "Geprüft, unverändert",

  -- mode
  ["mode.final"] = "Build auf Stufe 60",
  ["mode.path"] = "Build Stufe für Stufe",
  ["mode.final_hint"] = "Build auf Stufe 60: Ihr setzt die endgültigen Punkte, die Reihenfolge beim Leveln wird für Euch berechnet.",
  ["mode.path_hint"] = "Build Stufe für Stufe: jeder Klick ist der nächste Punkt, den Ihr beim Leveln nehmt.",

  -- badge
  ["badge.changed_from_classic"] = "Geändert seit Classic",
  ["badge.new_in_forever"] = "Neu in Forever",

  -- stat
  ["stat.spent_caps"] = "PUNKTE VERTEILT",
  ["stat.left_caps"] = "PUNKTE ÜBRIG",
  ["stat.level_required_caps"] = "BENÖTIGTE STUFE",
  ["stat.available_caps"] = "VERFÜGBAR",
  ["stat.spent_short_caps"] = "VERTEILT",

  -- btn
  ["btn.public_builds"] = "Öffentliche Builds",
  ["btn.public_builds_class"] = "Öffentliche Builds %s",
  ["btn.share"] = "Teilen",
  ["btn.save"] = "Speichern",
  ["btn.reset"] = "Zurücksetzen",
  ["btn.view_order"] = "Punktreihenfolge zeigen",
  ["btn.automatic"] = "Automatisch",
  ["btn.automatic_tip"] = "Wendet bei jedem Stufenaufstieg den nächsten Punkt des Builds im Spiel an",
  ["btn.sync"] = "Abgleichen",
  ["btn.sync_tip"] = "Ersetzt den Build durch die auf diesem Charakter erlernten Talente",
  ["btn.undo"] = "Rückgängig",
  ["btn.undo_tip"] = "Entfernt den zuletzt im Spiel erlernten Punkt",
  ["btn.apply_all"] = "Alle Punkte anwenden",
  ["btn.apply_all_tip"] = "Wendet alle Punkte des Builds im Spiel an",
  ["btn.apply_next"] = "Nächsten Punkt anwenden",
  ["btn.apply_next_tip"] = "Wendet den nächsten Punkt des Builds im Spiel an",
  ["btn.apply"] = "Anwenden",

  -- toggle
  ["toggle.classic_version"] = "Classic-Version",

  -- planner
  ["planner.view_at_level"] = "Meinen Build auf Stufe %s zeigen",

  -- tree
  ["tree.reset_tip"] = "Diesen Baum zurücksetzen",
  ["tree.pts"] = "%d Pkt.",
  ["tree.pts_at"] = "%d/%d Pkt.",
  ["tree.warrior.arms"] = "Waffen",
  ["tree.warrior.fury"] = "Furor",
  ["tree.warrior.protection"] = "Schutz",
  ["tree.paladin.holy"] = "Heilig",
  ["tree.paladin.protection"] = "Schutz",
  ["tree.paladin.retribution"] = "Vergeltung",
  ["tree.hunter.beast_mastery"] = "Tierherrschaft",
  ["tree.hunter.marksmanship"] = "Treffsicherheit",
  ["tree.hunter.survival"] = "Überleben",
  ["tree.rogue.assassination"] = "Meucheln",
  ["tree.rogue.combat"] = "Kampf",
  ["tree.rogue.subtlety"] = "Täuschung",
  ["tree.priest.discipline"] = "Disziplin",
  ["tree.priest.holy"] = "Heilig",
  ["tree.priest.shadow"] = "Schatten",
  ["tree.shaman.elemental"] = "Elementar",
  ["tree.shaman.enhancement"] = "Verstärkung",
  ["tree.shaman.restoration"] = "Wiederherstellung",
  ["tree.mage.arcane"] = "Arkan",
  ["tree.mage.fire"] = "Feuer",
  ["tree.mage.frost"] = "Frost",
  ["tree.warlock.affliction"] = "Gebrechen",
  ["tree.warlock.demonology"] = "Dämonologie",
  ["tree.warlock.destruction"] = "Zerstörung",
  ["tree.druid.balance"] = "Gleichgewicht",
  ["tree.druid.feral"] = "Wilder Kampf",
  ["tree.druid.restoration"] = "Wiederherstellung",

  -- order
  ["order.title"] = "Punktreihenfolge",
  ["order.empty"] = "Keine Punkte gesetzt. Klickt auf ein Talent, um zu beginnen.",

  -- footer
  ["footer.in_game_caps"] = "IM SPIEL",

  -- toast
  ["toast.build_cleared"] = "Build für %s geleert.",
  ["toast.this_class"] = "diese Klasse",
  ["toast.other_class"] = "Ihr seht eine andere Klasse: wechselt zu Eurer Klasse, um im Spiel zu handeln.",
  ["toast.synced.one"] = "Build abgeglichen: %d Punkt im Spiel erlernt.",
  ["toast.synced.other"] = "Build abgeglichen: %d Punkte im Spiel erlernt.",
  ["toast.build_imported"] = "Build importiert: %s.",
  ["toast.point_tomtom"] = "TomTom-Wegpunkt gesetzt: %s.",
  ["toast.point_map"] = "Kartenmarkierung gesetzt: %s.",
  ["toast.point_unknown"] = "Unbekannter Ort für %s.",

  -- confirm
  ["confirm.apply_all"] = "Jetzt alle Punkte des Builds im Spiel anwenden?",

  -- save
  ["save.title"] = "Build speichern",
  ["save.list_caps"] = "AUF DIESEM ACCOUNT GESPEICHERTE BUILDS",
  ["save.empty"] = "Kein gespeicherter Build für diese Klasse.",
  ["save.err.name"] = "Gebt dem Build einen Namen.",
  ["save.err.empty"] = "Der Build ist leer: nichts zu speichern.",
  ["save.ok"] = "Build \"%s\" gespeichert.",
  ["save.btn_delete"] = "Löschen",
  ["save.btn_load"] = "Laden",
  ["save.row_meta"] = "%d Punkte · %s",
  ["save.err.unreadable"] = "Dieser Build ist mit den aktuellen Daten nicht lesbar: %s",
  ["save.loaded"] = "Build \"%s\" geladen.",

  -- tip
  ["tip.rank"] = "Rang %d/%d",
  ["tip.next_rank_caps"] = "NÄCHSTER RANG",
  ["tip.classic_caps"] = "CLASSIC",
  ["tip.at_level"] = "Auf Stufe %d: Rang %d/%d",
  ["tip.next_rank_classic"] = "Nächster Rang (Classic): %s",
  ["tip.requires_tree_points"] = "Benötigt %d Punkte in diesem Baum.",
  ["tip.requires_rank"] = "%s (Rang %d)",
  ["tip.requires_list"] = "Benötigt: %s",
  ["tip.learned_in_game"] = "Im Spiel erlernt: %d/%d",
  ["tip.click_learn"] = "Klick: erlernen · Rechtsklick: verlernen",

  -- preset
  ["preset.leveling"] = "Abenteuer",
  ["preset.metiers"] = "Berufe",
  ["preset.qdv60"] = "Einfallsreichtum",
  ["preset.applied"] = "Vorlage \"%s\" angewendet (%d Punkte).",
  ["preset.err"] = "Vorlage kann nicht angewendet werden.",

  -- origin
  ["origin.classic"] = "Classic",

  -- type
  ["type.dungeon_new"] = "Neuer Forever-Dungeon",
  ["type.dungeon_classic"] = "Classic-Dungeon",
  ["type.raid_new"] = "Neuer Forever-Schlachtzug",
  ["type.raid_classic"] = "Classic-Schlachtzug",
  ["type.instance_new"] = "Neue Forever-Instanz",
  ["type.instance_classic"] = "Classic-Instanz",

  -- rep
  ["rep.orgrimmar"] = "Orgrimmar",
  ["rep.thunder_bluff"] = "Donnerfels",
  ["rep.undercity"] = "Unterstadt",
  ["rep.ironforge"] = "Eisenschmiede",
  ["rep.stormwind"] = "Sturmwind",
  ["rep.darnassus"] = "Darnassus",
  ["rep.gnomeregan_exiles"] = "Gnomeregangnome",
  ["rep.ratchet"] = "Ratschet",
  ["rep.gadgetzan"] = "Gadgetzan",
  ["rep.argent_dawn"] = "Argentumdämmerung",
  ["rep.cenarion_circle"] = "Zirkel des Cenarius",

  -- chain
  ["chain.part"] = "Teil einer Questreihe (Schritte zu erfassen)",
  ["chain.next"] = "Fortsetzung einer Questreihe (Schritte zu erfassen)",
  ["chain.teleporter"] = "Questreihe zum Teleporter von Gnomeregan",
  ["chain.title_caps"] = "QUESTREIHE: VORHERIGE SCHRITTE",
  ["chain.start_outside"] = "Die Questreihe beginnt außerhalb der Instanz: %s.",
  ["chain.at_zone"] = "in %s",
  ["chain.from_npc"] = "bei %s",
  ["chain.start_item"] = "Die Questreihe beginnt mit einem im Spiel gefundenen Gegenstand.",
  ["chain.to_verify"] = "zu prüfen",

  -- filter
  ["filter.all"] = "Alle",
  ["filter.new"] = "Neu",
  ["filter.raids"] = "Schlachtzüge",

  -- section
  ["section.levels"] = "Stufen %d bis %d",
  ["section.raids"] = "Schlachtzüge",

  -- unit
  ["unit.dungeon.one"] = "%d Dungeon",
  ["unit.dungeon.other"] = "%d Dungeons",
  ["unit.raid.one"] = "%d Schlachtzug",
  ["unit.raid.other"] = "%d Schlachtzüge",
  ["unit.quest.one"] = "%d Quest",
  ["unit.quest.other"] = "%d Quests",
  ["unit.boss.one"] = "%d Boss",
  ["unit.boss.other"] = "%d Bosse",

  -- fmt
  ["fmt.thousands_sep"] = ".",
  ["fmt.date"] = "%1$s.%2$s.%3$s",

  -- money
  ["money.g"] = "g",
  ["money.s"] = "s",
  ["money.c"] = "k",

  -- card
  ["card.players"] = "%s Spieler",
  ["card.visual_soon_caps"] = "BILD FOLGT",
  ["card.faction"] = "Fraktion: %s",
  ["card.level_recommended"] = "Empfohlene St. %s",
  ["card.level_max"] = "Stufe %d",
  ["card.quests_todo"] = "Quests: folgt",
  ["card.quests_side"] = "%s für %s",

  -- dungeons
  ["dungeons.footer"] = "Daten vom %s - %d Instanzen",
  ["dungeons.footer_nodate"] = "Daten - %d Instanzen",
  ["dungeons.title"] = "Dungeons & Schlachtzüge",
  ["dungeons.sub"] = "Die %d Dungeons von World of Warcraft Forever, Classic und neu, von Stufe 13 bis 60, dazu die Schlachtzüge.",
  ["search.placeholder"] = "Dungeon, Boss oder Beute…",
  ["search.none"] = "Keine Ergebnisse",

  -- detail
  ["detail.back"] = "Alle Dungeons",
  ["detail.show_entrance"] = "Eingang zeigen",
  ["detail.tab_quests"] = "Quests",
  ["detail.tab_boss"] = "Bosse",
  ["detail.tab_quests_count"] = "Quests %d",
  ["detail.tab_boss_count"] = "Bosse %d",

  -- point
  ["point.this"] = "dieser Ort",
  ["point.entrance"] = "Eingang: %s",

  -- fact
  ["fact.zone"] = "Gebiet",
  ["fact.entry"] = "Eingang",
  ["fact.faction"] = "Fraktion",
  ["fact.level_required"] = "Benötigte Stufe",
  ["fact.group_finder"] = "Gruppensuche",
  ["fact.players"] = "Spieler",
  ["fact.access_todo"] = "Zugang: folgt",

  -- boss
  ["boss.rare"] = "selten",
  ["boss.quest"] = "Quest",
  ["boss.with"] = "mit %s",
  ["boss.none"] = "Kein bekannter Boss für diese Instanz.",
  ["boss.select"] = "Wählt einen Boss.",
  ["boss.met"] = "im Spiel angetroffen",
  ["boss.no_pin"] = "keine Kartenposition",
  ["boss.pin_with"] = "%s (mit %s)",
  ["boss.caps"] = "BOSS",

  -- item
  ["item.loading"] = "Gegenstand %d (lädt)",

  -- loot
  ["loot.caps"] = "BEUTE",
  ["loot.none"] = "Beute für diesen Boss nicht erfasst (Beta).",
  ["loot.verify_classic_caps"] = "ZU PRÜFEN: CLASSIC-BEUTE",
  ["loot.verify_external_caps"] = "ZU PRÜFEN: EXTERNE QUELLE",
  ["loot.seen"] = "%s im Spiel bei diesem Boss (%s).",
  ["loot.items_seen.one"] = "%d Gegenstand gesehen",
  ["loot.items_seen.other"] = "%d Gegenstände gesehen",
  ["loot.kills_noted.one"] = "%d Sieg erfasst",
  ["loot.kills_noted.other"] = "%d Siege erfasst",
  ["loot.disclaimer"] = "Die Beute kann Fehler enthalten, da die Blizzard-API unter World of Warcraft Forever viele Informationen verbirgt, zumindest während der Beta. Sie wird nach und nach aktualisiert. Betrachtet diese Liste nicht als endgültig.",

  -- quest
  ["quest.meta_chain"] = "Reihe",
  ["quest.meta_in_log"] = "im Log",
  ["quest.meta_unconfirmed"] = "unbestätigt",
  ["quest.none_instance"] = "Keine bekannte Quest für diese Instanz.",
  ["quest.none_faction"] = "Keine Quest für diese Fraktion.",
  ["quest.select"] = "Wählt eine Quest.",
  ["quest.fallback_name"] = "Quest %d",
  ["quest.state_for"] = "%s für %s",
  ["quest.tag_level"] = "Stufe %s",
  ["quest.tag_chain"] = "Questreihe",
  ["quest.tag_unconfirmed"] = "Unbestätigt (Beta)",
  ["quest.locked_hint"] = "Nicht verfügbar: ein vorheriger Schritt ist nicht abgeschlossen (siehe Questreihe unten).",
  ["quest.objectives_caps"] = "QUESTZIELE",
  ["quest.giver_caps"] = "QUESTGEBER",
  ["quest.start_caps"] = "START",
  ["quest.turnin_caps"] = "ABGABE",
  ["quest.rewards_caps"] = "BELOHNUNGEN",
  ["quest.rewards_choice_caps"] = "BELOHNUNGEN: EINEN GEGENSTAND WÄHLEN",
  ["quest.xp"] = "%s EP",
  ["quest.rewards_external"] = "Das Spiel liefert diese Belohnungen noch nicht: sie stammen aus einer externen Quelle. Im Spiel prüfen.",
  ["quest.rewards_none"] = "Belohnungen nicht erfasst.",

  -- place
  ["place.unknown"] = "Unbekannt",

  -- map
  ["map.floor_n"] = "Etage %d",
  ["map.level_n"] = "Ebene %d",
  ["map.levels_caps"] = "EBENEN",

  -- pin
  ["pin.no_position"] = "Noch keine Kartenposition",
  ["pin.click_loot"] = "Klick: Beute anzeigen",
  ["pin.rare_prefix"] = "Selten. %s",
  ["pin.quest_boss_prefix"] = "Questboss. %s",
  ["pin.variable"] = "Wechselnde Position: einer dieser %d Orte. %s",
  ["pin.quest_item"] = "Questgegenstand",
  ["pin.rare_off_list"] = "Selten, nicht in der Bossliste",
  ["pin.to_verify"] = "Zu prüfen: fehlt in der Bossliste",

  -- audit
  ["audit.done"] = "Erfassung abgeschlossen: %d/%d Quests dem Server bekannt (%d unbekannt), %d/%d Gegenstände bekannt (%d unbekannt), %d Instanzen im Dungeonkompendium. Gebt /reload ein, um sie zu speichern.",
  ["audit.running"] = "Erfassung läuft bereits.",
  ["audit.started"] = "Erfassung läuft: %d Quests und %d Gegenstände werden vom Server angefragt (bis zu 3 Min.).",
  ["audit.forbidden"] = "Aktion vom Client abgelehnt: %s (zur Korrektur notiert).",
  ["audit.loot_summary"] = "In Dungeons erfasst: %d Bosse angetroffen, %d Gegenstände von %d NPCs. Wird bei der nächsten Erfassung gezählt.",

  -- instfaction
  ["instfaction.both"] = "Horde / Allianz",

  -- availability
  ["availability.not_open"] = "Noch nicht geöffnet",
  ["availability.opens_dec9"] = "Öffnet am 9. Dez.",

  -- instance
  ["instance.group_change"] = "Gruppengröße von 10 Spielern (Classic Era) auf 5 geändert.",
})
