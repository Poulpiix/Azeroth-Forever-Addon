# Azeroth Forever: version history

## Version 0.6.0 (November 8, 2026)

**Dungeons & Raids tab removed**
- The Dungeons & Raids tab is gone: other addons cover dungeons and raids better, so the addon now focuses on Talents and Heritage.
- Removed with it: the quest, boss and loot pages, the dungeon search, the "Show the entrance" waypoint, the quest progress tracking and the in game survey tools.
- Commands `/af donjons`, `/af dungeons`, `/af survey` (`/af releve`) and `/af loot` (`/af butin`) no longer exist.
- The minimap button now only opens or closes the window (left click). The right click shortcut to Dungeons & Raids is removed.

**Good to know**
- Talents, Heritage, AF1- / AF1H- sharing and the Classic talent texts in all languages are unchanged.
- If your last open tab was Dungeons & Raids, the window opens on Talents.
- Old saved data of the removed tab (quests done, survey results) stays harmlessly in your saved variables. It is no longer read.

## Version 0.5.0 (November 4, 2026)

**Update for the November 3 patch (client 1.60.1.70755)**
- Talent data updated for all nine classes: new talents, reworked talents and talents removed by the class balance changes.
- Talents removed by the patch stay in old shared builds but no longer cost points.
- The talent count is now 488 entries (468 usable talents).

**Good to know**
- Some French names of new talents are not official yet. They will be corrected if the game uses other names.

## Version 0.4.9 (October 22, 2026)

**New languages**
- The addon is now available in Italian, Korean and Japanese: interface, Classic talent texts, quest objectives, NPC names, places and reputations.
- Korean and Japanese need the game client in that language (the other clients do not have the fonts).

**Language button**
- New language button at the top right of the window, next to Alliance / Horde. Pick a language, or "Game language" to follow the client again. The interface reloads to apply it.

**Good to know**
- Some Italian, Korean and Japanese names (NPCs, places, a few spells) are not official yet. They will be corrected if the game uses other names.

## Version 0.4.8 (October 19, 2026)

**Fixes**
- Fixed a Lua error when opening a loot window in a dungeon ("attempt to compare local 'targetGUID' (a secret string value)"). Loot is still counted when the target is protected by the game; only the monster name may be left blank.
- Boss encounter tracking no longer errors when the boss level or ID is hidden by the game.

## Version 0.4.7 (October 16, 2026)

Updated for the October 15 patch (client 1.60.1.70425).

**New talents**
- Shaman: Elemental Mastery
- Mage: Arcane Wrath
- Priest: Dark Inspiration (replaces Improved Fade)
- Warlock: Grim Reach (replaces Curse)

**Removed talents**
- Shaman: Call of Thunder
- Priest: Shadow Affinity

**Changed talents**
- Descriptions and values are up to date for many Shaman, Mage, Priest, Paladin, Warlock, Hunter, Druid and Warrior talents.
- Mage: Critical Mass now has 5 ranks and Fire Power has 3 ranks.
- Several talents moved or have new prerequisites in the Shaman, Mage and Priest trees.

**Classic version**
- The Classic text is now shown for Arctic Reach, Improved Frostbolt, Fire Power, Critical Mass and Elemental Mastery. For now it is in English in German and Spanish.
- Grim Reach, Shadow Mastery and Destructive Reach are now identical to Classic.

**Good to know**
- The addon shows talent names in French. Some French names of new talents are not official yet (for example Courroux des arcanes and Inspiration ténébreuse). They will be corrected if the game uses other names.
