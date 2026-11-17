local content = require("ccb").content

-- obsoletion_and_migration/components.json

content.merge_requirement(
    content.Requirement { id = "spell_components_human_blood" }
        :component_any {
            { id = "demihuman_blood", count = 1 },
            { id = "mutant_human_blood", count = 1 },
            { id = "blood", count = 1 },
        }
)

-- recipes/requirements.json

-- 250g per unit. Crafting fur items, per 372 g of fur; 122 g + excessive weight of material is wasted, producing fur patches as byproducts.  Time needed is usually 60 minutes per unit if hand-stitching for extra material processing time.
content.merge_requirement(
    content.Requirement { id = "tailoring_glimmer_fur" }
        :component("tanned_glimmer_pelt", 1)
        :component("filament", 7, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 2, 1)
        :quality("LEATHER_AWL", 1, 1)
        :quality("CUT_FINE", 1, 1)
)

-- Copy of tailoring_cotton_patchwork with gossamer subbed in for cotton
content.merge_requirement(
    content.Requirement { id = "tailoring_gossamer_patchwork" }
        :component_any {
            { id = "sheet_gossamer", count = 1 },
            { id = "sheet_gossamer_patchwork", count = 1 },
        }
        :component("filament", 5, true)
        :quality("SEW", 1, 1)
        :quality("FABRIC_CUT", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "data_core_install" }
        :tool("data_core_slots", 1)
)

-- Copy of bronzesmithing_tools but requires non-iron hammering instead of hammering
content.merge_requirement(
    content.Requirement { id = "fey_smithing_tools" }
        :tool_any {
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 },
        }
        :quality("FEY_HAMMER", 2, 1)
        :quality("ANVIL", 2, 1)
)

-- requirements/components.json

content.merge_requirement(
    content.Requirement { id = "nails" },
    content.Requirement {}
        :component("dreamforged_nail", 1)
)

-- requirements/cooking_components.json

-- Sweet, unprocessed fruit, roughly by mass.
content.merge_requirement(
    content.Requirement { id = "sweet_fruit_fresh" },
    content.Requirement {}
        :component_any {
            { id = "hawthorn_berries", count = 1 },
            { id = "fig", count = 1 },
        }
)

-- anything you would consider a leafy green vegetable
content.merge_requirement(
    content.Requirement { id = "veggy_green" },
    content.Requirement {}
        :component("hawthorn_petals", 1)
)

-- requirements/material.json

-- Rocks that can be used for knapping.
content.merge_requirement(
    content.Requirement { id = "rock_flaking_any" },
    content.Requirement {}
        :component("obsidian_rock", 1)
)

-- requirements/melee.json

-- Any real, small weapons meant to stab someone at close range; larger shivs basically.
content.merge_requirement(
    content.Requirement { id = "real_knives" },
    content.Requirement {}
        :tool_any {
            { id = "glass_knife", count = 1 },
            { id = "dreamdross_knife", count = 1 },
            { id = "dreamforged_knife_combat", count = 1 },
            { id = "dreamforged_kris", count = 1 },
            { id = "dreamforged_kukri", count = 1 },
            { id = "dreamforged_tanto", count = 1 },
            { id = "moons_tears_knife_baselard", count = 1 },
        }
)

-- Any real, pole-like weapons designed for bashing and smashing.  Reserved for quality items.
content.merge_requirement(
    content.Requirement { id = "real_quarterstaves" },
    content.Requirement {}
        :tool_any {
            { id = "dreamdross_bo", count = 1 },
            { id = "dreamforged_q_staff", count = 1 },
            { id = "dreamforged_q_staff_exp", count = 1 },
        }
)

-- Any real great hammers.  It's got to have a big blunt end on a long pole, directly attached to it.
content.merge_requirement(
    content.Requirement { id = "real_great_hammers" },
    content.Requirement {}
        :tool_any {
            { id = "dreamforged_warhammer", count = 1 },
            { id = "dreamforged_lucerne", count = 1 },
        }
)

