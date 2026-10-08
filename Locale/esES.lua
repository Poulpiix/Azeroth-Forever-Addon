-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- Espanol (Espana). Complete: same keys as frFR and enUS. Tone: short and imperative, like the WoW UI.
-- Tokens (%s, %d, |cffRRGGBB, |r) are kept as in frFR. The Legacy tree keeps its original key prefix, only the displayed word is Legado.
local ADDON_NAME, AF = ...

AF:RegisterLocale("esES", {
  -- core
  ["core.loaded"] = "cargado%s. Escribe |cffffd100/af|r o haz clic en el botón del minimapa para abrir el addon.",
  ["core.ui_missing"] = "Interfaz no cargada.",

  -- path
  ["path.err.empty"] = "Ruta vacía o truncada.",
  ["path.err.version"] = "Versión de ruta desconocida.",
  ["path.err.header"] = "Encabezado de ruta no válido.",
  ["path.err.too_long"] = "Ruta demasiado larga (más de %d puntos).",
  ["path.err.char"] = "Carácter no válido en la ruta.",
  ["path.err.unknown_talent"] = "Talento desconocido en esta ruta.",
  ["path.err.maxed"] = "%s ya está en el rango máximo (%d).",
  ["path.err.cap"] = "Límite de %d puntos alcanzado.",
  ["path.err.other_talent"] = "otro talento",
  ["path.err.prereq"] = "%s requiere %s en el rango %d.",
  ["path.err.tier"] = "%s requiere %d puntos en el árbol de %s (%d en este punto de la ruta).",
  ["path.err.cannot_remove"] = "No se puede quitar %s: %s",

  -- talents
  ["talents.err.class_unknown"] = "Clase desconocida.",
  ["talents.err.talent_unknown"] = "Talento desconocido.",
  ["talents.count"] = "%d talentos",
  ["talents.head_sub"] = "%s · %s, %d nuevos y %d modificados",
  ["talents.client_data"] = "Datos del cliente %s",

  -- apply
  ["apply.err.unreadable"] = "No se pueden leer los talentos del juego: escribe /af diag.",
  ["apply.err.not_found"] = "No se encontró %s en el cliente.",
  ["apply.err.not_learnable"] = "Aún no se puede aprender %s (requisito o puntos del árbol).",
  ["apply.info.nothing_to_apply_learned"] = "Nada que aplicar: la build ya está aprendida en el juego.",
  ["apply.err.cannot_unlearn"] = "El juego no permite desaprender un único punto aprendido",
  ["apply.err.combat"] = "No es posible en combate.",
  ["apply.err.locked"] = "No se pueden cambiar los talentos en este momento.",
  ["apply.err.no_points"] = "No hay puntos de talento disponibles en este personaje.",
  ["apply.err.no_more_points"] = "No quedan puntos disponibles para el resto de la build.",
  ["apply.err.refused"] = "El juego ha rechazado %s.",
  ["apply.err.nothing"] = "Nada que aplicar.",
  ["apply.err.not_validated"] = "El juego no ha confirmado los talentos.",
  ["apply.err.none_learned"] = "Ningún punto de la build está aprendido en el juego.",
  ["apply.err.refused_remove"] = "El juego ha rechazado quitar %s.",
  ["apply.ok.removed"] = "Quitado en el juego: %s.",
  ["apply.err.timeout"] = "El juego no ha aprendido los talentos solicitados.",
  ["apply.warn.learned.one"] = "%d punto aprendido. %s",
  ["apply.warn.learned.other"] = "%d puntos aprendidos. %s",
  ["apply.ok.build_applied"] = "Build aplicada en el juego: %d puntos aprendidos.",
  ["apply.ok.learned"] = "Aprendido en el juego: %s.",

  -- share
  ["share.err.empty_any"] = "Pega un código que empiece por AF1- (clase) o AF1H- (Legado).",
  ["share.err.not_af_any"] = "Este no es un código de Azeroth Forever: debe empezar por AF1- o AF1H-.",
  ["share.err.incomplete"] = "Código incompleto: cópialo entero, hasta los 2 últimos caracteres.",
  ["share.err.corrupt"] = "Código dañado (suma de control incorrecta): cópialo entero.",
  ["share.err.kind"] = "Tipo de código desconocido.",
  ["share.err.class_in_code"] = "Clase desconocida en este código.",
  ["share.err.empty_class"] = "Pega un código que empiece por AF1-.",
  ["share.err.is_heritage"] = "Este es un código de Legado: usa la pestaña Legado para leerlo.",
  ["share.err.not_af_class"] = "Este no es un código de Azeroth Forever: debe empezar por AF1-.",
  ["share.err.class_or_catalog"] = "Clase desconocida en este código (o catálogo de talentos distinto: actualiza el addon).",
  ["share.err.catalog_changed"] = "El catálogo de talentos ha cambiado: actualiza el addon (%s)",
  ["share.err.impossible_order"] = "Este código describe un orden imposible (paso %d): %s",
  ["share.export_error"] = "No se puede exportar: %s",
  ["share.copy_link"] = "Copiar enlace",
  ["share.link_help_build"] = "Enlace a esta página (build + orden de puntos)",
  ["share.copy_code"] = "Copiar código del addon",
  ["share.code_help_class"] = "Código AF1- para pegar en el addon o en el sitio web",
  ["share.code_title"] = "Código del addon",
  ["share.paste"] = "Pegar un código",
  ["share.paste_menu_help"] = "Código AF1- (clase) o AF1H- (Legado)",
  ["share.paste_popup_help"] = "Código AF1- (clase) o AF1H- (Legado), y luego Importar.",
  ["share.public_help"] = "Ctrl+C para copiar, y luego abre el enlace en tu navegador.",
  ["share.public_title"] = "Builds públicas %s",

  -- heritage
  ["heritage.err.is_class"] = "Este es un código de clase (AF1-), no un código de Legado.",
  ["heritage.err.version"] = "Versión de código de Legado desconocida: actualiza el sitio web.",
  ["heritage.err.unreadable"] = "Código de Legado ilegible (%d rangos en lugar de %d).",
  ["heritage.err.rank_max"] = "%s no puede superar el rango %d.",
  ["heritage.err.too_many"] = "Este código gasta más de %d puntos de Legado.",
  ["heritage.err.tiers"] = "Este código no respeta los niveles de puntos del árbol.",
  ["heritage.err.node_unknown"] = "Nodo desconocido.",
  ["heritage.err.cap"] = "Límite de Legado de %d puntos alcanzado.",
  ["heritage.err.tier_locked"] = "Nivel no alcanzado para %s.",
  ["heritage.err.preset_invalid"] = "Preajuste no válido.",
  ["heritage.err.preset_unknown"] = "Preajuste desconocido.",
  ["heritage.title"] = "Árbol de Legado",
  ["heritage.sub"] = "Profesiones · Aventura · Ingenio · %s",
  ["heritage.total_points"] = "%d puntos",
  ["heritage.stat.spent_caps"] = "PUNTOS GASTADOS",
  ["heritage.stat.left_caps"] = "PUNTOS RESTANTES",
  ["heritage.reset_done"] = "Legado restablecido.",
  ["heritage.view_at"] = "Ver mi build de Legado con %s puntos gastados",
  ["heritage.unknown_skill"] = "Habilidad desconocida",
  ["heritage.unknown_skill_hint"] = "Se añadirá en una futura actualización.",
  ["heritage.tip.rank_meta"] = "Rango %d/%d · %s",
  ["heritage.tip.passive"] = "Pasiva",
  ["heritage.tip.at_points"] = "Con %d puntos gastados: rango %d/%d",
  ["heritage.tip.requires"] = "Requiere %d puntos de Legado gastados en %s.",
  ["heritage.imported"] = "Legado importado (%d puntos).",
  ["heritage.link_help"] = "Enlace a esta página (?hbuild=)",
  ["heritage.code_help"] = "Código AF1H- para pegar en el addon o en el sitio web",
  ["heritage.talented_note"] = "Tus talentos de clase empiezan en el nivel 9.",
  ["heritage.tree.professions"] = "Profesiones",
  ["heritage.col.professions.sub"] = "Fabricación, recolección y oro.",
  ["heritage.node.travail-acharne.name"] = "Trabajo duro",
  ["heritage.node.travail-acharne.desc"] = "Aumenta un 4% tu probabilidad de ganar un punto de habilidad al usar una profesión primaria, secundaria o de clase.",
  ["heritage.node.marchandage.name"] = "Regateo",
  ["heritage.node.marchandage.desc"] = "Reduce un 5% el precio en oro de los objetos comprados a todos los vendedores.",
  ["heritage.node.chef-etoile.name"] = "Chef estrellado",
  ["heritage.node.chef-etoile.desc"] = "Tus recetas de Cocina tienen un 10% de probabilidad de crear un resultado adicional.",
  ["heritage.node.etude-assidue.name"] = "Estudio aplicado",
  ["heritage.node.etude-assidue.desc"] = "Aumenta en 1 punto tu habilidad más baja entre tus profesiones primarias y secundarias actuales. Si ya has alcanzado 300 en ambas profesiones primarias y en las tres secundarias, obtienes de 2 a 4 Esencias elementales aleatorias.",
  ["heritage.node.etude-assidue.meta"] = "25 s de lanzamiento, 23 h de reutilización",
  ["heritage.node.recolte-abondante.name"] = "Cosecha abundante",
  ["heritage.node.recolte-abondante.desc"] = "Encuentras un 20% más de materiales poco comunes al practicar Minería, Herboristería y Desollar.",
  ["heritage.node.prime-de-rendement.name"] = "Prima de rendimiento",
  ["heritage.node.prime-de-rendement.desc"] = "Tienes un 5% de probabilidad de recibir un 100% más de Favor del mercader al entregar un cajón a la Autoridad de Comercio de Azeroth o a Logística de Durotar.",
  ["heritage.node.maitre-appateur.name"] = "Maestro del cebo",
  ["heritage.node.maitre-appateur.desc"] = "Al pescar con un cebo activo, tienes un 25% de probabilidad de capturar un pez adicional.",
  ["heritage.tree.adventure"] = "Aventura",
  ["heritage.col.adventure.sub"] = "Progresión, exploración y utilidades.",
  ["heritage.node.haute-vigilance.name"] = "Alerta máxima",
  ["heritage.node.haute-vigilance.desc"] = "Aumenta tu capacidad para detectar objetivos sigilosos cercanos, como si tu nivel fuera 1 superior. No tiene efecto en campos de batalla.",
  ["heritage.node.bien-repose.name"] = "Bien descansado",
  ["heritage.node.bien-repose.desc"] = "Tu experiencia de descanso se acumula un 4% más rápido y su límite aumenta un 4%.",
  ["heritage.node.talentueux.name"] = "Talentoso",
  ["heritage.node.talentueux.desc"] = "Ganas un punto de talento en cada nivel a partir del nivel 9 en lugar del nivel 10, sin superar nunca los 51 puntos de talento en total.",
  ["heritage.node.frisson-aventure.name"] = "Emoción de la aventura",
  ["heritage.node.frisson-aventure.desc"] = "Recuperas un 1% de tu salud y maná máximos durante 10 s cada vez que das el golpe mortal a un enemigo no trivial. No tiene efecto en mazmorras, bandas ni campos de batalla.",
  ["heritage.node.guide-de-terrain.name"] = "Guía de campo",
  ["heritage.node.guide-de-terrain.desc"] = "Reduce un 8% el tiempo de reutilización para añadir elementos de campamento.",
  ["heritage.node.grand-voyageur.name"] = "Viajero experimentado",
  ["heritage.node.grand-voyageur.desc"] = "Recibes un 50% de descuento en todas las rutas de vuelo, y tu montura voladora vuela un 20% más rápido.",
  ["heritage.node.medecine-de-terrain.name"] = "Medicina de campo",
  ["heritage.node.medecine-de-terrain.desc"] = "Reduce en 5 s la duración del efecto \"Vendado recientemente\" al usar una venda. No tiene efecto en mazmorras, bandas ni campos de batalla.",
  ["heritage.tree.ingenuity"] = "Ingenio",
  ["heritage.col.ingenuity.sub"] = "Mantenimiento, reputación y honor.",
  ["heritage.node.pour-un-plus-grand-honneur.name"] = "Por un mayor honor",
  ["heritage.node.pour-un-plus-grand-honneur.desc"] = "Aumenta un 2% los puntos de honor obtenidos.",
  ["heritage.node.gourmet.name"] = "Gourmet",
  ["heritage.node.gourmet.desc"] = "Aumenta un 33% la duración de los efectos beneficiosos de la comida.",
  ["heritage.node.permanence.name"] = "Permanencia",
  ["heritage.node.permanence.desc"] = "Las bonificaciones de estadísticas o atributos de larga duración que tus habilidades de clase otorgan al grupo o a la banda duran un 50% más, al igual que los beneficios obtenidos al descansar en un campamento.",
  ["heritage.node.les-vifs-et-les-morts.name"] = "Los vivos y los muertos",
  ["heritage.node.les-vifs-et-les-morts.desc"] = "Aumenta un 5% tu velocidad de movimiento mientras estás muerto, y tus hechizos y habilidades beneficiosos no cuestan recursos durante 1 min tras una resurrección o hasta que entres en combate.",
  ["heritage.node.economie-de-reactifs.name"] = "Economía de componentes",
  ["heritage.node.economie-de-reactifs.desc"] = "Tus habilidades de clase ya no requieren componentes que se puedan comprar a un vendedor, y tus elementos de campamento de rango 1 no cuestan componentes al fabricarse.",
  ["heritage.node.renforcement.name"] = "Refuerzo",
  ["heritage.node.renforcement.desc"] = "Pierdes un 8% menos de durabilidad al morir.",
  ["heritage.node.diplomate.name"] = "Diplomático",
  ["heritage.node.diplomate.desc"] = "Aumenta un 2% tu ganancia de reputación.",

  -- tab
  ["tab.talents"] = "Talentos",
  ["tab.heritage"] = "Legado",
  ["tab.dungeons"] = "Mazmorras y bandas",

  -- faction
  ["faction.alliance_caps"] = "ALIANZA",
  ["faction.horde_caps"] = "HORDA",
  ["faction.alliance"] = "Alianza",
  ["faction.horde"] = "Horda",
  ["faction.both"] = "Neutral",

  -- ui
  ["ui.err_section"] = "Error de interfaz (%s): %s",
  ["ui.err"] = "Error de interfaz: %s",
  ["ui.tagline"] = "HERRAMIENTAS PARA WOW FOREVER",
  ["ui.close"] = "Cerrar (Esc)",
  ["ui.site_tip"] = "Enlace del sitio web para copiar",
  ["ui.site_title"] = "Sitio web de Azeroth Forever",
  ["ui.site_hint"] = "Ctrl+C para copiar el enlace, y luego pégalo en tu navegador.",

  -- cmd
  ["cmd.scale"] = "Escala de la ventana: %s",
  ["cmd.diag_saved"] = "Diagnóstico guardado en SavedVariables\\AzerothForever.lua tras /reload.",
  ["cmd.debug"] = "Modo de depuración: %s",
  ["cmd.help"] = "Comandos: /af, /af talents, /af legacy, /af dungeons, /af scale 0.8, /af diag, /af survey, /af loot, /af minimap, /af locale, /af debug",
  ["cmd.locale_current"] = "Idioma activo: %s (cliente: %s). Para cambiarlo: /af locale frFR, /af locale auto.",
  ["cmd.locale_set"] = "Idioma: %s. Escribe /reload para aplicarlo.",
  ["cmd.locale_auto"] = "Idioma automático (%s). Escribe /reload para aplicarlo.",
  ["cmd.locale_bad"] = "Idioma desconocido: %s. Valores posibles: %s.",

  -- state
  ["state.on"] = "activado",
  ["state.off"] = "desactivado",
  ["state.done"] = "Completada",
  ["state.log"] = "En curso",
  ["state.avail"] = "Disponible",
  ["state.locked"] = "No disponible",
  ["state.done_caps"] = "Completada",
  ["state.log_caps"] = "En Curso",
  ["state.avail_caps"] = "Disponible",
  ["state.locked_caps"] = "No Disponible",

  -- minimap
  ["minimap.tip.left"] = "Clic izquierdo: abrir / cerrar",
  ["minimap.tip.right"] = "Clic derecho: Mazmorras y bandas",
  ["minimap.tip.drag"] = "Arrastrar: mover el botón",
  ["minimap.tip.cmd"] = "/af minimap: ocultar / mostrar",
  ["minimap.hidden"] = "Botón del minimapa oculto. Escribe /af minimap para volver a mostrarlo.",
  ["minimap.shown"] = "Botón del minimapa mostrado.",

  -- common
  ["common.close"] = "Cerrar",
  ["common.import"] = "Importar",
  ["common.cancel"] = "Cancelar",
  ["common.ok"] = "Aceptar",
  ["common.confirm"] = "Confirmación",
  ["common.lvl"] = "Niv. %s",
  ["common.lvl_lower"] = "niv. %s",
  ["common.level_n"] = "Nivel %s",
  ["common.required_n"] = "requiere %s",
  ["common.show"] = "Mostrar",

  -- popup
  ["popup.copy_help"] = "Ctrl+C para copiar, Esc para cerrar.",
  ["popup.code_unreadable"] = "Código ilegible.",

  -- status
  ["status.new"] = "Nuevo",
  ["status.changed"] = "Modificado",
  ["status.unchanged"] = "Verificado idéntico",

  -- mode
  ["mode.final"] = "Build de nivel 60",
  ["mode.path"] = "Build nivel a nivel",
  ["mode.final_hint"] = "Build de nivel 60: tú colocas los puntos finales, el orden de subida de nivel se calcula por ti.",
  ["mode.path_hint"] = "Build nivel a nivel: cada clic es el siguiente punto que obtendrás al subir de nivel.",

  -- badge
  ["badge.changed_from_classic"] = "Modificado respecto a Classic",
  ["badge.new_in_forever"] = "Nuevo en Forever",

  -- stat
  ["stat.spent_caps"] = "PUNTOS GASTADOS",
  ["stat.left_caps"] = "PUNTOS RESTANTES",
  ["stat.level_required_caps"] = "NIVEL REQUERIDO",
  ["stat.available_caps"] = "DISPONIBLES",
  ["stat.spent_short_caps"] = "GASTADOS",

  -- btn
  ["btn.public_builds"] = "Builds públicas",
  ["btn.public_builds_class"] = "Builds públicas %s",
  ["btn.share"] = "Compartir",
  ["btn.save"] = "Guardar",
  ["btn.reset"] = "Restablecer",
  ["btn.view_order"] = "Ver orden de puntos",
  ["btn.automatic"] = "Automático",
  ["btn.automatic_tip"] = "Aplica el siguiente punto de la build en el juego cada vez que subes de nivel",
  ["btn.sync"] = "Sincronizar",
  ["btn.sync_tip"] = "Sustituye la build por los talentos aprendidos en este personaje",
  ["btn.undo"] = "Deshacer",
  ["btn.undo_tip"] = "Quita el último punto aprendido en el juego",
  ["btn.apply_all"] = "Aplicar todos los puntos",
  ["btn.apply_all_tip"] = "Aplica todos los puntos de la build en el juego",
  ["btn.apply_next"] = "Aplicar siguiente punto",
  ["btn.apply_next_tip"] = "Aplica el siguiente punto de la build en el juego",
  ["btn.apply"] = "Aplicar",

  -- toggle
  ["toggle.classic_version"] = "Versión Classic",

  -- planner
  ["planner.view_at_level"] = "Ver mi build en el nivel %s",

  -- tree
  ["tree.reset_tip"] = "Restablecer este árbol",
  ["tree.pts"] = "%d pts",
  ["tree.pts_at"] = "%d/%d pts",
  ["tree.warrior.arms"] = "Armas",
  ["tree.warrior.fury"] = "Furia",
  ["tree.warrior.protection"] = "Protección",
  ["tree.paladin.holy"] = "Sagrado",
  ["tree.paladin.protection"] = "Protección",
  ["tree.paladin.retribution"] = "Represión",
  ["tree.hunter.beast_mastery"] = "Dominio de bestias",
  ["tree.hunter.marksmanship"] = "Puntería",
  ["tree.hunter.survival"] = "Supervivencia",
  ["tree.rogue.assassination"] = "Asesinato",
  ["tree.rogue.combat"] = "Combate",
  ["tree.rogue.subtlety"] = "Sutileza",
  ["tree.priest.discipline"] = "Disciplina",
  ["tree.priest.holy"] = "Sagrado",
  ["tree.priest.shadow"] = "Sombras",
  ["tree.shaman.elemental"] = "Elemental",
  ["tree.shaman.enhancement"] = "Mejora",
  ["tree.shaman.restoration"] = "Restauración",
  ["tree.mage.arcane"] = "Arcano",
  ["tree.mage.fire"] = "Fuego",
  ["tree.mage.frost"] = "Escarcha",
  ["tree.warlock.affliction"] = "Aflicción",
  ["tree.warlock.demonology"] = "Demonología",
  ["tree.warlock.destruction"] = "Destrucción",
  ["tree.druid.balance"] = "Equilibrio",
  ["tree.druid.feral"] = "Feral",
  ["tree.druid.restoration"] = "Restauración",

  -- order
  ["order.title"] = "Orden de puntos",
  ["order.empty"] = "Ningún punto colocado. Haz clic en un talento para empezar.",

  -- footer
  ["footer.in_game_caps"] = "EN EL JUEGO",

  -- toast
  ["toast.build_cleared"] = "Build borrada para %s.",
  ["toast.this_class"] = "esta clase",
  ["toast.other_class"] = "Estás viendo otra clase: vuelve a tu clase para actuar en el juego.",
  ["toast.synced.one"] = "Build sincronizada: %d punto aprendido en el juego.",
  ["toast.synced.other"] = "Build sincronizada: %d puntos aprendidos en el juego.",
  ["toast.build_imported"] = "Build importada: %s.",
  ["toast.point_tomtom"] = "Punto de ruta de TomTom establecido: %s.",
  ["toast.point_map"] = "Marcador de mapa establecido: %s.",
  ["toast.point_unknown"] = "Ubicación desconocida para %s.",

  -- confirm
  ["confirm.apply_all"] = "¿Aplicar ahora todos los puntos de la build en el juego?",

  -- save
  ["save.title"] = "Guardar build",
  ["save.list_caps"] = "BUILDS GUARDADAS EN ESTA CUENTA",
  ["save.empty"] = "Ninguna build guardada para esta clase.",
  ["save.err.name"] = "Ponle un nombre a la build.",
  ["save.err.empty"] = "La build está vacía: nada que guardar.",
  ["save.ok"] = "Build \"%s\" guardada.",
  ["save.btn_delete"] = "Eliminar",
  ["save.btn_load"] = "Cargar",
  ["save.row_meta"] = "%d puntos · %s",
  ["save.err.unreadable"] = "No se puede leer esta build con los datos actuales: %s",
  ["save.loaded"] = "Build \"%s\" cargada.",

  -- tip
  ["tip.rank"] = "Rango %d/%d",
  ["tip.next_rank_caps"] = "SIGUIENTE RANGO",
  ["tip.classic_caps"] = "CLASSIC",
  ["tip.at_level"] = "En el nivel %d: rango %d/%d",
  ["tip.next_rank_classic"] = "Siguiente rango (Classic): %s",
  ["tip.requires_tree_points"] = "Requiere %d puntos en este árbol.",
  ["tip.requires_rank"] = "%s (rango %d)",
  ["tip.requires_list"] = "Requiere: %s",
  ["tip.learned_in_game"] = "Aprendido en el juego: %d/%d",
  ["tip.click_learn"] = "Clic: aprender · Clic derecho: desaprender",

  -- preset
  ["preset.leveling"] = "Aventura",
  ["preset.metiers"] = "Profesiones",
  ["preset.qdv60"] = "Ingenio",
  ["preset.applied"] = "Preajuste \"%s\" aplicado (%d puntos).",
  ["preset.err"] = "No se puede aplicar el preajuste.",

  -- origin
  ["origin.classic"] = "Classic",

  -- type
  ["type.dungeon_new"] = "Nueva mazmorra de Forever",
  ["type.dungeon_classic"] = "Mazmorra Classic",
  ["type.raid_new"] = "Nueva banda de Forever",
  ["type.raid_classic"] = "Banda Classic",
  ["type.instance_new"] = "Nueva instancia de Forever",
  ["type.instance_classic"] = "Instancia Classic",

  -- rep
  ["rep.orgrimmar"] = "Orgrimmar",
  ["rep.thunder_bluff"] = "Cima del Trueno",
  ["rep.undercity"] = "Entrañas",
  ["rep.ironforge"] = "Forjaz",
  ["rep.stormwind"] = "Ventormenta",
  ["rep.darnassus"] = "Darnassus",
  ["rep.gnomeregan_exiles"] = "Exiliados de Gnomeregan",
  ["rep.ratchet"] = "Trinquete",
  ["rep.gadgetzan"] = "Gadgetzan",
  ["rep.argent_dawn"] = "Alba Argenta",
  ["rep.cenarion_circle"] = "Círculo Cenarion",

  -- chain
  ["chain.part"] = "Parte de una cadena (pasos por registrar)",
  ["chain.next"] = "Siguiente de una cadena (pasos por registrar)",
  ["chain.teleporter"] = "Cadena vinculada al teletransportador de Gnomeregan",
  ["chain.title_caps"] = "CADENA DE MISIONES: PASOS PREVIOS",
  ["chain.start_outside"] = "La cadena empieza fuera de la instancia: %s.",
  ["chain.at_zone"] = "en %s",
  ["chain.from_npc"] = "de %s",
  ["chain.start_item"] = "La cadena empieza con un objeto encontrado en el juego.",
  ["chain.to_verify"] = "por verificar",

  -- filter
  ["filter.all"] = "Todas",
  ["filter.new"] = "Nuevas",
  ["filter.raids"] = "Bandas",

  -- section
  ["section.levels"] = "Niveles %d a %d",
  ["section.raids"] = "Bandas",

  -- unit
  ["unit.dungeon.one"] = "%d mazmorra",
  ["unit.dungeon.other"] = "%d mazmorras",
  ["unit.raid.one"] = "%d banda",
  ["unit.raid.other"] = "%d bandas",
  ["unit.quest.one"] = "%d misión",
  ["unit.quest.other"] = "%d misiones",
  ["unit.boss.one"] = "%d jefe",
  ["unit.boss.other"] = "%d jefes",

  -- fmt
  ["fmt.thousands_sep"] = ".",
  ["fmt.date"] = "%1$s/%2$s/%3$s",

  -- money
  ["money.g"] = "g",
  ["money.s"] = "s",
  ["money.c"] = "c",

  -- card
  ["card.players"] = "%s jugadores",
  ["card.visual_soon_caps"] = "ILUSTRACIÓN PRÓXIMAMENTE",
  ["card.faction"] = "Facción: %s",
  ["card.level_recommended"] = "Nivel recomendado: %s",
  ["card.level_max"] = "Nivel %d",
  ["card.quests_todo"] = "Misiones: por determinar",
  ["card.quests_side"] = "%s para %s",

  -- dungeons
  ["dungeons.footer"] = "Datos a fecha de %s - %d instancias",
  ["dungeons.footer_nodate"] = "Datos - %d instancias",
  ["dungeons.title"] = "Mazmorras y bandas",
  ["dungeons.sub"] = "Las %d mazmorras de World of Warcraft Forever, Classic y nuevas, del nivel 13 al 60, además de las bandas.",
  ["search.placeholder"] = "Mazmorra, jefe o botín…",
  ["search.none"] = "Sin resultados",

  -- detail
  ["detail.back"] = "Todas las mazmorras",
  ["detail.show_entrance"] = "Mostrar entrada",
  ["detail.tab_quests"] = "Misiones",
  ["detail.tab_boss"] = "Jefes",
  ["detail.tab_quests_count"] = "Misiones %d",
  ["detail.tab_boss_count"] = "Jefes %d",

  -- point
  ["point.this"] = "esta ubicación",
  ["point.entrance"] = "Entrada: %s",

  -- fact
  ["fact.zone"] = "Zona",
  ["fact.entry"] = "Entrada",
  ["fact.faction"] = "Facción",
  ["fact.level_required"] = "Nivel requerido",
  ["fact.group_finder"] = "Buscar grupo",
  ["fact.players"] = "Jugadores",
  ["fact.access_todo"] = "Acceso: por determinar",

  -- boss
  ["boss.rare"] = "élite raro",
  ["boss.quest"] = "misión",
  ["boss.with"] = "con %s",
  ["boss.none"] = "No se conoce ningún jefe en esta instancia.",
  ["boss.select"] = "Selecciona un jefe.",
  ["boss.met"] = "encontrado en el juego",
  ["boss.no_pin"] = "sin posición en el mapa",
  ["boss.pin_with"] = "%s (con %s)",
  ["boss.caps"] = "JEFE",

  -- item
  ["item.loading"] = "Objeto %d (cargando)",

  -- loot
  ["loot.caps"] = "BOTÍN",
  ["loot.none"] = "Botín no registrado para este jefe (beta).",
  ["loot.verify_classic_caps"] = "POR VERIFICAR: BOTÍN CLASSIC",
  ["loot.verify_external_caps"] = "POR VERIFICAR: FUENTE EXTERNA",
  ["loot.seen"] = "%s en el juego con este jefe (%s).",
  ["loot.items_seen.one"] = "%d objeto visto",
  ["loot.items_seen.other"] = "%d objetos vistos",
  ["loot.kills_noted.one"] = "%d muerte anotada",
  ["loot.kills_noted.other"] = "%d muertes anotadas",
  ["loot.disclaimer"] = "El botín puede contener errores, porque la API de Blizzard en la que se basa World of Warcraft Forever oculta mucha información, al menos durante la beta. Se actualizará sobre la marcha. No consideres esta lista como definitiva.",

  -- quest
  ["quest.meta_chain"] = "Cadena",
  ["quest.meta_in_log"] = "en el registro",
  ["quest.meta_unconfirmed"] = "sin confirmar",
  ["quest.none_instance"] = "No se conoce ninguna misión en esta instancia.",
  ["quest.none_faction"] = "No hay misiones para esta facción.",
  ["quest.select"] = "Selecciona una misión.",
  ["quest.fallback_name"] = "Misión %d",
  ["quest.state_for"] = "%s para %s",
  ["quest.tag_level"] = "nivel %s",
  ["quest.tag_chain"] = "Cadena de misiones",
  ["quest.tag_unconfirmed"] = "Sin confirmar (beta)",
  ["quest.locked_hint"] = "No disponible: un paso anterior no está completado (consulta la cadena más abajo).",
  ["quest.objectives_caps"] = "OBJETIVOS",
  ["quest.giver_caps"] = "OFRECE",
  ["quest.start_caps"] = "INICIO",
  ["quest.turnin_caps"] = "ENTREGA",
  ["quest.rewards_caps"] = "RECOMPENSAS",
  ["quest.rewards_choice_caps"] = "RECOMPENSAS: ELIGE UN OBJETO",
  ["quest.xp"] = "%s PX",
  ["quest.rewards_external"] = "El juego aún no proporciona estas recompensas: proceden de una fuente externa. Verifícalas en el juego.",
  ["quest.rewards_none"] = "Recompensas no registradas.",

  -- place
  ["place.unknown"] = "Desconocido",

  -- map
  ["map.floor_n"] = "Planta %d",
  ["map.level_n"] = "Nivel %d",
  ["map.levels_caps"] = "NIVELES",

  -- pin
  ["pin.no_position"] = "Sin posición en el mapa todavía",
  ["pin.click_loot"] = "Clic: ver su botín",
  ["pin.rare_prefix"] = "Raro. %s",
  ["pin.quest_boss_prefix"] = "Jefe de misión. %s",
  ["pin.variable"] = "Posición variable: uno de estos %d lugares. %s",
  ["pin.quest_item"] = "Objeto de misión",
  ["pin.rare_off_list"] = "Raro, no figura en la lista de jefes",
  ["pin.to_verify"] = "Por verificar: falta en la lista de jefes",

  -- audit
  ["audit.done"] = "Sondeo completado: %d/%d misiones conocidas por el servidor (%d desconocidas), %d/%d objetos conocidos (%d desconocidos), %d instancias en el diario. Escribe /reload para guardarlo.",
  ["audit.running"] = "Sondeo ya en curso.",
  ["audit.started"] = "Sondeo en curso: %d misiones y %d objetos por solicitar al servidor (hasta 3 min).",
  ["audit.forbidden"] = "Acción rechazada por el cliente: %s (anotado para corregirlo).",
  ["audit.loot_summary"] = "Registrado en mazmorras: %d jefes encontrados, %d objetos de %d PNJ. Se contará en el próximo sondeo.",

  -- instfaction
  ["instfaction.both"] = "Horda / Alianza",

  -- availability
  ["availability.not_open"] = "Aún no abierta",
  ["availability.opens_dec9"] = "Abre el 9 dic.",

  -- instance
  ["instance.group_change"] = "Tamaño de grupo cambiado de 10 jugadores (Classic Era) a 5.",
})

