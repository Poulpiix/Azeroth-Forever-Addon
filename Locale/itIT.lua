-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- Italiano. Complete: same keys as frFR and enUS. Tone: short and imperative, like the WoW UI.
-- Tokens (%s, %d, |cffRRGGBB, |r) are kept as in frFR. The Legacy tree keeps its original key prefix, only the displayed word is Eredità.
local ADDON_NAME, AF = ...

AF:RegisterLocale("itIT", {
  -- core
  ["core.loaded"] = "caricato%s. Digita |cffffd100/af|r o clicca sul pulsante della minimappa per aprire l'addon.",
  ["core.ui_missing"] = "Interfaccia non caricata.",

  -- path
  ["path.err.empty"] = "Percorso vuoto o troncato.",
  ["path.err.version"] = "Versione del percorso sconosciuta.",
  ["path.err.header"] = "Intestazione del percorso non valida.",
  ["path.err.too_long"] = "Percorso troppo lungo (più di %d punti).",
  ["path.err.char"] = "Carattere non valido nel percorso.",
  ["path.err.unknown_talent"] = "Talento sconosciuto in questo percorso.",
  ["path.err.maxed"] = "%s ha già raggiunto il grado massimo (%d).",
  ["path.err.cap"] = "Limite di %d punti raggiunto.",
  ["path.err.other_talent"] = "un altro talento",
  ["path.err.prereq"] = "%s richiede %s al grado %d.",
  ["path.err.tier"] = "%s richiede %d punti nell'albero %s (%d a questo punto del percorso).",
  ["path.err.cannot_remove"] = "Impossibile rimuovere %s: %s",

  -- talents
  ["talents.err.class_unknown"] = "Classe sconosciuta.",
  ["talents.err.talent_unknown"] = "Talento sconosciuto.",
  ["talents.count"] = "%d talenti",
  ["talents.head_sub"] = "%s · %s, %d nuovi e %d modificati",
  ["talents.client_data"] = "Dati del client %s",

  -- apply
  ["apply.err.unreadable"] = "Impossibile leggere i talenti del gioco: digita /af diag.",
  ["apply.err.not_found"] = "%s non trovato nel client.",
  ["apply.err.not_learnable"] = "%s non può ancora essere appreso (requisito o punti dell'albero).",
  ["apply.info.nothing_to_apply_learned"] = "Niente da applicare: la build è già appresa in gioco.",
  ["apply.err.cannot_unlearn"] = "Il gioco non permette di disimparare un solo punto appreso",
  ["apply.err.combat"] = "Impossibile in combattimento.",
  ["apply.err.locked"] = "Al momento non è possibile cambiare i talenti.",
  ["apply.err.no_points"] = "Nessun punto talento disponibile su questo personaggio.",
  ["apply.err.no_more_points"] = "Nessun punto disponibile per il resto della build.",
  ["apply.err.refused"] = "Il gioco ha rifiutato %s.",
  ["apply.err.nothing"] = "Niente da applicare.",
  ["apply.err.not_validated"] = "Il gioco non ha confermato i talenti.",
  ["apply.err.none_learned"] = "Nessun punto della build è appreso in gioco.",
  ["apply.err.refused_remove"] = "Il gioco ha rifiutato di rimuovere %s.",
  ["apply.ok.removed"] = "Rimosso in gioco: %s.",
  ["apply.err.timeout"] = "Il gioco non ha appreso i talenti richiesti.",
  ["apply.warn.learned.one"] = "%d punto appreso. %s",
  ["apply.warn.learned.other"] = "%d punti appresi. %s",
  ["apply.ok.build_applied"] = "Build applicata in gioco: %d punti appresi.",
  ["apply.ok.learned"] = "Appreso in gioco: %s.",

  -- share
  ["share.err.empty_any"] = "Incolla un codice che inizia con AF1- (classe) o AF1H- (Eredità).",
  ["share.err.not_af_any"] = "Non è un codice Azeroth Forever: deve iniziare con AF1- o AF1H-.",
  ["share.err.incomplete"] = "Codice incompleto: copialo per intero, fino agli ultimi 2 caratteri.",
  ["share.err.corrupt"] = "Codice danneggiato (checksum errato): copialo per intero.",
  ["share.err.kind"] = "Tipo di codice sconosciuto.",
  ["share.err.class_in_code"] = "Classe sconosciuta in questo codice.",
  ["share.err.empty_class"] = "Incolla un codice che inizia con AF1-.",
  ["share.err.is_heritage"] = "Questo è un codice Eredità: usa la scheda Eredità per leggerlo.",
  ["share.err.not_af_class"] = "Non è un codice Azeroth Forever: deve iniziare con AF1-.",
  ["share.err.class_or_catalog"] = "Classe sconosciuta in questo codice (o catalogo dei talenti diverso: aggiorna l'addon).",
  ["share.err.catalog_changed"] = "Il catalogo dei talenti è cambiato: aggiorna l'addon (%s)",
  ["share.err.impossible_order"] = "Questo codice descrive un ordine impossibile (passo %d): %s",
  ["share.export_error"] = "Impossibile esportare: %s",
  ["share.copy_link"] = "Copia il link",
  ["share.link_help_build"] = "Link a questa pagina (build + ordine dei punti)",
  ["share.copy_code"] = "Copia il codice addon",
  ["share.code_help_class"] = "Codice AF1- da incollare nell'addon o sul sito",
  ["share.code_title"] = "Codice addon",
  ["share.paste"] = "Incolla un codice",
  ["share.paste_menu_help"] = "Codice AF1- (classe) o AF1H- (Eredità)",
  ["share.paste_popup_help"] = "Codice AF1- (classe) o AF1H- (Eredità), poi Importa.",
  ["share.public_help"] = "Ctrl+C per copiare, poi apri il link nel browser.",
  ["share.public_title"] = "Build pubbliche %s",

  -- heritage
  ["heritage.err.is_class"] = "Questo è un codice di classe (AF1-), non un codice Eredità.",
  ["heritage.err.version"] = "Versione del codice Eredità sconosciuta: aggiorna il sito.",
  ["heritage.err.unreadable"] = "Codice Eredità illeggibile (%d gradi invece di %d).",
  ["heritage.err.rank_max"] = "%s non può superare il grado %d.",
  ["heritage.err.too_many"] = "Questo codice spende più di %d punti Eredità.",
  ["heritage.err.tiers"] = "Questo codice non rispetta le soglie di punti dell'albero.",
  ["heritage.err.node_unknown"] = "Nodo sconosciuto.",
  ["heritage.err.cap"] = "Limite Eredità di %d punti raggiunto.",
  ["heritage.err.tier_locked"] = "Livello non raggiunto per %s.",
  ["heritage.err.preset_invalid"] = "Preset non valido.",
  ["heritage.err.preset_unknown"] = "Preset sconosciuto.",
  ["heritage.title"] = "Albero dell'Eredità",
  ["heritage.sub"] = "Professioni · Avventura · Ingegno · %s",
  ["heritage.total_points"] = "%d punti",
  ["heritage.stat.spent_caps"] = "PUNTI SPESI",
  ["heritage.stat.left_caps"] = "PUNTI RIMASTI",
  ["heritage.reset_done"] = "Eredità reimpostata.",
  ["heritage.view_at"] = "Vedi la mia Eredità a %s punti spesi",
  ["heritage.unknown_skill"] = "Abilità sconosciuta",
  ["heritage.unknown_skill_hint"] = "Sarà aggiunta in un prossimo aggiornamento.",
  ["heritage.tip.rank_meta"] = "Grado %d/%d · %s",
  ["heritage.tip.passive"] = "Passiva",
  ["heritage.tip.at_points"] = "A %d punti spesi: grado %d/%d",
  ["heritage.tip.requires"] = "Richiede %d punti Eredità spesi in %s.",
  ["heritage.imported"] = "Eredità importata (%d punti).",
  ["heritage.link_help"] = "Link a questa pagina (?hbuild=)",
  ["heritage.code_help"] = "Codice AF1H- da incollare nell'addon o sul sito",
  ["heritage.talented_note"] = "I talenti di classe iniziano al livello 9.",
  ["heritage.tree.professions"] = "Professioni",
  ["heritage.col.professions.sub"] = "Artigianato, raccolta e oro.",
  ["heritage.node.travail-acharne.name"] = "Duro lavoro",
  ["heritage.node.travail-acharne.desc"] = "Aumenta del 4% la probabilità di guadagnare un punto abilità quando usi una professione primaria, secondaria o di classe.",
  ["heritage.node.marchandage.name"] = "Contrattazione",
  ["heritage.node.marchandage.desc"] = "Riduce del 5% il prezzo in oro degli oggetti acquistati da tutti i venditori.",
  ["heritage.node.chef-etoile.name"] = "Chef stellato",
  ["heritage.node.chef-etoile.desc"] = "Le tue ricette di Cucina hanno il 10% di probabilità di creare un risultato aggiuntivo.",
  ["heritage.node.etude-assidue.name"] = "Studio assiduo",
  ["heritage.node.etude-assidue.desc"] = "Aumenta di 1 punto la tua abilità più bassa tra le professioni primarie e secondarie attuali. Se hai già raggiunto 300 in entrambe le professioni primarie e in tutte e tre le secondarie, ottieni da 2 a 4 Essenze Elementali casuali.",
  ["heritage.node.etude-assidue.meta"] = "25 sec di lancio, 23 h di recupero",
  ["heritage.node.recolte-abondante.name"] = "Raccolto abbondante",
  ["heritage.node.recolte-abondante.desc"] = "Trovi il 20% in più di materiali non comuni con Estrazione, Erboristeria e Scuoiatura.",
  ["heritage.node.prime-de-rendement.name"] = "Premio di rendimento",
  ["heritage.node.prime-de-rendement.desc"] = "Hai il 5% di probabilità di ricevere il 100% in più di Favore del Mercante quando consegni una cassa all'Autorità Commerciale di Azeroth o alla Logistica di Durotar.",
  ["heritage.node.maitre-appateur.name"] = "Maestro dell'esca",
  ["heritage.node.maitre-appateur.desc"] = "Quando peschi con un'Esca attiva, hai il 25% di probabilità di catturare un pesce in più.",
  ["heritage.tree.adventure"] = "Avventura",
  ["heritage.col.adventure.sub"] = "Progressione, esplorazione e utilità.",
  ["heritage.node.haute-vigilance.name"] = "Massima allerta",
  ["heritage.node.haute-vigilance.desc"] = "Aumenta la tua capacità di individuare i bersagli furtivi vicini, come se il tuo livello fosse aumentato di 1. Inefficace nei campi di battaglia.",
  ["heritage.node.bien-repose.name"] = "Ben riposato",
  ["heritage.node.bien-repose.desc"] = "L'esperienza di riposo si accumula il 4% più in fretta e il suo limite aumenta del 4%.",
  ["heritage.node.talentueux.name"] = "Talentuoso",
  ["heritage.node.talentueux.desc"] = "Ottieni un punto talento a ogni livello a partire dal livello 9 invece che dal 10, senza mai superare 51 punti talento in totale.",
  ["heritage.node.frisson-aventure.name"] = "Brivido dell'avventura",
  ["heritage.node.frisson-aventure.desc"] = "Recuperi l'1% della salute e del mana massimi in 10 sec ogni volta che infliggi il colpo mortale a un nemico non trascurabile. Inefficace nelle spedizioni, nelle incursioni e nei campi di battaglia.",
  ["heritage.node.guide-de-terrain.name"] = "Guida da campo",
  ["heritage.node.guide-de-terrain.desc"] = "Riduce dell'8% il tempo di recupero per aggiungere elementi al campo.",
  ["heritage.node.grand-voyageur.name"] = "Viaggiatore esperto",
  ["heritage.node.grand-voyageur.desc"] = "Ricevi uno sconto del 50% su tutte le rotte di volo e la tua cavalcatura volante vola il 20% più veloce.",
  ["heritage.node.medecine-de-terrain.name"] = "Medicina da campo",
  ["heritage.node.medecine-de-terrain.desc"] = "Riduce di 5 sec la durata dell'effetto \"Bendato di recente\" quando usi una Benda. Inefficace nelle spedizioni, nelle incursioni e nei campi di battaglia.",
  ["heritage.tree.ingenuity"] = "Ingegno",
  ["heritage.col.ingenuity.sub"] = "Manutenzione, reputazione e onore.",
  ["heritage.node.pour-un-plus-grand-honneur.name"] = "Per un onore più grande",
  ["heritage.node.pour-un-plus-grand-honneur.desc"] = "Aumenta del 2% i Punti Onore ottenuti.",
  ["heritage.node.gourmet.name"] = "Buongustaio",
  ["heritage.node.gourmet.desc"] = "Aumenta del 33% la durata degli effetti benefici del cibo.",
  ["heritage.node.permanence.name"] = "Permanenza",
  ["heritage.node.permanence.desc"] = "I bonus di statistiche o attributi di lunga durata che le abilità della tua classe conferiscono al gruppo o all'incursione durano il 50% in più, così come i benefici del riposo in un campo.",
  ["heritage.node.les-vifs-et-les-morts.name"] = "I vivi e i morti",
  ["heritage.node.les-vifs-et-les-morts.desc"] = "Aumenta del 5% la tua velocità di movimento da morto, e i tuoi incantesimi e le tue abilità benefici non costano risorse per 1 min dopo una resurrezione o finché non entri in combattimento.",
  ["heritage.node.economie-de-reactifs.name"] = "Risparmio di reagenti",
  ["heritage.node.economie-de-reactifs.desc"] = "Le abilità della tua classe non richiedono più reagenti acquistabili da un venditore, e gli elementi del campo di grado 1 non richiedono reagenti per essere creati.",
  ["heritage.node.renforcement.name"] = "Rinforzo",
  ["heritage.node.renforcement.desc"] = "Perdi l'8% di durevolezza in meno quando muori.",
  ["heritage.node.diplomate.name"] = "Diplomatico",
  ["heritage.node.diplomate.desc"] = "Aumenta del 2% i tuoi guadagni di reputazione.",

  -- tab
  ["tab.talents"] = "Talenti",
  ["tab.heritage"] = "Eredità",
  ["tab.dungeons"] = "Spedizioni e Incursioni",

  -- faction
  ["faction.alliance_caps"] = "ALLEANZA",
  ["faction.horde_caps"] = "ORDA",
  ["faction.alliance"] = "Alleanza",
  ["faction.horde"] = "Orda",
  ["faction.both"] = "Neutrale",

  -- ui
  ["ui.err_section"] = "Errore dell'interfaccia (%s): %s",
  ["ui.err"] = "Errore dell'interfaccia: %s",
  ["ui.tagline"] = "STRUMENTI PER WOW FOREVER",
  ["ui.close"] = "Chiudi (Esc)",
  ["ui.site_tip"] = "Link del sito da copiare",
  ["ui.site_title"] = "Sito di Azeroth Forever",
  ["ui.site_hint"] = "Ctrl+C per copiare il link, poi incollalo nel browser.",

  -- cmd
  ["cmd.scale"] = "Scala della finestra: %s",
  ["cmd.diag_saved"] = "Diagnostica salvata in SavedVariables\\AzerothForever.lua dopo /reload.",
  ["cmd.debug"] = "Modalità debug: %s",
  ["cmd.help"] = "Comandi: /af, /af talents, /af legacy, /af dungeons, /af scale 0.8, /af diag, /af survey, /af loot, /af minimap, /af locale, /af debug",
  ["cmd.locale_current"] = "Lingua attiva: %s (client: %s). Per cambiare: /af locale frFR, /af locale auto.",
  ["cmd.locale_set"] = "Lingua: %s. Digita /reload per applicarla.",
  ["cmd.locale_auto"] = "Lingua automatica (%s). Digita /reload per applicarla.",
  ["cmd.locale_bad"] = "Lingua sconosciuta: %s. Valori possibili: %s.",
  -- language picker (header)
  ["lang.button_tip"] = "Lingua dell'addon",
  ["lang.auto"] = "Lingua del gioco",
  ["lang.auto_help"] = "Attuale: %s",
  ["lang.need_client"] = "Richiede il gioco in questa lingua (caratteri)",
  ["lang.reload_confirm"] = "Lingua scelta: %s. Verrà applicata al ricaricamento dell'interfaccia. Ricaricare ora?",
  ["lang.reload"] = "Ricarica",
  ["lang.frFR"] = "Francese",
  ["lang.enUS"] = "Inglese",
  ["lang.deDE"] = "Tedesco",
  ["lang.esES"] = "Spagnolo (Spagna)",
  ["lang.esMX"] = "Spagnolo (Messico)",
  ["lang.itIT"] = "Italiano",
  ["lang.koKR"] = "Coreano",
  ["lang.jaJP"] = "Giapponese",

  -- state
  ["state.on"] = "attivata",
  ["state.off"] = "disattivata",
  ["state.done"] = "Completata",
  ["state.log"] = "In corso",
  ["state.avail"] = "Disponibile",
  ["state.locked"] = "Non disponibile",
  ["state.done_caps"] = "Completata",
  ["state.log_caps"] = "In corso",
  ["state.avail_caps"] = "Disponibile",
  ["state.locked_caps"] = "Non disponibile",

  -- minimap
  ["minimap.tip.left"] = "Clic sinistro: apri / chiudi",
  ["minimap.tip.right"] = "Clic destro: Spedizioni e Incursioni",
  ["minimap.tip.drag"] = "Trascina: sposta il pulsante",
  ["minimap.tip.cmd"] = "/af minimap: nascondi / mostra",
  ["minimap.hidden"] = "Pulsante della minimappa nascosto. Digita /af minimap per mostrarlo di nuovo.",
  ["minimap.shown"] = "Pulsante della minimappa mostrato.",

  -- common
  ["common.close"] = "Chiudi",
  ["common.import"] = "Importa",
  ["common.cancel"] = "Annulla",
  ["common.ok"] = "OK",
  ["common.confirm"] = "Conferma",
  ["common.lvl"] = "Liv. %s",
  ["common.lvl_lower"] = "liv. %s",
  ["common.level_n"] = "Livello %s",
  ["common.required_n"] = "richiesto %s",
  ["common.show"] = "Mostra",

  -- popup
  ["popup.copy_help"] = "Ctrl+C per copiare, Esc per chiudere.",
  ["popup.code_unreadable"] = "Codice illeggibile.",

  -- status
  ["status.new"] = "Nuovo",
  ["status.changed"] = "Modificato",
  ["status.unchanged"] = "Identico verificato",

  -- mode
  ["mode.final"] = "Build livello 60",
  ["mode.path"] = "Build livello per livello",
  ["mode.final_hint"] = "Build livello 60: posizioni i punti finali, l'ordine di livellamento viene calcolato per te.",
  ["mode.path_hint"] = "Build livello per livello: ogni clic è il prossimo punto che prenderai salendo di livello.",

  -- badge
  ["badge.changed_from_classic"] = "Modificato rispetto a Classic",
  ["badge.new_in_forever"] = "Novità di Forever",

  -- stat
  ["stat.spent_caps"] = "PUNTI SPESI",
  ["stat.left_caps"] = "PUNTI RIMASTI",
  ["stat.level_required_caps"] = "LIVELLO RICHIESTO",
  ["stat.available_caps"] = "DISPONIBILI",
  ["stat.spent_short_caps"] = "SPESI",

  -- btn
  ["btn.public_builds"] = "Build pubbliche",
  ["btn.public_builds_class"] = "Build pubbliche %s",
  ["btn.share"] = "Condividi",
  ["btn.save"] = "Salva",
  ["btn.reset"] = "Reimposta",
  ["btn.view_order"] = "Vedi l'ordine dei punti",
  ["btn.automatic"] = "Automatico",
  ["btn.automatic_tip"] = "Applica in gioco il prossimo punto della build a ogni livello guadagnato",
  ["btn.sync"] = "Sincronizza",
  ["btn.sync_tip"] = "Sostituisce la build con i talenti appresi da questo personaggio",
  ["btn.undo"] = "Annulla",
  ["btn.undo_tip"] = "Rimuove in gioco l'ultimo punto appreso",
  ["btn.apply_all"] = "Applica tutti i punti",
  ["btn.apply_all_tip"] = "Applica in gioco tutti i punti della build",
  ["btn.apply_next"] = "Applica il prossimo punto",
  ["btn.apply_next_tip"] = "Applica in gioco il prossimo punto della build",
  ["btn.apply"] = "Applica",

  -- toggle
  ["toggle.classic_version"] = "Versione Classic",

  -- planner
  ["planner.view_at_level"] = "Vedi la mia build al livello %s",

  -- tree
  ["tree.reset_tip"] = "Reimposta questo albero",
  ["tree.pts"] = "%d pt",
  ["tree.pts_at"] = "%d/%d pt",
  ["tree.warrior.arms"] = "Armi",
  ["tree.warrior.fury"] = "Furia",
  ["tree.warrior.protection"] = "Protezione",
  ["tree.paladin.holy"] = "Sacro",
  ["tree.paladin.protection"] = "Protezione",
  ["tree.paladin.retribution"] = "Castigo",
  ["tree.hunter.beast_mastery"] = "Padronanza delle Bestie",
  ["tree.hunter.marksmanship"] = "Precisione",
  ["tree.hunter.survival"] = "Sopravvivenza",
  ["tree.rogue.assassination"] = "Assassinio",
  ["tree.rogue.combat"] = "Combattimento",
  ["tree.rogue.subtlety"] = "Scaltrezza",
  ["tree.priest.discipline"] = "Disciplina",
  ["tree.priest.holy"] = "Sacro",
  ["tree.priest.shadow"] = "Ombra",
  ["tree.shaman.elemental"] = "Elementale",
  ["tree.shaman.enhancement"] = "Potenziamento",
  ["tree.shaman.restoration"] = "Rigenerazione",
  ["tree.mage.arcane"] = "Arcano",
  ["tree.mage.fire"] = "Fuoco",
  ["tree.mage.frost"] = "Gelo",
  ["tree.warlock.affliction"] = "Afflizione",
  ["tree.warlock.demonology"] = "Demonologia",
  ["tree.warlock.destruction"] = "Distruzione",
  ["tree.druid.balance"] = "Equilibrio",
  ["tree.druid.feral"] = "Combattimento Ferino",
  ["tree.druid.restoration"] = "Rigenerazione",

  -- order
  ["order.title"] = "Ordine dei punti",
  ["order.empty"] = "Nessun punto assegnato. Clicca su un talento per iniziare.",

  -- footer
  ["footer.in_game_caps"] = "IN GIOCO",

  -- toast
  ["toast.build_cleared"] = "Build cancellata per %s.",
  ["toast.this_class"] = "questa classe",
  ["toast.other_class"] = "Stai guardando un'altra classe: torna alla tua classe per agire in gioco.",
  ["toast.synced.one"] = "Build sincronizzata: %d punto appreso in gioco.",
  ["toast.synced.other"] = "Build sincronizzata: %d punti appresi in gioco.",
  ["toast.build_imported"] = "Build importata: %s.",
  ["toast.point_tomtom"] = "Waypoint TomTom impostato: %s.",
  ["toast.point_map"] = "Segnaposto sulla mappa impostato: %s.",
  ["toast.point_unknown"] = "Posizione sconosciuta per %s.",

  -- confirm
  ["confirm.apply_all"] = "Applicare ora in gioco tutti i punti della build?",

  -- save
  ["save.title"] = "Salva la build",
  ["save.list_caps"] = "BUILD SALVATE SU QUESTO ACCOUNT",
  ["save.empty"] = "Nessuna build salvata per questa classe.",
  ["save.err.name"] = "Dai un nome alla build.",
  ["save.err.empty"] = "La build è vuota: niente da salvare.",
  ["save.ok"] = "Build \"%s\" salvata.",
  ["save.btn_delete"] = "Elimina",
  ["save.btn_load"] = "Carica",
  ["save.row_meta"] = "%d punti · %s",
  ["save.err.unreadable"] = "Impossibile leggere questa build con i dati attuali: %s",
  ["save.loaded"] = "Build \"%s\" caricata.",

  -- tip
  ["tip.rank"] = "Grado %d/%d",
  ["tip.next_rank_caps"] = "GRADO SUCCESSIVO",
  ["tip.classic_caps"] = "CLASSIC",
  ["tip.at_level"] = "Al livello %d: grado %d/%d",
  ["tip.next_rank_classic"] = "Grado successivo (Classic): %s",
  ["tip.requires_tree_points"] = "Richiede %d punti in questo albero.",
  ["tip.requires_rank"] = "%s (grado %d)",
  ["tip.requires_list"] = "Richiede: %s",
  ["tip.learned_in_game"] = "Appreso in gioco: %d/%d",
  ["tip.click_learn"] = "Clic: impara · Clic destro: disimpara",

  -- preset
  ["preset.leveling"] = "Avventura",
  ["preset.metiers"] = "Professioni",
  ["preset.qdv60"] = "Ingegno",
  ["preset.applied"] = "Preset \"%s\" applicato (%d punti).",
  ["preset.err"] = "Impossibile applicare il preset.",

  -- origin
  ["origin.classic"] = "Classic",

  -- type
  ["type.dungeon_new"] = "Nuova spedizione Forever",
  ["type.dungeon_classic"] = "Spedizione Classic",
  ["type.raid_new"] = "Nuova incursione Forever",
  ["type.raid_classic"] = "Incursione Classic",
  ["type.instance_new"] = "Nuova istanza Forever",
  ["type.instance_classic"] = "Istanza Classic",

  -- rep
  ["rep.orgrimmar"] = "Orgrimmar",
  ["rep.thunder_bluff"] = "Picco del Tuono",
  ["rep.undercity"] = "Sepolcropoli",
  ["rep.ironforge"] = "Forgiaferro",
  ["rep.stormwind"] = "Roccavento",
  ["rep.darnassus"] = "Darnassus",
  ["rep.gnomeregan_exiles"] = "Esuli di Gnomeregan",
  ["rep.ratchet"] = "Ratchet",
  ["rep.gadgetzan"] = "Meccania",
  ["rep.argent_dawn"] = "Alba d'Argento",
  ["rep.cenarion_circle"] = "Circolo Cenariano",

  -- chain
  ["chain.part"] = "Parte di una catena (passi da registrare)",
  ["chain.next"] = "Seguito di una catena (passi da registrare)",
  ["chain.teleporter"] = "Catena legata al teletrasporto di Gnomeregan",
  ["chain.title_caps"] = "CATENA DI MISSIONI: PASSI PRECEDENTI",
  ["chain.start_outside"] = "La catena inizia fuori dall'istanza: %s.",
  ["chain.at_zone"] = "a %s",
  ["chain.from_npc"] = "da %s",
  ["chain.start_item"] = "La catena inizia con un oggetto trovato in gioco.",
  ["chain.to_verify"] = "da verificare",

  -- filter
  ["filter.all"] = "Tutte",
  ["filter.new"] = "Nuove",
  ["filter.raids"] = "Incursioni",

  -- section
  ["section.levels"] = "Livelli da %d a %d",
  ["section.raids"] = "Incursioni",

  -- unit
  ["unit.dungeon.one"] = "%d spedizione",
  ["unit.dungeon.other"] = "%d spedizioni",
  ["unit.raid.one"] = "%d incursione",
  ["unit.raid.other"] = "%d incursioni",
  ["unit.quest.one"] = "%d missione",
  ["unit.quest.other"] = "%d missioni",
  ["unit.boss.one"] = "%d boss",
  ["unit.boss.other"] = "%d boss",

  -- fmt
  ["fmt.thousands_sep"] = ".",
  ["fmt.date"] = "%1$s/%2$s/%3$s",

  -- money
  ["money.g"] = "o",
  ["money.s"] = "a",
  ["money.c"] = "r",

  -- card
  ["card.players"] = "%s giocatori",
  ["card.visual_soon_caps"] = "ILLUSTRAZIONE IN ARRIVO",
  ["card.faction"] = "Fazione: %s",
  ["card.level_recommended"] = "Liv. consigliato %s",
  ["card.level_max"] = "Livello %d",
  ["card.quests_todo"] = "Missioni: da definire",
  ["card.quests_side"] = "%s per %s",

  -- dungeons
  ["dungeons.footer"] = "Dati al %s - %d istanze",
  ["dungeons.footer_nodate"] = "Dati - %d istanze",
  ["dungeons.title"] = "Spedizioni e Incursioni",
  ["dungeons.sub"] = "Le %d spedizioni di World of Warcraft Forever, Classic e nuove, dal livello 13 al 60, più le incursioni.",
  ["search.placeholder"] = "Spedizione, boss o bottino…",
  ["search.none"] = "Nessun risultato",

  -- detail
  ["detail.back"] = "Tutte le spedizioni",
  ["detail.show_entrance"] = "Mostra l'ingresso",
  ["detail.tab_quests"] = "Missioni",
  ["detail.tab_boss"] = "Boss",
  ["detail.tab_quests_count"] = "Missioni %d",
  ["detail.tab_boss_count"] = "Boss %d",

  -- point
  ["point.this"] = "questa posizione",
  ["point.entrance"] = "Ingresso: %s",

  -- fact
  ["fact.zone"] = "Zona",
  ["fact.entry"] = "Ingresso",
  ["fact.faction"] = "Fazione",
  ["fact.level_required"] = "Livello richiesto",
  ["fact.group_finder"] = "Ricerca gruppo",
  ["fact.players"] = "Giocatori",
  ["fact.access_todo"] = "Accesso: da definire",

  -- boss
  ["boss.rare"] = "raro",
  ["boss.quest"] = "missione",
  ["boss.with"] = "con %s",
  ["boss.none"] = "Nessun boss noto per questa istanza.",
  ["boss.select"] = "Seleziona un boss.",
  ["boss.met"] = "incontrato in gioco",
  ["boss.no_pin"] = "nessuna posizione sulla mappa",
  ["boss.pin_with"] = "%s (con %s)",
  ["boss.caps"] = "BOSS",

  -- item
  ["item.loading"] = "Oggetto %d (caricamento)",

  -- loot
  ["loot.caps"] = "BOTTINO",
  ["loot.none"] = "Bottino non registrato per questo boss (beta).",
  ["loot.verify_classic_caps"] = "DA VERIFICARE: BOTTINO CLASSIC",
  ["loot.verify_external_caps"] = "DA VERIFICARE: FONTE ESTERNA",
  ["loot.seen"] = "%s in gioco su questo boss (%s).",
  ["loot.items_seen.one"] = "%d oggetto visto",
  ["loot.items_seen.other"] = "%d oggetti visti",
  ["loot.kills_noted.one"] = "%d uccisione registrata",
  ["loot.kills_noted.other"] = "%d uccisioni registrate",
  ["loot.disclaimer"] = "Il bottino può contenere errori, perché l'API di Blizzard alla base di World of Warcraft Forever nasconde molte informazioni, almeno durante la beta. Verrà aggiornato man mano. Non considerare questo elenco definitivo.",

  -- quest
  ["quest.meta_chain"] = "Catena",
  ["quest.meta_in_log"] = "nel registro",
  ["quest.meta_unconfirmed"] = "non confermata",
  ["quest.none_instance"] = "Nessuna missione nota per questa istanza.",
  ["quest.none_faction"] = "Nessuna missione per questa fazione.",
  ["quest.select"] = "Seleziona una missione.",
  ["quest.fallback_name"] = "Missione %d",
  ["quest.state_for"] = "%s per %s",
  ["quest.tag_level"] = "livello %s",
  ["quest.tag_chain"] = "Catena di missioni",
  ["quest.tag_unconfirmed"] = "Non confermata (beta)",
  ["quest.locked_hint"] = "Non disponibile: un passo precedente non è completato (vedi la catena qui sotto).",
  ["quest.objectives_caps"] = "OBIETTIVI",
  ["quest.giver_caps"] = "ASSEGNATARIO",
  ["quest.start_caps"] = "INIZIO",
  ["quest.turnin_caps"] = "CONSEGNA",
  ["quest.rewards_caps"] = "RICOMPENSE",
  ["quest.rewards_choice_caps"] = "RICOMPENSE: SCEGLI UN OGGETTO",
  ["quest.xp"] = "%s PE",
  ["quest.rewards_external"] = "Il gioco non fornisce ancora queste ricompense: provengono da una fonte esterna. Verifica in gioco.",
  ["quest.rewards_none"] = "Ricompense non registrate.",

  -- place
  ["place.unknown"] = "Sconosciuto",

  -- map
  ["map.floor_n"] = "Piano %d",
  ["map.level_n"] = "Livello %d",
  ["map.levels_caps"] = "LIVELLI",

  -- pin
  ["pin.no_position"] = "Nessuna posizione sulla mappa per ora",
  ["pin.click_loot"] = "Clic: vedi il suo bottino",
  ["pin.rare_prefix"] = "Raro. %s",
  ["pin.quest_boss_prefix"] = "Boss di missione. %s",
  ["pin.variable"] = "Posizione variabile: uno di questi %d punti. %s",
  ["pin.quest_item"] = "Oggetto di missione",
  ["pin.rare_off_list"] = "Raro, non presente nell'elenco dei boss",
  ["pin.to_verify"] = "Da verificare: assente dall'elenco dei boss",

  -- audit
  ["audit.done"] = "Rilevamento completato: %d/%d missioni note al server (%d sconosciute), %d/%d oggetti noti (%d sconosciuti), %d istanze nel diario. Digita /reload per salvarlo.",
  ["audit.running"] = "Rilevamento già in corso.",
  ["audit.started"] = "Rilevamento in corso: %d missioni e %d oggetti da richiedere al server (fino a 3 min).",
  ["audit.forbidden"] = "Azione rifiutata dal client: %s (annotata per una correzione).",
  ["audit.loot_summary"] = "Registrati nelle spedizioni: %d boss incontrati, %d oggetti da %d PNG. Conteggiati al prossimo rilevamento.",

  -- instfaction
  ["instfaction.both"] = "Orda / Alleanza",

  -- availability
  ["availability.not_open"] = "Non ancora aperta",
  ["availability.opens_dec9"] = "Apertura il 9 dic.",

  -- instance
  ["instance.group_change"] = "Dimensione del gruppo passata da 10 giocatori (Classic Era) a 5.",
})