-- Any real, top-heavy cutting weapons with a long pole and a blade on the end, designed to swing side-to-side.  Think like a sword with a really long handle.
content.merge_requirement(
    content.Requirement { id = "real_polearms" },
    content.Requirement {}
        :tool_any {
            { id = "dreamforged_halberd", count = 1 },
            { id = "dreamforged_glaive", count = 1 },
            { id = "dreamforged_glaive_healing", count = 1 },
            { id = "dreamforged_naginata", count = 1 },
            { id = "dreamforged_lucerne", count = 1 },
        }
)

-- Any quality weapon designed to hook your opponents and their gear in a fight.  Reserved for the good stuff.
content.merge_requirement(
    content.Requirement { id = "real_hooks" },
    content.Requirement {}
        :tool_any {
            { id = "dreamforged_warhammer", count = 1 },
            { id = "dreamforged_halberd", count = 1 },
            { id = "dreamforged_glaive", count = 1 },
            { id = "dreamforged_glaive_healing", count = 1 },
            { id = "dreamforged_battleaxe", count = 1 },
            { id = "dreamforged_lucerne", count = 1 },
        }
)

-- Any weapon that features a long pole with a pointed tip at the end.  Reserved for quality weapons.
content.merge_requirement(
    content.Requirement { id = "real_spears" },
    content.Requirement {}
        :tool("dreamforged_spear", 1)
)

-- Any real, top-heavy bashing weapons with a pointy ball at the end that doesn't independently swing (those are flails).
content.merge_requirement(
    content.Requirement { id = "real_maces" },
    content.Requirement {}
        :tool_any {
            { id = "redcap_club", count = 1 },
            { id = "dreamdross_club", count = 1 },
            { id = "dreamforged_mace", count = 1 },
            { id = "dreamforged_morningstar", count = 1 },
            { id = "moons_tears_mace", count = 1 },
        }
)

-- Any real, edged short swords you could practice with, like broadswords.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side can qualify.
content.merge_requirement(
    content.Requirement { id = "real_short_swords" },
    content.Requirement {}
        :tool("dreamforged_khopesh", 1)
)

-- Any real, edged medium swords you could practice with, like cavalry sabres.  This is any sword that is bigger than a short sword, but shorter than a long sword.
content.merge_requirement(
    content.Requirement { id = "real_medium_swords" },
    content.Requirement {}
        :tool_any {
            { id = "pooka_gladius", count = 1 },
            { id = "dreamforged_arming_sword", count = 1 },
            { id = "dreamforged_broadsword", count = 1 },
            { id = "dreamforged_tsurugi_speed", count = 1 },
            { id = "moons_tears_arming_sword", count = 1 },
            { id = "moons_tears_scimitar", count = 1 },
        }
)

-- Any real, edged long swords you could practice with, like katanas, longswords, etc.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side can qualify.
content.merge_requirement(
    content.Requirement { id = "real_long_swords" },
    content.Requirement {}
        :tool_any {
            { id = "mirror_march_estoc", count = 1 },
            { id = "spring_lord_estoc", count = 1 },
            { id = "summer_lord_estoc", count = 1 },
            { id = "autumn_lord_estoc", count = 1 },
            { id = "winter_lord_estoc", count = 1 },
            { id = "dreamforged_longsword", count = 1 },
            { id = "dreamforged_katana", count = 1 },
            { id = "dreamforged_wakizashi", count = 1 },
        }
)

-- Any real, edged, big swords you could practice with, like zweihanders, greatswords, or the Dragonslayer, etc.  I reckon that anything with a straight, sharp point to it that primarily swings side-to-side, and is large enough to require a normal human to use two hands can qualify.
content.merge_requirement(
    content.Requirement { id = "real_great_swords" },
    content.Requirement {}
        :tool_any {
            { id = "dreamforged_nodachi", count = 1 },
            { id = "dreamforged_zweihander", count = 1 },
        }
)

