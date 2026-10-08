# Azeroth Forever (addon)

Addon for **World of Warcraft Forever** (client 1.60.x). Class talent builder,
Heritage builder, dungeon and raid journal, and two-way sharing with
[azerothforever.info](https://azerothforever.info/), in game, without spending
a single point until you click Apply.

The in-game interface is available in French and English (`/af locale` to force a language,
other languages fall back to English). Talent descriptions, quest text and place names follow the
game client language.

Author: Poulpix. All rights reserved, see `LICENSE.md`.

## Installation

Copy the `AzerothForever` folder (the one containing `AzerothForever.toc`)
into `Interface/AddOns/` of your WoW Forever client, then restart the game.

## Usage

- `/af` opens or closes the window. A message in the chat confirms the addon
  is loaded at login and after `/reload`.
- Minimap button (addon logo, follows the Alliance / Horde theme): left click
  opens or closes the window, right click opens Dungeons & Raids, drag to move
  it around the minimap. `/af minimap` hides or shows it. Minimap button
  collectors using LibDBIcon are supported when that library is loaded.
- `/af talents`, `/af heritage`, `/af donjons` open a tab directly.
- `/af echelle 0.8` (0.6 to 1.2) changes the window size.
- `/af diag` shows what the client exposes for talents; the text is also kept
  in `WTF/.../SavedVariables/AzerothForever.lua` after `/reload`.
- `/af releve` asks the server about the quests and items of the dungeon
  journal and reads what the client exposes; `/reload` saves it.
- In dungeons, the addon records the bosses you meet and the loot you pick up
  (green and better); `/af butin` shows the count.

The window uses the visual identity of
[azerothforever.info](https://azerothforever.info/): same colors, fonts and
labels, and an Alliance / Horde switch that changes the whole palette and the
logo.

### Window: 3 tabs

- **Talents**: the 9 classes, class header (new and changed talents), points
  bar (spent, remaining, required level), Classic version, Reset, Save (named
  builds, per account), Share, public builds. "See my build at level X"
  slider, **level 60 build** and **level by level build** modes. Left click =
  +1 rank, right click = -1 rank; nothing is learned in game until you click
  Apply. "In game" footer: apply the next point, apply all points (with
  confirmation), Undo (disabled: the game cannot remove a single point),
  Sync (replaces the build with the talents you learned), Automatic box
  (off by default).
- **Heritage**: the 16 points (Professions, Adventure, Ingenuity), 3 presets,
  "See my heritage at N points spent" slider, AF1H- sharing.
- **Dungeons & Raids**: every dungeon and raid of the site (Scarlet Monastery
  split into its 4 wings), filters (All, Classic, New, Raids) and level
  ranges, and a search field (dungeon, boss or loot name, in English, French,
  German or Spanish) that opens the dungeon on the right boss. Each dungeon
  page has two tabs:
  - **Quests**: quests of the chosen faction, quest chains, givers and
    turn-ins with a "Show" button, rewards.
  - **Boss**: dungeon map with numbered boss pins (portrait or icon plus
    progression number), levels side by side, boss row, and the selected
    boss with its loot.
  One "Show the entrance" button in the page header places a waypoint on the
  world map (TomTom if installed).

### AF1- / AF1H- sharing

Codes use exactly the same format and checksum as the site: a build made in
the addon can be pasted on the site, and the other way around. If the talent
catalog changed between the site and your version of the addon, the import is
refused with a message instead of loading a wrong build.

## Files

```
AzerothForever.toc   Addon metadata
Core.lua             Init, low level helpers (bit/CRC), SavedVariables
Talents.lua          Build codec, build, in-game apply
Share.lua            AF1- codes
Heritage.lua         AF1H- codes, Heritage build
Theme.lua            Site color tokens (Alliance / Horde), fonts
Widgets.lua          Site style components (buttons, slider, menus...)
UI.lua               Main window: header, tabs, footer, /af commands
Minimap.lua          Minimap button
TalentsTab.lua       Talents tab
HeritageTab.lua      Heritage tab
Names.lua            Display layer for the French data (client API first, then English content)
Locale/              One file per language, plus enUS_Content.lua (hand translated data texts)
Journal.lua          Dungeon journal data (client first, then bundled data)
DungeonsTab.lua      Dungeons & Raids tab: list
DungeonDetail.lua    Dungeons & Raids tab: dungeon page, maps, boss pins
DungeonSearch.lua    Dungeons & Raids tab: search field (dungeon, boss or loot)
Audit.lua            /af releve, boss and loot records
Data/*.lua           Generated data (do not edit)
Fonts/               Cinzel, Source Sans 3, JetBrains Mono (SIL OFL)
Textures/            Class banners and icons, tree backgrounds, dungeon
                     thumbnails, maps and boss portraits, interface shapes
```

## Interface number

`## Interface: 16001` (client 1.60.1 build 70009).

## License

`LICENSE.md`: all rights reserved. You may use the addon as is, in game, for
personal use. Copying, modifying, merging, publishing, redistributing,
sublicensing and selling are prohibited without the author's written consent.
Exception: free translation addons attached to the project (extensions or
dependencies that only provide the translated texts) are allowed, under the
conditions listed in `LICENSE.md`.
Text and data mining and use by artificial intelligence are prohibited
(`noai, noimageai` notice at the top of each file, in the TOC and in
`ai.txt`).
