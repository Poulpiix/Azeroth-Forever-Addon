-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- English. Complete: same keys as frFR. Tone: short and imperative, like the WoW UI.
-- Tokens (%s, %d, |cffRRGGBB, |r) are kept as in frFR. state.*_caps are Title Case on purpose (no :upper()).
-- The Legacy tree keeps its original key prefix, only the displayed words are Legacy.
local ADDON_NAME, AF = ...

AF:RegisterLocale("enUS", {
  -- core
  ["core.loaded"] = "loaded%s. Type |cffffd100/af|r or click the minimap button to open the addon.",
  ["core.ui_missing"] = "Interface not loaded.",

  -- path
  ["path.err.empty"] = "Empty or truncated path.",
  ["path.err.version"] = "Unknown path version.",
  ["path.err.header"] = "Invalid path header.",
  ["path.err.too_long"] = "Path too long (more than %d points).",
  ["path.err.char"] = "Invalid path character.",
  ["path.err.unknown_talent"] = "Unknown talent in this path.",
  ["path.err.maxed"] = "%s is already at max rank (%d).",
  ["path.err.cap"] = "%d point cap reached.",
  ["path.err.other_talent"] = "another talent",
  ["path.err.prereq"] = "%s requires %s at rank %d.",
  ["path.err.tier"] = "%s requires %d points in the %s tree (%d at that point in the path).",
  ["path.err.cannot_remove"] = "Cannot remove %s: %s",

  -- talents
  ["talents.err.class_unknown"] = "Unknown class.",
  ["talents.err.talent_unknown"] = "Unknown talent.",
  ["talents.count"] = "%d talents",
  ["talents.head_sub"] = "%s · %s, %d new and %d changed",
  ["talents.client_data"] = "Client data %s",

  -- apply
  ["apply.err.unreadable"] = "Cannot read in-game talents: type /af diag.",
  ["apply.err.not_found"] = "%s was not found in the client.",
  ["apply.err.not_learnable"] = "%s cannot be learned yet (prerequisite or tree points).",
  ["apply.info.nothing_to_apply_learned"] = "Nothing to apply: the build is already learned in game.",
  ["apply.err.cannot_unlearn"] = "The game does not allow unlearning a single learned point",
  ["apply.err.combat"] = "Not possible in combat.",
  ["apply.err.locked"] = "Talents cannot be changed right now.",
  ["apply.err.no_points"] = "No talent points available on this character.",
  ["apply.err.no_more_points"] = "No more points available for the rest of the build.",
  ["apply.err.refused"] = "The game refused %s.",
  ["apply.err.nothing"] = "Nothing to apply.",
  ["apply.err.not_validated"] = "The game did not confirm the talents.",
  ["apply.err.none_learned"] = "No build point is learned in game.",
  ["apply.err.refused_remove"] = "The game refused to remove %s.",
  ["apply.ok.removed"] = "Removed in game: %s.",
  ["apply.err.timeout"] = "The game did not learn the requested talents.",
  ["apply.warn.learned.one"] = "%d point learned. %s",
  ["apply.warn.learned.other"] = "%d points learned. %s",
  ["apply.ok.build_applied"] = "Build applied in game: %d points learned.",
  ["apply.ok.learned"] = "Learned in game: %s.",

  -- share
  ["share.err.empty_any"] = "Paste a code starting with AF1- (class) or AF1H- (Legacy).",
  ["share.err.not_af_any"] = "This is not an Azeroth Forever code: it must start with AF1- or AF1H-.",
  ["share.err.incomplete"] = "Incomplete code: copy it in full, down to the last 2 characters.",
  ["share.err.corrupt"] = "Damaged code (bad checksum): copy it in full.",
  ["share.err.kind"] = "Unknown code type.",
  ["share.err.class_in_code"] = "Unknown class in this code.",
  ["share.err.empty_class"] = "Paste a code starting with AF1-.",
  ["share.err.is_heritage"] = "This is a Legacy code: use the Legacy tab to read it.",
  ["share.err.not_af_class"] = "This is not an Azeroth Forever code: it must start with AF1-.",
  ["share.err.class_or_catalog"] = "Unknown class in this code (or a different talent catalog: update the addon).",
  ["share.err.catalog_changed"] = "The talent catalog has changed: update the addon (%s)",
  ["share.err.impossible_order"] = "This code describes an impossible order (step %d): %s",
  ["share.export_error"] = "Cannot export: %s",
  ["share.copy_link"] = "Copy link",
  ["share.link_help_build"] = "Link to this page (build + point order)",
  ["share.copy_code"] = "Copy addon code",
  ["share.code_help_class"] = "AF1- code to paste in the addon or on the site",
  ["share.code_title"] = "Addon code",
  ["share.paste"] = "Paste a code",
  ["share.paste_menu_help"] = "AF1- code (class) or AF1H- code (Legacy)",
  ["share.paste_popup_help"] = "AF1- (class) or AF1H- (Legacy) code, then Import.",
  ["share.public_help"] = "Ctrl+C to copy, then open the link in your browser.",
  ["share.public_title"] = "Public builds %s",

  -- heritage
  ["heritage.err.is_class"] = "This is a class code (AF1-), not a Legacy code.",
  ["heritage.err.version"] = "Unknown Legacy code version: update the site.",
  ["heritage.err.unreadable"] = "Unreadable Legacy code (%d ranks instead of %d).",
  ["heritage.err.rank_max"] = "%s cannot exceed rank %d.",
  ["heritage.err.too_many"] = "This code spends more than %d Legacy points.",
  ["heritage.err.tiers"] = "This code does not respect the tree point tiers.",
  ["heritage.err.node_unknown"] = "Unknown node.",
  ["heritage.err.cap"] = "Legacy cap of %d points reached.",
  ["heritage.err.tier_locked"] = "Tier not reached for %s.",
  ["heritage.err.preset_invalid"] = "Invalid preset.",
  ["heritage.err.preset_unknown"] = "Unknown preset.",
  ["heritage.title"] = "Legacy Tree",
  ["heritage.sub"] = "Professions · Adventure · Ingenuity · %s",
  ["heritage.total_points"] = "%d points",
  ["heritage.stat.spent_caps"] = "POINTS SPENT",
  ["heritage.stat.left_caps"] = "POINTS LEFT",
  ["heritage.reset_done"] = "Legacy reset.",
  ["heritage.view_at"] = "View my Legacy build at %s spent points",
  ["heritage.unknown_skill"] = "Unknown skill",
  ["heritage.unknown_skill_hint"] = "Will be added in a future update.",
  ["heritage.tip.rank_meta"] = "Rank %d/%d · %s",
  ["heritage.tip.passive"] = "Passive",
  ["heritage.tip.at_points"] = "At %d points spent: rank %d/%d",
  ["heritage.tip.requires"] = "Requires %d Legacy points spent in %s.",
  ["heritage.imported"] = "Legacy imported (%d points).",
  ["heritage.link_help"] = "Link to this page (?hbuild=)",
  ["heritage.code_help"] = "AF1H- code to paste in the addon or on the site",
  ["heritage.talented_note"] = "Your class talents start at level 9.",
  ["heritage.tree.professions"] = "Professions",
  ["heritage.col.professions.sub"] = "Crafting, gathering and gold.",
  ["heritage.node.travail-acharne.name"] = "Hard Work",
  ["heritage.node.travail-acharne.desc"] = "Increases your chance to gain a skill point when using a primary, secondary or class profession by 4%.",
  ["heritage.node.marchandage.name"] = "Haggling",
  ["heritage.node.marchandage.desc"] = "Reduces the gold price of items bought from all vendors by 5%.",
  ["heritage.node.chef-etoile.name"] = "Star Chef",
  ["heritage.node.chef-etoile.desc"] = "Your Cooking recipes have a 10% chance to create an additional result.",
  ["heritage.node.etude-assidue.name"] = "Diligent Study",
  ["heritage.node.etude-assidue.desc"] = "Increases your lowest skill among your current primary and secondary professions by 1 point. If you have already reached 300 in both primary professions and all three secondary professions, you obtain 2 to 4 random Elemental Essences.",
  ["heritage.node.etude-assidue.meta"] = "25 sec cast, 23 hr cooldown",
  ["heritage.node.recolte-abondante.name"] = "Bountiful Harvest",
  ["heritage.node.recolte-abondante.desc"] = "You find 20% more Uncommon materials from Mining, Herbalism and Skinning.",
  ["heritage.node.prime-de-rendement.name"] = "Yield Bonus",
  ["heritage.node.prime-de-rendement.desc"] = "You have a 5% chance to receive 100% more Merchant's Favor when delivering a crate to the Azeroth Commerce Authority or Durotar Logistics.",
  ["heritage.node.maitre-appateur.name"] = "Master Baiter",
  ["heritage.node.maitre-appateur.desc"] = "When fishing with an active Bait, you have a 25% chance to catch an additional fish.",
  ["heritage.tree.adventure"] = "Adventure",
  ["heritage.col.adventure.sub"] = "Progression, exploration and utilities.",
  ["heritage.node.haute-vigilance.name"] = "High Alert",
  ["heritage.node.haute-vigilance.desc"] = "Increases your ability to detect nearby stealthed targets, as if your level were increased by 1. Ineffective in battlegrounds.",
  ["heritage.node.bien-repose.name"] = "Well Rested",
  ["heritage.node.bien-repose.desc"] = "Your rested experience accumulates 4% faster and its cap is increased by 4%.",
  ["heritage.node.talentueux.name"] = "Talented",
  ["heritage.node.talentueux.desc"] = "You gain a talent point every level starting at level 9 instead of level 10, never exceeding 51 talent points in total.",
  ["heritage.node.frisson-aventure.name"] = "Thrill of Adventure",
  ["heritage.node.frisson-aventure.desc"] = "You recover 1% of your maximum health and mana over 10 sec each time you land a killing blow on a non-trivial enemy. Ineffective in dungeons, raids and battlegrounds.",
  ["heritage.node.guide-de-terrain.name"] = "Field Guide",
  ["heritage.node.guide-de-terrain.desc"] = "Reduces the cooldown to add camp elements by 8%.",
  ["heritage.node.grand-voyageur.name"] = "Seasoned Traveler",
  ["heritage.node.grand-voyageur.desc"] = "You receive a 50% discount on all flight paths, and your flying mount flies 20% faster.",
  ["heritage.node.medecine-de-terrain.name"] = "Field Medicine",
  ["heritage.node.medecine-de-terrain.desc"] = "Reduces the duration of the \"Recently Bandaged\" effect by 5 sec when you use a Bandage. Ineffective in dungeons, raids and battlegrounds.",
  ["heritage.tree.ingenuity"] = "Ingenuity",
  ["heritage.col.ingenuity.sub"] = "Upkeep, reputation and honor.",
  ["heritage.node.pour-un-plus-grand-honneur.name"] = "For Greater Honor",
  ["heritage.node.pour-un-plus-grand-honneur.desc"] = "Increases Honor Points gained by 2%.",
  ["heritage.node.gourmet.name"] = "Gourmet",
  ["heritage.node.gourmet.desc"] = "Increases the duration of beneficial effects from food by 33%.",
  ["heritage.node.permanence.name"] = "Permanence",
  ["heritage.node.permanence.desc"] = "Long-duration stat or attribute bonuses that your class abilities grant to the group or raid last 50% longer, as do the benefits gained from resting at a camp.",
  ["heritage.node.les-vifs-et-les-morts.name"] = "The Quick and the Dead",
  ["heritage.node.les-vifs-et-les-morts.desc"] = "Increases your movement speed by 5% while dead, and your beneficial spells and abilities cost no resources for 1 min after a resurrection or until you enter combat.",
  ["heritage.node.economie-de-reactifs.name"] = "Reagent Economy",
  ["heritage.node.economie-de-reactifs.desc"] = "Your class abilities no longer require reagents purchasable from a vendor, and your rank 1 camp elements cost no reagents to craft.",
  ["heritage.node.renforcement.name"] = "Reinforcement",
  ["heritage.node.renforcement.desc"] = "You lose 8% less durability when you die.",
  ["heritage.node.diplomate.name"] = "Diplomat",
  ["heritage.node.diplomate.desc"] = "Increases your reputation gains by 2%.",

  -- tab
  ["tab.talents"] = "Talents",
  ["tab.heritage"] = "Legacy",
  ["tab.dungeons"] = "Dungeons & Raids",

  -- faction
  ["faction.alliance_caps"] = "ALLIANCE",
  ["faction.horde_caps"] = "HORDE",
  ["faction.alliance"] = "Alliance",
  ["faction.horde"] = "Horde",
  ["faction.both"] = "Neutral",

  -- ui
  ["ui.err_section"] = "Interface error (%s): %s",
  ["ui.err"] = "Interface error: %s",
  ["ui.tagline"] = "TOOLS FOR WOW FOREVER",
  ["ui.close"] = "Close (Esc)",
  ["ui.site_tip"] = "Site link to copy",
  ["ui.site_title"] = "Azeroth Forever website",
  ["ui.site_hint"] = "Ctrl+C to copy the link, then paste it in your browser.",

  -- cmd
  ["cmd.scale"] = "Window scale: %s",
  ["cmd.diag_saved"] = "Diagnostics saved to SavedVariables\\AzerothForever.lua after /reload.",
  ["cmd.debug"] = "Debug mode: %s",
  ["cmd.help"] = "Commands: /af, /af talents, /af legacy, /af dungeons, /af scale 0.8, /af diag, /af survey, /af loot, /af minimap, /af locale, /af debug",
  ["cmd.locale_current"] = "Active language: %s (client: %s). To change: /af locale frFR, /af locale auto.",
  ["cmd.locale_set"] = "Language: %s. Type /reload to apply.",
  ["cmd.locale_auto"] = "Automatic language (%s). Type /reload to apply.",
  ["cmd.locale_bad"] = "Unknown language: %s. Possible values: %s.",

  -- state
  ["state.on"] = "enabled",
  ["state.off"] = "disabled",
  ["state.done"] = "Completed",
  ["state.log"] = "In progress",
  ["state.avail"] = "Available",
  ["state.locked"] = "Unavailable",
  ["state.done_caps"] = "Completed",
  ["state.log_caps"] = "In Progress",
  ["state.avail_caps"] = "Available",
  ["state.locked_caps"] = "Unavailable",

  -- minimap
  ["minimap.tip.left"] = "Left-click: open / close",
  ["minimap.tip.right"] = "Right-click: Dungeons & Raids",
  ["minimap.tip.drag"] = "Drag: move the button",
  ["minimap.tip.cmd"] = "/af minimap: hide / show",
  ["minimap.hidden"] = "Minimap button hidden. Type /af minimap to show it again.",
  ["minimap.shown"] = "Minimap button shown.",

  -- common
  ["common.close"] = "Close",
  ["common.import"] = "Import",
  ["common.cancel"] = "Cancel",
  ["common.ok"] = "OK",
  ["common.confirm"] = "Confirmation",
  ["common.lvl"] = "Lvl %s",
  ["common.lvl_lower"] = "lvl %s",
  ["common.level_n"] = "Level %s",
  ["common.required_n"] = "required %s",
  ["common.show"] = "Show",

  -- popup
  ["popup.copy_help"] = "Ctrl+C to copy, Esc to close.",
  ["popup.code_unreadable"] = "Unreadable code.",

  -- status
  ["status.new"] = "New",
  ["status.changed"] = "Changed",
  ["status.unchanged"] = "Verified identical",

  -- mode
  ["mode.final"] = "Level 60 build",
  ["mode.path"] = "Level-by-level build",
  ["mode.final_hint"] = "Level 60 build: you place the final points, the leveling order is worked out for you.",
  ["mode.path_hint"] = "Level-by-level build: each click is the next point you will take as you level up.",

  -- badge
  ["badge.changed_from_classic"] = "Changed from Classic",
  ["badge.new_in_forever"] = "New in Forever",

  -- stat
  ["stat.spent_caps"] = "POINTS SPENT",
  ["stat.left_caps"] = "POINTS LEFT",
  ["stat.level_required_caps"] = "REQUIRED LEVEL",
  ["stat.available_caps"] = "AVAILABLE",
  ["stat.spent_short_caps"] = "SPENT",

  -- btn
  ["btn.public_builds"] = "Public builds",
  ["btn.public_builds_class"] = "Public builds %s",
  ["btn.share"] = "Share",
  ["btn.save"] = "Save",
  ["btn.reset"] = "Reset",
  ["btn.view_order"] = "View point order",
  ["btn.automatic"] = "Automatic",
  ["btn.automatic_tip"] = "Applies the next build point in game each time you level up",
  ["btn.sync"] = "Sync",
  ["btn.sync_tip"] = "Replaces the build with the talents learned on this character",
  ["btn.undo"] = "Undo",
  ["btn.undo_tip"] = "Removes the last learned point in game",
  ["btn.apply_all"] = "Apply all points",
  ["btn.apply_all_tip"] = "Applies every build point in game",
  ["btn.apply_next"] = "Apply next point",
  ["btn.apply_next_tip"] = "Applies the next build point in game",
  ["btn.apply"] = "Apply",

  -- toggle
  ["toggle.classic_version"] = "Classic version",

  -- planner
  ["planner.view_at_level"] = "View my build at level %s",

  -- tree
  ["tree.reset_tip"] = "Reset this tree",
  ["tree.pts"] = "%d pts",
  ["tree.pts_at"] = "%d/%d pts",
  ["tree.warrior.arms"] = "Arms",
  ["tree.warrior.fury"] = "Fury",
  ["tree.warrior.protection"] = "Protection",
  ["tree.paladin.holy"] = "Holy",
  ["tree.paladin.protection"] = "Protection",
  ["tree.paladin.retribution"] = "Retribution",
  ["tree.hunter.beast_mastery"] = "Beast Mastery",
  ["tree.hunter.marksmanship"] = "Marksmanship",
  ["tree.hunter.survival"] = "Survival",
  ["tree.rogue.assassination"] = "Assassination",
  ["tree.rogue.combat"] = "Combat",
  ["tree.rogue.subtlety"] = "Subtlety",
  ["tree.priest.discipline"] = "Discipline",
  ["tree.priest.holy"] = "Holy",
  ["tree.priest.shadow"] = "Shadow",
  ["tree.shaman.elemental"] = "Elemental",
  ["tree.shaman.enhancement"] = "Enhancement",
  ["tree.shaman.restoration"] = "Restoration",
  ["tree.mage.arcane"] = "Arcane",
  ["tree.mage.fire"] = "Fire",
  ["tree.mage.frost"] = "Frost",
  ["tree.warlock.affliction"] = "Affliction",
  ["tree.warlock.demonology"] = "Demonology",
  ["tree.warlock.destruction"] = "Destruction",
  ["tree.druid.balance"] = "Balance",
  ["tree.druid.feral"] = "Feral",
  ["tree.druid.restoration"] = "Restoration",

  -- order
  ["order.title"] = "Point order",
  ["order.empty"] = "No points placed. Click a talent to start.",

  -- footer
  ["footer.in_game_caps"] = "IN GAME",

  -- toast
  ["toast.build_cleared"] = "Build cleared for %s.",
  ["toast.this_class"] = "this class",
  ["toast.other_class"] = "You are viewing another class: switch back to your class to act in game.",
  ["toast.synced.one"] = "Build synced: %d point learned in game.",
  ["toast.synced.other"] = "Build synced: %d points learned in game.",
  ["toast.build_imported"] = "Build imported: %s.",
  ["toast.point_tomtom"] = "TomTom waypoint set: %s.",
  ["toast.point_map"] = "Map pin set: %s.",
  ["toast.point_unknown"] = "Unknown location for %s.",

  -- confirm
  ["confirm.apply_all"] = "Apply all build points in game now?",

  -- save
  ["save.title"] = "Save build",
  ["save.list_caps"] = "BUILDS SAVED ON THIS ACCOUNT",
  ["save.empty"] = "No saved build for this class.",
  ["save.err.name"] = "Give the build a name.",
  ["save.err.empty"] = "The build is empty: nothing to save.",
  ["save.ok"] = "Build \"%s\" saved.",
  ["save.btn_delete"] = "Delete",
  ["save.btn_load"] = "Load",
  ["save.row_meta"] = "%d points · %s",
  ["save.err.unreadable"] = "Cannot read this build with the current data: %s",
  ["save.loaded"] = "Build \"%s\" loaded.",

  -- tip
  ["tip.rank"] = "Rank %d/%d",
  ["tip.next_rank_caps"] = "NEXT RANK",
  ["tip.classic_caps"] = "CLASSIC",
  ["tip.at_level"] = "At level %d: rank %d/%d",
  ["tip.next_rank_classic"] = "Next rank (Classic): %s",
  ["tip.requires_tree_points"] = "Requires %d points in this tree.",
  ["tip.requires_rank"] = "%s (rank %d)",
  ["tip.requires_list"] = "Requires: %s",
  ["tip.learned_in_game"] = "Learned in game: %d/%d",
  ["tip.click_learn"] = "Click: learn · Right-click: unlearn",

  -- preset
  ["preset.leveling"] = "Adventure",
  ["preset.metiers"] = "Professions",
  ["preset.qdv60"] = "Ingenuity",
  ["preset.applied"] = "Preset \"%s\" applied (%d points).",
  ["preset.err"] = "Cannot apply preset.",

  -- origin
  ["origin.classic"] = "Classic",

  -- type
  ["type.dungeon_new"] = "New Forever dungeon",
  ["type.dungeon_classic"] = "Classic dungeon",
  ["type.raid_new"] = "New Forever raid",
  ["type.raid_classic"] = "Classic raid",
  ["type.instance_new"] = "New Forever instance",
  ["type.instance_classic"] = "Classic instance",

  -- rep
  ["rep.orgrimmar"] = "Orgrimmar",
  ["rep.thunder_bluff"] = "Thunder Bluff",
  ["rep.undercity"] = "Undercity",
  ["rep.ironforge"] = "Ironforge",
  ["rep.stormwind"] = "Stormwind",
  ["rep.darnassus"] = "Darnassus",
  ["rep.gnomeregan_exiles"] = "Gnomeregan Exiles",
  ["rep.ratchet"] = "Ratchet",
  ["rep.gadgetzan"] = "Gadgetzan",
  ["rep.argent_dawn"] = "Argent Dawn",
  ["rep.cenarion_circle"] = "Cenarion Circle",

  -- chain
  ["chain.part"] = "Part of a chain (steps to record)",
  ["chain.next"] = "Next in a chain (steps to record)",
  ["chain.teleporter"] = "Chain tied to the Gnomeregan teleporter",
  ["chain.title_caps"] = "QUEST CHAIN: PREVIOUS STEPS",
  ["chain.start_outside"] = "The chain starts outside the instance: %s.",
  ["chain.at_zone"] = "in %s",
  ["chain.from_npc"] = "from %s",
  ["chain.start_item"] = "The chain starts with an item found in game.",
  ["chain.to_verify"] = "to verify",

  -- filter
  ["filter.all"] = "All",
  ["filter.new"] = "New",
  ["filter.raids"] = "Raids",

  -- section
  ["section.levels"] = "Levels %d to %d",
  ["section.raids"] = "Raids",

  -- unit
  ["unit.dungeon.one"] = "%d dungeon",
  ["unit.dungeon.other"] = "%d dungeons",
  ["unit.raid.one"] = "%d raid",
  ["unit.raid.other"] = "%d raids",
  ["unit.quest.one"] = "%d quest",
  ["unit.quest.other"] = "%d quests",
  ["unit.boss.one"] = "%d boss",
  ["unit.boss.other"] = "%d bosses",

  -- fmt
  ["fmt.thousands_sep"] = ",",
  ["fmt.date"] = "%2$s/%1$s/%3$s",

  -- money
  ["money.g"] = "g",
  ["money.s"] = "s",
  ["money.c"] = "c",

  -- card
  ["card.players"] = "%s players",
  ["card.visual_soon_caps"] = "ARTWORK COMING SOON",
  ["card.faction"] = "Faction: %s",
  ["card.level_recommended"] = "Recommended lvl %s",
  ["card.level_max"] = "Level %d",
  ["card.quests_todo"] = "Quests: TBD",
  ["card.quests_side"] = "%s for %s",

  -- dungeons
  ["dungeons.footer"] = "Data as of %s - %d instances",
  ["dungeons.footer_nodate"] = "Data - %d instances",
  ["dungeons.title"] = "Dungeons & Raids",
  ["dungeons.sub"] = "The %d World of Warcraft Forever dungeons, Classic and new, from level 13 to 60, plus the raids.",
  ["search.placeholder"] = "Dungeon, boss or loot…",
  ["search.none"] = "No results",

  -- detail
  ["detail.back"] = "All dungeons",
  ["detail.show_entrance"] = "Show entrance",
  ["detail.tab_quests"] = "Quests",
  ["detail.tab_boss"] = "Bosses",
  ["detail.tab_quests_count"] = "Quests %d",
  ["detail.tab_boss_count"] = "Bosses %d",

  -- point
  ["point.this"] = "this location",
  ["point.entrance"] = "Entrance: %s",

  -- fact
  ["fact.zone"] = "Zone",
  ["fact.entry"] = "Entrance",
  ["fact.faction"] = "Faction",
  ["fact.level_required"] = "Required level",
  ["fact.group_finder"] = "Looking for Group",
  ["fact.players"] = "Players",
  ["fact.access_todo"] = "Access: TBD",

  -- boss
  ["boss.rare"] = "rare",
  ["boss.quest"] = "quest",
  ["boss.with"] = "with %s",
  ["boss.none"] = "No known boss for this instance.",
  ["boss.select"] = "Select a boss.",
  ["boss.met"] = "encountered in game",
  ["boss.no_pin"] = "no map position",
  ["boss.pin_with"] = "%s (with %s)",
  ["boss.caps"] = "BOSS",

  -- item
  ["item.loading"] = "Item %d (loading)",

  -- loot
  ["loot.caps"] = "LOOT",
  ["loot.none"] = "Loot not recorded for this boss (beta).",
  ["loot.verify_classic_caps"] = "TO VERIFY: CLASSIC LOOT",
  ["loot.verify_external_caps"] = "TO VERIFY: EXTERNAL SOURCE",
  ["loot.seen"] = "%s in game on this boss (%s).",
  ["loot.items_seen.one"] = "%d item seen",
  ["loot.items_seen.other"] = "%d items seen",
  ["loot.kills_noted.one"] = "%d kill noted",
  ["loot.kills_noted.other"] = "%d kills noted",
  ["loot.disclaimer"] = "Loot may contain errors, because the Blizzard API under World of Warcraft Forever hides a lot of information, at least during the beta. This will be updated as we go. Do not treat this list as final.",

  -- quest
  ["quest.meta_chain"] = "Chain",
  ["quest.meta_in_log"] = "in log",
  ["quest.meta_unconfirmed"] = "unconfirmed",
  ["quest.none_instance"] = "No known quest for this instance.",
  ["quest.none_faction"] = "No quest for this faction.",
  ["quest.select"] = "Select a quest.",
  ["quest.fallback_name"] = "Quest %d",
  ["quest.state_for"] = "%s for %s",
  ["quest.tag_level"] = "level %s",
  ["quest.tag_chain"] = "Quest chain",
  ["quest.tag_unconfirmed"] = "Unconfirmed (beta)",
  ["quest.locked_hint"] = "Unavailable: an earlier step is not completed (see the chain below).",
  ["quest.objectives_caps"] = "OBJECTIVES",
  ["quest.giver_caps"] = "GIVER",
  ["quest.start_caps"] = "START",
  ["quest.turnin_caps"] = "TURN-IN",
  ["quest.rewards_caps"] = "REWARDS",
  ["quest.rewards_choice_caps"] = "REWARDS: CHOOSE ONE ITEM",
  ["quest.xp"] = "%s XP",
  ["quest.rewards_external"] = "The game does not provide these rewards yet: they come from an external source. Verify in game.",
  ["quest.rewards_none"] = "Rewards not recorded.",

  -- place
  ["place.unknown"] = "Unknown",

  -- map
  ["map.floor_n"] = "Floor %d",
  ["map.level_n"] = "Level %d",
  ["map.levels_caps"] = "LEVELS",

  -- pin
  ["pin.no_position"] = "No map position yet",
  ["pin.click_loot"] = "Click: view its loot",
  ["pin.rare_prefix"] = "Rare. %s",
  ["pin.quest_boss_prefix"] = "Quest boss. %s",
  ["pin.variable"] = "Variable position: one of these %d spots. %s",
  ["pin.quest_item"] = "Quest item",
  ["pin.rare_off_list"] = "Rare, not on the boss list",
  ["pin.to_verify"] = "To verify: missing from the boss list",

  -- audit
  ["audit.done"] = "Survey complete: %d/%d quests known to the server (%d unknown), %d/%d items known (%d unknown), %d instances in the journal. Type /reload to save it.",
  ["audit.running"] = "Survey already running.",
  ["audit.started"] = "Survey running: %d quests and %d items to request from the server (up to 3 min).",
  ["audit.forbidden"] = "Action refused by the client: %s (noted for a fix).",
  ["audit.loot_summary"] = "Logged in dungeons: %d bosses met, %d items from %d NPCs. Counted in the next survey.",

  -- instfaction
  ["instfaction.both"] = "Horde / Alliance",

  -- availability
  ["availability.not_open"] = "Not open yet",
  ["availability.opens_dec9"] = "Opens Dec 9",

  -- instance
  ["instance.group_change"] = "Group size changed from 10 players (Classic Era) to 5.",
})