-- Any real, quality weapon designed to be used in a thrusting fashion.  Needs to be a sword, not a spear.  This includes fencing weaponry.
content.merge_requirement(
    content.Requirement { id = "real_thrusting_swords" },
    content.Requirement {}
        :tool_any {
            { id = "mirror_march_estoc", count = 1 },
            { id = "spring_lord_estoc", count = 1 },
            { id = "summer_lord_estoc", count = 1 },
            { id = "autumn_lord_estoc", count = 1 },
            { id = "winter_lord_estoc", count = 1 },
            { id = "dreamforged_estoc", count = 1 },
            { id = "dreamforged_broadsword", count = 1 },
            { id = "dreamforged_tsurugi_speed", count = 1 },
            { id = "dreamforged_rapier", count = 1 },
        }
)

-- Any real, cutting weapons that can be used like an axe; large, heavy head with two sharp sides on a pole.
content.merge_requirement(
    content.Requirement { id = "real_great_axes" },
    content.Requirement {}
        :tool("dreamforged_battleaxe", 1)
)

-- Any weapon that features a handle and flexible lash.
content.merge_requirement(
    content.Requirement { id = "whips" },
    content.Requirement {}
        :tool("salamander_flaming_summon_whip", 1)
)

-- requirements/spell_components.json

