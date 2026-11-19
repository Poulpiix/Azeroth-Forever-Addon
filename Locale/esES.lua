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

  -- faction
  ["faction.alliance_caps"] = "ALIANZA",
  ["faction.horde_caps"] = "HORDA",

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
  ["cmd.help"] = "Comandos: /af, /af talents, /af legacy, /af scale 0.8, /af diag, /af minimap, /af locale, /af debug",
  ["cmd.locale_current"] = "Idioma activo: %s (cliente: %s). Para cambiarlo: /af locale frFR, /af locale auto.",
  ["cmd.locale_set"] = "Idioma: %s. Escribe /reload para aplicarlo.",
  ["cmd.locale_auto"] = "Idioma automático (%s). Escribe /reload para aplicarlo.",
  ["cmd.locale_bad"] = "Idioma desconocido: %s. Valores posibles: %s.",
  -- language picker (header)
  ["lang.button_tip"] = "Idioma del addon",
  ["lang.auto"] = "Idioma del juego",
  ["lang.auto_help"] = "Actualmente: %s",
  ["lang.need_client"] = "Requiere el juego en este idioma (fuentes)",
  ["lang.reload_confirm"] = "Idioma elegido: %s. Se aplicará al recargar la interfaz. ¿Recargar ahora?",
  ["lang.reload"] = "Recargar",
  ["lang.frFR"] = "Francés",
  ["lang.enUS"] = "Inglés",
  ["lang.deDE"] = "Alemán",
  ["lang.esES"] = "Español (España)",
  ["lang.esMX"] = "Español (México)",
  ["lang.itIT"] = "Italiano",
  ["lang.koKR"] = "Coreano",
  ["lang.jaJP"] = "Japonés",

  -- state
  ["state.on"] = "activado",
  ["state.off"] = "desactivado",

  -- minimap
  ["minimap.tip.left"] = "Clic izquierdo: abrir / cerrar",
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

  -- unit
  ["unit.dungeon.one"] = "%d mazmorra",
  ["unit.dungeon.other"] = "%d mazmorras",
})

-- Classic talent text by talent id, one string per rank. Read by Names.lua N:ClassicRank. A talent missing here falls back to enUS, then to the French data.
AF.Content = AF.Content or {}
AF.Content.esES = AF.Content.esES or {}

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
  [113570] = {
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
