local ccb = require("ccb")
local content = ccb.content

-- Native recipe groups
do
local definition = content.RecipeGroup {
    id = "fbbb_crafting_recipes_custom",
    building_type = "BASE",
}
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbbb_crafting_recipes_basic",
    building_type = "BASE",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder (camp crafting fire fuel)"))
definition:recipe("pointy_stick", ccb.content.text(" Craft: Pointy Sticks"))
definition:recipe("wood_panel_from nailed planks", ccb.content.text(" Craft: Wooden Panel, Nailed Planks"))
definition:recipe("wood_panel_from wooden beams", ccb.content.text(" Craft: Wooden Panel, Wooden Beams"))
definition:recipe("wood_beam_from logs", ccb.content.text(" Craft: Wooden Beam"))
definition:recipe("2x4_from logs", ccb.content.text(" Craft: Wooden Plank"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbbb_crafting_recipes_cooking",
    building_type = "BASE",
}
definition:recipe("meat_cooked", ccb.content.text(" Cook: Meat, Cooked"))
definition:recipe("fish_cooked", ccb.content.text(" Cook: Fish, Cooked"))
definition:recipe("veggy_cooked", ccb.content.text(" Cook: Veggy, Cooked"))
definition:recipe("boiled_egg", ccb.content.text(" Cook: Egg, Boiled"))
definition:recipe("starch", ccb.content.text(" Cook: Starch"))
definition:recipe("starch_from_fibrous_stuff", ccb.content.text(" Cook: Cattail Starch"))
definition:recipe("flatbread", ccb.content.text(" Cook: Flatbread"))
definition:recipe("veggy_wild_cooked", ccb.content.text(" Cook: Veggy, Cooked Wild"))
definition:recipe("flour", ccb.content.text(" Cook: Flour"))
definition:recipe("salt", ccb.content.text(" Cook: Salt"))
definition:recipe("bread", ccb.content.text(" Cook: Bread"))
definition:recipe("fruit_leather", ccb.content.text(" Cook: Fruit Leather"))
definition:recipe("jerky", ccb.content.text(" Cook: Meat Jerky"))
definition:recipe("mushroom_cooked", ccb.content.text(" Cook: Mushroom, Cooked"))
definition:recipe("tallow", ccb.content.text(" Cook: Tallow"))
definition:recipe("cornmeal", ccb.content.text(" Cook: Cornmeal"))
definition:recipe("meat_smoked", ccb.content.text(" Cook: Meat, Smoked"))
definition:recipe("fish_smoked", ccb.content.text(" Cook: Fish, Smoked"))
definition:recipe("dry_mushroom", ccb.content.text(" Cook: Mushroom, Dried"))
definition:recipe("dry_fruit", ccb.content.text(" Cook: Fruit, Dehydrated"))
definition:recipe("sausage", ccb.content.text(" Cook: Sausage"))
definition:recipe("sausage_wasteland", ccb.content.text(" Cook: Sausage, Wasteland"))
definition:recipe("pie_meat", ccb.content.text(" Cook: Meat Pie"))
definition:recipe("pie_veggy", ccb.content.text(" Cook: Veggy Pie"))
definition:recipe("sugar", ccb.content.text(" Cook: Sugar"))
definition:recipe("hardtack", ccb.content.text(" Cook: Hardtack"))
definition:recipe("veggy_pickled_jarred", ccb.content.text(" Cook: Veggy, Pickled"))
definition:recipe("cheese_hard", ccb.content.text(" Cook: Cheese, Hard"))
definition:recipe("pemmican", ccb.content.text(" Cook: Pemmican, Meat + Berries"))
definition:recipe("pemmican_veggy", ccb.content.text(" Cook: Pemmican, Meat + Veg"))
definition:recipe("veggy_aspic", ccb.content.text(" Cook: Veggy Aspic"))
definition:recipe("meat_canned_jarred", ccb.content.text(" Cook: Meat, Canned"))
definition:recipe("meat_aspic", ccb.content.text(" Cook: Meat Aspic"))
definition:recipe("kompot", ccb.content.text(" Cook: Kompot"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbbb_crafting_recipes_crafting",
    building_type = "BASE",
}
definition:recipe("brick", ccb.content.text(" Craft: Brick"))
definition:recipe("clay_canister", ccb.content.text(" Craft: Canister, Clay"))
definition:recipe("crucible_clay", ccb.content.text(" Craft: Crucible, Clay"))
definition:recipe("fire_brick", ccb.content.text(" Craft: Brick, Fire"))
definition:recipe("pebble_clay", ccb.content.text(" Craft: Pellet, Clay"))
definition:recipe("scrap_copper", ccb.content.text(" Craft: Copper, Scrap"))
definition:recipe("spike", ccb.content.text(" Craft: Spike"))
definition:recipe("steel_chunk", ccb.content.text(" Craft: Steel, Chunk"))
definition:recipe("anvil_crude", ccb.content.text(" Craft: Small Anvil"))
definition:recipe("steel_lump", ccb.content.text(" Craft: Steel, Lump"))
definition:recipe("copper_knife", ccb.content.text(" Craft: Knife, Copper"))
definition:recipe("sword_crude", ccb.content.text(" Craft: Sword, Crude"))
definition:recipe("pot_copper", ccb.content.text(" Craft: Pot, Copper"))
definition:recipe("bolt_metal", ccb.content.text(" Craft: Crossbow Bolt, Steel"))
definition:recipe("chisel", ccb.content.text(" Craft: Metalworking Chisel"))
definition:recipe("hammer", ccb.content.text(" Craft: Hammer"))
definition:recipe("metal_file", ccb.content.text(" Craft: Metal Fileset"))
definition:recipe("stone_polishing", ccb.content.text(" Craft: Polishing Stone"))
definition:recipe("tongs", ccb.content.text(" Craft: Pair of kitchen tongs"))
definition:recipe("metalworking_tongs", ccb.content.text(" Craft: Pair of Flatjaw Tongs"))
definition:recipe("hotcut", ccb.content.text(" Craft: Hotcut (chisel for metal working)"))
definition:recipe("nail", ccb.content.text(" Craft: Nail"))
definition:recipe("lc_wire", ccb.content.text(" Craft: Wire"))
definition:recipe("swage", ccb.content.text(" Craft: Swage and Die Set"))
definition:recipe("blade", ccb.content.text(" Craft: Blade"))
definition:recipe("bearing", ccb.content.text(" Craft: Bearings"))
definition:recipe("caltrops", ccb.content.text(" Craft: Caltrops"))
definition:recipe("hand_drill", ccb.content.text(" Craft: Hand Drill"))
definition:recipe("sheet_metal", ccb.content.text(" Craft: Sheet Metal"))
definition:recipe("chain", ccb.content.text(" Craft: Chain"))
definition:recipe("shovel", ccb.content.text(" Craft: Shovel"))
definition:recipe("rebar", ccb.content.text(" Craft: Rebar"))
definition:recipe("hammer_sledge_from_scratch", ccb.content.text(" Craft: Hammer, Sledge"))
definition:recipe("knife_combat", ccb.content.text(" Craft: Knife, Combat"))
definition:recipe("knife_hunting", ccb.content.text(" Craft: Knife, Hunting"))
definition:recipe("spear_steel", ccb.content.text(" Craft: Spear, Steel"))
definition:recipe("machete", ccb.content.text(" Craft: Machete"))
definition:recipe("pipe", ccb.content.text(" Craft: Pipe"))
definition:recipe("screwdriver", ccb.content.text(" Craft: Screwdriver"))
definition:recipe("throwing_axe", ccb.content.text(" Craft: Axe, Throwing"))
definition:recipe("wrench", ccb.content.text(" Craft: Wrench"))
definition:recipe("hatchet", ccb.content.text(" Craft: Hatchet"))
definition:recipe("throwing_knife", ccb.content.text(" Craft: Knife, Throwing"))
definition:recipe("crowbar", ccb.content.text(" Craft: Crowbar"))
definition:recipe("pot", ccb.content.text(" Craft: Pot"))
definition:recipe("hoe", ccb.content.text(" Craft: Hoe"))
definition:recipe("pliers", ccb.content.text(" Craft: Pliers"))
definition:recipe("drift", ccb.content.text(" Craft: Drift"))
definition:recipe("halberd", ccb.content.text(" Craft: Halberd"))
definition:recipe("pockknife", ccb.content.text(" Craft: Knife, Pocket"))
definition:recipe("warhammer", ccb.content.text(" Craft: Hammer, War"))
definition:recipe("hacksaw", ccb.content.text(" Craft: Hacksaw"))
definition:recipe("saw", ccb.content.text(" Craft: Woodsaw"))
definition:recipe("pike", ccb.content.text(" Craft: Spear, Awl Pike"))
definition:recipe("halligan", ccb.content.text(" Craft: Halligan Bar"))
definition:recipe("mc_zweihander", ccb.content.text(" Craft: Sword, Medium Steel Zweihänder"))
definition:recipe("pickaxe", ccb.content.text(" Craft: Pickaxe"))
definition:recipe("bottle_glass", ccb.content.text(" Craft: Bottle, Glass"))
definition:recipe("flask_glass", ccb.content.text(" Craft: Flask, Glass"))
definition:recipe("glass_sheet", ccb.content.text(" Craft: Sheet, Glass"))
definition:recipe("jar_3l_glass_sealed", ccb.content.text(" Craft: 3 L Jar, Glass"))
definition:recipe("jar_glass_sealed", ccb.content.text(" Craft: Jar, Glass"))
definition:recipe("tempered_glass_sheet", ccb.content.text(" Craft: Tempered Sheet, Glass"))
definition:recipe("cured_hide", ccb.content.text(" Hideworking: Cured Hide"))
definition:recipe("cured_pelt", ccb.content.text(" Hideworking: Cured Pelt"))
definition:recipe("tanning_hide_active", ccb.content.text(" Hideworking: Tanning Hide"))
definition:recipe("tanning_pelt_active", ccb.content.text(" Hideworking: Tanning Pelt"))
definition:recipe("tanned_hide", ccb.content.text(" Hideworking: Tanned Hide"))
definition:recipe("leather", ccb.content.text(" Hideworking: Leather"))
definition:recipe("welding_rod_steel", ccb.content.text(" Craft: Welding Rod"))
definition:recipe("welding_rod_alloy", ccb.content.text(" Craft: Aluminum Welding Rod"))
definition:recipe("welding_wire_steel", ccb.content.text(" Craft: Welding Wire"))
definition:recipe("welding_wire_alloy", ccb.content.text(" Craft: Aluminum Welding Wire"))
definition:recipe("brazing_rod_bronze", ccb.content.text(" Craft: Brazing Rod"))
definition:recipe("brazing_rod_alloy", ccb.content.text(" Craft: Aluminum Brazing Rod"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_recipes_1",
    building_type = "BASE",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("pointy_stick", ccb.content.text(" Craft: Pointy Sticks"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_farm_recipes_1",
    building_type = "FARM",
}
definition:recipe("seed_veggy_wild", ccb.content.text(" Craft: Wild Veggy Stems"))
definition:recipe("seed_raw_dandelion", ccb.content.text(" Craft: Dandelion Seeds"))
definition:recipe("seed_potato_raw", ccb.content.text(" Craft: Potato, Starter"))
definition:recipe("seed_buckwheat", ccb.content.text(" Craft: Buckwheat Seeds"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_cooking_recipes_1",
    building_type = "COOK",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("meat_cooked", ccb.content.text(" Cook: Meat, Cooked"))
definition:recipe("fish_cooked", ccb.content.text(" Cook: Fish, Cooked"))
definition:recipe("veggy_cooked", ccb.content.text(" Cook: Veggy, Cooked"))
definition:recipe("boiled_egg", ccb.content.text(" Cook: Egg, Boiled"))
definition:recipe("starch", ccb.content.text(" Cook: Starch"))
definition:recipe("starch_from_fibrous_stuff", ccb.content.text(" Cook: Cattail Starch"))
definition:recipe("flatbread", ccb.content.text(" Cook: Flatbread"))
definition:recipe("veggy_wild_cooked", ccb.content.text(" Cook: Veggy, Cooked Wild"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_cooking_recipes_2",
    building_type = "COOK",
}
definition:recipe("flour", ccb.content.text(" Cook: Flour"))
definition:recipe("salt", ccb.content.text(" Cook: Salt"))
definition:recipe("bread", ccb.content.text(" Cook: Bread"))
definition:recipe("fruit_leather", ccb.content.text(" Cook: Fruit Leather"))
definition:recipe("jerky", ccb.content.text(" Cook: Meat Jerky"))
definition:recipe("mushroom_cooked", ccb.content.text(" Cook: Mushroom, Cooked"))
definition:recipe("cornmeal", ccb.content.text(" Cook: Cornmeal"))
definition:recipe("meat_smoked", ccb.content.text(" Cook: Meat, Smoked"))
definition:recipe("fish_smoked", ccb.content.text(" Cook: Fish, Smoked"))
definition:recipe("dry_mushroom", ccb.content.text(" Cook: Mushroom, Dried"))
definition:recipe("dry_fruit", ccb.content.text(" Cook: Fruit, Dehydrated"))
definition:recipe("sausage", ccb.content.text(" Cook: Sausage"))
definition:recipe("sausage_wasteland", ccb.content.text(" Cook: Sausage, Wasteland"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_cooking_recipes_3",
    building_type = "COOK",
}
definition:recipe("pie_meat", ccb.content.text(" Cook: Meat Pie"))
definition:recipe("pie_veggy", ccb.content.text(" Cook: Veggy Pie"))
definition:recipe("sugar", ccb.content.text(" Cook: Sugar"))
definition:recipe("hardtack", ccb.content.text(" Cook: Hardtack"))
definition:recipe("veggy_pickled_jarred", ccb.content.text(" Cook: Veggy, Pickled"))
definition:recipe("cheese_hard", ccb.content.text(" Cook: Cheese, Hard"))
definition:recipe("pemmican", ccb.content.text(" Cook: Pemmican, Meat + Berries"))
definition:recipe("pemmican_veggy", ccb.content.text(" Cook: Pemmican, Meat + Veg"))
definition:recipe("veggy_aspic", ccb.content.text(" Cook: Veggy Aspic"))
definition:recipe("meat_canned_jarred", ccb.content.text(" Cook: Meat, Canned"))
definition:recipe("meat_aspic", ccb.content.text(" Cook: Meat Aspic"))
definition:recipe("kompot", ccb.content.text(" Cook: Kompot"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_blacksmith_recipes_1",
    building_type = "SMITH",
}
definition:recipe("scrap_copper", ccb.content.text(" Craft: Copper, Scrap"))
definition:recipe("charcoal_npc", ccb.content.text(" Craft: Charcoal"))
definition:recipe("spike", ccb.content.text(" Craft: Spike"))
definition:recipe("caltrops_glass", ccb.content.text(" Craft: Glass Caltrops"))
definition:recipe("steel_chunk", ccb.content.text(" Craft: Steel, Chunk"))
definition:recipe("anvil_crude", ccb.content.text(" Craft: Small Anvil"))
definition:recipe("steel_lump", ccb.content.text(" Craft: Steel, Lump"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_blacksmith_recipes_3",
    building_type = "SMITH",
}
definition:recipe("chisel", ccb.content.text(" Craft: Metalworking Chisel"))
definition:recipe("hammer", ccb.content.text(" Craft: Hammer"))
definition:recipe("tongs", ccb.content.text(" Craft: Pair of kitchen tongs"))
definition:recipe("nail", ccb.content.text(" Craft: Nail"))
definition:recipe("lc_wire", ccb.content.text(" Craft: Wire"))
definition:recipe("swage", ccb.content.text(" Craft: Swage and Die Set"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_blacksmith_recipes_4",
    building_type = "SMITH",
}
definition:recipe("blade", ccb.content.text(" Craft: Blade"))
definition:recipe("bearing", ccb.content.text(" Craft: Bearings"))
definition:recipe("caltrops", ccb.content.text(" Craft: Caltrops"))
definition:recipe("hand_drill", ccb.content.text(" Craft: Hand Drill"))
definition:recipe("sheet_metal", ccb.content.text(" Craft: Sheet Metal"))
definition:recipe("chain", ccb.content.text(" Craft: Chain"))
definition:recipe("shovel", ccb.content.text(" Craft: Shovel"))
definition:recipe("rebar", ccb.content.text(" Craft: Rebar"))
definition:recipe("welding_rod_steel", ccb.content.text(" Craft: Steel Welding Rod"))
definition:recipe("gold_ring", ccb.content.text(" Craft: Gold Ring"))
definition:recipe("hammer_sledge_from_scratch", ccb.content.text(" Craft: Hammer, Sledge"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_blacksmith_recipes_5",
    building_type = "SMITH",
}
definition:recipe("knife_combat", ccb.content.text(" Craft: Knife, Combat"))
definition:recipe("spear_steel", ccb.content.text(" Craft: Spear, Steel"))
definition:recipe("machete", ccb.content.text(" Craft: Machete"))
definition:recipe("pipe", ccb.content.text(" Craft: Pipe"))
definition:recipe("screwdriver", ccb.content.text(" Craft: Screwdriver"))
definition:recipe("throwing_axe", ccb.content.text(" Craft: Axe, Throwing"))
definition:recipe("wrench", ccb.content.text(" Craft: Wrench"))
definition:recipe("hatchet", ccb.content.text(" Craft: Hatchet"))
definition:recipe("throwing_knife", ccb.content.text(" Craft: Knife, Throwing"))
definition:recipe("crowbar", ccb.content.text(" Craft: Crowbar"))
definition:recipe("pot", ccb.content.text(" Craft: Pot"))
definition:recipe("hoe", ccb.content.text(" Craft: Hoe"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_blacksmith_recipes_6",
    building_type = "SMITH",
}
definition:recipe("pliers", ccb.content.text(" Craft: Pliers"))
definition:recipe("halberd", ccb.content.text(" Craft: Halberd"))
definition:recipe("cuirass_lightplate", ccb.content.text(" Craft: Armor, Cuirass"))
definition:recipe("pockknife", ccb.content.text(" Craft: Knife, Pocket"))
definition:recipe("warhammer", ccb.content.text(" Craft: Hammer, War"))
definition:recipe("helmet_plate", ccb.content.text(" Craft: Helm, Great"))
definition:recipe("armor_ch_heavy_chestplate", ccb.content.text(" Craft: Armor, Hardened Heavy Chestplate"))
definition:recipe("armor_ch_light_chestplate", ccb.content.text(" Craft: Armor, Hardened Light Chestplate"))
definition:recipe("armor_ch_heavy_leg_guard", ccb.content.text(" Craft: Armor, Hardened Heavy Leg Guard"))
definition:recipe("armor_ch_light_leg_guard", ccb.content.text(" Craft: Armor, Hardened Light Leg Guard"))
definition:recipe("armor_ch_armguard", ccb.content.text(" Craft: Armor, Hardened Armguard"))
definition:recipe("armor_ch_heavyarmguard", ccb.content.text(" Craft: Armor, Hardened Heavy Armguard"))
definition:recipe("armor_ch_lightarmguard", ccb.content.text(" Craft: Armor, Hardened Light Armguard"))
definition:recipe("armor_ch_chestplate", ccb.content.text(" Craft: Armor, Hardened Chestplate"))
definition:recipe("armor_ch_leg_guard", ccb.content.text(" Craft: Armor, Hardened Leg Guard"))
definition:recipe("armor_ch_heavyplate", ccb.content.text(" Craft: Armor, Hardened Heavy Plate"))
definition:recipe("armor_ch_lightplate", ccb.content.text(" Craft: Armor, Hardened Light Plate"))
definition:recipe("armor_ch_plate", ccb.content.text(" Craft: Armor, Hardened Plate"))
definition:recipe("armor_hc_heavy_chestplate", ccb.content.text(" Craft: Armor, High Steel Heavy Chestplate"))
definition:recipe("armor_hc_light_chestplate", ccb.content.text(" Craft: Armor, High Steel Light Chestplate"))
definition:recipe("armor_hc_heavy_leg_guard", ccb.content.text(" Craft: Armor, High Steel Heavy Leg Guard"))
definition:recipe("armor_hc_light_leg_guard", ccb.content.text(" Craft: Armor, High Steel Light Leg Guard"))
definition:recipe("armor_hc_armguard", ccb.content.text(" Craft: Armor, High Steel Armguard"))
definition:recipe("armor_hc_heavyarmguard", ccb.content.text(" Craft: Armor, High Steel Heavy Armguard"))
definition:recipe("armor_hc_lightarmguard", ccb.content.text(" Craft: Armor, High Steel Light Armguard"))
definition:recipe("armor_hc_chestplate", ccb.content.text(" Craft: Armor, High Steel Chestplate"))
definition:recipe("armor_hc_leg_guard", ccb.content.text(" Craft: Armor, High Steel Leg Guard"))
definition:recipe("armor_hc_heavyplate", ccb.content.text(" Craft: Armor, High Steel Heavy Plate"))
definition:recipe("armor_hc_lightplate", ccb.content.text(" Craft: Armor, High Steel Light Plate"))
definition:recipe("armor_hc_plate", ccb.content.text(" Craft: Armor, High Steel Plate"))
definition:recipe("armor_lc_heavy_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Heavy Chestplate"))
definition:recipe("armor_lc_light_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Light Chestplate"))
definition:recipe("armor_lc_heavy_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Heavy Leg Guard"))
definition:recipe("armor_lc_light_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Light Leg Guard"))
definition:recipe("armor_lc_armguard", ccb.content.text(" Craft: Armor, Mild Steel Armguard"))
definition:recipe("armor_lc_heavyarmguard", ccb.content.text(" Craft: Armor, Mild Steel Heavy Armguard"))
definition:recipe("armor_lc_lightarmguard", ccb.content.text(" Craft: Armor, Mild Steel Light Armguard"))
definition:recipe("armor_lc_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Chestplate"))
definition:recipe("armor_lc_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Leg Guard"))
definition:recipe("armor_lc_heavyplate", ccb.content.text(" Craft: Armor, Mild Steel Heavy Plate"))
definition:recipe("armor_lc_lightplate", ccb.content.text(" Craft: Armor, Mild Steel Light Plate"))
definition:recipe("armor_lc_plate", ccb.content.text(" Craft: Armor, Mild Steel Plate"))
definition:recipe("armor_mc_heavy_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Heavy Chestplate"))
definition:recipe("armor_mc_light_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Light Chestplate"))
definition:recipe("armor_mc_heavy_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Heavy Leg Guard"))
definition:recipe("armor_mc_light_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Light Leg Guard"))
definition:recipe("armor_mc_armguard", ccb.content.text(" Craft: Armor, Medium Steel Armguard"))
definition:recipe("armor_mc_heavyarmguard", ccb.content.text(" Craft: Armor, Medium Steel Heavy Armguard"))
definition:recipe("armor_mc_lightarmguard", ccb.content.text(" Craft: Armor, Medium Steel Light Armguard"))
definition:recipe("armor_mc_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Chestplate"))
definition:recipe("armor_mc_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Leg Guard"))
definition:recipe("armor_mc_heavyplate", ccb.content.text(" Craft: Armor, Medium Steel Heavy Plate"))
definition:recipe("armor_mc_lightplate", ccb.content.text(" Craft: Armor, Medium Steel Light Plate"))
definition:recipe("armor_mc_plate", ccb.content.text(" Craft: Armor, Medium Steel Plate"))
definition:recipe("armor_qt_heavy_chestplate", ccb.content.text(" Craft: Armor, Tempered Heavy Chestplate"))
definition:recipe("armor_qt_light_chestplate", ccb.content.text(" Craft: Armor, Tempered Light Chestplate"))
definition:recipe("armor_qt_heavy_leg_guard", ccb.content.text(" Craft: Armor, Tempered Heavy Leg Guard"))
definition:recipe("armor_qt_light_leg_guard", ccb.content.text(" Craft: Armor, Tempered Light Leg Guard"))
definition:recipe("armor_qt_armguard", ccb.content.text(" Craft: Armor, Tempered Armguard"))
definition:recipe("armor_qt_heavyarmguard", ccb.content.text(" Craft: Armor, Tempered Heavy Armguard"))
definition:recipe("armor_qt_lightarmguard", ccb.content.text(" Craft: Armor, Tempered Light Armguard"))
definition:recipe("armor_qt_chestplate", ccb.content.text(" Craft: Armor, Tempered Chestplate"))
definition:recipe("armor_qt_leg_guard", ccb.content.text(" Craft: Armor, Tempered Leg Guard"))
definition:recipe("armor_qt_heavyplate", ccb.content.text(" Craft: Armor, Tempered Heavy Plate"))
definition:recipe("armor_qt_lightplate", ccb.content.text(" Craft: Armor, Tempered Light Plate"))
definition:recipe("armor_qt_plate", ccb.content.text(" Craft: Armor, Tempered Plate"))
definition:recipe("ch_demi_gaunt", ccb.content.text(" Craft: Armor, Hardened Demi Gauntlet"))
definition:recipe("ch_helm_close", ccb.content.text(" Craft: Armor, Hardened Close Helm"))
definition:recipe("ch_mitten_gaunt", ccb.content.text(" Craft: Armor, Hardened Mitten Gauntlet"))
definition:recipe("ch_sabaton", ccb.content.text(" Craft: Armor, Hardened Sabaton"))
definition:recipe("hc_demi_gaunt", ccb.content.text(" Craft: Armor, High Steel Demi Gauntlet"))
definition:recipe("hc_helm_close", ccb.content.text(" Craft: Armor, High Steel Close Helm"))
definition:recipe("hc_mitten_gaunt", ccb.content.text(" Craft: Armor, High Steel Mitten Gauntlet"))
definition:recipe("hc_sabaton", ccb.content.text(" Craft: Armor, High Steel Sabaton"))
definition:recipe("lc_demi_gaunt", ccb.content.text(" Craft: Armor, Mild Steel Demi Gauntlet"))
definition:recipe("lc_helm_close", ccb.content.text(" Craft: Armor, Mild Steel Close Helm"))
definition:recipe("lc_mitten_gaunt", ccb.content.text(" Craft: Armor, Mild Steel Mitten Gauntlet"))
definition:recipe("lc_sabaton", ccb.content.text(" Craft: Armor, Mild Steel Sabaton"))
definition:recipe("mc_demi_gaunt", ccb.content.text(" Craft: Armor, Medium Steel Demi Gauntlet"))
definition:recipe("mc_helm_close", ccb.content.text(" Craft: Armor, Medium Steel Close Helm"))
definition:recipe("mc_mitten_gaunt", ccb.content.text(" Craft: Armor, Medium Steel Mitten Gauntlet"))
definition:recipe("mc_sabaton", ccb.content.text(" Craft: Armor, Medium Steel Sabaton"))
definition:recipe("qt_demi_gaunt", ccb.content.text(" Craft: Armor, Tempered Demi Gauntlet"))
definition:recipe("qt_helm_close", ccb.content.text(" Craft: Armor, Tempered Close Helm"))
definition:recipe("qt_mitten_gaunt", ccb.content.text(" Craft: Armor, Tempered Mitten Gauntlet"))
definition:recipe("qt_sabaton", ccb.content.text(" Craft: Armor, Tempered Sabaton"))
definition:recipe("xl_armor_ch_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Heavy Chestplate"))
definition:recipe("xl_armor_ch_light_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Light Chestplate"))
definition:recipe("xl_armor_ch_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Heavy Leg Guard"))
definition:recipe("xl_armor_ch_light_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Light Leg Guard"))
definition:recipe("xl_armor_ch_armguard", ccb.content.text(" Craft: Armor, XL Hardened Armguard"))
definition:recipe("xl_armor_ch_heavyarmguard", ccb.content.text(" Craft: Armor, XL Hardened Heavy Armguard"))
definition:recipe("xl_armor_ch_lightarmguard", ccb.content.text(" Craft: Armor, XL Hardened Light Armguard"))
definition:recipe("xl_armor_ch_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Chestplate"))
definition:recipe("xl_armor_ch_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Leg Guard"))
definition:recipe("xl_armor_ch_heavyplate", ccb.content.text(" Craft: Armor, XL Hardened Heavy Plate"))
definition:recipe("xl_armor_ch_lightplate", ccb.content.text(" Craft: Armor, XL Hardened Light Plate"))
definition:recipe("xl_armor_ch_plate", ccb.content.text(" Craft: Armor, XL Hardened Plate"))
definition:recipe("xl_armor_hc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Heavy Chestplate"))
definition:recipe("xl_armor_hc_light_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Light Chestplate"))
definition:recipe("xl_armor_hc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Heavy Leg Guard"))
definition:recipe("xl_armor_hc_light_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Light Leg Guard"))
definition:recipe("xl_armor_hc_armguard", ccb.content.text(" Craft: Armor, XL High Steel Armguard"))
definition:recipe("xl_armor_hc_heavyarmguard", ccb.content.text(" Craft: Armor, XL High Steel Heavy Armguard"))
definition:recipe("xl_armor_hc_lightarmguard", ccb.content.text(" Craft: Armor, XL High Steel Light Armguard"))
definition:recipe("xl_armor_hc_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Chestplate"))
definition:recipe("xl_armor_hc_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Leg Guard"))
definition:recipe("xl_armor_hc_heavyplate", ccb.content.text(" Craft: Armor, XL High Steel Heavy Plate"))
definition:recipe("xl_armor_hc_lightplate", ccb.content.text(" Craft: Armor, XL High Steel Light Plate"))
definition:recipe("xl_armor_hc_plate", ccb.content.text(" Craft: Armor, XL High Steel Plate"))
definition:recipe("xl_armor_lc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Chestplate"))
definition:recipe("xl_armor_lc_light_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Light Chestplate"))
definition:recipe("xl_armor_lc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Leg Guard"))
definition:recipe("xl_armor_lc_light_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Light Leg Guard"))
definition:recipe("xl_armor_lc_armguard", ccb.content.text(" Craft: Armor, XL Mild Steel Armguard"))
definition:recipe("xl_armor_lc_heavyarmguard", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Armguard"))
definition:recipe("xl_armor_lc_lightarmguard", ccb.content.text(" Craft: Armor, XL Mild Steel Light Armguard"))
definition:recipe("xl_armor_lc_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Chestplate"))
definition:recipe("xl_armor_lc_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Leg Guard"))
definition:recipe("xl_armor_lc_heavyplate", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Plate"))
definition:recipe("xl_armor_lc_lightplate", ccb.content.text(" Craft: Armor, XL Mild Steel Light Plate"))
definition:recipe("xl_armor_lc_plate", ccb.content.text(" Craft: Armor, XL Mild Steel Plate"))
definition:recipe("xl_armor_mc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Chestplate"))
definition:recipe("xl_armor_mc_light_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Light Chestplate"))
definition:recipe("xl_armor_mc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Leg Guard"))
definition:recipe("xl_armor_mc_light_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Light Leg Guard"))
definition:recipe("xl_armor_mc_armguard", ccb.content.text(" Craft: Armor, XL Medium Steel Armguard"))
definition:recipe("xl_armor_mc_heavyarmguard", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Armguard"))
definition:recipe("xl_armor_mc_lightarmguard", ccb.content.text(" Craft: Armor, XL Medium Steel Light Armguard"))
definition:recipe("xl_armor_mc_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Chestplate"))
definition:recipe("xl_armor_mc_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Leg Guard"))
definition:recipe("xl_armor_mc_heavyplate", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Plate"))
definition:recipe("xl_armor_mc_lightplate", ccb.content.text(" Craft: Armor, XL Medium Steel Light Plate"))
definition:recipe("xl_armor_mc_plate", ccb.content.text(" Craft: Armor, XL Medium Steel Plate"))
definition:recipe("xl_armor_qt_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Heavy Chestplate"))
definition:recipe("xl_armor_qt_light_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Light Chestplate"))
definition:recipe("xl_armor_qt_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Heavy Leg Guard"))
definition:recipe("xl_armor_qt_light_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Light Leg Guard"))
definition:recipe("xl_armor_qt_armguard", ccb.content.text(" Craft: Armor, XL Tempered Armguard"))
definition:recipe("xl_armor_qt_heavyarmguard", ccb.content.text(" Craft: Armor, XL Tempered Heavy Armguard"))
definition:recipe("xl_armor_qt_lightarmguard", ccb.content.text(" Craft: Armor, XL Tempered Light Armguard"))
definition:recipe("xl_armor_qt_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Chestplate"))
definition:recipe("xl_armor_qt_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Leg Guard"))
definition:recipe("xl_armor_qt_heavyplate", ccb.content.text(" Craft: Armor, XL Tempered Heavy Plate"))
definition:recipe("xl_armor_qt_lightplate", ccb.content.text(" Craft: Armor, XL Tempered Light Plate"))
definition:recipe("xl_armor_qt_plate", ccb.content.text(" Craft: Armor, XL Tempered Plate"))
definition:recipe("broadsword", ccb.content.text(" Craft: Sword, Medium Steel Broadsword"))
definition:recipe("mc_scimitar", ccb.content.text(" Craft: Sword, Medium Steel Shamshir"))
definition:recipe("fire_ax", ccb.content.text(" Craft: Axe, Fire"))
definition:recipe("hacksaw", ccb.content.text(" Craft: Hacksaw"))
definition:recipe("saw", ccb.content.text(" Craft: Woodsaw"))
definition:recipe("pike", ccb.content.text(" Craft: Spear, Awl Pike"))
definition:recipe("rapier", ccb.content.text(" Craft: Sword, Medium Steel Rapier"))
definition:recipe("halligan", ccb.content.text(" Craft: Halligan Bar"))
definition:recipe("mc_zweihander", ccb.content.text(" Craft: Sword, Medium Steel Zweihänder"))
definition:recipe("pickaxe", ccb.content.text(" Craft: Pickaxe"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_firestation_blacksmith_recipes_7",
    building_type = "SMITH",
}
definition:recipe("sheet_metal_npc_drop", ccb.content.text(" Craft: Sheet Metal, Drop Hammer"))
definition:recipe("chain_npc_drop", ccb.content.text(" Craft: Chain, Drop Hammer"))
definition:recipe("nail_npc_drop", ccb.content.text(" Craft: Nail, Drop Hammer"))
definition:recipe("pipe_npc_drop", ccb.content.text(" Craft: Pipe, Drop Hammer"))
definition:recipe("rebar_npc_drop", ccb.content.text(" Craft: Rebar, Drop Hammer"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmh_2_crafting_recipes_1",
    building_type = "BASE",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("pointy_stick", ccb.content.text(" Craft: Pointy Sticks"))
definition:recipe("wood_panel_from nailed planks", ccb.content.text(" Craft: Wooden Panel, Nailed Planks"))
definition:recipe("wood_panel_from wooden beams", ccb.content.text(" Craft: Wooden Panel, Wooden Beams"))
definition:recipe("wood_beam_from logs", ccb.content.text(" Craft: Wooden Beam"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmh_2_cooking_recipes_1",
    building_type = "COOK",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("meat_cooked", ccb.content.text(" Cook: Meat, Cooked"))
definition:recipe("fish_cooked", ccb.content.text(" Cook: Fish, Cooked"))
definition:recipe("veggy_cooked", ccb.content.text(" Cook: Veggy, Cooked"))
definition:recipe("boiled_egg", ccb.content.text(" Cook: Egg, Boiled"))
definition:recipe("starch", ccb.content.text(" Cook: Starch"))
definition:recipe("starch_from_fibrous_stuff", ccb.content.text(" Cook: Cattail Starch"))
definition:recipe("flatbread", ccb.content.text(" Cook: Flatbread"))
definition:recipe("veggy_wild_cooked", ccb.content.text(" Cook: Veggy, Cooked Wild"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_shelter_recipes_1",
    building_type = "BASE",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("pointy_stick", ccb.content.text(" Craft: Pointy Sticks"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_shelter_cooking_recipes_1",
    building_type = "COOK",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("meat_cooked", ccb.content.text(" Cook: Meat, Cooked"))
definition:recipe("fish_cooked", ccb.content.text(" Cook: Fish, Cooked"))
definition:recipe("veggy_cooked", ccb.content.text(" Cook: Veggy, Cooked"))
definition:recipe("boiled_egg", ccb.content.text(" Cook: Egg, Boiled"))
definition:recipe("starch", ccb.content.text(" Cook: Starch"))
definition:recipe("starch_from_fibrous_stuff", ccb.content.text(" Cook: Cattail Starch"))
definition:recipe("flatbread", ccb.content.text(" Cook: Flatbread"))
definition:recipe("veggy_wild_cooked", ccb.content.text(" Cook: Veggy, Cooked Wild"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_shelter_1_recipes_1",
    building_type = "BASE",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("pointy_stick", ccb.content.text(" Craft: Pointy Sticks"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_shelter_1_cooking_recipes_1",
    building_type = "COOK",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("meat_cooked", ccb.content.text(" Cook: Meat, Cooked"))
definition:recipe("fish_cooked", ccb.content.text(" Cook: Fish, Cooked"))
definition:recipe("veggy_cooked", ccb.content.text(" Cook: Veggy, Cooked"))
definition:recipe("boiled_egg", ccb.content.text(" Cook: Egg, Boiled"))
definition:recipe("starch", ccb.content.text(" Cook: Starch"))
definition:recipe("starch_from_fibrous_stuff", ccb.content.text(" Cook: Cattail Starch"))
definition:recipe("flatbread", ccb.content.text(" Cook: Flatbread"))
definition:recipe("veggy_wild_cooked", ccb.content.text(" Cook: Veggy, Cooked Wild"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_shelter_2_recipes_1",
    building_type = "BASE",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("pointy_stick", ccb.content.text(" Craft: Pointy Sticks"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmc_shelter_2_cooking_recipes_1",
    building_type = "COOK",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("meat_cooked", ccb.content.text(" Cook: Meat, Cooked"))
definition:recipe("fish_cooked", ccb.content.text(" Cook: Fish, Cooked"))
definition:recipe("veggy_cooked", ccb.content.text(" Cook: Veggy, Cooked"))
definition:recipe("boiled_egg", ccb.content.text(" Cook: Egg, Boiled"))
definition:recipe("starch", ccb.content.text(" Cook: Starch"))
definition:recipe("starch_from_fibrous_stuff", ccb.content.text(" Cook: Cattail Starch"))
definition:recipe("flatbread", ccb.content.text(" Cook: Flatbread"))
definition:recipe("veggy_wild_cooked", ccb.content.text(" Cook: Veggy, Cooked Wild"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmk_2_recipes_1",
    building_type = "COOK",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("meat_cooked", ccb.content.text(" Cook: Meat, Cooked"))
definition:recipe("fish_cooked", ccb.content.text(" Cook: Fish, Cooked"))
definition:recipe("veggy_cooked", ccb.content.text(" Cook: Veggy, Cooked"))
definition:recipe("boiled_egg", ccb.content.text(" Cook: Egg, Boiled"))
definition:recipe("starch", ccb.content.text(" Cook: Starch"))
definition:recipe("starch_from_fibrous_stuff", ccb.content.text(" Cook: Cattail Starch"))
definition:recipe("flatbread", ccb.content.text(" Cook: Flatbread"))
definition:recipe("veggy_wild_cooked", ccb.content.text(" Cook: Veggy, Cooked Wild"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmk_2_recipes_2",
    building_type = "COOK",
}
definition:recipe("flour", ccb.content.text(" Cook: Flour"))
definition:recipe("salt", ccb.content.text(" Cook: Salt"))
definition:recipe("bread", ccb.content.text(" Cook: Bread"))
definition:recipe("fruit_leather", ccb.content.text(" Cook: Fruit Leather"))
definition:recipe("jerky", ccb.content.text(" Cook: Meat Jerky"))
definition:recipe("mushroom_cooked", ccb.content.text(" Cook: Mushroom, Cooked"))
definition:recipe("cornmeal", ccb.content.text(" Cook: Cornmeal"))
definition:recipe("meat_smoked", ccb.content.text(" Cook: Meat, Smoked"))
definition:recipe("fish_smoked", ccb.content.text(" Cook: Fish, Smoked"))
definition:recipe("dry_mushroom", ccb.content.text(" Cook: Mushroom, Dried"))
definition:recipe("dry_fruit", ccb.content.text(" Cook: Fruit, Dehydrated"))
definition:recipe("sausage", ccb.content.text(" Cook: Sausage"))
definition:recipe("sausage_wasteland", ccb.content.text(" Cook: Sausage, Wasteland"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmk_2_recipes_3",
    building_type = "COOK",
}
definition:recipe("pie_meat", ccb.content.text(" Cook: Meat Pie"))
definition:recipe("pie_veggy", ccb.content.text(" Cook: Veggy Pie"))
definition:recipe("sugar", ccb.content.text(" Cook: Sugar"))
definition:recipe("hardtack", ccb.content.text(" Cook: Hardtack"))
definition:recipe("veggy_pickled_jarred", ccb.content.text(" Cook: Veggy, Pickled"))
definition:recipe("cheese_hard", ccb.content.text(" Cook: Cheese, Hard"))
definition:recipe("pemmican", ccb.content.text(" Cook: Pemmican, Meat + Berries"))
definition:recipe("pemmican_veggy", ccb.content.text(" Cook: Pemmican, Meat + Veg"))
definition:recipe("veggy_aspic", ccb.content.text(" Cook: Veggy Aspic"))
definition:recipe("meat_canned_jarred", ccb.content.text(" Cook: Meat, Canned"))
definition:recipe("meat_aspic", ccb.content.text(" Cook: Meat Aspic"))
definition:recipe("kompot", ccb.content.text(" Cook: Kompot"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmf_2_recipes_1",
    building_type = "SMITH",
}
definition:recipe("corn_kernels", ccb.content.text(" Corn Kernels"))
definition:recipe("threshed_barley_flail", ccb.content.text(" Threshed Barley (with flail)"))
definition:recipe("threshed_buckwheat_flail", ccb.content.text(" Threshed Buckwheat (with flail)"))
definition:recipe("threshed_canola_flail", ccb.content.text(" Threshed Canola (with flail)"))
definition:recipe("threshed_lentils_flail", ccb.content.text(" Threshed Lentils (with flail)"))
definition:recipe("threshed_oats_flail", ccb.content.text(" Threshed Oats (with flail)"))
definition:recipe("threshed_wheat_flail", ccb.content.text(" Threshed Wheat (with flail)"))
definition:recipe("barley_win1", ccb.content.text(" Barley (winnowing)"))
definition:recipe("buckwheat_win1", ccb.content.text(" Buckwheat (winnowing)"))
definition:recipe("seed_canola_win1", ccb.content.text(" Canola (winnowing)"))
definition:recipe("dry_lentils_win1", ccb.content.text(" Lentils (winnowing)"))
definition:recipe("oats_win1", ccb.content.text(" Oats (winnowing)"))
definition:recipe("wheat_win1", ccb.content.text(" Wheat (winnowing)"))
definition:recipe("threshed_barley", ccb.content.text(" Threshed Barley"))
definition:recipe("threshed_buckwheat", ccb.content.text(" Threshed Buckwheat"))
definition:recipe("threshed_canola", ccb.content.text(" Threshed Canola"))
definition:recipe("threshed_lentils", ccb.content.text(" Threshed Lentils"))
definition:recipe("threshed_oats", ccb.content.text(" Threshed Oats"))
definition:recipe("threshed_wheat", ccb.content.text(" Threshed Wheat"))
definition:recipe("barley", ccb.content.text(" Barley"))
definition:recipe("buckwheat", ccb.content.text(" Buckwheat"))
definition:recipe("seed_canola", ccb.content.text(" Canola"))
definition:recipe("dry_lentils", ccb.content.text(" Lentils"))
definition:recipe("oats", ccb.content.text(" Oats"))
definition:recipe("wheat", ccb.content.text(" Wheat"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbml_2_shed_recipes_1",
    building_type = "SMITH",
}
definition:recipe("yarn_spinningwheel", ccb.content.text(" Craft: Yarn"))
definition:recipe("grass_yarn_spinningwheel", ccb.content.text(" Craft: Grass yarn"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_potter_recipes_0",
    building_type = "SMITH",
}
definition:recipe("crucible_clay", ccb.content.text(" Craft: Crucible, Clay"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_potter_recipes_1",
    building_type = "SMITH",
}
definition:recipe("brick", ccb.content.text(" Craft: Brick"))
definition:recipe("crucible_clay", ccb.content.text(" Craft: Crucible, Clay"))
definition:recipe("clay_canister", ccb.content.text(" Craft: Canister, Clay"))
definition:recipe("fire_brick", ccb.content.text(" Craft: Brick, Fire"))
definition:recipe("pebble_clay", ccb.content.text(" Craft: Pellet, Clay"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_blacksmith_recipes_0",
    building_type = "SMITH",
}
definition:recipe("stone_chisel", ccb.content.text(" Craft: Stone Chisel"))
definition:recipe("makeshift_hammer", ccb.content.text(" Craft: Makeshift Hammer"))
definition:recipe("primitive_hammer", ccb.content.text(" Craft: Stone Hammer"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_blacksmith_recipes_1",
    building_type = "SMITH",
}
definition:recipe("caltrops_glass", ccb.content.text(" Craft: Glass Caltrops"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_blacksmith_recipes_2",
    building_type = "SMITH",
}
definition:recipe("scrap_copper", ccb.content.text(" Craft: Copper, Scrap"))
definition:recipe("charcoal_npc", ccb.content.text(" Craft: Charcoal"))
definition:recipe("spike", ccb.content.text(" Craft: Spike"))
definition:recipe("caltrops_glass", ccb.content.text(" Craft: Glass Caltrops"))
definition:recipe("steel_chunk", ccb.content.text(" Craft: Steel, Chunk"))
definition:recipe("anvil_crude", ccb.content.text(" Craft: Small Anvil"))
definition:recipe("steel_lump", ccb.content.text(" Craft: Steel, Lump"))
definition:recipe("lc_steel_lump", ccb.content.text(" Craft: Mild Steel, Lump"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_blacksmith_recipes_3",
    building_type = "SMITH",
}
definition:recipe("casting_mold", ccb.content.text(" Craft: Casting Mold (for metal)"))
definition:recipe("copper_knife", ccb.content.text(" Craft: Knife, Copper"))
definition:recipe("sword_crude", ccb.content.text(" Craft: Sword, Crude"))
definition:recipe("pot_copper", ccb.content.text(" Craft: Pot, Copper"))
definition:recipe("bolt_metal", ccb.content.text(" Craft: Crossbow Bolt, Steel"))
definition:recipe("armor_scrapsuit", ccb.content.text(" Craft: Armor, Scrap Suit"))
definition:recipe("helmet_scrap", ccb.content.text(" Craft: Armor, Scrap Helmet"))
definition:recipe("cuirass_scrap", ccb.content.text(" Craft: Armor, Scrap Cuirass"))
definition:recipe("armguard_scrap", ccb.content.text(" Craft: Armor, Scrap Arm Guards"))
definition:recipe("legguard_scrap", ccb.content.text(" Craft: Armor, Scrap Leg Guards"))
definition:recipe("boots_scrap", ccb.content.text(" Craft: Armor, Scrap Boots"))
definition:recipe("chisel", ccb.content.text(" Craft: Metalworking Chisel"))
definition:recipe("hammer", ccb.content.text(" Craft: Hammer"))
definition:recipe("metal_file", ccb.content.text(" Craft: Metal Fileset"))
definition:recipe("stone_polishing", ccb.content.text(" Craft: Polishing Stone"))
definition:recipe("tongs", ccb.content.text(" Craft: Pair of Kitchen Tongs"))
definition:recipe("metalworking_tongs", ccb.content.text(" Craft: Pair of Flatjaw Tongs"))
definition:recipe("metalworking_tongs_casting", ccb.content.text(" Craft: Pair of Flatjaw Tongs"))
definition:recipe("hotcut", ccb.content.text(" Craft: Hotcut (chisel for metal working)"))
definition:recipe("nail", ccb.content.text(" Craft: Nail"))
definition:recipe("swage", ccb.content.text(" Craft: Swage and Die Set"))
definition:recipe("lc_wire", ccb.content.text(" Craft: Mild Steel, Wire"))
definition:recipe("lc_chain_link_fabrication", ccb.content.text(" Craft: Mild Steel, Link"))
definition:recipe("lc_link_sheet", ccb.content.text(" Craft: Mild Steel, Link Sheet"))
definition:recipe("mc_steel_lump", ccb.content.text(" Craft: Medium Steel, Lump"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_blacksmith_recipes_4",
    building_type = "SMITH",
}
definition:recipe("blade", ccb.content.text(" Craft: Blade"))
definition:recipe("bearing", ccb.content.text(" Craft: Bearings"))
definition:recipe("caltrops", ccb.content.text(" Craft: Caltrops"))
definition:recipe("hand_drill", ccb.content.text(" Craft: Hand Drill"))
definition:recipe("sheet_metal", ccb.content.text(" Craft: Sheet Metal"))
definition:recipe("chain", ccb.content.text(" Craft: Chain"))
definition:recipe("shovel", ccb.content.text(" Craft: Shovel"))
definition:recipe("rebar", ccb.content.text(" Craft: Rebar"))
definition:recipe("gold_ring", ccb.content.text(" Craft: Gold Ring"))
definition:recipe("hammer_sledge_from_scratch", ccb.content.text(" Craft: Hammer, Sledge"))
definition:recipe("ch_wire", ccb.content.text(" Craft: Hardened Steel, Wire"))
definition:recipe("welding_rod_steel", ccb.content.text(" Craft: Steel Welding Rod"))
definition:recipe("ch_chain_link_fabrication", ccb.content.text(" Craft: Hardened Steel, Link"))
definition:recipe("ch_link_sheet", ccb.content.text(" Craft: Hardened Steel, Link Sheet"))
definition:recipe("mc_wire", ccb.content.text(" Craft: Medium Steel, Wire"))
definition:recipe("mc_chain_link_fabrication", ccb.content.text(" Craft: Medium Steel, Link"))
definition:recipe("mc_link_sheet", ccb.content.text(" Craft: Medium Steel, Link Sheet"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_blacksmith_recipes_5",
    building_type = "SMITH",
}
definition:recipe("knife_combat", ccb.content.text(" Craft: Knife, Combat"))
definition:recipe("knife_hunting", ccb.content.text(" Craft: Knife, Hunting"))
definition:recipe("spear_steel", ccb.content.text(" Craft: Spear, Steel"))
definition:recipe("machete", ccb.content.text(" Craft: Machete"))
definition:recipe("pipe", ccb.content.text(" Craft: Pipe"))
definition:recipe("screwdriver", ccb.content.text(" Craft: Screwdriver"))
definition:recipe("throwing_axe", ccb.content.text(" Craft: Axe, Throwing"))
definition:recipe("wrench", ccb.content.text(" Craft: Wrench"))
definition:recipe("hatchet", ccb.content.text(" Craft: Hatchet"))
definition:recipe("throwing_knife", ccb.content.text(" Craft: Knife, Throwing"))
definition:recipe("crowbar", ccb.content.text(" Craft: Crowbar"))
definition:recipe("pot", ccb.content.text(" Craft: Pot"))
definition:recipe("hoe", ccb.content.text(" Craft: Hoe"))
definition:recipe("pliers", ccb.content.text(" Craft: Pliers"))
definition:recipe("drift", ccb.content.text(" Craft: Drift"))
definition:recipe("halberd", ccb.content.text(" Craft: Halberd"))
definition:recipe("cuirass_lightplate", ccb.content.text(" Craft: Armor, Cuirass"))
definition:recipe("pockknife", ccb.content.text(" Craft: Knife, Pocket"))
definition:recipe("warhammer", ccb.content.text(" Craft: Hammer, War"))
definition:recipe("helmet_plate", ccb.content.text(" Craft: Helm, Great"))
definition:recipe("armor_ch_heavy_chestplate", ccb.content.text(" Craft: Armor, Hardened Heavy Chestplate"))
definition:recipe("armor_ch_light_chestplate", ccb.content.text(" Craft: Armor, Hardened Light Chestplate"))
definition:recipe("armor_ch_heavy_leg_guard", ccb.content.text(" Craft: Armor, Hardened Heavy Leg Guard"))
definition:recipe("armor_ch_light_leg_guard", ccb.content.text(" Craft: Armor, Hardened Light Leg Guard"))
definition:recipe("armor_ch_armguard", ccb.content.text(" Craft: Armor, Hardened Armguard"))
definition:recipe("armor_ch_heavyarmguard", ccb.content.text(" Craft: Armor, Hardened Heavy Armguard"))
definition:recipe("armor_ch_lightarmguard", ccb.content.text(" Craft: Armor, Hardened Light Armguard"))
definition:recipe("armor_ch_chestplate", ccb.content.text(" Craft: Armor, Hardened Chestplate"))
definition:recipe("armor_ch_leg_guard", ccb.content.text(" Craft: Armor, Hardened Leg Guard"))
definition:recipe("armor_ch_heavyplate", ccb.content.text(" Craft: Armor, Hardened Heavy Plate"))
definition:recipe("armor_ch_lightplate", ccb.content.text(" Craft: Armor, Hardened Light Plate"))
definition:recipe("armor_ch_plate", ccb.content.text(" Craft: Armor, Hardened Plate"))
definition:recipe("armor_hc_heavy_chestplate", ccb.content.text(" Craft: Armor, High Steel Heavy Chestplate"))
definition:recipe("armor_hc_light_chestplate", ccb.content.text(" Craft: Armor, High Steel Light Chestplate"))
definition:recipe("armor_hc_heavy_leg_guard", ccb.content.text(" Craft: Armor, High Steel Heavy Leg Guard"))
definition:recipe("armor_hc_light_leg_guard", ccb.content.text(" Craft: Armor, High Steel Light Leg Guard"))
definition:recipe("armor_hc_armguard", ccb.content.text(" Craft: Armor, High Steel Armguard"))
definition:recipe("armor_hc_heavyarmguard", ccb.content.text(" Craft: Armor, High Steel Heavy Armguard"))
definition:recipe("armor_hc_lightarmguard", ccb.content.text(" Craft: Armor, High Steel Light Armguard"))
definition:recipe("armor_hc_chestplate", ccb.content.text(" Craft: Armor, High Steel Chestplate"))
definition:recipe("armor_hc_leg_guard", ccb.content.text(" Craft: Armor, High Steel Leg Guard"))
definition:recipe("armor_hc_heavyplate", ccb.content.text(" Craft: Armor, High Steel Heavy Plate"))
definition:recipe("armor_hc_lightplate", ccb.content.text(" Craft: Armor, High Steel Light Plate"))
definition:recipe("armor_hc_plate", ccb.content.text(" Craft: Armor, High Steel Plate"))
definition:recipe("armor_lc_heavy_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Heavy Chestplate"))
definition:recipe("armor_lc_light_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Light Chestplate"))
definition:recipe("armor_lc_heavy_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Heavy Leg Guard"))
definition:recipe("armor_lc_light_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Light Leg Guard"))
definition:recipe("armor_lc_armguard", ccb.content.text(" Craft: Armor, Mild Steel Armguard"))
definition:recipe("armor_lc_heavyarmguard", ccb.content.text(" Craft: Armor, Mild Steel Heavy Armguard"))
definition:recipe("armor_lc_lightarmguard", ccb.content.text(" Craft: Armor, Mild Steel Light Armguard"))
definition:recipe("armor_lc_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Chestplate"))
definition:recipe("armor_lc_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Leg Guard"))
definition:recipe("armor_lc_heavyplate", ccb.content.text(" Craft: Armor, Mild Steel Heavy Plate"))
definition:recipe("armor_lc_lightplate", ccb.content.text(" Craft: Armor, Mild Steel Light Plate"))
definition:recipe("armor_lc_plate", ccb.content.text(" Craft: Armor, Mild Steel Plate"))
definition:recipe("armor_mc_heavy_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Heavy Chestplate"))
definition:recipe("armor_mc_light_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Light Chestplate"))
definition:recipe("armor_mc_heavy_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Heavy Leg Guard"))
definition:recipe("armor_mc_light_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Light Leg Guard"))
definition:recipe("armor_mc_armguard", ccb.content.text(" Craft: Armor, Medium Steel Armguard"))
definition:recipe("armor_mc_heavyarmguard", ccb.content.text(" Craft: Armor, Medium Steel Heavy Armguard"))
definition:recipe("armor_mc_lightarmguard", ccb.content.text(" Craft: Armor, Medium Steel Light Armguard"))
definition:recipe("armor_mc_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Chestplate"))
definition:recipe("armor_mc_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Leg Guard"))
definition:recipe("armor_mc_heavyplate", ccb.content.text(" Craft: Armor, Medium Steel Heavy Plate"))
definition:recipe("armor_mc_lightplate", ccb.content.text(" Craft: Armor, Medium Steel Light Plate"))
definition:recipe("armor_mc_plate", ccb.content.text(" Craft: Armor, Medium Steel Plate"))
definition:recipe("armor_qt_heavy_chestplate", ccb.content.text(" Craft: Armor, Tempered Heavy Chestplate"))
definition:recipe("armor_qt_light_chestplate", ccb.content.text(" Craft: Armor, Tempered Light Chestplate"))
definition:recipe("armor_qt_heavy_leg_guard", ccb.content.text(" Craft: Armor, Tempered Heavy Leg Guard"))
definition:recipe("armor_qt_light_leg_guard", ccb.content.text(" Craft: Armor, Tempered Light Leg Guard"))
definition:recipe("armor_qt_armguard", ccb.content.text(" Craft: Armor, Tempered Armguard"))
definition:recipe("armor_qt_heavyarmguard", ccb.content.text(" Craft: Armor, Tempered Heavy Armguard"))
definition:recipe("armor_qt_lightarmguard", ccb.content.text(" Craft: Armor, Tempered Light Armguard"))
definition:recipe("armor_qt_chestplate", ccb.content.text(" Craft: Armor, Tempered Chestplate"))
definition:recipe("armor_qt_leg_guard", ccb.content.text(" Craft: Armor, Tempered Leg Guard"))
definition:recipe("armor_qt_heavyplate", ccb.content.text(" Craft: Armor, Tempered Heavy Plate"))
definition:recipe("armor_qt_lightplate", ccb.content.text(" Craft: Armor, Tempered Light Plate"))
definition:recipe("armor_qt_plate", ccb.content.text(" Craft: Armor, Tempered Plate"))
definition:recipe("ch_demi_gaunt", ccb.content.text(" Craft: Armor, Hardened Demi Gauntlet"))
definition:recipe("ch_helm_close", ccb.content.text(" Craft: Armor, Hardened Close Helm"))
definition:recipe("ch_mitten_gaunt", ccb.content.text(" Craft: Armor, Hardened Mitten Gauntlet"))
definition:recipe("ch_sabaton", ccb.content.text(" Craft: Armor, Hardened Sabaton"))
definition:recipe("hc_demi_gaunt", ccb.content.text(" Craft: Armor, High Steel Demi Gauntlet"))
definition:recipe("hc_helm_close", ccb.content.text(" Craft: Armor, High Steel Close Helm"))
definition:recipe("hc_mitten_gaunt", ccb.content.text(" Craft: Armor, High Steel Mitten Gauntlet"))
definition:recipe("hc_sabaton", ccb.content.text(" Craft: Armor, High Steel Sabaton"))
definition:recipe("lc_demi_gaunt", ccb.content.text(" Craft: Armor, Mild Steel Demi Gauntlet"))
definition:recipe("lc_helm_close", ccb.content.text(" Craft: Armor, Mild Steel Close Helm"))
definition:recipe("lc_mitten_gaunt", ccb.content.text(" Craft: Armor, Mild Steel Mitten Gauntlet"))
definition:recipe("lc_sabaton", ccb.content.text(" Craft: Armor, Mild Steel Sabaton"))
definition:recipe("mc_demi_gaunt", ccb.content.text(" Craft: Armor, Medium Steel Demi Gauntlet"))
definition:recipe("mc_helm_close", ccb.content.text(" Craft: Armor, Medium Steel Close Helm"))
definition:recipe("mc_mitten_gaunt", ccb.content.text(" Craft: Armor, Medium Steel Mitten Gauntlet"))
definition:recipe("mc_sabaton", ccb.content.text(" Craft: Armor, Medium Steel Sabaton"))
definition:recipe("qt_demi_gaunt", ccb.content.text(" Craft: Armor, Tempered Demi Gauntlet"))
definition:recipe("qt_helm_close", ccb.content.text(" Craft: Armor, Tempered Close Helm"))
definition:recipe("qt_mitten_gaunt", ccb.content.text(" Craft: Armor, Tempered Mitten Gauntlet"))
definition:recipe("qt_sabaton", ccb.content.text(" Craft: Armor, Tempered Sabaton"))
definition:recipe("xl_armor_ch_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Heavy Chestplate"))
definition:recipe("xl_armor_ch_light_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Light Chestplate"))
definition:recipe("xl_armor_ch_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Heavy Leg Guard"))
definition:recipe("xl_armor_ch_light_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Light Leg Guard"))
definition:recipe("xl_armor_ch_armguard", ccb.content.text(" Craft: Armor, XL Hardened Armguard"))
definition:recipe("xl_armor_ch_heavyarmguard", ccb.content.text(" Craft: Armor, XL Hardened Heavy Armguard"))
definition:recipe("xl_armor_ch_lightarmguard", ccb.content.text(" Craft: Armor, XL Hardened Light Armguard"))
definition:recipe("xl_armor_ch_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Chestplate"))
definition:recipe("xl_armor_ch_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Leg Guard"))
definition:recipe("xl_armor_ch_heavyplate", ccb.content.text(" Craft: Armor, XL Hardened Heavy Plate"))
definition:recipe("xl_armor_ch_lightplate", ccb.content.text(" Craft: Armor, XL Hardened Light Plate"))
definition:recipe("xl_armor_ch_plate", ccb.content.text(" Craft: Armor, XL Hardened Plate"))
definition:recipe("xl_armor_hc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Heavy Chestplate"))
definition:recipe("xl_armor_hc_light_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Light Chestplate"))
definition:recipe("xl_armor_hc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Heavy Leg Guard"))
definition:recipe("xl_armor_hc_light_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Light Leg Guard"))
definition:recipe("xl_armor_hc_armguard", ccb.content.text(" Craft: Armor, XL High Steel Armguard"))
definition:recipe("xl_armor_hc_heavyarmguard", ccb.content.text(" Craft: Armor, XL High Steel Heavy Armguard"))
definition:recipe("xl_armor_hc_lightarmguard", ccb.content.text(" Craft: Armor, XL High Steel Light Armguard"))
definition:recipe("xl_armor_hc_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Chestplate"))
definition:recipe("xl_armor_hc_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Leg Guard"))
definition:recipe("xl_armor_hc_heavyplate", ccb.content.text(" Craft: Armor, XL High Steel Heavy Plate"))
definition:recipe("xl_armor_hc_lightplate", ccb.content.text(" Craft: Armor, XL High Steel Light Plate"))
definition:recipe("xl_armor_hc_plate", ccb.content.text(" Craft: Armor, XL High Steel Plate"))
definition:recipe("xl_armor_lc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Chestplate"))
definition:recipe("xl_armor_lc_light_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Light Chestplate"))
definition:recipe("xl_armor_lc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Leg Guard"))
definition:recipe("xl_armor_lc_light_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Light Leg Guard"))
definition:recipe("xl_armor_lc_armguard", ccb.content.text(" Craft: Armor, XL Mild Steel Armguard"))
definition:recipe("xl_armor_lc_heavyarmguard", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Armguard"))
definition:recipe("xl_armor_lc_lightarmguard", ccb.content.text(" Craft: Armor, XL Mild Steel Light Armguard"))
definition:recipe("xl_armor_lc_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Chestplate"))
definition:recipe("xl_armor_lc_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Leg Guard"))
definition:recipe("xl_armor_lc_heavyplate", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Plate"))
definition:recipe("xl_armor_lc_lightplate", ccb.content.text(" Craft: Armor, XL Mild Steel Light Plate"))
definition:recipe("xl_armor_lc_plate", ccb.content.text(" Craft: Armor, XL Mild Steel Plate"))
definition:recipe("xl_armor_mc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Chestplate"))
definition:recipe("xl_armor_mc_light_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Light Chestplate"))
definition:recipe("xl_armor_mc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Leg Guard"))
definition:recipe("xl_armor_mc_light_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Light Leg Guard"))
definition:recipe("xl_armor_mc_armguard", ccb.content.text(" Craft: Armor, XL Medium Steel Armguard"))
definition:recipe("xl_armor_mc_heavyarmguard", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Armguard"))
definition:recipe("xl_armor_mc_lightarmguard", ccb.content.text(" Craft: Armor, XL Medium Steel Light Armguard"))
definition:recipe("xl_armor_mc_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Chestplate"))
definition:recipe("xl_armor_mc_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Leg Guard"))
definition:recipe("xl_armor_mc_heavyplate", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Plate"))
definition:recipe("xl_armor_mc_lightplate", ccb.content.text(" Craft: Armor, XL Medium Steel Light Plate"))
definition:recipe("xl_armor_mc_plate", ccb.content.text(" Craft: Armor, XL Medium Steel Plate"))
definition:recipe("xl_armor_qt_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Heavy Chestplate"))
definition:recipe("xl_armor_qt_light_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Light Chestplate"))
definition:recipe("xl_armor_qt_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Heavy Leg Guard"))
definition:recipe("xl_armor_qt_light_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Light Leg Guard"))
definition:recipe("xl_armor_qt_armguard", ccb.content.text(" Craft: Armor, XL Tempered Armguard"))
definition:recipe("xl_armor_qt_heavyarmguard", ccb.content.text(" Craft: Armor, XL Tempered Heavy Armguard"))
definition:recipe("xl_armor_qt_lightarmguard", ccb.content.text(" Craft: Armor, XL Tempered Light Armguard"))
definition:recipe("xl_armor_qt_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Chestplate"))
definition:recipe("xl_armor_qt_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Leg Guard"))
definition:recipe("xl_armor_qt_heavyplate", ccb.content.text(" Craft: Armor, XL Tempered Heavy Plate"))
definition:recipe("xl_armor_qt_lightplate", ccb.content.text(" Craft: Armor, XL Tempered Light Plate"))
definition:recipe("xl_armor_qt_plate", ccb.content.text(" Craft: Armor, XL Tempered Plate"))
definition:recipe("broadsword", ccb.content.text(" Craft: Sword, Medium Steel Broadsword"))
definition:recipe("mc_scimitar", ccb.content.text(" Craft: Sword, Medium Steel Shamshir"))
definition:recipe("fire_ax", ccb.content.text(" Craft: Axe, Fire"))
definition:recipe("hacksaw", ccb.content.text(" Craft: Hacksaw"))
definition:recipe("saw", ccb.content.text(" Craft: Woodsaw"))
definition:recipe("pike", ccb.content.text(" Craft: Spear, Awl Pike"))
definition:recipe("rapier", ccb.content.text(" Craft: Sword, Medium Steel Rapier"))
definition:recipe("halligan", ccb.content.text(" Craft: Halligan Bar"))
definition:recipe("mc_zweihander", ccb.content.text(" Craft: Sword, Medium Steel Zweihänder"))
definition:recipe("pickaxe", ccb.content.text(" Craft: Pickaxe"))
definition:recipe("hc_steel_lump", ccb.content.text(" Craft: High Steel, Lump"))
definition:recipe("hc_wire", ccb.content.text(" Craft: High Steel, Wire"))
definition:recipe("hc_chain_link_fabrication", ccb.content.text(" Craft: High Steel, Link"))
definition:recipe("hc_link_sheet", ccb.content.text(" Craft: High Steel, Link Sheet"))
definition:recipe("qt_wire", ccb.content.text(" Craft: Tempered Steel, Wire"))
definition:recipe("qt_chain_link_fabrication", ccb.content.text(" Craft: Tempered Steel, Link"))
definition:recipe("qt_link_sheet", ccb.content.text(" Craft: Tempered Steel, Link Sheet"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_blacksmith_recipes_6",
    building_type = "SMITH",
}
definition:recipe("sheet_metal_npc_drop", ccb.content.text(" Craft: Sheet Metal, Drop Hammer"))
definition:recipe("chain_npc_drop", ccb.content.text(" Craft: Chain, Drop Hammer"))
definition:recipe("nail_npc_drop", ccb.content.text(" Craft: Nail, Drop Hammer"))
definition:recipe("pipe_npc_drop", ccb.content.text(" Craft: Pipe, Drop Hammer"))
definition:recipe("rebar_npc_drop", ccb.content.text(" Craft: Rebar, Drop Hammer"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_glassblower_recipes_1",
    building_type = "SMITH",
}
definition:recipe("bottle_glass", ccb.content.text(" Craft: Bottle, Glass"))
definition:recipe("flask_glass", ccb.content.text(" Craft: Flask, Glass"))
definition:recipe("glass_sheet", ccb.content.text(" Craft: Sheet, Glass"))
definition:recipe("jar_3l_glass_sealed", ccb.content.text(" Craft: 3 L Jar, Glass"))
definition:recipe("jar_glass_sealed", ccb.content.text(" Craft: Jar, Glass"))
definition:recipe("tempered_glass_sheet", ccb.content.text(" Craft: Tempered Sheet, Glass"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fbmw_2_recipes_salt_water",
    building_type = "SMITH",
}
definition:recipe("cured_hide", ccb.content.text(" Hideworking: Cured Hide"))
definition:recipe("cured_pelt", ccb.content.text(" Hideworking: Cured Pelt"))
definition:recipe("tanning_hide_active", ccb.content.text(" Hideworking: Tanning Hide"))
definition:recipe("tanning_pelt_active", ccb.content.text(" Hideworking: Tanning Pelt"))
definition:recipe("tanned_hide", ccb.content.text(" Hideworking: Tanned Hide"))
definition:recipe("leather", ccb.content.text(" Hideworking: Leather"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "all_faction_base_types",
    building_type = "NONE",
}
definition:recipe("faction_base_modular_hub_field_0", ccb.content.text("Modular Field Camp version 1 (original version)"))
definition:terrain("faction_base_modular_hub_field_0", "field", "TYPE")
definition:terrain("faction_base_modular_hub_field_0", "rural_road", "TYPE")
definition:terrain("faction_base_modular_hub_field_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_modular_hub_field_0", "farmland", "PREFIX")
definition:terrain("faction_base_modular_hub_field_0", "hayfield", "PREFIX")
definition:recipe("faction_base_modular_hub_field_version_2_0", ccb.content.text("Modular Field Camp version 2 (no trenches, more beds, courtyards)"))
definition:terrain("faction_base_modular_hub_field_version_2_0", "field", "TYPE")
definition:terrain("faction_base_modular_hub_field_version_2_0", "rural_road", "TYPE")
definition:terrain("faction_base_modular_hub_field_version_2_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_modular_hub_field_version_2_0", "farmland", "PREFIX")
definition:terrain("faction_base_modular_hub_field_version_2_0", "hayfield", "PREFIX")
definition:recipe("faction_base_firestation_0", ccb.content.text("Firestation Base"))
definition:terrain("faction_base_firestation_0", "fire_station", "TYPE")
definition:recipe("faction_base_shelter_0", ccb.content.text("Evac Shelter Base"))
definition:terrain("faction_base_shelter_0", "shelter", "TYPE")
definition:terrain_parameter("faction_base_shelter_0", "shelter_layout", { "24x24_shelter" })
definition:recipe("faction_base_shelter_1_0", ccb.content.text("Evac Shelter Base"))
definition:terrain("faction_base_shelter_1_0", "shelter", "TYPE")
definition:terrain_parameter("faction_base_shelter_1_0", "shelter_layout", { "24x24_shelter_1" })
definition:recipe("faction_base_shelter_2_0", ccb.content.text("Evac Shelter Base"))
definition:terrain("faction_base_shelter_2_0", "shelter", "TYPE")
definition:terrain_parameter("faction_base_shelter_2_0", "shelter_layout", { "24x24_shelter_2" })
definition:recipe("faction_base_sealab_small_0", ccb.content.text("Freshwater Research Station Base"))
definition:terrain("faction_base_sealab_small_0", "sealab_small_-3", "TYPE")
definition:recipe("faction_base_lightindustry_0", ccb.content.text("Light Industry Office Base"))
definition:terrain("faction_base_lightindustry_0", "s_lightindustry_00", "TYPE")
definition:terrain("faction_base_lightindustry_0", "s_lightindustry_scen_00", "TYPE")
definition:recipe("faction_base_lightindustry_alt_0", ccb.content.text("Light Industry Office With Glass Walls Base"))
definition:terrain("faction_base_lightindustry_alt_0", "s_lightindustry_10", "TYPE")
definition:recipe("faction_base_helipad_0", ccb.content.text("Military Helipad Base"))
definition:terrain("faction_base_helipad_0", "helipad_nw", "TYPE")
definition:recipe("faction_base_outpost_normal_0", ccb.content.text("Normal Military Outpost Base"))
definition:terrain("faction_base_outpost_normal_0", "outpost", "TYPE")
definition:recipe("faction_base_lighthouse_0", ccb.content.text("Lighthouse Base"))
definition:terrain("faction_base_lighthouse_0", "lighthouse_ground", "TYPE")
definition:recipe("faction_base_pottery_cottage_0", ccb.content.text("Pottery Cottage Camp"))
definition:terrain("faction_base_pottery_cottage_0", "pottery_cottage", "TYPE")
definition:recipe("faction_base_radio_tower_0", ccb.content.text("Radio Tower Without Building Base"))
definition:terrain("faction_base_radio_tower_0", "radio_tower", "TYPE")
definition:recipe("faction_base_radio_tower_1_0", ccb.content.text("Radio Tower With Building Base"))
definition:terrain("faction_base_radio_tower_1_0", "radio_tower_1", "TYPE")
definition:recipe("faction_base_fire_lookout_tower_0", ccb.content.text("Fire Lookout Tower Base"))
definition:terrain("faction_base_fire_lookout_tower_0", "ws_fire_lookout_tower_base", "TYPE")
definition:recipe("faction_base_mansion_+1_0", ccb.content.text("Mansion Fountain Garden Base"))
definition:terrain("faction_base_mansion_+1_0", "mansion_+1", "TYPE")
definition:recipe("faction_base_mansion_+2_0", ccb.content.text("Mansion Dance Floor Room Base"))
definition:terrain("faction_base_mansion_+2_0", "mansion_+2", "TYPE")
definition:recipe("faction_base_mansion_+3_0", ccb.content.text("Mansion Basketball Room Base"))
definition:terrain("faction_base_mansion_+3_0", "mansion_+3", "TYPE")
definition:recipe("faction_base_mansion_+4_0", ccb.content.text("Mansion Garden With Columns Base"))
definition:terrain("faction_base_mansion_+4_0", "mansion_+4", "TYPE")
definition:recipe("faction_base_bare_bones_basecamp_0", ccb.content.text("Faction Base Bare Bones Basecamp.  Manually add bulletin board to use.  No construction.  Can be constructed anywhere.  Access to crafting recipes using Supplies zone covered furniture and appliances."))
definition:terrain("faction_base_bare_bones_basecamp_0", "ANY", "TYPE")
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "all_faction_base_expansions",
    building_type = "NONE",
}
definition:recipe("faction_base_canteen_0", ccb.content.text("Canteen version 1.  Provides cooking recipes, stoves, well, cellar"))
definition:terrain("faction_base_canteen_0", "field", "TYPE")
definition:terrain("faction_base_canteen_0", "rural_road", "TYPE")
definition:terrain("faction_base_canteen_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_canteen_0", "farmland", "PREFIX")
definition:terrain("faction_base_canteen_0", "hayfield", "PREFIX")
definition:recipe("faction_base_canteen_2_0", ccb.content.text("Canteen version 2.  Version 1 plus still, windmill, and more planters"))
definition:terrain("faction_base_canteen_2_0", "field", "TYPE")
definition:terrain("faction_base_canteen_2_0", "rural_road", "TYPE")
definition:terrain("faction_base_canteen_2_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_canteen_2_0", "farmland", "PREFIX")
definition:terrain("faction_base_canteen_2_0", "hayfield", "PREFIX")
definition:recipe("faction_base_farm_0", ccb.content.text("Farm version 1.  Shed, plots, some farming recipes"))
definition:terrain("faction_base_farm_0", "field", "TYPE")
definition:terrain("faction_base_farm_0", "rural_road", "TYPE")
definition:terrain("faction_base_farm_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_farm_0", "farmland", "PREFIX")
definition:terrain("faction_base_farm_0", "hayfield", "PREFIX")
definition:recipe("faction_base_farm_2_0", ccb.content.text("Farm version 2.  Just plots, fence (optional gate for tractor), processing recipes"))
definition:terrain("faction_base_farm_2_0", "field", "TYPE")
definition:terrain("faction_base_farm_2_0", "rural_road", "TYPE")
definition:terrain("faction_base_farm_2_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_farm_2_0", "farmland", "PREFIX")
definition:terrain("faction_base_farm_2_0", "hayfield", "PREFIX")
definition:recipe("faction_base_garage_0", ccb.content.text("Garage version 1.  Fits reasonably sized vehicles, free space around it"))
definition:terrain("faction_base_garage_0", "field", "TYPE")
definition:terrain("faction_base_garage_0", "rural_road", "TYPE")
definition:terrain("faction_base_garage_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_garage_0", "farmland", "PREFIX")
definition:terrain("faction_base_garage_0", "hayfield", "PREFIX")
definition:recipe("faction_base_garage_2_0", ccb.content.text("Garage version 2.  Maximum width, two lane size, three different lengths"))
definition:terrain("faction_base_garage_2_0", "field", "TYPE")
definition:terrain("faction_base_garage_2_0", "rural_road", "TYPE")
definition:terrain("faction_base_garage_2_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_garage_2_0", "farmland", "PREFIX")
definition:terrain("faction_base_garage_2_0", "hayfield", "PREFIX")
definition:recipe("faction_base_livestock_0", ccb.content.text("Livestock Area version 1.  Layout with plenty of free space"))
definition:terrain("faction_base_livestock_0", "field", "TYPE")
definition:terrain("faction_base_livestock_0", "rural_road", "TYPE")
definition:terrain("faction_base_livestock_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_livestock_0", "farmland", "PREFIX")
definition:terrain("faction_base_livestock_0", "hayfield", "PREFIX")
definition:recipe("faction_base_livestock_2_0", ccb.content.text("Livestock Area version 2.  More stalls than version 1, less free space"))
definition:terrain("faction_base_livestock_2_0", "field", "TYPE")
definition:terrain("faction_base_livestock_2_0", "rural_road", "TYPE")
definition:terrain("faction_base_livestock_2_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_livestock_2_0", "farmland", "PREFIX")
definition:terrain("faction_base_livestock_2_0", "hayfield", "PREFIX")
definition:recipe("faction_base_storehouse_0", ccb.content.text("Central Storage Building version 1.  Nice building with free space"))
definition:terrain("faction_base_storehouse_0", "field", "TYPE")
definition:terrain("faction_base_storehouse_0", "rural_road", "TYPE")
definition:terrain("faction_base_storehouse_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_storehouse_0", "farmland", "PREFIX")
definition:terrain("faction_base_storehouse_0", "hayfield", "PREFIX")
definition:recipe("faction_base_storehouse_2_0", ccb.content.text("Central Storage Building version 2.  Focus on storage.  Place in N, E, S, W only"))
definition:terrain("faction_base_storehouse_2_0", "field", "TYPE")
definition:terrain("faction_base_storehouse_2_0", "rural_road", "TYPE")
definition:terrain("faction_base_storehouse_2_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_storehouse_2_0", "farmland", "PREFIX")
definition:terrain("faction_base_storehouse_2_0", "hayfield", "PREFIX")
definition:recipe("faction_base_workshop_0", ccb.content.text("Fabrication Workshop version 1.  Nice workshop cottage"))
definition:terrain("faction_base_workshop_0", "field", "TYPE")
definition:terrain("faction_base_workshop_0", "rural_road", "TYPE")
definition:terrain("faction_base_workshop_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_workshop_0", "farmland", "PREFIX")
definition:terrain("faction_base_workshop_0", "hayfield", "PREFIX")
definition:recipe("faction_base_workshop_2_0", ccb.content.text("Fabrication Workshop version 2.  More detailed recipe progression"))
definition:terrain("faction_base_workshop_2_0", "field", "TYPE")
definition:terrain("faction_base_workshop_2_0", "rural_road", "TYPE")
definition:terrain("faction_base_workshop_2_0", "dirt_road_farm_parking", "TYPE")
definition:terrain("faction_base_workshop_2_0", "farmland", "PREFIX")
definition:terrain("faction_base_workshop_2_0", "hayfield", "PREFIX")
definition:recipe("faction_base_lightindustry_workshop_0", ccb.content.text("Light Industry Workshop"))
definition:terrain("faction_base_lightindustry_workshop_0", "s_lightindustry_11", "TYPE")
definition:terrain("faction_base_lightindustry_workshop_0", "s_lightindustry_01", "TYPE")
definition:terrain("faction_base_lightindustry_workshop_0", "s_lightindustry_scen_11", "TYPE")
definition:terrain("faction_base_lightindustry_workshop_0", "s_lightindustry_scen_01", "TYPE")
definition:recipe("faction_base_helipad_garage_0", ccb.content.text("Military Helipad Garage"))
definition:terrain("faction_base_helipad_garage_0", "helipad_ne", "TYPE")
definition:recipe("faction_base_mansion_e1", ccb.content.text("Mansion's Entrance"))
definition:terrain("faction_base_mansion_e1", "mansion_e1", "TYPE")
definition:recipe("faction_base_mansion_e2", ccb.content.text("Mansion's Entrance"))
definition:terrain("faction_base_mansion_e2", "mansion_e2", "TYPE")
definition:recipe("faction_base_mansion_t1", ccb.content.text("Mansion's Swimming Pool"))
definition:terrain("faction_base_mansion_t1", "mansion_t1", "TYPE")
definition:recipe("faction_base_mansion_t2", ccb.content.text("Mansion's Bedrooms"))
definition:terrain("faction_base_mansion_t2", "mansion_t2", "TYPE")
definition:recipe("faction_base_mansion_t3", ccb.content.text("Mansion's???"))
definition:terrain("faction_base_mansion_t3", "mansion_t3", "TYPE")
definition:recipe("faction_base_mansion_t4", ccb.content.text("Mansion's Kitchen"))
definition:terrain("faction_base_mansion_t4", "mansion_t4", "TYPE")
definition:recipe("faction_base_mansion_t5", ccb.content.text("Mansion's Library"))
definition:terrain("faction_base_mansion_t5", "mansion_t5", "TYPE")
definition:recipe("faction_base_mansion_t6", ccb.content.text("Mansion's Bedroom"))
definition:terrain("faction_base_mansion_t6", "mansion_t6", "TYPE")
definition:recipe("faction_base_mansion_t7", ccb.content.text("Mansion's Living Rooms"))
definition:terrain("faction_base_mansion_t7", "mansion_t7", "TYPE")
definition:recipe("faction_base_mansion_c1", ccb.content.text("Mansion's Swimming Pool"))
definition:terrain("faction_base_mansion_c1", "mansion_c1", "TYPE")
definition:recipe("faction_base_mansion_c2", ccb.content.text("Mansion's Bar"))
definition:terrain("faction_base_mansion_c2", "mansion_c2", "TYPE")
definition:recipe("faction_base_mansion_c3", ccb.content.text("Mansion's Living Rooms"))
definition:terrain("faction_base_mansion_c3", "mansion_c3", "TYPE")
definition:recipe("faction_base_mansion_c4", ccb.content.text("Mansion's Bedroom"))
definition:terrain("faction_base_mansion_c4", "mansion_c4", "TYPE")
definition:recipe("faction_base_mansion_c5", ccb.content.text("Mansion's Kitchen"))
definition:terrain("faction_base_mansion_c5", "mansion_c5", "TYPE")
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "kitchen_recipes_1",
    building_type = "COOK",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("meat_cooked", ccb.content.text(" Cook: Meat, Cooked"))
definition:recipe("fish_cooked", ccb.content.text(" Cook: Fish, Cooked"))
definition:recipe("veggy_cooked", ccb.content.text(" Cook: Veggy, Cooked"))
definition:recipe("boiled_egg", ccb.content.text(" Cook: Egg, Boiled"))
definition:recipe("starch", ccb.content.text(" Cook: Starch"))
definition:recipe("water_clean", ccb.content.text(" Boil: Water"))
definition:recipe("starch_from_fibrous_stuff", ccb.content.text(" Cook: Cattail Starch"))
definition:recipe("flatbread", ccb.content.text(" Cook: Flatbread"))
definition:recipe("veggy_wild_cooked", ccb.content.text(" Cook: Veggy, Cooked Wild"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "kitchen_recipes_2",
    building_type = "COOK",
}
definition:recipe("flour", ccb.content.text(" Cook: Flour"))
definition:recipe("salt", ccb.content.text(" Cook: Salt"))
definition:recipe("bread", ccb.content.text(" Cook: Bread"))
definition:recipe("fruit_leather", ccb.content.text(" Cook: Fruit Leather"))
definition:recipe("jerky", ccb.content.text(" Cook: Meat Jerky"))
definition:recipe("mushroom_cooked", ccb.content.text(" Cook: Mushroom, Cooked"))
definition:recipe("cornmeal", ccb.content.text(" Cook: Cornmeal"))
definition:recipe("meat_smoked", ccb.content.text(" Cook: Meat, Smoked"))
definition:recipe("fish_smoked", ccb.content.text(" Cook: Fish, Smoked"))
definition:recipe("dry_mushroom", ccb.content.text(" Cook: Mushroom, Dried"))
definition:recipe("dry_fruit", ccb.content.text(" Cook: Fruit, Dehydrated"))
definition:recipe("sausage", ccb.content.text(" Cook: Sausage"))
definition:recipe("sausage_wasteland", ccb.content.text(" Cook: Sausage, Wasteland"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "kitchen_recipes_3",
    building_type = "COOK",
}
definition:recipe("pie_meat", ccb.content.text(" Cook: Meat Pie"))
definition:recipe("pie_veggy", ccb.content.text(" Cook: Veggy Pie"))
definition:recipe("sugar", ccb.content.text(" Cook: Sugar"))
definition:recipe("hardtack", ccb.content.text(" Cook: Hardtack"))
definition:recipe("veggy_pickled_jarred", ccb.content.text(" Cook: Veggy, Pickled"))
definition:recipe("cheese_hard", ccb.content.text(" Cook: Cheese, Hard"))
definition:recipe("pemmican", ccb.content.text(" Cook: Pemmican, Meat + Berries"))
definition:recipe("pemmican_veggy", ccb.content.text(" Cook: Pemmican, Meat + Veg"))
definition:recipe("veggy_aspic", ccb.content.text(" Cook: Veggy Aspic"))
definition:recipe("meat_canned_jarred", ccb.content.text(" Cook: Meat, Canned"))
definition:recipe("meat_aspic", ccb.content.text(" Cook: Meat Aspic"))
definition:recipe("kompot", ccb.content.text(" Cook: Kompot"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "saltworks_recipes_1",
    building_type = "COOK",
}
definition:recipe("salt_from_salt_water", ccb.content.text(" Craft: Salt from salt water"))
definition:recipe("salted_fish", ccb.content.text(" Cook: Fish, Salted"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "saltworks_recipes_2",
    building_type = "COOK",
}
definition:recipe("brew_fruit_wine", ccb.content.text("Brew: Fruit Wine Must"))
definition:recipe("brew_mead", ccb.content.text("Brew: Spiced Wine Must"))
definition:recipe("brew_dandelion_wine", ccb.content.text("Brew: Dandelion Wine Must"))
definition:recipe("brew_burdock_wine", ccb.content.text("Brew: Burdock Wine Must"))
definition:recipe("brew_pine_wine", ccb.content.text("Brew: Pine Wine Must"))
definition:recipe("brew_hb_beer", ccb.content.text("Brew: Beer"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "saltworks_recipes_3",
    building_type = "COOK",
}
definition:recipe("brandy", ccb.content.text("Distill: Brandy"))
definition:recipe("gin_from_mash", ccb.content.text("Distill: Gin"))
definition:recipe("vodka_from_wash", ccb.content.text("Distill: Vodka"))
definition:recipe("rum", ccb.content.text("Distill: Rum"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "primitive_camp_recipes_1",
    building_type = "BASE",
}
definition:recipe("tinder", ccb.content.text(" Craft: Tinder"))
definition:recipe("pointy_stick", ccb.content.text(" Craft: Pointy Sticks"))
definition:recipe("wood_panel_from nailed planks", ccb.content.text(" Craft: Wooden Panel, Nailed Planks"))
definition:recipe("wood_panel_from wooden beams", ccb.content.text(" Craft: Wooden Panel, Wooden Beams"))
definition:recipe("wood_beam_from logs", ccb.content.text(" Craft: Wooden Beam"))
definition:recipe("2x4_from logs", ccb.content.text(" Craft: Wooden Plank"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "farm_recipes_1",
    building_type = "FARM",
}
definition:recipe("seed_veggy_wild", ccb.content.text(" Craft: Wild Veggy Stems"))
definition:recipe("seed_raw_dandelion", ccb.content.text(" Craft: Dandelion Seeds"))
definition:recipe("seed_potato_raw", ccb.content.text(" Craft: Potato, Starter"))
definition:recipe("seed_buckwheat", ccb.content.text(" Craft: Buckwheat Seeds"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "blacksmith_recipes_1",
    building_type = "SMITH",
}
definition:recipe("scrap_copper", ccb.content.text(" Craft: Copper, Scrap"))
definition:recipe("charcoal_npc", ccb.content.text(" Craft: Charcoal"))
definition:recipe("spike", ccb.content.text(" Craft: Spike"))
definition:recipe("caltrops_glass", ccb.content.text(" Craft: Glass Caltrops"))
definition:recipe("steel_chunk", ccb.content.text(" Craft: Steel, Chunk"))
definition:recipe("anvil_crude", ccb.content.text(" Craft: Small Anvil"))
definition:recipe("steel_lump", ccb.content.text(" Craft: Steel, Lump"))
definition:recipe("lc_steel_lump", ccb.content.text(" Craft: Mild Steel, Lump"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "blacksmith_recipes_2",
    building_type = "SMITH",
}
definition:recipe("copper_knife", ccb.content.text(" Craft: Knife, Copper"))
definition:recipe("sword_crude", ccb.content.text(" Craft: Sword, Crude"))
definition:recipe("pot_copper", ccb.content.text(" Craft: Pot, Copper"))
definition:recipe("bolt_metal", ccb.content.text(" Craft: Crossbow Bolt, Steel"))
definition:recipe("armor_scrapsuit", ccb.content.text(" Craft: Armor, Scrap Suit"))
definition:recipe("helmet_scrap", ccb.content.text(" Craft: Armor, Scrap Helmet"))
definition:recipe("cuirass_scrap", ccb.content.text(" Craft: Armor, Scrap Cuirass"))
definition:recipe("armguard_scrap", ccb.content.text(" Craft: Armor, Scrap Arm Guards"))
definition:recipe("legguard_scrap", ccb.content.text(" Craft: Armor, Scrap Leg Guards"))
definition:recipe("boots_scrap", ccb.content.text(" Craft: Armor, Scrap Boots"))
definition:recipe("copper_ax", ccb.content.text(" Craft: Axe, Copper"))
definition:recipe("spear_copper", ccb.content.text(" Craft: Spear, Copper"))
definition:recipe("lc_wire", ccb.content.text(" Craft: Mild Steel, Wire"))
definition:recipe("lc_chain_link_fabrication", ccb.content.text(" Craft: Mild Steel, Link"))
definition:recipe("lc_link_sheet", ccb.content.text(" Craft: Mild Steel, Link Sheet"))
definition:recipe("mc_steel_lump", ccb.content.text(" Craft: Medium Steel, Lump"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "blacksmith_recipes_3",
    building_type = "SMITH",
}
definition:recipe("chisel", ccb.content.text(" Craft: Metalworking Chisel"))
definition:recipe("hammer", ccb.content.text(" Craft: Hammer"))
definition:recipe("tongs", ccb.content.text(" Craft: Pair of Kitchen Tongs"))
definition:recipe("nail", ccb.content.text(" Craft: Nail"))
definition:recipe("swage", ccb.content.text(" Craft: Swage and Die Set"))
definition:recipe("mc_wire", ccb.content.text(" Craft: Medium Steel, Wire"))
definition:recipe("mc_chain_link_fabrication", ccb.content.text(" Craft: Medium Steel, Link"))
definition:recipe("mc_link_sheet", ccb.content.text(" Craft: Medium Steel, Link Sheet"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "blacksmith_recipes_4",
    building_type = "SMITH",
}
definition:recipe("blade", ccb.content.text(" Craft: Blade"))
definition:recipe("bearing", ccb.content.text(" Craft: Bearings"))
definition:recipe("caltrops", ccb.content.text(" Craft: Caltrops"))
definition:recipe("hand_drill", ccb.content.text(" Craft: Hand Drill"))
definition:recipe("sheet_metal", ccb.content.text(" Craft: Sheet Metal"))
definition:recipe("chain", ccb.content.text(" Craft: Chain"))
definition:recipe("shovel", ccb.content.text(" Craft: Shovel"))
definition:recipe("welding_rod_steel", ccb.content.text(" Craft: Steel Welding Rod"))
definition:recipe("rebar", ccb.content.text(" Craft: Rebar"))
definition:recipe("gold_ring", ccb.content.text(" Craft: Gold Ring"))
definition:recipe("hammer_sledge_from_scratch", ccb.content.text(" Craft: Hammer, Sledge"))
definition:recipe("ch_wire", ccb.content.text(" Craft: Hardened Steel, Wire"))
definition:recipe("ch_chain_link_fabrication", ccb.content.text(" Craft: Hardened Steel, Link"))
definition:recipe("ch_link_sheet", ccb.content.text(" Craft: Hardened Steel, Link Sheet"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "blacksmith_recipes_5",
    building_type = "SMITH",
}
definition:recipe("knife_combat", ccb.content.text(" Craft: Knife, Combat"))
definition:recipe("spear_steel", ccb.content.text(" Craft: Spear, Steel"))
definition:recipe("machete", ccb.content.text(" Craft: Machete"))
definition:recipe("pipe", ccb.content.text(" Craft: Pipe"))
definition:recipe("screwdriver", ccb.content.text(" Craft: Screwdriver"))
definition:recipe("throwing_axe", ccb.content.text(" Craft: Axe, Throwing"))
definition:recipe("wrench", ccb.content.text(" Craft: Wrench"))
definition:recipe("hatchet", ccb.content.text(" Craft: Hatchet"))
definition:recipe("throwing_knife", ccb.content.text(" Craft: Knife, Throwing"))
definition:recipe("crowbar", ccb.content.text(" Craft: Crowbar"))
definition:recipe("pot", ccb.content.text(" Craft: Pot"))
definition:recipe("hoe", ccb.content.text(" Craft: Hoe"))
definition:recipe("hc_steel_lump", ccb.content.text(" Craft: High Steel, Lump"))
definition:recipe("hc_wire", ccb.content.text(" Craft: High Steel, Wire"))
definition:recipe("hc_chain_link_fabrication", ccb.content.text(" Craft: High Steel, Link"))
definition:recipe("hc_link_sheet", ccb.content.text(" Craft: High Steel, Link Sheet"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "blacksmith_recipes_6",
    building_type = "SMITH",
}
definition:recipe("pliers", ccb.content.text(" Craft: Pliers"))
definition:recipe("halberd", ccb.content.text(" Craft: Halberd"))
definition:recipe("cuirass_lightplate", ccb.content.text(" Craft: Armor, Cuirass"))
definition:recipe("pockknife", ccb.content.text(" Craft: Knife, Pocket"))
definition:recipe("warhammer", ccb.content.text(" Craft: Hammer, War"))
definition:recipe("helmet_plate", ccb.content.text(" Craft: Helm, Great"))
definition:recipe("armor_ch_heavy_chestplate", ccb.content.text(" Craft: Armor, Hardened Heavy Chestplate"))
definition:recipe("armor_ch_light_chestplate", ccb.content.text(" Craft: Armor, Hardened Light Chestplate"))
definition:recipe("armor_ch_heavy_leg_guard", ccb.content.text(" Craft: Armor, Hardened Heavy Leg Guard"))
definition:recipe("armor_ch_light_leg_guard", ccb.content.text(" Craft: Armor, Hardened Light Leg Guard"))
definition:recipe("armor_ch_armguard", ccb.content.text(" Craft: Armor, Hardened Armguard"))
definition:recipe("armor_ch_heavyarmguard", ccb.content.text(" Craft: Armor, Hardened Heavy Armguard"))
definition:recipe("armor_ch_lightarmguard", ccb.content.text(" Craft: Armor, Hardened Light Armguard"))
definition:recipe("armor_ch_chestplate", ccb.content.text(" Craft: Armor, Hardened Chestplate"))
definition:recipe("armor_ch_leg_guard", ccb.content.text(" Craft: Armor, Hardened Leg Guard"))
definition:recipe("armor_ch_heavyplate", ccb.content.text(" Craft: Armor, Hardened Heavy Plate"))
definition:recipe("armor_ch_lightplate", ccb.content.text(" Craft: Armor, Hardened Light Plate"))
definition:recipe("armor_ch_plate", ccb.content.text(" Craft: Armor, Hardened Plate"))
definition:recipe("armor_hc_heavy_chestplate", ccb.content.text(" Craft: Armor, High Steel Heavy Chestplate"))
definition:recipe("armor_hc_light_chestplate", ccb.content.text(" Craft: Armor, High Steel Light Chestplate"))
definition:recipe("armor_hc_heavy_leg_guard", ccb.content.text(" Craft: Armor, High Steel Heavy Leg Guard"))
definition:recipe("armor_hc_light_leg_guard", ccb.content.text(" Craft: Armor, High Steel Light Leg Guard"))
definition:recipe("armor_hc_armguard", ccb.content.text(" Craft: Armor, High Steel Armguard"))
definition:recipe("armor_hc_heavyarmguard", ccb.content.text(" Craft: Armor, High Steel Heavy Armguard"))
definition:recipe("armor_hc_lightarmguard", ccb.content.text(" Craft: Armor, High Steel Light Armguard"))
definition:recipe("armor_hc_chestplate", ccb.content.text(" Craft: Armor, High Steel Chestplate"))
definition:recipe("armor_hc_leg_guard", ccb.content.text(" Craft: Armor, High Steel Leg Guard"))
definition:recipe("armor_hc_heavyplate", ccb.content.text(" Craft: Armor, High Steel Heavy Plate"))
definition:recipe("armor_hc_lightplate", ccb.content.text(" Craft: Armor, High Steel Light Plate"))
definition:recipe("armor_hc_plate", ccb.content.text(" Craft: Armor, High Steel Plate"))
definition:recipe("armor_lc_heavy_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Heavy Chestplate"))
definition:recipe("armor_lc_light_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Light Chestplate"))
definition:recipe("armor_lc_heavy_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Heavy Leg Guard"))
definition:recipe("armor_lc_light_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Light Leg Guard"))
definition:recipe("armor_lc_armguard", ccb.content.text(" Craft: Armor, Mild Steel Armguard"))
definition:recipe("armor_lc_heavyarmguard", ccb.content.text(" Craft: Armor, Mild Steel Heavy Armguard"))
definition:recipe("armor_lc_lightarmguard", ccb.content.text(" Craft: Armor, Mild Steel Light Armguard"))
definition:recipe("armor_lc_chestplate", ccb.content.text(" Craft: Armor, Mild Steel Chestplate"))
definition:recipe("armor_lc_leg_guard", ccb.content.text(" Craft: Armor, Mild Steel Leg Guard"))
definition:recipe("armor_lc_heavyplate", ccb.content.text(" Craft: Armor, Mild Steel Heavy Plate"))
definition:recipe("armor_lc_lightplate", ccb.content.text(" Craft: Armor, Mild Steel Light Plate"))
definition:recipe("armor_lc_plate", ccb.content.text(" Craft: Armor, Mild Steel Plate"))
definition:recipe("armor_mc_heavy_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Heavy Chestplate"))
definition:recipe("armor_mc_light_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Light Chestplate"))
definition:recipe("armor_mc_heavy_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Heavy Leg Guard"))
definition:recipe("armor_mc_light_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Light Leg Guard"))
definition:recipe("armor_mc_armguard", ccb.content.text(" Craft: Armor, Medium Steel Armguard"))
definition:recipe("armor_mc_heavyarmguard", ccb.content.text(" Craft: Armor, Medium Steel Heavy Armguard"))
definition:recipe("armor_mc_lightarmguard", ccb.content.text(" Craft: Armor, Medium Steel Light Armguard"))
definition:recipe("armor_mc_chestplate", ccb.content.text(" Craft: Armor, Medium Steel Chestplate"))
definition:recipe("armor_mc_leg_guard", ccb.content.text(" Craft: Armor, Medium Steel Leg Guard"))
definition:recipe("armor_mc_heavyplate", ccb.content.text(" Craft: Armor, Medium Steel Heavy Plate"))
definition:recipe("armor_mc_lightplate", ccb.content.text(" Craft: Armor, Medium Steel Light Plate"))
definition:recipe("armor_mc_plate", ccb.content.text(" Craft: Armor, Medium Steel Plate"))
definition:recipe("armor_qt_heavy_chestplate", ccb.content.text(" Craft: Armor, Tempered Heavy Chestplate"))
definition:recipe("armor_qt_light_chestplate", ccb.content.text(" Craft: Armor, Tempered Light Chestplate"))
definition:recipe("armor_qt_heavy_leg_guard", ccb.content.text(" Craft: Armor, Tempered Heavy Leg Guard"))
definition:recipe("armor_qt_light_leg_guard", ccb.content.text(" Craft: Armor, Tempered Light Leg Guard"))
definition:recipe("armor_qt_armguard", ccb.content.text(" Craft: Armor, Tempered Armguard"))
definition:recipe("armor_qt_heavyarmguard", ccb.content.text(" Craft: Armor, Tempered Heavy Armguard"))
definition:recipe("armor_qt_lightarmguard", ccb.content.text(" Craft: Armor, Tempered Light Armguard"))
definition:recipe("armor_qt_chestplate", ccb.content.text(" Craft: Armor, Tempered Chestplate"))
definition:recipe("armor_qt_leg_guard", ccb.content.text(" Craft: Armor, Tempered Leg Guard"))
definition:recipe("armor_qt_heavyplate", ccb.content.text(" Craft: Armor, Tempered Heavy Plate"))
definition:recipe("armor_qt_lightplate", ccb.content.text(" Craft: Armor, Tempered Light Plate"))
definition:recipe("armor_qt_plate", ccb.content.text(" Craft: Armor, Tempered Plate"))
definition:recipe("ch_demi_gaunt", ccb.content.text(" Craft: Armor, Hardened Demi Gauntlet"))
definition:recipe("ch_helm_close", ccb.content.text(" Craft: Armor, Hardened Close Helm"))
definition:recipe("ch_mitten_gaunt", ccb.content.text(" Craft: Armor, Hardened Mitten Gauntlet"))
definition:recipe("ch_sabaton", ccb.content.text(" Craft: Armor, Hardened Sabaton"))
definition:recipe("hc_demi_gaunt", ccb.content.text(" Craft: Armor, High Steel Demi Gauntlet"))
definition:recipe("hc_helm_close", ccb.content.text(" Craft: Armor, High Steel Close Helm"))
definition:recipe("hc_mitten_gaunt", ccb.content.text(" Craft: Armor, High Steel Mitten Gauntlet"))
definition:recipe("hc_sabaton", ccb.content.text(" Craft: Armor, High Steel Sabaton"))
definition:recipe("lc_demi_gaunt", ccb.content.text(" Craft: Armor, Mild Steel Demi Gauntlet"))
definition:recipe("lc_helm_close", ccb.content.text(" Craft: Armor, Mild Steel Close Helm"))
definition:recipe("lc_mitten_gaunt", ccb.content.text(" Craft: Armor, Mild Steel Mitten Gauntlet"))
definition:recipe("lc_sabaton", ccb.content.text(" Craft: Armor, Mild Steel Sabaton"))
definition:recipe("mc_demi_gaunt", ccb.content.text(" Craft: Armor, Medium Steel Demi Gauntlet"))
definition:recipe("mc_helm_close", ccb.content.text(" Craft: Armor, Medium Steel Close Helm"))
definition:recipe("mc_mitten_gaunt", ccb.content.text(" Craft: Armor, Medium Steel Mitten Gauntlet"))
definition:recipe("mc_sabaton", ccb.content.text(" Craft: Armor, Medium Steel Sabaton"))
definition:recipe("qt_demi_gaunt", ccb.content.text(" Craft: Armor, Tempered Demi Gauntlet"))
definition:recipe("qt_helm_close", ccb.content.text(" Craft: Armor, Tempered Close Helm"))
definition:recipe("qt_mitten_gaunt", ccb.content.text(" Craft: Armor, Tempered Mitten Gauntlet"))
definition:recipe("qt_sabaton", ccb.content.text(" Craft: Armor, Tempered Sabaton"))
definition:recipe("xl_armor_ch_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Heavy Chestplate"))
definition:recipe("xl_armor_ch_light_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Light Chestplate"))
definition:recipe("xl_armor_ch_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Heavy Leg Guard"))
definition:recipe("xl_armor_ch_light_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Light Leg Guard"))
definition:recipe("xl_armor_ch_armguard", ccb.content.text(" Craft: Armor, XL Hardened Armguard"))
definition:recipe("xl_armor_ch_heavyarmguard", ccb.content.text(" Craft: Armor, XL Hardened Heavy Armguard"))
definition:recipe("xl_armor_ch_lightarmguard", ccb.content.text(" Craft: Armor, XL Hardened Light Armguard"))
definition:recipe("xl_armor_ch_chestplate", ccb.content.text(" Craft: Armor, XL Hardened Chestplate"))
definition:recipe("xl_armor_ch_leg_guard", ccb.content.text(" Craft: Armor, XL Hardened Leg Guard"))
definition:recipe("xl_armor_ch_heavyplate", ccb.content.text(" Craft: Armor, XL Hardened Heavy Plate"))
definition:recipe("xl_armor_ch_lightplate", ccb.content.text(" Craft: Armor, XL Hardened Light Plate"))
definition:recipe("xl_armor_ch_plate", ccb.content.text(" Craft: Armor, XL Hardened Plate"))
definition:recipe("xl_armor_hc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Heavy Chestplate"))
definition:recipe("xl_armor_hc_light_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Light Chestplate"))
definition:recipe("xl_armor_hc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Heavy Leg Guard"))
definition:recipe("xl_armor_hc_light_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Light Leg Guard"))
definition:recipe("xl_armor_hc_armguard", ccb.content.text(" Craft: Armor, XL High Steel Armguard"))
definition:recipe("xl_armor_hc_heavyarmguard", ccb.content.text(" Craft: Armor, XL High Steel Heavy Armguard"))
definition:recipe("xl_armor_hc_lightarmguard", ccb.content.text(" Craft: Armor, XL High Steel Light Armguard"))
definition:recipe("xl_armor_hc_chestplate", ccb.content.text(" Craft: Armor, XL High Steel Chestplate"))
definition:recipe("xl_armor_hc_leg_guard", ccb.content.text(" Craft: Armor, XL High Steel Leg Guard"))
definition:recipe("xl_armor_hc_heavyplate", ccb.content.text(" Craft: Armor, XL High Steel Heavy Plate"))
definition:recipe("xl_armor_hc_lightplate", ccb.content.text(" Craft: Armor, XL High Steel Light Plate"))
definition:recipe("xl_armor_hc_plate", ccb.content.text(" Craft: Armor, XL High Steel Plate"))
definition:recipe("xl_armor_lc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Chestplate"))
definition:recipe("xl_armor_lc_light_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Light Chestplate"))
definition:recipe("xl_armor_lc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Leg Guard"))
definition:recipe("xl_armor_lc_light_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Light Leg Guard"))
definition:recipe("xl_armor_lc_armguard", ccb.content.text(" Craft: Armor, XL Mild Steel Armguard"))
definition:recipe("xl_armor_lc_heavyarmguard", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Armguard"))
definition:recipe("xl_armor_lc_lightarmguard", ccb.content.text(" Craft: Armor, XL Mild Steel Light Armguard"))
definition:recipe("xl_armor_lc_chestplate", ccb.content.text(" Craft: Armor, XL Mild Steel Chestplate"))
definition:recipe("xl_armor_lc_leg_guard", ccb.content.text(" Craft: Armor, XL Mild Steel Leg Guard"))
definition:recipe("xl_armor_lc_heavyplate", ccb.content.text(" Craft: Armor, XL Mild Steel Heavy Plate"))
definition:recipe("xl_armor_lc_lightplate", ccb.content.text(" Craft: Armor, XL Mild Steel Light Plate"))
definition:recipe("xl_armor_lc_plate", ccb.content.text(" Craft: Armor, XL Mild Steel Plate"))
definition:recipe("xl_armor_mc_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Chestplate"))
definition:recipe("xl_armor_mc_light_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Light Chestplate"))
definition:recipe("xl_armor_mc_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Leg Guard"))
definition:recipe("xl_armor_mc_light_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Light Leg Guard"))
definition:recipe("xl_armor_mc_armguard", ccb.content.text(" Craft: Armor, XL Medium Steel Armguard"))
definition:recipe("xl_armor_mc_heavyarmguard", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Armguard"))
definition:recipe("xl_armor_mc_lightarmguard", ccb.content.text(" Craft: Armor, XL Medium Steel Light Armguard"))
definition:recipe("xl_armor_mc_chestplate", ccb.content.text(" Craft: Armor, XL Medium Steel Chestplate"))
definition:recipe("xl_armor_mc_leg_guard", ccb.content.text(" Craft: Armor, XL Medium Steel Leg Guard"))
definition:recipe("xl_armor_mc_heavyplate", ccb.content.text(" Craft: Armor, XL Medium Steel Heavy Plate"))
definition:recipe("xl_armor_mc_lightplate", ccb.content.text(" Craft: Armor, XL Medium Steel Light Plate"))
definition:recipe("xl_armor_mc_plate", ccb.content.text(" Craft: Armor, XL Medium Steel Plate"))
definition:recipe("xl_armor_qt_heavy_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Heavy Chestplate"))
definition:recipe("xl_armor_qt_light_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Light Chestplate"))
definition:recipe("xl_armor_qt_heavy_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Heavy Leg Guard"))
definition:recipe("xl_armor_qt_light_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Light Leg Guard"))
definition:recipe("xl_armor_qt_armguard", ccb.content.text(" Craft: Armor, XL Tempered Armguard"))
definition:recipe("xl_armor_qt_heavyarmguard", ccb.content.text(" Craft: Armor, XL Tempered Heavy Armguard"))
definition:recipe("xl_armor_qt_lightarmguard", ccb.content.text(" Craft: Armor, XL Tempered Light Armguard"))
definition:recipe("xl_armor_qt_chestplate", ccb.content.text(" Craft: Armor, XL Tempered Chestplate"))
definition:recipe("xl_armor_qt_leg_guard", ccb.content.text(" Craft: Armor, XL Tempered Leg Guard"))
definition:recipe("xl_armor_qt_heavyplate", ccb.content.text(" Craft: Armor, XL Tempered Heavy Plate"))
definition:recipe("xl_armor_qt_lightplate", ccb.content.text(" Craft: Armor, XL Tempered Light Plate"))
definition:recipe("xl_armor_qt_plate", ccb.content.text(" Craft: Armor, XL Tempered Plate"))
definition:recipe("broadsword", ccb.content.text(" Craft: Sword, Medium Steel Broadsword"))
definition:recipe("mc_scimitar", ccb.content.text(" Craft: Sword, Medium Steel Shamshir"))
definition:recipe("fire_ax", ccb.content.text(" Craft: Axe, Fire"))
definition:recipe("hacksaw", ccb.content.text(" Craft: Hacksaw"))
definition:recipe("saw", ccb.content.text(" Craft: Woodsaw"))
definition:recipe("pike", ccb.content.text(" Craft: Spear, Awl Pike"))
definition:recipe("rapier", ccb.content.text(" Craft: Sword, Medium Steel Rapier"))
definition:recipe("halligan", ccb.content.text(" Craft: Halligan Bar"))
definition:recipe("mc_zweihander", ccb.content.text(" Craft: Sword, Medium Steel Zweihänder"))
definition:recipe("pickaxe", ccb.content.text(" Craft: Pickaxe"))
definition:recipe("qt_wire", ccb.content.text(" Craft: Tempered Steel, Wire"))
definition:recipe("qt_chain_link_fabrication", ccb.content.text(" Craft: Tempered Steel, Link"))
definition:recipe("qt_link_sheet", ccb.content.text(" Craft: Tempered Steel, Link Sheet"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "blacksmith_recipes_7",
    building_type = "SMITH",
}
definition:recipe("sheet_metal_npc_drop", ccb.content.text(" Craft: Sheet Metal, Drop Hammer"))
definition:recipe("chain_npc_drop", ccb.content.text(" Craft: Chain, Drop Hammer"))
definition:recipe("nail_npc_drop", ccb.content.text(" Craft: Nail, Drop Hammer"))
definition:recipe("pipe_npc_drop", ccb.content.text(" Craft: Pipe, Drop Hammer"))
definition:recipe("rebar_npc_drop", ccb.content.text(" Craft: Rebar, Drop Hammer"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "power_saw_recipes",
    building_type = "SMITH",
}
definition:recipe("water_wheel_with_power_saw", ccb.content.text(" Craft: Water Wheel, Power Saw"))
definition:recipe("xl_water_wheel_with_power_saw", ccb.content.text(" Craft: Large Water Wheel, Power Saw"))
definition:recipe("wood_beam_with_planer", ccb.content.text(" Craft: Wooden Beam, Planer"))
definition:recipe("plank_long", ccb.content.text(" Craft: Long planks, Power Saw"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "fishing_recipes",
    building_type = "COOK",
}
definition:recipe("fish_npc_fish_trap", ccb.content.text(" Fishing: fish, fish trap"))
definition:recipe("fish_npc_fish_rod_lvl1", ccb.content.text(" Fishing: fish, level 1 fishing rod"))
definition:recipe("fish_npc_fish_rod_lvl2", ccb.content.text(" Fishing: fish, level 2 fishing rod"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "hack_recipes_general",
    building_type = "BASE",
}
definition:recipe("memory_card_unread_npc_hack", ccb.content.text(" Hack & Download: random data, SD-Memory card"))
definition:recipe("software_useless_npc_hack", ccb.content.text(" Hack & Download: misc software, USB drive"))
definition:recipe("software_math_npc_hack", ccb.content.text(" Hack & Download: MatheMAX, USB drive"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "clay_recipes_1",
    building_type = "SMITH",
}
definition:recipe("brick", ccb.content.text(" Craft: Brick"))
definition:recipe("fire_brick", ccb.content.text(" Craft: Fire Brick"))
definition:recipe("pebble_clay", ccb.content.text(" Craft: Clay Pellet"))
definition:recipe("clay_canister", ccb.content.text(" Craft: Clay Canister"))
definition:recipe("clay_hydria", ccb.content.text(" Craft: Clay Hydria"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "hack_recipes_science",
    building_type = "BASE",
}
definition:recipe("memory_card_science_npc_hack", ccb.content.text(" Hack & Download: science data, SD-Memory card"))
definition:recipe("software_medical_npc_hack", ccb.content.text(" Hack & Download: MediSoft, USB drive"))
definition:recipe("software_electronics_reference_npc_hack", ccb.content.text(" Hack & Download: IC datasheet archives, USB drive"))
content.add(definition)
end
do
local definition = content.RecipeGroup {
    id = "hack_recipes_satellite",
    building_type = "BASE",
}
definition:recipe("satellitemap_npc_hack", ccb.content.text(" Hack & Download: Satellite Map, sketch"))
content.add(definition)
end