content.merge_requirement(
    content.Requirement { id = "spell_components_changeling_dreamsparks" }
        :component("changeling_dreamspark", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_changeling_dreamsparks_2" }
        :component("changeling_dreamspark", 2)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_changeling_dreamsparks_3" }
        :component("changeling_dreamspark", 3)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_changeling_dreamsparks_4" }
        :component("changeling_dreamspark", 4)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_changeling_dreamsparks_5" }
        :component("changeling_dreamspark", 5)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_dreamdross" }
        :component("scrap_dreamdross", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_dreamdross2" }
        :component_any {
            { id = "dreamdross_lump", count = 1 },
            { id = "scrap_dreamdross", count = 10 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_dreamdross3" }
        :component_any {
            { id = "forged_dreamstuff_ingot", count = 1 },
            { id = "dreamdross_lump", count = 10 },
            { id = "scrap_dreamdross", count = 100 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_dreamer_coin" }
        :component_any {
            { id = "coin_penny", count = 1 },
            { id = "coin_nickel", count = 1 },
            { id = "coin_quarter", count = 1 },
            { id = "coin_half_dollar", count = 1 },
            { id = "coin_dollar", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_cable_whip" }
        :component("cable", 5)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_ward_off_rain" }
        :component_any {
            { id = "leaves", count = 2 },
            { id = "grape_leaves", count = 2 },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 },
            { id = "wintergreen_leaves", count = 2 },
        }
        :component_any {
            { id = "cotton_patchwork", count = 1 },
            { id = "scrap_cotton", count = 7 },
            { id = "felt_patch", count = 1 },
            { id = "scrap_felt", count = 7 },
            { id = "canvas_patch", count = 1 },
            { id = "scrap_canvas", count = 7 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_witchlight" }
        :component_any {
            { id = "lamp_oil", count = 4 },
            { id = "cooking_oil", count = 4 },
            { id = "crude_lamp_oil", count = 4 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_see_fae_necklace" }
        :component_any {
            { id = "cordage_36_leather", count = 1 },
            { id = "string_36", count = 1 },
            { id = "cordage_36", count = 1 },
            { id = "cordage_short", count = 6, requirement = true },
        }
        :component("wild_herbs", 30)
        :component("hawthorn_berries", 3)
        :component("leather", 1)
        :component_any {
            { id = "thread", count = 3 },
            { id = "sinew", count = 3 },
            { id = "plant_fibre", count = 3 },
            { id = "yarn", count = 3 },
            { id = "thread_canvas", count = 3 },
            { id = "thread_nomex", count = 6 },
            { id = "thread_kevlar", count = 6 },
        }
        :tool_any {
            { id = "needle_wood", count = 1 },
            { id = "needle_bone", count = 1 },
            { id = "needle_steel", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_light_fire" }
        :component_any {
            { id = "ash", count = 1 },
            { id = "corpse_ash", count = 1 },
        }
)

-- 1 seeds for staple grain crops (or tobacco), 3 seeds for other crops, no seeds of non-farmed crops
content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_make_plants_grow" }
        :component_any {
            { id = "seed_oats", count = 1 },
            { id = "seed_tobacco", count = 1 },
            { id = "seed_corn", count = 1 },
            { id = "seed_beans", count = 1 },
            { id = "seed_wheat", count = 1 },
            { id = "seed_lentils", count = 1 },
            { id = "seed_barley", count = 1 },
            { id = "soybean_seed", count = 1 },
            { id = "seed_buckwheat", count = 1 },
            { id = "seed_onion", count = 3 },
            { id = "seed_grapes", count = 3 },
            { id = "seed_garlic", count = 3 },
            { id = "seed_tomato", count = 3 },
            { id = "seed_celery", count = 3 },
            { id = "seed_carrot", count = 3 },
            { id = "seed_lettuce", count = 3 },
            { id = "seed_spinach", count = 3 },
            { id = "seed_mustard", count = 3 },
            { id = "seed_cabbage", count = 3 },
            { id = "seed_pumpkin", count = 3 },
            { id = "seed_broccoli", count = 3 },
            { id = "seed_zucchini", count = 3 },
            { id = "seed_eggplant", count = 3 },
            { id = "seed_cucumber", count = 3 },
            { id = "seed_sugar_beet", count = 3 },
            { id = "seed_bell_pepper", count = 3 },
            { id = "seed_chili_pepper", count = 3 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_nether_eye_paste" }
        :component("corpse_ash", 5)
        :component_any {
            { id = "edible_blood", count = 1, requirement = true },
            { id = "blood_tainted", count = 1 },
        }
        :component("wild_herbs", 20)
        :quality("FINE_GRIND", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_changeling_snare" }
        :component("yarn", 10)
        :component("splinter", 3)
        :component("blackberries", 1)
        :component("wild_herbs", 20)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_stunning_spell" }
        :component_any {
            { id = "copper", count = 2 },
            { id = "copper_ring", count = 1 },
            { id = "copper_ear", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_cure_cold_or_flu" }
        :component("scrap_cast_iron", 1)
        :component_any {
            { id = "tea_raw", count = 1 },
            { id = "tea_bag", count = 1 },
        }
        :component_any {
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 },
        }
        :component("wild_herbs", 1)
        :tool_charges("water_boiling_heat", 1, true)
        :quality("BOIL", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_luck_spell" }
        :component("coin_penny", 1)
        :component("paper", 1)
        :tool("candle_lit", 1)
        :tool_any {
            { id = "pen", charges = 4 },
            { id = "pencil", charges = 4 },
            { id = "blue_pen", charges = 4 },
            { id = "green_pen", charges = 4 },
            { id = "black_pen", charges = 4 },
            { id = "red_pen", charges = 4 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_evil_eye_ward" }
        :component("salt", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_extra_lock_door" }
        :component_any {
            { id = "string_6", count = 3 },
            { id = "cordage_6", count = 3 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_clairvoyance_cone" }
        :component("glass_shard", 3)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_increase_healing_rate" }
        :component("wild_herbs", 50)
        :component("willowbark", 4)
        :component_any {
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 },
        }
        :quality("FINE_GRIND", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_increase_bandaging_rate" }
        :component("scrap_cast_iron", 1)
        :component("salt", 10)
        :component("wild_herbs", 4)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_hide_in_forest" }
        :component_any {
            { id = "leaves", count = 1 },
            { id = "grape_leaves", count = 1 },
            { id = "young_leaves", count = 2 },
            { id = "chicory_leaves", count = 2 },
            { id = "wintergreen_leaves", count = 2 },
        }
        :component("raw_beans", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_no_nightmares" }
        :component("wild_herbs", 15)
        :component("thyme_oil", 2)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_turn_into_bear" }
        :component("skull_bear", 1)
        :component("animal_blood", 5)
        :component("raw_fur", 20)
        :component("sinew", 25)
        :quality("SEW", 2, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_walk_on_water" }
        :component_any {
            { id = "alder_bark", count = 1 },
            { id = "tanbark", count = 1 },
            { id = "birchbark", count = 1 },
            { id = "willowbark", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_bless_steel_weapon" }
        :component("salt", 15)
        :component("wild_herbs", 30)
        :tool("candle_lit", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_magic_square_four_hours" }
        :component("paper", 1)
        :tool("candle_lit", 1)
        :tool_any {
            { id = "pen", charges = 4 },
            { id = "pencil", charges = 4 },
            { id = "blue_pen", charges = 4 },
            { id = "green_pen", charges = 4 },
            { id = "black_pen", charges = 4 },
            { id = "red_pen", charges = 4 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_magic_square_six_hours" }
        :component("paper", 2)
        :tool("candle_lit", 1)
        :tool_any {
            { id = "pen", charges = 4 },
            { id = "pencil", charges = 6 },
            { id = "blue_pen", charges = 6 },
            { id = "green_pen", charges = 6 },
            { id = "black_pen", charges = 6 },
            { id = "red_pen", charges = 6 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_magic_square_eight_hours" }
        :component("paper", 2)
        :tool("candle_lit", 1)
        :tool_any {
            { id = "pen", charges = 8 },
            { id = "pencil", charges = 8 },
            { id = "blue_pen", charges = 8 },
            { id = "green_pen", charges = 8 },
            { id = "black_pen", charges = 8 },
            { id = "red_pen", charges = 8 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_magic_square_twelve_hours" }
        :component("paper", 3)
        :tool("candle_lit", 1)
        :tool_any {
            { id = "pen", charges = 12 },
            { id = "pencil", charges = 12 },
            { id = "blue_pen", charges = 12 },
            { id = "green_pen", charges = 12 },
            { id = "black_pen", charges = 12 },
            { id = "red_pen", charges = 12 },
        }
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_extinguish_fire_spell" }
        :component("ash", 2)
        :tool("spellbook_hedge_book_of_raziel", 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_chicken_sacrifice_make_rain" }
        :component("milk_standard_raw_fresh", 6, true)
        :component_any {
            { id = "honey_bottled", count = 3 },
            { id = "honey_glassed", count = 1 },
        }
        :component("wild_herbs", 20)
        :quality("CUT", 1, 1)
)

content.merge_requirement(
    content.Requirement { id = "spell_components_hedge_raziel_amulet_protection" }
        :component("worthy_wine", 3, true)
        :component("eggs_bird", 1, true)
        :component_any {
            { id = "apple", count = 1 },
            { id = "lemon", count = 1 },
        }
        :component("copper_necklace", 1)
        :quality("CUT_FINE", 1, 1)
)

-- requirements/toolsets.json

content.merge_requirement(
    content.Requirement { id = "surface_heat" },
    content.Requirement {}
        :tool_any {
            { id = "heater_tool", charges = 20 },
            { id = "item_salamander_cooking_heat", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "water_boiling_heat" },
    content.Requirement {}
        :tool_any {
            { id = "heater_tool", charges = 20 },
            { id = "item_salamander_cooking_heat", count = 1 },
        }
)

content.merge_requirement(
    content.Requirement { id = "welding_standard" },
    content.Requirement {}
        :tool_charges("inventor_welder", 10)
)

content.merge_requirement(
    content.Requirement { id = "welding_alloys" },
    content.Requirement {}
        :tool_charges("inventor_welder", 10)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_standard" },
    content.Requirement {}
        :tool_charges("inventor_welder", 100)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_alloys" },
    content.Requirement {}
        :tool_charges("inventor_welder", 100)
)

content.merge_requirement(
    content.Requirement { id = "repair_welding_rebar" },
    content.Requirement {}
        :tool_charges("inventor_welder", 400)
)

-- mutations/paraclesians/paraclesian_mutation_spells.json

-- Cotton for the Weave Gossamer spell
content.merge_requirement(
    content.Requirement { id = "spell_components_paraclesian_spell_make_gossamer" }
        :component_any {
            { id = "cotton_patchwork", count = 8 },
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_cotton_patchwork", count = 1 },
        }
)
