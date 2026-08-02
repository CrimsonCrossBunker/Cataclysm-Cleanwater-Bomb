# Legacy Markdown classification report

This file is generated from `markdown-inventory.yml`; do not edit it by hand.

- Frozen source commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
- Documents: **175**
- Remaining `review` actions: **0**
- Rejected contributor identities: **157**
- `obj-lua/` is outside the tracked inventory and was not traversed.

## Actions

| Value | Count |
| --- | ---: |
| `archive_public` | 7 |
| `generated_reference` | 4 |
| `keep_in_repo` | 57 |
| `merge_into` | 15 |
| `migrate_preserve` | 35 |
| `migrate_rewrite` | 50 |
| `retain_third_party` | 7 |

## Migration status

| Value | Count |
| --- | ---: |
| `classified` | 163 |
| `verified` | 12 |

## Domains

| Value | Count |
| --- | ---: |
| `architecture` | 1 |
| `build` | 9 |
| `content` | 2 |
| `cpp` | 6 |
| `design` | 14 |
| `eoc` | 2 |
| `governance` | 8 |
| `historical` | 1 |
| `json` | 47 |
| `localization` | 4 |
| `lore` | 5 |
| `lua` | 3 |
| `mods` | 48 |
| `release` | 3 |
| `resources` | 2 |
| `testing` | 3 |
| `third-party` | 7 |
| `tooling` | 1 |
| `translation` | 4 |
| `ui` | 4 |
| `upstream` | 1 |

## Priorities

| Value | Count |
| --- | ---: |
| `P0` | 38 |
| `P1` | 71 |
| `P2` | 49 |
| `P3` | 17 |

## Documents

