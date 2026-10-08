-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- Deutsch: Classic talent text (block CLASSIC of the talent tooltip), one string per rank, keyed by talent id,
-- and the quest objectives Wowhead has no German text for (objective, end of file).
-- Translated by hand from Data/Talents.lua (talent.classic), same numbers as the data. Read by Names.lua N:ClassicRank
-- when the addon language is deDE. A talent missing here falls back to enUS, then to the French data.
local ADDON_NAME, AF = ...

AF.Content = AF.Content or {}
AF.Content.deDE = AF.Content.deDE or {}
AF.Content.deDE.classic = {
  [105958] = {
    "Verringert die Wutkosten Eurer Fähigkeit Heldenhafter Stoß um 1.",
    "Verringert die Wutkosten Eurer Fähigkeit Heldenhafter Stoß um 2.",
    "Verringert die Wutkosten Eurer Fähigkeit Heldenhafter Stoß um 3.",
  },
  [105956] = {
    "Erhöht den Blutungsschaden Eurer Fähigkeit Verwunden um 15%.",
    "Erhöht den Blutungsschaden Eurer Fähigkeit Verwunden um 25%.",
    "Erhöht den Blutungsschaden Eurer Fähigkeit Verwunden um 35%.",
  },
  [105955] = {
    "Erhöht die durch Eure Fähigkeit Sturmangriff erzeugte Wut um 3.",
    "Erhöht die durch Eure Fähigkeit Sturmangriff erzeugte Wut um 6.",
  },
  [105954] = {
    "Ihr behaltet beim Haltungswechsel bis zu 5 Wutpunkte.",
    "Ihr behaltet beim Haltungswechsel bis zu 10 Wutpunkte.",
    "Ihr behaltet beim Haltungswechsel bis zu 15 Wutpunkte.",
    "Ihr behaltet beim Haltungswechsel bis zu 20 Wutpunkte.",
    "Ihr behaltet beim Haltungswechsel bis zu 25 Wutpunkte.",
  },
  [105951] = {
    "Erhöht die Zeit, die Eure Wut außerhalb des Kampfes zum Abklingen braucht, um 30%.",
  },
  [105950] = {
    "Eure kritischen Treffer lassen den Gegner bluten und fügen ihm im Verlauf von 12 Sek. 20% des durchschnittlichen Schadens Eurer Nahkampfwaffe zu.",
    "Eure kritischen Treffer lassen den Gegner bluten und fügen ihm im Verlauf von 12 Sek. 40% des durchschnittlichen Schadens Eurer Nahkampfwaffe zu.",
    "Eure kritischen Treffer lassen den Gegner bluten und fügen ihm im Verlauf von 12 Sek. 60% des durchschnittlichen Schadens Eurer Nahkampfwaffe zu.",
  },
  [105948] = {
    "Erhöht den mit Zweihand-Nahkampfwaffen verursachten Schaden um 1%.",
    "Erhöht den mit Zweihand-Nahkampfwaffen verursachten Schaden um 2%.",
    "Erhöht den mit Zweihand-Nahkampfwaffen verursachten Schaden um 3%.",
    "Erhöht den mit Zweihand-Nahkampfwaffen verursachten Schaden um 4%.",
    "Erhöht den mit Zweihand-Nahkampfwaffen verursachten Schaden um 5%.",
  },
  [105947] = {
    "Erhöht den kritischen Schadensbonus Eurer Fähigkeiten in Kampf-, Verteidigungs- und Berserkerhaltung um 10%.",
    "Erhöht den kritischen Schadensbonus Eurer Fähigkeiten in Kampf-, Verteidigungs- und Berserkerhaltung um 20%.",
  },
  [110858] = {
    "Verringert die Zauberzeit Eurer Fähigkeit Zuschlagen um 0.1 Sek.",
    "Verringert die Zauberzeit Eurer Fähigkeit Zuschlagen um 0.2 Sek.",
    "Verringert die Zauberzeit Eurer Fähigkeit Zuschlagen um 0.3 Sek.",
    "Verringert die Zauberzeit Eurer Fähigkeit Zuschlagen um 0.4 Sek.",
    "Verringert die Zauberzeit Eurer Fähigkeit Zuschlagen um 0.5 Sek.",
  },
  [105938] = {
    "Erhöht Wirkungsbereich und Dauer Eurer Fähigkeiten Schlachtruf und Demoralisierender Ruf um 10%.",
    "Erhöht Wirkungsbereich und Dauer Eurer Fähigkeiten Schlachtruf und Demoralisierender Ruf um 20%.",
    "Erhöht Wirkungsbereich und Dauer Eurer Fähigkeiten Schlachtruf und Demoralisierender Ruf um 30%.",
    "Erhöht Wirkungsbereich und Dauer Eurer Fähigkeiten Schlachtruf und Demoralisierender Ruf um 40%.",
    "Erhöht Wirkungsbereich und Dauer Eurer Fähigkeiten Schlachtruf und Demoralisierender Ruf um 50%.",
  },
  [105939] = {
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 1%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 2%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 3%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 4%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 5%.",
  },
  [110857] = {
    "Erhöht Eure Chance, Betäubungs- und Bezauberungseffekten zu widerstehen, um zusätzlich 3%.",
    "Erhöht Eure Chance, Betäubungs- und Bezauberungseffekten zu widerstehen, um zusätzlich 6%.",
    "Erhöht Eure Chance, Betäubungs- und Bezauberungseffekten zu widerstehen, um zusätzlich 9%.",
    "Erhöht Eure Chance, Betäubungs- und Bezauberungseffekten zu widerstehen, um zusätzlich 12%.",
    "Erhöht Eure Chance, Betäubungs- und Bezauberungseffekten zu widerstehen, um zusätzlich 15%.",
  },
  [105937] = {
    "Gewährt Euch eine Chance von 8%, einen zusätzlichen Wutpunkt zu erzeugen, wenn Ihr mit einer Waffe Nahkampfschaden verursacht.",
    "Gewährt Euch eine Chance von 16%, einen zusätzlichen Wutpunkt zu erzeugen, wenn Ihr mit einer Waffe Nahkampfschaden verursacht.",
    "Gewährt Euch eine Chance von 24%, einen zusätzlichen Wutpunkt zu erzeugen, wenn Ihr mit einer Waffe Nahkampfschaden verursacht.",
    "Gewährt Euch eine Chance von 32%, einen zusätzlichen Wutpunkt zu erzeugen, wenn Ihr mit einer Waffe Nahkampfschaden verursacht.",
    "Gewährt Euch eine Chance von 40%, einen zusätzlichen Wutpunkt zu erzeugen, wenn Ihr mit einer Waffe Nahkampfschaden verursacht.",
  },
  [105936] = {
    "Erhöht den Bonusschaden Eurer Fähigkeit Spalten um 40%.",
    "Erhöht den Bonusschaden Eurer Fähigkeit Spalten um 80%.",
    "Erhöht den Bonusschaden Eurer Fähigkeit Spalten um 120%.",
  },
  [105935] = {
    "Lässt alle Gegner in der Nähe des Kriegers taumeln und verringert ihr Bewegungstempo 6 Sek. lang um 50%.",
  },
  [105934] = {
    "Regeneriert im Verlauf von 6 Sek. 1% Eurer gesamten Gesundheit, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Regeneriert im Verlauf von 6 Sek. 2% Eurer gesamten Gesundheit, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Regeneriert im Verlauf von 6 Sek. 3% Eurer gesamten Gesundheit, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
  },
  [105933] = {
    "Erhöht den Schaden Eurer Schildhandwaffe um 5%.",
    "Erhöht den Schaden Eurer Schildhandwaffe um 10%.",
    "Erhöht den Schaden Eurer Schildhandwaffe um 15%.",
    "Erhöht den Schaden Eurer Schildhandwaffe um 20%.",
    "Erhöht den Schaden Eurer Schildhandwaffe um 25%.",
  },
  [105931] = {
    "Gewährt Euch 12 Sek. lang einen Bonus von 5% auf Nahkampfschaden, für bis zu 12 Treffer, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Gewährt Euch 12 Sek. lang einen Bonus von 10% auf Nahkampfschaden, für bis zu 12 Treffer, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Gewährt Euch 12 Sek. lang einen Bonus von 15% auf Nahkampfschaden, für bis zu 12 Treffer, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Gewährt Euch 12 Sek. lang einen Bonus von 20% auf Nahkampfschaden, für bis zu 12 Treffer, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Gewährt Euch 12 Sek. lang einen Bonus von 25% auf Nahkampfschaden, für bis zu 12 Treffer, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
  },
  [105932] = {
    "Verringert die Wutkosten Eurer Fähigkeit Hinrichten um 2.",
    "Verringert die Wutkosten Eurer Fähigkeit Hinrichten um 5.",
  },
  [105927] = {
    "Erhöht bei Aktivierung Euren körperlichen Schaden um 20% und macht Euch immun gegen Furchteffekte, verringert aber Eure Rüstung und alle Widerstände um 20%. Hält 30 Sek. lang an.",
  },
  [105978] = {
    "Eure Fähigkeit Berserkerwut erzeugt bei Benutzung 5 Wut.",
    "Eure Fähigkeit Berserkerwut erzeugt bei Benutzung 10 Wut.",
  },
  [105928] = {
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 10%, nachdem Ihr einen kritischen Nahkampftreffer erzielt habt.",
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 15%, nachdem Ihr einen kritischen Nahkampftreffer erzielt habt.",
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 20%, nachdem Ihr einen kritischen Nahkampftreffer erzielt habt.",
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 25%, nachdem Ihr einen kritischen Nahkampftreffer erzielt habt.",
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 30%, nachdem Ihr einen kritischen Nahkampftreffer erzielt habt.",
  },
  [105930] = {
    "Greift das Ziel sofort an und verursacht Schaden in Höhe von 45% Eurer Angriffskraft. Außerdem stellen die nächsten 5 erfolgreichen Nahkampfangriffe 10 Gesundheit wieder her. Dieser Effekt hält 8 Sek. lang an.",
  },
  [105976] = {
    "Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um 1% und gewährt eine Chance von 20%, beim Blocken 1 Wut zu erzeugen.",
    "Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um 2% und gewährt eine Chance von 40%, beim Blocken 1 Wut zu erzeugen.",
    "Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um 3% und gewährt eine Chance von 60%, beim Blocken 1 Wut zu erzeugen.",
    "Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um 4% und gewährt eine Chance von 80%, beim Blocken 1 Wut zu erzeugen.",
    "Erhöht Eure Chance, Angriffe mit einem Schild zu blocken, um 5% und gewährt eine Chance von 100%, beim Blocken 1 Wut zu erzeugen.",
  },
  [105975] = {
    "Erhöht Eure Verteidigungsfertigkeit um 2.",
    "Erhöht Eure Verteidigungsfertigkeit um 4.",
    "Erhöht Eure Verteidigungsfertigkeit um 6.",
    "Erhöht Eure Verteidigungsfertigkeit um 8.",
    "Erhöht Eure Verteidigungsfertigkeit um 10.",
  },
  [105974] = {
    "Erhöht die sofort durch Eure Fähigkeit Blutrausch erzeugte Wut um 2.",
    "Erhöht die sofort durch Eure Fähigkeit Blutrausch erzeugte Wut um 5.",
  },
  [105973] = {
    "Erhöht den Rüstungswert von Gegenständen um 2%.",
    "Erhöht den Rüstungswert von Gegenständen um 4%.",
    "Erhöht den Rüstungswert von Gegenständen um 6%.",
    "Erhöht den Rüstungswert von Gegenständen um 8%.",
    "Erhöht den Rüstungswert von Gegenständen um 10%.",
  },
  [105972] = {
    "Verringert die Wutkosten Eurer Fähigkeit Donnerknall um 1.",
    "Verringert die Wutkosten Eurer Fähigkeit Donnerknall um 2.",
    "Verringert die Wutkosten Eurer Fähigkeit Donnerknall um 4.",
  },
  [105970] = {
    "Gewährt Euch bei Aktivierung 20 Sek. lang vorübergehend 30% Eurer maximalen Gesundheit. Nach Ablauf des Effekts geht diese Gesundheit verloren.",
  },
  [105969] = {
    "Gewährt Eurer Fähigkeit Rache eine Chance von 15%, das Ziel 3 Sek. lang zu betäuben.",
    "Gewährt Eurer Fähigkeit Rache eine Chance von 30%, das Ziel 3 Sek. lang zu betäuben.",
    "Gewährt Eurer Fähigkeit Rache eine Chance von 45%, das Ziel 3 Sek. lang zu betäuben.",
  },
  [110856] = {
    "Erhöht die durch Eure Angriffe in Verteidigungshaltung erzeugte Bedrohung um 3%.",
    "Erhöht die durch Eure Angriffe in Verteidigungshaltung erzeugte Bedrohung um 6%.",
    "Erhöht die durch Eure Angriffe in Verteidigungshaltung erzeugte Bedrohung um 9%.",
    "Erhöht die durch Eure Angriffe in Verteidigungshaltung erzeugte Bedrohung um 12%.",
    "Erhöht die durch Eure Angriffe in Verteidigungshaltung erzeugte Bedrohung um 15%.",
  },
  [105968] = {
    "Verringert die Wutkosten Eurer Fähigkeit Rüstung zerreißen um 1.",
    "Verringert die Wutkosten Eurer Fähigkeit Rüstung zerreißen um 2.",
    "Verringert die Wutkosten Eurer Fähigkeit Rüstung zerreißen um 3.",
  },
  [105967] = {
    "Erhöht die Dauer Eurer Fähigkeit Entwaffnen um 1 Sek.",
    "Erhöht die Dauer Eurer Fähigkeit Entwaffnen um 2 Sek.",
    "Erhöht die Dauer Eurer Fähigkeit Entwaffnen um 3 Sek.",
  },
  [105964] = {
    "Erhöht die Dauer Eurer Fähigkeit Schildwall um 3 Sek.",
    "Erhöht die Dauer Eurer Fähigkeit Schildwall um 5 Sek.",
  },
  [105965] = {
    "Betäubt den Gegner 5 Sek. lang.",
  },
  [105963] = {
    "Gewährt Eurer Fähigkeit Schildhieb eine Chance von 50%, das Ziel 3 Sek. lang zum Schweigen zu bringen.",
    "Gewährt Eurer Fähigkeit Schildhieb eine Chance von 100%, das Ziel 3 Sek. lang zum Schweigen zu bringen.",
  },
  [105962] = {
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 2%.",
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 4%.",
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 6%.",
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 8%.",
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 10%.",
  },
  [105959] = {
    "Schlägt das Ziel mit Eurem Schild und verursacht 225 bis 235 Schaden, abhängig von Eurem Blockwert, mit einer Chance von 50%, 1 Magieeffekt auf dem Ziel zu bannen. Erzeugt außerdem ein hohes Maß an Bedrohung.",
  },
  [105333] = {
    "Erhöht die Heilung Eurer Zauber Heiliges Licht und Lichtblitz um 4%.",
    "Erhöht die Heilung Eurer Zauber Heiliges Licht und Lichtblitz um 8%.",
    "Erhöht die Heilung Eurer Zauber Heiliges Licht und Lichtblitz um 12%.",
  },
  [105335] = {
    "Gewährt Euren Zaubern Lichtblitz und Heiliges Licht eine Chance von 14%, bei erlittenem Schaden keine Zauberzeit zu verlieren.",
    "Gewährt Euren Zaubern Lichtblitz und Heiliges Licht eine Chance von 28%, bei erlittenem Schaden keine Zauberzeit zu verlieren.",
    "Gewährt Euren Zaubern Lichtblitz und Heiliges Licht eine Chance von 42%, bei erlittenem Schaden keine Zauberzeit zu verlieren.",
    "Gewährt Euren Zaubern Lichtblitz und Heiliges Licht eine Chance von 56%, bei erlittenem Schaden keine Zauberzeit zu verlieren.",
    "Gewährt Euren Zaubern Lichtblitz und Heiliges Licht eine Chance von 70%, bei erlittenem Schaden keine Zauberzeit zu verlieren.",
  },
  [105334] = {
    "Erhöht den Schaden Eures Siegels der Rechtschaffenheit und Eures Richturteils der Rechtschaffenheit um 3%.",
    "Erhöht den Schaden Eures Siegels der Rechtschaffenheit und Eures Richturteils der Rechtschaffenheit um 6%.",
    "Erhöht den Schaden Eures Siegels der Rechtschaffenheit und Eures Richturteils der Rechtschaffenheit um 9%.",
    "Erhöht den Schaden Eures Siegels der Rechtschaffenheit und Eures Richturteils der Rechtschaffenheit um 12%.",
    "Erhöht den Schaden Eures Siegels der Rechtschaffenheit und Eures Richturteils der Rechtschaffenheit um 15%.",
  },
  [105331] = {
    "Erhöht Eure Chance, Furcht- und Desorientierungseffekten zu widerstehen, um zusätzlich 5%.",
    "Erhöht Eure Chance, Furcht- und Desorientierungseffekten zu widerstehen, um zusätzlich 10%.",
  },
  [105329] = {
    "Nach einem kritischen Effekt Eurer Heilzauber Lichtblitz, Heiliges Licht oder Heiliger Schock habt Ihr eine Chance von 20%, Mana in Höhe der Grundkosten des Zaubers zu erhalten.",
    "Nach einem kritischen Effekt Eurer Heilzauber Lichtblitz, Heiliges Licht oder Heiliger Schock habt Ihr eine Chance von 40%, Mana in Höhe der Grundkosten des Zaubers zu erhalten.",
    "Nach einem kritischen Effekt Eurer Heilzauber Lichtblitz, Heiliges Licht oder Heiliger Schock habt Ihr eine Chance von 60%, Mana in Höhe der Grundkosten des Zaubers zu erhalten.",
    "Nach einem kritischen Effekt Eurer Heilzauber Lichtblitz, Heiliges Licht oder Heiliger Schock habt Ihr eine Chance von 80%, Mana in Höhe der Grundkosten des Zaubers zu erhalten.",
    "Nach einem kritischen Effekt Eurer Heilzauber Lichtblitz, Heiliges Licht oder Heiliger Schock habt Ihr eine Chance von 100%, Mana in Höhe der Grundkosten des Zaubers zu erhalten.",
  },
  [105323] = {
    "Trifft das Ziel mit heiliger Energie und verursacht 204 bis 220 Heiligschaden an einem Gegner oder heilt einen Verbündeten um 204 bis 220.",
  },
  [105321] = {
    "Erhöht die kritische Trefferchance Eurer Heiligzauber um 1%.",
    "Erhöht die kritische Trefferchance Eurer Heiligzauber um 2%.",
    "Erhöht die kritische Trefferchance Eurer Heiligzauber um 3%.",
    "Erhöht die kritische Trefferchance Eurer Heiligzauber um 4%.",
    "Erhöht die kritische Trefferchance Eurer Heiligzauber um 5%.",
  },
  [105626] = {
    "Erhöht Eure Chance, Angriffe mit Eurem Schild zu blocken, um 6%, nachdem Ihr Opfer eines kritischen Treffers wurdet. Hält 10 Sek. oder 5 Blocks lang an.",
    "Erhöht Eure Chance, Angriffe mit Eurem Schild zu blocken, um 12%, nachdem Ihr Opfer eines kritischen Treffers wurdet. Hält 10 Sek. oder 5 Blocks lang an.",
    "Erhöht Eure Chance, Angriffe mit Eurem Schild zu blocken, um 18%, nachdem Ihr Opfer eines kritischen Treffers wurdet. Hält 10 Sek. oder 5 Blocks lang an.",
    "Erhöht Eure Chance, Angriffe mit Eurem Schild zu blocken, um 24%, nachdem Ihr Opfer eines kritischen Treffers wurdet. Hält 10 Sek. oder 5 Blocks lang an.",
    "Erhöht Eure Chance, Angriffe mit Eurem Schild zu blocken, um 30%, nachdem Ihr Opfer eines kritischen Treffers wurdet. Hält 10 Sek. oder 5 Blocks lang an.",
  },
  [105638] = {
    "Erhöht Eure Trefferchance mit Nahkampfwaffen um 1%.",
    "Erhöht Eure Trefferchance mit Nahkampfwaffen um 2%.",
    "Erhöht Eure Trefferchance mit Nahkampfwaffen um 3%.",
  },
  [105637] = {
    "Verringert die Abklingzeit Eures Segens des Schutzes um 60 Sek. und erhöht die Dauer Eures Segens der Freiheit um 3 Sek.",
    "Verringert die Abklingzeit Eures Segens des Schutzes um 120 Sek. und erhöht die Dauer Eures Segens der Freiheit um 6 Sek.",
  },
  [105636] = {
    "Erhöht Eure Verteidigungsfertigkeit um 2.",
    "Erhöht Eure Verteidigungsfertigkeit um 4.",
    "Erhöht Eure Verteidigungsfertigkeit um 6.",
    "Erhöht Eure Verteidigungsfertigkeit um 8.",
    "Erhöht Eure Verteidigungsfertigkeit um 10.",
  },
  [105634] = {
    "Erhöht die durch Euren Zauber Zorn der Gerechtigkeit erzeugte Bedrohung um 16%.",
    "Erhöht die durch Euren Zauber Zorn der Gerechtigkeit erzeugte Bedrohung um 33%.",
    "Erhöht die durch Euren Zauber Zorn der Gerechtigkeit erzeugte Bedrohung um 50%.",
  },
  [110874] = {
    "Erhöht den von Eurem Schild absorbierten Schaden um 10%.",
    "Erhöht den von Eurem Schild absorbierten Schaden um 20%.",
    "Erhöht den von Eurem Schild absorbierten Schaden um 30%.",
  },
  [105629] = {
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 2%.",
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 4%.",
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 6%.",
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 8%.",
    "Erhöht den mit Einhand-Nahkampfwaffen verursachten Schaden um 10%.",
  },
  [105627] = {
    "Gewährt Euch eine Chance von 20% auf einen zusätzlichen Angriff, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Gewährt Euch eine Chance von 40% auf einen zusätzlichen Angriff, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Gewährt Euch eine Chance von 60% auf einen zusätzlichen Angriff, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Gewährt Euch eine Chance von 80% auf einen zusätzlichen Angriff, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
    "Gewährt Euch eine Chance von 100% auf einen zusätzlichen Angriff, nachdem Ihr Opfer eines kritischen Treffers wurdet.",
  },
  [105628] = {
    "Erhöht Eure Blockchance 10 Sek. lang um 30% und verursacht, solange aktiv, für jeden geblockten Angriff 65 Heiligschaden. Der durch Heiliger Schild verursachte Schaden erzeugt 20% zusätzliche Bedrohung. Jeder Block verbraucht eine Aufladung. 4 Aufladungen.",
  },
  [105706] = {
    "Verringert die Manakosten Eurer Richturteil- und Siegelzauber um 3%.",
    "Verringert die Manakosten Eurer Richturteil- und Siegelzauber um 6%.",
    "Verringert die Manakosten Eurer Richturteil- und Siegelzauber um 9%.",
    "Verringert die Manakosten Eurer Richturteil- und Siegelzauber um 12%.",
    "Verringert die Manakosten Eurer Richturteil- und Siegelzauber um 15%.",
  },
  [105705] = {
    "Verringert die Abklingzeit Eures Zaubers Richturteil um 1 Sek.",
    "Verringert die Abklingzeit Eures Zaubers Richturteil um 2 Sek.",
  },
  [105703] = {
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 1%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 2%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 3%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 4%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Nahkampfwaffen um 5%.",
  },
  [105702] = {
    "Gewährt den schadensverursachenden Nahkampfangriffen des Paladins eine Chance, Stärke und Beweglichkeit des Ziels 10 Sek. lang um 5% zu verringern.",
    "Gewährt den schadensverursachenden Nahkampfangriffen des Paladins eine Chance, Stärke und Beweglichkeit des Ziels 10 Sek. lang um 10% zu verringern.",
    "Gewährt den schadensverursachenden Nahkampfangriffen des Paladins eine Chance, Stärke und Beweglichkeit des Ziels 10 Sek. lang um 15% zu verringern.",
  },
  [105696] = {
    "Gewährt dem Paladin eine Chance, zusätzlichen Heiligschaden in Höhe von 70% des normalen Waffenschadens zu verursachen. Auf dem Paladin kann jeweils nur ein Siegel aktiv sein. Hält 30 Sek. lang an.\n\nDas Entfesseln der Energie dieses Siegels richtet einen Gegner und verursacht sofort 73 Heiligschaden, oder 138 bis 146, wenn das Ziel betäubt oder handlungsunfähig ist.",
  },
  [105699] = {
    "Erhöht das Bewegungstempo und das Reittempo um 4%. Nicht stapelbar mit anderen Effekten, die das Bewegungstempo erhöhen.",
    "Erhöht das Bewegungstempo und das Reittempo um 8%. Nicht stapelbar mit anderen Effekten, die das Bewegungstempo erhöhen.",
  },
  [105698] = {
    "Alle kritischen Zaubertreffer, die Ihr erleidet, fügen dem Zaubernden ebenfalls 15% des erlittenen Schadens zu. Der durch Auge um Auge verursachte Schaden kann 50% der gesamten Gesundheit des Paladins nicht überschreiten.",
    "Alle kritischen Zaubertreffer, die Ihr erleidet, fügen dem Zaubernden ebenfalls 30% des erlittenen Schadens zu. Der durch Auge um Auge verursachte Schaden kann 50% der gesamten Gesundheit des Paladins nicht überschreiten.",
  },
  [105697] = {
    "Erhöht den mit Zweihand-Nahkampfwaffen verursachten Schaden um 2%.",
    "Erhöht den mit Zweihand-Nahkampfwaffen verursachten Schaden um 4%.",
    "Erhöht den mit Zweihand-Nahkampfwaffen verursachten Schaden um 6%.",
  },
  [105693] = {
    "Gewährt Euch 8 Sek. lang einen Bonus von 3% auf verursachten körperlichen und Heiligschaden, nachdem Ihr mit einem Waffenschlag, Zauber oder einer Fähigkeit einen kritischen Treffer erzielt habt.",
    "Gewährt Euch 8 Sek. lang einen Bonus von 6% auf verursachten körperlichen und Heiligschaden, nachdem Ihr mit einem Waffenschlag, Zauber oder einer Fähigkeit einen kritischen Treffer erzielt habt.",
    "Gewährt Euch 8 Sek. lang einen Bonus von 9% auf verursachten körperlichen und Heiligschaden, nachdem Ihr mit einem Waffenschlag, Zauber oder einer Fähigkeit einen kritischen Treffer erzielt habt.",
    "Gewährt Euch 8 Sek. lang einen Bonus von 12% auf verursachten körperlichen und Heiligschaden, nachdem Ihr mit einem Waffenschlag, Zauber oder einer Fähigkeit einen kritischen Treffer erzielt habt.",
    "Gewährt Euch 8 Sek. lang einen Bonus von 15% auf verursachten körperlichen und Heiligschaden, nachdem Ihr mit einem Waffenschlag, Zauber oder einer Fähigkeit einen kritischen Treffer erzielt habt.",
  },
  [104960] = {
    "Solange Aspekt des Falken aktiv ist, haben alle normalen Distanzangriffe eine Chance von 1%, das Distanzangriffstempo 12 Sek. lang um 30% zu erhöhen.",
    "Solange Aspekt des Falken aktiv ist, haben alle normalen Distanzangriffe eine Chance von 2%, das Distanzangriffstempo 12 Sek. lang um 30% zu erhöhen.",
    "Solange Aspekt des Falken aktiv ist, haben alle normalen Distanzangriffe eine Chance von 3%, das Distanzangriffstempo 12 Sek. lang um 30% zu erhöhen.",
    "Solange Aspekt des Falken aktiv ist, haben alle normalen Distanzangriffe eine Chance von 4%, das Distanzangriffstempo 12 Sek. lang um 30% zu erhöhen.",
    "Solange Aspekt des Falken aktiv ist, haben alle normalen Distanzangriffe eine Chance von 5%, das Distanzangriffstempo 12 Sek. lang um 30% zu erhöhen.",
  },
  [104976] = {
    "Erhöht die Gesundheit Eurer Tiere um 3%.",
    "Erhöht die Gesundheit Eurer Tiere um 6%.",
    "Erhöht die Gesundheit Eurer Tiere um 9%.",
    "Erhöht die Gesundheit Eurer Tiere um 12%.",
    "Erhöht die Gesundheit Eurer Tiere um 15%.",
  },
  [104974] = {
    "Erhöht den Ausweichbonus Eures Aspekts des Affen um 1%.",
    "Erhöht den Ausweichbonus Eures Aspekts des Affen um 2%.",
    "Erhöht den Ausweichbonus Eures Aspekts des Affen um 3%.",
    "Erhöht den Ausweichbonus Eures Aspekts des Affen um 4%.",
    "Erhöht den Ausweichbonus Eures Aspekts des Affen um 5%.",
  },
  [104970] = {
    "Erhöht das Bewegungstempo Eurer Tiere im Freien um 30%.",
  },
  [104969] = {
    "Erhöht den von Euren Tieren verursachten Schaden um 4%.",
    "Erhöht den von Euren Tieren verursachten Schaden um 8%.",
    "Erhöht den von Euren Tieren verursachten Schaden um 12%.",
    "Erhöht den von Euren Tieren verursachten Schaden um 16%.",
    "Erhöht den von Euren Tieren verursachten Schaden um 20%.",
  },
  [104968] = {
    "Gewährt Eurem Zauber Tier heilen bei jeder Heilung eine Chance von 15%, 1 Fluch-, Krankheits-, Magie- oder Gifteffekt von Eurem Tier zu entfernen.",
    "Gewährt Eurem Zauber Tier heilen bei jeder Heilung eine Chance von 50%, 1 Fluch-, Krankheits-, Magie- oder Gifteffekt von Eurem Tier zu entfernen.",
  },
  [104967] = {
    "Erhöht die kritische Trefferchance Eurer Tiere um 3%.",
    "Erhöht die kritische Trefferchance Eurer Tiere um 6%.",
    "Erhöht die kritische Trefferchance Eurer Tiere um 9%.",
    "Erhöht die kritische Trefferchance Eurer Tiere um 12%.",
    "Erhöht die kritische Trefferchance Eurer Tiere um 15%.",
  },
  [104965] = {
    "Solange Euer Tier aktiv ist, erhalten Ihr und Euer Tier alle 10 Sek. 1% Eurer gesamten Gesundheit zurück.",
    "Solange Euer Tier aktiv ist, erhalten Ihr und Euer Tier alle 10 Sek. 2% Eurer gesamten Gesundheit zurück.",
  },
  [104964] = {
    "Befehlt Eurem Tier, das Ziel bei seinem nächsten erfolgreichen Nahkampfangriff einzuschüchtern, was ein hohes Maß an Bedrohung erzeugt und das Ziel 3 Sek. lang betäubt.",
  },
  [104963] = {
    "Erhöht die Fokusregeneration Eurer Tiere um 10%.",
    "Erhöht die Fokusregeneration Eurer Tiere um 20%.",
  },
  [105011] = {
    "Erhöht Eure kritische Trefferchance mit Distanzwaffen um 1%.",
    "Erhöht Eure kritische Trefferchance mit Distanzwaffen um 2%.",
    "Erhöht Eure kritische Trefferchance mit Distanzwaffen um 3%.",
    "Erhöht Eure kritische Trefferchance mit Distanzwaffen um 4%.",
    "Erhöht Eure kritische Trefferchance mit Distanzwaffen um 5%.",
  },
  [105009] = {
    "Verringert die Manakosten Eurer Schüsse und Stiche um 2%.",
    "Verringert die Manakosten Eurer Schüsse und Stiche um 4%.",
    "Verringert die Manakosten Eurer Schüsse und Stiche um 6%.",
    "Verringert die Manakosten Eurer Schüsse und Stiche um 8%.",
    "Verringert die Manakosten Eurer Schüsse und Stiche um 10%.",
  },
  [105006] = {
    "Verringert die Abklingzeit Eures Arkanen Schusses um 0,2 Sek.",
    "Verringert die Abklingzeit Eures Arkanen Schusses um 0,4 Sek.",
    "Verringert die Abklingzeit Eures Arkanen Schusses um 0,6 Sek.",
    "Verringert die Abklingzeit Eures Arkanen Schusses um 0,8 Sek.",
    "Verringert die Abklingzeit Eures Arkanen Schusses um 1 Sek.",
  },
  [105004] = {
    "Erhöht die Angriffskraft von Gruppenmitgliedern im Umkreis von 45 Metern um 50. Hält 30 Min. lang an.",
  },
  [105002] = {
    "Erhöht den kritischen Schadensbonus Eurer Distanzwaffen um 6%.",
    "Erhöht den kritischen Schadensbonus Eurer Distanzwaffen um 12%.",
    "Erhöht den kritischen Schadensbonus Eurer Distanzwaffen um 18%.",
    "Erhöht den kritischen Schadensbonus Eurer Distanzwaffen um 24%.",
    "Erhöht den kritischen Schadensbonus Eurer Distanzwaffen um 30%.",
  },
  [105001] = {
    "Erhöht den Schaden Eurer Zauber Mehrfachschuss und Salve um 5%.",
    "Erhöht den Schaden Eurer Zauber Mehrfachschuss und Salve um 10%.",
    "Erhöht den Schaden Eurer Zauber Mehrfachschuss und Salve um 15%.",
  },
  [104996] = {
    "Erhöht jeglichen Schaden gegen Wildtiere, Riesen und Drachkin um 1% und den kritischen Trefferschaden gegen diese Ziele um zusätzlich 1%.",
    "Erhöht jeglichen Schaden gegen Wildtiere, Riesen und Drachkin um 2% und den kritischen Trefferschaden gegen diese Ziele um zusätzlich 2%.",
    "Erhöht jeglichen Schaden gegen Wildtiere, Riesen und Drachkin um 3% und den kritischen Trefferschaden gegen diese Ziele um zusätzlich 3%.",
  },
  [104995] = {
    "Erhöht Eure Parierchance um 1%.",
    "Erhöht Eure Parierchance um 2%.",
    "Erhöht Eure Parierchance um 3%.",
    "Erhöht Eure Parierchance um 4%.",
    "Erhöht Eure Parierchance um 5%.",
  },
  [104994] = {
    "Gewährt Eurer Feuerbrandfalle, Frostfalle und Sprengfalle eine Chance von 5%, das Ziel zu fesseln, sodass es sich 5 Sek. lang nicht bewegen kann.",
    "Gewährt Eurer Feuerbrandfalle, Frostfalle und Sprengfalle eine Chance von 10%, das Ziel zu fesseln, sodass es sich 5 Sek. lang nicht bewegen kann.",
    "Gewährt Eurer Feuerbrandfalle, Frostfalle und Sprengfalle eine Chance von 15%, das Ziel zu fesseln, sodass es sich 5 Sek. lang nicht bewegen kann.",
    "Gewährt Eurer Feuerbrandfalle, Frostfalle und Sprengfalle eine Chance von 20%, das Ziel zu fesseln, sodass es sich 5 Sek. lang nicht bewegen kann.",
    "Gewährt Eurer Feuerbrandfalle, Frostfalle und Sprengfalle eine Chance von 25%, das Ziel zu fesseln, sodass es sich 5 Sek. lang nicht bewegen kann.",
  },
  [104993] = {
    "Erhöht die kritische Trefferchance von Raptorstoß und Mungobiss um 10%.",
    "Erhöht die kritische Trefferchance von Raptorstoß und Mungobiss um 20%.",
  },
  [104992] = {
    "Erhöht Eure gesamte Gesundheit um 2%.",
    "Erhöht Eure gesamte Gesundheit um 4%.",
    "Erhöht Eure gesamte Gesundheit um 6%.",
    "Erhöht Eure gesamte Gesundheit um 8%.",
    "Erhöht Eure gesamte Gesundheit um 10%.",
  },
  [104990] = {
    "Gewährt Eurer Fähigkeit Zurechtstutzen eine Chance von 4%, das Ziel 5 Sek. lang bewegungsunfähig zu machen.",
    "Gewährt Eurer Fähigkeit Zurechtstutzen eine Chance von 8%, das Ziel 5 Sek. lang bewegungsunfähig zu machen.",
    "Gewährt Eurer Fähigkeit Zurechtstutzen eine Chance von 12%, das Ziel 5 Sek. lang bewegungsunfähig zu machen.",
    "Gewährt Eurer Fähigkeit Zurechtstutzen eine Chance von 16%, das Ziel 5 Sek. lang bewegungsunfähig zu machen.",
    "Gewährt Eurer Fähigkeit Zurechtstutzen eine Chance von 20%, das Ziel 5 Sek. lang bewegungsunfähig zu machen.",
  },
  [104987] = {
    "Erhöht Eure Trefferchance um 1% und Eure Chance, bewegungseinschränkenden Effekten zu widerstehen, um zusätzlich 5%.",
    "Erhöht Eure Trefferchance um 2% und Eure Chance, bewegungseinschränkenden Effekten zu widerstehen, um zusätzlich 10%.",
    "Erhöht Eure Trefferchance um 3% und Eure Chance, bewegungseinschränkenden Effekten zu widerstehen, um zusätzlich 15%.",
  },
  [104988] = {
    "Verringert die Chance, dass Gegner den Effekten Eurer Fallen widerstehen, um 5%.",
    "Verringert die Chance, dass Gegner den Effekten Eurer Fallen widerstehen, um 10%.",
  },
  [104989] = {
    "Ein Schlag, der nach dem Parieren eines gegnerischen Angriffs aktiv wird. Dieser Angriff verursacht 40 Schaden und macht das Ziel 5 Sek. lang bewegungsunfähig. Gegenangriff kann nicht geblockt, ausgewichen oder pariert werden.",
  },
  [110859] = {
    "Erhöht Eure Beweglichkeit um 3%.",
    "Erhöht Eure Beweglichkeit um 6%.",
    "Erhöht Eure Beweglichkeit um 9%.",
    "Erhöht Eure Beweglichkeit um 12%.",
    "Erhöht Eure Beweglichkeit um 15%.",
  },
  [105742] = {
    "Erhöht die Dauer Eures Solarplexus um 0,5 Sek.",
    "Erhöht die Dauer Eures Solarplexus um 1 Sek.",
    "Erhöht die Dauer Eures Solarplexus um 1,5 Sek.",
  },
  [105723] = {
    "Nachdem Ihr einen Gegner getötet habt, der Erfahrung oder Ehre gewährt, ist die kritische Trefferchance Eures nächsten Finsteren Stoßes, Meuchelns, Hinterhalts oder Geisterhaften Stoßes um 20% erhöht. Hält 20 Sek. lang an.",
    "Nachdem Ihr einen Gegner getötet habt, der Erfahrung oder Ehre gewährt, ist die kritische Trefferchance Eures nächsten Finsteren Stoßes, Meuchelns, Hinterhalts oder Geisterhaften Stoßes um 40% erhöht. Hält 20 Sek. lang an.",
  },
  [105722] = {
    "Erhöht Eure kritische Trefferchance um 1%.",
    "Erhöht Eure kritische Trefferchance um 2%.",
    "Erhöht Eure kritische Trefferchance um 3%.",
    "Erhöht Eure kritische Trefferchance um 4%.",
    "Erhöht Eure kritische Trefferchance um 5%.",
  },
  [105721] = {
    "Gewährt Euren Finishing-Moves eine Chance von 20%, dem Ziel einen Kombopunkt hinzuzufügen.",
    "Gewährt Euren Finishing-Moves eine Chance von 40%, dem Ziel einen Kombopunkt hinzuzufügen.",
    "Gewährt Euren Finishing-Moves eine Chance von 60%, dem Ziel einen Kombopunkt hinzuzufügen.",
  },
  [105720] = {
    "Erhöht den Schaden gegen Humanoide, Riesen, Wildtiere und Drachkin um 1%.",
    "Erhöht den Schaden gegen Humanoide, Riesen, Wildtiere und Drachkin um 2%.",
  },
  [105759] = {
    "Eure Finishing-Moves haben pro Kombopunkt eine Chance von 20%, 25 Energie wiederherzustellen.",
  },
  [105717] = {
    "Erhöht die Rüstungsverringerung Eurer Fähigkeit Rüstung schwächen um 25%.",
    "Erhöht die Rüstungsverringerung Eurer Fähigkeit Rüstung schwächen um 50%.",
  },
  [105716] = {
    "Erhöht den kritischen Schadensbonus Eures Finsteren Stoßes, Solarplexus, Meuchelns, Geisterhaften Stoßes und Blutsturzes um 6%.",
    "Erhöht den kritischen Schadensbonus Eures Finsteren Stoßes, Solarplexus, Meuchelns, Geisterhaften Stoßes und Blutsturzes um 12%.",
    "Erhöht den kritischen Schadensbonus Eures Finsteren Stoßes, Solarplexus, Meuchelns, Geisterhaften Stoßes und Blutsturzes um 18%.",
    "Erhöht den kritischen Schadensbonus Eures Finsteren Stoßes, Solarplexus, Meuchelns, Geisterhaften Stoßes und Blutsturzes um 24%.",
    "Erhöht den kritischen Schadensbonus Eures Finsteren Stoßes, Solarplexus, Meuchelns, Geisterhaften Stoßes und Blutsturzes um 30%.",
  },
  [105715] = {
    "Erhöht bei Aktivierung die kritische Trefferchance Eures nächsten Finsteren Stoßes, Meuchelns, Hinterhalts oder Ausweidens um 100%.",
  },
  [105713] = {
    "Erhöht Eure Chance, Gifte auf Euer Ziel anzuwenden, um 2%.",
    "Erhöht Eure Chance, Gifte auf Euer Ziel anzuwenden, um 4%.",
    "Erhöht Eure Chance, Gifte auf Euer Ziel anzuwenden, um 6%.",
    "Erhöht Eure Chance, Gifte auf Euer Ziel anzuwenden, um 8%.",
    "Erhöht Eure Chance, Gifte auf Euer Ziel anzuwenden, um 10%.",
  },
  [105718] = {
    "Erhöht Eure maximale Energie um 10.",
  },
  [105711] = {
    "Solange das Ziel von Eurem Nierenhieb betroffen ist, erleidet es 3% zusätzlichen Schaden aus allen Quellen.",
    "Solange das Ziel von Eurem Nierenhieb betroffen ist, erleidet es 6% zusätzlichen Schaden aus allen Quellen.",
    "Solange das Ziel von Eurem Nierenhieb betroffen ist, erleidet es 9% zusätzlichen Schaden aus allen Quellen.",
  },
  [105710] = {
    "Eure kritischen Treffer mit Fähigkeiten, die Kombopunkte hinzufügen, haben eine Chance von 20%, einen zusätzlichen Kombopunkt hinzuzufügen.",
    "Eure kritischen Treffer mit Fähigkeiten, die Kombopunkte hinzufügen, haben eine Chance von 40%, einen zusätzlichen Kombopunkt hinzuzufügen.",
    "Eure kritischen Treffer mit Fähigkeiten, die Kombopunkte hinzufügen, haben eine Chance von 60%, einen zusätzlichen Kombopunkt hinzuzufügen.",
    "Eure kritischen Treffer mit Fähigkeiten, die Kombopunkte hinzufügen, haben eine Chance von 80%, einen zusätzlichen Kombopunkt hinzuzufügen.",
    "Eure kritischen Treffer mit Fähigkeiten, die Kombopunkte hinzufügen, haben eine Chance von 100%, einen zusätzlichen Kombopunkt hinzuzufügen.",
  },
  [105708] = {
    "Erhöht den Schaden Eures Ausweidens um 5%.",
    "Erhöht den Schaden Eures Ausweidens um 10%.",
    "Erhöht den Schaden Eures Ausweidens um 15%.",
  },
  [105738] = {
    "Erhöht Eure Parierchance um 1%.",
    "Erhöht Eure Parierchance um 2%.",
    "Erhöht Eure Parierchance um 3%.",
    "Erhöht Eure Parierchance um 4%.",
    "Erhöht Eure Parierchance um 5%.",
  },
  [105737] = {
    "Erhöht Eure Trefferchance mit Nahkampfwaffen um 1%.",
    "Erhöht Eure Trefferchance mit Nahkampfwaffen um 2%.",
    "Erhöht Eure Trefferchance mit Nahkampfwaffen um 3%.",
    "Erhöht Eure Trefferchance mit Nahkampfwaffen um 4%.",
    "Erhöht Eure Trefferchance mit Nahkampfwaffen um 5%.",
  },
  [105736] = {
    "Verringert die Abklingzeit Eurer Fähigkeiten Sprinten und Entrinnen um 45 Sek.",
    "Verringert die Abklingzeit Eurer Fähigkeiten Sprinten und Entrinnen um 1,5 Min.",
  },
  [105735] = {
    "Ein Angriff, der nach dem Parieren eines gegnerischen Angriffs aktiv wird. Er verursacht 150% Waffenschaden und entwaffnet das Ziel 6 Sek. lang.",
  },
  [105733] = {
    "Gewährt Eurer Fähigkeit Tritt eine Chance von 50%, das Ziel 2 Sek. lang zum Schweigen zu bringen.",
    "Gewährt Eurer Fähigkeit Tritt eine Chance von 100%, das Ziel 2 Sek. lang zum Schweigen zu bringen.",
  },
  [105740] = {
    "Erhöht den Schaden Eurer Schildhandwaffe um 10%.",
    "Erhöht den Schaden Eurer Schildhandwaffe um 20%.",
    "Erhöht den Schaden Eurer Schildhandwaffe um 30%.",
    "Erhöht den Schaden Eurer Schildhandwaffe um 40%.",
    "Erhöht den Schaden Eurer Schildhandwaffe um 50%.",
  },
  [105728] = {
    "Erhöht Euer Angriffstempo um 20%. Außerdem treffen Eure Angriffe einen zusätzlichen Gegner in der Nähe. Hält 15 Sek. lang an.",
  },
  [105727] = {
    "Gewährt Euch eine Chance von 1% auf einen zusätzlichen Angriff gegen dasselbe Ziel, nachdem Ihr ihm mit Eurem Schwert Schaden zugefügt habt.",
    "Gewährt Euch eine Chance von 2% auf einen zusätzlichen Angriff gegen dasselbe Ziel, nachdem Ihr ihm mit Eurem Schwert Schaden zugefügt habt.",
    "Gewährt Euch eine Chance von 3% auf einen zusätzlichen Angriff gegen dasselbe Ziel, nachdem Ihr ihm mit Eurem Schwert Schaden zugefügt habt.",
    "Gewährt Euch eine Chance von 4% auf einen zusätzlichen Angriff gegen dasselbe Ziel, nachdem Ihr ihm mit Eurem Schwert Schaden zugefügt habt.",
    "Gewährt Euch eine Chance von 5% auf einen zusätzlichen Angriff gegen dasselbe Ziel, nachdem Ihr ihm mit Eurem Schwert Schaden zugefügt habt.",
  },
  [105726] = {
    "Erhöht Eure Fertigkeit mit Schwertern, Faustwaffen und Dolchen um 3.",
    "Erhöht Eure Fertigkeit mit Schwertern, Faustwaffen und Dolchen um 5.",
  },
  [105730] = {
    "Erhöht den Schaden Eures Finsteren Stoßes und Ausweidens um 2%.",
    "Erhöht den Schaden Eures Finsteren Stoßes und Ausweidens um 4%.",
    "Erhöht den Schaden Eures Finsteren Stoßes und Ausweidens um 6%.",
  },
  [105756] = {
    "Erhöht Euer Bewegungstempo in Verstohlenheit um 3% und verringert die Abklingzeit Eurer Verstohlenheit um 1 Sek.",
    "Erhöht Euer Bewegungstempo in Verstohlenheit um 6% und verringert die Abklingzeit Eurer Verstohlenheit um 2 Sek.",
    "Erhöht Euer Bewegungstempo in Verstohlenheit um 9% und verringert die Abklingzeit Eurer Verstohlenheit um 3 Sek.",
    "Erhöht Euer Bewegungstempo in Verstohlenheit um 12% und verringert die Abklingzeit Eurer Verstohlenheit um 4 Sek.",
    "Erhöht Euer Bewegungstempo in Verstohlenheit um 15% und verringert die Abklingzeit Eurer Verstohlenheit um 5 Sek.",
  },
  [105761] = {
    "Verringert die Chance von Gegnern, Euch in Verstohlenheit zu entdecken.",
    "Verringert die Chance von Gegnern, Euch in Verstohlenheit zu entdecken. Wirksamer als Meister der Täuschung (Rang 1).",
    "Verringert die Chance von Gegnern, Euch in Verstohlenheit zu entdecken. Wirksamer als Meister der Täuschung (Rang 2).",
    "Verringert die Chance von Gegnern, Euch in Verstohlenheit zu entdecken. Wirksamer als Meister der Täuschung (Rang 3).",
    "Verringert die Chance von Gegnern, Euch in Verstohlenheit zu entdecken. Wirksamer als Meister der Täuschung (Rang 4).",
  },
  [105760] = {
    "Erhöht den Schaden von hinten mit Meucheln, Erdrosseln oder Hinterhalt um 4%.",
    "Erhöht den Schaden von hinten mit Meucheln, Erdrosseln oder Hinterhalt um 8%.",
    "Erhöht den Schaden von hinten mit Meucheln, Erdrosseln oder Hinterhalt um 12%.",
    "Erhöht den Schaden von hinten mit Meucheln, Erdrosseln oder Hinterhalt um 16%.",
    "Erhöht den Schaden von hinten mit Meucheln, Erdrosseln oder Hinterhalt um 20%.",
  },
  [105751] = {
    "Gewährt Euch eine Chance von 15%, Eurem Ziel einen Kombopunkt hinzuzufügen, nachdem Ihr seinem Angriff ausgewichen seid oder einem seiner Zauber vollständig widerstanden habt.",
    "Gewährt Euch eine Chance von 30%, Eurem Ziel einen Kombopunkt hinzuzufügen, nachdem Ihr seinem Angriff ausgewichen seid oder einem seiner Zauber vollständig widerstanden habt.",
    "Gewährt Euch eine Chance von 45%, Eurem Ziel einen Kombopunkt hinzuzufügen, nachdem Ihr seinem Angriff ausgewichen seid oder einem seiner Zauber vollständig widerstanden habt.",
  },
  [105753] = {
    "Verringert die Abklingzeit Eurer Fähigkeiten Verschwinden und Blenden um 45 Sek.",
    "Verringert die Abklingzeit Eurer Fähigkeiten Verschwinden und Blenden um 1.5 Sek.",
  },
  [105755] = {
    "Gewährt Euch eine Chance von 25%, Eurem Ziel einen zusätzlichen Kombopunkt hinzuzufügen, wenn Ihr Hinterhalt, Erdrosseln oder Fieser Trick benutzt.",
    "Gewährt Euch eine Chance von 50%, Eurem Ziel einen zusätzlichen Kombopunkt hinzuzufügen, wenn Ihr Hinterhalt, Erdrosseln oder Fieser Trick benutzt.",
    "Gewährt Euch eine Chance von 75%, Eurem Ziel einen zusätzlichen Kombopunkt hinzuzufügen, wenn Ihr Hinterhalt, Erdrosseln oder Fieser Trick benutzt.",
  },
  [105754] = {
    "Ein Schlag, der 125% Waffenschaden verursacht und Eure Ausweichchance 7 Sek. lang um 15% erhöht. Gewährt 1 Kombopunkt.",
  },
  [105747] = {
    "Verbessert Eure Entdeckung von Verstohlenheit und verringert die Chance, von Zaubern und Distanzangriffen getroffen zu werden, um 2%.",
    "Verbessert Eure Entdeckung von Verstohlenheit und verringert die Chance, von Zaubern und Distanzangriffen getroffen zu werden, um 4%. Wirksamer als Geschärfte Sinne (Rang 1).",
  },
  [105743] = {
    "Fügt Eurem Ziel bei Benutzung 2 Kombopunkte hinzu. Ihr müsst diese Kombopunkte innerhalb von 10 Sek. erweitern oder verbrauchen, sonst gehen sie verloren.",
  },
  [105752] = {
    "Lässt Eure Angriffe 100 Rüstung Eures Ziels ignorieren und erhöht den Schaden Eurer Blutung um 10%. Die ignorierte Rüstung steigt mit Eurer Stufe.",
    "Lässt Eure Angriffe 200 Rüstung Eures Ziels ignorieren und erhöht den Schaden Eurer Blutung um 20%. Die ignorierte Rüstung steigt mit Eurer Stufe.",
    "Lässt Eure Angriffe 300 Rüstung Eures Ziels ignorieren und erhöht den Schaden Eurer Blutung um 30%. Die ignorierte Rüstung steigt mit Eurer Stufe.",
  },
  [105745] = {
    "Verringert die Energiekosten Eures Fiesen Tricks und Erdrosselns um 10.",
    "Verringert die Energiekosten Eures Fiesen Tricks und Erdrosselns um 20.",
  },
  [105748] = {
    "Ein sofortiger Schlag, der den Gegner verletzt und bei ihm einen Blutsturz auslöst, der jeglichen körperlichen Schaden am Ziel um bis zu 3 erhöht. Hält 30 Aufladungen oder 15 Sek. lang an. Gewährt 1 Kombopunkt.",
  },
  [105850] = {
    "Erhöht den mit Zauberstäben verursachten Schaden um 5%.",
    "Erhöht den mit Zauberstäben verursachten Schaden um 10%.",
    "Erhöht den mit Zauberstäben verursachten Schaden um 15%.",
    "Erhöht den mit Zauberstäben verursachten Schaden um 20%.",
    "Erhöht den mit Zauberstäben verursachten Schaden um 25%.",
  },
  [105848] = {
    "Verringert die durch Eure Zauber erzeugte Bedrohung um 4%.",
    "Verringert die durch Eure Zauber erzeugte Bedrohung um 8%.",
    "Verringert die durch Eure Zauber erzeugte Bedrohung um 12%.",
    "Verringert die durch Eure Zauber erzeugte Bedrohung um 16%.",
    "Verringert die durch Eure Zauber erzeugte Bedrohung um 20%.",
  },
  [105846] = {
    "Erhöht den von Eurem Machtwort: Schild absorbierten Schaden um 5%.",
    "Erhöht den von Eurem Machtwort: Schild absorbierten Schaden um 10%.",
    "Erhöht den von Eurem Machtwort: Schild absorbierten Schaden um 15%.",
  },
  [105845] = {
    "Gewährt Euch eine Chance von 50%, den Effekt Fokussiertes Zaubern zu erhalten, der 6 Sek. lang anhält, nachdem Ihr Opfer eines kritischen Nah- oder Distanztreffers wurdet. Fokussiertes Zaubern verhindert Zauberzeitverlust durch erlittenen Schaden und erhöht den Widerstand gegen Unterbrechungseffekte um 10%.",
    "Gewährt Euch eine Chance von 100%, den Effekt Fokussiertes Zaubern zu erhalten, der 6 Sek. lang anhält, nachdem Ihr Opfer eines kritischen Nah- oder Distanztreffers wurdet. Fokussiertes Zaubern verhindert Zauberzeitverlust durch erlittenen Schaden und erhöht den Widerstand gegen Unterbrechungseffekte um 20%.",
  },
  [105842] = {
    "Verringert die Manakosten Eurer Spontanzauber um 2%.",
    "Verringert die Manakosten Eurer Spontanzauber um 4%.",
    "Verringert die Manakosten Eurer Spontanzauber um 6%.",
    "Verringert die Manakosten Eurer Spontanzauber um 8%.",
    "Verringert die Manakosten Eurer Spontanzauber um 10%.",
  },
  [105843] = {
    "Ermöglicht, dass 5% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
    "Ermöglicht, dass 10% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
    "Ermöglicht, dass 15% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
  },
  [105841] = {
    "Erhöht den Rüstungsbonus Eures Zaubers Inneres Feuer um 10%.",
    "Erhöht den Rüstungsbonus Eures Zaubers Inneres Feuer um 20%.",
    "Erhöht den Rüstungsbonus Eures Zaubers Inneres Feuer um 30%.",
  },
  [105837] = {
    "Erhöht Euer maximales Mana um 2%.",
    "Erhöht Euer maximales Mana um 4%.",
    "Erhöht Euer maximales Mana um 6%.",
    "Erhöht Euer maximales Mana um 8%.",
    "Erhöht Euer maximales Mana um 10%.",
  },
  [105838] = {
    "Verringert die Zauberzeit Eures Zaubers Manabrand um 0.25 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Manabrand um 0.5 Sek.",
  },
  [105836] = {
    "Erfüllt das Ziel mit Macht und erhöht dessen Zauberschaden und Heilung um 20%. Hält 15 Sek. lang an.",
  },
  [105867] = {
    "Gewährt Euch eine Chance von 35%, beim Wirken eines Heilzaubers keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 70%, beim Wirken eines Heilzaubers keine Unterbrechung durch erlittenen Schaden zu erleiden.",
  },
  [105863] = {
    "Verringert die Zauberzeit Eurer Zauber Göttliche Pein, Heiliges Feuer, Heilen und Große Heilung um 0.1 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Göttliche Pein, Heiliges Feuer, Heilen und Große Heilung um 0.2 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Göttliche Pein, Heiliges Feuer, Heilen und Große Heilung um 0.3 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Göttliche Pein, Heiliges Feuer, Heilen und Große Heilung um 0.4 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Göttliche Pein, Heiliges Feuer, Heilen und Große Heilung um 0.5 Sek.",
  },
  [105862] = {
    "Löst eine Explosion heiligen Lichts um den Zaubernden aus, die allen Gegnern im Umkreis von 10 Metern 29 bis 33 Heiligschaden zufügt und alle Gruppenmitglieder im Umkreis von 10 Metern um 54 bis 62 heilt. Diese Effekte erzeugen keine Bedrohung.",
  },
  [105861] = {
    "Nachdem Ihr durch einen Nah- oder Distanzangriff kritisch getroffen wurdet, erhaltet Ihr im Verlauf von 6 Sek. 8% des erlittenen Schadens zurück.",
    "Nachdem Ihr durch einen Nah- oder Distanzangriff kritisch getroffen wurdet, erhaltet Ihr im Verlauf von 6 Sek. 16% des erlittenen Schadens zurück.",
    "Nachdem Ihr durch einen Nah- oder Distanzangriff kritisch getroffen wurdet, erhaltet Ihr im Verlauf von 6 Sek. 25% des erlittenen Schadens zurück.",
  },
  [105860] = {
    "Erhöht die Rüstung Eures Ziels 15 Sek. lang um 8%, nachdem Ihr einen kritischen Effekt mit Blitzheilung, Heilen, Große Heilung oder Gebet der Heilung erzielt habt.",
    "Erhöht die Rüstung Eures Ziels 15 Sek. lang um 16%, nachdem Ihr einen kritischen Effekt mit Blitzheilung, Heilen, Große Heilung oder Gebet der Heilung erzielt habt.",
    "Erhöht die Rüstung Eures Ziels 15 Sek. lang um 25%, nachdem Ihr einen kritischen Effekt mit Blitzheilung, Heilen, Große Heilung oder Gebet der Heilung erzielt habt.",
  },
  [105858] = {
    "Verringert die Manakosten Eurer Zauber Geringes Heilen, Heilen und Große Heilung um 5%.",
    "Verringert die Manakosten Eurer Zauber Geringes Heilen, Heilen und Große Heilung um 10%.",
    "Verringert die Manakosten Eurer Zauber Geringes Heilen, Heilen und Große Heilung um 15%.",
  },
  [105857] = {
    "Erhöht den Schaden Eurer Zauber Göttliche Pein und Heiliges Feuer um 5%.",
    "Erhöht den Schaden Eurer Zauber Göttliche Pein und Heiliges Feuer um 10%.",
  },
  [105854] = {
    "Beim Tod wird der Priester 10 Sek. lang zum Geist der Erlösung. Der Geist der Erlösung kann sich nicht bewegen, nicht angreifen und weder angegriffen noch von Zaubern oder Effekten anvisiert werden. In dieser Gestalt kann der Priester jeden Heilzauber kostenlos wirken. Endet der Effekt, stirbt der Priester.",
  },
  [105853] = {
    "Erhöht Zauberschaden und Heilung um bis zu 5% Eurer gesamten Willenskraft.",
    "Erhöht Zauberschaden und Heilung um bis zu 10% Eurer gesamten Willenskraft.",
    "Erhöht Zauberschaden und Heilung um bis zu 15% Eurer gesamten Willenskraft.",
    "Erhöht Zauberschaden und Heilung um bis zu 20% Eurer gesamten Willenskraft.",
    "Erhöht Zauberschaden und Heilung um bis zu 25% Eurer gesamten Willenskraft.",
  },
  [105852] = {
    "Erhöht die Heilung Eurer Heilzauber um 2%.",
    "Erhöht die Heilung Eurer Heilzauber um 4%.",
    "Erhöht die Heilung Eurer Heilzauber um 6%.",
    "Erhöht die Heilung Eurer Heilzauber um 8%.",
    "Erhöht die Heilung Eurer Heilzauber um 10%.",
  },
  [110851] = {
    "Verringert die Chance Eures Ziels, Euren Schattenzaubern zu widerstehen, um 2%.",
    "Verringert die Chance Eures Ziels, Euren Schattenzaubern zu widerstehen, um 4%.",
    "Verringert die Chance Eures Ziels, Euren Schattenzaubern zu widerstehen, um 6%.",
    "Verringert die Chance Eures Ziels, Euren Schattenzaubern zu widerstehen, um 8%.",
    "Verringert die Chance Eures Ziels, Euren Schattenzaubern zu widerstehen, um 10%.",
  },
  [105833] = {
    "Gewährt Euch eine Chance von 20%, nach dem Töten eines Ziels, das Erfahrung gewährt, einen Bonus von 100% auf Eure Willenskraft zu erhalten. Solange dieser Effekt aktiv ist, regeneriert sich Euer Mana beim Zaubern mit 50% der normalen Rate. Hält 15 Sek. lang an.",
    "Gewährt Euch eine Chance von 40%, nach dem Töten eines Ziels, das Erfahrung gewährt, einen Bonus von 100% auf Eure Willenskraft zu erhalten. Solange dieser Effekt aktiv ist, regeneriert sich Euer Mana beim Zaubern mit 50% der normalen Rate. Hält 15 Sek. lang an.",
    "Gewährt Euch eine Chance von 60%, nach dem Töten eines Ziels, das Erfahrung gewährt, einen Bonus von 100% auf Eure Willenskraft zu erhalten. Solange dieser Effekt aktiv ist, regeneriert sich Euer Mana beim Zaubern mit 50% der normalen Rate. Hält 15 Sek. lang an.",
    "Gewährt Euch eine Chance von 80%, nach dem Töten eines Ziels, das Erfahrung gewährt, einen Bonus von 100% auf Eure Willenskraft zu erhalten. Solange dieser Effekt aktiv ist, regeneriert sich Euer Mana beim Zaubern mit 50% der normalen Rate. Hält 15 Sek. lang an.",
    "Gewährt Euch eine Chance von 100%, nach dem Töten eines Ziels, das Erfahrung gewährt, einen Bonus von 100% auf Eure Willenskraft zu erhalten. Solange dieser Effekt aktiv ist, regeneriert sich Euer Mana beim Zaubern mit 50% der normalen Rate. Hält 15 Sek. lang an.",
  },
  [105831] = {
    "Verringert die durch Eure Schattenzauber erzeugte Bedrohung um 8%.",
    "Verringert die durch Eure Schattenzauber erzeugte Bedrohung um 16%.",
    "Verringert die durch Eure Schattenzauber erzeugte Bedrohung um 25%.",
  },
  [105829] = {
    "Erhöht die Reichweite Eurer Schattenschadenszauber um 6%.",
    "Erhöht die Reichweite Eurer Schattenschadenszauber um 13%.",
    "Erhöht die Reichweite Eurer Schattenschadenszauber um 20%.",
  },
  [105826] = {
    "Greift den Geist des Ziels mit Schattenenergie an, verursacht im Verlauf von 3 Sek. 75 Schattenschaden und verringert sein Bewegungstempo um 50%.",
  },
  [105820] = {
    "Belegt Euer Ziel mit Schattenenergie, die 1 Min. lang alle Gruppenmitglieder um 20% des von Euren Schattenzaubern verursachten Schadens heilt.",
  },
  [105821] = {
    "Eure Schattenschadenszauber haben eine Chance von 20%, Euer Ziel für Schattenschaden verwundbar zu machen. Diese Verwundbarkeit erhöht den Schattenschaden am Ziel um 3% und hält 15 Sek. lang an. Bis zu 5-mal stapelbar.",
    "Eure Schattenschadenszauber haben eine Chance von 40%, Euer Ziel für Schattenschaden verwundbar zu machen. Diese Verwundbarkeit erhöht den Schattenschaden am Ziel um 3% und hält 15 Sek. lang an. Bis zu 5-mal stapelbar.",
    "Eure Schattenschadenszauber haben eine Chance von 60%, Euer Ziel für Schattenschaden verwundbar zu machen. Diese Verwundbarkeit erhöht den Schattenschaden am Ziel um 3% und hält 15 Sek. lang an. Bis zu 5-mal stapelbar.",
    "Eure Schattenschadenszauber haben eine Chance von 80%, Euer Ziel für Schattenschaden verwundbar zu machen. Diese Verwundbarkeit erhöht den Schattenschaden am Ziel um 3% und hält 15 Sek. lang an. Bis zu 5-mal stapelbar.",
    "Eure Schattenschadenszauber haben eine Chance von 100%, Euer Ziel für Schattenschaden verwundbar zu machen. Diese Verwundbarkeit erhöht den Schattenschaden am Ziel um 3% und hält 15 Sek. lang an. Bis zu 5-mal stapelbar.",
  },
  [105824] = {
    "Bringt das Ziel zum Schweigen und hindert es 5 Sek. lang am Zaubern.",
  },
  [105818] = {
    "Erhöht den Schaden Eurer Schattenzauber um 2%.",
    "Erhöht den Schaden Eurer Schattenzauber um 4%.",
    "Erhöht den Schaden Eurer Schattenzauber um 6%.",
    "Erhöht den Schaden Eurer Schattenzauber um 8%.",
    "Erhöht den Schaden Eurer Schattenzauber um 10%.",
  },
  [105817] = {
    "Nehmt Schattengestalt an, was Euren Schattenschaden um 15% erhöht und den erlittenen körperlichen Schaden um 15% verringert. In dieser Gestalt könnt Ihr jedoch keine Heiligzauber wirken.",
  },
  [104773] = {
    "Verringert die Manakosten Eurer Zauber Schock, Blitzschlag und Kettenblitzschlag um 2%.",
    "Verringert die Manakosten Eurer Zauber Schock, Blitzschlag und Kettenblitzschlag um 4%.",
    "Verringert die Manakosten Eurer Zauber Schock, Blitzschlag und Kettenblitzschlag um 6%.",
    "Verringert die Manakosten Eurer Zauber Schock, Blitzschlag und Kettenblitzschlag um 8%.",
    "Verringert die Manakosten Eurer Zauber Schock, Blitzschlag und Kettenblitzschlag um 10%.",
  },
  [104772] = {
    "Erhöht den Schaden Eurer Zauber Blitzschlag, Kettenblitzschlag und Schock um 1%.",
    "Erhöht den Schaden Eurer Zauber Blitzschlag, Kettenblitzschlag und Schock um 2%.",
    "Erhöht den Schaden Eurer Zauber Blitzschlag, Kettenblitzschlag und Schock um 3%.",
    "Erhöht den Schaden Eurer Zauber Blitzschlag, Kettenblitzschlag und Schock um 4%.",
    "Erhöht den Schaden Eurer Zauber Blitzschlag, Kettenblitzschlag und Schock um 5%.",
  },
  [104771] = {
    "Verringert den durch Feuer-, Frost- und Natureffekte erlittenen Schaden um 4%.",
    "Verringert den durch Feuer-, Frost- und Natureffekte erlittenen Schaden um 7%.",
    "Verringert den durch Feuer-, Frost- und Natureffekte erlittenen Schaden um 10%.",
  },
  [104770] = {
    "Erhöht den Schaden Eurer Feuertotems um 5%.",
    "Erhöht den Schaden Eurer Feuertotems um 10%.",
    "Erhöht den Schaden Eurer Feuertotems um 15%.",
  },
  [104769] = {
    "Eure kritischen Treffer mit Angriffszaubern erhöhen 10 Sek. lang Eure Chance auf einen kritischen Nahkampftreffer um 3%.",
    "Eure kritischen Treffer mit Angriffszaubern erhöhen 10 Sek. lang Eure Chance auf einen kritischen Nahkampftreffer um 6%.",
    "Eure kritischen Treffer mit Angriffszaubern erhöhen 10 Sek. lang Eure Chance auf einen kritischen Nahkampftreffer um 9%.",
  },
  [104766] = {
    "Erhöht den kritischen Schadensbonus Eurer Totems der Verbrennung, des glühenden Magmas und der Feuernova sowie Eurer Feuer-, Frost- und Naturzauber um 100%.",
  },
  [104764] = {
    "Verringert die Verzögerung bis zur Aktivierung Eures Totems der Feuernova um 1 Sek. und die durch Euer Totem des glühenden Magmas erzeugte Bedrohung um 25%.",
    "Verringert die Verzögerung bis zur Aktivierung Eures Totems der Feuernova um 2 Sek. und die durch Euer Totem des glühenden Magmas erzeugte Bedrohung um 50%.",
  },
  [104763] = {
    "Gewährt Euch eine Chance von 33%, 6 Sek. lang den Effekt Fokussiertes Zaubern zu erhalten, nachdem Ihr Opfer eines kritischen Nah- oder Distanztreffers wurdet. Fokussiertes Zaubern verhindert Zauberzeitverlust durch erlittenen Schaden.",
    "Gewährt Euch eine Chance von 66%, 6 Sek. lang den Effekt Fokussiertes Zaubern zu erhalten, nachdem Ihr Opfer eines kritischen Nah- oder Distanztreffers wurdet. Fokussiertes Zaubern verhindert Zauberzeitverlust durch erlittenen Schaden.",
    "Gewährt Euch eine Chance von 100%, 6 Sek. lang den Effekt Fokussiertes Zaubern zu erhalten, nachdem Ihr Opfer eines kritischen Nah- oder Distanztreffers wurdet. Fokussiertes Zaubern verhindert Zauberzeitverlust durch erlittenen Schaden.",
  },
  [104762] = {
    "Erhöht die kritische Trefferchance Eurer Zauber Blitzschlag und Kettenblitzschlag um zusätzlich 1%.",
    "Erhöht die kritische Trefferchance Eurer Zauber Blitzschlag und Kettenblitzschlag um zusätzlich 2%.",
    "Erhöht die kritische Trefferchance Eurer Zauber Blitzschlag und Kettenblitzschlag um zusätzlich 3%.",
    "Erhöht die kritische Trefferchance Eurer Zauber Blitzschlag und Kettenblitzschlag um zusätzlich 4%.",
    "Erhöht die kritische Trefferchance Eurer Zauber Blitzschlag und Kettenblitzschlag um zusätzlich 6%.",
  },
  [104761] = {
    "Erhöht die Reichweite Eurer Zauber Blitzschlag und Kettenblitzschlag um 3 Meter.",
    "Erhöht die Reichweite Eurer Zauber Blitzschlag und Kettenblitzschlag um 6 Meter.",
  },
  [104765] = {
    "Verringert die Zauberzeit Eurer Zauber Blitzschlag und Kettenblitzschlag um 0.2 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Blitzschlag und Kettenblitzschlag um 0.4 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Blitzschlag und Kettenblitzschlag um 0.6 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Blitzschlag und Kettenblitzschlag um 0.8 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Blitzschlag und Kettenblitzschlag um 1 Sek.",
  },
  [104753] = {
    "Erhöht Eure Chance auf einen kritischen Treffer mit Waffenangriffen um 1%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Waffenangriffen um 2%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Waffenangriffen um 3%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Waffenangriffen um 4%.",
    "Erhöht Eure Chance auf einen kritischen Treffer mit Waffenangriffen um 5%.",
  },
  [104756] = {
    "Erhöht Euer maximales Mana um 1%.",
    "Erhöht Euer maximales Mana um 2%.",
    "Erhöht Euer maximales Mana um 3%.",
    "Erhöht Euer maximales Mana um 4%.",
    "Erhöht Euer maximales Mana um 5%.",
  },
  [104752] = {
    "Verringert die Zauberzeit Eures Zaubers Geisterwolf um 1 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Geisterwolf um 2 Sek.",
  },
  [104750] = {
    "Erhöht den Nahkampfangriffskraftbonus Eurer Waffe des Felsbeißers um 7%, den Effekt Eurer Waffe des Windzorns um 13% und den Schaden Eurer Waffen der Flammenzunge und des Frostbrands um 5%.",
    "Erhöht den Nahkampfangriffskraftbonus Eurer Waffe des Felsbeißers um 14%, den Effekt Eurer Waffe des Windzorns um 27% und den Schaden Eurer Waffen der Flammenzunge und des Frostbrands um 10%.",
    "Erhöht den Nahkampfangriffskraftbonus Eurer Waffe des Felsbeißers um 20%, den Effekt Eurer Waffe des Windzorns um 40% und den Schaden Eurer Waffen der Flammenzunge und des Frostbrands um 15%.",
  },
  [104748] = {
    "Erhöht Eure Ausweichchance um zusätzlich 1%.",
    "Erhöht Eure Ausweichchance um zusätzlich 2%.",
    "Erhöht Eure Ausweichchance um zusätzlich 3%.",
    "Erhöht Eure Ausweichchance um zusätzlich 4%.",
    "Erhöht Eure Ausweichchance um zusätzlich 5%.",
  },
  [104746] = {
    "Erhöht den Rüstungswert von Gegenständen um 2%.",
    "Erhöht den Rüstungswert von Gegenständen um 4%.",
    "Erhöht den Rüstungswert von Gegenständen um 6%.",
    "Erhöht den Rüstungswert von Gegenständen um 8%.",
    "Erhöht den Rüstungswert von Gegenständen um 10%.",
  },
  [104747] = {
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 10%, nachdem Ihr einen kritischen Treffer erzielt habt.",
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 15%, nachdem Ihr einen kritischen Treffer erzielt habt.",
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 20%, nachdem Ihr einen kritischen Treffer erzielt habt.",
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 25%, nachdem Ihr einen kritischen Treffer erzielt habt.",
    "Erhöht Euer Angriffstempo für Eure nächsten 3 Schwünge um 30%, nachdem Ihr einen kritischen Treffer erzielt habt.",
  },
  [104743] = {
    "Gewährt Euch einen zusätzlichen Angriff. Außerdem ist der Schaden der nächsten 2 Naturschadensquellen am Ziel um 20% erhöht. Hält 12 Sek. lang an.",
  },
  [104745] = {
    "Gewährt Euch eine Chance, Nahkampfangriffe von Gegnern zu parieren.",
  },
  [104729] = {
    "Verringert die Manakosten Eurer Totems um 5%.",
    "Verringert die Manakosten Eurer Totems um 10%.",
    "Verringert die Manakosten Eurer Totems um 15%.",
    "Verringert die Manakosten Eurer Totems um 20%.",
    "Verringert die Manakosten Eurer Totems um 25%.",
  },
  [104736] = {
    "Verringert die durch Eure Heilzauber erzeugte Bedrohung um 5%.",
    "Verringert die durch Eure Heilzauber erzeugte Bedrohung um 10%.",
    "Verringert die durch Eure Heilzauber erzeugte Bedrohung um 15%.",
  },
  [104735] = {
    "Verringert die Manakosten Eurer Heilzauber um 1%.",
    "Verringert die Manakosten Eurer Heilzauber um 2%.",
    "Verringert die Manakosten Eurer Heilzauber um 3%.",
    "Verringert die Manakosten Eurer Heilzauber um 4%.",
    "Verringert die Manakosten Eurer Heilzauber um 5%.",
  },
  [104737] = {
    "Verringert die Abklingzeit Eures Zaubers Reinkarnation um 10 Min. und erhöht die Gesundheit und das Mana, mit denen Ihr wiederbelebt werdet, um zusätzlich 10%.",
    "Verringert die Abklingzeit Eures Zaubers Reinkarnation um 20 Min. und erhöht die Gesundheit und das Mana, mit denen Ihr wiederbelebt werdet, um zusätzlich 20%.",
  },
  [104731] = {
    "Erhöht den Rüstungswert Eures Ziels 15 Sek. lang um 8%, nachdem es einen kritischen Effekt eines Eurer Heilzauber erhalten hat.",
    "Erhöht den Rüstungswert Eures Ziels 15 Sek. lang um 16%, nachdem es einen kritischen Effekt eines Eurer Heilzauber erhalten hat.",
    "Erhöht den Rüstungswert Eures Ziels 15 Sek. lang um 25%, nachdem es einen kritischen Effekt eines Eurer Heilzauber erhalten hat.",
  },
  [104733] = {
    "Gewährt Euch eine Chance von 14%, beim Wirken eines Heilzaubers keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 28%, beim Wirken eines Heilzaubers keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 42%, beim Wirken eines Heilzaubers keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 56%, beim Wirken eines Heilzaubers keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 70%, beim Wirken eines Heilzaubers keine Unterbrechung durch erlittenen Schaden zu erleiden.",
  },
  [104738] = {
    "Erhöht die kritische Effektchance Eurer Heil- und Blitzzauber um 1%.",
    "Erhöht die kritische Effektchance Eurer Heil- und Blitzzauber um 2%.",
    "Erhöht die kritische Effektchance Eurer Heil- und Blitzzauber um 3%.",
    "Erhöht die kritische Effektchance Eurer Heil- und Blitzzauber um 4%.",
    "Erhöht die kritische Effektchance Eurer Heil- und Blitzzauber um 5%.",
  },
  [104730] = {
    "Erhöht den Effekt Eurer Totems der Manaquelle und des heilenden Flusses um 5%.",
    "Erhöht den Effekt Eurer Totems der Manaquelle und des heilenden Flusses um 10%.",
    "Erhöht den Effekt Eurer Totems der Manaquelle und des heilenden Flusses um 15%.",
    "Erhöht den Effekt Eurer Totems der Manaquelle und des heilenden Flusses um 20%.",
    "Erhöht den Effekt Eurer Totems der Manaquelle und des heilenden Flusses um 25%.",
  },
  [104728] = {
    "Beschwört zu Füßen des Zaubernden 12 Sek. lang ein Totem der Manaflut mit 5 Gesundheit, das Gruppenmitgliedern im Umkreis von 20 Metern alle 3 Sek. 170 Mana wiederherstellt.",
  },
  [104727] = {
    "Eure Zauber Welle der Heilung haben eine Chance von 33%, die Wirkung nachfolgender Zauber Welle der Heilung auf diesem Ziel 15 Sek. lang um 6% zu erhöhen. Dieser Effekt ist bis zu 3-mal stapelbar.",
    "Eure Zauber Welle der Heilung haben eine Chance von 66%, die Wirkung nachfolgender Zauber Welle der Heilung auf diesem Ziel 15 Sek. lang um 6% zu erhöhen. Dieser Effekt ist bis zu 3-mal stapelbar.",
    "Eure Zauber Welle der Heilung haben eine Chance von 100%, die Wirkung nachfolgender Zauber Welle der Heilung auf diesem Ziel 15 Sek. lang um 6% zu erhöhen. Dieser Effekt ist bis zu 3-mal stapelbar.",
  },
  [105814] = {
    "Verringert die Chance des Gegners, Euren Arkanzaubern zu widerstehen, um 2%.",
    "Verringert die Chance des Gegners, Euren Arkanzaubern zu widerstehen, um 4%.",
    "Verringert die Chance des Gegners, Euren Arkanzaubern zu widerstehen, um 6%.",
    "Verringert die Chance des Gegners, Euren Arkanzaubern zu widerstehen, um 8%.",
    "Verringert die Chance des Gegners, Euren Arkanzaubern zu widerstehen, um 10%.",
  },
  [105813] = {
    "Gewährt Euch eine Chance von 20%, beim Kanalisieren von Arkane Geschosse keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 40%, beim Kanalisieren von Arkane Geschosse keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 60%, beim Kanalisieren von Arkane Geschosse keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 80%, beim Kanalisieren von Arkane Geschosse keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 100%, beim Kanalisieren von Arkane Geschosse keine Unterbrechung durch erlittenen Schaden zu erleiden.",
  },
  [105812] = {
    "Verringert den Widerstand Eures Ziels gegen alle Eure Zauber um 5 und die durch Eure Arkanzauber erzeugte Bedrohung um 20%.",
    "Verringert den Widerstand Eures Ziels gegen alle Eure Zauber um 10 und die durch Eure Arkanzauber erzeugte Bedrohung um 40%.",
  },
  [105811] = {
    "Erhöht alle Widerstände um 2 und lässt jeden vollständig widerstandenen Zauber 1% Eures gesamten Manas wiederherstellen. 1 Sek. Abklingzeit.",
    "Erhöht alle Widerstände um 4 und lässt jeden vollständig widerstandenen Zauber 2% Eures gesamten Manas wiederherstellen. 1 Sek. Abklingzeit.",
    "Erhöht alle Widerstände um 6 und lässt jeden vollständig widerstandenen Zauber 3% Eures gesamten Manas wiederherstellen. 1 Sek. Abklingzeit.",
    "Erhöht alle Widerstände um 8 und lässt jeden vollständig widerstandenen Zauber 4% Eures gesamten Manas wiederherstellen. 1 Sek. Abklingzeit.",
    "Erhöht alle Widerstände um 10 und lässt jeden vollständig widerstandenen Zauber 5% Eures gesamten Manas wiederherstellen. 1 Sek. Abklingzeit.",
  },
  [105809] = {
    "Erhöht Eure Rüstung um einen Wert in Höhe von 50% Eurer Intelligenz.",
  },
  [105808] = {
    "Erhöht den Effekt Eurer Zauber Magie verstärken und Magie dämpfen um 25%.",
    "Erhöht den Effekt Eurer Zauber Magie verstärken und Magie dämpfen um 50%.",
  },
  [105807] = {
    "Erhöht die kritische Trefferchance Eures Zaubers Arkane Explosion um zusätzlich 2%.",
    "Erhöht die kritische Trefferchance Eures Zaubers Arkane Explosion um zusätzlich 4%.",
    "Erhöht die kritische Trefferchance Eures Zaubers Arkane Explosion um zusätzlich 6%.",
  },
  [105805] = {
    "Verringert das pro erlittenem Schadenspunkt verlorene Mana bei aktivem Manaschild um 10%.",
    "Verringert das pro erlittenem Schadenspunkt verlorene Mana bei aktivem Manaschild um 20%.",
  },
  [105804] = {
    "Gewährt Eurem Gegenzauber eine Chance von 50%, das Ziel 4 Sek. lang zum Schweigen zu bringen.",
    "Gewährt Eurem Gegenzauber eine Chance von 100%, das Ziel 4 Sek. lang zum Schweigen zu bringen.",
  },
  [105803] = {
    "Ermöglicht, dass 5% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
    "Ermöglicht, dass 10% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
    "Ermöglicht, dass 15% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
  },
  [105800] = {
    "Erhöht Euer maximales Mana um 2%.",
    "Erhöht Euer maximales Mana um 4%.",
    "Erhöht Euer maximales Mana um 6%.",
    "Erhöht Euer maximales Mana um 8%.",
    "Erhöht Euer maximales Mana um 10%.",
  },
  [105799] = {
    "Erhöht Euren Zauberschaden und Eure kritische Trefferchance um 1%.",
    "Erhöht Euren Zauberschaden und Eure kritische Trefferchance um 2%.",
    "Erhöht Euren Zauberschaden und Eure kritische Trefferchance um 3%.",
  },
  [105798] = {
    "Bei Aktivierung verursachen Eure Zauber 30% mehr Schaden, kosten aber 30% mehr Mana. Dieser Effekt hält 15 Sek. lang an.",
  },
  [105797] = {
    "Verringert die Abklingzeit Eures Zaubers Feuerschlag um 0.5 Sek.",
    "Verringert die Abklingzeit Eures Zaubers Feuerschlag um 1 Sek.",
    "Verringert die Abklingzeit Eures Zaubers Feuerschlag um 1.5 Sek.",
  },
  [105796] = {
    "Erhöht die kritische Trefferchance Eurer Zauber Feuerschlag und Versengen um 2%.",
    "Erhöht die kritische Trefferchance Eurer Zauber Feuerschlag und Versengen um 4%.",
  },
  [105795] = {
    "Verringert die Zauberzeit Eures Zaubers Feuerball um 0.1 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Feuerball um 0.2 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Feuerball um 0.3 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Feuerball um 0.4 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Feuerball um 0.5 Sek.",
  },
  [105792] = {
    "Gewährt Euren Feuerzaubern eine Chance von 2%, das Ziel 2 Sek. lang zu betäuben.",
    "Gewährt Euren Feuerzaubern eine Chance von 4%, das Ziel 2 Sek. lang zu betäuben.",
    "Gewährt Euren Feuerzaubern eine Chance von 6%, das Ziel 2 Sek. lang zu betäuben.",
    "Gewährt Euren Feuerzaubern eine Chance von 8%, das Ziel 2 Sek. lang zu betäuben.",
    "Gewährt Euren Feuerzaubern eine Chance von 10%, das Ziel 2 Sek. lang zu betäuben.",
  },
  [105789] = {
    "Gewährt Euren Feuerzaubern eine Chance von 35%, bei erlittenem Schaden keine Zauberzeit zu verlieren, und verringert die durch Eure Feuerzauber erzeugte Bedrohung um 15%.",
    "Gewährt Euren Feuerzaubern eine Chance von 70%, bei erlittenem Schaden keine Zauberzeit zu verlieren, und verringert die durch Eure Feuerzauber erzeugte Bedrohung um 30%.",
  },
  [105790] = {
    "Schleudert einen gewaltigen, brennenden Felsbrocken, der 149 bis 195 Feuerschaden und im Verlauf von 12 Sek. zusätzlich 56 Feuerschaden verursacht.",
  },
  [105788] = {
    "Eure Zauber Versengen haben eine Chance von 33%, Euer Ziel für Feuerschaden verwundbar zu machen. Diese Verwundbarkeit erhöht den Feuerschaden am Ziel um 3% und hält 30 Sek. lang an. Bis zu 5-mal stapelbar.",
    "Eure Zauber Versengen haben eine Chance von 66%, Euer Ziel für Feuerschaden verwundbar zu machen. Diese Verwundbarkeit erhöht den Feuerschaden am Ziel um 3% und hält 30 Sek. lang an. Bis zu 5-mal stapelbar.",
    "Eure Zauber Versengen haben eine Chance von 100%, Euer Ziel für Feuerschaden verwundbar zu machen. Diese Verwundbarkeit erhöht den Feuerschaden am Ziel um 3% und hält 30 Sek. lang an. Bis zu 5-mal stapelbar.",
  },
  [105785] = {
    "Kritische Treffer Eurer Feuer- und Frostzauber erstatten 10% ihrer Grundmanakosten zurück.",
    "Kritische Treffer Eurer Feuer- und Frostzauber erstatten 20% ihrer Grundmanakosten zurück.",
    "Kritische Treffer Eurer Feuer- und Frostzauber erstatten 30% ihrer Grundmanakosten zurück.",
  },
  [105783] = {
    "Eine Flammenwelle breitet sich vom Zaubernden aus, fügt allen Gegnern in der Explosion 160 bis 192 Feuerschaden zu und macht sie 6 Sek. lang benommen.",
  },
  [105781] = {
    "Bei Aktivierung erhöht jeder Treffer Eurer Feuerschadenszauber Eure kritische Trefferchance mit Feuerschadenszaubern um 10%. Dieser Effekt hält an, bis Ihr 3 kritische Treffer mit Feuerzaubern erzielt habt.",
  },
  [105780] = {
    "Erhöht die Rüstung und die Widerstände Eurer Zauber Frostrüstung und Eisrüstung um 15%. Außerdem gewährt er Eurem Frostzauberschutz, solange aktiv, eine Chance von 10%, Frostzauber und -effekte zurückzuwerfen.",
    "Erhöht die Rüstung und die Widerstände Eurer Zauber Frostrüstung und Eisrüstung um 30%. Außerdem gewährt er Eurem Frostzauberschutz, solange aktiv, eine Chance von 20%, Frostzauber und -effekte zurückzuwerfen.",
  },
  [105778] = {
    "Verringert die Chance des Gegners, Euren Frost- und Feuerzaubern zu widerstehen, um 2%.",
    "Verringert die Chance des Gegners, Euren Frost- und Feuerzaubern zu widerstehen, um 4%.",
    "Verringert die Chance des Gegners, Euren Frost- und Feuerzaubern zu widerstehen, um 6%.",
  },
  [105776] = {
    "Erhöht die Dauer Eurer Kälteeffekte um 1 Sek. und verringert das Tempo des Ziels um zusätzlich 4%.",
    "Erhöht die Dauer Eurer Kälteeffekte um 2 Sek. und verringert das Tempo des Ziels um zusätzlich 7%.",
    "Erhöht die Dauer Eurer Kälteeffekte um 3 Sek. und verringert das Tempo des Ziels um zusätzlich 10%.",
  },
  [105774] = {
    "Gewährt Euren Kälteeffekten eine Chance von 5%, das Ziel 5 Sek. lang einzufrieren.",
    "Gewährt Euren Kälteeffekten eine Chance von 10%, das Ziel 5 Sek. lang einzufrieren.",
    "Gewährt Euren Kälteeffekten eine Chance von 15%, das Ziel 5 Sek. lang einzufrieren.",
  },
  [105771] = {
    "Fügt Eurem Zauber Blizzard einen Kälteeffekt hinzu. Dieser Effekt verringert das Bewegungstempo des Ziels um 30%. Hält 1,5 Sek. lang an.",
    "Fügt Eurem Zauber Blizzard einen Kälteeffekt hinzu. Dieser Effekt verringert das Bewegungstempo des Ziels um 50%. Hält 1,5 Sek. lang an.",
    "Fügt Eurem Zauber Blizzard einen Kälteeffekt hinzu. Dieser Effekt verringert das Bewegungstempo des Ziels um 65%. Hält 1,5 Sek. lang an.",
  },
  [105769] = {
    "Ihr werdet in einen Eisblock eingeschlossen, der Euch 10 Sek. lang vor allen körperlichen Angriffen und Zaubern schützt. In dieser Zeit könnt Ihr weder angreifen noch Euch bewegen oder zaubern.",
  },
  [105768] = {
    "Erhöht die kritische Trefferchance aller Eurer Zauber gegen eingefrorene Ziele um 10%.",
    "Erhöht die kritische Trefferchance aller Eurer Zauber gegen eingefrorene Ziele um 20%.",
    "Erhöht die kritische Trefferchance aller Eurer Zauber gegen eingefrorene Ziele um 30%.",
    "Erhöht die kritische Trefferchance aller Eurer Zauber gegen eingefrorene Ziele um 40%.",
    "Erhöht die kritische Trefferchance aller Eurer Zauber gegen eingefrorene Ziele um 50%.",
  },
  [105765] = {
    "Erhöht den Schaden Eures Zaubers Kältekegel um 15%.",
    "Erhöht den Schaden Eures Zaubers Kältekegel um 25%.",
    "Erhöht den Schaden Eures Zaubers Kältekegel um 35%.",
  },
  [105766] = {
    "Bei Aktivierung beendet dieser Zauber sofort die Abklingzeit aller Eurer Frostzauber.",
  },
  [105763] = {
    "Gewährt Euren Frostschadenszaubern eine Chance von 20%, den Effekt Winterkälte anzuwenden, der die Chance eines Frostzaubers auf einen kritischen Treffer am Ziel 15 Sek. lang um 2% erhöht. Bis zu 5-mal stapelbar.",
    "Gewährt Euren Frostschadenszaubern eine Chance von 40%, den Effekt Winterkälte anzuwenden, der die Chance eines Frostzaubers auf einen kritischen Treffer am Ziel 15 Sek. lang um 2% erhöht. Bis zu 5-mal stapelbar.",
    "Gewährt Euren Frostschadenszaubern eine Chance von 60%, den Effekt Winterkälte anzuwenden, der die Chance eines Frostzaubers auf einen kritischen Treffer am Ziel 15 Sek. lang um 2% erhöht. Bis zu 5-mal stapelbar.",
    "Gewährt Euren Frostschadenszaubern eine Chance von 80%, den Effekt Winterkälte anzuwenden, der die Chance eines Frostzaubers auf einen kritischen Treffer am Ziel 15 Sek. lang um 2% erhöht. Bis zu 5-mal stapelbar.",
    "Gewährt Euren Frostschadenszaubern eine Chance von 100%, den Effekt Winterkälte anzuwenden, der die Chance eines Frostzaubers auf einen kritischen Treffer am Ziel 15 Sek. lang um 2% erhöht. Bis zu 5-mal stapelbar.",
  },
  [105762] = {
    "Schirmt Euch sofort ab und absorbiert 455 Schaden. Hält 1 Min. lang an. Solange der Schild hält, werden Zauber nicht unterbrochen.",
  },
  [105925] = {
    "Verringert die Chance von Gegnern, Euren Gebrechenszaubern zu widerstehen, um 2%.",
    "Verringert die Chance von Gegnern, Euren Gebrechenszaubern zu widerstehen, um 4%.",
    "Verringert die Chance von Gegnern, Euren Gebrechenszaubern zu widerstehen, um 6%.",
    "Verringert die Chance von Gegnern, Euren Gebrechenszaubern zu widerstehen, um 8%.",
    "Verringert die Chance von Gegnern, Euren Gebrechenszaubern zu widerstehen, um 10%.",
  },
  [105924] = {
    "Verringert die Zauberzeit Eures Zaubers Verderbnis um 0,4 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Verderbnis um 0,8 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Verderbnis um 1,2 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Verderbnis um 1,6 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Verderbnis um 2 Sek.",
  },
  [105919] = {
    "Erhöht den Schaden Eures Fluchs der Pein um 2%.",
    "Erhöht den Schaden Eures Fluchs der Pein um 4%.",
    "Erhöht den Schaden Eures Fluchs der Pein um 6%.",
  },
  [105918] = {
    "Gewährt Euch eine Chance von 14%, beim Kanalisieren von Blutsauger, Mana entziehen oder Seelendieb keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 28%, beim Kanalisieren von Blutsauger, Mana entziehen oder Seelendieb keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 42%, beim Kanalisieren von Blutsauger, Mana entziehen oder Seelendieb keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 56%, beim Kanalisieren von Blutsauger, Mana entziehen oder Seelendieb keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 70%, beim Kanalisieren von Blutsauger, Mana entziehen oder Seelendieb keine Unterbrechung durch erlittenen Schaden zu erleiden.",
  },
  [105916] = {
    "Erhöht den Effekt Eures nächsten Fluchs der Schwäche oder Fluchs der Pein um 50% oder Eures nächsten Fluchs der Erschöpfung um 20%. Hält 30 Sek. lang an.",
  },
  [105914] = {
    "Gewährt Euren Zaubern Verderbnis und Blutsauger eine Chance von 2%, Euch nach Schaden am Gegner in den Zustand Schattentrance zu versetzen. Schattentrance verringert die Zauberzeit Eures nächsten Schattenblitzes um 100%.",
    "Gewährt Euren Zaubern Verderbnis und Blutsauger eine Chance von 4%, Euch nach Schaden am Gegner in den Zustand Schattentrance zu versetzen. Schattentrance verringert die Zauberzeit Eures nächsten Schattenblitzes um 100%.",
  },
  [105913] = {
    "Verringert das Bewegungstempo des Ziels 12 Sek. lang um 10%. Pro Hexenmeister kann auf einem Ziel jeweils nur ein Fluch aktiv sein.",
  },
  [105912] = {
    "Überträgt alle 3 Sek. 15 Gesundheit vom Ziel auf den Zaubernden. Hält 30 Sek. lang an.",
  },
  [105911] = {
    "Erhöht die von Eurem Zauber Blutsauger entzogene Gesundheit um 2%.",
    "Erhöht die von Eurem Zauber Blutsauger entzogene Gesundheit um 4%.",
    "Erhöht die von Eurem Zauber Blutsauger entzogene Gesundheit um 6%.",
    "Erhöht die von Eurem Zauber Blutsauger entzogene Gesundheit um 8%.",
    "Erhöht die von Eurem Zauber Blutsauger entzogene Gesundheit um 10%.",
  },
  [105910] = {
    "Erhöht den Schaden oder die entzogene Gesundheit Eurer Schattenzauber um 2%.",
    "Erhöht den Schaden oder die entzogene Gesundheit Eurer Schattenzauber um 4%.",
    "Erhöht den Schaden oder die entzogene Gesundheit Eurer Schattenzauber um 6%.",
    "Erhöht den Schaden oder die entzogene Gesundheit Eurer Schattenzauber um 8%.",
    "Erhöht den Schaden oder die entzogene Gesundheit Eurer Schattenzauber um 10%.",
  },
  [105905] = {
    "Erhöht die durch Euren Zauber Aderlass übertragene Gesundheit um 10%.",
    "Erhöht die durch Euren Zauber Aderlass übertragene Gesundheit um 20%.",
  },
  [105908] = {
    "Erhöht den Effekt der Zauber Feuerblitz, Feuerschild und Blutpakt Eures Wichtels um 10%.",
    "Erhöht den Effekt der Zauber Feuerblitz, Feuerschild und Blutpakt Eures Wichtels um 20%.",
    "Erhöht den Effekt der Zauber Feuerblitz, Feuerschild und Blutpakt Eures Wichtels um 30%.",
  },
  [105907] = {
    "Erhöht Eure gesamte Ausdauer um 3%, verringert aber Eure gesamte Willenskraft um 1%.",
    "Erhöht Eure gesamte Ausdauer um 6%, verringert aber Eure gesamte Willenskraft um 2%.",
    "Erhöht Eure gesamte Ausdauer um 9%, verringert aber Eure gesamte Willenskraft um 3%.",
    "Erhöht Eure gesamte Ausdauer um 12%, verringert aber Eure gesamte Willenskraft um 4%.",
    "Erhöht Eure gesamte Ausdauer um 15%, verringert aber Eure gesamte Willenskraft um 5%.",
  },
  [105906] = {
    "Erhöht den Nahkampfschaden Eures Leerwandlers, Eures Sukkubus, Eures Inkubus und Eures Teufelsjägers um 4%.",
    "Erhöht den Nahkampfschaden Eures Leerwandlers, Eures Sukkubus, Eures Inkubus und Eures Teufelsjägers um 8%.",
    "Erhöht den Nahkampfschaden Eures Leerwandlers, Eures Sukkubus, Eures Inkubus und Eures Teufelsjägers um 12%.",
    "Erhöht den Nahkampfschaden Eures Leerwandlers, Eures Sukkubus, Eures Inkubus und Eures Teufelsjägers um 16%.",
    "Erhöht den Nahkampfschaden Eures Leerwandlers, Eures Sukkubus, Eures Inkubus und Eures Teufelsjägers um 20%.",
  },
  [105904] = {
    "Erhöht die Wirksamkeit der Zauber Qual, Schatten verzehren, Opferung und Leiden Eures Leerwandlers um 10%.",
    "Erhöht die Wirksamkeit der Zauber Qual, Schatten verzehren, Opferung und Leiden Eures Leerwandlers um 20%.",
    "Erhöht die Wirksamkeit der Zauber Qual, Schatten verzehren, Opferung und Leiden Eures Leerwandlers um 30%.",
  },
  [105903] = {
    "Erhöht das maximale Mana Eures Wichtels, Leerwandlers, Sukkubus, Inkubus und Teufelsjägers um 3%.",
    "Erhöht das maximale Mana Eures Wichtels, Leerwandlers, Sukkubus, Inkubus und Teufelsjägers um 6%.",
    "Erhöht das maximale Mana Eures Wichtels, Leerwandlers, Sukkubus, Inkubus und Teufelsjägers um 9%.",
    "Erhöht das maximale Mana Eures Wichtels, Leerwandlers, Sukkubus, Inkubus und Teufelsjägers um 12%.",
    "Erhöht das maximale Mana Eures Wichtels, Leerwandlers, Sukkubus, Inkubus und Teufelsjägers um 15%.",
  },
  [105900] = {
    "Opfert bei Aktivierung Euren beschworenen Dämon und gewährt Euch einen Effekt, der 30 Min. lang anhält. Der Effekt endet, sobald ein Dämon beschworen wird.\n\nWichtel: Erhöht Euren Feuerschaden um 15%.\n\nLeerwandler: Stellt alle 4 Sek. 3% der gesamten Gesundheit wieder her.\n\nSukkubus/Inkubus: Erhöht Euren Schattenschaden um 15%.\n\nTeufelsjäger: Stellt alle 4 Sek. 2% des gesamten Manas wieder her.",
  },
  [105892] = {
    "Solange aktiv, erleidet Euer Dämon (Wichtel, Leerwandler, Sukkubus, Inkubus oder Teufelsjäger) 30% des gesamten Schadens, den der Zaubernde erleidet. Außerdem verursachen Dämon und Meister beide 3% mehr Schaden. Hält an, solange der Dämon aktiv ist.",
  },
  [105891] = {
    "Gewährt dem Hexenmeister und dem beschworenen Dämon einen Effekt, solange der Dämon aktiv ist. Wichtel: Verringert die erzeugte Bedrohung um 4%. Leerwandler: Verringert den erlittenen körperlichen Schaden um 2%. Sukkubus/Inkubus: Erhöht jeglichen verursachten Schaden um 2%. Teufelsjäger: Erhöht alle Widerstände um 2 pro Stufe.",
    "Gewährt dem Hexenmeister und dem beschworenen Dämon einen Effekt, solange der Dämon aktiv ist. Wichtel: Verringert die erzeugte Bedrohung um 8%. Leerwandler: Verringert den erlittenen körperlichen Schaden um 4%. Sukkubus/Inkubus: Erhöht jeglichen verursachten Schaden um 4%. Teufelsjäger: Erhöht alle Widerstände um 4 pro Stufe.",
    "Gewährt dem Hexenmeister und dem beschworenen Dämon einen Effekt, solange der Dämon aktiv ist. Wichtel: Verringert die erzeugte Bedrohung um 12%. Leerwandler: Verringert den erlittenen körperlichen Schaden um 6%. Sukkubus/Inkubus: Erhöht jeglichen verursachten Schaden um 6%. Teufelsjäger: Erhöht alle Widerstände um 6 pro Stufe.",
    "Gewährt dem Hexenmeister und dem beschworenen Dämon einen Effekt, solange der Dämon aktiv ist. Wichtel: Verringert die erzeugte Bedrohung um 16%. Leerwandler: Verringert den erlittenen körperlichen Schaden um 8%. Sukkubus/Inkubus: Erhöht jeglichen verursachten Schaden um 8%. Teufelsjäger: Erhöht alle Widerstände um 8 pro Stufe.",
    "Gewährt dem Hexenmeister und dem beschworenen Dämon einen Effekt, solange der Dämon aktiv ist. Wichtel: Verringert die erzeugte Bedrohung um 20%. Leerwandler: Verringert den erlittenen körperlichen Schaden um 10%. Sukkubus/Inkubus: Erhöht jeglichen verursachten Schaden um 10%. Teufelsjäger: Erhöht alle Widerstände um 1 pro Stufe.",
  },
  [105881] = {
    "Erhöht die Reichweite Eurer Zerstörungszauber um 10%.",
    "Erhöht die Reichweite Eurer Zerstörungszauber um 20%.",
  },
  [105889] = {
    "Eure kritischen Treffer mit Schattenblitz erhöhen den Schattenschaden am Ziel um 4%, bis 4 nicht-periodische Schadensquellen angewendet wurden. Der Effekt hält höchstens 12 Sek. lang an.",
    "Eure kritischen Treffer mit Schattenblitz erhöhen den Schattenschaden am Ziel um 8%, bis 4 nicht-periodische Schadensquellen angewendet wurden. Der Effekt hält höchstens 12 Sek. lang an.",
    "Eure kritischen Treffer mit Schattenblitz erhöhen den Schattenschaden am Ziel um 12%, bis 4 nicht-periodische Schadensquellen angewendet wurden. Der Effekt hält höchstens 12 Sek. lang an.",
    "Eure kritischen Treffer mit Schattenblitz erhöhen den Schattenschaden am Ziel um 16%, bis 4 nicht-periodische Schadensquellen angewendet wurden. Der Effekt hält höchstens 12 Sek. lang an.",
    "Eure kritischen Treffer mit Schattenblitz erhöhen den Schattenschaden am Ziel um 20%, bis 4 nicht-periodische Schadensquellen angewendet wurden. Der Effekt hält höchstens 12 Sek. lang an.",
  },
  [105888] = {
    "Verringert die Zauberzeit Eurer Zauber Schattenblitz und Feuerbrand um 0,1 Sek. und die Eures Zaubers Seelenfeuer um 0,4 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Schattenblitz und Feuerbrand um 0,2 Sek. und die Eures Zaubers Seelenfeuer um 0,8 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Schattenblitz und Feuerbrand um 0,3 Sek. und die Eures Zaubers Seelenfeuer um 1,2 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Schattenblitz und Feuerbrand um 0,4 Sek. und die Eures Zaubers Seelenfeuer um 1,6 Sek.",
    "Verringert die Zauberzeit Eurer Zauber Schattenblitz und Feuerbrand um 0,5 Sek. und die Eures Zaubers Seelenfeuer um 2 Sek.",
  },
  [105887] = {
    "Verringert die Manakosten Eurer Zerstörungszauber um 1%.",
    "Verringert die Manakosten Eurer Zerstörungszauber um 2%.",
    "Verringert die Manakosten Eurer Zerstörungszauber um 3%.",
    "Verringert die Manakosten Eurer Zerstörungszauber um 4%.",
    "Verringert die Manakosten Eurer Zerstörungszauber um 5%.",
  },
  [105886] = {
    "Gewährt Euren Zerstörungszaubern eine Chance von 2%, das Ziel 5 Sek. lang benommen zu machen.",
    "Gewährt Euren Zerstörungszaubern eine Chance von 4%, das Ziel 5 Sek. lang benommen zu machen.",
    "Gewährt Euren Zerstörungszaubern eine Chance von 6%, das Ziel 5 Sek. lang benommen zu machen.",
    "Gewährt Euren Zerstörungszaubern eine Chance von 8%, das Ziel 5 Sek. lang benommen zu machen.",
    "Gewährt Euren Zerstörungszaubern eine Chance von 10%, das Ziel 5 Sek. lang benommen zu machen.",
  },
  [105883] = {
    "Erhöht den kritischen Schadensbonus Eurer Zerstörungszauber um 100%.",
  },
  [105884] = {
    "Trifft das Ziel sofort mit 92 bis 104 Schattenschaden. Stirbt das Ziel innerhalb von 5 Sek. nach Schattenbrand und gewährt Erfahrung oder Ehre, erhält der Zaubernde einen Seelensplitter.",
  },
  [105882] = {
    "Gewährt Euch eine Chance von 35%, beim Kanalisieren von Feuerregen, Höllenfeuer oder Seelenfeuer einer Unterbrechung durch erlittenen Schaden zu widerstehen.",
    "Gewährt Euch eine Chance von 70%, beim Kanalisieren von Feuerregen, Höllenfeuer oder Seelenfeuer einer Unterbrechung durch erlittenen Schaden zu widerstehen.",
  },
  [105879] = {
    "Erhöht die kritische Trefferchance Eures Zaubers Sengender Schmerz um 2%.",
    "Erhöht die kritische Trefferchance Eures Zaubers Sengender Schmerz um 4%.",
    "Erhöht die kritische Trefferchance Eures Zaubers Sengender Schmerz um 6%.",
    "Erhöht die kritische Trefferchance Eures Zaubers Sengender Schmerz um 8%.",
    "Erhöht die kritische Trefferchance Eures Zaubers Sengender Schmerz um 10%.",
  },
  [105880] = {
    "Entzündet ein bereits von Feuerbrand betroffenes Ziel, verursacht 250 bis 316 Feuerschaden und verbraucht den Zauber Feuerbrand.",
  },
  [105878] = {
    "Gewährt Euren Zaubern Feuerregen, Höllenfeuer und Seelenfeuer eine Chance von 13%, das Ziel 3 Sek. lang zu betäuben.",
    "Gewährt Euren Zaubern Feuerregen, Höllenfeuer und Seelenfeuer eine Chance von 26%, das Ziel 3 Sek. lang zu betäuben.",
  },
  [104923] = {
    "Verringert die Zauberzeit Eures Zaubers Zorn um 0.1 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Zorn um 0.2 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Zorn um 0.3 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Zorn um 0.4 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Zorn um 0.5 Sek.",
  },
  [104925] = {
    "Verringert die Manakosten Eurer Zauber Mondfeuer, Sternenfeuer, Zorn, Heilende Berührung, Nachwachsen und Verjüngung um 3%.",
    "Verringert die Manakosten Eurer Zauber Mondfeuer, Sternenfeuer, Zorn, Heilende Berührung, Nachwachsen und Verjüngung um 6%.",
    "Verringert die Manakosten Eurer Zauber Mondfeuer, Sternenfeuer, Zorn, Heilende Berührung, Nachwachsen und Verjüngung um 9%.",
  },
  [104931] = {
    "Erhöht den Schaden und die kritische Trefferchance Eures Zaubers Mondfeuer um 2%.",
    "Erhöht den Schaden und die kritische Trefferchance Eures Zaubers Mondfeuer um 4%.",
    "Erhöht den Schaden und die kritische Trefferchance Eures Zaubers Mondfeuer um 6%.",
    "Erhöht den Schaden und die kritische Trefferchance Eures Zaubers Mondfeuer um 8%.",
    "Erhöht den Schaden und die kritische Trefferchance Eures Zaubers Mondfeuer um 10%.",
  },
  [104929] = {
    "Erhöht die Reichweite Eurer Zauber Zorn, Wucherwurzeln, Feenfeuer, Mondfeuer, Sternenfeuer und Hurrikan um 10%.",
    "Erhöht die Reichweite Eurer Zauber Zorn, Wucherwurzeln, Feenfeuer, Mondfeuer, Sternenfeuer und Hurrikan um 20%.",
  },
  [104926] = {
    "Gewährt Euch eine Chance von 40%, beim Wirken von Wucherwurzeln keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 70%, beim Wirken von Wucherwurzeln keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 100%, beim Wirken von Wucherwurzeln keine Unterbrechung durch erlittenen Schaden zu erleiden.",
  },
  [104930] = {
    "Das feindliche Ziel wird von Insekten umschwärmt, was seine Trefferchance um 2% verringert und im Verlauf von 12 Sek. 66 Naturschaden verursacht.",
  },
  [104932] = {
    "Erhöht den kritischen Schadensbonus Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 20%.",
    "Erhöht den kritischen Schadensbonus Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 40%.",
    "Erhöht den kritischen Schadensbonus Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 60%.",
    "Erhöht den kritischen Schadensbonus Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 80%.",
    "Erhöht den kritischen Schadensbonus Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 100%.",
  },
  [104933] = {
    "Verringert die Zauberzeit von Sternenfeuer um 0.1 Sek. und gewährt eine Chance von 3%, das Ziel 3 Sek. lang zu betäuben.",
    "Verringert die Zauberzeit von Sternenfeuer um 0.2 Sek. und gewährt eine Chance von 6%, das Ziel 3 Sek. lang zu betäuben.",
    "Verringert die Zauberzeit von Sternenfeuer um 0.3 Sek. und gewährt eine Chance von 9%, das Ziel 3 Sek. lang zu betäuben.",
    "Verringert die Zauberzeit von Sternenfeuer um 0.4 Sek. und gewährt eine Chance von 12%, das Ziel 3 Sek. lang zu betäuben.",
    "Verringert die Zauberzeit von Sternenfeuer um 0.5 Sek. und gewährt eine Chance von 15%, das Ziel 3 Sek. lang zu betäuben.",
  },
  [110844] = {
    "Erhöht die Chance Eures Griffs der Natur, einen Gegner zu umschlingen, um 15%.",
    "Erhöht die Chance Eures Griffs der Natur, einen Gegner zu umschlingen, um 30%.",
    "Erhöht die Chance Eures Griffs der Natur, einen Gegner zu umschlingen, um 45%.",
    "Erhöht die Chance Eures Griffs der Natur, einen Gegner zu umschlingen, um 65%.",
  },
  [104934] = {
    "Nach einem kritischen Treffer mit einem Zauber erhaltet Ihr einen Segen der Natur, der die Zauberzeit Eures nächsten Zaubers um 0,5 Sek. verringert.",
  },
  [104936] = {
    "Erhöht den Schaden Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 2%.",
    "Erhöht den Schaden Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 4%.",
    "Erhöht den Schaden Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 6%.",
    "Erhöht den Schaden Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 8%.",
    "Erhöht den Schaden Eurer Zauber Sternenfeuer, Mondfeuer und Zorn um 10%.",
  },
  [104937] = {
    "Verwandelt den Druiden in Mondkingestalt. In dieser Gestalt ist der Rüstungsbeitrag von Gegenständen um 360% erhöht, und alle Gruppenmitglieder im Umkreis von 30 Metern erhalten eine um 3% erhöhte kritische Zaubertrefferchance. Der Mondkin kann in dieser Gestalt nur Gleichgewichtszauber wirken.\n\nDer Gestaltwandel befreit den Zaubernden von Verwandlung und bewegungseinschränkenden Effekten.",
  },
  [104938] = {
    "Verringert die Kosten Eurer Fähigkeiten Zerfleischen, Prankenhieb, Klaue und Krallenhieb um 1 Wut oder Energie.",
    "Verringert die Kosten Eurer Fähigkeiten Zerfleischen, Prankenhieb, Klaue und Krallenhieb um 2 Wut oder Energie.",
    "Verringert die Kosten Eurer Fähigkeiten Zerfleischen, Prankenhieb, Klaue und Krallenhieb um 3 Wut oder Energie.",
    "Verringert die Kosten Eurer Fähigkeiten Zerfleischen, Prankenhieb, Klaue und Krallenhieb um 4 Wut oder Energie.",
    "Verringert die Kosten Eurer Fähigkeiten Zerfleischen, Prankenhieb, Klaue und Krallenhieb um 5 Wut oder Energie.",
  },
  [104939] = {
    "Erhöht Eure Intelligenz um 4%. Außerdem ist in Bären- oder Terrorbärengestalt Eure Ausdauer um 4% und in Katzengestalt Eure Stärke um 4% erhöht.",
    "Erhöht Eure Intelligenz um 8%. Außerdem ist in Bären- oder Terrorbärengestalt Eure Ausdauer um 8% und in Katzengestalt Eure Stärke um 8% erhöht.",
    "Erhöht Eure Intelligenz um 12%. Außerdem ist in Bären- oder Terrorbärengestalt Eure Ausdauer um 12% und in Katzengestalt Eure Stärke um 12% erhöht.",
    "Erhöht Eure Intelligenz um 16%. Außerdem ist in Bären- oder Terrorbärengestalt Eure Ausdauer um 16% und in Katzengestalt Eure Stärke um 16% erhöht.",
    "Erhöht Eure Intelligenz um 20%. Außerdem ist in Bären- oder Terrorbärengestalt Eure Ausdauer um 20% und in Katzengestalt Eure Stärke um 20% erhöht.",
  },
  [104943] = {
    "Erhöht Euer Bewegungstempo im Freien in Katzengestalt um 15% und Eure Ausweichchance in Katzengestalt um 2%.",
    "Erhöht Euer Bewegungstempo im Freien in Katzengestalt um 30% und Eure Ausweichchance in Katzengestalt um 4%.",
  },
  [104940] = {
    "Erhöht die in Bären- und Terrorbärengestalt erzeugte Bedrohung um 3% und verringert die Chance von Gegnern, Euch beim Schleichen zu entdecken.",
    "Erhöht die in Bären- und Terrorbärengestalt erzeugte Bedrohung um 6% und verringert die Chance von Gegnern, Euch beim Schleichen zu entdecken.",
    "Erhöht die in Bären- und Terrorbärengestalt erzeugte Bedrohung um 9% und verringert die Chance von Gegnern, Euch beim Schleichen zu entdecken.",
    "Erhöht die in Bären- und Terrorbärengestalt erzeugte Bedrohung um 12% und verringert die Chance von Gegnern, Euch beim Schleichen zu entdecken.",
    "Erhöht die in Bären- und Terrorbärengestalt erzeugte Bedrohung um 15% und verringert die Chance von Gegnern, Euch beim Schleichen zu entdecken.",
  },
  [104941] = {
    "Erhöht die Betäubungsdauer Eurer Fähigkeiten Hieb und Anspringen um 0.5 Sek.",
    "Erhöht die Betäubungsdauer Eurer Fähigkeiten Hieb und Anspringen um 1 Sek.",
  },
  [104942] = {
    "Erhöht den Rüstungsbeitrag Eurer Gegenstände um 2%.",
    "Erhöht den Rüstungsbeitrag Eurer Gegenstände um 4%.",
    "Erhöht den Rüstungsbeitrag Eurer Gegenstände um 6%.",
    "Erhöht den Rüstungsbeitrag Eurer Gegenstände um 8%.",
    "Erhöht den Rüstungsbeitrag Eurer Gegenstände um 10%.",
  },
  [104948] = {
    "Erhöht den Schaden Eurer Fähigkeiten Klaue, Krallenhieb, Zerfleischen und Prankenhieb um 10%.",
    "Erhöht den Schaden Eurer Fähigkeiten Klaue, Krallenhieb, Zerfleischen und Prankenhieb um 20%.",
  },
  [104944] = {
    "Lässt Euch einen Gegner anstürmen, macht ihn bewegungsunfähig und unterbricht 4 Sek. lang jeden gewirkten Zauber.",
  },
  [104946] = {
    "Erhöht Eure kritische Trefferchance in Bären-, Terrorbären- oder Katzengestalt um 2%.",
    "Erhöht Eure kritische Trefferchance in Bären-, Terrorbären- oder Katzengestalt um 4%.",
    "Erhöht Eure kritische Trefferchance in Bären-, Terrorbären- oder Katzengestalt um 6%.",
  },
  [104945] = {
    "Verringert die Energiekosten Eurer Fähigkeit Schreddern um 6.",
    "Verringert die Energiekosten Eurer Fähigkeit Schreddern um 12.",
  },
  [104952] = {
    "Erhöht Eure Nahkampfangriffskraft in Katzen-, Bären- und Terrorbärengestalt um 50% Eurer Stufe.",
    "Erhöht Eure Nahkampfangriffskraft in Katzen-, Bären- und Terrorbärengestalt um 100% Eurer Stufe.",
    "Erhöht Eure Nahkampfangriffskraft in Katzen-, Bären- und Terrorbärengestalt um 150% Eurer Stufe.",
  },
  [104947] = {
    "Gewährt Euch eine Chance von 50%, bei jedem kritischen Treffer in Bären- oder Terrorbärengestalt zusätzlich 5 Wut zu erhalten.",
    "Gewährt Euch eine Chance von 100%, bei jedem kritischen Treffer in Bären- oder Terrorbärengestalt zusätzlich 5 Wut zu erhalten.",
  },
  [104955] = {
    "In Katzen-, Bären- oder Terrorbärengestalt erhöht der Rudelführer die kritische Distanz- und Nahkampftrefferchance aller Gruppenmitglieder im Umkreis von 45 Metern um 3%.",
  },
  [104957] = {
    "Gewährt Euch eine Chance von 14%, beim Wirken von Heilende Berührung, Nachwachsen und Gelassenheit keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 28%, beim Wirken von Heilende Berührung, Nachwachsen und Gelassenheit keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 42%, beim Wirken von Heilende Berührung, Nachwachsen und Gelassenheit keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 56%, beim Wirken von Heilende Berührung, Nachwachsen und Gelassenheit keine Unterbrechung durch erlittenen Schaden zu erleiden.",
    "Gewährt Euch eine Chance von 70%, beim Wirken von Heilende Berührung, Nachwachsen und Gelassenheit keine Unterbrechung durch erlittenen Schaden zu erleiden.",
  },
  [104958] = {
    "Gewährt Euch eine Chance von 20%, 10 Wut zu erhalten, wenn Ihr Bären- oder Terrorbärengestalt annehmt, oder 40 Energie, wenn Ihr Katzengestalt annehmt.",
    "Gewährt Euch eine Chance von 40%, 10 Wut zu erhalten, wenn Ihr Bären- oder Terrorbärengestalt annehmt, oder 40 Energie, wenn Ihr Katzengestalt annehmt.",
    "Gewährt Euch eine Chance von 60%, 10 Wut zu erhalten, wenn Ihr Bären- oder Terrorbärengestalt annehmt, oder 40 Energie, wenn Ihr Katzengestalt annehmt.",
    "Gewährt Euch eine Chance von 80%, 10 Wut zu erhalten, wenn Ihr Bären- oder Terrorbärengestalt annehmt, oder 40 Energie, wenn Ihr Katzengestalt annehmt.",
    "Gewährt Euch eine Chance von 100%, 10 Wut zu erhalten, wenn Ihr Bären- oder Terrorbärengestalt annehmt, oder 40 Energie, wenn Ihr Katzengestalt annehmt.",
  },
  [104922] = {
    "Verringert die Zauberzeit Eures Zaubers Heilende Berührung um 0.1 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Heilende Berührung um 0.2 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Heilende Berührung um 0.3 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Heilende Berührung um 0.4 Sek.",
    "Verringert die Zauberzeit Eures Zaubers Heilende Berührung um 0.5 Sek.",
  },
  [104920] = {
    "Verringert die durch Eure Heilzauber erzeugte Bedrohung um 4%.",
    "Verringert die durch Eure Heilzauber erzeugte Bedrohung um 8%.",
    "Verringert die durch Eure Heilzauber erzeugte Bedrohung um 12%.",
    "Verringert die durch Eure Heilzauber erzeugte Bedrohung um 16%.",
    "Verringert die durch Eure Heilzauber erzeugte Bedrohung um 20%.",
  },
  [104917] = {
    "Ermöglicht, dass 5% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
    "Ermöglicht, dass 10% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
    "Ermöglicht, dass 15% Eurer Manaregeneration während des Zauberwirkens weiterlaufen.",
  },
  [104916] = {
    "Erhöht den Effekt aller Eurer Heilzauber um 2%.",
    "Erhöht den Effekt aller Eurer Heilzauber um 4%.",
    "Erhöht den Effekt aller Eurer Heilzauber um 6%.",
    "Erhöht den Effekt aller Eurer Heilzauber um 8%.",
    "Erhöht den Effekt aller Eurer Heilzauber um 10%.",
  },
  [104912] = {
    "Verbraucht einen Verjüngungs- oder Nachwachsen-Effekt auf einem freundlichen Ziel und heilt es sofort um einen Betrag in Höhe von 12 Sek. Verjüngung oder 18 Sek. Nachwachsen.",
  },
  [104909] = {
    "Verringert die durch Gelassenheit erzeugte Bedrohung um 50%.",
    "Verringert die durch Gelassenheit erzeugte Bedrohung um 100%.",
  },
}