-- Boss names, keyed by the French name of Data/Journal.lua. Read by Names.lua N:BossName. A boss missing here uses its English name.
AF.Content = AF.Content or {}
AF.Content.esES = AF.Content.esES or {}
AF.Content.esES.npc = {
  -- wowhead forever zone=718 (Cavernes des lamentations). Lord Cobrahn, Lady Anacondra, Lord Pythas, Lord Serpentis, Kresh, Skum : nom anglais identique.
  ["Mutanus le Dévoreur"] = "Mutanus el Devorador",
  ["Verdan l'Immortel"] = "Verdan el Eterno",
  ["Dragon féérique déviant"] = "Dragón férico descarriado",
  -- wowhead forever zone=1581 (Les Mortemines). Rhahk'Zor, Sneed, Gilnid, Edwin VanCleef : nom anglais identique.
  ["Déchiqueteur de Sneed"] = "Trituradora de Sneed",
  ["Macaron"] = "Cocinitas",
  ["M. Smite"] = "Don Mamporro",
  ["Capitaine Vertepeau"] = "Capitán Verdetez",
  ["Mineur Johnson"] = "Minero Johnson",
  -- wowhead forever zone=722 (Souilles de Tranchebauge). Tuten'kash : nom anglais identique.
  ["Mordresh Oeil-de-feu"] = "Mordresh Ojo de Fuego",
  ["Glouton"] = "Glotón",
  ["Amnennar le Porte-froid"] = "Amnennar el Gélido",
  ["Pestegueule le Pourrissant"] = "Fauzpeste el Putrefacto",
  ["Groinfendu"] = "Morrandrajos",
  -- wowhead forever zone=2437 (Gouffre de Ragefeu). Bazzalan : nom anglais identique.
  ["Lorgnesilex"] = "Ogglesílex",
  ["Jergosh l'Invocateur"] = "Jergosh el Conjurador",
  ["Taragaman l'Affameur"] = "Taragaman el Hambriento",
  -- wowhead forever zone=491 (Kraal de Tranchebauge). Roogug : nom anglais identique.
  ["Aggem Mantépine"] = "Aggem Malaespina",
  ["Nécrorateur Jargba"] = "Portavoz de la muerte Jargba",
  ["Seigneur Brusquebroche"] = "Señor supremo Colmicarnero",
  ["Agathelos l'Enragé"] = "Agathelos el Furioso",
  ["Charlga Trancheflanc"] = "Charlga Filonavaja",
  ["Lanceur de Tranchebauge"] = "Cuerolanza de Rajacieno",
  ["Chasseur aveugle"] = "Cazador ciego",
  ["Implorateur de la terre Halmgar"] = "Clamor de Tierra Halmgar",
  -- wowhead forever zone=1337 (Uldaman). Revelosh, Baelog, Olaf, Grimlok, Archaedas : nom anglais identique.
  ["Eric « l'Agile »"] = "Eric \"El Suave\"",
  ["Ironaya"] = "Hierraya",
  ["Sentinelle d'obsidienne"] = "Centinela Obsidiano",
  ["Ancien gardien des pierres"] = "Vigilante pétreo anciano",
  ["Galgann Martel-de-feu"] = "Galgann Flamartillo",
  ["Les Disques de Norgannon"] = "Los Discos de Norgannon",
  ["Titre de propriété de Moulin-de-Tarren"] = "Las escrituras del Molino Tarren",
  -- wowhead forever zone=16919 (La salle des Thanes). Wowhead n'a pas de nom espagnol : traduction faite main (Martillo Funesto d'après l'objet 270260).
  ["Faldrim Courbenclume"] = "Faldrim Yunquemar",
  ["Pilleur"] = "Saqueo",
  ["Durgen Mornemartel"] = "Durgen Martillo Funesto",
  -- wowhead forever zone=209 (Donjon d'Ombrecroc). Rethilgore : nom anglais identique.
  ["Tranchegriffe le Boucher"] = "Zarpador el Carnicero",
  ["Baron d'Argelaine"] = "Barón Filargenta",
  ["Commandant Springvale"] = "Comandante Vallefont",
  ["Odo l'Aveugle"] = "Odo el Cegato",
  ["Fenrus le Dévoreur"] = "Fenrus el Devorador",
  ["Maître-loup Nandos"] = "Maestro de lobos Nandos",
  ["Archimage Arugal"] = "Archimago Arugal",
  ["Palefroi corrompu"] = "Corcel nefasto",
  ["Capitaine Ligemort"] = "Capitán Juramorte",
  -- wowhead forever zone=1176 (Zul'Farrak). Antu'sul, Gahz'rilla, Ruuzlu, Zerillis : nom anglais identique.
  ["Theka le Martyr"] = "Theka el Mártir",
  ["Sorcier-docteur Zum'rah"] = "Médico brujo Zum'rah",
  ["Hydromancienne Velratha"] = "Hidromántica Velratha",
  ["Nekrum Mâchetripes"] = "Nekrum Cometripas",
  ["Prêtre des ombres Sezz'ziz"] = "Sacerdote oscuro Sezz'ziz",
  ["Chef Ukorz Scalpessable"] = "Jefe Ukorz Cabellarena",
  ["Bourreau Sandfury"] = "Verdugo Furiarena",
  ["Sergent Bly"] = "Sargento Bly",
  ["Sandarr Ravadune"] = "Sandarr Asaltadunas",
  ["Ame en peine poudreuse"] = "Suciespectro",
  -- wowhead forever zone=719 (Profondeurs de Brassenoire). Autres boss : nom anglais identique.
  ["Baron Aquanis"] = "Barón Aquanis",
  ["Seigneur du crépuscule Kelris"] = "Señor Crepuscular Kelris",
  ["Vieux Serra'kis"] = "Viejo Serra'kis",
  -- wowhead forever zone=717 (La Prison). Hamhock, Bazil Thredd, Dextren Ward : nom anglais identique.
  ["Targorr le Terrifiant"] = "Targorr el Pavoroso",
  ["Kam Deepfury"] = "Kam Furiahonda",
  ["Bruegal Ironknuckle"] = "Bruegal Nudoferro",
  -- wowhead forever zone=721 (Gnomeregan). Grubbis : nom anglais identique.
  ["Techbot"] = "Tecnobot",
  ["Retombée visqueuse"] = "Radiactivo viscoso",
  ["Électrocuteur 6000"] = "Electrocutor 6000",
  ["Faucheur de foule 9-60"] = "Golpeamasa 9-60",
  ["Mekgénieur Thermaplugg"] = "Mekigeniero Termochufe",
  ["Ambassadeur Sombrefer"] = "Embajador Hierro Negro",
  -- wowhead forever zone=1584 (Profondeurs de Blackrock). Lord Roccor, Bael'Gar, Lord Incendius, Verek, Magmus : nom anglais identique.
  ["Maître-chien Grebmar"] = "Domador de jaurías Grebmar",
  ["Grand Interrogateur Gerstahn"] = "Alto Interrogador Gerstahn",
  ["Anub'shiah, Éviscérateur, Gorosh le Derviche, Grison, Hedrum le Rampant ou Ok'thor le Briseur"] = "Anub'shiah, Eviscerador, Gorosh el Endemoniado, Grisez, Hedrum el Trepador u Ok'thor el Rompedor",
  ["Pyromancien Blé-du-savoir"] = "Piromántico Cultugrano",
  ["Gardien Stilgiss"] = "Guarda Stilgiss",
  ["Fineous Sombrevire"] = "Finoso Virunegro",
  ["Général Forgehargne"] = "General Forjira",
  ["Seigneur golem Argelmach"] = "Señor Gólem Argelmach",
  ["Hurley Soufflenoir"] = "Hurley Negrálito",
  ["Phalange"] = "Falange",
  ["Lanfiche Brouillecircuit"] = "Plugger Aropatoso",
  ["Ribbly Fermevanne"] = "Ribbly Llavenrosca",
  ["Ambassadeur Cinglefouet"] = "Embajador Latifuego",
  ["Les Sept : Haine'rel, Colé'rel, Ignobl'rel, Funéb'rel, Fulmi'rel, Tragi'rel, Demeu'rel"] = "Los Siete: Hate'rel, Anger'rel, Vile'rel, Gloom'rel, Seeth'rel, Doom'rel, Dope'rel",
  ["Empereur Dagran Thaurissan"] = "Emperador Dagran Thaurissan",
  ["Princesse Moira Barbe-de-bronze"] = "Princesa Moira Barbabronce",
  ["Panzor l'Invincible"] = "Panzor el Invencible",
  -- wowhead forever zone=2017 (Stratholme). Balnazzar, Nerub'enkan, Skul : nom anglais identique.
  ["Timmy le Cruel"] = "Timmy el Cruel",
  ["Malor le Zélé"] = "Malor el Entusiasta",
  ["Maître canonnier Willey"] = "Maestro cañonero Willey",
  ["Archiviste Galford"] = "Archivista Galford",
  ["Magistrat Barthilas"] = "Magistrado Barthilas",
  ["Baronne Anastari"] = "Baronesa Anastari",
  ["Maleki le Blafard"] = "Maleki el Pálido",
  ["Ramstein Grandgosier"] = "Ramstein el Empachador",
  ["Baron Vaillefendre"] = "Barón Osahendido",
  ["Le Condamné"] = "El imperdonable",
  ["Hearthsinger Forresten"] = "Escupezones Foreste",
  ["Echine-de-pierre"] = "Pidrespina",
  ["Fras Siabi"] = "Fras Siabi",
  ["Postier Malown"] = "Jefe de correos Gassol",
  ["Forgeur de marteaux cramoisi"] = "Forjador de martillos carmesí",
  ["Fabricant d'épées de la Garde noire"] = "Armero Guardia Negra",
  -- wowhead forever (Monastère écarlate : Cimetière, rares).
  ["Azshir le Sans-sommeil"] = "Azshir el Insomne",
  ["Échine-de-fer"] = "Dorsacerado",
  ["Champion mort"] = "Campeón caído",
  -- wowhead forever (Monastère écarlate). Herod : nom anglais identique.
  ["Interrogateur Vishas"] = "Interrogador Vishas",
  ["Mage de sang Thalnos"] = "Mago sangriento Thalnos",
  ["Maître-chien Loksey"] = "Domador de jaurías Loksey",
  ["Arcaniste Doan"] = "Arcanista Doan",
  ["Grand Inquisiteur Fairbanks"] = "Alto inquisidor Ribalimpia",
  ["Commandant écarlate Mograine"] = "Comandante Escarlata Mograine",
  ["Grand Inquisiteur Whitemane"] = "Alta Inquisidora Melenablanca",
  -- wowhead forever zone=1477 (Temple d'Atal'Hakkar). Atal'alarion, Morphaz, Hazzas : nom anglais identique.
  ["Tisserand"] = "Sastrón",
  ["Fauche-rêve"] = "Guadañasueños",
  ["Jammal'an le prophète"] = "Jammal'an el Profeta",
  ["Ogom le Misérable"] = "Ogom el Desdichado",
  ["Avatar d'Hakkar"] = "Avatar de Hakkar",
  ["Ombre d'Eranikus"] = "Sombra de Eranikus",
  -- wowhead forever zone=2057 (Scholomance). Jandice Barov, Vectus, Instructor Malicia, Doctor Theolen Krastinov, Lord Alexei Barov, Lady Illucia Barov : nom anglais identique.
  ["Kirtonos le Héraut"] = "Kirtonos el Heraldo",
  ["Cliquettripes"] = "Traquesangre",
  ["Marduk Noirétang"] = "Marduz Pozonegro",
  ["Ras Murmegivre"] = "Ras Levescarcha",
  ["Gardien du savoir Polkelt"] = "Tradicionalista Polkelt",
  ["Le Voracien"] = "El Devorador",
  ["Sombre Maître Gandling"] = "Maestro oscuro Gandling",
  -- wowhead forever zone=2557 (Hache-tripes). Lethtendris, Magister Kalendris, Immol'thar, Tsu'zee, Ferra, Pimgib : nom anglais identique.
  ["Pusillin"] = "Pusillín",
  ["Zevrim Sabot-de-ronce"] = "Zevrim Pezuñahendida",
  ["Hydrogénos"] = "Hidromilecio",
  ["Alzzin le Modeleur"] = "Alzzin el Formaferal",
  ["Tendris Crochebois"] = "Tendris Madeguerra",
  ["Illyanna Corvichêne"] = "Illyanna Roblecuervo",
  ["Prince Tortheldrin"] = "Príncipe Tortheldrin",
  ["Garde Mol'dar"] = "Guardia Mol'dar",
  ["Garde Fengus"] = "Guardia Fengus",
  ["Garde Slip'kik"] = "Guardia Slip'kik",
  ["Capitaine Kromcrush"] = "Capitán Kromcrush",
  ["Cho'Rush l'Observateur"] = "Cho'Rush el Observador",
  ["Roi Gordok"] = "Rey Gordok",
  ["Kreeg le Marteleur"] = "Vapuleador Kreeg",
  -- wowhead forever zone=2100 (Maraudon). Noxxion : nom anglais identique.
  ["Esprit de Veng"] = "Espíritu de Veng",
  ["Tranchefouet"] = "Latisable",
  ["Esprit de Maraudos"] = "Espíritu de Maraudos",
  ["Seigneur Vylelangue"] = "Lord Lenguavil",
  ["Celebras le Maudit"] = "Celebras el Maldito",
  ["Glissement de terrain"] = "Derrumblo",
  ["Artisan Gizlock"] = "Manitas Gizlock",
  ["Grippe-charogne"] = "Escamapodrida",
  ["Princesse Theradras"] = "Princesa Theradras",
  ["Meshlok le Moissonneur"] = "Meshlok el Cosechador",
  -- wowhead forever zone=16611 (Ruines de Lordaeron). L'Abandonné, Viktor le Vil, Capitaine de Lordaeron : traduction faite main (absent de Wowhead ES).
  ["Croc-Flétri"] = "Colmimarchito",
  ["L'Abandonné"] = "El Abandonado",
  ["Le Baron"] = "El barón",
  ["Viktor le Vil"] = "Viktor el Vil",
  ["Capitaine de Lordaeron"] = "Capitán de Lordaeron",
  -- wowhead forever zone=2717 (Cœur du Magma).
  ["Baron Geddon"] = "Barón Geddon",
  ["Messager de Sulfuron"] = "Sulfuron Presagista",
  ["Golemagg l'Incinérateur"] = "Golemagg el Incinerador",
  ["Chambellan Executus"] = "Mayordomo Executus",
  -- wowhead forever zone=3456 (Naxxramas).
  ["Grande veuve Faerlina"] = "Gran Viuda Faerlina",
  ["Noth le Porte-peste"] = "Noth el Pesteador",
  ["Heigan l'Impur"] = "Heigan el Impuro",
  ["Horreb"] = "Loatheb",
  ["Instructeur Razuvious"] = "Instructor Razuvious",
  ["Gothik le Moissonneur"] = "Gothik el Cosechador",
  ["Généralissime Mograine, Thane Korth'azz, Dame Blaumeux et Sire Zeliek"] = "Alto Señor Mograine, Thane Korth'azz, Lady Blaumeux y Sir Zeliek",
  ["Le Recousu"] = "Remendejo",
  ["Saphiron"] = "Sapphiron",
}

-- Item names the client has no translation for (Wowhead Forever shows them in [brackets]), by item id. Read by Names.lua N:ItemName.
AF.Content = AF.Content or {}
AF.Content.esES = AF.Content.esES or {}
AF.Content.esES.itemName = {
  -- zone=722 (Souilles de Tranchebauge), traduction faite main, nom officiel à confirmer en jeu.
  [10775] = "Caparazón de Tuten'kash",
  [10771] = "Fajín de mago de la muerte",
  [10772] = "Cuchilla del glotón",
  [10774] = "Hombreras de piel de carne",
  [10761] = "Daga de furia gélida",
  [10762] = "Togas del liche",
  [10763] = "Almete de metal gélido",
  [10764] = "Armadura de escalofrío mortal",
  [10765] = "Dedos de hueso",
  -- zone=491 (Kraal de Tranchebauge), traduction faite main, nom officiel à confirmer en jeu.
  [6682] = "Togas de médium",
  [6685] = "Manto de médium",
  [6688] = "Tocado de viento susurrante",
  [6690] = "Leotardos salvajes",
  [6691] = "Faca de colmillo de cerdo",
  [6692] = "Atracador de púas",
  [6693] = "Garra de Agamaggan",
  [6695] = "Amuleto de hueso estigio",
  [6696] = "Arco de acechador nocturno",
  [6697] = "Manto de ala de murciélago",
  -- zone=1337 (Uldaman), traduction faite main, nom officiel à confirmer en jeu.
  [9389] = "Bufas de Revelosh",
  [9390] = "Guantes de Revelosh",
  [9407] = "Leotardos de tejepiedra",
  [9411] = "Bufas de esquirla de roca",
  [9414] = "Leotardos de piel aceitada",
  [9415] = "Vestiduras tribales de Grimlok",
  [9416] = "Carga de Grimlok",
  -- butin de zone (Kraal, Uldaman) sans traduction sur Wowhead Forever, traduction faite main, nom officiel à confirmer en jeu.
  [2039] = "Anillo de las llanuras",
  [2264] = "Manto de ladrones",
  [9384] = "Navaja de Bóveda Pétrea",
  [9420] = "Salacot de aventurero",
  -- zone=1176 (Zul'Farrak), traduction faite main, nom officiel à confirmer en jeu.
  [9379] = "Sang'thraze el Desviador",
  [9467] = "Colmillo de Gahz'rilla",
  [9469] = "Armadura de escamas de Gahz'rilla",
  [9470] = "Máscara de mal mojo",
  [9473] = "Piel vudú gafada",
  [9474] = "Falda vudú gafada",
  [9475] = "Rebanadora diabólica",
  [9476] = "Bufas del gran malvado",
  [9477] = "El Ejecutor del jefe",
  [9639] = "La Mano de Antu'sul",
  [9640] = "Empuñaduras de tornillo",
  [11086] = "Jang'thraze el Protector",
  [12470] = "Tobilleras de acechador de arena",
  [18082] = "Bastón irritante de Zum'rah",
  -- zone=721 (Gnomeregan), traduction faite main (aucun nom FR, DE, ES sur Wowhead Forever), nom officiel à confirmer en jeu.
  [9447] = "Tuerca del Electrocutor",
  [9448] = "Trapo aceitoso de tanque araña",
  [9452] = "Hidrobastón",
  [9458] = "Núcleo central de Termochufe",
  [9461] = "Engranaje cargado",
  [9490] = "Megapicadora Gizmotrón",
  [9509] = "Leotardos de vertido de petróleo",
  [9510] = "Pisoteadores de caverna profunda",
  -- zone=1584 (Profondeurs de Blackrock), traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [811] = "Hacha de los bosques profundos",
  [11623] = "Capa de lanzaduendes",
  [11627] = "Grebas de pies ligeros",
  [11628] = "Arco del domador de jaurías",
  [11630] = "Balines de esquirla de roca",
  [11631] = "Guarda de caparazón pétreo",
  [11632] = "Hombreras de escoria terrestre",
  [11633] = "Caparazón de colmillo de araña",
  [11726] = "Cota de mallas de gladiador salvaje",
  [11728] = "Leotardos de gladiador salvaje",
  [11729] = "Yelmo de gladiador salvaje",
  [11730] = "Mandiletes de gladiador salvaje",
  [11731] = "Grebas de gladiador salvaje",
  [11745] = "Puños de Falange",
  [11747] = "Togas de zancudo de llamas",
  [11748] = "Caduceo pírico",
  [11749] = "Leotardos de escama abrasadora",
  [11750] = "Bastón de yesca",
  [11764] = "Brazaletes de piel de ceniza",
  [11765] = "Guardamuñecas de malla de pira",
  [11817] = "Espada del señor general",
  [11821] = "Leotardos de discordia bélica",
  [11822] = "Botas de omnihechizo",
  [11823] = "Falda de luminaria",
  [11841] = "Pantalones de diseñador jefe",
  [22240] = "Grebas de desesperación marchita",
  [22241] = "Bufas de guarda oscuro",
  [22242] = "Correa de Verek",
  -- zone=1584 (Profondeurs de Blackrock), vérifiés ensuite : traduction faite main, nom officiel à confirmer en jeu.
  [11735] = "Parche de furia colérica",
  [11746] = "Yelmo de cráneo de gólem",
  -- zone=2017 (Stratholme), traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [13107] = "Puños de magicráneo",
  [13340] = "Capa del Barón Negro",
  [13387] = "Faja de previsión",
  [13397] = "Capa de gárgola piel de piedra",
  [13400] = "Avambrazos del sádico",
  [13402] = "Galochas de Timmy",
  [13404] = "Máscara del imperdonable",
  [13405] = "Bufas de Plaga Nocturna gimientes",
  [18720] = "Sudario de los Nathrezim",
  [18722] = "Garras de la muerte",
  -- Monastère écarlate (Cimetière, rares), traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [7690] = "Torno de ébano",
  [7691] = "Sudario embalsamado",
  [7689] = "Alba mórbida",
  [7686] = "Ojo de Dorsacerado",
  [7688] = "Costillar de Dorsacerado",
  [7687] = "Puño de Dorsacerado",
  [7754] = "Botas de heraldo",
  [7731] = "Talismán de esquirla fantasmal",
  [7708] = "Varita necrótica",
  [7709] = "Leotardos añublados",
  [7730] = "Triturador de cobalto",
  -- Monastère écarlate, traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [7710] = "Vara de entrenamiento de Loksey",
  [7786] = "Partecabezas",
  [10332] = "Botas Escarlata",
  [7719] = "Yelmo de rabioso enfurecido",
  [10330] = "Leotardos Escarlata",
  [7717] = "Devastador",
  [7724] = "Guanteletes de divinidad",
  [7723] = "Poderío de Mograine",
  [7752] = "Asesina de sueños",
  [7757] = "Bastón de tejevientos",
  [7721] = "Mano de rectitud",
  [19507] = "Chal del inquisidor",
  [19508] = "Brazales de cuero marcados",
  [19509] = "Botas de malla polvorientas",
  [7685] = "Orbe del vidente olvidado",
  [7684] = "Manto de mago sangriento",
  [7714] = "Hoja hipnótica",
  [7713] = "Vara ilusoria",
  -- zone=1477 (Temple d'Atal'Hakkar), traduction faite main (aucun nom FR sur Wowhead Forever), nom officiel à confirmer en jeu.
  [10799] = "Pincho craneal",
  [10804] = "Puño de los condenados",
  [10807] = "Falda del profeta Atal'ai",
  [10833] = "Cuernos de Eranikus",
  [10838] = "Poderío de Hakkar",
  [10844] = "Aguja de Hakkar",
  [12243] = "Garra humeante",
  [12465] = "Paño de anochecer",
  [12466] = "Cordón de Aguja del Alba",
  -- zone=2057 (Scholomance), traduction faite main (aucun nom FR, DE, ES sur Wowhead Forever), nom officiel à confirmer en jeu.
  [14620] = "Faja de hueso mortal",
  [14621] = "Escarpes de hueso mortal",
  [14622] = "Guanteletes de hueso mortal",
  [14623] = "Musleras de hueso mortal",
  [14624] = "Coraza de hueso mortal",
  [14525] = "Guanteletes aferrahuesos",
  -- zone=2100 (Maraudon), traduction faite main (aucun nom FR, DE, ES sur Wowhead Forever), nom officiel à confirmer en jeu.
  [17710] = "Daga de piedra calcinada",
  [17713] = "Anillo de piedra negra",
  [17714] = "Brazales de la princesa de piedra",
  [17715] = "Ojo de Theradras",
  [17717] = "Rifle megadisparo",
  [17719] = "Espada focal del inventor",
  [17728] = "Botas de escamas de cocodrilo albino",
  [17730] = "Hacha mordisco de caimán",
  [17732] = "Manto de Escamapodrida",
  [17738] = "Garra de Celebras",
  [17739] = "Paño del guardián de la arboleda",
  [17740] = "Tocado del adivino",
  [17741] = "Abrazo de la naturaleza",
  [17745] = "Tirador nocivo",
  [17748] = "Sandalias de pudrevid",
  [17755] = "Fajín de crin de sátiro",
  [17766] = "Cetro de la princesa Theradras",
  [17943] = "Puño de piedra",
  -- zone=16611 (Ruines de Lordaeron), traduction faite main (nom anglais seulement sur Wowhead Forever), nom officiel à confirmer en jeu.
  [271211] = "Caminantes viles",
  [271217] = "Picadora de cadáveres",
  -- zone=2717 (Cœur du Magma, objets de zone de Ragnaros), traduction faite main (absent de Wowhead Forever dans cette langue), nom officiel à confirmer en jeu.
  [13116] = "Bufas de lo Invisible",
  [5267] = "Kris escarlata",
  -- zone=3456 (Naxxramas, Kel'Thuzad), traduction faite main (absent de Wowhead Forever en FR, DE, ES), nom officiel à confirmer en jeu.
  [23577] = "El frío hambriento",
}

AF.Content = AF.Content or {}
AF.Content.esES = AF.Content.esES or {}
AF.Content.esES.where = {
  ["Azshara"] = "Azshara",
  ["Berceau-de-l'Hiver"] = "Cuna del Invierno",
  ["Bois de la Pénombre"] = "Bosque del Ocaso",
  ["Cime des Anciens, Pitons-du-Tonnerre"] = "Colina de los Ancianos, Cima del Trueno",
  ["Clairières de Tirisfal"] = "Claros de Tirisfal",
  ["Comté-du-Lac, Carmines"] = "Villa del Lago, Montañas Crestagrana",
  ["Contreforts de Hautebrande"] = "Laderas de Trabalomas",
  ["Cratère d'Un'Goro"] = "Cráter de Un'Goro",
  ["Darnassus"] = "Darnassus",
  ["Devant la Prison, Hurlevent"] = "Frente a Las Mazmorras, Ventormenta",
  ["Donjon d'Ombrecroc"] = "Castillo de Colmillo Oscuro",
  ["Dun Morogh"] = "Dun Morogh",
  ["Durotar"] = "Durotar",
  ["Désolace"] = "Desolace",
  ["Forgefer"] = "Forjaz",
  ["Forêt des Pins-Argentés"] = "Bosque de Argénteos",
  ["Fossoyeuse"] = "Entrañas",
  ["Féralas"] = "Feralas",
  ["Gnomeregan"] = "Gnomeregan",
  ["Gouffre de Ragefeu"] = "Sima Ígnea",
  ["Hache-tripes"] = "La Masacre",
  ["Hurlevent"] = "Ventormenta",
  ["Intérieur Gnomeregan"] = "Interior de Gnomeregan",
  ["Intérieur du Kraal (escorte)"] = "Interior del Horado (escolta)",
  ["Kraal de Tranchebauge"] = "Horado Rajacieno",
  ["Le temple d'Atal'Hakkar"] = "El Templo de Atal'Hakkar",
  ["Les Carmines"] = "Montañas Crestagrana",
  ["Les Hinterlands"] = "Las Tierras del Interior",
  ["Les Paluns"] = "Los Humedales",
  ["Les Pitons-du-Tonnerre"] = "Cima del Trueno",
  ["Les Tarides"] = "Los Baldíos",
  ["Loch Modan"] = "Loch Modan",
  ["Maleterres de l'Est"] = "Tierras de la Peste del Este",
  ["Maleterres de l'Ouest"] = "Tierras de la Peste del Oeste",
  ["Marais des Chagrins"] = "Pantano de las Penas",
  ["Maraudon"] = "Maraudon",
  ["Marche de l'Ouest"] = "Páramos de Poniente",
  ["Marécage d'Âprefange"] = "Marjal Revolcafango",
  ["Mille pointes"] = "Mil Agujas",
  ["Monastère écarlate"] = "Monasterio Escarlata",
  ["Orgrimmar"] = "Orgrimmar",
  ["Orneval"] = "Vallefresno",
  ["Pic Rochenoire"] = "Cumbre de Roca Negra",
  ["Profondeurs de Blackrock"] = "Profundidades de Roca Negra",
  ["Profondeurs de Brassenoire"] = "Cavernas de Brazanegra",
  ["Reflet-de-Lune"] = "Claro de la Luna",
  ["Refuge de Pierre-du-Pic / Orneval"] = "Pico Espolón / Vallefresno",
  ["Salle des Thanes"] = "Sala de los Thanes",
  ["Sombre-Comté"] = "Villa Oscura",
  ["Sombrivage"] = "Costa Oscura",
  ["Sortie des Mortemines"] = "Salida de las Minas de la Muerte",
  ["Souilles de Tranchebauge"] = "Zahúrda Rajacieno",
  ["Steppes ardentes"] = "Estepas Ardientes",
  ["Stratholme"] = "Stratholme",
  ["Tanaris"] = "Tanaris",
  ["Terres foudroyées"] = "Las Tierras Devastadas",
  ["Terres ingrates"] = "Tierras Inhóspitas",
  ["Uldaman"] = "Uldaman",
  ["Vallée de Strangleronce"] = "Vega de Tuercespina",
}
AF.Content.esES.rep = {
  ["Alliance"] = "Alianza",
  ["Aube d'argent"] = "Alba Argenta",
  ["Baie-du-Butin"] = "Bahía del Botín",
  ["Cabestan"] = "Trinquete",
  ["Cartel Gentepression"] = "Cártel Bonvapor",
  ["Cercle cénarien"] = "Círculo Cenarion",
  ["Cercle terrestre"] = "Círculo Terrestre",
  ["Clan Marteau-Hardi"] = "Clan Martillo Salvaje",
  ["Darnassus"] = "Darnassus",
  ["Exilés de Gnomeregan"] = "Exiliados de Gnomeregan",
  ["Forgefer"] = "Forjaz",
  ["Fossoyeuse"] = "Entrañas",
  ["Gadgetzan"] = "Gadgetzan",
  ["Horde"] = "Horda",
  ["Hurlevent"] = "Ventormenta",
  ["La Voile sanglante"] = "Bucaneros Velasangre",
  ["Les Pitons-du-Tonnerre"] = "Cima del Trueno",
  ["Orgrimmar"] = "Orgrimmar",
  ["Shen'dralar"] = "Shen'dralar",
  ["Stormwind"] = "Ventormenta",
  ["Thunder Bluff"] = "Cima del Trueno",
  ["Trolls Sombrelance"] = "Trols Lanza Oscura",
}
AF.Content.esES.entry = {
  ["Au-dessus du Site de fouilles de Whelgar"] = "Sobre las Excavaciones de Whelgar",
  ["Dalaran, barrière tombée"] = "Dalaran, barrera caída",
  ["Dans les collines d'Un'Goro."] = "En las colinas de Un'Goro.",
  ["Derrière les portes furbolgs, nord d'Azshara"] = "Tras las puertas de los furbolgs, al norte de Azshara",
  ["Donjon au nord du Sépulcre"] = "Fortaleza al norte del Sepulcro",
  ["Donjon extérieur, dans la Prairie du Fleuve."] = "Mazmorra exterior, en la Pradera del Río.",
  ["Faille de l'Ombre, Orgrimmar"] = "Grieta de las Sombras, Orgrimmar",
  ["Mine de Ruisselune, Marche de l'Ouest"] = "Mina de Moonbrook, Páramos de Poniente",
  ["Nord-est de Tirisfal, 4 ailes"] = "Noreste de Tirisfal, 4 alas",
  ["Oasis aux abords des Cavernes, Tarides"] = "Oasis a las afueras de las Cuevas, Los Baldíos",
  ["Porte de Gnomeregan, ou téléporteur Scooty à Cabestan"] = "Puerta de Gnomeregan, o teletransportador de Scooty en Trinquete",
  ["Prison de Hurlevent, Vieille ville"] = "Prisión de Ventormenta, Casco Antiguo",
  ["Ruines au nord-ouest d'Orneval, côte"] = "Ruinas al noroeste de Vallefresno, en la costa",
  ["Ruines au-dessus de Fossoyeuse"] = "Ruinas sobre Entrañas",
  ["Ruines trolles au large de la côte"] = "Ruinas trols frente a la costa",
  ["Sous le Vieux Forgefer ; Haute-Salle vers 43, 51"] = "Bajo el Viejo Forjaz; Gran Salón hacia 43, 51",
  ["Sud des Tarides, entrée du Kraal"] = "Sur de Los Baldíos, entrada del Horado",
  ["Trois entrées, dont une sur le Mont Hyjal."] = "Tres entradas, una de ellas en el Monte Hyjal.",
  ["Île d'Alcaz, nord-est d'Âprefange"] = "Isla de Alcaz, noreste de Marjal Revolcafango",
}
AF.Content.esES.item = {
  ["Blason de Lordaeron"] = "Blasón de Lordaeron",
  ["Blason de Lordaeron (objet dans l'instance, souvent bâtiment NW toit bleu)"] = "Blasón de Lordaeron (objeto dentro de la instancia, a menudo en el edificio NO de tejado azul)",
  ["Explosifs extra-destructeurs (item 254553)"] = "Explosivos superdestructivos (objeto 254553)",
  ["Objet ramassé ou reçu en butin"] = "Objeto recogido u obtenido como botín",
  ["Sacoche du Totem-Sinistre"] = "Zurrón Tótem Siniestro",
}
AF.Content.esES.npc_add = {
  ["Afadra Mur-de-Dun"] = "Afadra Dunwall",
  ["Ancienne des Shen'Dralar"] = "Anciana Shen'dralar",
  ["Apothicaire Zamah"] = "Boticario Zamah",
  ["Archevêque Benedictus"] = "Arzobispo Benedictus",
  ["Archimage Tervosh"] = "Archimago Tervosh",
  ["Artiste Renfray"] = "Artista Renfray",
  ["Autel d'Hakkar"] = "Altar de Hakkar",
  ["Bashana Totem-runique"] = "Bashana Runetotem",
  ["Bibliothécaire Mae Blêmepoussière"] = "Bibliotecaria Mae Paledust",
  ["Brasero de Belnistrasz"] = "Brasero de Belnistrasz",
  ["Brikolette Toutevapeur"] = "Tinkee Steamboil",
  ["Brohann Ventrabière"] = "Brohann Caskbelly",
  ["Celebras le Racheté"] = "Celebras el Redimido",
  ["Cime-de-pierre le Vieil"] = "Viejo Stonepeak",
  ["Commandant Gor'shak"] = "Comandante Gor'shak",
  ["Conseiller Belgrum"] = "Consejero Belgrum",
  ["Conseiller Millstipe"] = "Concejal Millstipe",
  ["Cyrus Lerepenti"] = "Cyrus Therepentous",
  ["Cœur-de-tonnerre"] = "Corazón de Trueno",
  ["Dalar Tisselaube"] = "Dalar Dawnweaver",
  ["Directrice de l'orphelinat Rossignol"] = "Matrona del orfanato Nightingale",
  ["Domestique fantomatique"] = "Sirviente fantasmal",
  ["Don de Menethil"] = "Regalo de Menethil",
  ["Duc Hydraxis"] = "Duque Hydraxis",
  ["Duc Nicholas Zverenhoff"] = "Duque Nicholas Zverenhoff",
  ["Eclaireur Riell"] = "Explorador Riell",
  ["Erudite Roncerune"] = "Erudito Runethorn",
  ["Esprit de Zaetar"] = "Espíritu de Zaetar",
  ["Exilé atal'ai"] = "Exiliado atal'ai",
  ["Falfindel Gardevoie"] = "Falfindel Waywarden",
  ["Falla Vent-de-sagesse"] = "Falla Sagewind",
  ["Franclorn Le Forgebusier"] = "Franclorn Forgewright",
  ["Galamav le Tireur d'élite"] = "Galamav el Certero",
  ["Garde Berton"] = "Guardia Berton",
  ["Garde d'argent Manados"] = "Guardia de plata Manados",
  ["Garde d'argent Thaelrid"] = "Guardia de plata Thaelrid",
  ["Gardien Bel'dugur"] = "Celador Bel'dugur",
  ["Gardien Marandis"] = "Celador Marandis",
  ["Gardien Remulos"] = "Vigilante Remulos",
  ["Gardien Thelwater"] = "Celador Thelwater",
  ["Gardien du savoir Lydros"] = "Guardián del saber Lydros",
  ["Gerrig Poigne-d'os"] = "Gerrig Bonegrip",
  ["Gershala Murmenuit"] = "Gershala Nightwhisper",
  ["Ghak Touchesoins"] = "Ghak Healtouch",
  ["Gouvernante Nagmara"] = "Señora Nagmara",
  ["Grand Bricoleur Mekkanivelle"] = "Gran Manitas Mekkatorque",
  ["Grand exécuteur Hadrec"] = "Alto ejecutor Hadrec",
  ["Gregan Gerbebière"] = "Gregan Brewspewer",
  ["Grutier Bigglefuzz"] = "Operario de grúa Bigglefuzz",
  ["Gryan Roidemantel"] = "Gryan Stoutmantle",
  ["Général Marcus Jonathan"] = "General Marcus Jonathan",
  ["Hamuul Totem-Runique"] = "Hamuul Runetotem",
  ["Helendis Ruissecorne"] = "Helendis Riverhorn",
  ["Heralath Ruissefriche"] = "Heralath Fallowbrook",
  ["Idole d'Hakkar"] = "Ídolo de Hakkar",
  ["Infiltrateur du Bouclier balafré"] = "Infiltrador Escudo Cicatriz",
  ["Ingénieur en chef Vizisanie"] = "Ingeniero jefe Bilgewhizzle",
  ["Jalinda Brindille"] = "Jalinda Sprig",
  ["Jarkal Fondemousse"] = "Jarkal Mossmeld",
  ["John le Loqueteux"] = "John el Andrajoso",
  ["Jordan Morpuits"] = "Jordan Stilwell",
  ["Kharan Force-martel"] = "Kharan Mighthammer",
  ["Krom Rudebras"] = "Krom Stoutarm",
  ["Lachnouf Zéboulon"] = "Wizzle Brassbolts",
  ["Latronicus Lancelune"] = "Latronicus Moonspear",
  ["Le Décapeur 5200"] = "El Chispamático 5200",
  ["Leonid Barthalomew le Révéré"] = "Leonid Bartholomew el Venerado",
  ["Liv Rafistolier"] = "Liv Rizzlefix",
  ["Lothos Ouvrefaille"] = "Lothos Riftwaker",
  ["Magistrat Marduke"] = "Magistrado Marduke",
  ["Malyfous Sombremartel"] = "Malyfous Darkhammer",
  ["Marque de Drakkisath"] = "Marca de Drakkisath",
  ["Marvon Chercherivet"] = "Marvon Rivetseeker",
  ["Maréchal Maxwell"] = "Mariscal Maxwell",
  ["Maréchal Windsor"] = "Mariscal Windsor",
  ["Maur Totem-sinistre"] = "Maur Tótem Siniestro",
  ["Maxwort Uberbrille"] = "Maxwort Uberglint",
  ["Mayara Luisaile"] = "Mayara Brightwing",
  ["Maître Gadrin"] = "Maestro Gadrin",
  ["Maître apothicaire Faranell"] = "Maestro boticario Faranell",
  ["Maître mécanicien Fontuyau"] = "Maestro mecánico Castpipe",
  ["Maître-artisan Overspark"] = "Maestro manitas Overspark",
  ["Maître-bricoleur Suprétincelle"] = "Maestro manitas Overspark",
  ["Monument de Franclorn Le Forgebusier"] = "Monumento a Franclorn Forgewright",
  ["Morbin Plaie-lumineuse"] = "Morbin Glowwound",
  ["Motley Garmaçon"] = "Motley Garmason",
  ["Myriam Chantelune"] = "Miriam Moonsong",
  ["Nara Crin-Sauvage"] = "Nara Wildmane",
  ["Nara Crin-sauvage"] = "Nara Wildmane",
  ["Nathanos le Flétrisseur"] = "Nathanos Marchitornio",
  ["Neeru Lamefeu"] = "Neeru Fireblade",
  ["Noué Dédodevie"] = "Knot Thimblejack",
  ["Nécrogarde Kristof"] = "Guardia de la Muerte Kristof",
  ["Nécrotraqueur Vincent"] = "Acechador de la Muerte Vincent",
  ["Ombremage Vivian Lagrave"] = "Maga de las Sombras Vivian Lagrave",
  ["Ozzie Virevolt"] = "Ozzie Togglevolt",
  ["Paria centaure"] = "Paria centauro",
  ["Pléthorloge Cléventail"] = "Klockmort Spannerspan",
  ["Prospecteur Baguefer"] = "Prospector Ironband",
  ["Prospecteur Botte-de-fer"] = "Prospector Ironboot",
  ["Prospecteur Foudrepique"] = "Prospector Stormpike",
  ["RECHERCHE"] = "SE BUSCA",
  ["Ragnar Tonnebière"] = "Ragnar Thunderbrew",
  ["Raleigh le Dévot"] = "Raleigh el Devoto",
  ["Roi Magni Barbe-de-bronze"] = "Rey Magni Barbabronce",
  ["Réceptacle d'essence"] = "Receptáculo de esencia",
  ["Régisseuse sanglante de Kirtonos"] = "Administrador de sangre de Kirtonos",
  ["Sage Recherche-la-vérité"] = "Sabio Truthseeker",
  ["Sagorne Rôdeur-des-crêtes"] = "Sagorne Creststrider",
  ["Saule"] = "Willow",
  ["Seigneur de guerre Sangredent"] = "Señor de la guerra Bloodfang",
  ["Shoni la Silencieuse"] = "Shoni the Shilent",
  ["TUER A VUE"] = "MATAR AL VER",
  ["Tabitha Tissecœur"] = "Tabitha Heartweaver",
  ["Talo Sabot-de-ronce"] = "Talo Thornhoof",
  ["Terre-voyant Farsen"] = "Vidente de la tierra Farsen",
  ["Thadius Sinissombre"] = "Thadius Grimshade",
  ["Theldurin l'Egaré"] = "Theldurin el Perdido",
  ["Trenton Martelume"] = "Trenton Lighthammer",
  ["Treshala Ruissefriche"] = "Treshala Fallowbrook",
  ["Vark Balafre-glorieuse"] = "Vark Battlescar",
  ["Veilleur de l'aube Selgorm"] = "Vigía del alba Selgorm",
  ["Veilleur de l'aube Shaedlass"] = "Vigía del alba Shaedlass",
  ["Wilder Crispechardon"] = "Wilder Thistlenettle",
  ["Willix l'Importateur"] = "Willix el Importador",
  ["Yuka Fermevanne"] = "Yuka Screwspigot",
}
AF.Content.esES.objective = {
  ["Anneau sali (Fourni) (1)"] = "Anillo incrustado de mugre (Proporcionado) (1)",
  ["Blason de Lordaeron"] = "Blasón de Lordaeron",
  ["Cadavre de Maur Totem-Sinistre"] = "Cadáver de Maur Tótem Siniestro",
  ["Cercle de pierres atal'ai (Fourni) (1)"] = "Círculo de piedra atal'ai (Proporcionado) (1)",
  ["Collier brisé (Fourni) (1)"] = "Collar roto (Proporcionado) (1)",
  ["Deathstalker Adamant"] = "Acechador de la Muerte Adamant",
  ["Deathstalker Vincent"] = "Acechador de la Muerte Vincent",
  ["Ecaille d'Awbee (Fourni) (1)"] = "Escama de Awbee (Proporcionado) (1)",
  ["Ecaille de dragon luisante (Fourni) (1)"] = "Escama de dragón sana (Proporcionado) (1)",
  ["Essence d'Eranikus (Fourni) (1)"] = "Esencia de Eranikus (Proporcionado) (1)",
  ["Globe d'eau étrange (Fourni) (1)"] = "Globo de agua extraño (Proporcionado) (1)",
  ["Graine de vie (Fourni) (1)"] = "Semilla de vida (Proporcionado) (1)",
  ["Insigne ensanglanté (Fourni) (10)"] = "Insignia ensangrentada (Proporcionado) (10)",
  ["Le guide de Nostro du tueur de dragons (Fourni) (1)"] = "Compendio de Foror sobre matar dragones (Proporcionado) (1)",
  ["Lettre tachée de sang (Fourni) (1)"] = "Carta manchada de sangre (Proporcionado) (1)",
  ["Livre du souvenir (Fourni) (1)"] = "Recuerdo de la memoria (Proporcionado) (1)",
  ["Morceau de chair de la Bête luminescent (Fourni) (1)"] = "Trozo de carne de bestia luminosa (Proporcionado) (1)",
  ["Ordres du général Drakkisath (Fourni) (1)"] = "Órdenes del general Drakkisath (Proporcionado) (1)",
  ["Parler à Hamuul"] = "Hablar con Hamuul",
  ["Parler à Nara"] = "Hablar con Nara",
  ["Petit parchemin (Fourni) (1)"] = "Pergamino pequeño (Proporcionado) (1)",
  ["Pierre de voeu de Belnistrasz (Fourni) (1)"] = "Piedra de juramento de Belnistrasz (Proporcionado) (1)",
  ["Sacoche du Totem-Sinistre"] = "Zurrón Tótem Siniestro",
  ["Traité d’entente (Fourni) (1)"] = "Tratado de entendimiento (Proporcionado) (1)",
  ["Tête de Balnazzar (Fourni) (1)"] = "Cabeza de Balnazzar (Proporcionado) (1)",
  ["Une lettre qui n'a pas été envoyée. (Fourni) (1)"] = "Una carta sin enviar. (Proporcionado) (1)",
}
AF.Content.esES.instance = {
  rfc = "Sima Ígnea",
  hot = "Sala de los Thanes",
  wc = "Cuevas de los Lamentos",
  rol = "Ruinas de Lordaeron",
  dm = "Las Minas de la Muerte",
  sfk = "Castillo de Colmillo Oscuro",
  stocks = "Las Mazmorras",
  bfd = "Cavernas de Brazanegra",
  excav = "Excavaciones: Los Humedales",
  sm = "Monasterio Escarlata",
  cod = "Ciudad de Dalaran",
  gnomer = "Gnomeregan",
  rfk = "Horado Rajacieno",
  dc = "La Ciudad Sumergida",
  rfd = "Zahúrda Rajacieno",
  krol = "Fortaleza de Krol'Dok",
  ulda = "Uldaman",
  zf = "Zul'Farrak",
  mara = "Maraudon",
  alcaz = "Prisión de Alcaz",
  st = "El Templo de Atal'Hakkar",
  brd = "Profundidades de Roca Negra",
  brs = "Cumbre de Roca Negra",
  bh = "Fortaleza Faucenegra",
  dire = "La Masacre",
  scholo = "Scholomance",
  strat = "Stratholme",
  shapers = "Terraza de los Moldeadores",
  barrow = "Fosas de Barrow",
  hyjal = "Monte Hyjal",
  ony = "Guarida de Onyxia",
  mc = "Núcleo de Magma",
  bwl = "Guarida Alanegra",
  zg = "Zul'Gurub",
  aq20 = "Ruinas de Ahn'Qiraj",
  aq40 = "Templo de Ahn'Qiraj",
  naxx = "Naxxramas",
}
do
  local C = AF.Content.esES
  C.npc = C.npc or {}
  for k, v in pairs(C.npc_add or {}) do if C.npc[k] == nil then C.npc[k] = v end end
  C.npc_add = nil
end

AF.Content.esES.classic_part = {
  [104727] = {
    "Tus hechizos de Oleada de curación tienen un 33% de probabilidad de aumentar en un 6% el efecto de los siguientes hechizos de Oleada de curación sobre ese objetivo durante 15 seg. Este efecto se acumula hasta 3 veces.",
    "Tus hechizos de Oleada de curación tienen un 66% de probabilidad de aumentar en un 6% el efecto de los siguientes hechizos de Oleada de curación sobre ese objetivo durante 15 seg. Este efecto se acumula hasta 3 veces.",
    "Tus hechizos de Oleada de curación tienen un 100% de probabilidad de aumentar en un 6% el efecto de los siguientes hechizos de Oleada de curación sobre ese objetivo durante 15 seg. Este efecto se acumula hasta 3 veces.",
  },
  [104728] = {
    "Invoca un Tótem Marea de maná con 5 de salud a los pies del lanzador durante 12 seg que restaura 170 de maná cada 3 segundos a los miembros del grupo situados a menos de 20 metros.",
  },
  [104729] = {
    "Reduce el coste de maná de tus tótems en un 5%.",
    "Reduce el coste de maná de tus tótems en un 10%.",
    "Reduce el coste de maná de tus tótems en un 15%.",
    "Reduce el coste de maná de tus tótems en un 20%.",
    "Reduce el coste de maná de tus tótems en un 25%.",
  },
  [104730] = {
    "Aumenta en un 5% el efecto de tus Tótems Fuente de maná y Corriente de sanación.",
    "Aumenta en un 10% el efecto de tus Tótems Fuente de maná y Corriente de sanación.",
    "Aumenta en un 15% el efecto de tus Tótems Fuente de maná y Corriente de sanación.",
    "Aumenta en un 20% el efecto de tus Tótems Fuente de maná y Corriente de sanación.",
    "Aumenta en un 25% el efecto de tus Tótems Fuente de maná y Corriente de sanación.",
  },
  [104731] = {
    "Aumenta el valor de armadura de tu objetivo en un 8% durante 15 seg después de que reciba un efecto crítico de uno de tus hechizos de sanación.",
    "Aumenta el valor de armadura de tu objetivo en un 16% durante 15 seg después de que reciba un efecto crítico de uno de tus hechizos de sanación.",
    "Aumenta el valor de armadura de tu objetivo en un 25% durante 15 seg después de que reciba un efecto crítico de uno de tus hechizos de sanación.",
  },
  [104733] = {
    "Te otorga un 14% de probabilidad de evitar la interrupción causada por daño al lanzar cualquier hechizo de sanación.",
    "Te otorga un 28% de probabilidad de evitar la interrupción causada por daño al lanzar cualquier hechizo de sanación.",
    "Te otorga un 42% de probabilidad de evitar la interrupción causada por daño al lanzar cualquier hechizo de sanación.",
    "Te otorga un 56% de probabilidad de evitar la interrupción causada por daño al lanzar cualquier hechizo de sanación.",
    "Te otorga un 70% de probabilidad de evitar la interrupción causada por daño al lanzar cualquier hechizo de sanación.",
  },
  [104735] = {
    "Reduce el coste de maná de tus hechizos de sanación en un 1%.",
    "Reduce el coste de maná de tus hechizos de sanación en un 2%.",
    "Reduce el coste de maná de tus hechizos de sanación en un 3%.",
    "Reduce el coste de maná de tus hechizos de sanación en un 4%.",
    "Reduce el coste de maná de tus hechizos de sanación en un 5%.",
  },
  [104736] = {
    "Reduce la amenaza generada por tus hechizos de sanación en un 5%.",
    "Reduce la amenaza generada por tus hechizos de sanación en un 10%.",
    "Reduce la amenaza generada por tus hechizos de sanación en un 15%.",
  },
  [104737] = {
    "Reduce en 10 min el tiempo de reutilización de tu hechizo Reencarnación y aumenta en un 10% adicional la salud y el maná con los que reencarnas.",
    "Reduce en 20 min el tiempo de reutilización de tu hechizo Reencarnación y aumenta en un 20% adicional la salud y el maná con los que reencarnas.",
  },
  [104738] = {
    "Aumenta en un 1% la probabilidad de golpe crítico de tus hechizos de sanación y de relámpagos.",
    "Aumenta en un 2% la probabilidad de golpe crítico de tus hechizos de sanación y de relámpagos.",
    "Aumenta en un 3% la probabilidad de golpe crítico de tus hechizos de sanación y de relámpagos.",
    "Aumenta en un 4% la probabilidad de golpe crítico de tus hechizos de sanación y de relámpagos.",
    "Aumenta en un 5% la probabilidad de golpe crítico de tus hechizos de sanación y de relámpagos.",
  },
  [104743] = {
    "Te otorga un ataque adicional. Además, las siguientes 2 fuentes de daño de Naturaleza infligidas al objetivo aumentan en un 20%. Dura 12 seg.",
  },
  [104745] = {
    "Te da la posibilidad de parar ataques cuerpo a cuerpo enemigos.",
  },
  [104746] = {
    "Aumenta en un 2% el valor de armadura de los objetos.",
    "Aumenta en un 4% el valor de armadura de los objetos.",
    "Aumenta en un 6% el valor de armadura de los objetos.",
    "Aumenta en un 8% el valor de armadura de los objetos.",
    "Aumenta en un 10% el valor de armadura de los objetos.",
  },
  [104747] = {
    "Aumenta tu velocidad de ataque en un 10% durante tus siguientes 3 golpes después de asestar un golpe crítico.",
    "Aumenta tu velocidad de ataque en un 15% durante tus siguientes 3 golpes después de asestar un golpe crítico.",
    "Aumenta tu velocidad de ataque en un 20% durante tus siguientes 3 golpes después de asestar un golpe crítico.",
    "Aumenta tu velocidad de ataque en un 25% durante tus siguientes 3 golpes después de asestar un golpe crítico.",
    "Aumenta tu velocidad de ataque en un 30% durante tus siguientes 3 golpes después de asestar un golpe crítico.",
  },
  [104748] = {
    "Aumenta tu probabilidad de esquivar en un 1% adicional.",
    "Aumenta tu probabilidad de esquivar en un 2% adicional.",
    "Aumenta tu probabilidad de esquivar en un 3% adicional.",
    "Aumenta tu probabilidad de esquivar en un 4% adicional.",
    "Aumenta tu probabilidad de esquivar en un 5% adicional.",
  },
  [104750] = {
    "Aumenta en un 7% la bonificación de poder de ataque cuerpo a cuerpo de tu Arma Muerdepiedras, en un 13% el efecto de tu Arma Viento Furioso y en un 5% el daño infligido por tu Arma Lengua de Fuego y tu Arma Estigma de Escarcha.",
    "Aumenta en un 14% la bonificación de poder de ataque cuerpo a cuerpo de tu Arma Muerdepiedras, en un 27% el efecto de tu Arma Viento Furioso y en un 10% el daño infligido por tu Arma Lengua de Fuego y tu Arma Estigma de Escarcha.",
    "Aumenta en un 20% la bonificación de poder de ataque cuerpo a cuerpo de tu Arma Muerdepiedras, en un 40% el efecto de tu Arma Viento Furioso y en un 15% el daño infligido por tu Arma Lengua de Fuego y tu Arma Estigma de Escarcha.",
  },
  [104752] = {
    "Reduce en 1 seg el tiempo de lanzamiento de tu hechizo Lobo fantasma.",
    "Reduce en 2 seg el tiempo de lanzamiento de tu hechizo Lobo fantasma.",
  },
  [104753] = {
    "Aumenta en un 1% tu probabilidad de asestar un golpe crítico con tus ataques con arma.",
    "Aumenta en un 2% tu probabilidad de asestar un golpe crítico con tus ataques con arma.",
    "Aumenta en un 3% tu probabilidad de asestar un golpe crítico con tus ataques con arma.",
    "Aumenta en un 4% tu probabilidad de asestar un golpe crítico con tus ataques con arma.",
    "Aumenta en un 5% tu probabilidad de asestar un golpe crítico con tus ataques con arma.",
  },
  [104756] = {
    "Aumenta tu maná máximo en un 1%.",
    "Aumenta tu maná máximo en un 2%.",
    "Aumenta tu maná máximo en un 3%.",
    "Aumenta tu maná máximo en un 4%.",
    "Aumenta tu maná máximo en un 5%.",
  },
  [104761] = {
    "Aumenta en 3 metros el alcance de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Aumenta en 6 metros el alcance de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
  },
  [104762] = {
    "Aumenta en un 1% adicional la probabilidad de golpe crítico de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Aumenta en un 2% adicional la probabilidad de golpe crítico de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Aumenta en un 3% adicional la probabilidad de golpe crítico de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Aumenta en un 4% adicional la probabilidad de golpe crítico de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Aumenta en un 6% adicional la probabilidad de golpe crítico de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
  },
  [104763] = {
    "Te otorga un 33% de probabilidad de obtener el efecto Lanzamiento concentrado durante 6 seg después de sufrir un golpe crítico cuerpo a cuerpo o a distancia. El efecto Lanzamiento concentrado evita que pierdas tiempo de lanzamiento al recibir daño.",
    "Te otorga un 66% de probabilidad de obtener el efecto Lanzamiento concentrado durante 6 seg después de sufrir un golpe crítico cuerpo a cuerpo o a distancia. El efecto Lanzamiento concentrado evita que pierdas tiempo de lanzamiento al recibir daño.",
    "Te otorga un 100% de probabilidad de obtener el efecto Lanzamiento concentrado durante 6 seg después de sufrir un golpe crítico cuerpo a cuerpo o a distancia. El efecto Lanzamiento concentrado evita que pierdas tiempo de lanzamiento al recibir daño.",
  },
  [104764] = {
    "Reduce en 1 seg el retraso antes de que se active tu Tótem Nova de Fuego y disminuye en un 25% la amenaza generada por tu Tótem de magma.",
    "Reduce en 2 seg el retraso antes de que se active tu Tótem Nova de Fuego y disminuye en un 50% la amenaza generada por tu Tótem de magma.",
  },
  [104765] = {
    "Reduce en 0.2 seg el tiempo de lanzamiento de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Reduce en 0.4 seg el tiempo de lanzamiento de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Reduce en 0.6 seg el tiempo de lanzamiento de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Reduce en 0.8 seg el tiempo de lanzamiento de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
    "Reduce en 1 seg el tiempo de lanzamiento de tus hechizos Descarga de relámpagos y Cadena de relámpagos.",
  },
  [104766] = {
    "Aumenta en un 100% la bonificación de daño crítico de tus Tótems abrasador, de magma y Nova de Fuego y de tus hechizos de Fuego, Escarcha y Naturaleza.",
  },
  [104769] = {
    "Tus golpes críticos con hechizos ofensivos aumentan en un 3% tu probabilidad de asestar golpes críticos con ataques cuerpo a cuerpo durante 10 seg.",
    "Tus golpes críticos con hechizos ofensivos aumentan en un 6% tu probabilidad de asestar golpes críticos con ataques cuerpo a cuerpo durante 10 seg.",
    "Tus golpes críticos con hechizos ofensivos aumentan en un 9% tu probabilidad de asestar golpes críticos con ataques cuerpo a cuerpo durante 10 seg.",
  },
  [104770] = {
    "Aumenta en un 5% el daño infligido por tus tótems de Fuego.",
    "Aumenta en un 10% el daño infligido por tus tótems de Fuego.",
    "Aumenta en un 15% el daño infligido por tus tótems de Fuego.",
  },
  [104771] = {
    "Reduce en un 4% el daño recibido por efectos de Fuego, Escarcha y Naturaleza.",
    "Reduce en un 7% el daño recibido por efectos de Fuego, Escarcha y Naturaleza.",
    "Reduce en un 10% el daño recibido por efectos de Fuego, Escarcha y Naturaleza.",
  },
  [104772] = {
    "Aumenta en un 1% el daño infligido por tus hechizos Descarga de relámpagos, Cadena de relámpagos y Choque.",
    "Aumenta en un 2% el daño infligido por tus hechizos Descarga de relámpagos, Cadena de relámpagos y Choque.",
    "Aumenta en un 3% el daño infligido por tus hechizos Descarga de relámpagos, Cadena de relámpagos y Choque.",
    "Aumenta en un 4% el daño infligido por tus hechizos Descarga de relámpagos, Cadena de relámpagos y Choque.",
    "Aumenta en un 5% el daño infligido por tus hechizos Descarga de relámpagos, Cadena de relámpagos y Choque.",
  },
  [104773] = {
    "Reduce en un 2% el coste de maná de tus hechizos Choque, Descarga de relámpagos y Cadena de relámpagos.",
    "Reduce en un 4% el coste de maná de tus hechizos Choque, Descarga de relámpagos y Cadena de relámpagos.",
    "Reduce en un 6% el coste de maná de tus hechizos Choque, Descarga de relámpagos y Cadena de relámpagos.",
    "Reduce en un 8% el coste de maná de tus hechizos Choque, Descarga de relámpagos y Cadena de relámpagos.",
    "Reduce en un 10% el coste de maná de tus hechizos Choque, Descarga de relámpagos y Cadena de relámpagos.",
  },
  [104909] = {
    "Reduce en un 50% la amenaza generada por Tranquilidad.",
    "Reduce en un 100% la amenaza generada por Tranquilidad.",
  },
  [104912] = {
    "Consume un efecto de Rejuvenecimiento o Recrecimiento sobre un objetivo amistoso para curarlo instantáneamente en una cantidad igual a 12 seg de Rejuvenecimiento o 18 seg de Recrecimiento.",
  },
  [104916] = {
    "Aumenta en un 2% el efecto de todos tus hechizos de sanación.",
    "Aumenta en un 4% el efecto de todos tus hechizos de sanación.",
    "Aumenta en un 6% el efecto de todos tus hechizos de sanación.",
    "Aumenta en un 8% el efecto de todos tus hechizos de sanación.",
    "Aumenta en un 10% el efecto de todos tus hechizos de sanación.",
  },
  [104917] = {
    "Permite que el 5% de tu regeneración de maná continúe mientras lanzas hechizos.",
    "Permite que el 10% de tu regeneración de maná continúe mientras lanzas hechizos.",
    "Permite que el 15% de tu regeneración de maná continúe mientras lanzas hechizos.",
  },
  [104920] = {
    "Reduce en un 4% la amenaza generada por tus hechizos de sanación.",
    "Reduce en un 8% la amenaza generada por tus hechizos de sanación.",
    "Reduce en un 12% la amenaza generada por tus hechizos de sanación.",
    "Reduce en un 16% la amenaza generada por tus hechizos de sanación.",
    "Reduce en un 20% la amenaza generada por tus hechizos de sanación.",
  },
  [104922] = {
    "Reduce en 0.1 seg el tiempo de lanzamiento de tu hechizo Toque de sanación.",
    "Reduce en 0.2 seg el tiempo de lanzamiento de tu hechizo Toque de sanación.",
    "Reduce en 0.3 seg el tiempo de lanzamiento de tu hechizo Toque de sanación.",
    "Reduce en 0.4 seg el tiempo de lanzamiento de tu hechizo Toque de sanación.",
    "Reduce en 0.5 seg el tiempo de lanzamiento de tu hechizo Toque de sanación.",
  },
  [104923] = {
    "Reduce en 0.1 seg el tiempo de lanzamiento de tu hechizo Cólera.",
    "Reduce en 0.2 seg el tiempo de lanzamiento de tu hechizo Cólera.",
    "Reduce en 0.3 seg el tiempo de lanzamiento de tu hechizo Cólera.",
    "Reduce en 0.4 seg el tiempo de lanzamiento de tu hechizo Cólera.",
    "Reduce en 0.5 seg el tiempo de lanzamiento de tu hechizo Cólera.",
  },
  [104925] = {
    "Reduce en un 3% el coste de maná de tus hechizos Fuego lunar, Fuego estelar, Cólera, Toque de sanación, Recrecimiento y Rejuvenecimiento.",
    "Reduce en un 6% el coste de maná de tus hechizos Fuego lunar, Fuego estelar, Cólera, Toque de sanación, Recrecimiento y Rejuvenecimiento.",
    "Reduce en un 9% el coste de maná de tus hechizos Fuego lunar, Fuego estelar, Cólera, Toque de sanación, Recrecimiento y Rejuvenecimiento.",
  },
  [104926] = {
    "Te otorga un 40% de probabilidad de evitar la interrupción causada por daño al lanzar Raíces enmarañadoras.",
    "Te otorga un 70% de probabilidad de evitar la interrupción causada por daño al lanzar Raíces enmarañadoras.",
    "Te otorga un 100% de probabilidad de evitar la interrupción causada por daño al lanzar Raíces enmarañadoras.",
  },
  [104929] = {
    "Aumenta en un 10% el alcance de tus hechizos Cólera, Raíces enmarañadoras, Fuego feérico, Fuego lunar, Fuego estelar y Huracán.",
    "Aumenta en un 20% el alcance de tus hechizos Cólera, Raíces enmarañadoras, Fuego feérico, Fuego lunar, Fuego estelar y Huracán.",
  },
  [104930] = {
    "El objetivo enemigo es asaltado por un enjambre de insectos, lo que reduce en un 2% su probabilidad de golpear y le causa 66 de daño de Naturaleza durante 12 seg.",
  },
  [104931] = {
    "Aumenta en un 2% el daño y la probabilidad de golpe crítico de tu hechizo Fuego lunar.",
    "Aumenta en un 4% el daño y la probabilidad de golpe crítico de tu hechizo Fuego lunar.",
    "Aumenta en un 6% el daño y la probabilidad de golpe crítico de tu hechizo Fuego lunar.",
    "Aumenta en un 8% el daño y la probabilidad de golpe crítico de tu hechizo Fuego lunar.",
    "Aumenta en un 10% el daño y la probabilidad de golpe crítico de tu hechizo Fuego lunar.",
  },
  [104932] = {
    "Aumenta en un 20% la bonificación de daño crítico de tus hechizos Fuego estelar, Fuego lunar y Cólera.",
    "Aumenta en un 40% la bonificación de daño crítico de tus hechizos Fuego estelar, Fuego lunar y Cólera.",
    "Aumenta en un 60% la bonificación de daño crítico de tus hechizos Fuego estelar, Fuego lunar y Cólera.",
    "Aumenta en un 80% la bonificación de daño crítico de tus hechizos Fuego estelar, Fuego lunar y Cólera.",
    "Aumenta en un 100% la bonificación de daño crítico de tus hechizos Fuego estelar, Fuego lunar y Cólera.",
  },
  [104933] = {
    "Reduce en 0.1 seg el tiempo de lanzamiento de Fuego estelar y otorga un 3% de probabilidad de aturdir al objetivo durante 3 seg.",
    "Reduce en 0.2 seg el tiempo de lanzamiento de Fuego estelar y otorga un 6% de probabilidad de aturdir al objetivo durante 3 seg.",
    "Reduce en 0.3 seg el tiempo de lanzamiento de Fuego estelar y otorga un 9% de probabilidad de aturdir al objetivo durante 3 seg.",
    "Reduce en 0.4 seg el tiempo de lanzamiento de Fuego estelar y otorga un 12% de probabilidad de aturdir al objetivo durante 3 seg.",
    "Reduce en 0.5 seg el tiempo de lanzamiento de Fuego estelar y otorga un 15% de probabilidad de aturdir al objetivo durante 3 seg.",
  },
  [104934] = {
    "Después de asestar un golpe crítico con un hechizo, obtienes una bendición de la naturaleza que reduce en 0.5 seg el tiempo de lanzamiento de tu siguiente hechizo.",
  },
  [104936] = {
    "Aumenta en un 2% el daño infligido por tus hechizos Fuego estelar, Fuego lunar y Cólera.",
    "Aumenta en un 4% el daño infligido por tus hechizos Fuego estelar, Fuego lunar y Cólera.",
    "Aumenta en un 6% el daño infligido por tus hechizos Fuego estelar, Fuego lunar y Cólera.",
    "Aumenta en un 8% el daño infligido por tus hechizos Fuego estelar, Fuego lunar y Cólera.",
    "Aumenta en un 10% el daño infligido por tus hechizos Fuego estelar, Fuego lunar y Cólera.",
  },
  [104937] = {
    "Transforma al druida en lechúcico lunar. Mientras estás en esta forma, la contribución de armadura de los objetos aumenta en un 360% y todos los miembros del grupo situados a menos de 30 metros ven aumentada en un 3% su probabilidad de golpe crítico con hechizos. El lechúcico lunar solo puede lanzar hechizos de Equilibrio mientras está en esta forma.\n\nEl acto de cambiar de forma libera al lanzador de Polimorfia y de los efectos que impiden el movimiento.",
  },
  [104938] = {
    "Reduce en 1 de Furia o Energía el coste de tus habilidades Magullar, Zarpazo, Garra y Desgarrar.",
    "Reduce en 2 de Furia o Energía el coste de tus habilidades Magullar, Zarpazo, Garra y Desgarrar.",
    "Reduce en 3 de Furia o Energía el coste de tus habilidades Magullar, Zarpazo, Garra y Desgarrar.",
    "Reduce en 4 de Furia o Energía el coste de tus habilidades Magullar, Zarpazo, Garra y Desgarrar.",
    "Reduce en 5 de Furia o Energía el coste de tus habilidades Magullar, Zarpazo, Garra y Desgarrar.",
  },
  [104939] = {
    "Aumenta tu Inteligencia en un 4%. Además, mientras estás en Forma de oso o de oso temible tu Aguante aumenta en un 4% y mientras estás en Forma de felino tu Fuerza aumenta en un 4%.",
    "Aumenta tu Inteligencia en un 8%. Además, mientras estás en Forma de oso o de oso temible tu Aguante aumenta en un 8% y mientras estás en Forma de felino tu Fuerza aumenta en un 8%.",
    "Aumenta tu Inteligencia en un 12%. Además, mientras estás en Forma de oso o de oso temible tu Aguante aumenta en un 12% y mientras estás en Forma de felino tu Fuerza aumenta en un 12%.",
    "Aumenta tu Inteligencia en un 16%. Además, mientras estás en Forma de oso o de oso temible tu Aguante aumenta en un 16% y mientras estás en Forma de felino tu Fuerza aumenta en un 16%.",
    "Aumenta tu Inteligencia en un 20%. Además, mientras estás en Forma de oso o de oso temible tu Aguante aumenta en un 20% y mientras estás en Forma de felino tu Fuerza aumenta en un 20%.",
  },
  [104940] = {
    "Aumenta en un 3% la amenaza generada en Forma de oso y de oso temible y reduce la probabilidad de que los enemigos te detecten mientras Acechas.",
    "Aumenta en un 6% la amenaza generada en Forma de oso y de oso temible y reduce la probabilidad de que los enemigos te detecten mientras Acechas.",
    "Aumenta en un 9% la amenaza generada en Forma de oso y de oso temible y reduce la probabilidad de que los enemigos te detecten mientras Acechas.",
    "Aumenta en un 12% la amenaza generada en Forma de oso y de oso temible y reduce la probabilidad de que los enemigos te detecten mientras Acechas.",
    "Aumenta en un 15% la amenaza generada en Forma de oso y de oso temible y reduce la probabilidad de que los enemigos te detecten mientras Acechas.",
  },
  [104941] = {
    "Aumenta en 0.5 seg la duración del aturdimiento de tus habilidades Machacar y Abalanzarse.",
    "Aumenta en 1 seg la duración del aturdimiento de tus habilidades Machacar y Abalanzarse.",
  },
  [104942] = {
    "Aumenta en un 2% tu contribución de armadura de los objetos.",
    "Aumenta en un 4% tu contribución de armadura de los objetos.",
    "Aumenta en un 6% tu contribución de armadura de los objetos.",
    "Aumenta en un 8% tu contribución de armadura de los objetos.",
    "Aumenta en un 10% tu contribución de armadura de los objetos.",
  },
  [104943] = {
    "Aumenta tu velocidad de movimiento en un 15% mientras estás al aire libre en Forma de felino y aumenta en un 2% tu probabilidad de esquivar mientras estás en Forma de felino.",
    "Aumenta tu velocidad de movimiento en un 30% mientras estás al aire libre en Forma de felino y aumenta en un 4% tu probabilidad de esquivar mientras estás en Forma de felino.",
  },
  [104944] = {
    "Te hace cargar contra un enemigo, inmovilizándolo e interrumpiendo cualquier hechizo que esté lanzando durante 4 seg.",
  },
  [104945] = {
    "Reduce en 6 el coste de Energía de tu habilidad Triturar.",
    "Reduce en 12 el coste de Energía de tu habilidad Triturar.",
  },
  [104946] = {
    "Aumenta en un 2% tu probabilidad de golpe crítico mientras estás en Forma de oso, de oso temible o de felino.",
    "Aumenta en un 4% tu probabilidad de golpe crítico mientras estás en Forma de oso, de oso temible o de felino.",
    "Aumenta en un 6% tu probabilidad de golpe crítico mientras estás en Forma de oso, de oso temible o de felino.",
  },
  [104947] = {
    "Te otorga un 50% de probabilidad de obtener 5 de Furia adicionales cada vez que asestas un golpe crítico mientras estás en Forma de oso o de oso temible.",
    "Te otorga un 100% de probabilidad de obtener 5 de Furia adicionales cada vez que asestas un golpe crítico mientras estás en Forma de oso o de oso temible.",
  },
  [104948] = {
    "Aumenta en un 10% el daño causado por tus habilidades Garra, Desgarrar, Magullar y Zarpazo.",
    "Aumenta en un 20% el daño causado por tus habilidades Garra, Desgarrar, Magullar y Zarpazo.",
  },
  [104952] = {
    "Aumenta en un 50% de tu nivel el poder de ataque cuerpo a cuerpo en Forma de felino, de oso y de oso temible.",
    "Aumenta en un 100% de tu nivel el poder de ataque cuerpo a cuerpo en Forma de felino, de oso y de oso temible.",
    "Aumenta en un 150% de tu nivel el poder de ataque cuerpo a cuerpo en Forma de felino, de oso y de oso temible.",
  },
  [104955] = {
    "Mientras estás en Forma de felino, de oso o de oso temible, el Líder de la manada aumenta en un 45% la probabilidad de golpe crítico a distancia y cuerpo a cuerpo de todos los miembros del grupo situados a menos de 3 metros.",
  },
  [104957] = {
    "Te otorga un 14% de probabilidad de evitar la interrupción causada por daño al lanzar los hechizos Toque de sanación, Recrecimiento y Tranquilidad.",
    "Te otorga un 28% de probabilidad de evitar la interrupción causada por daño al lanzar los hechizos Toque de sanación, Recrecimiento y Tranquilidad.",
    "Te otorga un 42% de probabilidad de evitar la interrupción causada por daño al lanzar los hechizos Toque de sanación, Recrecimiento y Tranquilidad.",
    "Te otorga un 56% de probabilidad de evitar la interrupción causada por daño al lanzar los hechizos Toque de sanación, Recrecimiento y Tranquilidad.",
    "Te otorga un 70% de probabilidad de evitar la interrupción causada por daño al lanzar los hechizos Toque de sanación, Recrecimiento y Tranquilidad.",
  },
  [104958] = {
    "Te otorga un 20% de probabilidad de obtener 10 de Furia cuando cambias a Forma de oso o de oso temible, o 40 de Energía cuando cambias a Forma de felino.",
    "Te otorga un 40% de probabilidad de obtener 10 de Furia cuando cambias a Forma de oso o de oso temible, o 40 de Energía cuando cambias a Forma de felino.",
    "Te otorga un 60% de probabilidad de obtener 10 de Furia cuando cambias a Forma de oso o de oso temible, o 40 de Energía cuando cambias a Forma de felino.",
    "Te otorga un 80% de probabilidad de obtener 10 de Furia cuando cambias a Forma de oso o de oso temible, o 40 de Energía cuando cambias a Forma de felino.",
    "Te otorga un 100% de probabilidad de obtener 10 de Furia cuando cambias a Forma de oso o de oso temible, o 40 de Energía cuando cambias a Forma de felino.",
  },
  [104960] = {
    "Mientras el Aspecto del halcón está activo, todos los ataques normales a distancia tienen un 1% de probabilidad de aumentar en un 30% la velocidad de ataque a distancia durante 12 seg.",
    "Mientras el Aspecto del halcón está activo, todos los ataques normales a distancia tienen un 2% de probabilidad de aumentar en un 30% la velocidad de ataque a distancia durante 12 seg.",
    "Mientras el Aspecto del halcón está activo, todos los ataques normales a distancia tienen un 3% de probabilidad de aumentar en un 30% la velocidad de ataque a distancia durante 12 seg.",
    "Mientras el Aspecto del halcón está activo, todos los ataques normales a distancia tienen un 4% de probabilidad de aumentar en un 30% la velocidad de ataque a distancia durante 12 seg.",
    "Mientras el Aspecto del halcón está activo, todos los ataques normales a distancia tienen un 5% de probabilidad de aumentar en un 30% la velocidad de ataque a distancia durante 12 seg.",
  },
  [104963] = {
    "Aumenta en un 10% la regeneración de Concentración de tus mascotas.",
    "Aumenta en un 20% la regeneración de Concentración de tus mascotas.",
  },
  [104964] = {
    "Ordena a tu mascota que intimide al objetivo en el siguiente ataque cuerpo a cuerpo que acierte, causando una gran cantidad de amenaza y aturdiendo al objetivo durante 3 seg.",
  },
  [104965] = {
    "Mientras tu mascota está activa, tú y tu mascota recuperaréis un 1% de la salud total cada 10 seg.",
    "Mientras tu mascota está activa, tú y tu mascota recuperaréis un 2% de la salud total cada 10 seg.",
  },
  [104967] = {
    "Aumenta en un 3% la probabilidad de golpe crítico de tus mascotas.",
    "Aumenta en un 6% la probabilidad de golpe crítico de tus mascotas.",
    "Aumenta en un 9% la probabilidad de golpe crítico de tus mascotas.",
    "Aumenta en un 12% la probabilidad de golpe crítico de tus mascotas.",
    "Aumenta en un 15% la probabilidad de golpe crítico de tus mascotas.",
  },
  [104968] = {
    "Otorga a tu hechizo Sanar mascota un 15% de probabilidad de eliminar 1 efecto de Maldición, Enfermedad, Magia o Veneno de tu mascota cada vez que cura.",
    "Otorga a tu hechizo Sanar mascota un 50% de probabilidad de eliminar 1 efecto de Maldición, Enfermedad, Magia o Veneno de tu mascota cada vez que cura.",
  },
  [104969] = {
    "Aumenta en un 4% el daño infligido por tus mascotas.",
    "Aumenta en un 8% el daño infligido por tus mascotas.",
    "Aumenta en un 12% el daño infligido por tus mascotas.",
    "Aumenta en un 16% el daño infligido por tus mascotas.",
    "Aumenta en un 20% el daño infligido por tus mascotas.",
  },
  [104970] = {
    "Aumenta en un 30% la velocidad de movimiento al aire libre de tus mascotas.",
  },
  [104974] = {
    "Aumenta en un 1% la bonificación de Esquivar de tu Aspecto del mono.",
    "Aumenta en un 2% la bonificación de Esquivar de tu Aspecto del mono.",
    "Aumenta en un 3% la bonificación de Esquivar de tu Aspecto del mono.",
    "Aumenta en un 4% la bonificación de Esquivar de tu Aspecto del mono.",
    "Aumenta en un 5% la bonificación de Esquivar de tu Aspecto del mono.",
  },
  [104976] = {
    "Aumenta en un 3% el Aguante de tus mascotas.",
    "Aumenta en un 6% el Aguante de tus mascotas.",
    "Aumenta en un 9% el Aguante de tus mascotas.",
    "Aumenta en un 12% el Aguante de tus mascotas.",
    "Aumenta en un 15% el Aguante de tus mascotas.",
  },
  [104987] = {
    "Aumenta en un 1% tu probabilidad de golpear y aumenta en un 5% adicional tu probabilidad de resistir efectos que impiden el movimiento.",
    "Aumenta en un 2% tu probabilidad de golpear y aumenta en un 10% adicional tu probabilidad de resistir efectos que impiden el movimiento.",
    "Aumenta en un 3% tu probabilidad de golpear y aumenta en un 15% adicional tu probabilidad de resistir efectos que impiden el movimiento.",
  },
  [104988] = {
    "Reduce en un 5% la probabilidad de que los enemigos resistan los efectos de tus trampas.",
    "Reduce en un 10% la probabilidad de que los enemigos resistan los efectos de tus trampas.",
  },
  [104989] = {
    "Un golpe que se activa después de parar un ataque del oponente. Este ataque inflige 40 de daño e inmoviliza al objetivo durante 5 seg. El Contraataque no puede ser bloqueado, esquivado ni parado.",
  },
  [104990] = {
    "Otorga a tu habilidad Cercenar un 4% de probabilidad de inmovilizar al objetivo durante 5 seg.",
    "Otorga a tu habilidad Cercenar un 8% de probabilidad de inmovilizar al objetivo durante 5 seg.",
    "Otorga a tu habilidad Cercenar un 12% de probabilidad de inmovilizar al objetivo durante 5 seg.",
    "Otorga a tu habilidad Cercenar un 16% de probabilidad de inmovilizar al objetivo durante 5 seg.",
    "Otorga a tu habilidad Cercenar un 20% de probabilidad de inmovilizar al objetivo durante 5 seg.",
  },
  [104992] = {
    "Aumenta tu salud total en un 2%.",
    "Aumenta tu salud total en un 4%.",
    "Aumenta tu salud total en un 6%.",
    "Aumenta tu salud total en un 8%.",
    "Aumenta tu salud total en un 10%.",
  },
  [104993] = {
    "Aumenta en un 10% la probabilidad de golpe crítico de Golpe de raptor y Mordedura de mangosta.",
    "Aumenta en un 20% la probabilidad de golpe crítico de Golpe de raptor y Mordedura de mangosta.",
  },
  [104994] = {
    "Otorga a tu Trampa de inmolación, Trampa de escarcha y Trampa explosiva un 5% de probabilidad de atrapar al objetivo, impidiéndole moverse durante 5 seg.",
    "Otorga a tu Trampa de inmolación, Trampa de escarcha y Trampa explosiva un 10% de probabilidad de atrapar al objetivo, impidiéndole moverse durante 5 seg.",
    "Otorga a tu Trampa de inmolación, Trampa de escarcha y Trampa explosiva un 15% de probabilidad de atrapar al objetivo, impidiéndole moverse durante 5 seg.",
    "Otorga a tu Trampa de inmolación, Trampa de escarcha y Trampa explosiva un 20% de probabilidad de atrapar al objetivo, impidiéndole moverse durante 5 seg.",
    "Otorga a tu Trampa de inmolación, Trampa de escarcha y Trampa explosiva un 25% de probabilidad de atrapar al objetivo, impidiéndole moverse durante 5 seg.",
  },
  [104995] = {
    "Aumenta en un 1% tu probabilidad de Parar.",
    "Aumenta en un 2% tu probabilidad de Parar.",
    "Aumenta en un 3% tu probabilidad de Parar.",
    "Aumenta en un 4% tu probabilidad de Parar.",
    "Aumenta en un 5% tu probabilidad de Parar.",
  },
  [104996] = {
    "Aumenta en un 1% todo el daño infligido a Bestias, Gigantes y Dragontinos, y aumenta en un 1% adicional el daño crítico contra esos objetivos.",
    "Aumenta en un 2% todo el daño infligido a Bestias, Gigantes y Dragontinos, y aumenta en un 2% adicional el daño crítico contra esos objetivos.",
    "Aumenta en un 3% todo el daño infligido a Bestias, Gigantes y Dragontinos, y aumenta en un 3% adicional el daño crítico contra esos objetivos.",
  },
  [105001] = {
    "Aumenta en un 5% el daño infligido por tus hechizos Disparo múltiple y Descarga.",
    "Aumenta en un 10% el daño infligido por tus hechizos Disparo múltiple y Descarga.",
    "Aumenta en un 15% el daño infligido por tus hechizos Disparo múltiple y Descarga.",
  },
  [105002] = {
    "Aumenta en un 6% la bonificación de daño crítico de tus armas a distancia.",
    "Aumenta en un 12% la bonificación de daño crítico de tus armas a distancia.",
    "Aumenta en un 18% la bonificación de daño crítico de tus armas a distancia.",
    "Aumenta en un 24% la bonificación de daño crítico de tus armas a distancia.",
    "Aumenta en un 30% la bonificación de daño crítico de tus armas a distancia.",
  },
  [105004] = {
    "Aumenta el poder de ataque de los miembros del grupo situados a menos de 45 metros en 50. Dura 30 min.",
  },
  [105006] = {
    "Reduce en 0.2 seg el tiempo de reutilización de tu Disparo arcano.",
    "Reduce en 0.4 seg el tiempo de reutilización de tu Disparo arcano.",
    "Reduce en 0.6 seg el tiempo de reutilización de tu Disparo arcano.",
    "Reduce en 0.8 seg el tiempo de reutilización de tu Disparo arcano.",
    "Reduce en 1 seg el tiempo de reutilización de tu Disparo arcano.",
  },
  [105009] = {
    "Reduce en un 2% el coste de maná de tus disparos y picaduras.",
    "Reduce en un 4% el coste de maná de tus disparos y picaduras.",
    "Reduce en un 6% el coste de maná de tus disparos y picaduras.",
    "Reduce en un 8% el coste de maná de tus disparos y picaduras.",
    "Reduce en un 10% el coste de maná de tus disparos y picaduras.",
  },
  [105011] = {
    "Aumenta en un 1% tu probabilidad de golpe crítico con armas a distancia.",
    "Aumenta en un 2% tu probabilidad de golpe crítico con armas a distancia.",
    "Aumenta en un 3% tu probabilidad de golpe crítico con armas a distancia.",
    "Aumenta en un 4% tu probabilidad de golpe crítico con armas a distancia.",
    "Aumenta en un 5% tu probabilidad de golpe crítico con armas a distancia.",
  },
  [105321] = {
    "Aumenta en un 1% la probabilidad de golpe crítico de tus hechizos Sagrados.",
    "Aumenta en un 2% la probabilidad de golpe crítico de tus hechizos Sagrados.",
    "Aumenta en un 3% la probabilidad de golpe crítico de tus hechizos Sagrados.",
    "Aumenta en un 4% la probabilidad de golpe crítico de tus hechizos Sagrados.",
    "Aumenta en un 5% la probabilidad de golpe crítico de tus hechizos Sagrados.",
  },
  [105323] = {
    "Golpea al objetivo con energía sagrada, causando de 204 a 220 de daño Sagrado a un enemigo, o de 204 a 220 de sanación a un aliado.",
  },
  [105329] = {
    "Después de obtener un efecto crítico de tus hechizos de sanación Destello de luz, Luz Sagrada o Choque Sagrado, te otorga un 20% de probabilidad de ganar maná igual al coste base del hechizo.",
    "Después de obtener un efecto crítico de tus hechizos de sanación Destello de luz, Luz Sagrada o Choque Sagrado, te otorga un 40% de probabilidad de ganar maná igual al coste base del hechizo.",
    "Después de obtener un efecto crítico de tus hechizos de sanación Destello de luz, Luz Sagrada o Choque Sagrado, te otorga un 60% de probabilidad de ganar maná igual al coste base del hechizo.",
    "Después de obtener un efecto crítico de tus hechizos de sanación Destello de luz, Luz Sagrada o Choque Sagrado, te otorga un 80% de probabilidad de ganar maná igual al coste base del hechizo.",
    "Después de obtener un efecto crítico de tus hechizos de sanación Destello de luz, Luz Sagrada o Choque Sagrado, te otorga un 100% de probabilidad de ganar maná igual al coste base del hechizo.",
  },
  [105331] = {
    "Aumenta en un 5% adicional tu probabilidad de resistir efectos de Miedo y Desorientación.",
    "Aumenta en un 10% adicional tu probabilidad de resistir efectos de Miedo y Desorientación.",
  },
  [105333] = {
    "Aumenta en un 4% la sanación realizada por tus hechizos Luz Sagrada y Destello de luz.",
    "Aumenta en un 8% la sanación realizada por tus hechizos Luz Sagrada y Destello de luz.",
    "Aumenta en un 12% la sanación realizada por tus hechizos Luz Sagrada y Destello de luz.",
  },
  [105334] = {
    "Aumenta en un 3% el daño infligido por tu Sello de rectitud y Juicio de rectitud.",
    "Aumenta en un 6% el daño infligido por tu Sello de rectitud y Juicio de rectitud.",
    "Aumenta en un 9% el daño infligido por tu Sello de rectitud y Juicio de rectitud.",
    "Aumenta en un 12% el daño infligido por tu Sello de rectitud y Juicio de rectitud.",
    "Aumenta en un 15% el daño infligido por tu Sello de rectitud y Juicio de rectitud.",
  },
  [105335] = {
    "Otorga a tus hechizos Destello de luz y Luz Sagrada un 14% de probabilidad de ignorar la interrupción por daño recibido mientras los lanzas.",
    "Otorga a tus hechizos Destello de luz y Luz Sagrada un 28% de probabilidad de ignorar la interrupción por daño recibido mientras los lanzas.",
    "Otorga a tus hechizos Destello de luz y Luz Sagrada un 42% de probabilidad de ignorar la interrupción por daño recibido mientras los lanzas.",
    "Otorga a tus hechizos Destello de luz y Luz Sagrada un 56% de probabilidad de ignorar la interrupción por daño recibido mientras los lanzas.",
    "Otorga a tus hechizos Destello de luz y Luz Sagrada un 70% de probabilidad de ignorar la interrupción por daño recibido mientras los lanzas.",
  },
}
do
  local C = AF.Content.esES
  C.classic = C.classic or {}
  for k, v in pairs(C.classic_part or {}) do C.classic[k] = v end
  C.classic_part = nil
end

AF.Content.esES.classic_part = {
  [105626] = {
    "Aumenta en un 6% tu probabilidad de bloquear ataques con el escudo después de recibir un golpe crítico. Dura 10 seg o 5 bloqueos.",
    "Aumenta en un 12% tu probabilidad de bloquear ataques con el escudo después de recibir un golpe crítico. Dura 10 seg o 5 bloqueos.",
    "Aumenta en un 18% tu probabilidad de bloquear ataques con el escudo después de recibir un golpe crítico. Dura 10 seg o 5 bloqueos.",
    "Aumenta en un 24% tu probabilidad de bloquear ataques con el escudo después de recibir un golpe crítico. Dura 10 seg o 5 bloqueos.",
    "Aumenta en un 30% tu probabilidad de bloquear ataques con el escudo después de recibir un golpe crítico. Dura 10 seg o 5 bloqueos.",
  },
  [105627] = {
    "Te da un 20% de probabilidad de conseguir un ataque adicional después de recibir un golpe crítico.",
    "Te da un 40% de probabilidad de conseguir un ataque adicional después de recibir un golpe crítico.",
    "Te da un 60% de probabilidad de conseguir un ataque adicional después de recibir un golpe crítico.",
    "Te da un 80% de probabilidad de conseguir un ataque adicional después de recibir un golpe crítico.",
    "Te da un 100% de probabilidad de conseguir un ataque adicional después de recibir un golpe crítico.",
  },
  [105628] = {
    "Aumenta en un 30% tu probabilidad de bloquear durante 10 seg, e inflige 65 p. de daño Sagrado por cada ataque bloqueado mientras está activo. El daño causado por Escudo sagrado genera un 20% más de amenaza. Cada bloqueo consume una carga. 4 cargas.",
  },
  [105629] = {
    "Aumenta en un 2% el daño que infliges con armas cuerpo a cuerpo a una mano.",
    "Aumenta en un 4% el daño que infliges con armas cuerpo a cuerpo a una mano.",
    "Aumenta en un 6% el daño que infliges con armas cuerpo a cuerpo a una mano.",
    "Aumenta en un 8% el daño que infliges con armas cuerpo a cuerpo a una mano.",
    "Aumenta en un 10% el daño que infliges con armas cuerpo a cuerpo a una mano.",
  },
  [105634] = {
    "Aumenta en un 16% la amenaza generada por tu hechizo Furia justa.",
    "Aumenta en un 33% la amenaza generada por tu hechizo Furia justa.",
    "Aumenta en un 50% la amenaza generada por tu hechizo Furia justa.",
  },
  [105636] = {
    "Aumenta en 2 tu habilidad de Defensa.",
    "Aumenta en 4 tu habilidad de Defensa.",
    "Aumenta en 6 tu habilidad de Defensa.",
    "Aumenta en 8 tu habilidad de Defensa.",
    "Aumenta en 10 tu habilidad de Defensa.",
  },
  [105637] = {
    "Reduce en 60 seg el tiempo de reutilización de tu Bendición de protección y aumenta en 3 seg la duración de tu Bendición de libertad.",
    "Reduce en 120 seg el tiempo de reutilización de tu Bendición de protección y aumenta en 6 seg la duración de tu Bendición de libertad.",
  },
  [105638] = {
    "Aumenta en un 1% tu probabilidad de golpear con armas cuerpo a cuerpo.",
    "Aumenta en un 2% tu probabilidad de golpear con armas cuerpo a cuerpo.",
    "Aumenta en un 3% tu probabilidad de golpear con armas cuerpo a cuerpo.",
  },
  [105693] = {
    "Te otorga una bonificación del 3% al daño Físico y Sagrado que infliges durante 8 seg después de asestar un golpe crítico con un golpe de arma, hechizo o habilidad.",
    "Te otorga una bonificación del 6% al daño Físico y Sagrado que infliges durante 8 seg después de asestar un golpe crítico con un golpe de arma, hechizo o habilidad.",
    "Te otorga una bonificación del 9% al daño Físico y Sagrado que infliges durante 8 seg después de asestar un golpe crítico con un golpe de arma, hechizo o habilidad.",
    "Te otorga una bonificación del 12% al daño Físico y Sagrado que infliges durante 8 seg después de asestar un golpe crítico con un golpe de arma, hechizo o habilidad.",
    "Te otorga una bonificación del 15% al daño Físico y Sagrado que infliges durante 8 seg después de asestar un golpe crítico con un golpe de arma, hechizo o habilidad.",
  },
  [105696] = {
    "Da al paladín una probabilidad de infligir daño Sagrado adicional igual al 70% del daño normal del arma. Solo puede haber un Sello activo a la vez en el paladín. Dura 30 seg.\n\nLiberar la energía de este Sello juzgará a un enemigo, causando instantáneamente 73 p. de daño Sagrado, o de 138 a 146 si el objetivo está aturdido o incapacitado.",
  },
  [105697] = {
    "Aumenta en un 2% el daño que infliges con armas cuerpo a cuerpo a dos manos.",
    "Aumenta en un 4% el daño que infliges con armas cuerpo a cuerpo a dos manos.",
    "Aumenta en un 6% el daño que infliges con armas cuerpo a cuerpo a dos manos.",
  },
  [105698] = {
    "Todos los críticos de hechizo que recibas también causarán al lanzador el 15% del daño recibido. El daño causado por Ojo por ojo no puede exceder el 50% de la salud total del paladín.",
    "Todos los críticos de hechizo que recibas también causarán al lanzador el 30% del daño recibido. El daño causado por Ojo por ojo no puede exceder el 50% de la salud total del paladín.",
  },
  [105699] = {
    "Aumenta en un 4% la velocidad de movimiento y la velocidad de movimiento montado. No se acumula con otros efectos que aumenten la velocidad de movimiento.",
    "Aumenta en un 8% la velocidad de movimiento y la velocidad de movimiento montado. No se acumula con otros efectos que aumenten la velocidad de movimiento.",
  },
  [105702] = {
    "Los ataques cuerpo a cuerpo dañinos del paladín tienen una probabilidad de reducir en un 5% la Fuerza y la Agilidad del objetivo durante 10 seg.",
    "Los ataques cuerpo a cuerpo dañinos del paladín tienen una probabilidad de reducir en un 10% la Fuerza y la Agilidad del objetivo durante 10 seg.",
    "Los ataques cuerpo a cuerpo dañinos del paladín tienen una probabilidad de reducir en un 15% la Fuerza y la Agilidad del objetivo durante 10 seg.",
  },
  [105703] = {
    "Aumenta en un 1% tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo.",
    "Aumenta en un 2% tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo.",
    "Aumenta en un 3% tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo.",
    "Aumenta en un 4% tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo.",
    "Aumenta en un 5% tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo.",
  },
  [105705] = {
    "Reduce en 1 seg el tiempo de reutilización de tu hechizo Juicio.",
    "Reduce en 2 seg el tiempo de reutilización de tu hechizo Juicio.",
  },
  [105706] = {
    "Reduce en un 3% el coste de maná de tus hechizos Juicio y Sello.",
    "Reduce en un 6% el coste de maná de tus hechizos Juicio y Sello.",
    "Reduce en un 9% el coste de maná de tus hechizos Juicio y Sello.",
    "Reduce en un 12% el coste de maná de tus hechizos Juicio y Sello.",
    "Reduce en un 15% el coste de maná de tus hechizos Juicio y Sello.",
  },
  [105708] = {
    "Aumenta en un 5% el daño causado por tu Evisceración.",
    "Aumenta en un 10% el daño causado por tu Evisceración.",
    "Aumenta en un 15% el daño causado por tu Evisceración.",
  },
  [105710] = {
    "Tus golpes críticos de habilidades que añaden puntos de combo tienen un 20% de probabilidad de añadir un punto de combo adicional.",
    "Tus golpes críticos de habilidades que añaden puntos de combo tienen un 40% de probabilidad de añadir un punto de combo adicional.",
    "Tus golpes críticos de habilidades que añaden puntos de combo tienen un 60% de probabilidad de añadir un punto de combo adicional.",
    "Tus golpes críticos de habilidades que añaden puntos de combo tienen un 80% de probabilidad de añadir un punto de combo adicional.",
    "Tus golpes críticos de habilidades que añaden puntos de combo tienen un 100% de probabilidad de añadir un punto de combo adicional.",
  },
  [105711] = {
    "Mientras esté afectado por tu Golpe de riñón, el objetivo recibe un 3% más de daño de todas las fuentes.",
    "Mientras esté afectado por tu Golpe de riñón, el objetivo recibe un 6% más de daño de todas las fuentes.",
    "Mientras esté afectado por tu Golpe de riñón, el objetivo recibe un 9% más de daño de todas las fuentes.",
  },
  [105713] = {
    "Aumenta en un 2% tu probabilidad de aplicar venenos a tu objetivo.",
    "Aumenta en un 4% tu probabilidad de aplicar venenos a tu objetivo.",
    "Aumenta en un 6% tu probabilidad de aplicar venenos a tu objetivo.",
    "Aumenta en un 8% tu probabilidad de aplicar venenos a tu objetivo.",
    "Aumenta en un 10% tu probabilidad de aplicar venenos a tu objetivo.",
  },
  [105715] = {
    "Al activarse, aumenta en un 100% la probabilidad de golpe crítico de tu siguiente Golpe siniestro, Puñalada, Emboscada o Evisceración.",
  },
  [105716] = {
    "Aumenta en un 6% la bonificación de daño de golpe crítico de tu Golpe siniestro, Gubia, Puñalada, Golpe fantasmal y Hemorragia.",
    "Aumenta en un 12% la bonificación de daño de golpe crítico de tu Golpe siniestro, Gubia, Puñalada, Golpe fantasmal y Hemorragia.",
    "Aumenta en un 18% la bonificación de daño de golpe crítico de tu Golpe siniestro, Gubia, Puñalada, Golpe fantasmal y Hemorragia.",
    "Aumenta en un 24% la bonificación de daño de golpe crítico de tu Golpe siniestro, Gubia, Puñalada, Golpe fantasmal y Hemorragia.",
    "Aumenta en un 30% la bonificación de daño de golpe crítico de tu Golpe siniestro, Gubia, Puñalada, Golpe fantasmal y Hemorragia.",
  },
  [105717] = {
    "Aumenta en un 25% la reducción de armadura de tu Exponer armadura.",
    "Aumenta en un 50% la reducción de armadura de tu Exponer armadura.",
  },
  [105718] = {
    "Aumenta tu Energía máxima en 10.",
  },
  [105720] = {
    "Aumenta en un 1% el daño infligido a Humanoides, Gigantes, Bestias y Dragonantes.",
    "Aumenta en un 2% el daño infligido a Humanoides, Gigantes, Bestias y Dragonantes.",
  },
  [105721] = {
    "Tus movimientos finales tienen un 20% de probabilidad de añadir un punto de combo a tu objetivo.",
    "Tus movimientos finales tienen un 40% de probabilidad de añadir un punto de combo a tu objetivo.",
    "Tus movimientos finales tienen un 60% de probabilidad de añadir un punto de combo a tu objetivo.",
  },
  [105722] = {
    "Aumenta en un 1% tu probabilidad de asestar un golpe crítico.",
    "Aumenta en un 2% tu probabilidad de asestar un golpe crítico.",
    "Aumenta en un 3% tu probabilidad de asestar un golpe crítico.",
    "Aumenta en un 4% tu probabilidad de asestar un golpe crítico.",
    "Aumenta en un 5% tu probabilidad de asestar un golpe crítico.",
  },
  [105723] = {
    "Tras matar a un oponente que otorgue experiencia o honor, aumenta en un 20% tu probabilidad de golpe crítico con tu siguiente Golpe siniestro, Puñalada, Emboscada o Golpe fantasmal. Dura 20 seg.",
    "Tras matar a un oponente que otorgue experiencia o honor, aumenta en un 40% tu probabilidad de golpe crítico con tu siguiente Golpe siniestro, Puñalada, Emboscada o Golpe fantasmal. Dura 20 seg.",
  },
  [105726] = {
    "Aumenta en 3 tu habilidad con Espadas, Armas de puño y Dagas.",
    "Aumenta en 5 tu habilidad con Espadas, Armas de puño y Dagas.",
  },
  [105727] = {
    "Te da un 1% de probabilidad de conseguir un ataque adicional contra el mismo objetivo después de infligir daño con tu espada.",
    "Te da un 2% de probabilidad de conseguir un ataque adicional contra el mismo objetivo después de infligir daño con tu espada.",
    "Te da un 3% de probabilidad de conseguir un ataque adicional contra el mismo objetivo después de infligir daño con tu espada.",
    "Te da un 4% de probabilidad de conseguir un ataque adicional contra el mismo objetivo después de infligir daño con tu espada.",
    "Te da un 5% de probabilidad de conseguir un ataque adicional contra el mismo objetivo después de infligir daño con tu espada.",
  },
  [105728] = {
    "Aumenta en un 20% tu velocidad de ataque. Además, los ataques golpean a un oponente cercano adicional. Dura 15 seg.",
  },
  [105730] = {
    "Aumenta en un 2% el daño de tus habilidades Golpe siniestro y Evisceración.",
    "Aumenta en un 4% el daño de tus habilidades Golpe siniestro y Evisceración.",
    "Aumenta en un 6% el daño de tus habilidades Golpe siniestro y Evisceración.",
  },
  [105733] = {
    "Tu habilidad Patada tiene un 50% de probabilidad de silenciar al objetivo durante 2 seg.",
    "Tu habilidad Patada tiene un 100% de probabilidad de silenciar al objetivo durante 2 seg.",
  },
  [105735] = {
    "Un ataque que se activa después de parar un ataque de un oponente. Este ataque inflige un 150% de daño del arma y desarma al objetivo durante 6 seg.",
  },
  [105736] = {
    "Reduce en 45 seg el tiempo de reutilización de tus habilidades Esprintar y Evasión.",
    "Reduce en 1.5 min el tiempo de reutilización de tus habilidades Esprintar y Evasión.",
  },
  [105737] = {
    "Aumenta en un 1% tu probabilidad de golpear con armas cuerpo a cuerpo.",
    "Aumenta en un 2% tu probabilidad de golpear con armas cuerpo a cuerpo.",
    "Aumenta en un 3% tu probabilidad de golpear con armas cuerpo a cuerpo.",
    "Aumenta en un 4% tu probabilidad de golpear con armas cuerpo a cuerpo.",
    "Aumenta en un 5% tu probabilidad de golpear con armas cuerpo a cuerpo.",
  },
  [105738] = {
    "Aumenta en un 1% tu probabilidad de parar.",
    "Aumenta en un 2% tu probabilidad de parar.",
    "Aumenta en un 3% tu probabilidad de parar.",
    "Aumenta en un 4% tu probabilidad de parar.",
    "Aumenta en un 5% tu probabilidad de parar.",
  },
  [105740] = {
    "Aumenta en un 10% el daño causado por tu arma de la mano izquierda.",
    "Aumenta en un 20% el daño causado por tu arma de la mano izquierda.",
    "Aumenta en un 30% el daño causado por tu arma de la mano izquierda.",
    "Aumenta en un 40% el daño causado por tu arma de la mano izquierda.",
    "Aumenta en un 50% el daño causado por tu arma de la mano izquierda.",
  },
  [105742] = {
    "Aumenta en 0.5 seg la duración de tu efecto de Gubia.",
    "Aumenta en 1 seg la duración de tu efecto de Gubia.",
    "Aumenta en 1.5 seg la duración de tu efecto de Gubia.",
  },
  [105743] = {
    "Al usarse, añade 2 puntos de combo a tu objetivo. Debes añadir o usar esos puntos de combo en un plazo de 10 seg o se perderán.",
  },
  [105745] = {
    "Reduce en 10 el coste de Energía de tu Golpe bajo y Garrote.",
    "Reduce en 20 el coste de Energía de tu Golpe bajo y Garrote.",
  },
  [105747] = {
    "Aumenta tu detección de Sigilo y reduce en un 2% la probabilidad de que te alcancen hechizos y ataques a distancia.",
    "Aumenta tu detección de Sigilo y reduce en un 4% la probabilidad de que te alcancen hechizos y ataques a distancia. Más eficaz que Sentidos agudizados (rango 1).",
  },
  [105748] = {
    "Un golpe instantáneo que daña al oponente y hace que el objetivo sufra una hemorragia, lo que aumenta hasta en 3 cualquier daño Físico infligido al objetivo. Dura 30 cargas o 15 seg. Otorga 1 punto de combo.",
  },
  [105751] = {
    "Te da un 15% de probabilidad de añadir un punto de combo a tu objetivo después de esquivar su ataque o resistir por completo uno de sus hechizos.",
    "Te da un 30% de probabilidad de añadir un punto de combo a tu objetivo después de esquivar su ataque o resistir por completo uno de sus hechizos.",
    "Te da un 45% de probabilidad de añadir un punto de combo a tu objetivo después de esquivar su ataque o resistir por completo uno de sus hechizos.",
  },
  [105752] = {
    "Hace que tus ataques ignoren 100 p. de la Armadura de tu objetivo y aumenta en un 10% el daño infligido por tu Ruptura. La cantidad de Armadura ignorada aumenta con tu nivel.",
    "Hace que tus ataques ignoren 200 p. de la Armadura de tu objetivo y aumenta en un 20% el daño infligido por tu Ruptura. La cantidad de Armadura ignorada aumenta con tu nivel.",
    "Hace que tus ataques ignoren 300 p. de la Armadura de tu objetivo y aumenta en un 30% el daño infligido por tu Ruptura. La cantidad de Armadura ignorada aumenta con tu nivel.",
  },
  [105753] = {
    "Reduce en 45 seg el tiempo de reutilización de tus habilidades Esfumarse y Ceguera.",
    "Reduce en 1.5 seg el tiempo de reutilización de tus habilidades Esfumarse y Ceguera.",
  },
  [105754] = {
    "Un golpe que inflige un 125% de daño del arma y aumenta en un 15% tu probabilidad de esquivar durante 7 seg. Otorga 1 punto de combo.",
  },
  [105755] = {
    "Te da un 25% de probabilidad de añadir un punto de combo adicional a tu objetivo al usar tu habilidad Emboscada, Garrote o Golpe bajo.",
    "Te da un 50% de probabilidad de añadir un punto de combo adicional a tu objetivo al usar tu habilidad Emboscada, Garrote o Golpe bajo.",
    "Te da un 75% de probabilidad de añadir un punto de combo adicional a tu objetivo al usar tu habilidad Emboscada, Garrote o Golpe bajo.",
  },
  [105756] = {
    "Aumenta en un 3% tu velocidad de movimiento mientras estás en Sigilo y reduce en 1 seg el tiempo de reutilización de tu habilidad Sigilo.",
    "Aumenta en un 6% tu velocidad de movimiento mientras estás en Sigilo y reduce en 2 seg el tiempo de reutilización de tu habilidad Sigilo.",
    "Aumenta en un 9% tu velocidad de movimiento mientras estás en Sigilo y reduce en 3 seg el tiempo de reutilización de tu habilidad Sigilo.",
    "Aumenta en un 12% tu velocidad de movimiento mientras estás en Sigilo y reduce en 4 seg el tiempo de reutilización de tu habilidad Sigilo.",
    "Aumenta en un 15% tu velocidad de movimiento mientras estás en Sigilo y reduce en 5 seg el tiempo de reutilización de tu habilidad Sigilo.",
  },
  [105759] = {
    "Tus movimientos finales tienen un 20% de probabilidad por punto de combo de restaurar 25 de Energía.",
  },
  [105760] = {
    "Aumenta en un 4% el daño infligido al golpear por la espalda con tu Puñalada, Garrote o Emboscada.",
    "Aumenta en un 8% el daño infligido al golpear por la espalda con tu Puñalada, Garrote o Emboscada.",
    "Aumenta en un 12% el daño infligido al golpear por la espalda con tu Puñalada, Garrote o Emboscada.",
    "Aumenta en un 16% el daño infligido al golpear por la espalda con tu Puñalada, Garrote o Emboscada.",
    "Aumenta en un 20% el daño infligido al golpear por la espalda con tu Puñalada, Garrote o Emboscada.",
  },
  [105761] = {
    "Reduce la probabilidad de que los enemigos te detecten mientras estás en Sigilo.",
    "Reduce la probabilidad de que los enemigos te detecten mientras estás en Sigilo. Más eficaz que Maestro del engaño (rango 1).",
    "Reduce la probabilidad de que los enemigos te detecten mientras estás en Sigilo. Más eficaz que Maestro del engaño (rango 2).",
    "Reduce la probabilidad de que los enemigos te detecten mientras estás en Sigilo. Más eficaz que Maestro del engaño (rango 3).",
    "Reduce la probabilidad de que los enemigos te detecten mientras estás en Sigilo. Más eficaz que Maestro del engaño (rango 4).",
  },
  [105762] = {
    "Te protege al instante con un escudo que absorbe 455 p. de daño. Dura 1 min. Mientras el escudo aguante, los hechizos no serán interrumpidos.",
  },
  [105763] = {
    "Tus hechizos de daño de Escarcha tienen un 20% de probabilidad de aplicar el efecto Frío invernal, que aumenta en un 2% la probabilidad de que un hechizo de Escarcha asesté un golpe crítico al objetivo durante 15 seg. Se acumula hasta 5 veces.",
    "Tus hechizos de daño de Escarcha tienen un 40% de probabilidad de aplicar el efecto Frío invernal, que aumenta en un 2% la probabilidad de que un hechizo de Escarcha asesté un golpe crítico al objetivo durante 15 seg. Se acumula hasta 5 veces.",
    "Tus hechizos de daño de Escarcha tienen un 60% de probabilidad de aplicar el efecto Frío invernal, que aumenta en un 2% la probabilidad de que un hechizo de Escarcha asesté un golpe crítico al objetivo durante 15 seg. Se acumula hasta 5 veces.",
    "Tus hechizos de daño de Escarcha tienen un 80% de probabilidad de aplicar el efecto Frío invernal, que aumenta en un 2% la probabilidad de que un hechizo de Escarcha asesté un golpe crítico al objetivo durante 15 seg. Se acumula hasta 5 veces.",
    "Tus hechizos de daño de Escarcha tienen un 100% de probabilidad de aplicar el efecto Frío invernal, que aumenta en un 2% la probabilidad de que un hechizo de Escarcha asesté un golpe crítico al objetivo durante 15 seg. Se acumula hasta 5 veces.",
  },
  [105765] = {
    "Aumenta en un 15% el daño infligido por tu hechizo Cono de frío.",
    "Aumenta en un 25% el daño infligido por tu hechizo Cono de frío.",
    "Aumenta en un 35% el daño infligido por tu hechizo Cono de frío.",
  },
  [105766] = {
    "Al activarse, este hechizo finaliza el tiempo de reutilización de todos tus hechizos de Escarcha.",
  },
  [105768] = {
    "Aumenta en un 10% la probabilidad de golpe crítico de todos tus hechizos contra objetivos congelados.",
    "Aumenta en un 20% la probabilidad de golpe crítico de todos tus hechizos contra objetivos congelados.",
    "Aumenta en un 30% la probabilidad de golpe crítico de todos tus hechizos contra objetivos congelados.",
    "Aumenta en un 40% la probabilidad de golpe crítico de todos tus hechizos contra objetivos congelados.",
    "Aumenta en un 50% la probabilidad de golpe crítico de todos tus hechizos contra objetivos congelados.",
  },
  [105769] = {
    "Quedas encerrado en un bloque de hielo que te protege de todos los ataques físicos y hechizos durante 10 seg, pero durante ese tiempo no puedes atacar, moverte ni lanzar hechizos.",
  },
  [105771] = {
    "Añade un efecto de enfriamiento a tu hechizo Ventisca. Este efecto reduce en un 30% la velocidad de movimiento del objetivo. Dura 1.5 seg.",
    "Añade un efecto de enfriamiento a tu hechizo Ventisca. Este efecto reduce en un 50% la velocidad de movimiento del objetivo. Dura 1.5 seg.",
    "Añade un efecto de enfriamiento a tu hechizo Ventisca. Este efecto reduce en un 65% la velocidad de movimiento del objetivo. Dura 1.5 seg.",
  },
  [105774] = {
    "Tus efectos de enfriamiento tienen un 5% de probabilidad de congelar al objetivo durante 5 seg.",
    "Tus efectos de enfriamiento tienen un 10% de probabilidad de congelar al objetivo durante 5 seg.",
    "Tus efectos de enfriamiento tienen un 15% de probabilidad de congelar al objetivo durante 5 seg.",
  },
  [105776] = {
    "Aumenta en 1 seg la duración de tus efectos de enfriamiento y reduce en un 4% adicional la velocidad del objetivo.",
    "Aumenta en 2 seg la duración de tus efectos de enfriamiento y reduce en un 7% adicional la velocidad del objetivo.",
    "Aumenta en 3 seg la duración de tus efectos de enfriamiento y reduce en un 10% adicional la velocidad del objetivo.",
  },
  [105778] = {
    "Reduce en un 2% la probabilidad de que el oponente resista tus hechizos de Escarcha y Fuego.",
    "Reduce en un 4% la probabilidad de que el oponente resista tus hechizos de Escarcha y Fuego.",
    "Reduce en un 6% la probabilidad de que el oponente resista tus hechizos de Escarcha y Fuego.",
  },
  [105780] = {
    "Aumenta en un 15% la armadura y las resistencias otorgadas por tus hechizos Armadura de escarcha y Armadura de hielo. Además, tu Resguardo de escarcha tiene un 10% de probabilidad de reflejar hechizos y efectos de Escarcha mientras está activo.",
    "Aumenta en un 30% la armadura y las resistencias otorgadas por tus hechizos Armadura de escarcha y Armadura de hielo. Además, tu Resguardo de escarcha tiene un 20% de probabilidad de reflejar hechizos y efectos de Escarcha mientras está activo.",
  },
  [105781] = {
    "Al activarse, este hechizo hace que cada impacto de tus hechizos de daño de Fuego aumente en un 10% tu probabilidad de golpe crítico con hechizos de daño de Fuego. Este efecto dura hasta que hayas causado 3 golpes críticos con hechizos de Fuego.",
  },
  [105783] = {
    "Una oleada de llamas se irradia hacia fuera desde el lanzador, dañando a todos los enemigos atrapados en la explosión con 160 a 192 p. de daño de Fuego y atontándolos durante 6 seg.",
  },
  [105785] = {
    "Tus críticos de hechizos de Fuego y Escarcha te devolverán el 10% de su coste base de maná.",
    "Tus críticos de hechizos de Fuego y Escarcha te devolverán el 20% de su coste base de maná.",
    "Tus críticos de hechizos de Fuego y Escarcha te devolverán el 30% de su coste base de maná.",
  },
  [105788] = {
    "Tus hechizos Quemadura tienen un 33% de probabilidad de hacer que tu objetivo sea vulnerable al daño de Fuego. Esta vulnerabilidad aumenta en un 3% el daño de Fuego infligido a tu objetivo y dura 30 seg. Se acumula hasta 5 veces.",
    "Tus hechizos Quemadura tienen un 66% de probabilidad de hacer que tu objetivo sea vulnerable al daño de Fuego. Esta vulnerabilidad aumenta en un 3% el daño de Fuego infligido a tu objetivo y dura 30 seg. Se acumula hasta 5 veces.",
    "Tus hechizos Quemadura tienen un 100% de probabilidad de hacer que tu objetivo sea vulnerable al daño de Fuego. Esta vulnerabilidad aumenta en un 3% el daño de Fuego infligido a tu objetivo y dura 30 seg. Se acumula hasta 5 veces.",
  },
  [105789] = {
    "Tus hechizos de Fuego tienen un 35% de probabilidad de ignorar la interrupción causada por el daño mientras lanzas, y reducen en un 15% la amenaza causada por tus hechizos de Fuego.",
    "Tus hechizos de Fuego tienen un 70% de probabilidad de ignorar la interrupción causada por el daño mientras lanzas, y reducen en un 30% la amenaza causada por tus hechizos de Fuego.",
  },
  [105790] = {
    "Lanza una inmensa roca ígnea que causa 149 a 195 p. de daño de Fuego y 56 p. de daño de Fuego adicional durante 12 seg.",
  },
  [105792] = {
    "Tus hechizos de Fuego tienen un 2% de probabilidad de aturdir al objetivo durante 2 seg.",
    "Tus hechizos de Fuego tienen un 4% de probabilidad de aturdir al objetivo durante 2 seg.",
    "Tus hechizos de Fuego tienen un 6% de probabilidad de aturdir al objetivo durante 2 seg.",
    "Tus hechizos de Fuego tienen un 8% de probabilidad de aturdir al objetivo durante 2 seg.",
    "Tus hechizos de Fuego tienen un 10% de probabilidad de aturdir al objetivo durante 2 seg.",
  },
  [105795] = {
    "Reduce en 0.1 seg el tiempo de lanzamiento de tu hechizo Bola de fuego.",
    "Reduce en 0.2 seg el tiempo de lanzamiento de tu hechizo Bola de fuego.",
    "Reduce en 0.3 seg el tiempo de lanzamiento de tu hechizo Bola de fuego.",
    "Reduce en 0.4 seg el tiempo de lanzamiento de tu hechizo Bola de fuego.",
    "Reduce en 0.5 seg el tiempo de lanzamiento de tu hechizo Bola de fuego.",
  },
  [105796] = {
    "Aumenta en un 2% la probabilidad de golpe crítico de tus hechizos Explosión de fuego y Quemadura.",
    "Aumenta en un 4% la probabilidad de golpe crítico de tus hechizos Explosión de fuego y Quemadura.",
  },
  [105797] = {
    "Reduce en 0.5 seg el tiempo de reutilización de tu hechizo Explosión de fuego.",
    "Reduce en 1 seg el tiempo de reutilización de tu hechizo Explosión de fuego.",
    "Reduce en 1.5 seg el tiempo de reutilización de tu hechizo Explosión de fuego.",
  },
  [105798] = {
    "Al activarse, tus hechizos infligen un 30% más de daño pero cuestan un 30% más de maná. Este efecto dura 15 seg.",
  },
  [105799] = {
    "Aumenta en un 1% tu daño con hechizos y tu probabilidad de asestar un golpe crítico.",
    "Aumenta en un 2% tu daño con hechizos y tu probabilidad de asestar un golpe crítico.",
    "Aumenta en un 3% tu daño con hechizos y tu probabilidad de asestar un golpe crítico.",
  },
  [105800] = {
    "Aumenta en un 2% tu maná máximo.",
    "Aumenta en un 4% tu maná máximo.",
    "Aumenta en un 6% tu maná máximo.",
    "Aumenta en un 8% tu maná máximo.",
    "Aumenta en un 10% tu maná máximo.",
  },
  [105803] = {
    "Permite que continúe mientras lanzas hechizos el 5% de tu regeneración de maná.",
    "Permite que continúe mientras lanzas hechizos el 10% de tu regeneración de maná.",
    "Permite que continúe mientras lanzas hechizos el 15% de tu regeneración de maná.",
  },
  [105804] = {
    "Tu Contrahechizo tiene un 50% de probabilidad de silenciar al objetivo durante 4 seg.",
    "Tu Contrahechizo tiene un 100% de probabilidad de silenciar al objetivo durante 4 seg.",
  },
  [105805] = {
    "Reduce en un 10% el maná perdido por cada punto de daño recibido cuando Escudo de maná está activo.",
    "Reduce en un 20% el maná perdido por cada punto de daño recibido cuando Escudo de maná está activo.",
  },
  [105807] = {
    "Aumenta en un 2% adicional la probabilidad de golpe crítico de tu hechizo Explosión Arcana.",
    "Aumenta en un 4% adicional la probabilidad de golpe crítico de tu hechizo Explosión Arcana.",
    "Aumenta en un 6% adicional la probabilidad de golpe crítico de tu hechizo Explosión Arcana.",
  },
  [105808] = {
    "Aumenta en un 25% el efecto de tus hechizos Amplificar magia y Atenuar magia.",
    "Aumenta en un 50% el efecto de tus hechizos Amplificar magia y Atenuar magia.",
  },
  [105809] = {
    "Aumenta tu armadura en una cantidad igual al 50% de tu Inteligencia.",
  },
  [105811] = {
    "Aumenta todas las resistencias en 2 y hace que todos los hechizos completamente resistidos restauren un 1% de tu maná total. 1 seg de tiempo de reutilización.",
    "Aumenta todas las resistencias en 4 y hace que todos los hechizos completamente resistidos restauren un 2% de tu maná total. 1 seg de tiempo de reutilización.",
    "Aumenta todas las resistencias en 6 y hace que todos los hechizos completamente resistidos restauren un 3% de tu maná total. 1 seg de tiempo de reutilización.",
    "Aumenta todas las resistencias en 8 y hace que todos los hechizos completamente resistidos restauren un 4% de tu maná total. 1 seg de tiempo de reutilización.",
    "Aumenta todas las resistencias en 10 y hace que todos los hechizos completamente resistidos restauren un 5% de tu maná total. 1 seg de tiempo de reutilización.",
  },
  [105812] = {
    "Reduce en 5 la resistencia de tu objetivo a todos tus hechizos y reduce en un 20% la amenaza causada por tus hechizos Arcanos.",
    "Reduce en 10 la resistencia de tu objetivo a todos tus hechizos y reduce en un 40% la amenaza causada por tus hechizos Arcanos.",
  },
  [105813] = {
    "Te da un 20% de probabilidad de evitar la interrupción causada por el daño mientras canalizas Misiles Arcanos.",
    "Te da un 40% de probabilidad de evitar la interrupción causada por el daño mientras canalizas Misiles Arcanos.",
    "Te da un 60% de probabilidad de evitar la interrupción causada por el daño mientras canalizas Misiles Arcanos.",
    "Te da un 80% de probabilidad de evitar la interrupción causada por el daño mientras canalizas Misiles Arcanos.",
    "Te da un 100% de probabilidad de evitar la interrupción causada por el daño mientras canalizas Misiles Arcanos.",
  },
  [105814] = {
    "Reduce en un 2% la probabilidad de que el oponente resista tus hechizos Arcanos.",
    "Reduce en un 4% la probabilidad de que el oponente resista tus hechizos Arcanos.",
    "Reduce en un 6% la probabilidad de que el oponente resista tus hechizos Arcanos.",
    "Reduce en un 8% la probabilidad de que el oponente resista tus hechizos Arcanos.",
    "Reduce en un 10% la probabilidad de que el oponente resista tus hechizos Arcanos.",
  },
  [105817] = {
    "Adopta una Forma de las Sombras, que aumenta en un 15% tu daño de Sombras y reduce en un 15% el daño Físico que recibes. Sin embargo, no puedes lanzar hechizos Sagrados mientras estés en esta forma.",
  },
  [105818] = {
    "Aumenta en un 2% el daño causado por tus hechizos de Sombras.",
    "Aumenta en un 4% el daño causado por tus hechizos de Sombras.",
    "Aumenta en un 6% el daño causado por tus hechizos de Sombras.",
    "Aumenta en un 8% el daño causado por tus hechizos de Sombras.",
    "Aumenta en un 10% el daño causado por tus hechizos de Sombras.",
  },
  [105820] = {
    "Aflige a tu objetivo con energía de Sombras que cura a todos los miembros del grupo por el 20% del daño causado por tus hechizos de Sombras durante 1 min.",
  },
  [105821] = {
    "Tus hechizos de daño de Sombras tienen un 20% de probabilidad de hacer que tu objetivo sea vulnerable al daño de Sombras. Esta vulnerabilidad aumenta en un 3% el daño de Sombras infligido a tu objetivo y dura 15 seg. Se acumula hasta 5 veces.",
    "Tus hechizos de daño de Sombras tienen un 40% de probabilidad de hacer que tu objetivo sea vulnerable al daño de Sombras. Esta vulnerabilidad aumenta en un 3% el daño de Sombras infligido a tu objetivo y dura 15 seg. Se acumula hasta 5 veces.",
    "Tus hechizos de daño de Sombras tienen un 60% de probabilidad de hacer que tu objetivo sea vulnerable al daño de Sombras. Esta vulnerabilidad aumenta en un 3% el daño de Sombras infligido a tu objetivo y dura 15 seg. Se acumula hasta 5 veces.",
    "Tus hechizos de daño de Sombras tienen un 80% de probabilidad de hacer que tu objetivo sea vulnerable al daño de Sombras. Esta vulnerabilidad aumenta en un 3% el daño de Sombras infligido a tu objetivo y dura 15 seg. Se acumula hasta 5 veces.",
    "Tus hechizos de daño de Sombras tienen un 100% de probabilidad de hacer que tu objetivo sea vulnerable al daño de Sombras. Esta vulnerabilidad aumenta en un 3% el daño de Sombras infligido a tu objetivo y dura 15 seg. Se acumula hasta 5 veces.",
  },
  [105824] = {
    "Silencia al objetivo e impide que lance hechizos durante 5 seg.",
  },
  [105826] = {
    "Asalta la mente del objetivo con energía de Sombras, causando 75 p. de daño de Sombras durante 3 seg y reduciendo su velocidad de movimiento en un 50%.",
  },
  [105829] = {
    "Aumenta en un 6% el alcance de tus hechizos de daño de Sombras.",
    "Aumenta en un 13% el alcance de tus hechizos de daño de Sombras.",
    "Aumenta en un 20% el alcance de tus hechizos de daño de Sombras.",
  },
}
do
  local C = AF.Content.esES
  C.classic = C.classic or {}
  for k, v in pairs(C.classic_part or {}) do C.classic[k] = v end
  C.classic_part = nil
end

AF.Content.esES.classic_part = {
  [105831] = {
    "Reduce la amenaza generada por tus hechizos de las Sombras en un 8%.",
    "Reduce la amenaza generada por tus hechizos de las Sombras en un 16%.",
    "Reduce la amenaza generada por tus hechizos de las Sombras en un 25%.",
  },
  [105833] = {
    "Te otorga un 20% de probabilidad de obtener una bonificación del 100% a tu Espíritu tras matar a un objetivo que otorgue experiencia. Mientras este efecto está activo, tu maná continúa regenerándose al 50% del ritmo normal mientras lanzas hechizos. Dura 15 s.",
    "Te otorga un 40% de probabilidad de obtener una bonificación del 100% a tu Espíritu tras matar a un objetivo que otorgue experiencia. Mientras este efecto está activo, tu maná continúa regenerándose al 50% del ritmo normal mientras lanzas hechizos. Dura 15 s.",
    "Te otorga un 60% de probabilidad de obtener una bonificación del 100% a tu Espíritu tras matar a un objetivo que otorgue experiencia. Mientras este efecto está activo, tu maná continúa regenerándose al 50% del ritmo normal mientras lanzas hechizos. Dura 15 s.",
    "Te otorga un 80% de probabilidad de obtener una bonificación del 100% a tu Espíritu tras matar a un objetivo que otorgue experiencia. Mientras este efecto está activo, tu maná continúa regenerándose al 50% del ritmo normal mientras lanzas hechizos. Dura 15 s.",
    "Te otorga un 100% de probabilidad de obtener una bonificación del 100% a tu Espíritu tras matar a un objetivo que otorgue experiencia. Mientras este efecto está activo, tu maná continúa regenerándose al 50% del ritmo normal mientras lanzas hechizos. Dura 15 s.",
  },
  [105836] = {
    "Infunde poder al objetivo, aumentando su daño de hechizos y su sanación en un 20%. Dura 15 s.",
  },
  [105837] = {
    "Aumenta tu maná máximo en un 2%.",
    "Aumenta tu maná máximo en un 4%.",
    "Aumenta tu maná máximo en un 6%.",
    "Aumenta tu maná máximo en un 8%.",
    "Aumenta tu maná máximo en un 10%.",
  },
  [105838] = {
    "Reduce el tiempo de lanzamiento de tu hechizo Quemar maná en 0,25 s.",
    "Reduce el tiempo de lanzamiento de tu hechizo Quemar maná en 0,5 s.",
  },
  [105841] = {
    "Aumenta la bonificación de armadura de tu hechizo Fuego interno en un 10%.",
    "Aumenta la bonificación de armadura de tu hechizo Fuego interno en un 20%.",
    "Aumenta la bonificación de armadura de tu hechizo Fuego interno en un 30%.",
  },
  [105842] = {
    "Reduce el coste de maná de tus hechizos de lanzamiento instantáneo en un 2%.",
    "Reduce el coste de maná de tus hechizos de lanzamiento instantáneo en un 4%.",
    "Reduce el coste de maná de tus hechizos de lanzamiento instantáneo en un 6%.",
    "Reduce el coste de maná de tus hechizos de lanzamiento instantáneo en un 8%.",
    "Reduce el coste de maná de tus hechizos de lanzamiento instantáneo en un 10%.",
  },
  [105843] = {
    "Permite que el 5% de tu regeneración de maná continúe mientras lanzas hechizos.",
    "Permite que el 10% de tu regeneración de maná continúe mientras lanzas hechizos.",
    "Permite que el 15% de tu regeneración de maná continúe mientras lanzas hechizos.",
  },
  [105845] = {
    "Te otorga un 50% de probabilidad de obtener el efecto Lanzamiento concentrado, que dura 6 s, tras recibir un golpe crítico cuerpo a cuerpo o a distancia. El efecto Lanzamiento concentrado evita que pierdas tiempo de lanzamiento al recibir daño y aumenta la resistencia a los efectos de interrupción en un 10%.",
    "Te otorga un 100% de probabilidad de obtener el efecto Lanzamiento concentrado, que dura 6 s, tras recibir un golpe crítico cuerpo a cuerpo o a distancia. El efecto Lanzamiento concentrado evita que pierdas tiempo de lanzamiento al recibir daño y aumenta la resistencia a los efectos de interrupción en un 20%.",
  },
  [105846] = {
    "Aumenta la cantidad de daño absorbida por tu Palabra de poder: Escudo en un 5%.",
    "Aumenta la cantidad de daño absorbida por tu Palabra de poder: Escudo en un 10%.",
    "Aumenta la cantidad de daño absorbida por tu Palabra de poder: Escudo en un 15%.",
  },
  [105848] = {
    "Reduce la amenaza generada por tus hechizos en un 4%.",
    "Reduce la amenaza generada por tus hechizos en un 8%.",
    "Reduce la amenaza generada por tus hechizos en un 12%.",
    "Reduce la amenaza generada por tus hechizos en un 16%.",
    "Reduce la amenaza generada por tus hechizos en un 20%.",
  },
  [105850] = {
    "Aumenta el daño que infliges con varitas en un 5%.",
    "Aumenta el daño que infliges con varitas en un 10%.",
    "Aumenta el daño que infliges con varitas en un 15%.",
    "Aumenta el daño que infliges con varitas en un 20%.",
    "Aumenta el daño que infliges con varitas en un 25%.",
  },
  [105852] = {
    "Aumenta la cantidad sanada por tus hechizos de sanación en un 2%.",
    "Aumenta la cantidad sanada por tus hechizos de sanación en un 4%.",
    "Aumenta la cantidad sanada por tus hechizos de sanación en un 6%.",
    "Aumenta la cantidad sanada por tus hechizos de sanación en un 8%.",
    "Aumenta la cantidad sanada por tus hechizos de sanación en un 10%.",
  },
  [105853] = {
    "Aumenta el daño de hechizos y la sanación hasta en un 5% de tu Espíritu total.",
    "Aumenta el daño de hechizos y la sanación hasta en un 10% de tu Espíritu total.",
    "Aumenta el daño de hechizos y la sanación hasta en un 15% de tu Espíritu total.",
    "Aumenta el daño de hechizos y la sanación hasta en un 20% de tu Espíritu total.",
    "Aumenta el daño de hechizos y la sanación hasta en un 25% de tu Espíritu total.",
  },
  [105854] = {
    "Al morir, el sacerdote se convierte en el Espíritu de redención durante 10 s. El Espíritu de redención no puede moverse, atacar, ser atacado ni ser objetivo de ningún hechizo o efecto. Mientras está en esta forma, el sacerdote puede lanzar cualquier hechizo de sanación sin coste alguno. Cuando el efecto termina, el sacerdote muere.",
  },
  [105857] = {
    "Aumenta el daño causado por tus hechizos Aplastar y Fuego sagrado en un 5%.",
    "Aumenta el daño causado por tus hechizos Aplastar y Fuego sagrado en un 10%.",
  },
  [105858] = {
    "Reduce el coste de maná de tus hechizos Sanación menor, Sanación y Sanación superior en un 5%.",
    "Reduce el coste de maná de tus hechizos Sanación menor, Sanación y Sanación superior en un 10%.",
    "Reduce el coste de maná de tus hechizos Sanación menor, Sanación y Sanación superior en un 15%.",
  },
  [105860] = {
    "Aumenta la armadura de tu objetivo en un 8% durante 15 s tras recibir un efecto crítico de tus hechizos Sanación relámpago, Sanación, Sanación superior o Rezo de sanación.",
    "Aumenta la armadura de tu objetivo en un 16% durante 15 s tras recibir un efecto crítico de tus hechizos Sanación relámpago, Sanación, Sanación superior o Rezo de sanación.",
    "Aumenta la armadura de tu objetivo en un 25% durante 15 s tras recibir un efecto crítico de tus hechizos Sanación relámpago, Sanación, Sanación superior o Rezo de sanación.",
  },
  [105861] = {
    "Tras recibir un golpe crítico de un ataque cuerpo a cuerpo o a distancia, recuperas el 8% del daño recibido durante 6 s.",
    "Tras recibir un golpe crítico de un ataque cuerpo a cuerpo o a distancia, recuperas el 16% del daño recibido durante 6 s.",
    "Tras recibir un golpe crítico de un ataque cuerpo a cuerpo o a distancia, recuperas el 25% del daño recibido durante 6 s.",
  },
  [105862] = {
    "Provoca una explosión de luz sagrada alrededor del lanzador, que inflige de 29 a 33 p. de daño Sagrado a todos los objetivos enemigos situados a 10 m o menos y sana de 54 a 62 p. a todos los miembros del grupo situados a 10 m o menos. Estos efectos no generan amenaza.",
  },
  [105863] = {
    "Reduce el tiempo de lanzamiento de tus hechizos Aplastar, Fuego sagrado, Sanación y Sanación superior en 0,1 s.",
    "Reduce el tiempo de lanzamiento de tus hechizos Aplastar, Fuego sagrado, Sanación y Sanación superior en 0,2 s.",
    "Reduce el tiempo de lanzamiento de tus hechizos Aplastar, Fuego sagrado, Sanación y Sanación superior en 0,3 s.",
    "Reduce el tiempo de lanzamiento de tus hechizos Aplastar, Fuego sagrado, Sanación y Sanación superior en 0,4 s.",
    "Reduce el tiempo de lanzamiento de tus hechizos Aplastar, Fuego sagrado, Sanación y Sanación superior en 0,5 s.",
  },
  [105867] = {
    "Te otorga un 35% de probabilidad de evitar la interrupción causada por daño mientras lanzas un hechizo de sanación.",
    "Te otorga un 70% de probabilidad de evitar la interrupción causada por daño mientras lanzas un hechizo de sanación.",
  },
  [105878] = {
    "Otorga a tus hechizos Lluvia de fuego, Llamas infernales y Fuego de alma un 13% de probabilidad de aturdir al objetivo durante 3 s.",
    "Otorga a tus hechizos Lluvia de fuego, Llamas infernales y Fuego de alma un 26% de probabilidad de aturdir al objetivo durante 3 s.",
  },
  [105879] = {
    "Aumenta la probabilidad de golpe crítico de tu hechizo Dolor abrasador en un 2%.",
    "Aumenta la probabilidad de golpe crítico de tu hechizo Dolor abrasador en un 4%.",
    "Aumenta la probabilidad de golpe crítico de tu hechizo Dolor abrasador en un 6%.",
    "Aumenta la probabilidad de golpe crítico de tu hechizo Dolor abrasador en un 8%.",
    "Aumenta la probabilidad de golpe crítico de tu hechizo Dolor abrasador en un 10%.",
  },
  [105880] = {
    "Prende fuego a un objetivo que ya esté afectado por Inmolar, infligiendo de 250 a 316 p. de daño de Fuego y consumiendo el hechizo Inmolar.",
  },
  [105881] = {
    "Aumenta el alcance de tus hechizos de Destrucción en un 10%.",
    "Aumenta el alcance de tus hechizos de Destrucción en un 20%.",
  },
  [105882] = {
    "Te otorga un 35% de probabilidad de resistir la interrupción causada por daño mientras canalizas el hechizo Lluvia de fuego, Llamas infernales o Fuego de alma.",
    "Te otorga un 70% de probabilidad de resistir la interrupción causada por daño mientras canalizas el hechizo Lluvia de fuego, Llamas infernales o Fuego de alma.",
  },
  [105883] = {
    "Aumenta la bonificación de daño de golpe crítico de tus hechizos de Destrucción en un 100%.",
  },
  [105884] = {
    "Fulmina al instante al objetivo, infligiendo de 92 a 104 p. de daño de las Sombras. Si el objetivo muere en los 5 s posteriores a Quemadura de las Sombras y otorga experiencia o honor, el lanzador obtiene un fragmento de alma.",
  },
  [105886] = {
    "Otorga a tus hechizos de Destrucción un 2% de probabilidad de atontar al objetivo durante 5 s.",
    "Otorga a tus hechizos de Destrucción un 4% de probabilidad de atontar al objetivo durante 5 s.",
    "Otorga a tus hechizos de Destrucción un 6% de probabilidad de atontar al objetivo durante 5 s.",
    "Otorga a tus hechizos de Destrucción un 8% de probabilidad de atontar al objetivo durante 5 s.",
    "Otorga a tus hechizos de Destrucción un 10% de probabilidad de atontar al objetivo durante 5 s.",
  },
  [105887] = {
    "Reduce el coste de maná de tus hechizos de Destrucción en un 1%.",
    "Reduce el coste de maná de tus hechizos de Destrucción en un 2%.",
    "Reduce el coste de maná de tus hechizos de Destrucción en un 3%.",
    "Reduce el coste de maná de tus hechizos de Destrucción en un 4%.",
    "Reduce el coste de maná de tus hechizos de Destrucción en un 5%.",
  },
  [105888] = {
    "Reduce el tiempo de lanzamiento de tus hechizos Descarga de las Sombras e Inmolar en 0,1 s y el de tu hechizo Fuego de alma en 0,4 s.",
    "Reduce el tiempo de lanzamiento de tus hechizos Descarga de las Sombras e Inmolar en 0,2 s y el de tu hechizo Fuego de alma en 0,8 s.",
    "Reduce el tiempo de lanzamiento de tus hechizos Descarga de las Sombras e Inmolar en 0,3 s y el de tu hechizo Fuego de alma en 1,2 s.",
    "Reduce el tiempo de lanzamiento de tus hechizos Descarga de las Sombras e Inmolar en 0,4 s y el de tu hechizo Fuego de alma en 1,6 s.",
    "Reduce el tiempo de lanzamiento de tus hechizos Descarga de las Sombras e Inmolar en 0,5 s y el de tu hechizo Fuego de alma en 2 s.",
  },
  [105889] = {
    "Tus golpes críticos de Descarga de las Sombras aumentan en un 4% el daño de las Sombras infligido al objetivo hasta que se apliquen 4 fuentes de daño no periódico. El efecto dura un máximo de 12 s.",
    "Tus golpes críticos de Descarga de las Sombras aumentan en un 8% el daño de las Sombras infligido al objetivo hasta que se apliquen 4 fuentes de daño no periódico. El efecto dura un máximo de 12 s.",
    "Tus golpes críticos de Descarga de las Sombras aumentan en un 12% el daño de las Sombras infligido al objetivo hasta que se apliquen 4 fuentes de daño no periódico. El efecto dura un máximo de 12 s.",
    "Tus golpes críticos de Descarga de las Sombras aumentan en un 16% el daño de las Sombras infligido al objetivo hasta que se apliquen 4 fuentes de daño no periódico. El efecto dura un máximo de 12 s.",
    "Tus golpes críticos de Descarga de las Sombras aumentan en un 20% el daño de las Sombras infligido al objetivo hasta que se apliquen 4 fuentes de daño no periódico. El efecto dura un máximo de 12 s.",
  },
  [105891] = {
    "Otorga un efecto tanto al brujo como al demonio invocado mientras ese demonio esté activo.\nDiablillo: reduce la amenaza generada en un 4%.\nIncursor del Vacío: reduce el daño físico recibido en un 2%.\nSuculento/Íncubo: aumenta todo el daño causado en un 2%.\nCazador vil: aumenta todas las resistencias en 2 por nivel.",
    "Otorga un efecto tanto al brujo como al demonio invocado mientras ese demonio esté activo.\nDiablillo: reduce la amenaza generada en un 8%.\nIncursor del Vacío: reduce el daño físico recibido en un 4%.\nSuculento/Íncubo: aumenta todo el daño causado en un 4%.\nCazador vil: aumenta todas las resistencias en 4 por nivel.",
    "Otorga un efecto tanto al brujo como al demonio invocado mientras ese demonio esté activo.\nDiablillo: reduce la amenaza generada en un 12%.\nIncursor del Vacío: reduce el daño físico recibido en un 6%.\nSuculento/Íncubo: aumenta todo el daño causado en un 6%.\nCazador vil: aumenta todas las resistencias en 6 por nivel.",
    "Otorga un efecto tanto al brujo como al demonio invocado mientras ese demonio esté activo.\nDiablillo: reduce la amenaza generada en un 16%.\nIncursor del Vacío: reduce el daño físico recibido en un 8%.\nSuculento/Íncubo: aumenta todo el daño causado en un 8%.\nCazador vil: aumenta todas las resistencias en 8 por nivel.",
    "Otorga un efecto tanto al brujo como al demonio invocado mientras ese demonio esté activo.\nDiablillo: reduce la amenaza generada en un 20%.\nIncursor del Vacío: reduce el daño físico recibido en un 10%.\nSuculento/Íncubo: aumenta todo el daño causado en un 10%.\nCazador vil: aumenta todas las resistencias en 1 por nivel.",
  },
  [105892] = {
    "Mientras está activo, el 30% de todo el daño que recibe el lanzador lo recibe en su lugar tu demonio (Diablillo, Incursor del Vacío, Súcubo, Íncubo o Manáfago). Además, tanto el demonio como su amo infligirán un 3% más de daño. Dura mientras el demonio esté activo.",
  },
  [105900] = {
    "Al activarse, sacrifica a tu demonio invocado para otorgarte un efecto que dura 30 min. El efecto se cancela si se invoca a cualquier demonio.\nDiablillo: aumenta tu daño de Fuego en un 15%.\nIncursor del Vacío: restaura el 3% de la salud total cada 4 s.\nSúcubo/Íncubo: aumenta tu daño de las Sombras en un 15%.\nCazador vil: restaura el 2% del maná total cada 4 s.",
  },
  [105903] = {
    "Aumenta el maná máximo de tu Diablillo, Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 3%.",
    "Aumenta el maná máximo de tu Diablillo, Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 6%.",
    "Aumenta el maná máximo de tu Diablillo, Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 9%.",
    "Aumenta el maná máximo de tu Diablillo, Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 12%.",
    "Aumenta el maná máximo de tu Diablillo, Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 15%.",
  },
  [105904] = {
    "Aumenta la efectividad de los hechizos Tormento, Consumir las Sombras, Sacrificio y Sufrimiento de tu Incursor del Vacío en un 10%.",
    "Aumenta la efectividad de los hechizos Tormento, Consumir las Sombras, Sacrificio y Sufrimiento de tu Incursor del Vacío en un 20%.",
    "Aumenta la efectividad de los hechizos Tormento, Consumir las Sombras, Sacrificio y Sufrimiento de tu Incursor del Vacío en un 30%.",
  },
  [105905] = {
    "Aumenta la cantidad de salud transferida por tu hechizo Transfusión de vida en un 10%.",
    "Aumenta la cantidad de salud transferida por tu hechizo Transfusión de vida en un 20%.",
  },
  [105906] = {
    "Aumenta el daño causado por los ataques cuerpo a cuerpo de tu Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 4%.",
    "Aumenta el daño causado por los ataques cuerpo a cuerpo de tu Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 8%.",
    "Aumenta el daño causado por los ataques cuerpo a cuerpo de tu Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 12%.",
    "Aumenta el daño causado por los ataques cuerpo a cuerpo de tu Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 16%.",
    "Aumenta el daño causado por los ataques cuerpo a cuerpo de tu Incursor del Vacío, Súcubo, Íncubo y Manáfago en un 20%.",
  },
  [105907] = {
    "Aumenta tu Aguante total en un 3%, pero reduce tu Espíritu total en un 1%.",
    "Aumenta tu Aguante total en un 6%, pero reduce tu Espíritu total en un 2%.",
    "Aumenta tu Aguante total en un 9%, pero reduce tu Espíritu total en un 3%.",
    "Aumenta tu Aguante total en un 12%, pero reduce tu Espíritu total en un 4%.",
    "Aumenta tu Aguante total en un 15%, pero reduce tu Espíritu total en un 5%.",
  },
  [105908] = {
    "Aumenta el efecto de los hechizos Descarga de fuego, Escudo de fuego y Pacto de sangre de tu Diablillo en un 10%.",
    "Aumenta el efecto de los hechizos Descarga de fuego, Escudo de fuego y Pacto de sangre de tu Diablillo en un 20%.",
    "Aumenta el efecto de los hechizos Descarga de fuego, Escudo de fuego y Pacto de sangre de tu Diablillo en un 30%.",
  },
  [105910] = {
    "Aumenta el daño infligido o la vida drenada por tus hechizos de las Sombras en un 2%.",
    "Aumenta el daño infligido o la vida drenada por tus hechizos de las Sombras en un 4%.",
    "Aumenta el daño infligido o la vida drenada por tus hechizos de las Sombras en un 6%.",
    "Aumenta el daño infligido o la vida drenada por tus hechizos de las Sombras en un 8%.",
    "Aumenta el daño infligido o la vida drenada por tus hechizos de las Sombras en un 10%.",
  },
  [105911] = {
    "Aumenta la cantidad drenada por tu hechizo Drenar vida en un 2%.",
    "Aumenta la cantidad drenada por tu hechizo Drenar vida en un 4%.",
    "Aumenta la cantidad drenada por tu hechizo Drenar vida en un 6%.",
    "Aumenta la cantidad drenada por tu hechizo Drenar vida en un 8%.",
    "Aumenta la cantidad drenada por tu hechizo Drenar vida en un 10%.",
  },
  [105912] = {
    "Transfiere 15 p. de salud del objetivo al lanzador cada 3 s. Dura 30 s.",
  },
  [105913] = {
    "Reduce la velocidad de movimiento del objetivo en un 10% durante 12 s. Solo puede haber una Maldición por brujo activa en un mismo objetivo.",
  },
  [105914] = {
    "Otorga a tus hechizos Corrupción y Drenar vida un 2% de probabilidad de hacerte entrar en un estado de Trance de las Sombras tras dañar al oponente. El estado de Trance de las Sombras reduce el tiempo de lanzamiento de tu siguiente hechizo Descarga de las Sombras en un 100%.",
    "Otorga a tus hechizos Corrupción y Drenar vida un 4% de probabilidad de hacerte entrar en un estado de Trance de las Sombras tras dañar al oponente. El estado de Trance de las Sombras reduce el tiempo de lanzamiento de tu siguiente hechizo Descarga de las Sombras en un 100%.",
  },
  [105916] = {
    "Aumenta el efecto de tu siguiente Maldición de debilidad o Maldición de agonía en un 50%, o de tu siguiente Maldición de agotamiento en un 20%. Dura 30 s.",
  },
  [105918] = {
    "Te otorga un 14% de probabilidad de evitar la interrupción causada por daño mientras canalizas el hechizo Drenar vida, Drenar maná o Drenar alma.",
    "Te otorga un 28% de probabilidad de evitar la interrupción causada por daño mientras canalizas el hechizo Drenar vida, Drenar maná o Drenar alma.",
    "Te otorga un 42% de probabilidad de evitar la interrupción causada por daño mientras canalizas el hechizo Drenar vida, Drenar maná o Drenar alma.",
    "Te otorga un 56% de probabilidad de evitar la interrupción causada por daño mientras canalizas el hechizo Drenar vida, Drenar maná o Drenar alma.",
    "Te otorga un 70% de probabilidad de evitar la interrupción causada por daño mientras canalizas el hechizo Drenar vida, Drenar maná o Drenar alma.",
  },
  [105919] = {
    "Aumenta el daño causado por tu Maldición de agonía en un 2%.",
    "Aumenta el daño causado por tu Maldición de agonía en un 4%.",
    "Aumenta el daño causado por tu Maldición de agonía en un 6%.",
  },
  [105924] = {
    "Reduce el tiempo de lanzamiento de tu hechizo Corrupción en 0,4 s.",
    "Reduce el tiempo de lanzamiento de tu hechizo Corrupción en 0,8 s.",
    "Reduce el tiempo de lanzamiento de tu hechizo Corrupción en 1,2 s.",
    "Reduce el tiempo de lanzamiento de tu hechizo Corrupción en 1,6 s.",
    "Reduce el tiempo de lanzamiento de tu hechizo Corrupción en 2 s.",
  },
  [105925] = {
    "Reduce la probabilidad de que los enemigos resistan tus hechizos de Aflicción en un 2%.",
    "Reduce la probabilidad de que los enemigos resistan tus hechizos de Aflicción en un 4%.",
    "Reduce la probabilidad de que los enemigos resistan tus hechizos de Aflicción en un 6%.",
    "Reduce la probabilidad de que los enemigos resistan tus hechizos de Aflicción en un 8%.",
    "Reduce la probabilidad de que los enemigos resistan tus hechizos de Aflicción en un 10%.",
  },
  [105927] = {
    "Al activarse, aumenta tu daño físico en un 20% y te vuelve inmune a los efectos de Miedo, pero reduce tu armadura y todas tus resistencias en un 20%. Dura 30 s.",
  },
  [105928] = {
    "Aumenta tu velocidad de ataque en un 10% durante tus 3 siguientes golpes tras asestar un golpe crítico cuerpo a cuerpo.",
    "Aumenta tu velocidad de ataque en un 15% durante tus 3 siguientes golpes tras asestar un golpe crítico cuerpo a cuerpo.",
    "Aumenta tu velocidad de ataque en un 20% durante tus 3 siguientes golpes tras asestar un golpe crítico cuerpo a cuerpo.",
    "Aumenta tu velocidad de ataque en un 25% durante tus 3 siguientes golpes tras asestar un golpe crítico cuerpo a cuerpo.",
    "Aumenta tu velocidad de ataque en un 30% durante tus 3 siguientes golpes tras asestar un golpe crítico cuerpo a cuerpo.",
  },
  [105930] = {
    "Ataca al instante al objetivo, causando un daño equivalente al 45% de tu poder de ataque. Además, tus 5 siguientes ataques cuerpo a cuerpo exitosos restaurarán 10 p. de salud. Este efecto dura 8 s.",
  },
  [105931] = {
    "Te otorga una bonificación del 5% al daño cuerpo a cuerpo durante 12 s, hasta un máximo de 12 golpes, tras recibir un golpe crítico.",
    "Te otorga una bonificación del 10% al daño cuerpo a cuerpo durante 12 s, hasta un máximo de 12 golpes, tras recibir un golpe crítico.",
    "Te otorga una bonificación del 15% al daño cuerpo a cuerpo durante 12 s, hasta un máximo de 12 golpes, tras recibir un golpe crítico.",
    "Te otorga una bonificación del 20% al daño cuerpo a cuerpo durante 12 s, hasta un máximo de 12 golpes, tras recibir un golpe crítico.",
    "Te otorga una bonificación del 25% al daño cuerpo a cuerpo durante 12 s, hasta un máximo de 12 golpes, tras recibir un golpe crítico.",
  },
  [105932] = {
    "Reduce el coste de Furia de tu habilidad Ejecutar en 2.",
    "Reduce el coste de Furia de tu habilidad Ejecutar en 5.",
  },
  [105933] = {
    "Aumenta el daño infligido por tu arma de la mano izquierda en un 5%.",
    "Aumenta el daño infligido por tu arma de la mano izquierda en un 10%.",
    "Aumenta el daño infligido por tu arma de la mano izquierda en un 15%.",
    "Aumenta el daño infligido por tu arma de la mano izquierda en un 20%.",
    "Aumenta el daño infligido por tu arma de la mano izquierda en un 25%.",
  },
  [105934] = {
    "Regenera el 1% de tu salud total durante 6 s tras recibir un golpe crítico.",
    "Regenera el 2% de tu salud total durante 6 s tras recibir un golpe crítico.",
    "Regenera el 3% de tu salud total durante 6 s tras recibir un golpe crítico.",
  },
  [105935] = {
    "Desequilibra a todos los enemigos cercanos al guerrero, reduciendo su velocidad de movimiento en un 50% durante 6 s.",
  },
  [105936] = {
    "Aumenta el daño adicional infligido por tu habilidad Hendedura en un 40%.",
    "Aumenta el daño adicional infligido por tu habilidad Hendedura en un 80%.",
    "Aumenta el daño adicional infligido por tu habilidad Hendedura en un 120%.",
  },
  [105937] = {
    "Te otorga un 8% de probabilidad de generar un punto de Furia adicional cuando infliges daño cuerpo a cuerpo con un arma.",
    "Te otorga un 16% de probabilidad de generar un punto de Furia adicional cuando infliges daño cuerpo a cuerpo con un arma.",
    "Te otorga un 24% de probabilidad de generar un punto de Furia adicional cuando infliges daño cuerpo a cuerpo con un arma.",
    "Te otorga un 32% de probabilidad de generar un punto de Furia adicional cuando infliges daño cuerpo a cuerpo con un arma.",
    "Te otorga un 40% de probabilidad de generar un punto de Furia adicional cuando infliges daño cuerpo a cuerpo con un arma.",
  },
  [105938] = {
    "Aumenta el área de efecto y la duración de tus habilidades Grito de batalla y Grito desmoralizador en un 10%.",
    "Aumenta el área de efecto y la duración de tus habilidades Grito de batalla y Grito desmoralizador en un 20%.",
    "Aumenta el área de efecto y la duración de tus habilidades Grito de batalla y Grito desmoralizador en un 30%.",
    "Aumenta el área de efecto y la duración de tus habilidades Grito de batalla y Grito desmoralizador en un 40%.",
    "Aumenta el área de efecto y la duración de tus habilidades Grito de batalla y Grito desmoralizador en un 50%.",
  },
  [105939] = {
    "Aumenta tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo en un 1%.",
    "Aumenta tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo en un 2%.",
    "Aumenta tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo en un 3%.",
    "Aumenta tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo en un 4%.",
    "Aumenta tu probabilidad de asestar un golpe crítico con armas cuerpo a cuerpo en un 5%.",
  },
  [105947] = {
    "Aumenta la bonificación de daño de golpe crítico de tus habilidades en Actitud de batalla, Actitud defensiva y Actitud rabiosa en un 10%.",
    "Aumenta la bonificación de daño de golpe crítico de tus habilidades en Actitud de batalla, Actitud defensiva y Actitud rabiosa en un 20%.",
  },
  [105948] = {
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de dos manos en un 1%.",
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de dos manos en un 2%.",
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de dos manos en un 3%.",
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de dos manos en un 4%.",
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de dos manos en un 5%.",
  },
  [105950] = {
    "Tus golpes críticos hacen que el oponente sangre, infligiendo el 20% del daño medio de tu arma cuerpo a cuerpo durante 12 s.",
    "Tus golpes críticos hacen que el oponente sangre, infligiendo el 40% del daño medio de tu arma cuerpo a cuerpo durante 12 s.",
    "Tus golpes críticos hacen que el oponente sangre, infligiendo el 60% del daño medio de tu arma cuerpo a cuerpo durante 12 s.",
  },
  [105951] = {
    "Aumenta en un 30% el tiempo que tarda tu Furia en disiparse fuera de combate.",
  },
  [105954] = {
    "Conservas hasta 5 de tus puntos de Furia cuando cambias de actitud.",
    "Conservas hasta 10 de tus puntos de Furia cuando cambias de actitud.",
    "Conservas hasta 15 de tus puntos de Furia cuando cambias de actitud.",
    "Conservas hasta 20 de tus puntos de Furia cuando cambias de actitud.",
    "Conservas hasta 25 de tus puntos de Furia cuando cambias de actitud.",
  },
  [105955] = {
    "Aumenta en 3 la cantidad de Furia generada por tu habilidad Carga.",
    "Aumenta en 6 la cantidad de Furia generada por tu habilidad Carga.",
  },
  [105956] = {
    "Aumenta el daño de sangrado infligido por tu habilidad Romper en un 15%.",
    "Aumenta el daño de sangrado infligido por tu habilidad Romper en un 25%.",
    "Aumenta el daño de sangrado infligido por tu habilidad Romper en un 35%.",
  },
  [105958] = {
    "Reduce el coste de Furia de tu habilidad Golpe heroico en 1.",
    "Reduce el coste de Furia de tu habilidad Golpe heroico en 2.",
    "Reduce el coste de Furia de tu habilidad Golpe heroico en 3.",
  },
  [105959] = {
    "Embiste al objetivo con tu escudo, infligiendo de 225 a 235 p. de daño, modificado por tu valor de bloqueo de escudo, y tiene un 50% de probabilidad de disipar 1 efecto mágico del objetivo. También genera una gran cantidad de amenaza.",
  },
  [105962] = {
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de una mano en un 2%.",
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de una mano en un 4%.",
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de una mano en un 6%.",
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de una mano en un 8%.",
    "Aumenta el daño que infliges con armas cuerpo a cuerpo de una mano en un 10%.",
  },
  [105963] = {
    "Otorga a tu habilidad Ataque con escudo un 50% de probabilidad de silenciar al objetivo durante 3 s.",
    "Otorga a tu habilidad Ataque con escudo un 100% de probabilidad de silenciar al objetivo durante 3 s.",
  },
  [105964] = {
    "Aumenta la duración de tu habilidad Muro de escudo en 3 s.",
    "Aumenta la duración de tu habilidad Muro de escudo en 5 s.",
  },
  [105965] = {
    "Aturde al oponente durante 5 s.",
  },
  [105967] = {
    "Aumenta la duración de tu habilidad Desarme en 1 s.",
    "Aumenta la duración de tu habilidad Desarme en 2 s.",
    "Aumenta la duración de tu habilidad Desarme en 3 s.",
  },
  [105968] = {
    "Reduce el coste de Furia de tu habilidad Machacar armadura en 1.",
    "Reduce el coste de Furia de tu habilidad Machacar armadura en 2.",
    "Reduce el coste de Furia de tu habilidad Machacar armadura en 3.",
  },
  [105969] = {
    "Otorga a tu habilidad Venganza un 15% de probabilidad de aturdir al objetivo durante 3 s.",
    "Otorga a tu habilidad Venganza un 30% de probabilidad de aturdir al objetivo durante 3 s.",
    "Otorga a tu habilidad Venganza un 45% de probabilidad de aturdir al objetivo durante 3 s.",
  },
  [105970] = {
    "Al activarse, esta habilidad te otorga temporalmente el 30% de tu salud máxima durante 20 s. Cuando el efecto termina, la salud se pierde.",
  },
  [105972] = {
    "Reduce el coste de Furia de tu habilidad Atronar en 1.",
    "Reduce el coste de Furia de tu habilidad Atronar en 2.",
    "Reduce el coste de Furia de tu habilidad Atronar en 4.",
  },
  [105973] = {
    "Aumenta el valor de armadura de los objetos en un 2%.",
    "Aumenta el valor de armadura de los objetos en un 4%.",
    "Aumenta el valor de armadura de los objetos en un 6%.",
    "Aumenta el valor de armadura de los objetos en un 8%.",
    "Aumenta el valor de armadura de los objetos en un 10%.",
  },
  [105974] = {
    "Aumenta en 2 la Furia instantánea generada por tu habilidad Ira de sangre.",
    "Aumenta en 5 la Furia instantánea generada por tu habilidad Ira de sangre.",
  },
  [105975] = {
    "Aumenta tu habilidad de Defensa en 2.",
    "Aumenta tu habilidad de Defensa en 4.",
    "Aumenta tu habilidad de Defensa en 6.",
    "Aumenta tu habilidad de Defensa en 8.",
    "Aumenta tu habilidad de Defensa en 10.",
  },
  [105976] = {
    "Aumenta tu probabilidad de bloquear ataques con un escudo en un 1% y te otorga un 20% de probabilidad de generar 1 p. de Furia cuando se produce un bloqueo.",
    "Aumenta tu probabilidad de bloquear ataques con un escudo en un 2% y te otorga un 40% de probabilidad de generar 1 p. de Furia cuando se produce un bloqueo.",
    "Aumenta tu probabilidad de bloquear ataques con un escudo en un 3% y te otorga un 60% de probabilidad de generar 1 p. de Furia cuando se produce un bloqueo.",
    "Aumenta tu probabilidad de bloquear ataques con un escudo en un 4% y te otorga un 80% de probabilidad de generar 1 p. de Furia cuando se produce un bloqueo.",
    "Aumenta tu probabilidad de bloquear ataques con un escudo en un 5% y te otorga un 100% de probabilidad de generar 1 p. de Furia cuando se produce un bloqueo.",
  },
  [105978] = {
    "Tu habilidad Ira rabiosa genera 5 p. de Furia al usarse.",
    "Tu habilidad Ira rabiosa genera 10 p. de Furia al usarse.",
  },
  [110844] = {
    "Aumenta en un 15% la probabilidad de que tu Agarre de la naturaleza enrede a un enemigo.",
    "Aumenta en un 30% la probabilidad de que tu Agarre de la naturaleza enrede a un enemigo.",
    "Aumenta en un 45% la probabilidad de que tu Agarre de la naturaleza enrede a un enemigo.",
    "Aumenta en un 65% la probabilidad de que tu Agarre de la naturaleza enrede a un enemigo.",
  },
  [110851] = {
    "Reduce en un 2% la probabilidad de que tu objetivo resista tus hechizos de las Sombras.",
    "Reduce en un 4% la probabilidad de que tu objetivo resista tus hechizos de las Sombras.",
    "Reduce en un 6% la probabilidad de que tu objetivo resista tus hechizos de las Sombras.",
    "Reduce en un 8% la probabilidad de que tu objetivo resista tus hechizos de las Sombras.",
    "Reduce en un 10% la probabilidad de que tu objetivo resista tus hechizos de las Sombras.",
  },
  [110856] = {
    "Aumenta la amenaza generada por tus ataques en Actitud defensiva en un 3%.",
    "Aumenta la amenaza generada por tus ataques en Actitud defensiva en un 6%.",
    "Aumenta la amenaza generada por tus ataques en Actitud defensiva en un 9%.",
    "Aumenta la amenaza generada por tus ataques en Actitud defensiva en un 12%.",
    "Aumenta la amenaza generada por tus ataques en Actitud defensiva en un 15%.",
  },
  [110857] = {
    "Aumenta en un 3% adicional tu probabilidad de resistir efectos de aturdimiento y de encantamiento.",
    "Aumenta en un 6% adicional tu probabilidad de resistir efectos de aturdimiento y de encantamiento.",
    "Aumenta en un 9% adicional tu probabilidad de resistir efectos de aturdimiento y de encantamiento.",
    "Aumenta en un 12% adicional tu probabilidad de resistir efectos de aturdimiento y de encantamiento.",
    "Aumenta en un 15% adicional tu probabilidad de resistir efectos de aturdimiento y de encantamiento.",
  },
  [110858] = {
    "Reduce el tiempo de lanzamiento de tu habilidad Zurrar en 0,1 s.",
    "Reduce el tiempo de lanzamiento de tu habilidad Zurrar en 0,2 s.",
    "Reduce el tiempo de lanzamiento de tu habilidad Zurrar en 0,3 s.",
    "Reduce el tiempo de lanzamiento de tu habilidad Zurrar en 0,4 s.",
    "Reduce el tiempo de lanzamiento de tu habilidad Zurrar en 0,5 s.",
  },
  [110859] = {
    "Aumenta tu Agilidad en un 3%.",
    "Aumenta tu Agilidad en un 6%.",
    "Aumenta tu Agilidad en un 9%.",
    "Aumenta tu Agilidad en un 12%.",
    "Aumenta tu Agilidad en un 15%.",
  },
  [110874] = {
    "Aumenta el daño absorbido por tu escudo en un 10%.",
    "Aumenta el daño absorbido por tu escudo en un 20%.",
    "Aumenta el daño absorbido por tu escudo en un 30%.",
  },
}
do
  local C = AF.Content.esES
  C.classic = C.classic or {}
  for k, v in pairs(C.classic_part or {}) do C.classic[k] = v end
  C.classic_part = nil
end

-- noms propres identiques dans toutes les langues, sauf le titre de Captain Truman (traduction faite main, à confirmer en jeu)
AF.Content.esES.npc["Captain Truman"] = "Capitán Truman"

AF.Content.esES.npc_boss = {
  ["Bazzalan"] = "Bazzalan",
  ["Faldrim Courbenclume"] = "Faldrim Yunquemar",
  ["Magmatus"] = "Magmatus",
  ["Durgen Mornemartel"] = "Durgen Dirgemartillo",
  ["Dame Anacondra"] = "Dama Anacondra",
  ["Seigneur Cobrahn"] = "Señor Cobrahn",
  ["Kresh"] = "Kresh",
  ["Seigneur Pythas"] = "Señor Pythas",
  ["Skum"] = "Skum",
  ["Seigneur Serpentis"] = "Señor Serpentis",
  ["Rath'mael"] = "Rath'mael",
  ["Bjork"] = "Bjork",
  ["Rhahk'Zor"] = "Rhahk'Zor",
  ["Sneed"] = "Sneed",
  ["Gilnid"] = "Gilnid",
  ["Capitaine Vertepeau"] = "Capitán Piel Verde",
  ["M. Smite"] = "Sr. Smite",
  ["Macaron"] = "Cocinitas",
  ["Edwin VanCleef"] = "Edwin VanCleef",
  ["Rethilgore"] = "Rethilgore",
  ["Baron d'Argelaine"] = "Barón Silverlaine",
  ["Kam Deepfury"] = "Kam Furiaprofunda",
  ["Hamhock"] = "Hamhock",
  ["Bazil Thredd"] = "Bazil Thredd",
  ["Dextren Ward"] = "Dextren Ward",
  ["Ghamoo-ra"] = "Ghamoo-ra",
  ["Dame Sarevess"] = "Dama Sarevess",
  ["Gelihast"] = "Gelihast",
  ["Lorgus Jett"] = "Lorgus Jett",
  ["Baron Aquanis"] = "Barón Aquanis",
  ["Vieux Serra'kis"] = "Viejo Serra'kis",
  ["Aku'mai"] = "Aku'mai",
  ["Échine-de-sel"] = "Espinasal",
  ["Dent-d'ombre"] = "Dientesombrío",
  ["Horreur des hautes-terres"] = "Horror de las tierras altas",
  ["Gardien des reliques"] = "Guardián de reliquias",
  ["Herod"] = "Herod",
  ["Anomalie arcanique"] = "Anomalía arcana",
  ["Ancien gangrené"] = "Anciano vil",
  ["Dévoreur de mana"] = "Devorador de maná",
  ["Élémentaire de mana"] = "Elemental de maná",
  ["Sentinelle instable"] = "Centinela inestable",
  ["Ombre de l'archimage"] = "Sombra del archimago",
  ["Lyn l'Ignorée"] = "Lyn la Ignorada",
  ["Atrexis le Chevalier des tombes"] = "Atrexis el Caballero de la tumba",
  ["Spectre de mana"] = "Espectro de maná",
  ["Grubbis"] = "Grubbis",
  ["Roogug"] = "Roogug",
  ["Charlga Trancheflanc"] = "Charlga Filoflanco",
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
  ["Seigneur Roccor"] = "Señor Roccor",
  ["Bael'Gar"] = "Bael'Gar",
  ["Seigneur Incendius"] = "Señor Incendius",
  ["Verek"] = "Verek",
  ["Fineous Sombrevire"] = "Fineous Sombravira",
  ["Phalange"] = "Falange",
  ["Lanfiche Brouillecircuit"] = "Plugger Spazzring",
  ["Ribbly Fermevanne"] = "Ribbly Screwspigot",
  ["Magmus"] = "Magmus",
  ["Généralissime Omokk"] = "Alto señor Omokk",
  ["Chasseresse des ombres Vosh'gajin"] = "Cazadora de las sombras Vosh'gajin",
  ["Maître de guerre Voone"] = "Maestro de guerra Voone",
  ["Matriarche Couveuse"] = "Matriarca Incubadora",
  ["Urok Hurleruine"] = "Urok Aullaruinas",
  ["Intendant Zigris"] = "Intendente Zigris",
  ["Halycon"] = "Halycon",
  ["Gizrul l'esclavagiste"] = "Gizrul el Esclavista",
  ["Seigneur Wyrmthalak"] = "Señor Wyrmthalak",
  ["Pyrogarde Prophète ardent"] = "Piroguardia Profeta ardiente",
  ["Solakar Voluteflamme"] = "Solakar Corona de llamas",
  ["Goraluk Brisenclume"] = "Goraluk Rompeyunques",
  ["Gyth"] = "Gyth",
  ["Chef de guerre Rend Main-noire"] = "Jefe de guerra Rend Mano Negra",
  ["La Bête"] = "La Bestia",
  ["Général Drakkisath"] = "Général Drakkisath",
  ["Pusillin"] = "Pusillin",
  ["Lethtendris"] = "Lethtendris",
  ["Magistère Kalendris"] = "Magistère Kalendris",
  ["Immol'thar"] = "Immol'thar",
  ["Prince Tortheldrin"] = "Príncipe Tortheldrin",
  ["Jandice Barov"] = "Jandice Barov",
  ["Marduk Noirétang"] = "Marduk Pozanegra",
  ["Vectus"] = "Vectus",
  ["Instructeur Malicia"] = "Instructora Malicia",
  ["Docteur Theolen Krastinov"] = "Doctor Theolen Krastinov",
  ["Seigneur Alexei Barov"] = "Señor Alexei Barov",
  ["Dame Illucia Barov"] = "Dama Illucia Barov",
  ["Balnazzar"] = "Balnazzar",
  ["Nerub'enkan"] = "Nerub'enkan",
  ["Baron Vaillefendre"] = "Barón Rivendare",
  ["Onyxia"] = "Onyxia",
  ["Lucifron"] = "Lucifron",
  ["Magmadar"] = "Magmadar",
  ["Gehennas"] = "Gehennas",
  ["Garr"] = "Garr",
  ["Baron Geddon"] = "Barón Géddon",
  ["Shazzrah"] = "Shazzrah",
  ["Ragnaros"] = "Ragnaros",
  ["Tranchetripe l'Indompté"] = "Sangrevaja el Indomable",
  ["Vaelastrasz le Corrompu"] = "Vaelastrasz el Corrupto",
  ["Seigneur des couvées Lashlayer"] = "Señor de linaje Capazote",
  ["Gueule-de-feu"] = "Faucefogo",
  ["Rochébène"] = "Ebonroc",
  ["Flamegor"] = "Flamagor",
  ["Chromaggus"] = "Chromaggus",
  ["Nefarian"] = "Nefarian",
  ["Grande prêtresse Jeklik"] = "Suma sacerdotisa Jeklik",
  ["Grand prêtre Venoxis"] = "Sumo sacerdote Venoxis",
  ["Grande prêtresse Mar'li"] = "Suma sacerdotisa Mar'li",
  ["Seigneur sanglant Mandokir"] = "Señor sangriento Mandokir",
  ["Gri'lek, Hazza'rah, Renataki ou Wushoolay"] = "Gri'lek, Hazza'rah, Renataki o Wushoolay",
  ["Gahz'ranka"] = "Gahz'ranka",
  ["Grand prêtre Thekal"] = "Sumo sacerdote Thekal",
  ["Grande prêtresse Arlokk"] = "Suma sacerdotisa Arlokk",
  ["Jin'do le Maléficieur"] = "Jin'do el Aojador",
  ["Hakkar"] = "Hakkar",
  ["Kurinnaxx"] = "Kurinnaxx",
  ["Général Rajaxx"] = "General Rajaxx",
  ["Moam"] = "Moam",
  ["Buru Grandgosier"] = "Buru el Manducador",
  ["Ayamiss le Chasseur"] = "Ayamiss el Cazador",
  ["Ossirian l'Intouché"] = "Osirio el Sinmarcas",
  ["Le Prophète Skeram"] = "El Profeta Skeram",
  ["Seigneur Kri, Princesse Yauj et Vem"] = "Señor Kri, Princesa Yauj y Vem",
  ["Garde de guerre Sartura"] = "Guardia de guerra Sartura",
  ["Fankriss l'Inflexible"] = "Fankriss el Inflexible",
  ["Viscidus"] = "Viscidus",
  ["Princesse Huhuran"] = "Princesa Huhuran",
  ["Empereur Vek'lor et Empereur Vek'nilash"] = "Emperador Vek'lor y Emperador Vek'nilash",
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
  local C = AF.Content.esES
  for k, v in pairs(C.npc_boss or {}) do if C.npc[k] == nil then C.npc[k] = v end end
  C.npc_boss = nil
  C.npc["Galamav the Marksman"] = C.npc["Galamav the Marksman"] or "Galamav el Certero"
  C.npc["Myranda the Hag"] = C.npc["Myranda the Hag"] or "Myranda la Bruja"
  C.npc["Leonid Barthalomew the Revered"] = C.npc["Leonid Barthalomew the Revered"] or "Leonid Barthalomew el Venerado"
end

-- quêtes sans identifiant dans les données (Molten Core), traduction faite main
AF.Content.esES.npc["L'Alliance a besoin de pierres du Magma calcinées !"] = "¡La Alianza necesita piedras de núcleo chamuscadas!"
AF.Content.esES.npc["La Horde a besoin de pierres du Magma calcinées !"] = "¡La Horda necesita piedras de núcleo chamuscadas!"

AF.Content.esES.npc["Garde d'argent Thaelrid"] = "Guardia argenta Thaelrid"
AF.Content.esES.npc["Manuscrit de Lorgalis"] = "Manuscrito de Lorgalis"

-- Profondeurs de Rochenoire : noms officiels Wowhead (infobulles classic, esES)
do
  local C = AF.Content.esES
  C.where = C.where or {}
  C.where["Profondeurs de Rochenoire"] = "Profundidades de Roca Negra"
  C.npc["Kharan Mighthammer"] = "Kharan Martillazo"
  C.npc["Kharan Force-martel"] = "Kharan Martillazo"
  C.npc["Commandant Gor'shak"] = "Comandante Gor'shak"
  C.npc["Maréchal Windsor"] = "Alguacil Windsor"
  C.npc["Clé du Sinistre dévoreur"] = "Llave de Tragapenas"
  C.npc["Torche ombreforge"] = "Antorcha Sombratiniebla"
  C.npc["Coffre sombre"] = "Arca oscura"
  C.npc["Monument de Franclorn Forgewright"] = "Monumento a Franclorn Forjador"
  C.npc["Monument de Franclorn Le Forgebusier"] = "Monumento a Franclorn Forjador"
  C.npc["Coffre des sept"] = "Cofre de los Siete"
  C.npc["Garde d'argent Thaelrid"] = "Guardia Argenta Thaelrid"
end

-- Quêtes Forever sans texte espagnol sur Wowhead (champs entre crochets dans Data/QuestText.lua) : traduction faite main.
-- Journal.lua (Official) prend ces champs à la place des champs entre crochets.
AF.Content.esES.questText = {
  -- 7507 : le texte Wowhead garde le nom anglais de l'objet, nom espagnol de l'objet 18401 avec Foror (nom Forever).
  [7507] = { summary = "Devuelve el Compendio de matar dragones de Foror a El Athenaeum." },
  [92415] = { title = "Recuerda que te quiero", summary = "Lleva la Carta manchada de sangre a la matrona del orfanato Nightingale, en la ciudad de Ventormenta.", desc = "<Un fajo de pergaminos rasgado y manchado ha sobrevivido a duras penas en el cementerio, hollado por los no-muertos. Menciona a un niño desaparecido de la familia Heartweaver. Quizá la matrona del orfanato de la ciudad de Ventormenta sepa más.>" },
  [92745] = { title = "El estado de las minas", summary = "Mata a 4 Excavadores kobold en la Mina Jangolode y a 6 Mineros Zarpa del Río en la Cantera de la Costa de Oro.", desc = "¡Las muestras de los pozos que recogiste contienen metales tóxicos! Si no ponemos fin rápidamente a esta corrupción, pasarán décadas antes de que puedan volver a crecer cultivos en este suelo.\nLos Defias se han apoderado de las minas de los Páramos de Poniente y utilizan criaturas como mano de obra para exprimir sus recursos. Interrúmpelos matando a sus mineros en la Mina Jangolode, al norte, y en la Cantera de la Costa de Oro, al oeste." },
  [92747] = { title = "Espionaje en Arroyoluna", summary = "Reúne 8 Suministros industriales sospechosos en Arroyoluna.", desc = "Qué raro: el veneno no parece proceder de las minas que investigaste.\n\nMe han dicho que las Minas de la Muerte, bajo la ciudad de Arroyoluna, son las minas más grandes y profundas de los Páramos de Poniente, pero llevan abandonadas desde la Primera Guerra. ¿Será posible que las Minas de la Muerte vuelvan a estar activas?\n\nPor favor, viaja a Arroyoluna, <nombre>, y busca indicios de actividad minera o industrial. ¡Es la última pista que nos queda!" },
  [92748] = { title = "Consulta explosiva", summary = "Viaja al Distrito de los Enanos en Ventormenta y encuentra a un ingeniero que pueda ayudar.", desc = "Los suministros que encontraste apuntan a una enorme operación industrial en algún lugar de Las Minas de la Muerte. No cabe duda de que es el origen de las toxinas que asolan las tierras de cultivo de Los Páramos de Poniente. Tenemos que detenerla, y rápido.\n\nLo que haya allí abajo será difícil de destruir. Ve al Distrito de los Enanos de Ventormenta y encuentra a un ingeniero que pueda proporcionarnos algunos explosivos." },
  [92749] = { title = "Un plan explosivo", summary = "Consigue 10 Dinamitas bastas mediante fabricación, comercio o la casa de subastas, y vuelve con Sprite Jumpsprocket en el Distrito de los Enanos de Ventormenta.", desc = "¿Sabotaje industrial? ¡Ahora sí tienes mi atención!\nEmpezaremos con algo de dinamita..." },
  [92750] = { title = "Detonación a distancia", summary = "Habla con alguien de Inteligencia de Ventormenta para conseguir un detonador remoto.", desc = "Supongo que quieres una explosión \"controlada\", ¿no? No es tan divertido, pero es buena elección si quieres conservar todos tus miembros.\nMe temo que no tengo un detonador remoto. ¿Por qué no preguntas a los sigilosos de Inteligencia de Ventormenta? Ellos deberían poder encontrarnos algo." },
  [92751] = { title = "Detonación a distancia", summary = "Lleva el Kit de detonador remoto a Sprite Jumpsprocket, en el Distrito Enano de Ventormenta.", desc = "¿Necesitas que destruyan algo? ¿Tendrá algo que ver con tus actividades en Arroyoluna? No pongas esa cara de sorpresa. La IV:7 está al tanto de todo lo que ocurre en las tierras de Ventormenta.\nSi piensas provocar una explosión en las cuevas bajo los Páramos de Poniente, más te vale estar bien lejos de antemano. Toma este detonador remoto: es un prototipo reciente de nuestros propios ingenieros.\nAh, y sería mejor que no mencionaras mi participación a tu amiga elfa." },
  [92752] = { title = "Consulta explosiva", summary = "Vuelve con Alba Fairmoon, en los Páramos de Poniente.", desc = "Eso es: ¡la bomba está lista! Cuidado con ese detonador, ¿eh?" },
  [92753] = { title = "Destrucción en las Minas de la Muerte", summary = "Encuentra la forja oculta en las Minas de la Muerte y coloca cerca los explosivos extradestructivos. Después, reúnete con Alba Fairmoon en la salida de las Minas de la Muerte.", desc = "La fuente del veneno es probablemente una gran forja metalúrgica de algún tipo. Encuentra la manera de entrar en las Minas de la Muerte, localiza la forja y coloca los explosivos.\nTe esperaré en las colinas detrás de Arroyo de la Luna. Cuando regreses, podremos detonar los explosivos. Con suerte, sin la forja, la tierra podrá empezar a sanar.", objectives = { "Explosivos colocados" } },
  [92819] = { title = "Destrucción en Las Minas de la Muerte", summary = "Usa el detonador.", desc = "Casi hemos terminado. Usa el detonador y pon fin a esto.", objectives = { "Detonador usado" } },
  [95189] = { title = "Blasón de Lordaeron", summary = "Devuelve el Blasón de Lordaeron a Lady Dena Kennedy en la Ciudad de Ventormenta.", desc = "<Un blasón desgastado que muestra la marca de Lordaeron. Con tan pocas reliquias tras la caída del reino, alguien en Ventormenta estaría muy interesado en hacerse con esto.>" },
  [95195] = { title = "Insignia ensangrentada", summary = "Recoge 10 insignias ensangrentadas y llévalas al general Marcus Jonathan, en la Ciudad de Ventormenta.", desc = "<La vieja insignia de la Alianza parece haber pertenecido a un soldado de Lordaeron. Es probable que estas ruinas estén llenas de medallas similares que los familiares vivos agradecerían recuperar.>" },
  [95204] = { title = "Blasón de Lordaeron", summary = "Lleva el Blasón de Lordaeron a Oran Snakewrithe, en Entrañas.", desc = "<Un blasón desgastado que muestra la marca de Lordaeron. Con tan pocas reliquias tras la caída del reino, alguien en Entrañas estaría muy interesado en hacerse con él.>" },
  [95250] = { title = "Criaturas abominables", summary = "Consigue la Cabeza del Barón en las Ruinas de Lordaeron y llévasela al capitán Truman.", desc = "¿Qué quieres, <raza>? ¿No ves que hay una guerra que ganar?\n\nMi señor ya se ha lanzado a la refriega y me ha ordenado mantener mi puesto. Sin embargo, ha pasado bastante tiempo.\n\nDudo que sobrevivas diez minutos en combate, pero si eso mantiene ocupada tu simple mente, ¿por qué no buscas al Gran Mariscal? Es el héroe más alto y escultural que hayas visto jamás. Lo reconocerás en cuanto lo veas." },
  [96393] = { title = "Incursión en la vieja Forjaz", summary = "Entra en la Sala de los Thanes, bajo la vieja Forjaz, y consigue la Cabeza de Durgen Martillo Funesto.", desc = "Reúne a unos aliados y desciende a las cavernas bajo la vieja Forjaz. Entra en la Sala de los Thanes y avanza hasta las bóvedas inferiores.\n\nMi dialecto Hierro Negro está algo oxidado, pero logro distinguir un nombre: un tal Durgen Martillo Funesto. Es probable que sea el comandante. Toma su cabeza y entrégasela al rey Magni Barbabronce.\n\nAh, y cuando lo hagas, ¡dile que su viejo amigo Farsen le manda saludos!" },
  [96394] = { objectives = { "Aparición enfurecida x 15", "Alma atormentada x 10" } },
  [96395] = { title = "Un rencor ancestral", summary = "Haz descansar el espíritu de Faldrim Yunquemar en la Sala de los Thanes.", desc = "El... Thane... mi poderoso... Thane... él... necesita... descansar.\n\nPor favor... ayúdalo... ayúdalo... a descansar...\n\nConsumido... por... un rencor... ancestral... No... hay descanso...", objectives = { "Faldrim Yunquemar" } },
  [98423] = { title = "El Tratado de Entendimiento", summary = "Entrega el Tratado de Entendimiento a Magni Barbabronce en Forjaz.", desc = "Dentro de la cámara encuentras una tablilla que detalla los términos de un tratado de paz entre los clanes enanos Barbabronce y Martillo Salvaje. Parece datar de la época posterior a la Guerra de los Tres Martillos, y es muy probable que sea un notable fragmento de la historia enana. Sin duda, al rey de Forjaz le interesaría este artefacto." },
}

-- Noms officiels relevés dans les infobulles Wowhead (WoW Forever, esES), à la place des traductions faites main.
do
  local C = AF.Content.esES
  C.npc = C.npc or {}; C.npc["Goraluk Brisenclume"] = "Goraluk Yunquegrieta"
  C.npc = C.npc or {}; C.npc["Seigneur des couvées Lashlayer"] = "Señor de prole Capazote"
  C.npc = C.npc or {}; C.npc["Prospecteur Botte-de-fer"] = "Prospector Ferrobota"
  C.npc = C.npc or {}; C.npc["Krom Rudebras"] = "Krom Brazorrecio"
  C.npc = C.npc or {}; C.npc["Myranda the Hag"] = "Myranda la Fada"
  C.npc = C.npc or {}; C.npc["Bashana Totem-runique"] = "Bashana Runatótem"
  C.npc = C.npc or {}; C.npc["Gerrig Poigne-d'os"] = "Gerrig Agarrahueso"
  C.npc = C.npc or {}; C.npc["Seigneur Incendius"] = "Lord Incendius"
  C.npc = C.npc or {}; C.npc["Bibliothécaire Mae Blêmepoussière"] = "Bibliotecaria Mae Palipolvo"
  C.npc = C.npc or {}; C.npc["Marvon Chercherivet"] = "Marvon Buscarroblones"
  C.npc = C.npc or {}; C.npc["Treshala Ruissefriche"] = "Treshala Arroyobarbecho"
  C.npc = C.npc or {}; C.npc["Gardien Remulos"] = "Guardián Rémulos"
  C.npc = C.npc or {}; C.npc["Jarkal Fondemousse"] = "Jarkal Musgofusión"
  C.npc = C.npc or {}; C.npc["Shoni la Silencieuse"] = "Shoni el Shilenshioso"
  C.npc = C.npc or {}; C.npc["Brohann Ventrabière"] = "Brohann Barriliga"
  C.npc = C.npc or {}; C.npc["Dame Illucia Barov"] = "Lady Illucia Barov"
  C.npc = C.npc or {}; C.npc["Solakar Voluteflamme"] = "Solakar Corona de Fuego"
  C.npc = C.npc or {}; C.npc["Magistère Kalendris"] = "Magister Kalendris"
  C.npc = C.npc or {}; C.npc["Prospecteur Foudrepique"] = "Prospector Pico Tormenta"
  C.npc = C.npc or {}; C.npc["Duc Nicholas Zverenhoff"] = "Duque Nicolas Zverenhoff"
  C.npc = C.npc or {}; C.npc["Seigneur Cobrahn"] = "Lord Cobrahn"
  C.npc = C.npc or {}; C.npc["Thadius Sinissombre"] = "Thadius Sombramacabra"
  C.npc = C.npc or {}; C.npc["Le Décapeur 5200"] = "La Chispamática 5200"
  C.npc = C.npc or {}; C.npc["Gregan Gerbebière"] = "Gregan Tirabirras"
  C.npc = C.npc or {}; C.npc["Veilleur de l'aube Shaedlass"] = "Shaedlass Guardalbas"
  C.npc = C.npc or {}; C.npc["Neeru Lamefeu"] = "Neeru Hojafuego"
  C.npc = C.npc or {}; C.npc["Wilder Crispechardon"] = "Wilder Cardortiga"
  C.npc = C.npc or {}; C.npc["Nathanos le Flétrisseur"] = "Nathanos Clamorinfecto"
  C.npc = C.npc or {}; C.npc["Lothos Ouvrefaille"] = "Lothos Levantagrietas"
  C.npc = C.npc or {}; C.npc["Nécrotraqueur Vincent"] = "Mortacechador Vincent"
  C.npc = C.npc or {}; C.npc["Chasseresse des ombres Vosh'gajin"] = "Cazador de las Sombras Vosh'gajin"
  C.npc = C.npc or {}; C.npc["Grande prêtresse Arlokk"] = "Suma Sacerdotisa Arlokk"
  C.npc = C.npc or {}; C.npc["Pléthorloge Cléventail"] = "Klockmort Palmalicate"
  C.npc = C.npc or {}; C.npc["Grand prêtre Thekal"] = "Sumo Sacerdote Thekal"
  C.npc = C.npc or {}; C.npc["Falla Vent-de-sagesse"] = "Fala Ventsalvia"
  C.npc = C.npc or {}; C.npc["Ragnar Tonnebière"] = "Ragnar Cebatruenos"
  C.npc = C.npc or {}; C.npc["Prospecteur Baguefer"] = "Prospector Vetaferro"
  C.npc = C.npc or {}; C.npc["Afadra Mur-de-Dun"] = "Afadra Murocre"
  C.npc = C.npc or {}; C.npc["Malyfous Sombremartel"] = "Malyfous Martilloscuro"
  C.npc = C.npc or {}; C.npc["Ancienne des Shen'Dralar"] = "Anciano Shen'dralar"
  C.npc = C.npc or {}; C.npc["Régisseuse sanglante de Kirtonos"] = "Ayudante de sangre de Kirtonos"
  C.npc = C.npc or {}; C.npc["Seigneur Alexei Barov"] = "Lord Alexei Barov"
  C.npc = C.npc or {}; C.npc["Maître-bricoleur Suprétincelle"] = "Maestro manitas Sobrechispa"
  C.npc = C.npc or {}; C.npc["Yuka Fermevanne"] = "Yuka Llavenrosca"
  C.npc = C.npc or {}; C.npc["Mayara Luisaile"] = "Mayara Alasol"
  C.npc = C.npc or {}; C.npc["Vark Balafre-glorieuse"] = "Vark Marcaguerra"
  C.npc = C.npc or {}; C.npc["Infiltrateur du Bouclier balafré"] = "Infiltrador Escudo del Estigma"
  C.npc = C.npc or {}; C.npc["Ozzie Virevolt"] = "Oci Voltiflop"
  C.npc = C.npc or {}; C.npc["Franclorn Le Forgebusier"] = "Franclorn Forjador"
  C.npc = C.npc or {}; C.npc["Gardien du savoir Lydros"] = "Tradicionalista Lydros"
  C.npc = C.npc or {}; C.npc["Le Prophète Skeram"] = "El profeta Skeram"
  C.npc = C.npc or {}; C.npc["Maxwort Uberbrille"] = "Maxwort Suprandor"
  C.npc = C.npc or {}; C.npc["Galamav the Marksman"] = "Galamav el Preciso"
  C.npc = C.npc or {}; C.npc["Helendis Ruissecorne"] = "Helendis Rivacuerno"
  C.npc = C.npc or {}; C.npc["Pyrogarde Prophète ardent"] = "Piroguardián brasadivino"
  C.npc = C.npc or {}; C.npc["Ingénieur en chef Vizisanie"] = "Ingeniero Jefe Silvaina"
  C.npc = C.npc or {}; C.npc["Grand exécuteur Hadrec"] = "Sumo Ejecutor Hadrec"
  C.npc = C.npc or {}; C.npc["Nara Crin-Sauvage"] = "Nara Bravacrín"
  C.npc = C.npc or {}; C.npc["Gryan Roidemantel"] = "Gryan Mantorrecio"
  C.npc = C.npc or {}; C.npc["Gizrul l'esclavagiste"] = "Gizrul el esclavista"
  C.npc = C.npc or {}; C.npc["Urok Hurleruine"] = "Urok Aullapocalipsis"
  C.npc = C.npc or {}; C.npc["Instructeur Malicia"] = "Instructor Malicia"
  C.npc = C.npc or {}; C.npc["Veilleur de l'aube Selgorm"] = "Selgorm Guardalbas"
  C.npc = C.npc or {}; C.npc["Latronicus Lancelune"] = "Latronicus Lanzaluna"
  C.npc = C.npc or {}; C.npc["Nara Crin-sauvage"] = "Nara Bravacrín"
  C.npc = C.npc or {}; C.npc["Brikolette Toutevapeur"] = "Tinkee Vaporio"
  C.npc = C.npc or {}; C.npc["Jordan Morpuits"] = "Jordan Fontana"
  C.npc = C.npc or {}; C.npc["Talo Sabot-de-ronce"] = "Talo Pezuñahendida"
  C.npc = C.npc or {}; C.npc["Gershala Murmenuit"] = "Gershala Noctusurro"
  C.npc = C.npc or {}; C.npc["Seigneur Wyrmthalak"] = "Señor Supremo Vermiothalak"
  C.npc = C.npc or {}; C.npc["Sage Recherche-la-vérité"] = "Sabio Buscaverdad"
  C.npc = C.npc or {}; C.npc["Grand prêtre Venoxis"] = "Sumo Sacerdote Venoxis"
  C.npc = C.npc or {}; C.npc["Conseiller Millstipe"] = "Consejero Tallolino"
  C.npc = C.npc or {}; C.npc["Maître-artisan Overspark"] = "Maestro manitas Sobrechispa"
  C.npc = C.npc or {}; C.npc["Maréchal Maxwell"] = "Alguacil Maxwell"
  C.npc = C.npc or {}; C.npc["TUER A VUE"] = "MATAR INMEDIATAMENTE"
  C.npc = C.npc or {}; C.npc["Dalar Tisselaube"] = "Dalar Tejalba"
  C.npc = C.npc or {}; C.npc["Gardien Thelwater"] = "Alcaide Thelagua"
  C.npc = C.npc or {}; C.npc["Matriarche Couveuse"] = "Madre Telabrasada"
  C.npc = C.npc or {}; C.npc["Grande prêtresse Mar'li"] = "Suma Sacerdotisa Mar'li"
  C.npc = C.npc or {}; C.npc["Grutier Bigglefuzz"] = "Operador de grúa Pelardo"
  C.npc = C.npc or {}; C.npc["Noué Dédodevie"] = "Knot Llavededo"
  C.npc = C.npc or {}; C.npc["Grand Bricoleur Mekkanivelle"] = "Alto Mecachifle Mekkatorque"
  C.npc = C.npc or {}; C.npc["Heralath Ruissefriche"] = "Heralath Arroyobarbecho"
  C.npc = C.npc or {}; C.npc["Galamav le Tireur d'élite"] = "Galamav el Preciso"
  C.npc = C.npc or {}; C.npc["Général Drakkisath"] = "General Drakkisath"
  C.npc = C.npc or {}; C.npc["Seigneur Pythas"] = "Lord Pythas"
  C.npc = C.npc or {}; C.npc["Cœur-de-tonnerre"] = "Truenozón"
  C.npc = C.npc or {}; C.npc["Rochébène"] = "Ebanorroca"
  C.npc = C.npc or {}; C.npc["Exilé atal'ai"] = "Exiliado Atal'ai"
  C.npc = C.npc or {}; C.npc["Lachnouf Zéboulon"] = "Wizzle Pernolatón"
  C.npc = C.npc or {}; C.npc["John le Loqueteux"] = "John Andrajoso"
  C.npc = C.npc or {}; C.npc["Hamuul Totem-Runique"] = "Hamuul Runatótem"
  C.npc = C.npc or {}; C.npc["Dame Sarevess"] = "Lady Sarevess"
  C.npc = C.npc or {}; C.npc["Apothicaire Zamah"] = "Boticaria Zamah"
  C.npc = C.npc or {}; C.npc["Chef de guerre Rend Main-noire"] = "Jefe de Guerra Desgarro Puño Negro"
  C.npc = C.npc or {}; C.npc["Seigneur Roccor"] = "Lord Roccor"
  C.npc = C.npc or {}; C.npc["Grande prêtresse Jeklik"] = "Suma Sacerdotisa Jeklik"
  C.npc = C.npc or {}; C.npc["Jin'do le Maléficieur"] = "Jin'do el Malhechor"
  C.npc = C.npc or {}; C.npc["Généralissime Omokk"] = "Alto Señor Omokk"
  C.npc = C.npc or {}; C.npc["Cyrus Lerepenti"] = "Cyrus Therepentio"
  C.npc = C.npc or {}; C.npc["Trenton Martelume"] = "Trenton Mazaligera"
  C.npc = C.npc or {}; C.npc["Seigneur Serpentis"] = "Lord Serpentis"
  C.npc = C.npc or {}; C.npc["Dame Anacondra"] = "Lady Anacondra"
  C.npc = C.npc or {}; C.npc["Garde de guerre Sartura"] = "Guardia de batalla Sartura"
  C.npc = C.npc or {}; C.npc["Sagorne Rôdeur-des-crêtes"] = "Sagorne Zancresta"
  C.npc = C.npc or {}; C.npc["Gouvernante Nagmara"] = "Maestra Nagmara"
  C.npc = C.npc or {}; C.npc["Paria centaure"] = "Paria Centauro"
  C.npc = C.npc or {}; C.npc["Fankriss l'Inflexible"] = "Fankriss el Implacable"
  C.npc = C.npc or {}; C.npc["Ghak Touchesoins"] = "Ghak Sanadón"
  C.npc = C.npc or {}; C.npc["Brasero de Belnistrasz"] = "Blandón de Belnistrasz"
  C.npc = C.npc or {}; C.npc["Maître mécanicien Fontuyau"] = "Maestro mecánico Funditubo"
  C.where = C.where or {}; C.where["Les Hinterlands"] = "Tierras del Interior"
  C.where = C.where or {}; C.where["Salle des Thanes"] = "El Salón de los Feudales"
  C.where = C.where or {}; C.where["Steppes ardentes"] = "Las Estepas Ardientes"
  C.where = C.where or {}; C.where["Mille pointes"] = "Las Mil Agujas"
  C.where = C.where or {}; C.where["Hurlevent"] = "Ciudad de Ventormenta"
  C.where = C.where or {}; C.where["Souilles de Tranchebauge"] = "Zahúrda Rojocieno"
  C.rep = C.rep or {}; C.rep["Exilés de Gnomeregan"] = "Exiliado de Gnomeregan"
  C.rep = C.rep or {}; C.rep["Cercle terrestre"] = "Anillo de la Tierra"
  C.rep = C.rep or {}; C.rep["Trolls Sombrelance"] = "Trols de Lanza Negra"
  C.item = C.item or {}; C.item["Sacoche du Totem-Sinistre"] = "Cartera de Tótem Siniestro"
  C.instance = C.instance or {}; C.instance["hot"] = "El Salón de los Feudales"
  C.instance = C.instance or {}; C.instance["rfd"] = "Zahúrda Rojocieno"
  C.instance = C.instance or {}; C.instance["st"] = "Templo Sumergido"
end