| Original path | Stable ID | Action | Status | Priority | Batch | Target |
| --- | --- | --- | --- | --- | --- | --- |
| `CODE_OF_CONDUCT.md` | `governance.code-of-conduct` | `keep_in_repo` | `verified` | `P0` | `—` | `CODE_OF_CONDUCT.md` |
| `CONTRIBUTING.md` | `governance.contributing` | `keep_in_repo` | `verified` | `P0` | `—` | `CONTRIBUTING.md` |
| `ISSUES.md` | `governance.issue-workflow` | `keep_in_repo` | `verified` | `P0` | `—` | `ISSUES.md` |
| `README.md` | `project.readme` | `keep_in_repo` | `verified` | `P0` | `—` | `README.md` |
| `SYNC_EXCLUDED_PRS.md` | `upstream.excluded-prs` | `keep_in_repo` | `verified` | `P1` | `—` | `SYNC_EXCLUDED_PRS.md` |
| `TRANSLATION_CREDITS.md` | `translation.credits` | `keep_in_repo` | `verified` | `P2` | `—` | `TRANSLATION_CREDITS.md` |
| `data/json/LOADING_ORDER.md` | `legacy.data-json-loading-order` | `merge_into` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/loading-order.md` |
| `data/json/npcs/godco/NECC_INFO.md` | `content.npc.godco-roster` | `keep_in_repo` | `classified` | `P2` | `phase-2-content` | `data/json/npcs/godco/NECC_INFO.md` |
| `data/json/npcs/refugee_center/FREE_MERCHANTS_INFO.md` | `content.npc.free-merchants-economy` | `keep_in_repo` | `classified` | `P2` | `phase-2-content` | `data/json/npcs/refugee_center/FREE_MERCHANTS_INFO.md` |
| `data/lua/README.md` | `lua.v5.overview` | `migrate_rewrite` | `classified` | `P0` | `phase-0-lua` | `docs/zh_CN/api/lua/v5/overview.md` |
| `data/lua/examples/api_v5_mod/README.md` | `lua.v5.example-mod` | `migrate_rewrite` | `classified` | `P0` | `phase-0-lua` | `docs/zh_CN/api/lua/v5/example-mod.md` |
| `data/mods/Backrooms/README.md` | `mods.backrooms.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/Backrooms/README.md` |
| `data/mods/BombasticPerks/docs/contributing.md` | `mods.bombastic-perks.contributing` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/BombasticPerks/docs/contributing.md` |
| `data/mods/BombasticPerks/docs/expanding_with_mods.md` | `mods.bombastic-perks.extension-contract` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/BombasticPerks/docs/expanding_with_mods.md` |
| `data/mods/DinoMod/DESIGN.md` | `mods.dinomod.design` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/DinoMod/DESIGN.md` |
| `data/mods/DinoMod/README.md` | `mods.dinomod.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/DinoMod/README.md` |
| `data/mods/MA/README.md` | `mods.massachusetts.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/MA/README.md` |
| `data/mods/Magiclysm/lore.md` | `mods.magiclysm.lore` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/Magiclysm/lore.md` |
| `data/mods/Magiclysm/magic_balance.md` | `mods.magiclysm.balance` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/Magiclysm/magic_balance.md` |
| `data/mods/Megafauna/readme.md` | `mods.megafauna.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/Megafauna/readme.md` |
| `data/mods/MindOverMatter/GainingPowerSpoilers.md` | `mods.mind-over-matter.gaining-powers` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/MindOverMatter/GainingPowerSpoilers.md` |
| `data/mods/MindOverMatter/NetherAttunementSpoilers.md` | `mods.mind-over-matter.nether-attunement` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/MindOverMatter/NetherAttunementSpoilers.md` |
| `data/mods/MindOverMatter/NewPowerGuide.md` | `mods.mind-over-matter.new-power-guide` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/MindOverMatter/NewPowerGuide.md` |
| `data/mods/MindOverMatter/PowerDescriptionSpoilers.md` | `mods.mind-over-matter.power-reference` | `generated_reference` | `classified` | `P1` | `phase-1-mods` | `docs/zh_CN/data/mods/MindOverMatter/PowerDescriptionSpoilers.md` |
| `data/mods/MindOverMatter/README.md` | `mods.mind-over-matter.overview` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/MindOverMatter/README.md` |
| `data/mods/MindOverMatter/lore_spoilers.md` | `mods.mind-over-matter.lore` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/MindOverMatter/lore_spoilers.md` |
| `data/mods/MindOverMatterNoKnacks/README.md` | `mods.mind-over-matter.no-knacks` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/MindOverMatterNoKnacks/README.md` |
| `data/mods/No_Hope/CONTRIBUTING.md` | `mods.no-hope.contributing` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/No_Hope/CONTRIBUTING.md` |
| `data/mods/No_Hope/DIFFICULTY_OPTIONS.md` | `mods.no-hope.difficulty-options` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/No_Hope/DIFFICULTY_OPTIONS.md` |
| `data/mods/Sky_Island/README.md` | `mods.sky-island.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/Sky_Island/README.md` |
| `data/mods/Sorcerer/README.md` | `mods.sorcerer.overview` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/Sorcerer/README.md` |
| `data/mods/TEST_DATA/README.md` | `testing.test-data-mod` | `keep_in_repo` | `classified` | `P0` | `phase-0-testing` | `data/mods/TEST_DATA/README.md` |
| `data/mods/XedraWood/README.md` | `mods.xedra-wood.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/XedraWood/README.md` |
| `data/mods/Xedra_Evolved/README.md` | `mods.xedra-evolved.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/Xedra_Evolved/README.md` |
| `data/mods/Xedra_Evolved/design_doc_spoilers.md` | `mods.xedra-evolved.design` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/Xedra_Evolved/design_doc_spoilers.md` |
| `data/mods/Xedra_Evolved/vampire_guide.md` | `mods.xedra-evolved.vampire-guide` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/Xedra_Evolved/vampire_guide.md` |
| `data/mods/aftershock_exoplanet/doc/Hacking.md` | `mods.aftershock-exoplanet.hacking` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/aftershock_exoplanet/doc/Hacking.md` |
| `data/mods/aftershock_exoplanet/doc/crafting_system.md` | `mods.aftershock-exoplanet.crafting-system` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/aftershock_exoplanet/doc/crafting_system.md` |
| `data/mods/aftershock_exoplanet/doc/lore/cyberpunk_future.md` | `mods.aftershock-exoplanet.lore.cyberpunk-future` | `merge_into` | `classified` | `P3` | `phase-3-mods` | `docs/zh_CN/data/mods/aftershock_exoplanet/doc/lore/organizations.md` |
| `data/mods/aftershock_exoplanet/doc/lore/factions.md` | `mods.aftershock-exoplanet.lore.factions` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/aftershock_exoplanet/doc/lore/factions.md` |
| `data/mods/aftershock_exoplanet/doc/lore/organizations.md` | `mods.aftershock-exoplanet.lore.organizations` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/aftershock_exoplanet/doc/lore/organizations.md` |
| `data/mods/aftershock_exoplanet/doc/lore/points_of_interest.md` | `mods.aftershock-exoplanet.lore.points-of-interest` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/aftershock_exoplanet/doc/lore/points_of_interest.md` |
| `data/mods/aftershock_exoplanet/doc/lore/ranged_weapon_balance.md` | `mods.aftershock-exoplanet.balance.ranged-weapons` | `generated_reference` | `classified` | `P1` | `phase-1-mods` | `docs/zh_CN/data/mods/aftershock_exoplanet/doc/lore/ranged_weapon_balance.md` |
| `data/mods/aftershock_exoplanet/doc/lore/salus_4.md` | `mods.aftershock-exoplanet.lore.salus-iv` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/aftershock_exoplanet/doc/lore/salus_4.md` |
| `data/mods/aftershock_exoplanet/doc/lore/timeline.md` | `mods.aftershock-exoplanet.lore.timeline` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/aftershock_exoplanet/doc/lore/timeline.md` |
| `data/mods/aftershock_exoplanet/doc/suit_operating_time.md` | `mods.aftershock-exoplanet.balance.powered-armor` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/aftershock_exoplanet/doc/suit_operating_time.md` |
| `data/mods/aftershock_exoplanet/items/armor/exosuit/exosuit_guide.md` | `mods.aftershock-exoplanet.exosuit-guide` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/aftershock_exoplanet/items/armor/exosuit/exosuit_guide.md` |
| `data/mods/alt_map_key/README.md` | `mods.alternative-map-key.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/alt_map_key/README.md` |
| `data/mods/classic_zombies/design-doc.md` | `mods.classic-zombies.design` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/classic_zombies/design-doc.md` |
| `data/mods/classic_zombies/place_names.md` | `mods.classic-zombies.place-names` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/classic_zombies/place_names.md` |
| `data/mods/hunvre/documentation/lore.md` | `mods.hunvre.lore` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/hunvre/documentation/lore.md` |
| `data/mods/hunvre/progress_tracker.md` | `mods.hunvre.progress` | `keep_in_repo` | `classified` | `P3` | `phase-3-mods` | `data/mods/hunvre/progress_tracker.md` |
| `data/mods/immortal_path/GLOSSARY.md` | `mods.immortal-path.glossary` | `keep_in_repo` | `classified` | `P0` | `phase-0-mods` | `data/mods/immortal_path/GLOSSARY.md` |
| `data/mods/immortal_path/LANGUAGE_CONVENTION.md` | `mods.immortal-path.language-convention` | `keep_in_repo` | `classified` | `P0` | `phase-0-translation` | `data/mods/immortal_path/LANGUAGE_CONVENTION.md` |
| `data/mods/immortal_path/doc/game-design.md` | `mods.immortal-path.game-design` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/immortal_path/doc/game-design.md` |
| `data/mods/immortal_path/doc/lore.md` | `mods.immortal-path.lore` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/immortal_path/doc/lore.md` |
| `data/mods/immortal_path/doc/spell-design.md` | `mods.immortal-path.spell-design` | `keep_in_repo` | `classified` | `P1` | `phase-1-mods` | `data/mods/immortal_path/doc/spell-design.md` |
| `data/mods/innawood/readme.md` | `mods.innawood.overview` | `keep_in_repo` | `classified` | `P2` | `phase-2-mods` | `data/mods/innawood/readme.md` |
| `data/mods/translate-dialogue/README.md` | `mods.translate-dialogue.maintenance` | `keep_in_repo` | `classified` | `P1` | `phase-1-translation` | `data/mods/translate-dialogue/README.md` |
| `doc/ASCII_ART.md` | `content.ascii-art` | `migrate_rewrite` | `classified` | `P2` | `phase-2-ui` | `docs/zh_CN/content/ascii-art.md` |
| `doc/CHANGELOG_GUIDELINES.md` | `contributing.changelog-guidelines` | `keep_in_repo` | `classified` | `P1` | `phase-1-release` | `doc/CHANGELOG_GUIDELINES.md` |
| `doc/DEVELOPER_FAQ.md` | `contributing.developer-faq` | `merge_into` | `classified` | `P1` | `phase-1-architecture` | `docs/zh_CN/how-to/common-tasks.md` |
| `doc/FREQUENTLY_MADE_SUGGESTIONS.md` | `design.frequently-made-suggestions` | `migrate_rewrite` | `classified` | `P1` | `phase-1-design` | `docs/zh_CN/design/frequently-made-suggestions.md` |
| `doc/GUN_NAMING_AND_INCLUSION.md` | `content.firearms-naming-and-inclusion` | `migrate_rewrite` | `classified` | `P2` | `phase-2-design` | `docs/zh_CN/content/firearms/naming-and-inclusion.md` |
| `doc/HOWTO_MASSAGE_MA_GUN_DATA.md` | `archive.firearms-massachusetts-data-workflow` | `archive_public` | `classified` | `P3` | `phase-3-historical` | `docs/zh_CN/archive/firearms/massachusetts-data-workflow.md` |
| `doc/HOW_YOU_CAN_HELP.md` | `getting-started.how-you-can-help` | `merge_into` | `classified` | `P0` | `phase-0-governance` | `docs/zh_CN/getting-started/first-contribution.md` |
| `doc/IN_REPO_MODS.md` | `mods.in-repository-policy` | `migrate_rewrite` | `classified` | `P1` | `phase-1-mods` | `docs/zh_CN/mods/in-repository-policy.md` |
| `doc/ISSUE_TRIAGE.md` | `maintainers.issue-triage` | `migrate_rewrite` | `classified` | `P1` | `phase-1-governance` | `docs/zh_CN/maintainers/issue-triage.md` |
| `doc/JSON/ARTIFACTS.md` | `json.artifacts` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/artifacts.md` |
| `doc/JSON/BASECAMP.md` | `json.basecamp` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/basecamp.md` |
| `doc/JSON/CLIMBING.md` | `json.climbing-aids` | `migrate_preserve` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/reference/json/climbing-aids.md` |
| `doc/JSON/DIMENSIONS.md` | `json.dimensions` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/dimensions.md` |
| `doc/JSON/EFFECTS_JSON.md` | `json.effects` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/effects.md` |
| `doc/JSON/EFFECT_ON_CONDITION.md` | `eoc.reference` | `migrate_preserve` | `classified` | `P0` | `phase-0-eoc` | `docs/zh_CN/reference/eoc/index.md` |
| `doc/JSON/EXAMINE.md` | `json.examine-actions` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/examine-actions.md` |
| `doc/JSON/FACTIONS.md` | `json.npc-factions` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/npc-factions.md` |
| `doc/JSON/FACTION_MISSIONS.md` | `json.faction-missions` | `migrate_preserve` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/reference/json/faction-missions.md` |
| `doc/JSON/GUIDE_COMESTIBLES.md` | `json.comestibles-placement` | `migrate_rewrite` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/how-to/json/comestibles.md` |
| `doc/JSON/HELP_MENU.md` | `json.help-menu` | `migrate_preserve` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/reference/json/help-menu.md` |
| `doc/JSON/ITEM.md` | `json.items` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/items/index.md` |
| `doc/JSON/ITEM_CRAFT_AND_DISASSEMBLY.md` | `json.recipes-and-disassembly` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/recipes-and-disassembly.md` |
| `doc/JSON/ITEM_SPAWN.md` | `json.item-groups` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/item-groups.md` |
| `doc/JSON/JSON_FLAGS.md` | `json.flags` | `generated_reference` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/generated/flags.md` |
| `doc/JSON/JSON_INFO.md` | `json.object-types` | `migrate_rewrite` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/index.md` |
| `doc/JSON/JSON_INHERITANCE.md` | `json.inheritance` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/inheritance.md` |
| `doc/JSON/JSON_LOADING_ORDER.md` | `legacy.doc-json-json-loading-order` | `merge_into` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/loading-order.md` |
| `doc/JSON/JSON_Mapping_Guides/Guide_for_beginning_mapgen.md` | `tutorial.mapgen-beginner` | `migrate_rewrite` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/tutorials/json-mapgen/beginner.md` |
| `doc/JSON/JSON_Mapping_Guides/Guide_for_intermediate_mapgen.md` | `tutorial.mapgen-intermediate` | `migrate_rewrite` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/tutorials/json-mapgen/intermediate.md` |
| `doc/JSON/JSON_Mapping_Guides/JSON_ROOF_MAPGEN.md` | `tutorial.mapgen-roofs` | `merge_into` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/tutorials/json-mapgen/beginner.md` |
| `doc/JSON/JSON_STYLE.md` | `contributing.json-style` | `migrate_rewrite` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/contributing/json-style.md` |
| `doc/JSON/JSON_TOOLS.md` | `how-to.json-tools` | `migrate_rewrite` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/how-to/json/tools.md` |
| `doc/JSON/MAGIC.md` | `json.magic-spells-enchantments` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/magic-spells-enchantments.md` |
| `doc/JSON/MAPGEN.md` | `json.mapgen` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/mapgen.md` |
| `doc/JSON/MAP_SMASHING.md` | `json.map-smashing` | `merge_into` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/reference/json/terrain-and-furniture.md` |
| `doc/JSON/MARTIALART_JSON.md` | `json.martial-arts` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/martial-arts.md` |
| `doc/JSON/MISSIONS_JSON.md` | `json.missions` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/missions.md` |
| `doc/JSON/MONSTERS.md` | `json.monsters` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/monsters.md` |
| `doc/JSON/MONSTER_SPECIAL_ATTACKS.md` | `json.monster-special-attacks` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/monster-special-attacks.md` |
| `doc/JSON/MOVE_MODE.md` | `json.movement-modes` | `migrate_preserve` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/reference/json/movement-modes.md` |
| `doc/JSON/MUTATIONS.md` | `json.mutations` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/mutations.md` |
| `doc/JSON/NPCs.md` | `json.npcs-dialogue` | `migrate_preserve` | `classified` | `P0` | `phase-0-eoc` | `docs/zh_CN/reference/eoc/npcs-and-dialogue.md` |
| `doc/JSON/OBSOLETION_AND_MIGRATION.md` | `json.obsoletion-and-migration` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/obsoletion-and-migration.md` |
| `doc/JSON/OPTIONS.md` | `json.options` | `migrate_preserve` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/reference/json/options.md` |
| `doc/JSON/OVERMAP.md` | `json.overmap` | `migrate_preserve` | `classified` | `P0` | `phase-0-json` | `docs/zh_CN/reference/json/overmap.md` |
| `doc/JSON/PRACTICE_RECIPES.md` | `json.practice-recipes` | `migrate_preserve` | `classified` | `P2` | `phase-2-json` | `docs/zh_CN/reference/json/practice-recipes.md` |
| `doc/JSON/PROFICIENCY.md` | `json.proficiencies` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/proficiencies.md` |
| `doc/JSON/PROFICIENCY_LIST.md` | `json.proficiencies-index` | `generated_reference` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/generated/proficiencies.md` |
| `doc/JSON/REGION_LAYOUT.md` | `json.region-layout` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/region-layout.md` |
| `doc/JSON/REGION_SETTINGS.md` | `json.region-settings` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/region-settings.md` |
| `doc/JSON/TER_FURN_TRANSFORM.md` | `json.terrain-furniture-transforms` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/terrain-furniture-transforms.md` |
| `doc/JSON/VEHICLES_JSON.md` | `json.vehicle-prototypes` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/vehicle-prototypes.md` |
| `doc/JSON/VITAMIN.md` | `json.vitamins` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/vitamins.md` |
| `doc/JSON/WEATHER_TYPE.md` | `json.weather-types` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/weather-types.md` |
| `doc/JSON/WOUNDS.md` | `json.wounds` | `migrate_preserve` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/reference/json/wounds.md` |
| `doc/MANUAL_OF_STYLE.md` | `content.manual-of-style` | `migrate_rewrite` | `classified` | `P1` | `phase-1-translation` | `docs/zh_CN/contributing/in-game-text-style.md` |
| `doc/MODDING.md` | `modding-overview` | `migrate_rewrite` | `classified` | `P0` | `phase-0-mods` | `docs/zh_CN/modding/overview.md` |
| `doc/MOD_COMPATIBILITY.md` | `mod-compatibility` | `migrate_rewrite` | `classified` | `P0` | `phase-0-mods` | `docs/zh_CN/modding/compatibility.md` |
| `doc/PLAYER_ACTIVITY.md` | `cpp-activities` | `migrate_rewrite` | `classified` | `P1` | `phase-1-cpp` | `docs/zh_CN/cpp/activities.md` |
| `doc/RELEASE_DIFF.md` | `legacy.doc-release-diff` | `merge_into` | `classified` | `P1` | `phase-1-release` | `docs/zh_CN/maintenance/releases.md` |
| `doc/RELEASE_PROCESS.md` | `legacy.doc-release-process` | `merge_into` | `classified` | `P1` | `phase-1-release` | `docs/zh_CN/maintenance/releases.md` |
| `doc/SOUNDPACKS.md` | `soundpacks` | `migrate_rewrite` | `classified` | `P2` | `phase-2-resources` | `docs/zh_CN/resources/soundpacks.md` |
| `doc/TESTING_YOUR_CHANGES.md` | `testing-manual` | `merge_into` | `classified` | `P0` | `phase-0-testing` | `docs/zh_CN/testing/manual-playtesting.md` |
| `doc/TILESET.md` | `tilesets` | `migrate_rewrite` | `classified` | `P2` | `phase-2-resources` | `docs/zh_CN/resources/tilesets.md` |
| `doc/TRANSLATING.md` | `translation-guide` | `migrate_rewrite` | `classified` | `P0` | `phase-0-localization` | `docs/zh_CN/localization/translation-guide.md` |
| `doc/TRANSLATING_MOD.md` | `mod-localization` | `merge_into` | `classified` | `P1` | `phase-1-localization` | `docs/zh_CN/modding/localization.md` |
| `doc/USER_INTERFACE_AND_ACCESSIBILITY.md` | `ui-accessibility` | `migrate_rewrite` | `classified` | `P1` | `phase-1-ui` | `docs/zh_CN/ui/accessibility.md` |
| `doc/WIDGETS.md` | `json-widgets` | `migrate_rewrite` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/json/widgets.md` |
| `doc/c++/CODE_STYLE.md` | `cpp-code-style` | `migrate_rewrite` | `classified` | `P0` | `phase-0-cpp` | `docs/zh_CN/cpp/code-style.md` |
| `doc/c++/COMPILER_SUPPORT.md` | `platform-matrix` | `migrate_rewrite` | `classified` | `P0` | `phase-0-build` | `docs/zh_CN/platforms/compiler-support.md` |
| `doc/c++/COMPILING-CMAKE-VCPKG.md` | `legacy.doc-c-compiling-cmake-vcpkg` | `merge_into` | `classified` | `P0` | `phase-0-build` | `docs/zh_CN/build/windows-msvc.md` |
| `doc/c++/COMPILING-CMAKE.md` | `build-cmake` | `migrate_rewrite` | `classified` | `P0` | `phase-0-build` | `docs/zh_CN/build/cmake.md` |
| `doc/c++/COMPILING-CYGWIN.md` | `archive-build-cygwin` | `archive_public` | `classified` | `P3` | `phase-3-build` | `docs/zh_CN/archive/build/cygwin.md` |
| `doc/c++/COMPILING-DEVCONTAINER.md` | `build-devcontainer` | `migrate_rewrite` | `classified` | `P1` | `phase-1-build` | `docs/zh_CN/build/devcontainer.md` |
| `doc/c++/COMPILING-FLATPAK.md` | `archive-build-flatpak` | `archive_public` | `classified` | `P3` | `phase-3-build` | `docs/zh_CN/archive/build/flatpak.md` |
| `doc/c++/COMPILING-MSYS.md` | `build-windows-msys2` | `migrate_rewrite` | `classified` | `P0` | `phase-0-build` | `docs/zh_CN/build/windows-msys2.md` |
| `doc/c++/COMPILING-VS-VCPKG.md` | `build-windows-msvc` | `migrate_rewrite` | `classified` | `P0` | `phase-0-build` | `docs/zh_CN/build/windows-msvc.md` |
| `doc/c++/COMPILING.md` | `build-overview` | `migrate_rewrite` | `classified` | `P0` | `phase-0-build` | `docs/zh_CN/build/overview.md` |
| `doc/c++/DEVELOPER_TOOLING.md` | `developer-tooling` | `migrate_rewrite` | `classified` | `P1` | `phase-1-cpp` | `docs/zh_CN/cpp/developer-tooling.md` |
| `doc/c++/JSON_INTERFACE.md` | `cpp-json-interface` | `migrate_rewrite` | `classified` | `P1` | `phase-1-cpp` | `docs/zh_CN/cpp/json-interface.md` |
| `doc/c++/PERFORMANCE.md` | `cpp-performance` | `migrate_rewrite` | `classified` | `P1` | `phase-1-cpp` | `docs/zh_CN/cpp/performance.md` |
| `doc/c++/POINTS_COORDINATES.md` | `cpp-coordinates` | `migrate_rewrite` | `classified` | `P1` | `phase-1-cpp` | `docs/zh_CN/cpp/coordinates.md` |
| `doc/c++/TESTING.md` | `cpp-testing` | `migrate_rewrite` | `classified` | `P0` | `phase-0-testing` | `docs/zh_CN/testing/cpp.md` |
| `doc/design-balance-lore/ARMOR_BALANCE_AND_DESIGN.md` | `json-armor-design` | `migrate_rewrite` | `classified` | `P2` | `phase-2-design` | `docs/zh_CN/json/armor-design.md` |
| `doc/design-balance-lore/CONSTRUCTION_BALANCE.md` | `archive-construction-balance` | `archive_public` | `classified` | `P3` | `phase-3-design` | `docs/zh_CN/archive/design/construction-balance.md` |
| `doc/design-balance-lore/GAME_BALANCE.md` | `legacy.doc-design-balance-lore-game-balance` | `merge_into` | `classified` | `P1` | `phase-1-design` | `docs/zh_CN/design/balance.md` |
| `doc/design-balance-lore/LORE_FAQ.md` | `archive-lore-faq` | `archive_public` | `classified` | `P3` | `phase-3-lore` | `docs/zh_CN/archive/lore/faq.md` |
| `doc/design-balance-lore/PORTAL_STORM_BALANCE_AND_DESIGN.md` | `design-portal-storms` | `migrate_rewrite` | `classified` | `P2` | `phase-2-design` | `docs/zh_CN/design/portal-storms.md` |
| `doc/design-balance-lore/POSTAPOC_PRICE_GUIDE.md` | `json-item-pricing` | `migrate_rewrite` | `classified` | `P2` | `phase-2-design` | `docs/zh_CN/json/item-pricing.md` |
| `doc/design-balance-lore/STEEL_CRAFTING.md` | `design-steel-crafting` | `migrate_rewrite` | `classified` | `P2` | `phase-2-design` | `docs/zh_CN/design/steel-crafting.md` |
| `doc/design-balance-lore/VARIANTS.md` | `json-item-variants` | `migrate_rewrite` | `classified` | `P1` | `phase-1-json` | `docs/zh_CN/json/item-variants.md` |
| `doc/design-balance-lore/batteries_and_electricity.md` | `design-batteries-electricity` | `migrate_rewrite` | `classified` | `P2` | `phase-2-design` | `docs/zh_CN/design/batteries-electricity.md` |
| `doc/design-balance-lore/design-balance.md` | `design-balance` | `migrate_rewrite` | `classified` | `P1` | `phase-1-design` | `docs/zh_CN/design/balance.md` |
| `doc/design-balance-lore/design-doc.md` | `design-overview` | `merge_into` | `classified` | `P1` | `phase-1-design` | `docs/zh_CN/design/overview.md` |
| `doc/design-balance-lore/design-gameplay.md` | `design-gameplay` | `migrate_rewrite` | `classified` | `P1` | `phase-1-design` | `docs/zh_CN/design/gameplay.md` |
| `doc/design-balance-lore/design-user-experience.md` | `design-user-experience` | `migrate_rewrite` | `classified` | `P1` | `phase-1-design` | `docs/zh_CN/design/user-experience.md` |
| `doc/design-balance-lore/lore-background.md` | `lore-background` | `migrate_rewrite` | `classified` | `P2` | `phase-2-lore` | `docs/zh_CN/lore/background.md` |
| `doc/design-balance-lore/lore-factions.md` | `lore-factions` | `migrate_rewrite` | `classified` | `P2` | `phase-2-lore` | `docs/zh_CN/lore/factions.md` |
| `doc/design-balance-lore/lore.md` | `lore-overview` | `migrate_rewrite` | `classified` | `P2` | `phase-2-lore` | `docs/zh_CN/lore/overview.md` |
| `doc/design-balance-lore/melee_weapons/MELEE_BALANCE_SPREADSHEET.md` | `archive-melee-balance-spreadsheet` | `archive_public` | `classified` | `P3` | `phase-3-design` | `docs/zh_CN/archive/design/melee-balance-spreadsheet.md` |
| `doc/design-balance-lore/technology.md` | `lore-technology` | `migrate_rewrite` | `classified` | `P2` | `phase-2-lore` | `docs/zh_CN/lore/technology.md` |
| `doc/development_process.md` | `archive-upstream-development-process` | `archive_public` | `classified` | `P3` | `phase-3-governance` | `docs/zh_CN/archive/governance/development-process.md` |
| `doc/reviewing_PR_guide.md` | `pr-review-guide` | `migrate_rewrite` | `classified` | `P0` | `phase-0-governance` | `docs/zh_CN/contributing/pr-review.md` |
| `doc/user-guides/COLOR.md` | `ui-colors` | `migrate_rewrite` | `classified` | `P2` | `phase-2-ui` | `docs/zh_CN/ui/colors.md` |
| `doc/user-guides/FONT_OPTIONS.md` | `ui-fonts` | `migrate_rewrite` | `classified` | `P2` | `phase-2-ui` | `docs/zh_CN/ui/fonts.md` |
| `lang/notes/README_all_translators.md` | `legacy.lang-notes-readme-all-translators` | `merge_into` | `classified` | `P1` | `phase-1-localization` | `docs/zh_CN/localization/translation-guide.md` |
| `lang/notes/ru-notes.md` | `translation-notes-ru` | `keep_in_repo` | `classified` | `P3` | `phase-3-localization` | `lang/notes/ru-notes.md` |
| `src/lua/LICENSE.md` | `third-party.src-lua-license` | `retain_third_party` | `verified` | `P3` | `—` | `src/lua/LICENSE.md` |
| `src/lua/README.md` | `vendor-lua-runtime-provenance` | `retain_third_party` | `classified` | `P3` | `phase-3-third-party` | `src/lua/README.md` |
| `src/third-party/snmalloc/README.md` | `third-party.src-third-party-snmalloc-readme` | `retain_third_party` | `verified` | `P3` | `—` | `src/third-party/snmalloc/README.md` |
| `src/third-party/snmalloc/stl/README.md` | `third-party.src-third-party-snmalloc-stl-readme` | `retain_third_party` | `verified` | `P3` | `—` | `src/third-party/snmalloc/stl/README.md` |
| `src/third-party/snmalloc/stl/cxx/README.md` | `third-party.src-third-party-snmalloc-stl-cxx-readme` | `retain_third_party` | `verified` | `P3` | `—` | `src/third-party/snmalloc/stl/cxx/README.md` |
| `src/third-party/snmalloc/stl/gnu/README.md` | `third-party.src-third-party-snmalloc-stl-gnu-readme` | `retain_third_party` | `verified` | `P3` | `—` | `src/third-party/snmalloc/stl/gnu/README.md` |
| `src/third-party/zstd/README.md` | `third-party.src-third-party-zstd-readme` | `retain_third_party` | `verified` | `P3` | `—` | `src/third-party/zstd/README.md` |
| `tools/llama/README.md` | `tool-llama-build-acceleration` | `keep_in_repo` | `classified` | `P2` | `phase-2-tooling` | `tools/llama/README.md` |
| `tools/lua_api/README.md` | `tool-lua-api-coverage` | `keep_in_repo` | `classified` | `P0` | `phase-0-lua` | `tools/lua_api/README.md` |