-- Quest objectives with no client or Wowhead text (quests to talk to someone or to deliver a provided item), keyed by the French string of Data/Instances.lua. Read by Journal.lua J:QuestView after the client and Data/QuestText.lua.
AF.Content.deDE.objective = {
  ["Sacoche du Totem-Sinistre"] = "Grimmtotemranzen",
  ["Cadavre de Maur Totem-Sinistre"] = "Maur Grimmtotems Leiche",
  ["Traité d’entente (Fourni) (1)"] = "Abkommen des Einvernehmens (Erhalten) (1)",
  ["Parler à Hamuul"] = "Sprecht mit Hamuul",
  ["Parler à Nara"] = "Sprecht mit Nara",
  ["Blason de Lordaeron"] = "Wappen von Lordaeron",
  ["Insigne ensanglanté (Fourni) (10)"] = "Blutverschmierte Insignie (Erhalten) (10)",
  ["Lettre tachée de sang (Fourni) (1)"] = "Blutbefleckter Brief (Erhalten) (1)",
  ["Une lettre qui n'a pas été envoyée. (Fourni) (1)"] = "Ein nicht abgeschickter Brief (Erhalten) (1)",
  ["Deathstalker Adamant"] = "Todespirscher Adamant",
  ["Deathstalker Vincent"] = "Todespirscher Vincent",
  ["Globe d'eau étrange (Fourni) (1)"] = "Seltsame Wasserkugel (Erhalten) (1)",
  ["Anneau sali (Fourni) (1)"] = "Schmutzverkrusteter Ring (Erhalten) (1)",
  ["Petit parchemin (Fourni) (1)"] = "Kleine Rolle (Erhalten) (1)",
  ["Pierre de voeu de Belnistrasz (Fourni) (1)"] = "Belnistrasz' Schwurstein (Erhalten) (1)",
  ["Collier brisé (Fourni) (1)"] = "Zerrissene Halskette (Erhalten) (1)",
  ["Graine de vie (Fourni) (1)"] = "Samenkorn des Lebens (Erhalten) (1)",
  ["Cercle de pierres atal'ai (Fourni) (1)"] = "Steinkreis der Atal'ai (Erhalten) (1)",
  ["Essence d'Eranikus (Fourni) (1)"] = "Essenz von Eranikus (Erhalten) (1)",
  ["Morceau de chair de la Bête luminescent (Fourni) (1)"] = "Stück leuchtendes Fleisch der Bestie (Erhalten) (1)",
  ["Ecaille d'Awbee (Fourni) (1)"] = "Awbees Schuppe (Erhalten) (1)",
  ["Le guide de Nostro du tueur de dragons (Fourni) (1)"] = "Forors Kompendium des Drachentötens (Erhalten) (1)",
  ["Ordres du général Drakkisath (Fourni) (1)"] = "Befehl von General Drakkisath (Erhalten) (1)",
  ["Ecaille de dragon luisante (Fourni) (1)"] = "Gesunde Großdrachenschuppe (Erhalten) (1)",
  ["Tête de Balnazzar (Fourni) (1)"] = "Kopf von Balnazzar (Erhalten) (1)",
  ["Livre du souvenir (Fourni) (1)"] = "Andenken der Erinnerung (Erhalten) (1)",
}

