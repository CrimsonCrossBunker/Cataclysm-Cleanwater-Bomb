local content = require("ccb").content

do
    local group = content.ItemGroup { id = "debug_template_item", kind = "distribution" }
    group:item("standard_template_construct", 10)
    group:item("standard_template_construct_combat_exoskeleton", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nanofab_recipes_combat_exoskeletons", kind = "distribution" }
    group:item("combat_exoskeleton_heavy", 10)
    group:item("combat_exoskeleton_medium", 10)
    group:item("combat_exoskeleton_light", 10)
    group:item("combat_exoskeleton_armor_head_heavy", 1)
    group:item("combat_exoskeleton_armor_torso_heavy", 1)
    group:item("combat_exoskeleton_armor_arm_heavy", 1)
    group:item("combat_exoskeleton_armor_leg_heavy", 1)
    group:item("combat_exoskeleton_armor_head_medium", 1)
    group:item("combat_exoskeleton_armor_torso_medium", 1)
    group:item("combat_exoskeleton_armor_arm_medium", 1)
    group:item("combat_exoskeleton_armor_leg_medium", 1)
    group:item("combat_exoskeleton_armor_head_light", 1)
    group:item("combat_exoskeleton_armor_torso_light", 1)
    group:item("combat_exoskeleton_armor_arm_light", 1)
    group:item("combat_exoskeleton_armor_leg_light", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "antique_guns", kind = "distribution" }
    group:item("pistol_flintlock", 60)
    group:item("carbine_flintlock", 40)
    group:item("rifle_flintlock", 75)
    group:item("colt_army", 30)
    group:item("colt_navy", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "antique_guns_with_ammo", kind = "distribution", with_ammo = 100, with_magazine = 100 }
    group:item("pistol_flintlock", 60)
    group:item("carbine_flintlock", 40)
    group:item("rifle_flintlock", 75)
    group:item("colt_army", 30)
    group:item("colt_navy", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "antique_ammo", kind = "distribution" }
    group:item("flintlock_ammo", 60)
    group:item("flintlock_shot", 40)
    group:item("36navy", 50)
    group:item("44army", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "archery_mods", kind = "distribution" }
    group:item("arrowrest", 50)
    group:item("bow_scope", 30)
    group:item("bow_sight", 50)
    group:item("bow_sight_pin", 50)
    group:item("bow_silencer", 50)
    group:item("bow_stabilizer", 50)
    group:item("bow_stabilizer_set", 40)
    content.add(group)
end

do
    -- archery ammo, that can be crafted, and can be find in random survivor camps
    local group = content.ItemGroup { id = "makeshift_archery_ammo", kind = "distribution" }
    group:entry { item = "arrow_fire_hardened_fletched", count = { 10, 30 } }
    group:entry { item = "arrow_heavy_fire_hardened_fletched", count = { 10, 30 }, probability = 50 }
    group:entry { item = "arrow_wood_heavy", count = { 10, 30 } }
    group:entry { item = "arrow_metal_sharpened_fletched", count = { 10, 30 } }
    group:entry { item = "arrow_small_game_fletched", count = { 10, 30 }, probability = 50 }
    group:entry { item = "arrow_wood", count = { 10, 30 } }
    group:entry { item = "arrow_field_point_fletched", count = { 10, 30 } }
    group:entry { item = "arrow_heavy_field_point_fletched", count = { 10, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "archery_quivers", kind = "distribution" }
    group:item("quiver", 50)
    group:item("quiver_large", 50)
    group:item("nylon_quiver", 75)
    group:item("quiver_takedown_bow", 10)
    group:group("archery_loaded_quivers", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "archery_loaded_quivers", kind = "distribution" }
    group:group("loaded_quiver", 50)
    group:group("loaded_quiver_large", 50)
    group:group("loaded_nylon_quiver", 75)
    group:group("loaded_takedown_quiver", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "loaded_quiver", kind = "distribution", container = "quiver", overflow = "discard" }
    group:group("archery_ammo", 80)
    group:group("crossbow_bolts", 20)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "loaded_quiver_large",
        kind = "distribution",
        container = "quiver_large",
        overflow = "discard",
    }
    group:group("archery_ammo", 80)
    group:group("crossbow_bolts", 20)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "loaded_nylon_quiver",
        kind = "distribution",
        container = "nylon_quiver",
        overflow = "discard",
    }
    group:group("archery_ammo", 80)
    group:group("crossbow_bolts", 20)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "loaded_takedown_quiver",
        kind = "collection",
        container = "quiver_takedown_bow",
        overflow = "discard",
    }
    group:group("archery_ammo")
    group:group("archery_mods", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crossbow_bolts", kind = "distribution" }
    group:entry { item = "bolt_makeshift", count = { 10, 30 } }
    group:entry { item = "bolt_wood", count = { 10, 30 } }
    group:entry { item = "bolt_wood_bodkin", count = { 10, 30 }, probability = 50 }
    group:entry { item = "bolt_wood_small_game", count = { 10, 30 } }
    group:entry { item = "bolt_metal", count = { 10, 30 } }
    group:entry { item = "bolt_steel", count = { 10, 30 } }
    group:entry { item = "bolt_steel_bodkin", count = { 10, 30 } }
    group:entry { item = "bolt_steel_target", count = { 10, 30 } }
    group:entry { item = "bolt_cf", count = { 10, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "crossbow_bolts_makeshift", kind = "distribution" }
    group:entry { item = "bolt_crude", count = { 10, 30 } }
    group:entry { item = "bolt_simple_wood", count = { 10, 30 } }
    group:entry { item = "bolt_simple_small_game", count = { 10, 30 } }
    group:entry { item = "bolt_makeshift", count = { 10, 30 } }
    group:entry { item = "bolt_wood", count = { 10, 30 } }
    group:entry { item = "bolt_wood_bodkin", count = { 10, 30 }, probability = 50 }
    group:entry { item = "bolt_wood_small_game", count = { 10, 30 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "archery_ammo", kind = "distribution" }
    group:entry { item = "arrow_wood", count = { 10, 30 } }
    group:entry { item = "arrow_field_point_fletched", count = { 10, 30 }, probability = 50 }
    group:entry { item = "arrow_cf", count = { 10, 30 } }
    group:entry { item = "arrow_small_game_fletched", count = { 10, 30 } }
    group:entry { item = "arrow_heavy_field_point_fletched", count = { 10, 30 } }
    group:entry { item = "arrow_metal", count = { 10, 30 } }
    group:entry { item = "arrow_metal_bodkin", count = { 10, 30 } }
    group:entry { item = "arrow_metal_target", count = { 10, 30 } }
    group:entry { item = "arrow_plastic", count = { 10, 30 } }
    content.add(group)
end