-- Boss names, keyed by the French name of Data/Journal.lua. Read by Names.lua N:BossName. A boss missing here uses its English name.
AF.Content.deDE.npc = {
  -- wowhead forever zone=718 (Cavernes des lamentations). Lady Anacondra, Lord Pythas, Lord Serpentis, Kresh, Skum : nom anglais identique.
  ["Seigneur Cobrahn"] = "Lord Kobrahn",
  ["Mutanus le Dévoreur"] = "Mutanus der Verschlinger",
  ["Verdan l'Immortel"] = "Verdan der Ewiglebende",
  ["Dragon féérique déviant"] = "Deviatfeendrache",
  -- wowhead forever zone=1581 (Les Mortemines). Rhahk'Zor, Sneed, Gilnid, Cookie, Mr. Smite, Captain Greenskin : nom anglais identique.
  ["Edwin VanCleef"] = "Edwin van Cleef",
  ["Déchiqueteur de Sneed"] = "Sneeds Schredder",
  ["Mineur Johnson"] = "Minenarbeiter Johnson",
  -- wowhead forever zone=722 (Souilles de Tranchebauge). Tuten'kash : nom anglais identique.
  ["Mordresh Oeil-de-feu"] = "Mordresh Feuerauge",
  ["Glouton"] = "Nimmersatt",
  ["Amnennar le Porte-froid"] = "Amnennar der Kältebringer",
  ["Pestegueule le Pourrissant"] = "Plaguemaw der Faulende",
  ["Groinfendu"] = "Struppmähne",
  -- wowhead forever zone=2437 (Gouffre de Ragefeu). Bazzalan : nom anglais identique.
  ["Lorgnesilex"] = "Flintauge",
  ["Jergosh l'Invocateur"] = "Jergosh der Herbeirufer",
  ["Taragaman l'Affameur"] = "Taragaman der Hungerleider",
  -- wowhead forever zone=491 (Kraal de Tranchebauge). Roogug, Charlga Razorflank : nom anglais identique.
  ["Aggem Mantépine"] = "Aggem Dornfluch",
  ["Nécrorateur Jargba"] = "Todessprecher Jargba",
  ["Seigneur Brusquebroche"] = "Oberanführer Rammhauer",
  ["Agathelos l'Enragé"] = "Agathelos der Tobende",
  ["Lanceur de Tranchebauge"] = "Speerbalg von Razorfen",
  ["Chasseur aveugle"] = "Blinder Jäger",
  ["Implorateur de la terre Halmgar"] = "Erdenrufer Halmgar",
  -- wowhead forever zone=1337 (Uldaman). Revelosh, Baelog, Olaf, Ironaya, Grimlok, Archaedas : nom anglais identique.
  ["Eric « l'Agile »"] = "Eric \"Der Flinke\"",
  ["Sentinelle d'obsidienne"] = "Obsidianschildwache",
  ["Ancien gardien des pierres"] = "Uralter Steinbewahrer",
  ["Galgann Martel-de-feu"] = "Galgann Feuerhammer",
  ["Les Disques de Norgannon"] = "Die Scheiben von Norgannon",
  ["Titre de propriété de Moulin-de-Tarren"] = "Die Besitzurkunde für Tarrens Mühle",
  -- wowhead forever zone=16919 (La salle des Thanes). Faldrim Anvilmar, Magmatus, Durgen Dirgehammer : nom anglais identique.
  ["Pilleur"] = "Schleppweg",
  -- wowhead forever zone=209 (Donjon d'Ombrecroc). Rethilgore, Baron Silverlaine : nom anglais identique.
  ["Tranchegriffe le Boucher"] = "Klingenklaue der Metzger",
  ["Commandant Springvale"] = "Kommandant Springvale",
  ["Odo l'Aveugle"] = "Odo der Blindseher",
  ["Fenrus le Dévoreur"] = "Fenrus der Verschlinger",
  ["Maître-loup Nandos"] = "Wolfmeister Nandos",
  ["Archimage Arugal"] = "Erzmagier Arugal",
  ["Palefroi corrompu"] = "Teufelsross",
  ["Capitaine Ligemort"] = "Todeshöriger Captain",
  -- wowhead forever zone=1176 (Zul'Farrak). Antu'sul, Gahz'rilla, Ruuzlu, Sergeant Bly, Zerillis : nom anglais identique.
  ["Theka le Martyr"] = "Theka der Märtyrer",
  ["Sorcier-docteur Zum'rah"] = "Hexendoktor Zum'rah",
  ["Hydromancienne Velratha"] = "Wasserbeschwörerin Velratha",
  ["Nekrum Mâchetripes"] = "Nekrum der Ausweider",
  ["Prêtre des ombres Sezz'ziz"] = "Schattenpriester Sezz'ziz",
  ["Chef Ukorz Scalpessable"] = "Häuptling Ukorz Sandscalp",
  ["Bourreau Sandfury"] = "Henker der Sandfury",
  ["Sandarr Ravadune"] = "Sandarr der Wüstenräuber",
  ["Ame en peine poudreuse"] = "Karaburan",
  -- wowhead forever zone=719 (Profondeurs de Brassenoire). Autres boss : nom anglais identique.
  ["Seigneur du crépuscule Kelris"] = "Twilight-Lord Kelris",
  -- wowhead forever zone=717 (La Prison). Kam Deepfury, Hamhock, Bazil Thredd, Dextren Ward : nom anglais identique.
  ["Targorr le Terrifiant"] = "Targorr der Schreckliche",
  ["Bruegal Ironknuckle"] = "Bruegal Eisenfaust",
  -- wowhead forever zone=721 (Gnomeregan). Techbot, Grubbis : nom anglais identique.
  ["Retombée visqueuse"] = "Verflüssigte Ablagerung",
  ["Électrocuteur 6000"] = "Elektrokutionator 6000",
  ["Faucheur de foule 9-60"] = "Meute-Verprügler 9-60",
  ["Mekgénieur Thermaplugg"] = "Robogenieur Thermaplugg",
  ["Ambassadeur Sombrefer"] = "Botschafter der Dunkeleisenzwerge",
  -- wowhead forever zone=1584 (Profondeurs de Blackrock). Lord Roccor, Bael'Gar, Lord Incendius, Verek, Fineous Darkvire, Phalanx, Plugger Spazzring, Ribbly Screwspigot, Magmus : nom anglais identique.
  ["Maître-chien Grebmar"] = "Hundemeister Grebmar",
  ["Grand Interrogateur Gerstahn"] = "Verhörmeisterin Gerstahn",
  ["Anub'shiah, Éviscérateur, Gorosh le Derviche, Grison, Hedrum le Rampant ou Ok'thor le Briseur"] = "Anub'shiah, Ausweider, Gorosh der Derwisch, Grizzle, Hedrum der Krabbler oder Ok'thor der Zerstörer",
  ["Pyromancien Blé-du-savoir"] = "Pyromant Weiskorn",
  ["Gardien Stilgiss"] = "Wärter Stilgiss",
  ["Général Forgehargne"] = "General Zornesschmied",
  ["Seigneur golem Argelmach"] = "Golemlord Argelmach",
  ["Hurley Soufflenoir"] = "Hurley Pestatem",
  ["Ambassadeur Cinglefouet"] = "Botschafter Flammenschlag",
  ["Les Sept : Haine'rel, Colé'rel, Ignobl'rel, Funéb'rel, Fulmi'rel, Tragi'rel, Demeu'rel"] = "Die Sieben: Hass'rel, Zorn'rel, Bös'rel, Dunk'rel, Wut'rel, Un'rel, Trott'rel",
  ["Empereur Dagran Thaurissan"] = "Imperator Dagran Thaurissan",
  ["Princesse Moira Barbe-de-bronze"] = "Prinzessin Moira Bronzebeard",
  ["Panzor l'Invincible"] = "Panzor der Unbesiegbare",
  -- wowhead forever zone=2017 (Stratholme). Balnazzar, Nerub'enkan, Baron Rivendare, Skul : nom anglais identique.
  ["Timmy le Cruel"] = "Timmy der Grausame",
  ["Malor le Zélé"] = "Malor der Eifrige",
  ["Maître canonnier Willey"] = "Kanonenmeister Willey",
  ["Archiviste Galford"] = "Archivar Galford",
  ["Magistrat Barthilas"] = "Magistrat Barthilas",
  ["Baronne Anastari"] = "Baroness Anastari",
  ["Maleki le Blafard"] = "Maleki der Leichenblasse",
  ["Ramstein Grandgosier"] = "Ramstein der Verschlinger",
  ["Le Condamné"] = "Der Unverziehene",
  ["Hearthsinger Forresten"] = "Herdsinger Forresten",
  ["Echine-de-pierre"] = "Steinbuckel",
  ["Fras Siabi"] = "Fras Siabi",
  ["Postier Malown"] = "Postmeister Malown",
  ["Forgeur de marteaux cramoisi"] = "Purpurroter Hammerschmied",
  ["Fabricant d'épées de la Garde noire"] = "Schwertschmied der schwarzen Wache",
  -- wowhead forever (Monastère écarlate : Cimetière, rares).
  ["Azshir le Sans-sommeil"] = "Azshir der Schlaflose",
  ["Échine-de-fer"] = "Eisenrücken",
  ["Champion mort"] = "Gestürzter Held",
  -- wowhead forever (Monastère écarlate). Herod : nom anglais identique.
  ["Interrogateur Vishas"] = "Befrager Vishas",
  ["Mage de sang Thalnos"] = "Blutmagier Thalnos",
  ["Maître-chien Loksey"] = "Hundemeister Loksey",
  ["Arcaniste Doan"] = "Arkanist Doan",
  ["Grand Inquisiteur Fairbanks"] = "Hochinquisitor Fairbanks",
  ["Commandant écarlate Mograine"] = "Scharlachroter Kommandant Mograine",
  ["Grand Inquisiteur Whitemane"] = "Hochinquisitor Whitemane",
  -- wowhead forever zone=1477 (Temple d'Atal'Hakkar). Atal'alarion, Morphaz, Hazzas : nom anglais identique.
  ["Tisserand"] = "Wirker",
  ["Fauche-rêve"] = "Traumsense",
  ["Jammal'an le prophète"] = "Jammal'an der Prophet",
  ["Ogom le Misérable"] = "Ogom der Elende",
  ["Avatar d'Hakkar"] = "Avatar von Hakkar",
  ["Ombre d'Eranikus"] = "Eranikus' Schemen",
  -- wowhead forever zone=2057 (Scholomance). Jandice Barov, Marduk Blackpool, Vectus, Lord Alexei Barov, Lady Illucia Barov : nom anglais identique.
  ["Kirtonos le Héraut"] = "Kirtonos der Herold",
  ["Cliquettripes"] = "Blutrippe",
  ["Ras Murmegivre"] = "Ras Frostraunen",
  ["Instructeur Malicia"] = "Instrukteurin Malicia",
  ["Docteur Theolen Krastinov"] = "Doktor Theolen Krastinov",
  ["Gardien du savoir Polkelt"] = "Hüter des Wissens Polkelt",
  ["Le Voracien"] = "Der Ravenier",
  ["Sombre Maître Gandling"] = "Dunkelmeister Gandling",
  -- wowhead forever zone=2557 (Hache-tripes). Pusillin, Lethtendris, Magister Kalendris, Immol'thar, Prince Tortheldrin, Captain Kromcrush, Tsu'zee, Ferra, Pimgib : nom anglais identique.
  ["Zevrim Sabot-de-ronce"] = "Zevrim Dornhuf",
  ["Hydrogénos"] = "Hydrobrut",
  ["Alzzin le Modeleur"] = "Alzzin der Wildformer",
  ["Tendris Crochebois"] = "Tendris Wucherborke",
  ["Illyanna Corvichêne"] = "Illyanna Rabeneiche",
  ["Garde Mol'dar"] = "Wache Mol'dar",
  ["Garde Fengus"] = "Wache Fengus",
  ["Garde Slip'kik"] = "Wache Slip'kik",
  ["Cho'Rush l'Observateur"] = "Cho'Rush der Beobachter",
  ["Roi Gordok"] = "König Gordok",
  ["Kreeg le Marteleur"] = "Stampfer Kreeg",
  -- wowhead forever zone=2100 (Maraudon). Noxxion : nom anglais identique.
  ["Esprit de Veng"] = "Geist von Veng",
  ["Tranchefouet"] = "Schlingwurzler",
  ["Esprit de Maraudos"] = "Geist von Maraudos",
  ["Seigneur Vylelangue"] = "Lord Schlangenzunge",
  ["Celebras le Maudit"] = "Celebras der Verfluchte",
  ["Glissement de terrain"] = "Erdrutsch",
  ["Artisan Gizlock"] = "Tüftler Gizlock",
  ["Grippe-charogne"] = "Faulschnapper",
  ["Princesse Theradras"] = "Prinzessin Theradras",
  ["Meshlok le Moissonneur"] = "Meshlok der Ernter",
  -- wowhead forever zone=16611 (Ruines de Lordaeron). Rath'mael, Bjork : nom identique.
  ["Croc-Flétri"] = "Welkzahn",
  ["L'Abandonné"] = "Der Verlassene",
  ["Le Baron"] = "Der Baron",
  ["Viktor le Vil"] = "Viktor der Üble",
  ["Capitaine de Lordaeron"] = "Hauptmann von Lordaeron",
  -- wowhead forever zone=2717 (Cœur du Magma). Lucifron, Magmadar, Gehennas, Garr, Baron Geddon, Shazzrah, Ragnaros : nom identique.
  ["Messager de Sulfuron"] = "Sulfuronherold",
  ["Golemagg l'Incinérateur"] = "Golemagg der Verbrenner",
  ["Chambellan Executus"] = "Majordomus Executus",
  -- wowhead forever zone=3456 (Naxxramas). Anub'Rekhan, Maexxna, Grobbulus, Gluth, Thaddius, Kel'Thuzad : nom identique.
  ["Grande veuve Faerlina"] = "Großwitwe Faerlina",
  ["Noth le Porte-peste"] = "Noth der Seuchenfürst",
  ["Heigan l'Impur"] = "Heigan der Unreine",
  ["Horreb"] = "Loatheb",
  ["Instructeur Razuvious"] = "Instrukteur Razuvious",
  ["Gothik le Moissonneur"] = "Gothik der Seelenjäger",
  ["Généralissime Mograine, Thane Korth'azz, Dame Blaumeux et Sire Zeliek"] = "Hochlord Mograine, Thane Korth'azz, Lady Blaumeux und Sire Zeliek",
  ["Le Recousu"] = "Flickwerk",
}

-- Item names the client has no translation for (Wowhead Forever shows them in [brackets]), by item id. Read by Names.lua N:ItemName.
AF.Content = AF.Content or {}
AF.Content.deDE = AF.Content.deDE or {}
AF.Content.deDE.itemName = {
  -- zone=722 (Souilles de Tranchebauge), traduction faite main, nom officiel à confirmer en jeu.
  [10775] = "Tuten'kashs Panzer",
  [10771] = "Todesmagierschärpe",
  [10772] = "Hackbeil des Vielfraßes",
  [10774] = "Fleischhautschultern",
  [10761] = "Kältezorndolch",
  [10762] = "Roben des Lichs",
  [10763] = "Eismetallbarbute",
  [10764] = "Todeskälterüstung",
  [10765] = "Knochenfinger",
  -- zone=491 (Kraal de Tranchebauge), traduction faite main, nom officiel à confirmer en jeu.
  [6682] = "Todessprecherroben",
  [6685] = "Todessprechermantel",
  [6688] = "Wisperwindkopfschmuck",
  [6690] = "Wilde Gamaschen",
  [6691] = "Schweinehauerklinge",
  [6692] = "Gezackter Häscher",
  [6693] = "Agamaggans Griff",
  [6695] = "Stygisches Knochenamulett",
  [6696] = "Nachtpirscherbogen",
  [6697] = "Fledermausflügelmantel",
  -- zone=1337 (Uldaman), traduction faite main, nom officiel à confirmer en jeu.
  [9389] = "Reveloshs Schulterstücke",
  [9390] = "Reveloshs Handschuhe",
  [9407] = "Steinwebergamaschen",
  [9411] = "Felssplitterschulterstücke",
  [9414] = "Ölhautgamaschen",
  [9415] = "Grimloks Stammesgewänder",
  [9416] = "Grimloks Sturmangriff",
  -- butin de zone (Kraal, Uldaman) sans traduction sur Wowhead Forever, traduction faite main, nom officiel à confirmer en jeu.
  [2039] = "Ring der Ebenen",
  [2264] = "Mantel der Diebe",
  [9384] = "Steingewölbestichmesser",
  [9420] = "Tropenhelm des Abenteurers",
  -- zone=1176 (Zul'Farrak), traduction faite main, nom officiel à confirmer en jeu.
  [9379] = "Sang'thraze der Ablenker",
  [9467] = "Gahz'rillas Fangzahn",
  [9469] = "Gahz'rillaschuppenrüstung",
  [9470] = "Maske des bösen Mojos",
  [9473] = "Verhexte Hoodoohaut",
  [9474] = "Verhexter Hoodookilt",
  [9475] = "Diabolischer Schneider",
  [9476] = "Große böse Schulterstücke",
  [9477] = "Der Vollstrecker des Häuptlings",
  [9639] = "Die Hand von Antu'sul",
  [9640] = "Schraubstockgriffe",
  [11086] = "Jang'thraze der Beschützer",
  [12470] = "Sandpirscher-Knöchelschützer",
  [18082] = "Zum'rahs ärgerlicher Stock",
  -- zone=721 (Gnomeregan), traduction faite main (aucun nom FR, DE, ES sur Wowhead Forever), nom officiel à confirmer en jeu.
  [9447] = "Elektrokutionatormutter",
  [9448] = "Spinnenpanzer-Öllappen",
  [9452] = "Hydrostock",
  [9458] = "Thermapluggs Zentralkern",
  [9461] = "Geladenes Zahnrad",
  [9490] = "Gizmotron-Megahacker",
  [9509] = "Ölteppichgamaschen",
  [9510] = "Tiefhöhlenstapfer",
  -- zone=1584 (Profondeurs de Blackrock), traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [811] = "Axt der tiefen Wälder",
  [11623] = "Feenwirkerumhang",
  [11627] = "Leichtfußschienbeinschützer",
  [11628] = "Bogen des Hundemeisters",
  [11630] = "Felssplitterkugeln",
  [11631] = "Steinschalenschutz",
  [11632] = "Erdschlackeschultern",
  [11633] = "Spinnenzahnpanzer",
  [11726] = "Kettenrüstung des wilden Gladiators",
  [11728] = "Gamaschen des wilden Gladiators",
  [11729] = "Helm des wilden Gladiators",
  [11730] = "Griffe des wilden Gladiators",
  [11731] = "Schienbeinschützer des wilden Gladiators",
  [11745] = "Fäuste von Phalanx",
  [11747] = "Flammenschreiterroben",
  [11748] = "Pyrischer Caduceus",
  [11749] = "Sengschuppengamaschen",
  [11750] = "Anzündstab",
  [11764] = "Aschenhautarmschienen",
  [11765] = "Scheiterkettenarmschützer",
  [11817] = "Schwert des Lordgenerals",
  [11821] = "Kriegszwistgamaschen",
  [11822] = "Allzauberstiefel",
  [11823] = "Kilt des Leuchtenden",
  [11841] = "Pantalons des Chefkonstrukteurs",
  [22240] = "Schienbeinschützer der welkenden Verzweiflung",
  [22241] = "Schulterstücke des dunklen Wärters",
  [22242] = "Vereks Leine",
  -- zone=1584 (Profondeurs de Blackrock), vérifiés ensuite : traduction faite main, nom officiel à confirmer en jeu.
  [11735] = "Wutzornaugenklappe",
  [11746] = "Golemschädelhelm",
  -- zone=2017 (Stratholme), traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [13107] = "Magischädelmanschetten",
  [13340] = "Umhang des schwarzen Barons",
  [13387] = "Gurt der Voraussicht",
  [13397] = "Steinhautgargoylenumhang",
  [13400] = "Unterarmschienen des Sadisten",
  [13402] = "Timmys Galoschen",
  [13404] = "Maske des Unverziehenen",
  [13405] = "Heulende Nachtbannschulterstücke",
  [18720] = "Leichentuch der Nathrezim",
  [18722] = "Todesgriffe",
  -- Monastère écarlate (Cimetière, rares), traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [7690] = "Ebenholzschraubstock",
  [7691] = "Einbalsamiertes Leichentuch",
  [7689] = "Morbide Morgendämmerung",
  [7686] = "Eisenrückens Auge",
  [7688] = "Eisenrückens Brustkorb",
  [7687] = "Eisenrückens Faust",
  [7754] = "Stiefel des Vorboten",
  [7731] = "Geistersplittertalisman",
  [7708] = "Nekrotischer Zauberstab",
  [7709] = "Verseuchte Gamaschen",
  [7730] = "Kobaltzermalmer",
  -- Monastère écarlate, traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [7710] = "Lokseys Übungsstock",
  [7786] = "Schädelspalter",
  [10332] = "Scharlachrote Stiefel",
  [7719] = "Helm des tobenden Berserkers",
  [10330] = "Scharlachrote Gamaschen",
  [7717] = "Verwüster",
  [7724] = "Stulpen der Göttlichkeit",
  [7723] = "Mograines Macht",
  [7752] = "Traumtöter",
  [7757] = "Windweberstab",
  [7721] = "Hand der Rechtschaffenheit",
  [19507] = "Schultertuch des Inquisitors",
  [19508] = "Gebrandmarkte Lederarmschienen",
  [19509] = "Staubige Kettenstiefel",
  [7685] = "Kugel des vergessenen Sehers",
  [7684] = "Blutmagiermantel",
  [7714] = "Hypnotische Klinge",
  [7713] = "Illusorische Rute",
  -- zone=1477 (Temple d'Atal'Hakkar), traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [10799] = "Kopfstachel",
  [10804] = "Faust der Verdammten",
  [10807] = "Kilt des Atal'ai-Propheten",
  [10833] = "Hörner von Eranikus",
  [10838] = "Macht von Hakkar",
  [10844] = "Turmspitze von Hakkar",
  [12243] = "Schwelende Klaue",
  [12465] = "Nachteinbruchtuch",
  [12466] = "Morgenspitzenkordel",
  -- zone=2057 (Scholomance), traduction faite main (aucun nom FR, DE, ES sur Wowhead Forever), nom officiel à confirmer en jeu.
  [14620] = "Todesknochengurt",
  [14621] = "Todesknochensabatons",
  [14622] = "Todesknochenstulpen",
  [14623] = "Todesknochenbeinschützer",
  [14624] = "Todesknochenbrustplatte",
  [14525] = "Knochengreiferstulpen",
  -- zone=2100 (Maraudon), traduction faite main (aucun nom FR, DE, ES sur Wowhead Forever), nom officiel à confirmer en jeu.
  [17710] = "Brandsteindolch",
  [17713] = "Schwarzsteinring",
  [17714] = "Armschienen der Steinprinzessin",
  [17715] = "Auge von Theradras",
  [17717] = "Megaschussgewehr",
  [17719] = "Fokusschwert des Erfinders",
  [17728] = "Albino-Krokoschuppenstiefel",
  [17730] = "Alligatorbissaxt",
  [17732] = "Faulschnappers Mantel",
  [17738] = "Klaue von Celebras",
  [17739] = "Tuch des Hainhüters",
  [17740] = "Kopfschmuck des Wahrsagers",
  [17741] = "Umarmung der Natur",
  [17745] = "Giftiger Schießer",
  [17748] = "Rankenfäulesandalen",
  [17755] = "Satyrmähnenschärpe",
  [17766] = "Zepter von Prinzessin Theradras",
  [17943] = "Steinfaust",
  -- zone=16611 (Ruines de Lordaeron), traduction faite main (nom anglais seulement sur Wowhead Forever), nom officiel à confirmer en jeu.
  [271211] = "Übelwandler",
  [271217] = "Leichenhacker",
  -- zone=2717 (Cœur du Magma, objets de zone de Ragnaros), traduction faite main (absent de Wowhead Forever dans cette langue), nom officiel à confirmer en jeu.
  [13116] = "Schiftung des Ungesehenen",
  -- zone=3456 (Naxxramas, Kel'Thuzad), traduction faite main (absent de Wowhead Forever en FR, DE, ES), nom officiel à confirmer en jeu.
  [23577] = "Die hungrige Kälte",
}

AF.Content = AF.Content or {}
AF.Content.deDE = AF.Content.deDE or {}
AF.Content.deDE.where = {
  ["Azshara"] = "Azshara",
  ["Berceau-de-l'Hiver"] = "Winterquell",
  ["Bois de la Pénombre"] = "Dämmerwald",
  ["Cime des Anciens, Pitons-du-Tonnerre"] = "Anhöhe der Ältesten, Donnerfels",
  ["Clairières de Tirisfal"] = "Tirisfal",
  ["Comté-du-Lac, Carmines"] = "Seenhain, Rotkammgebirge",
  ["Contreforts de Hautebrande"] = "Vorgebirge von Hillsbrad",
  ["Cratère d'Un'Goro"] = "Krater von Un'Goro",
  ["Darnassus"] = "Darnassus",
  ["Devant la Prison, Hurlevent"] = "Vor dem Verlies, Sturmwind",
  ["Donjon d'Ombrecroc"] = "Burg Schattenfang",
  ["Dun Morogh"] = "Dun Morogh",
  ["Durotar"] = "Durotar",
  ["Désolace"] = "Desolace",
  ["Forgefer"] = "Eisenschmiede",
  ["Forêt des Pins-Argentés"] = "Silberwald",
  ["Fossoyeuse"] = "Unterstadt",
  ["Féralas"] = "Feralas",
  ["Gnomeregan"] = "Gnomeregan",
  ["Gouffre de Ragefeu"] = "Flammenschlund",
  ["Hache-tripes"] = "Düsterbruch",
  ["Hurlevent"] = "Sturmwind",
  ["Intérieur Gnomeregan"] = "Im Inneren von Gnomeregan",
  ["Intérieur du Kraal (escorte)"] = "Im Inneren des Krals (Eskorte)",
  ["Kraal de Tranchebauge"] = "Kral der Klingenhauer",
  ["Le temple d'Atal'Hakkar"] = "Der Tempel von Atal'Hakkar",
  ["Les Carmines"] = "Rotkammgebirge",
  ["Les Hinterlands"] = "Hinterland",
  ["Les Paluns"] = "Sumpfland",
  ["Les Pitons-du-Tonnerre"] = "Donnerfels",
  ["Les Tarides"] = "Das Brachland",
  ["Loch Modan"] = "Loch Modan",
  ["Maleterres de l'Est"] = "Östliche Pestländer",
  ["Maleterres de l'Ouest"] = "Westliche Pestländer",
  ["Marais des Chagrins"] = "Sümpfe des Elends",
  ["Maraudon"] = "Maraudon",
  ["Marche de l'Ouest"] = "Westfall",
  ["Marécage d'Âprefange"] = "Düstermarschen",
  ["Mille pointes"] = "Tausend Nadeln",
  ["Monastère écarlate"] = "Scharlachrotes Kloster",
  ["Orgrimmar"] = "Orgrimmar",
  ["Orneval"] = "Eschental",
  ["Pic Rochenoire"] = "Die Spitze des Schwarzfels",
  ["Profondeurs de Blackrock"] = "Die Blackrocktiefen",
  ["Profondeurs de Brassenoire"] = "Die Tiefschwarze Grotte",
  ["Reflet-de-Lune"] = "Mondlichtung",
  ["Refuge de Pierre-du-Pic / Orneval"] = "Steinkrallengipfel / Eschental",
  ["Salle des Thanes"] = "Halle der Thans",
  ["Sombre-Comté"] = "Dunkelhain",
  ["Sombrivage"] = "Dunkelküste",
  ["Sortie des Mortemines"] = "Ausgang der Todesminen",
  ["Souilles de Tranchebauge"] = "Die Hügel der Klingenhauer",
  ["Steppes ardentes"] = "Brennende Steppe",
  ["Stratholme"] = "Stratholme",
  ["Tanaris"] = "Tanaris",
  ["Terres foudroyées"] = "Verwüstete Lande",
  ["Terres ingrates"] = "Ödland",
  ["Uldaman"] = "Uldaman",
  ["Vallée de Strangleronce"] = "Schlingendorntal",
}

AF.Content.deDE.rep = {
  ["Alliance"] = "Allianz",
  ["Aube d'argent"] = "Argentumdämmerung",
  ["Baie-du-Butin"] = "Beutebucht",
  ["Cabestan"] = "Ratschet",
  ["Cartel Gentepression"] = "Dampfdruckkartell",
  ["Cercle cénarien"] = "Zirkel des Cenarius",
  ["Cercle terrestre"] = "Irdener Ring",
  ["Clan Marteau-Hardi"] = "Wildhammerklan",
  ["Darnassus"] = "Darnassus",
  ["Exilés de Gnomeregan"] = "Gnomeregangnome",
  ["Forgefer"] = "Eisenschmiede",
  ["Fossoyeuse"] = "Unterstadt",
  ["Gadgetzan"] = "Gadgetzan",
  ["Horde"] = "Horde",
  ["Hurlevent"] = "Sturmwind",
  ["La Voile sanglante"] = "Blutsegelbukaniere",
  ["Les Pitons-du-Tonnerre"] = "Donnerfels",
  ["Orgrimmar"] = "Orgrimmar",
  ["Shen'dralar"] = "Shen'dralar",
  ["Stormwind"] = "Sturmwind",
  ["Thunder Bluff"] = "Donnerfels",
  ["Trolls Sombrelance"] = "Dunkelspeer-Trolle",
}

AF.Content.deDE.entry = {
  ["Au-dessus du Site de fouilles de Whelgar"] = "Oberhalb der Ausgrabungsstätte von Whelgar",
  ["Dalaran, barrière tombée"] = "Dalaran, Barriere gefallen",
  ["Dans les collines d'Un'Goro."] = "In den Hügeln von Un'Goro.",
  ["Derrière les portes furbolgs, nord d'Azshara"] = "Hinter den Furbolgtoren, nördlich von Azshara",
  ["Donjon au nord du Sépulcre"] = "Burg nördlich der Gruft",
  ["Donjon extérieur, dans la Prairie du Fleuve."] = "Äußeres Verlies, in der Flusswiese.",
  ["Faille de l'Ombre, Orgrimmar"] = "Schattenschlucht, Orgrimmar",
  ["Mine de Ruisselune, Marche de l'Ouest"] = "Mondbachmine, Westfall",
  ["Nord-est de Tirisfal, 4 ailes"] = "Nordöstliches Tirisfal, 4 Flügel",
  ["Oasis aux abords des Cavernes, Tarides"] = "Oase vor den Höhlen, Brachland",
  ["Porte de Gnomeregan, ou téléporteur Scooty à Cabestan"] = "Tor von Gnomeregan oder Scootys Teleporter in Ratschet",
  ["Prison de Hurlevent, Vieille ville"] = "Verlies von Sturmwind, Altstadt",
  ["Ruines au nord-ouest d'Orneval, côte"] = "Ruinen nordwestlich von Eschental, an der Küste",
  ["Ruines au-dessus de Fossoyeuse"] = "Ruinen oberhalb der Unterstadt",
  ["Ruines trolles au large de la côte"] = "Trollruinen vor der Küste",
  ["Sous le Vieux Forgefer ; Haute-Salle vers 43, 51"] = "Unter Alt-Eisenschmiede; Hohe Halle bei 43, 51",
  ["Sud des Tarides, entrée du Kraal"] = "Südliches Brachland, Eingang zum Kral",
  ["Trois entrées, dont une sur le Mont Hyjal."] = "Drei Eingänge, einer davon auf dem Berg Hyjal.",
  ["Île d'Alcaz, nord-est d'Âprefange"] = "Insel Alcaz, nordöstlich der Düstermarschen",
}

AF.Content.deDE.item = {
  ["Blason de Lordaeron"] = "Wappen von Lordaeron",
  ["Blason de Lordaeron (objet dans l'instance, souvent bâtiment NW toit bleu)"] = "Wappen von Lordaeron (Gegenstand in der Instanz, oft im NW-Gebäude mit dem blauen Dach)",
  ["Explosifs extra-destructeurs (item 254553)"] = "Superzerstörerische Sprengstoffe (Gegenstand 254553)",
  ["Objet ramassé ou reçu en butin"] = "Aufgesammelter Gegenstand oder Beute",
  ["Sacoche du Totem-Sinistre"] = "Düsterlohe-Tasche",
}

AF.Content.deDE.npc_add = {
  ["Afadra Mur-de-Dun"] = "Afadra Dunwall",
  ["Ancienne des Shen'Dralar"] = "Älteste der Shen'dralar",
  ["Apothicaire Zamah"] = "Apotheker Zamah",
  ["Archevêque Benedictus"] = "Erzbischof Benedictus",
  ["Archimage Tervosh"] = "Erzmagier Tervosh",
  ["Artiste Renfray"] = "Künstler Renfray",
  ["Autel d'Hakkar"] = "Altar von Hakkar",
  ["Bashana Totem-runique"] = "Bashana Runentotem",
  ["Bibliothécaire Mae Blêmepoussière"] = "Bibliothekarin Mae Paledust",
  ["Brasero de Belnistrasz"] = "Belnistraszs Kohlenbecken",
  ["Brikolette Toutevapeur"] = "Tinkee Steamboil",
  ["Brohann Ventrabière"] = "Brohann Caskbelly",
  ["Capitaine Kromcrush"] = "Hauptmann Kromcrush",
  ["Celebras le Racheté"] = "Celebras der Erlöste",
  ["Cime-de-pierre le Vieil"] = "Old Stonepeak",
  ["Commandant Gor'shak"] = "Kommandant Gor'shak",
  ["Conseiller Belgrum"] = "Berater Belgrum",
  ["Conseiller Millstipe"] = "Ratsherr Millstipe",
  ["Cyrus Lerepenti"] = "Cyrus Therepentous",
  ["Cœur-de-tonnerre"] = "Thunderheart",
  ["Dalar Tisselaube"] = "Dalar Dawnweaver",
  ["Directrice de l'orphelinat Rossignol"] = "Waisenhausmatrone Nightingale",
  ["Domestique fantomatique"] = "Geisterhafter Diener",
  ["Don de Menethil"] = "Menethils Gabe",
  ["Duc Hydraxis"] = "Herzog Hydraxis",
  ["Duc Nicholas Zverenhoff"] = "Herzog Nicholas Zverenhoff",
  ["Eclaireur Riell"] = "Späher Riell",
  ["Erudite Roncerune"] = "Gelehrter Runethorn",
  ["Esprit de Zaetar"] = "Geist von Zaetar",
  ["Exilé atal'ai"] = "Atal'ai-Exilant",
  ["Falfindel Gardevoie"] = "Falfindel Waywarden",
  ["Falla Vent-de-sagesse"] = "Falla Sagewind",
  ["Franclorn Le Forgebusier"] = "Franclorn Forgewright",
  ["Galamav le Tireur d'élite"] = "Galamav der Scharfschütze",
  ["Garde Berton"] = "Wache Berton",
  ["Garde d'argent Manados"] = "Silberwache Manados",
  ["Garde d'argent Thaelrid"] = "Silberwache Thaelrid",
  ["Gardien Bel'dugur"] = "Wächter Bel'dugur",
  ["Gardien Marandis"] = "Wächter Marandis",
  ["Gardien Remulos"] = "Hüter Remulos",
  ["Gardien Thelwater"] = "Wächter Thelwater",
  ["Gardien du savoir Lydros"] = "Wissenshüter Lydros",
  ["Gerrig Poigne-d'os"] = "Gerrig Bonegrip",
  ["Gershala Murmenuit"] = "Gershala Nightwhisper",
  ["Ghak Touchesoins"] = "Ghak Healtouch",
  ["Gouvernante Nagmara"] = "Herrin Nagmara",
  ["Grand Bricoleur Mekkanivelle"] = "Hochtüftler Mekkadrill",
  ["Grand exécuteur Hadrec"] = "Hochexekutor Hadrec",
  ["Gregan Gerbebière"] = "Gregan Brewspewer",
  ["Grutier Bigglefuzz"] = "Kranführer Bigglefuzz",
  ["Gryan Roidemantel"] = "Gryan Stoutmantle",
  ["Général Marcus Jonathan"] = "General Marcus Jonathan",
  ["Hamuul Totem-Runique"] = "Hamuul Runentotem",
  ["Helendis Ruissecorne"] = "Helendis Riverhorn",
  ["Heralath Ruissefriche"] = "Heralath Fallowbrook",
  ["Idole d'Hakkar"] = "Götzenbild von Hakkar",
  ["Infiltrateur du Bouclier balafré"] = "Infiltrant des Narbenschilds",
  ["Ingénieur en chef Vizisanie"] = "Chefingenieur Bilgewhizzle",
  ["Jalinda Brindille"] = "Jalinda Sprig",
  ["Jarkal Fondemousse"] = "Jarkal Mossmeld",
  ["John le Loqueteux"] = "Zerlumpter John",
  ["Jordan Morpuits"] = "Jordan Stilwell",
  ["Kharan Force-martel"] = "Kharan Mighthammer",
  ["Krom Rudebras"] = "Krom Stoutarm",
  ["Lachnouf Zéboulon"] = "Wizzle Brassbolts",
  ["Latronicus Lancelune"] = "Latronicus Moonspear",
  ["Le Décapeur 5200"] = "Der Sparklematic 5200",
  ["Leonid Barthalomew le Révéré"] = "Leonid Bartholomew der Ehrwürdige",
  ["Liv Rafistolier"] = "Liv Rizzlefix",
  ["Lothos Ouvrefaille"] = "Lothos Riftwaker",
  ["Magistrat Marduke"] = "Magistrat Marduke",
  ["Malyfous Sombremartel"] = "Malyfous Darkhammer",
  ["Marque de Drakkisath"] = "Mal von Drakkisath",
  ["Marvon Chercherivet"] = "Marvon Rivetseeker",
  ["Maréchal Maxwell"] = "Marschall Maxwell",
  ["Maréchal Windsor"] = "Marschall Windsor",
  ["Maur Totem-sinistre"] = "Maur Düsterlohe",
  ["Maxwort Uberbrille"] = "Maxwort Uberglint",
  ["Mayara Luisaile"] = "Mayara Brightwing",
  ["Maître Gadrin"] = "Meister Gadrin",
  ["Maître apothicaire Faranell"] = "Meisterapotheker Faranell",
  ["Maître mécanicien Fontuyau"] = "Meistermechaniker Castpipe",
  ["Maître-artisan Overspark"] = "Tüftlermeister Überspark",
  ["Maître-bricoleur Suprétincelle"] = "Tüftlermeister Überspark",
  ["Monument de Franclorn Le Forgebusier"] = "Denkmal für Franclorn Forgewright",
  ["Morbin Plaie-lumineuse"] = "Morbin Glowwound",
  ["Motley Garmaçon"] = "Motley Garmason",
  ["Myriam Chantelune"] = "Miriam Moonsong",
  ["Nara Crin-Sauvage"] = "Nara Wildmane",
  ["Nara Crin-sauvage"] = "Nara Wildmane",
  ["Nathanos le Flétrisseur"] = "Nathanos Pestrufer",
  ["Neeru Lamefeu"] = "Neeru Fireblade",
  ["Noué Dédodevie"] = "Knot Thimblejack",
  ["Nécrogarde Kristof"] = "Todeswache Kristof",
  ["Nécrotraqueur Vincent"] = "Todespirscher Vincent",
  ["Ombremage Vivian Lagrave"] = "Schattenmagierin Vivian Lagrave",
  ["Ozzie Virevolt"] = "Ozzie Togglevolt",
  ["Paria centaure"] = "Zentaurenparia",
  ["Pléthorloge Cléventail"] = "Klockmort Spannerspan",
  ["Prospecteur Baguefer"] = "Prospektor Ironband",
  ["Prospecteur Botte-de-fer"] = "Prospektor Ironboot",
  ["Prospecteur Foudrepique"] = "Prospektor Stormpike",
  ["RECHERCHE"] = "GESUCHT",
  ["Ragnar Tonnebière"] = "Ragnar Thunderbrew",
  ["Raleigh le Dévot"] = "Raleigh der Fromme",
  ["Roi Magni Barbe-de-bronze"] = "König Magni Bronzebart",
  ["Réceptacle d'essence"] = "Essenzbehälter",
  ["Régisseuse sanglante de Kirtonos"] = "Blutverwalter von Kirtonos",
  ["Sage Recherche-la-vérité"] = "Weiser Truthseeker",
  ["Sagorne Rôdeur-des-crêtes"] = "Sagorne Creststrider",
  ["Saule"] = "Willow",
  ["Seigneur de guerre Sangredent"] = "Kriegsherr Bloodfang",
  ["Shoni la Silencieuse"] = "Shoni the Shilent",
  ["TUER A VUE"] = "AUF SICHT TÖTEN",
  ["Tabitha Tissecœur"] = "Tabitha Heartweaver",
  ["Talo Sabot-de-ronce"] = "Talo Thornhoof",
  ["Terre-voyant Farsen"] = "Erdenseher Farsen",
  ["Thadius Sinissombre"] = "Thadius Grimshade",
  ["Theldurin l'Egaré"] = "Theldurin der Verlorene",
  ["Trenton Martelume"] = "Trenton Lighthammer",
  ["Treshala Ruissefriche"] = "Treshala Fallowbrook",
  ["Vark Balafre-glorieuse"] = "Vark Battlescar",
  ["Veilleur de l'aube Selgorm"] = "Dämmerungswächter Selgorm",
  ["Veilleur de l'aube Shaedlass"] = "Dämmerungswächter Shaedlass",
  ["Wilder Crispechardon"] = "Wilder Thistlenettle",
  ["Willix l'Importateur"] = "Willix der Importeur",
  ["Yuka Fermevanne"] = "Yuka Screwspigot",
}

AF.Content.deDE.instance = {
  rfc = "Flammenschlund",
  hot = "Halle der Thans",
  wc = "Die Höhlen des Wehklagens",
  rol = "Ruinen von Lordaeron",
  dm = "Die Todesminen",
  sfk = "Burg Schattenfang",
  stocks = "Das Verlies",
  bfd = "Die Tiefschwarze Grotte",
  excav = "Ausgrabungsstätte: Sumpfland",
  sm = "Scharlachrotes Kloster",
  cod = "Stadt Dalaran",
  gnomer = "Gnomeregan",
  rfk = "Kral der Klingenhauer",
  dc = "Die versunkene Stadt",
  rfd = "Die Hügel der Klingenhauer",
  krol = "Festung Krol'dok",
  ulda = "Uldaman",
  zf = "Zul'Farrak",
  mara = "Maraudon",
  alcaz = "Gefängnis von Alcaz",
  st = "Der Tempel von Atal'Hakkar",
  brd = "Die Blackrocktiefen",
  brs = "Die Spitze des Schwarzfels",
  bh = "Feste Schwarzkiefer",
  dire = "Düsterbruch",
  scholo = "Scholomance",
  strat = "Stratholme",
  shapers = "Terrasse der Former",
  barrow = "Barrow-Gruben",
  hyjal = "Berg Hyjal",
  ony = "Onyxias Hort",
  mc = "Geschmolzener Kern",
  bwl = "Pechschwingenhort",
  zg = "Zul'Gurub",
  aq20 = "Ruinen von Ahn'Qiraj",
  aq40 = "Tempel von Ahn'Qiraj",
  naxx = "Naxxramas",
}
do
  local C = AF.Content.deDE
  C.npc = C.npc or {}
  for k, v in pairs(C.npc_add or {}) do if C.npc[k] == nil then C.npc[k] = v end end
  C.npc_add = nil
end

-- Titel von Captain Truman (von Hand übersetzt, im Spiel zu bestätigen)
AF.Content.deDE.npc["Captain Truman"] = "Hauptmann Truman"

AF.Content.deDE.npc_boss = {
  ["Bazzalan"] = "Bazzalan",
  ["Faldrim Courbenclume"] = "Faldrim Ambossmar",
  ["Magmatus"] = "Magmatus",
  ["Durgen Mornemartel"] = "Durgen Trauerhammer",
  ["Dame Anacondra"] = "Lady Anacondra",
  ["Seigneur Cobrahn"] = "Lord Cobrahn",
  ["Kresh"] = "Kresh",
  ["Seigneur Pythas"] = "Lord Pythas",
  ["Skum"] = "Skum",
  ["Seigneur Serpentis"] = "Lord Serpentis",
  ["Rath'mael"] = "Rath'mael",
  ["Bjork"] = "Bjork",
  ["Rhahk'Zor"] = "Rhahk'Zor",
  ["Sneed"] = "Sneed",
  ["Gilnid"] = "Gilnid",
  ["Capitaine Vertepeau"] = "Hauptmann Grünhaut",
  ["M. Smite"] = "Mr. Smite",
  ["Macaron"] = "Smutje",
  ["Edwin VanCleef"] = "Edwin VanCleef",
  ["Rethilgore"] = "Rethilgore",
  ["Baron d'Argelaine"] = "Baron Silberlein",
  ["Kam Deepfury"] = "Kam Tiefenzorn",
  ["Hamhock"] = "Hamhock",
  ["Bazil Thredd"] = "Bazil Thredd",
  ["Dextren Ward"] = "Dextren Ward",
  ["Ghamoo-ra"] = "Ghamoo-ra",
  ["Dame Sarevess"] = "Lady Sarevess",
  ["Gelihast"] = "Gelihast",
  ["Lorgus Jett"] = "Lorgus Jett",
  ["Baron Aquanis"] = "Baron Aquanis",
  ["Vieux Serra'kis"] = "Der alte Serra'kis",
  ["Aku'mai"] = "Aku'mai",
  ["Échine-de-sel"] = "Salzrücken",
  ["Dent-d'ombre"] = "Schattenzahn",
  ["Horreur des hautes-terres"] = "Hochlandschrecken",
  ["Gardien des reliques"] = "Reliktwächter",
  ["Herod"] = "Herod",
  ["Anomalie arcanique"] = "Arkane Anomalie",
  ["Ancien gangrené"] = "Teuflischer Ältester",
  ["Dévoreur de mana"] = "Manaverschlinger",
  ["Élémentaire de mana"] = "Manaelementar",
  ["Sentinelle instable"] = "Instabiler Wächter",
  ["Ombre de l'archimage"] = "Schemen des Erzmagiers",
  ["Lyn l'Ignorée"] = "Lyn die Ignorierte",
  ["Atrexis le Chevalier des tombes"] = "Atrexis der Grabritter",
  ["Spectre de mana"] = "Manageist",
  ["Grubbis"] = "Grubbis",
  ["Roogug"] = "Roogug",
  ["Charlga Trancheflanc"] = "Charlga Klingenflanke",
  ["Tuten'kash"] = "Tuten'kash",
  ["Revelosh"] = "Revelosh",
  ["Baelog"] = "Baelog",
  ["Olaf"] = "Olaf",
  ["Ironaya"] = "Ironaya",
  ["Grimlok"] = "Grimlok",
  ["Archaedas"] = "Archaedas",
  ["Antu'sul"] = "Antu'sul",
  ["Gahz'rilla"] = "Gahz'rilla",
  ["Ruuzlu"] = "Ruuzlu",
  ["Noxxion"] = "Noxxion",
  ["Atal'alarion"] = "Atal'alarion",
  ["Morphaz"] = "Morphaz",
  ["Hazzas"] = "Hazzas",
  ["Seigneur Roccor"] = "Lord Roccor",
  ["Bael'Gar"] = "Bael'Gar",
  ["Seigneur Incendius"] = "Lord Incendius",
  ["Verek"] = "Verek",
  ["Fineous Sombrevire"] = "Fineous Dunkelader",
  ["Phalange"] = "Phalanx",
  ["Lanfiche Brouillecircuit"] = "Stöpsler Krampfring",
  ["Ribbly Fermevanne"] = "Ribbly Schraubhahn",
  ["Magmus"] = "Magmus",
  ["Généralissime Omokk"] = "Hochlord Omokk",
  ["Chasseresse des ombres Vosh'gajin"] = "Schattenjägerin Vosh'gajin",
  ["Maître de guerre Voone"] = "Kriegsmeister Voone",
  ["Matriarche Couveuse"] = "Mutter Glimmspinne",
  ["Urok Hurleruine"] = "Urok Schreckensheuler",
  ["Intendant Zigris"] = "Rüstmeister Zigris",
  ["Halycon"] = "Halycon",
  ["Gizrul l'esclavagiste"] = "Gizrul der Sklavenhalter",
  ["Seigneur Wyrmthalak"] = "Lord Wyrmthalak",
  ["Pyrogarde Prophète ardent"] = "Pyrogardist Glutseher",
  ["Solakar Voluteflamme"] = "Solakar Flammenkranz",
  ["Goraluk Brisenclume"] = "Goraluk Ambossknacker",
  ["Gyth"] = "Gyth",
  ["Chef de guerre Rend Main-noire"] = "Kriegshäuptling Rend Schwarzfaust",
  ["La Bête"] = "Die Bestie",
  ["Général Drakkisath"] = "General Drakkisath",
  ["Pusillin"] = "Pusillin",
  ["Lethtendris"] = "Lethtendris",
  ["Magistère Kalendris"] = "Magister Kalendris",
  ["Immol'thar"] = "Immol'thar",
  ["Prince Tortheldrin"] = "Prinz Tortheldrin",
  ["Jandice Barov"] = "Jandice Barov",
  ["Marduk Noirétang"] = "Marduk Schwarzweiher",
  ["Vectus"] = "Vectus",
  ["Instructeur Malicia"] = "Ausbilderin Malicia",
  ["Docteur Theolen Krastinov"] = "Doktor Theolen Krastinov",
  ["Seigneur Alexei Barov"] = "Lord Alexei Barov",
  ["Dame Illucia Barov"] = "Lady Illucia Barov",
  ["Balnazzar"] = "Balnazzar",
  ["Nerub'enkan"] = "Nerub'enkan",
  ["Baron Vaillefendre"] = "Baron Rivendare",
  ["Onyxia"] = "Onyxia",
  ["Lucifron"] = "Lucifron",
  ["Magmadar"] = "Magmadar",
  ["Gehennas"] = "Gehennas",
  ["Garr"] = "Garr",
  ["Baron Geddon"] = "Baron Geddon",
  ["Shazzrah"] = "Shazzrah",
  ["Ragnaros"] = "Ragnaros",
  ["Tranchetripe l'Indompté"] = "Razorgore der Ungezähmte",
  ["Vaelastrasz le Corrompu"] = "Vaelastrasz der Verdorbene",
  ["Seigneur des couvées Lashlayer"] = "Brutwächter Dreschbringer",
  ["Gueule-de-feu"] = "Feuerschwinge",
  ["Rochébène"] = "Schattenschwinge",
  ["Flamegor"] = "Flammenmaul",
  ["Chromaggus"] = "Chromaggus",
  ["Nefarian"] = "Nefarian",
  ["Grande prêtresse Jeklik"] = "Hohepriesterin Jeklik",
  ["Grand prêtre Venoxis"] = "Hohepriester Venoxis",
  ["Grande prêtresse Mar'li"] = "Hohepriesterin Mar'li",
  ["Seigneur sanglant Mandokir"] = "Blutfürst Mandokir",
  ["Gri'lek, Hazza'rah, Renataki ou Wushoolay"] = "Gri'lek, Hazza'rah, Renataki oder Wushoolay",
  ["Gahz'ranka"] = "Gahz'ranka",
  ["Grand prêtre Thekal"] = "Hohepriester Thekal",
  ["Grande prêtresse Arlokk"] = "Hohepriesterin Arlokk",
  ["Jin'do le Maléficieur"] = "Jin'do der Verhexer",
  ["Hakkar"] = "Hakkar",
  ["Kurinnaxx"] = "Kurinnaxx",
  ["Général Rajaxx"] = "General Rajaxx",
  ["Moam"] = "Moam",
  ["Buru Grandgosier"] = "Buru der Schlinger",
  ["Ayamiss le Chasseur"] = "Ayamiss der Jäger",
  ["Ossirian l'Intouché"] = "Ossirian der Narbenlose",
  ["Le Prophète Skeram"] = "Der Prophet Skeram",
  ["Seigneur Kri, Princesse Yauj et Vem"] = "Lord Kri, Prinzessin Yauj und Vem",
  ["Garde de guerre Sartura"] = "Schlachtwache Sartura",
  ["Fankriss l'Inflexible"] = "Fankriss der Unnachgiebige",
  ["Viscidus"] = "Viscidus",
  ["Princesse Huhuran"] = "Prinzessin Huhuran",
  ["Empereur Vek'lor et Empereur Vek'nilash"] = "Imperator Vek'lor und Imperator Vek'nilash",
  ["Ouro"] = "Ouro",
  ["C'Thun"] = "C'Thun",
  ["Anub'Rekhan"] = "Anub'Rekhan",
  ["Maexxna"] = "Maexxna",
  ["Grobbulus"] = "Grobbulus",
  ["Gluth"] = "Gluth",
  ["Thaddius"] = "Thaddius",
  ["Saphiron"] = "Saphiron",
  ["Kel'Thuzad"] = "Kel'Thuzad",
}
do
  local C = AF.Content.deDE
  for k, v in pairs(C.npc_boss or {}) do if C.npc[k] == nil then C.npc[k] = v end end
  C.npc_boss = nil
  C.npc["Galamav the Marksman"] = C.npc["Galamav the Marksman"] or "Galamav der Scharfschütze"
  C.npc["Myranda the Hag"] = C.npc["Myranda the Hag"] or "Myranda die Hexe"
  C.npc["Leonid Barthalomew the Revered"] = C.npc["Leonid Barthalomew the Revered"] or "Leonid Barthalomew der Ehrwürdige"
end

-- quêtes sans identifiant dans les données (Molten Core), traduction faite main
AF.Content.deDE.npc["L'Alliance a besoin de pierres du Magma calcinées !"] = "Die Allianz braucht versengte Kernsteine!"
AF.Content.deDE.npc["La Horde a besoin de pierres du Magma calcinées !"] = "Die Horde braucht versengte Kernsteine!"

AF.Content.deDE.npc["Garde d'argent Thaelrid"] = "Argentumwache Thaelrid"
AF.Content.deDE.npc["Manuscrit de Lorgalis"] = "Lorgalis-Manuskript"

-- Profondeurs de Rochenoire : noms officiels Wowhead (infobulles classic, deDE)
do
  local C = AF.Content.deDE
  C.where = C.where or {}
  C.where["Profondeurs de Rochenoire"] = "Die Blackrocktiefen"
  C.npc["Kharan Mighthammer"] = "Kharan Mighthammer"
  C.npc["Commandant Gor'shak"] = "Kommandant Gor'shak"
  C.npc["Maréchal Windsor"] = "Marshal Windsor"
  C.npc["Clé du Sinistre dévoreur"] = "Schlüssel des 'Grimmigen Säufers'"
  C.npc["Torche ombreforge"] = "Schattenschmiedefackel"
  C.npc["Coffre sombre"] = "Dunkler Kasten"
  C.npc["Monument de Franclorn Forgewright"] = "Denkmal für Franclorn Forgewright"
  C.npc["Coffre des sept"] = "Truhe der Sieben"
end

-- Noms officiels relevés dans les infobulles Wowhead (WoW Forever, deDE), à la place des traductions faites main.
do
  local C = AF.Content.deDE
  C.npc = C.npc or {}; C.npc["Goraluk Brisenclume"] = "Goraluk Hammerbruch"
  C.npc = C.npc or {}; C.npc["Prospecteur Botte-de-fer"] = "Ausgrabungsleiter Ironboot"
  C.npc = C.npc or {}; C.npc["Durgen Mornemartel"] = "Durgen Dirgehammer"
  C.npc = C.npc or {}; C.npc["Myranda the Hag"] = "Myranda die Vettel"
  C.npc = C.npc or {}; C.npc["Bashana Totem-runique"] = "Bashana Runetotem"
  C.npc = C.npc or {}; C.npc["Bibliothécaire Mae Blêmepoussière"] = "Bilbliothekarin Mae Paledust"
  C.npc = C.npc or {}; C.npc["Artiste Renfray"] = "Grafiker Renfray"
  C.npc = C.npc or {}; C.npc["Marduk Noirétang"] = "Marduk Blackpool"
  C.npc = C.npc or {}; C.npc["Gardien Remulos"] = "Bewahrer Remulos"
  C.npc = C.npc or {}; C.npc["Shoni la Silencieuse"] = "Shoni die Schtille"
  C.npc = C.npc or {}; C.npc["Solakar Voluteflamme"] = "Solakar Feuerkrone"
  C.npc = C.npc or {}; C.npc["Techbot"] = "Techbot"
  C.npc = C.npc or {}; C.npc["Sergent Bly"] = "Sergeant Bly"
  C.npc = C.npc or {}; C.npc["Prospecteur Foudrepique"] = "Ausgrabungsleiter Stormpike"
  C.npc = C.npc or {}; C.npc["Duc Nicholas Zverenhoff"] = "Fürst Nicholas Zverenhoff"
  C.npc = C.npc or {}; C.npc["Le Décapeur 5200"] = "Der Funkelmat 5200"
  C.npc = C.npc or {}; C.npc["Maître apothicaire Faranell"] = "Apothekermeister Faranell"
  C.npc = C.npc or {}; C.npc["Idole d'Hakkar"] = "Götze von Hakkar"
  C.npc = C.npc or {}; C.npc["Veilleur de l'aube Shaedlass"] = "Dämmerungsbehüter Shaedlass"
  C.npc = C.npc or {}; C.npc["Nathanos le Flétrisseur"] = "Nathanos Blightcaller"
  C.npc = C.npc or {}; C.npc["Ragnar Tonnebière"] = "Ragnar Donnerbräu"
  C.npc = C.npc or {}; C.npc["Prospecteur Baguefer"] = "Ausgrabungsleiter Ironband"
  C.npc = C.npc or {}; C.npc["Ancienne des Shen'Dralar"] = "Uralte Shen'dralar"
  C.npc = C.npc or {}; C.npc["Macaron"] = "Cookie"
  C.npc = C.npc or {}; C.npc["Régisseuse sanglante de Kirtonos"] = "Blutdiener von Kirtonos"
  C.npc = C.npc or {}; C.npc["Ribbly Fermevanne"] = "Ribbly Screwspigot"
  C.npc = C.npc or {}; C.npc["Maître-bricoleur Suprétincelle"] = "Tüftlermeister Overspark"
  C.npc = C.npc or {}; C.npc["Maur Totem-sinistre"] = "Maur Grimmtotem"
  C.npc = C.npc or {}; C.npc["Buru Grandgosier"] = "Buru der Verschlinger"
  C.npc = C.npc or {}; C.npc["Infiltrateur du Bouclier balafré"] = "Spitzel der Schmetterschilde"
  C.npc = C.npc or {}; C.npc["Gardien du savoir Lydros"] = "Hüter des Wissens Lydros"
  C.npc = C.npc or {}; C.npc["Duc Hydraxis"] = "Fürst Hydraxis"
  C.npc = C.npc or {}; C.npc["Galamav the Marksman"] = "Galamav der Schütze"
  C.npc = C.npc or {}; C.npc["Pyrogarde Prophète ardent"] = "Feuerwache Glutseher"
  C.npc = C.npc or {}; C.npc["Capitaine Kromcrush"] = "Captain Kromcrush"
  C.npc = C.npc or {}; C.npc["Faldrim Courbenclume"] = "Faldrim Anvilmar"
  C.npc = C.npc or {}; C.npc["Roi Magni Barbe-de-bronze"] = "König Magni Bronzebeard"
  C.npc = C.npc or {}; C.npc["Gizrul l'esclavagiste"] = "Gizrul der Geifernde"
  C.npc = C.npc or {}; C.npc["Urok Hurleruine"] = "Urok Schreckensbote"
  C.npc = C.npc or {}; C.npc["Veilleur de l'aube Selgorm"] = "Dämmerungsbehüter Selgorm"
  C.npc = C.npc or {}; C.npc["Capitaine Vertepeau"] = "Captain Greenskin"
  C.npc = C.npc or {}; C.npc["Seigneur Wyrmthalak"] = "Oberanführer Wyrmthalak"
  C.npc = C.npc or {}; C.npc["Sage Recherche-la-vérité"] = "Sage Truthseeker"
  C.npc = C.npc or {}; C.npc["Theldurin l'Egaré"] = "Theldurin der Verirrte"
  C.npc = C.npc or {}; C.npc["Maître-artisan Overspark"] = "Tüftlermeister Overspark"
  C.npc = C.npc or {}; C.npc["Maréchal Maxwell"] = "Marshal Maxwell"
  C.npc = C.npc or {}; C.npc["TUER A VUE"] = "SOFORT TÖTEN"
  C.npc = C.npc or {}; C.npc["Baron d'Argelaine"] = "Baron Silverlaine"
  C.npc = C.npc or {}; C.npc["Gardien Thelwater"] = "Aufseher Thelwater"
  C.npc = C.npc or {}; C.npc["Matriarche Couveuse"] = "Mutter Glimmernetz"
  C.npc = C.npc or {}; C.npc["Grand Bricoleur Mekkanivelle"] = "Hochtüftler Mekkatorque"
  C.npc = C.npc or {}; C.npc["Leonid Barthalomew the Revered"] = "Leonid Barthalomew der Geachtete"
  C.npc = C.npc or {}; C.npc["Galamav le Tireur d'élite"] = "Galamav der Schütze"
  C.npc = C.npc or {}; C.npc["Vieux Serra'kis"] = "Old Serra'kis"
  C.npc = C.npc or {}; C.npc["Don de Menethil"] = "Menethils Geschenk"
  C.npc = C.npc or {}; C.npc["Esprit de Zaetar"] = "Zaetars Geist"
  C.npc = C.npc or {}; C.npc["Exilé atal'ai"] = "Verbannter der Atal'ai"
  C.npc = C.npc or {}; C.npc["John le Loqueteux"] = "Struppiger John"
  C.npc = C.npc or {}; C.npc["Hamuul Totem-Runique"] = "Hamuul Runetotem"
  C.npc = C.npc or {}; C.npc["Apothicaire Zamah"] = "Apothekerin Zamah"
  C.npc = C.npc or {}; C.npc["Charlga Trancheflanc"] = "Charlga Razorflank"
  C.npc = C.npc or {}; C.npc["Chef de guerre Rend Main-noire"] = "Kriegshäuptling Rend Blackhand"
  C.npc = C.npc or {}; C.npc["Terre-voyant Farsen"] = "Erdseher Farsen"
  C.npc = C.npc or {}; C.npc["Captain Truman"] = "Captain Truman"
  C.npc = C.npc or {}; C.npc["Fineous Sombrevire"] = "Fineous Darkvire"
  C.npc = C.npc or {}; C.npc["Eclaireur Riell"] = "Späherin Riell"
  C.npc = C.npc or {}; C.npc["Kam Deepfury"] = "Kam Deepfury"
  C.npc = C.npc or {}; C.npc["Raleigh le Dévot"] = "Raleigh der Andächtige"
  C.npc = C.npc or {}; C.npc["Lanfiche Brouillecircuit"] = "Plugger Spazzring"
  C.npc = C.npc or {}; C.npc["Paria centaure"] = "Zentaurenpariah"
  C.npc = C.npc or {}; C.npc["Brasero de Belnistrasz"] = "Belnistrasz’ Kohlenpfanne"
  C.npc = C.npc or {}; C.npc["Maître mécanicien Fontuyau"] = "Mechanikermeister Castpipe"
  C.where = C.where or {}; C.where["Profondeurs de Rochenoire"] = "Blackrocktiefen"
  C.where = C.where or {}; C.where["Salle des Thanes"] = "Die Halle der Thanen"
  C.where = C.where or {}; C.where["Forgefer"] = "Ironforge"
  C.where = C.where or {}; C.where["Les Pitons-du-Tonnerre"] = "Thunder Bluff"
  C.where = C.where or {}; C.where["Les Tarides"] = "Brachland"
  C.where = C.where or {}; C.where["Monastère écarlate"] = "Das Scharlachrote Kloster"
  C.where = C.where or {}; C.where["Cratère d'Un'Goro"] = "Un'Goro-Krater"
  C.where = C.where or {}; C.where["Marécage d'Âprefange"] = "Marschen von Dustwallow"
  C.where = C.where or {}; C.where["Profondeurs de Blackrock"] = "Blackrocktiefen"
  C.where = C.where or {}; C.where["Berceau-de-l'Hiver"] = "Winterspring"
  C.where = C.where or {}; C.where["Gouffre de Ragefeu"] = "Ragefireabgrund"
  C.where = C.where or {}; C.where["Hurlevent"] = "Stormwind"
  C.where = C.where or {}; C.where["Orneval"] = "Ashenvale"
  C.where = C.where or {}; C.where["Donjon d'Ombrecroc"] = "Burg Shadowfang"
  C.where = C.where or {}; C.where["Pic Rochenoire"] = "Blackrockspitze"
  C.where = C.where or {}; C.where["Souilles de Tranchebauge"] = "Die Hügel von Razorfen"
  C.where = C.where or {}; C.where["Profondeurs de Brassenoire"] = "Blackfathom-Tiefe"
  C.where = C.where or {}; C.where["Kraal de Tranchebauge"] = "Der Kral von Razorfen"
  C.where = C.where or {}; C.where["Reflet-de-Lune"] = "Moonglade"
  C.where = C.where or {}; C.where["Fossoyeuse"] = "Undercity"
  C.rep = C.rep or {}; C.rep["Baie-du-Butin"] = "Booty Bay"
  C.rep = C.rep or {}; C.rep["Thunder Bluff"] = "Thunder Bluff"
  C.rep = C.rep or {}; C.rep["Cercle terrestre"] = "Der Irdene Ring"
  C.rep = C.rep or {}; C.rep["Cartel Gentepression"] = "Steamwheedle-Kartell"
  C.rep = C.rep or {}; C.rep["Hurlevent"] = "Stormwind"
  C.rep = C.rep or {}; C.rep["Cabestan"] = "Ratchet"
  C.rep = C.rep or {}; C.rep["Forgefer"] = "Ironforge"
  C.rep = C.rep or {}; C.rep["Les Pitons-du-Tonnerre"] = "Thunder Bluff"
  C.rep = C.rep or {}; C.rep["Fossoyeuse"] = "Undercity"
  C.rep = C.rep or {}; C.rep["Trolls Sombrelance"] = "Darkspear"
  C.rep = C.rep or {}; C.rep["Stormwind"] = "Stormwind"
  C.item = C.item or {}; C.item["Sacoche du Totem-Sinistre"] = "Grimmtotemranzen"
  C.instance = C.instance or {}; C.instance["rfc"] = "Ragefireabgrund"
  C.instance = C.instance or {}; C.instance["hot"] = "Die Halle der Thanen"
  C.instance = C.instance or {}; C.instance["rol"] = "Die Ruinen von Lordaeron"
  C.instance = C.instance or {}; C.instance["sfk"] = "Burg Shadowfang"
  C.instance = C.instance or {}; C.instance["bfd"] = "Blackfathom-Tiefe"
  C.instance = C.instance or {}; C.instance["sm"] = "Das Scharlachrote Kloster"
  C.instance = C.instance or {}; C.instance["rfk"] = "Der Kral von Razorfen"
  C.instance = C.instance or {}; C.instance["rfd"] = "Die Hügel von Razorfen"
  C.instance = C.instance or {}; C.instance["st"] = "Versunkener Tempel"
  C.instance = C.instance or {}; C.instance["brd"] = "Blackrocktiefen"
  C.instance = C.instance or {}; C.instance["brs"] = "Blackrockspitze"
end
