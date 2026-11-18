local ccb = require("ccb")
local content = ccb.content
require("crafting_actions")

local warped_recipe = require("warped_recipe")

do
    local category = content.RecipeCategory { id = "CC_WARP" }
    category:subcategory("CSC_ALL")
    category:subcategory("CSC_WARP_GEAR")
    category:subcategory("CSC_WARP_TOOLS")
    category:subcategory("CSC_WARP_ITEMS")
    category:subcategory("CSC_WARP_MATERIALS")
    category:subcategory("CSC_WARP_UPGRADES")
    content.upsert(category)
end

do
    local recipe = warped_recipe {
        id = "buildkey_base1",
        result = "buildkey_base1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "stick", count = 4 }, { id = "stick_long", count = 2 }, { id = "twig", count = 16 } }
    recipe:component_any { { id = "rock", count = 10 } }
    recipe:component_any { { id = "pebble", count = 10 } }
    recipe:component_any { { id = "sharp_rock", count = 1 } }
    recipe:component_any { { id = "scrap", count = 4 } }
    recipe:component_any { { id = "withered", count = 4 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_bigroom1",
        result = "buildkey_bigroom1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 1 } }
    recipe:component_any { { id = "hinge", count = 5 } }
    recipe:component_any { { id = "nail", count = 20 } }
    recipe:component_any { { id = "nuts_bolts", count = 15 } }
    recipe:component_any { { id = "box_medium", count = 4 }, { id = "box_large", count = 1 }, { id = "box_oversize", count = 2 } }
    recipe:component_any { { id = "cordage", count = 5, requirement = true } }
    recipe:quality("DIG", 1, 1)
    recipe:quality("HAMMER", 2, 1)
    recipe:quality("SCREW", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_bigroom2",
        result = "buildkey_bigroom2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "shovel", count = 1 }, { id = "shovel_snow", count = 1 } }
    recipe:component_any { { id = "sheet_metal", count = 8 } }
    recipe:component_any { { id = "frame", count = 2 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_bigroom3",
        result = "buildkey_bigroom3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "wood_beam", count = 4 } }
    recipe:component_any { { id = "sheet_metal", count = 8 } }
    recipe:component_any { { id = "frame", count = 2 } }
    recipe:component_any { { id = "wearable_light", count = 2 } }
    recipe:component_any { { id = "hard_plate", count = 4 }, { id = "steel_plate", count = 8 } }
    recipe:component_any { { id = "battery_car", count = 1 }, { id = "battery_motorbike", count = 1 }, { id = "medium_storage_battery", count = 1 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_bigroom4",
        result = "buildkey_bigroom4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "storage_battery", count = 1 } }
    recipe:component_any { { id = "mil_plate", count = 2 } }
    recipe:component_any { { id = "acidchitin_plate", count = 2 }, { id = "chitin_plate", count = 4 } }
    recipe:component_any { { id = "hdframe", count = 2 } }
    recipe:component_any { { id = "block_and_tackle", count = 1 } }
    recipe:component_any { { id = "mannequin", count = 1 } }
    recipe:component_any { { id = "hd_pipe", count = 4 } }
    recipe:component_any { { id = "hd_pipe_fittings", count = 4 } }
    recipe:quality("SAW_M_FINE", 1, 1)
    recipe:quality("SAW_M", 2, 1)
    recipe:quality("WELD", 1, 1)
    recipe:quality("GLARE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_centralskylight2",
        result = "buildkey_centralskylight2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 4 } }
    recipe:component_any { { id = "glass_shard", count = 150 } }
    recipe:component_any { { id = "chunk_rubber", count = 5 } }
    recipe:component_any { { id = "glue_strong", count = 20 } }
    recipe:component_any { { id = "cordage", count = 5, requirement = true } }
    recipe:quality("DIG", 1, 1)
    recipe:quality("HAMMER", 2, 1)
    recipe:quality("SCREW", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_centralskylight3",
        result = "buildkey_centralskylight3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "aquamarine", count = 4 }, { id = "citrine", count = 4 }, { id = "garnet", count = 4 }, { id = "peridot", count = 4 }, { id = "tourmaline", count = 4 }, { id = "blue_topaz", count = 4 } }
    recipe:component_any { { id = "glass_sheet", count = 3 } }
    recipe:component_any { { id = "mirror", count = 1 } }
    recipe:component_any { { id = "glue_strong", count = 40 } }
    recipe:component_any { { id = "frame_wood", count = 2 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_centralskylight4",
        result = "buildkey_centralskylight4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "bigmirror", count = 1 } }
    recipe:component_any { { id = "tempered_glass_sheet", count = 4 } }
    recipe:component_any { { id = "frame", count = 4 } }
    recipe:component_any { { id = "glue_weak", count = 8 } }
    recipe:component_any { { id = "diamond", count = 8 }, { id = "ruby", count = 8 }, { id = "emerald", count = 8 }, { id = "sapphire", count = 8 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_eastroom1",
        result = "buildkey_eastroom1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 1 } }
    recipe:component_any { { id = "hinge", count = 5 } }
    recipe:component_any { { id = "nail", count = 20 } }
    recipe:component_any { { id = "nuts_bolts", count = 15 } }
    recipe:component_any { { id = "box_medium", count = 4 }, { id = "box_large", count = 1 }, { id = "box_oversize", count = 2 } }
    recipe:component_any { { id = "cordage", count = 5, requirement = true } }
    recipe:quality("DIG", 1, 1)
    recipe:quality("HAMMER", 2, 1)
    recipe:quality("SCREW", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_eastroom2",
        result = "buildkey_eastroom2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "shovel", count = 1 }, { id = "shovel_snow", count = 1 } }
    recipe:component_any { { id = "sheet_metal", count = 8 } }
    recipe:component_any { { id = "frame", count = 2 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_eastroom3",
        result = "buildkey_eastroom3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "wood_beam", count = 4 } }
    recipe:component_any { { id = "sheet_metal", count = 8 } }
    recipe:component_any { { id = "frame", count = 2 } }
    recipe:component_any { { id = "wearable_light", count = 2 } }
    recipe:component_any { { id = "hard_plate", count = 4 }, { id = "steel_plate", count = 8 } }
    recipe:component_any { { id = "battery_car", count = 1 }, { id = "battery_motorbike", count = 1 }, { id = "medium_storage_battery", count = 1 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_eastroom4",
        result = "buildkey_eastroom4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "glass_sheet", count = 4 } }
    recipe:component_any { { id = "sheet_metal", count = 4 } }
    recipe:component_any { { id = "glass_shard", count = 100 } }
    recipe:component_any { { id = "battery_car", count = 1 }, { id = "battery_motorbike", count = 1 }, { id = "medium_storage_battery", count = 1 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_east_side_rooms",
        result = "buildkey_east_side_rooms",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "block_and_tackle", count = 1 }, { id = "block_and_tackle_wood", count = 1 } }
    recipe:component_any { { id = "wood_beam", count = 8 } }
    recipe:component_any { { id = "sheet_metal", count = 24 } }
    recipe:component_any { { id = "box_medium_wood", count = 3 }, { id = "box_medium_metal", count = 2 } }
    recipe:component_any { { id = "backpack", count = 3 }, { id = "net_backpack", count = 5 }, { id = "backpack_denim", count = 3 }, { id = "backpack_hiking", count = 3 }, { id = "backpack_leather", count = 3 } }
    recipe:component_any { { id = "golf_bag", count = 1 } }
    recipe:component_any { { id = "bag_body_bag", count = 2 } }
    recipe:component_any { { id = "bag_canvas", count = 2 } }
    recipe:component_any { { id = "bag_garbage_reinforced", count = 1 } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_south_greenhouse_1",
        result = "buildkey_south_greenhouse_1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 4 } }
    recipe:component_any { { id = "hinge", count = 6 } }
    recipe:component_any { { id = "box_medium", count = 4 }, { id = "box_large", count = 1 }, { id = "box_oversize", count = 2 } }
    recipe:component_any { { id = "material_soil", count = 40 } }
    recipe:component_any { { id = "sheet_metal", count = 3 } }
    recipe:quality("DIG", 1, 1)
    recipe:quality("SAW_M", 2, 1)
    recipe:quality("WELD", 1, 1)
    recipe:quality("GLARE", 1, 1)
    recipe:quality("SCREW", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_south_greenhouse_2",
        result = "buildkey_south_greenhouse_2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 4 } }
    recipe:component_any { { id = "hinge", count = 6 } }
    recipe:component_any { { id = "box_medium", count = 4 }, { id = "box_large", count = 1 }, { id = "box_oversize", count = 2 } }
    recipe:component_any { { id = "material_soil", count = 40 } }
    recipe:component_any { { id = "sheet_metal", count = 3 } }
    recipe:quality("DIG", 1, 1)
    recipe:quality("SAW_M", 2, 1)
    recipe:quality("WELD", 1, 1)
    recipe:quality("GLARE", 1, 1)
    recipe:quality("SCREW", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_south_greenhouse_3",
        result = "buildkey_south_greenhouse_3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 10 } }
    recipe:component_any { { id = "nail", count = 20 } }
    recipe:component_any { { id = "chunk_rubber", count = 30 } }
    recipe:component_any { { id = "clay_pot_flower", count = 30 }, { id = "plastic_pot_flower", count = 30 } }
    recipe:component_any { { id = "tempered_glass_sheet", count = 8 } }
    recipe:component_any { { id = "cable", count = 10 } }
    recipe:quality("SAW_M_FINE", 1, 1)
    recipe:quality("SAW_M", 2, 1)
    recipe:quality("HAMMER", 2, 1)
    recipe:quality("SCREW", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_south_greenhouse_4",
        result = "buildkey_south_greenhouse_4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 10 } }
    recipe:component_any { { id = "nail", count = 20 } }
    recipe:component_any { { id = "chunk_rubber", count = 30 } }
    recipe:component_any { { id = "clay_pot_flower", count = 30 }, { id = "plastic_pot_flower", count = 30 } }
    recipe:component_any { { id = "tempered_glass_sheet", count = 8 } }
    recipe:component_any { { id = "cable", count = 10 } }
    recipe:quality("SAW_M_FINE", 1, 1)
    recipe:quality("SAW_M", 2, 1)
    recipe:quality("HAMMER", 2, 1)
    recipe:quality("SCREW", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_south_greenhouse_skylight_1",
        result = "buildkey_south_greenhouse_skylight_1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "glass_sheet", count = 4 } }
    recipe:component_any { { id = "tempered_glass_sheet", count = 4 } }
    recipe:component_any { { id = "glue_strong", count = 80 } }
    recipe:component_any { { id = "nuts_bolts", count = 80 } }
    recipe:component_any { { id = "frame_wood", count = 8 } }
    recipe:component_any { { id = "cordage", count = 2, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_south_greenhouse_skylight_2",
        result = "buildkey_south_greenhouse_skylight_2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "glass_sheet", count = 4 } }
    recipe:component_any { { id = "tempered_glass_sheet", count = 4 } }
    recipe:component_any { { id = "glue_strong", count = 80 } }
    recipe:component_any { { id = "nuts_bolts", count = 80 } }
    recipe:component_any { { id = "frame_wood", count = 8 } }
    recipe:component_any { { id = "cordage", count = 2, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_merchant_stall",
        result = "buildkey_merchant_stall",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "platinum_ring", count = 1 } }
    recipe:component_any { { id = "money_fifty", count = 10 } }
    recipe:component_any { { id = "money_hundred", count = 5 } }
    recipe:component_any { { id = "gift_card", count = 5 } }
    recipe:component_any { { id = "gold_ring", count = 2 } }
    recipe:component_any { { id = "silver_ring", count = 3 } }
    recipe:component_any { { id = "copper_ring", count = 4 } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_climatecontrol",
        result = "buildkey_climatecontrol",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "coat_winter", count = 1 } }
    recipe:component_any { { id = "down_blanket", count = 1 } }
    recipe:component_any { { id = "mask_ski", count = 1 } }
    recipe:component_any { { id = "umbrella", count = 1 }, { id = "teleumbrella", count = 1 } }
    recipe:component_any { { id = "flag_swimsuit", count = 1 }, { id = "trunks", count = 1 }, { id = "bikini_bottom_short", count = 1 }, { id = "bikini_bottom", count = 1 } }
    recipe:component_any { { id = "tshirt_cropped", count = 1 } }
    recipe:component_any { { id = "large_space_heater", count = 1 } }
    recipe:component_any { { id = "mountable_cooler", count = 1 } }
    recipe:quality("SEW", 3, 1)
    recipe:quality("FABRIC_CUT", 2, 1)
    recipe:quality("BLOW_HOT_AIR", 1, 1)
    content.upsert(recipe)
end

-- Intended to be a very early-game craft, as the bunker and constructing on the surface makes it mostly obsolete.
-- The amount of glass shards is equal to the amount disassembling a standing mirror would give.
do
    local recipe = warped_recipe {
        id = "upgradekey_sunblock",
        result = "upgradekey_sunblock",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "sunglasses", count = 1 }, { id = "sunglasses_eye", count = 1 }, { id = "sunglasses_bifocal", count = 1 }, { id = "sunglasses_reading", count = 1 }, { id = "fitover_sunglasses", count = 1 } }
    recipe:component_any { { id = "sunglasses", count = 1 }, { id = "sunglasses_eye", count = 1 }, { id = "sunglasses_bifocal", count = 1 }, { id = "sunglasses_reading", count = 1 }, { id = "fitover_sunglasses", count = 1 } }
    recipe:component_any { { id = "umbrella", count = 1 }, { id = "teleumbrella", count = 1 } }
    recipe:component_any { { id = "sundress", count = 1 } }
    recipe:component_any { { id = "glass_shard", count = 176 } }
    content.upsert(recipe)
end

-- Intended to be a very early-game craft, as island-side radiation immunity is a very niche effect.
do
    local recipe = warped_recipe {
        id = "upgradekey_radblock",
        result = "upgradekey_radblock",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "bleach", count = 30 }, { id = "ammonia_hydroxide", count = 30 } }
    recipe:component_any { { id = "broom", count = 1 } }
    recipe:component_any { { id = "mop", count = 1 }, { id = "mop_folded", count = 1 } }
    recipe:component_any { { id = "soap", count = 10 }, { id = "detergent", count = 10 } }
    content.upsert(recipe)
end

-- Intended to be a midgame craft, as the winds are a good motivator to drive early exploration.
do
    local recipe = warped_recipe {
        id = "upgradekey_windblock",
        result = "upgradekey_windblock",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "jacket_windbreaker", count = 3 } }
    recipe:component_any { { id = "survival_book", count = 1 } }
    recipe:component_any { { id = "milk_cream", count = 5 }, { id = "moisturizer", count = 5 }, { id = "bristol_sherry", count = 5 } }
    recipe:component_any { { id = "any_tallow", count = 60, requirement = true } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_island_steady",
        result = "upgradekey_island_steady",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "jumper_cable", count = 3 }, { id = "jumper_cable_heavy", count = 3 }, { id = "hd_tow_cable", count = 3 } }
    recipe:component_any { { id = "hc_chain_link", count = 11 }, { id = "qt_chain_link", count = 11 }, { id = "ch_chain_link", count = 11 } }
    recipe:component_any { { id = "plant_fibre", count = 500 }, { id = "sinew", count = 500 } }
    content.upsert(recipe)
end

-- Intended to be a lategame craft, something the player focuses on as winter draws near.
do
    local recipe = warped_recipe {
        id = "upgradekey_temperature_control",
        result = "upgradekey_temperature_control",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "thermal_outfit", count = 20 }, { id = "thermal_suit", count = 20 }, { id = "bio_climate", count = 1 }, { id = "bio_heatsink", count = 1 }, { id = "exodii_ac_kit", count = 3 } }
    recipe:component_any { { id = "mountable_cooler", count = 3 }, { id = "condensor_coil", count = 30 }, { id = "evaporator_coil", count = 30 } }
    recipe:component_any { { id = "mountable_heater", count = 3 }, { id = "element", count = 30 } }
    recipe:component_any { { id = "air_compressor", count = 1 }, { id = "1l_gold", count = 1 } }
    recipe:component_any { { id = "railroad_track_item", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_northroom1",
        result = "buildkey_northroom1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 1 } }
    recipe:component_any { { id = "hinge", count = 3 } }
    recipe:component_any { { id = "nail", count = 20 } }
    recipe:component_any { { id = "chunk_rubber", count = 15 } }
    recipe:component_any { { id = "glass_shard", count = 250 } }
    recipe:component_any { { id = "cordage", count = 5, requirement = true } }
    recipe:quality("DIG", 1, 1)
    recipe:quality("HAMMER", 2, 1)
    recipe:quality("SCREW", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_northroom2",
        result = "buildkey_northroom2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "shovel", count = 1 }, { id = "shovel_snow", count = 1 } }
    recipe:component_any { { id = "glass_sheet", count = 4 } }
    recipe:component_any { { id = "glue_weak", count = 4 } }
    recipe:component_any { { id = "frame", count = 2 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_northroom3",
        result = "buildkey_northroom3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "wood_beam", count = 4 } }
    recipe:component_any { { id = "tempered_glass_sheet", count = 4 } }
    recipe:component_any { { id = "frame", count = 2 } }
    recipe:component_any { { id = "rubber_tire_strip", count = 4 } }
    recipe:component_any { { id = "battery_car", count = 1 }, { id = "battery_motorbike", count = 1 }, { id = "medium_storage_battery", count = 1 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_northroom4",
        result = "buildkey_northroom4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "reinforced_glass_sheet", count = 4 } }
    recipe:component_any { { id = "sheet_metal", count = 4 } }
    recipe:component_any { { id = "hdframe", count = 2 } }
    recipe:component_any { { id = "432gal_drum_rubber", count = 3 } }
    recipe:component_any { { id = "wood_beam", count = 8 } }
    recipe:component_any { { id = "block_and_tackle", count = 1 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_north_side_rooms",
        result = "buildkey_north_side_rooms",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "block_and_tackle", count = 1 }, { id = "block_and_tackle_wood", count = 1 } }
    recipe:component_any { { id = "wood_beam", count = 8 } }
    recipe:component_any { { id = "sheet_metal", count = 24 } }
    recipe:component_any { { id = "box_medium_wood", count = 3 }, { id = "box_medium_metal", count = 2 } }
    recipe:component_any { { id = "backpack", count = 3 }, { id = "net_backpack", count = 5 }, { id = "backpack_denim", count = 3 }, { id = "backpack_hiking", count = 3 }, { id = "backpack_leather", count = 3 } }
    recipe:component_any { { id = "golf_bag", count = 1 } }
    recipe:component_any { { id = "bag_body_bag", count = 2 } }
    recipe:component_any { { id = "bag_canvas", count = 2 } }
    recipe:component_any { { id = "bag_garbage_reinforced", count = 1 } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_rankup1",
        result = "upgradekey_rankup1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 2 } }
    recipe:quality("HAMMER", 2, 1)
    recipe:quality("BOIL", 2, 1)
    recipe:quality("JACK", 1, 1)
    recipe:quality("HOSE", 1, 1)
    recipe:quality("STRAIN", 1, 1)
    recipe:quality("SAW_W", 2, 1)
    recipe:quality("WRENCH_FINE", 1, 1)
    recipe:quality("WRENCH", 2, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_rankup2",
        result = "upgradekey_rankup2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 4 } }
    recipe:quality("BUTCHER", 16, 1)
    recipe:quality("CHEM", 2, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("CUT_FINE", 2, 1)
    recipe:quality("MOP", 1, 1)
    recipe:quality("SMOOTH", 1, 1)
    recipe:quality("WINNOW", 1, 1)
    recipe:quality("PRY", 2, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_westroom1",
        result = "buildkey_westroom1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "2x4", count = 1 } }
    recipe:component_any { { id = "hinge", count = 5 } }
    recipe:component_any { { id = "nail", count = 20 } }
    recipe:component_any { { id = "nuts_bolts", count = 15 } }
    recipe:component_any { { id = "box_medium", count = 4 }, { id = "box_large", count = 1 }, { id = "box_oversize", count = 2 } }
    recipe:component_any { { id = "cordage", count = 5, requirement = true } }
    recipe:quality("DIG", 1, 1)
    recipe:quality("HAMMER", 2, 1)
    recipe:quality("SCREW", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_westroom2",
        result = "buildkey_westroom2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "shovel", count = 1 }, { id = "shovel_snow", count = 1 } }
    recipe:component_any { { id = "sheet_metal", count = 8 } }
    recipe:component_any { { id = "frame", count = 2 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_westroom3",
        result = "buildkey_westroom3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "wood_beam", count = 4 } }
    recipe:component_any { { id = "sheet_metal", count = 8 } }
    recipe:component_any { { id = "frame", count = 2 } }
    recipe:component_any { { id = "wearable_light", count = 2 } }
    recipe:component_any { { id = "hard_plate", count = 4 }, { id = "steel_plate", count = 8 } }
    recipe:component_any { { id = "battery_car", count = 1 }, { id = "battery_motorbike", count = 1 }, { id = "medium_storage_battery", count = 1 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_westroom4",
        result = "buildkey_westroom4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "glass_sheet", count = 4 } }
    recipe:component_any { { id = "sheet_metal", count = 4 } }
    recipe:component_any { { id = "glass_shard", count = 100 } }
    recipe:component_any { { id = "battery_car", count = 1 }, { id = "battery_motorbike", count = 1 }, { id = "medium_storage_battery", count = 1 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "buildkey_west_side_rooms",
        result = "buildkey_west_side_rooms",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "block_and_tackle", count = 1 }, { id = "block_and_tackle_wood", count = 1 } }
    recipe:component_any { { id = "wood_beam", count = 8 } }
    recipe:component_any { { id = "sheet_metal", count = 24 } }
    recipe:component_any { { id = "box_medium_wood", count = 3 }, { id = "box_medium_metal", count = 2 } }
    recipe:component_any { { id = "backpack", count = 3 }, { id = "net_backpack", count = 5 }, { id = "backpack_denim", count = 3 }, { id = "backpack_hiking", count = 3 }, { id = "backpack_leather", count = 3 } }
    recipe:component_any { { id = "golf_bag", count = 1 } }
    recipe:component_any { { id = "bag_body_bag", count = 2 } }
    recipe:component_any { { id = "bag_canvas", count = 2 } }
    recipe:component_any { { id = "bag_garbage_reinforced", count = 1 } }
    recipe:quality("WRENCH", 2, 1)
    recipe:quality("SCREW_FINE", 1, 1)
    recipe:quality("DRILL", 1, 1)
    recipe:quality("HAMMER_FINE", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_challenge_mode",
        result = "upgradekey_challenge_mode",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 50 } }
    recipe:component_any { { id = "m107a1", count = 1 }, { id = "m2browning", count = 1 }, { id = "as50", count = 1 } }
    recipe:component_any { { id = "xedra_enviro_suit", count = 1 }, { id = "xedra_enviro_suit_casual", count = 1 } }
    recipe:component_any { { id = "lc_chainmail_vest", count = 1 }, { id = "hc_chainmail_vest", count = 1 }, { id = "mc_chainmail_vest", count = 1 }, { id = "ch_chainmail_vest", count = 1 }, { id = "qt_chainmail_vest", count = 1 } }
    recipe:component_any { { id = "lab_postit_bio", count = 2 }, { id = "lab_postit_blob", count = 2 }, { id = "lab_postit_migo", count = 2 }, { id = "lab_postit_portal", count = 2 }, { id = "lab_postit_tech", count = 2 } }
    recipe:component_any { { id = "lab_file_bio", count = 2 }, { id = "lab_file_portal", count = 2 }, { id = "lab_file_psych", count = 2 }, { id = "lab_file_sec", count = 2 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_exit1",
        result = "upgradekey_exit1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "roller_blades", count = 1 } }
    recipe:component_any { { id = "jacket_windbreaker", count = 1 } }
    recipe:component_any { { id = "crowbar", count = 1 }, { id = "heavy_crowbar", count = 1 } }
    recipe:component_any { { id = "speedo", count = 1 }, { id = "bikini_bottom_short", count = 1 }, { id = "bikini_bottom", count = 1 }, { id = "loincloth", count = 1 }, { id = "loincloth_fur", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_exit2",
        result = "upgradekey_exit2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "grapnel", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    recipe:component_any { { id = "roller_shoes_off", count = 1 }, { id = "folded_skateboard_generic", count = 1 } }
    recipe:component_any { { id = "fire_ax", count = 1 }, { id = "crash_axe", count = 1 } }
    recipe:component_any { { id = "halligan", count = 1 }, { id = "ny_hook", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_exit3",
        result = "upgradekey_exit3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "doormat", count = 5 } }
    recipe:component_any { { id = "warptoken", count = 3 } }
    recipe:component_any { { id = "oven_door", count = 2 }, { id = "door_lock", count = 5 } }
    recipe:component_any { { id = "vehicle_dashboard", count = 1 }, { id = "vehicle_controls", count = 1 } }
    recipe:component_any { { id = "indoor_volleyball", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_exit4",
        result = "upgradekey_exit4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "bite_suit", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 5 } }
    recipe:component_any { { id = "carpentry_book", count = 1 }, { id = "textbook_carpentry", count = 1 } }
    recipe:component_any { { id = "hinge", count = 20 } }
    recipe:component_any { { id = "mossberg_590_shockwave", count = 1 }, { id = "shotgun_d", count = 3 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing1",
        result = "upgradekey_landing1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "pillow", count = 2 }, { id = "down_pillow", count = 2 } }
    recipe:component_any { { id = "sheet", count = 2 } }
    recipe:component_any { { id = "tinder", count = 10 } }
    recipe:component_any { { id = "glass_shard", count = 20 } }
    recipe:component_any { { id = "seed_flower", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing2",
        result = "upgradekey_landing2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "mattress", count = 1 }, { id = "down_mattress", count = 1 } }
    recipe:component_any { { id = "quilt", count = 5 }, { id = "quilt_patchwork", count = 5 } }
    recipe:component_any { { id = "warptoken", count = 2 } }
    recipe:component_any { { id = "blanket", count = 2 }, { id = "fur_blanket", count = 2 }, { id = "down_blanket", count = 2 } }
    recipe:component_any { { id = "feather", count = 40 }, { id = "down_feather", count = 40 } }
    recipe:component_any { { id = "shot_glass", count = 1 } }
    recipe:component_any { { id = "spurge", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing3",
        result = "upgradekey_landing3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "cleansuit", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 5 } }
    recipe:component_any { { id = "teddy_bear", count = 2 } }
    recipe:component_any { { id = "felt_patch", count = 4 } }
    recipe:component_any { { id = "crackpipe", count = 1 }, { id = "pipe_glass", count = 1 } }
    recipe:component_any { { id = "seed_mushroom", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing4",
        result = "upgradekey_landing4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "hazmat_suit", count = 1 }, { id = "wetsuit", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 8 } }
    recipe:component_any { { id = "shark_plushie", count = 1 } }
    recipe:component_any { { id = "faux_fur", count = 20 } }
    recipe:component_any { { id = "eclipse_glasses", count = 1 }, { id = "pipe_glass", count = 1 } }
    recipe:component_any { { id = "dahlia_root", count = 5 } }
    recipe:component_any { { id = "poppy_bud", count = 10 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing5",
        result = "upgradekey_landing5",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "chainmail_suit_faraday", count = 1 }, { id = "fursuit", count = 1 }, { id = "armor_samurai", count = 1 }, { id = "armor_junk_plate", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 12 } }
    recipe:component_any { { id = "book_fict_soft_ya_myeyes", count = 1 } }
    recipe:component_any { { id = "fur", count = 40 } }
    recipe:component_any { { id = "glasses_monocle", count = 1 } }
    recipe:component_any { { id = "heroin", count = 1 } }
    recipe:component_any { { id = "coke", count = 20 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing6",
        result = "upgradekey_landing6",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "any_flag_landing_upgradekey", count = 6, requirement = true } }
    recipe:component_any { { id = "warptoken", count = 16 } }
    recipe:component_any { { id = "roadmap", count = 6 }, { id = "subwaystationmap", count = 6 }, { id = "survivormap", count = 6 }, { id = "trailmap", count = 6 }, { id = "touristmap", count = 6 }, { id = "restaurantmap", count = 6 } }
    recipe:component_any { { id = "labmap", count = 5 }, { id = "id_science_visitor_1", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing7",
        result = "upgradekey_landing7",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "oxycodone", count = 200 }, { id = "tramadol", count = 200 } }
    recipe:component_any { { id = "poppy_pain", count = 20 }, { id = "morphine", count = 10 } }
    recipe:component_any { { id = "warptoken", count = 20 } }
    recipe:component_any { { id = "thermal_suit", count = 5 } }
    recipe:component_any { { id = "coat_winter", count = 5 } }
    recipe:component_any { { id = "plastic_jack_o_lantern", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing8",
        result = "upgradekey_landing8",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "any_badge", count = 3, requirement = true } }
    recipe:component_any { { id = "warptoken", count = 24 } }
    recipe:component_any { { id = "jade_brooch", count = 3 } }
    recipe:component_any { { id = "any_tiara", count = 6, requirement = true } }
    recipe:component_any { { id = "bronze_medal", count = 1 }, { id = "silver_medal", count = 1 }, { id = "gold_medal", count = 1 }, { id = "service_medal", count = 1 } }
    recipe:component_any { { id = "suit", count = 1 } }
    recipe:component_any { { id = "ring_signet", count = 3 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing_waterwalking",
        result = "upgradekey_landing_waterwalking",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "flotation_vest_ms", count = 1 }, { id = "flotation_vest", count = 1 }, { id = "armor_samurai", count = 1 }, { id = "armor_junk_plate", count = 1 } }
    recipe:component_any { { id = "warp_waterwalking_stone", count = 5 } }
    recipe:component_any { { id = "folded_inflatable_boat", count = 1 } }
    recipe:component_any { { id = "stationary_water_purifier", count = 1 } }
    recipe:component_any { { id = "soup_fish", count = 10 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing_flight",
        result = "upgradekey_landing_flight",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "mutant_bug_hydrogen_sacs", count = 300 } }
    recipe:component_any { { id = "warptoken", count = 16 } }
    recipe:component_any { { id = "book_fict_soft_ya_hilo", count = 1 } }
    recipe:component_any { { id = "iv_mutagen_bird", count = 2 } }
    recipe:component_any { { id = "feather", count = 100 }, { id = "down_feather", count = 100 } }
    recipe:component_any { { id = "meth", count = 10 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_landing_phase",
        result = "upgradekey_landing_phase",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "altered_keyring", count = 1 }, { id = "bio_probability_travel", count = 1 }, { id = "bio_teleport", count = 1 }, { id = "teleporter", count = 3 } }
    recipe:component_any { { id = "phase_immersion_suit", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 22 } }
    recipe:component_any { { id = "book_lockpick", count = 1 } }
    recipe:component_any { { id = "crude_picklock", count = 25 } }
    recipe:component_any { { id = "picklocks", count = 1 } }
    recipe:component_any { { id = "colander_steel", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_raidlength1",
        result = "upgradekey_raidlength1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "mask_gas", count = 1 }, { id = "mask_gas_half", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    recipe:component_any { { id = "backpack", count = 4 }, { id = "backpack_leather", count = 4 } }
    recipe:component_any { { id = "granola", count = 6 } }
    recipe:component_any { { id = "water_mineral", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_raidlength2",
        result = "upgradekey_raidlength2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "boots_hiking", count = 2 } }
    recipe:component_any { { id = "backpack_hiking", count = 2 } }
    recipe:component_any { { id = "pants_hiking", count = 1 } }
    recipe:component_any { { id = "rehydration_drink", count = 5 } }
    recipe:component_any { { id = "protein_bar_evac", count = 10 }, { id = "protein_smoothie", count = 4 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_slaughter",
        result = "upgradekey_slaughter",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "corpse", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_bonusmissions1",
        result = "upgradekey_bonusmissions1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "fp_loyalty_card", count = 1 } }
    recipe:component_any { { id = "coin_penny", count = 1 } }
    recipe:component_any { { id = "coin_nickel", count = 1 } }
    recipe:component_any { { id = "coin_dime", count = 1 } }
    recipe:component_any { { id = "coin_quarter", count = 1 } }
    recipe:component_any { { id = "money_one", count = 1 } }
    recipe:component_any { { id = "money_five", count = 1 } }
    recipe:component_any { { id = "money_ten", count = 1 } }
    recipe:component_any { { id = "money_twenty", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_bonusmissions2",
        result = "upgradekey_bonusmissions2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "gasdiscount_platinum", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 3 } }
    recipe:component_any { { id = "ring_purity", count = 1 } }
    recipe:component_any { { id = "ring_engagement", count = 1 } }
    recipe:component_any { { id = "ring_wedding", count = 1 } }
    recipe:component_any { { id = "sf_watch", count = 1 } }
    recipe:component_any { { id = "cufflinks_intricate", count = 1 } }
    recipe:component_any { { id = "ring_signet", count = 1 } }
    recipe:component_any { { id = "platinum_locket", count = 1 } }
    recipe:component_any { { id = "tieclip", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_bonusmissions3",
        result = "upgradekey_bonusmissions3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "jade_brooch", count = 1 }, { id = "crown_golden", count = 1 }, { id = "crown_golden_survivor", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 6 } }
    recipe:component_any { { id = "platinum_small", count = 100 } }
    recipe:component_any { { id = "gold_small", count = 200 } }
    recipe:component_any { { id = "silver_small", count = 500 } }
    recipe:component_any { { id = "diamond", count = 5 } }
    recipe:component_any { { id = "ruby", count = 1 } }
    recipe:component_any { { id = "emerald", count = 1 } }
    recipe:component_any { { id = "onyx", count = 1 } }
    recipe:component_any { { id = "garnet", count = 1 } }
    recipe:component_any { { id = "sapphire", count = 1 } }
    recipe:component_any { { id = "opal", count = 1 } }
    recipe:component_any { { id = "pearl", count = 1 } }
    recipe:component_any { { id = "citrine", count = 1 } }
    recipe:component_any { { id = "peridot", count = 1 } }
    recipe:component_any { { id = "amethyst", count = 1 } }
    recipe:component_any { { id = "tourmaline", count = 1 } }
    recipe:component_any { { id = "aquamarine", count = 1 } }
    recipe:component_any { { id = "alexandrite", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_bonusmissions4",
        result = "upgradekey_bonusmissions4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 8 } }
    recipe:component_any { { id = "money_bundle_one", count = 2 } }
    recipe:component_any { { id = "money_bundle_two", count = 2 } }
    recipe:component_any { { id = "money_bundle_five", count = 2 } }
    recipe:component_any { { id = "money_bundle_ten", count = 2 } }
    recipe:component_any { { id = "money_bundle_twenty", count = 2 } }
    recipe:component_any { { id = "money_bundle_fifty", count = 2 } }
    recipe:component_any { { id = "money_bundle_hundred", count = 2 } }
    recipe:component_any { { id = "spiral_stone", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_bonusmissions5",
        result = "upgradekey_bonusmissions5",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:tool_any { { id = "black_pen", charges = 5000 } }
    recipe:tool_any { { id = "blue_pen", charges = 5000 } }
    recipe:tool_any { { id = "red_pen", charges = 5000 } }
    recipe:tool_any { { id = "green_pen", charges = 5000 } }
    recipe:component_any { { id = "warptoken", count = 10 } }
    recipe:component_any { { id = "paper", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_hardmissions1",
        result = "upgradekey_hardmissions1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "bat", count = 1 }, { id = "bwirebat", count = 1 }, { id = "nailbat", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 2 } }
    recipe:component_any { { id = "bandages", count = 10 } }
    recipe:component_any { { id = "liq_bandage_spray", count = 1 } }
    recipe:component_any { { id = "9mm", count = 50 }, { id = "9mmfmj", count = 50 }, { id = "9mmP", count = 30 }, { id = "9mmP2", count = 20 } }
    recipe:quality("PISTOL", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_hardmissions2",
        result = "upgradekey_hardmissions2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "hammer_sledge", count = 1 }, { id = "hammer_sledge_short", count = 1 }, { id = "hammer_sledge_heavy", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 2 } }
    recipe:component_any { { id = "quikclot", count = 8 } }
    recipe:component_any { { id = "bfipowder", count = 10 } }
    recipe:component_any { { id = "shot_00", count = 40 } }
    recipe:component_any { { id = "grenade", count = 1 } }
    recipe:quality("SHOTGUN", 1, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_scouting1",
        result = "upgradekey_scouting1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "glasses_eye", count = 1 }, { id = "glasses_bifocal", count = 1 }, { id = "glasses_reading", count = 1 } }
    recipe:component_any { { id = "any_pipe", count = 1, requirement = true } }
    recipe:component_any { { id = "wire", count = 5 } }
    recipe:component_any { { id = "tinder", count = 5 } }
    recipe:component_any { { id = "cordage_short", count = 1, requirement = true } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_scouting2",
        result = "upgradekey_scouting2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "binoculars", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 2 } }
    recipe:component_any { { id = "cu_pipe", count = 5 } }
    recipe:component_any { { id = "duct_tape", count = 20 } }
    recipe:component_any { { id = "light_battery_cell", count = 5 }, { id = "light_battery_cell", count = 10 }, { id = "light_battery_cell", count = 15 } }
    recipe:component_any { { id = "cordage", count = 1, requirement = true } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_scouting3",
        result = "upgradekey_scouting3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "camera", count = 1 }, { id = "camera_pro", count = 1 }, { id = "wearable_camera", count = 1 }, { id = "wearable_camera_pro", count = 1 }, { id = "omnicamera", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 5 } }
    recipe:component_any { { id = "scrap_aluminum", count = 12 } }
    recipe:component_any { { id = "glue_strong", count = 10 }, { id = "glue_weak", count = 150 } }
    recipe:component_any { { id = "medium_battery_cell", count = 6 } }
    recipe:component_any { { id = "extension_cable", count = 1 }, { id = "long_extension_cable", count = 1 }, { id = "jumper_cable", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_scouting4",
        result = "upgradekey_scouting4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "lens", count = 2 }, { id = "lens_small", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 8 } }
    recipe:component_any { { id = "microscope", count = 1 } }
    recipe:component_any { { id = "silver_small", count = 20 } }
    recipe:component_any { { id = "brazing_rod_bronze", count = 5 }, { id = "brazing_rod_alloy", count = 5 } }
    recipe:component_any { { id = "heavy_plus_battery_cell", count = 1 }, { id = "heavy_battery_cell", count = 2 } }
    recipe:component_any { { id = "rope_30", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_scouting5",
        result = "upgradekey_scouting5",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "microscope_dissecting", count = 1 } }
    recipe:component_any { { id = "sensor_module", count = 1 } }
    recipe:component_any { { id = "book_newage_witchcraftbeg", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 12 } }
    recipe:component_any { { id = "platinum_small", count = 10 } }
    recipe:component_any { { id = "battery_car", count = 1 }, { id = "battery_motorbike", count = 1 }, { id = "medium_storage_battery", count = 1 } }
    recipe:component_any { { id = "hd_tow_cable", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_scouting6",
        result = "upgradekey_scouting6",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "tele_sight", count = 1 } }
    recipe:component_any { { id = "cantilever_small", count = 1 } }
    recipe:component_any { { id = "survivor_scope", count = 3 } }
    recipe:component_any { { id = "warptoken", count = 16 } }
    recipe:component_any { { id = "plastic_chunk", count = 20 } }
    recipe:component_any { { id = "beeper", count = 1 }, { id = "stereo", count = 1 }, { id = "chimes", count = 1 } }
    recipe:component_any { { id = "radio", count = 1 } }
    content.upsert(recipe)
end

-- The components below allow all CBMs that enhances eyes or vision.
-- Two petrified eyes in a sky island run is a daunting task, so the other components are easier to find to compensate.
do
    local recipe = warped_recipe {
        id = "upgradekey_scouting7",
        result = "upgradekey_scouting7",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "bio_eye_optic", count = 1 }, { id = "bio_armor_eyes", count = 1 }, { id = "bio_ar", count = 1 }, { id = "bio_eye_enhancer", count = 1 }, { id = "bio_infrared", count = 1 }, { id = "bio_night_vision", count = 1 } }
    recipe:component_any { { id = "steroid_eyedrops", count = 50 }, { id = "eyedrops", count = 50 } }
    recipe:component_any { { id = "warptoken", count = 20 } }
    recipe:component_any { { id = "petrified_eye", count = 2 } }
    recipe:component_any { { id = "magic_8_ball", count = 3 } }
    recipe:component_any { { id = "steel_lump", count = 10 } }
    content.upsert(recipe)
end

-- Yrax sensors are very hard to find, so the other components are few to compensate.
do
    local recipe = warped_recipe {
        id = "upgradekey_scouting8",
        result = "upgradekey_scouting8",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "exodii_sensor", count = 3 } }
    recipe:component_any { { id = "self_monitoring_module", count = 2 } }
    recipe:component_any { { id = "yrax_sensor", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 24 } }
    recipe:component_any { { id = "book_newage_witchcraftadv", count = 1 } }
    recipe:component_any { { id = "gold_small", count = 100 } }
    content.upsert(recipe)
end

-- The clay urn is craftable, the porcelain urn is 100% likely to be found in retirement centers and a crystal urn can be found in one mansion out of two.
do
    local recipe = warped_recipe {
        id = "upgradekey_scoutingclairvoyance1",
        result = "upgradekey_scoutingclairvoyance1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "book_newage_inpsychic", count = 1 }, { id = "book_newage_beyondveil", count = 1 } }
    recipe:component_any { { id = "clay_urn", count = 1 } }
    recipe:component_any { { id = "porcelain_urn", count = 1 } }
    recipe:component_any { { id = "crystal_urn", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 16 } }
    recipe:component_any { { id = "corpse_ash", count = 300 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_scoutingclairvoyance2",
        result = "upgradekey_scoutingclairvoyance2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "broken_lab_security_drone_BM", count = 5 }, { id = "broken_lab_security_drone_YM", count = 5 }, { id = "broken_lab_security_drone_GR", count = 5 }, { id = "broken_lab_security_drone_GM", count = 5 }, { id = "broken_lab_security_drone_BM2", count = 5 } }
    recipe:component_any { { id = "pathfinding_module", count = 5 } }
    recipe:component_any { { id = "warptoken", count = 22 } }
    recipe:component_any { { id = "light_detector", count = 5 } }
    recipe:component_any { { id = "emf_detector", count = 1 } }
    recipe:component_any { { id = "geiger_off", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_stability1",
        result = "upgradekey_stability1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "antibiotics", count = 4 }, { id = "weak_antibiotic", count = 8 }, { id = "strong_antibiotic", count = 2 } }
    recipe:component_any { { id = "warptoken", count = 3 } }
    recipe:component_any { { id = "antifungal", count = 4 } }
    recipe:component_any { { id = "antiparasitic", count = 4 } }
    recipe:component_any { { id = "weed", count = 10 } }
    recipe:component_any { { id = "amplifier", count = 5 } }
    recipe:component_any { { id = "news_regional", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_stability2",
        result = "upgradekey_stability2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "flu_shot", count = 2 } }
    recipe:component_any { { id = "warptoken", count = 8 } }
    recipe:component_any { { id = "prussian_blue", count = 4 }, { id = "iodine", count = 4 }, { id = "prussian_blue", count = 4 } }
    recipe:component_any { { id = "meth", count = 10 } }
    recipe:component_any { { id = "solar_cell", count = 5 } }
    recipe:component_any { { id = "motor", count = 1 } }
    recipe:component_any { { id = "mag_news", count = 1 } }
    recipe:component_any { { id = "mag_beauty", count = 1 } }
    recipe:component_any { { id = "mag_cars", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_stability3",
        result = "upgradekey_stability3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "mutagen_medical", count = 1 }, { id = "iv_mutagen_medical", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 15 } }
    recipe:component_any { { id = "geiger_off", count = 1 } }
    recipe:component_any { { id = "scalpel", count = 1 } }
    recipe:component_any { { id = "stethoscope", count = 1 } }
    recipe:component_any { { id = "pure_meth", count = 1 } }
    recipe:component_any { { id = "transponder", count = 4 } }
    recipe:component_any { { id = "receiver", count = 4 } }
    recipe:component_any { { id = "recipe_maiar", count = 1 }, { id = "recipe_lab_elec", count = 1 }, { id = "textbook_atomic_lab", count = 1 }, { id = "recipe_lab_cvd", count = 1 }, { id = "recipe_creepy", count = 1 }, { id = "recipe_animal", count = 1 }, { id = "recipe_labchem", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_stability4",
        result = "upgradekey_stability4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "panacea", count = 1 }, { id = "purifier_smart_shot", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 25 } }
    recipe:component_any { { id = "plut_cell", count = 5 } }
    recipe:component_any { { id = "dimensional_anchor", count = 1 }, { id = "broken_dimensional_anchor", count = 1 } }
    recipe:component_any { { id = "c4", count = 1 } }
    recipe:component_any { { id = "fidget_spinner", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_stability5",
        result = "upgradekey_stability5",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "ballistic_vest_heavy", count = 2 } }
    recipe:component_any { { id = "warptoken", count = 30 } }
    recipe:component_any { { id = "alien_pod_resin", count = 5 } }
    recipe:component_any { { id = "oxygen_tank", count = 5 }, { id = "scuba_tank", count = 5 } }
    recipe:component_any { { id = "iv_mutagen_medical", count = 1 } }
    recipe:component_any { { id = "caviar_egg_sandwich", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_stability6",
        result = "upgradekey_stability6",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 35 } }
    recipe:component_any { { id = "helmet_acidchitin", count = 1 }, { id = "helmet_bronze", count = 1 } }
    recipe:component_any { { id = "armor_acidchitin", count = 1 }, { id = "cuirass_bronze", count = 1 } }
    recipe:component_any { { id = "armguard_acidchitin", count = 1 }, { id = "armguard_bronze", count = 1 } }
    recipe:component_any { { id = "legguard_acidchitin", count = 1 }, { id = "legguard_bronze", count = 1 } }
    recipe:component_any { { id = "hard_steel_armor", count = 1 }, { id = "migo_plate", count = 1 }, { id = "migo_sideplate", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_stability7",
        result = "upgradekey_stability7",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "corpse_yugg_jade", count = 1 }, { id = "corpse_yugg_rubber", count = 1 }, { id = "corpse_yugg_mutflesh", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 40 } }
    recipe:component_any { { id = "wine_marloss", count = 1 } }
    recipe:component_any { { id = "resonance_measurement_device", count = 1 }, { id = "nre_recorder", count = 1 } }
    recipe:component_any { { id = "pure_meth", count = 6 } }
    recipe:component_any { { id = "friday", count = 1 }, { id = "spirit_island", count = 1 } }
    recipe:component_any { { id = "violin_golden", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_basementsunlock",
        result = "upgradekey_basementsunlock",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "fursuit", count = 1 } }
    recipe:component_any { { id = "bodypillow", count = 2 } }
    recipe:component_any { { id = "catan", count = 1 } }
    recipe:component_any { { id = "dnd", count = 1 } }
    recipe:component_any { { id = "snakesnladders", count = 1 } }
    recipe:component_any { { id = "chess", count = 1 } }
    recipe:component_any { { id = "RPG_die", count = 4 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_roofsunlock",
        result = "upgradekey_roofsunlock",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "survivor_scope", count = 1 } }
    recipe:component_any { { id = "golf_tee", count = 1 } }
    recipe:component_any { { id = "feather", count = 40 }, { id = "down_feather", count = 40 } }
    recipe:component_any { { id = "eggs_any_shape", count = 6, requirement = true } }
    recipe:component_any { { id = "golf_ball", count = 1 } }
    recipe:component_any { { id = "camp_chair", count = 1 } }
    recipe:component_any { { id = "tourist_table", count = 1 } }
    recipe:component_any { { id = "stepladder", count = 1 }, { id = "aluminum_stepladder", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_labsunlock",
        result = "upgradekey_labsunlock",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "id_science", count = 1 } }
    recipe:component_any { { id = "plut_cell", count = 5 } }
    recipe:component_any { { id = "oxy_torch", count = 1 } }
    recipe:component_any { { id = "tinyweldtank", count = 1 }, { id = "weldtank", count = 1 } }
    recipe:component_any { { id = "mutagen", count = 2 }, { id = "iv_mutagen", count = 1 } }
    recipe:component_any { { id = "jackhammer", count = 1 }, { id = "elec_jackhammer", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "secure_container_1",
        result = "secure_container_1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "secure_container_2",
        result = "secure_container_2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "secure_container_3",
        result = "secure_container_3",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "secure_container_4",
        result = "secure_container_4",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "secure_container_5",
        result = "secure_container_5",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_warped_harness1",
        result = "upgradekey_warped_harness1",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "frame", count = 10 } }
    recipe:component_any { { id = "cargo_rack", count = 4 } }
    recipe:component_any { { id = "v6_combustion", count = 1 }, { id = "v6_diesel", count = 1 }, { id = "v8_combustion", count = 1 }, { id = "v8_diesel", count = 1 } }
    recipe:component_any { { id = "wheel_wide_or", count = 4 }, { id = "wheel", count = 4 }, { id = "wheel_wide", count = 4 } }
    recipe:component_any { { id = "wheel_mount_medium", count = 4 } }
    recipe:component_any { { id = "alternator_car", count = 1 } }
    recipe:component_any { { id = "metal_tank", count = 1 } }
    recipe:component_any { { id = "battery_car", count = 1 } }
    recipe:quality("LIFT", 8, 1)
    recipe:quality("JACK", 4, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "upgradekey_warped_harness2",
        result = "upgradekey_warped_harness2",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "hdframe", count = 5 } }
    recipe:component_any { { id = "livestock_carrier", count = 2 } }
    recipe:component_any { { id = "v12_diesel", count = 2 }, { id = "v12_combustion", count = 2 } }
    recipe:component_any { { id = "wheel_armor", count = 4 } }
    recipe:component_any { { id = "wheel_mount_heavy", count = 4 } }
    recipe:component_any { { id = "alternator_truck", count = 2 } }
    recipe:component_any { { id = "metal_tank", count = 2 } }
    recipe:component_any { { id = "battery_car", count = 4 } }
    recipe:quality("LIFT", 40, 1)
    recipe:quality("JACK", 16, 1)
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_grassbag",
        result = "warp_grassbag",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        autolearn = true,
    }
    recipe:result_charges(100)
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_wood_floor_tokens",
        result = "warp_wood_floor_tokens",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        autolearn = true,
    }
    recipe:result_charges(50)
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    recipe:component_any { { id = "2x4", count = 25 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_flagstone_floor_tokens",
        result = "warp_flagstone_floor_tokens",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        autolearn = true,
    }
    recipe:result_charges(50)
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    recipe:component_any { { id = "rock_large", count = 25 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_sand_floor_tokens",
        result = "warp_sand_floor_tokens",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        autolearn = true,
    }
    recipe:result_charges(50)
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    recipe:component_any { { id = "material_sand", count = 2500 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_flesh_floor_tokens",
        result = "warp_flesh_floor_tokens",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        autolearn = true,
    }
    recipe:result_charges(50)
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    recipe:component_any { { id = "any_blood", count = 6, requirement = true } }
    recipe:component_any { { id = "meat_offal", count = 2, requirement = true } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_waterwalking_stone",
        result = "warp_waterwalking_stone",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        autolearn = true,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 3 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_vortex_token",
        result = "warp_vortex_token",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 15 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_skyward_beacon",
        result = "warp_skyward_beacon",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 10 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warpextender",
        result = "warpextender",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 3 } }
    recipe:component_any { { id = "clay_lump", count = 3 } }
    recipe:component_any { { id = "rock", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_healing_salve",
        result = "warp_healing_salve",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    recipe:component_any { { id = "bandages", count = 1 }, { id = "bandages_makeshift", count = 2 }, { id = "bandages_makeshift_bleached", count = 2 }, { id = "bandages_makeshift_boiled", count = 2 }, { id = "adhesive_bandages", count = 5 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warphome",
        result = "warphome",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 20 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warphaulbag",
        result = "warphaulbag",
        subcategory = "CSC_WARP_GEAR",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 10 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warphaulbag_tier2",
        result = "warphaulbag_tier2",
        subcategory = "CSC_WARP_GEAR",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 20 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warphaulbag_tier3",
        result = "warphaulbag_tier3",
        subcategory = "CSC_WARP_GEAR",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 30 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_carrier",
        result = "warp_carrier",
        subcategory = "CSC_WARP_GEAR",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 12 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_autodoc_inert",
        result = "warp_autodoc_inert",
        subcategory = "CSC_WARP_TOOLS",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 30 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "recipe_craft_random_artifact",
        name = ccb.content.text("materialize random artifact"),
        description = ccb.content.text("Utilizing the unstable, reality-changing nature of the warp shards, you could combine several to create a powerful semi-magical item.  This is a skill you have no way of practicing and a field of science no one's ever really touched, so exactly what you'd get from it is anyone's guess."),
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 8 } }
    recipe:on_complete("sky_craft_random_artifact")
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_labs_catalyst",
        result = "warp_labs_catalyst",
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 15 } }
    recipe:component_any { { id = "id_science", count = 1 } }
    recipe:component_any { { id = "microscope_dissecting", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "item_merchant_attractor",
        result = "item_merchant_attractor",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 90000,
        flags = { "SECRET", "BLIND_EASY" },
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 10 } }
    recipe:component_any { { id = "coin_penny", count = 1 }, { id = "coin_nickel", count = 1 } }
    recipe:component_any { { id = "coin_dime", count = 1 }, { id = "coin_quarter", count = 1 } }
    recipe:component_any { { id = "money_one", count = 1 }, { id = "money_five", count = 1 } }
    recipe:component_any { { id = "money_ten", count = 1 }, { id = "money_twenty", count = 1 } }
    recipe:component_any { { id = "money_fifty", count = 1 }, { id = "money_hundred", count = 1 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_folded_infinitree",
        result = "warp_folded_infinitree",
        subcategory = "CSC_WARP_TOOLS",
        duration_moves = 90000,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 3 } }
    recipe:component_any { { id = "2x4", count = 2 } }
    recipe:component_any { { id = "stick_long", count = 1 }, { id = "stick", count = 2 }, { id = "twig", count = 6 } }
    recipe:component_any { { id = "leaves", count = 8 } }
    recipe:component_any { { id = "splinter", count = 4 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_folded_infinitystone",
        result = "warp_folded_infinitystone",
        subcategory = "CSC_WARP_TOOLS",
        duration_moves = 90000,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 3 } }
    recipe:component_any { { id = "rock", count = 10 } }
    recipe:component_any { { id = "clay_lump", count = 5 }, { id = "material_sand", count = 20 } }
    recipe:component_any { { id = "rock_flaking", count = 4 }, { id = "rock_large", count = 1 } }
    recipe:component_any { { id = "material_soil", count = 2 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warp_folded_infinityore",
        result = "warp_folded_infinityore",
        subcategory = "CSC_WARP_TOOLS",
        duration_moves = 90000,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 3 } }
    recipe:component_any { { id = "scrap", count = 20 }, { id = "steel_chunk_any", count = 4, requirement = true }, { id = "steel_lump_any", count = 1, requirement = true } }
    recipe:component_any { { id = "pipe", count = 2 }, { id = "wire", count = 6 } }
    recipe:component_any { { id = "nuts_bolts", count = 4 }, { id = "pipe_fittings", count = 4 }, { id = "sheet_metal_small", count = 10 } }
    recipe:component_any { { id = "nail", count = 40 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "sky_island_warped_pond",
        name = ccb.content.text("Warped Pond"),
        description = ccb.content.text("Create a pond on your island.  You must be standing next to a water source to successfully create the pond."),
        subcategory = "CSC_WARP_UPGRADES",
        duration_moves = 0,
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 30 } }
    recipe:on_complete("sky_craft_warped_pond")
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warped_autodoc_upgrader_1",
        result = "warped_autodoc_upgrader_1",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 360000,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 20 } }
    recipe:component_any { { id = "ether", count = 150 } }
    recipe:component_any { { id = "xanax", count = 8 } }
    recipe:component_any { { id = "record_patient", count = 1 } }
    recipe:component_any { { id = "medical_sample", count = 2 } }
    recipe:component_any { { id = "vacutainer", count = 1 } }
    recipe:component_any { { id = "gloves_medical", count = 6 } }
    recipe:component_any { { id = "stethoscope", count = 2 } }
    content.upsert(recipe)
end

do
    local recipe = warped_recipe {
        id = "warped_autodoc_upgrader_2",
        result = "warped_autodoc_upgrader_2",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 360000,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 40 } }
    recipe:component_any { { id = "oxycodone", count = 10 } }
    recipe:component_any { { id = "record_patient", count = 3 } }
    recipe:component_any { { id = "diazepam", count = 5 } }
    recipe:component_any { { id = "morphine", count = 10 } }
    recipe:component_any { { id = "medical_sample", count = 10 } }
    recipe:component_any { { id = "badge_doctor", count = 1 } }
    recipe:component_any { { id = "software_medical", count = 1 } }
    content.upsert(recipe)
end

-- 3000 g unworked wood per token
do
    local recipe = warped_recipe {
        id = "log_from_tokens",
        result = "log",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 10 } }
    content.upsert(recipe)
end

-- ~1950 g worked wood per token
do
    local recipe = warped_recipe {
        id = "2x4_from_tokens",
        result = "2x4",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 4,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 5 } }
    content.upsert(recipe)
end

-- 3000 g unworked wood per token
do
    local recipe = warped_recipe {
        id = "stick_long_from_tokens",
        result = "stick_long",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 3000 g unworked wood per token
do
    local recipe = warped_recipe {
        id = "stick_from_tokens",
        result = "stick",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 2,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 3000 g unworked wood per token
do
    local recipe = warped_recipe {
        id = "splinter_from_tokens",
        result = "splinter",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 20,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 2000 g worked wood per token
do
    local recipe = warped_recipe {
        id = "wood_panel_from_tokens",
        result = "wood_panel",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 6 } }
    content.upsert(recipe)
end

-- ~1900 g worked wood per token
do
    local recipe = warped_recipe {
        id = "wooden_post_short_from_tokens",
        result = "wooden_post_short",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 2,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 3 } }
    content.upsert(recipe)
end

-- ~1900 g worked wood per token
do
    local recipe = warped_recipe {
        id = "wooden_post_from_tokens",
        result = "wooden_post",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 3 } }
    content.upsert(recipe)
end

-- ~1950 g worked wood per token
do
    local recipe = warped_recipe {
        id = "wood_beam_from_tokens",
        result = "wood_beam",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinitree1", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 25 } }
    content.upsert(recipe)
end

-- 30 cents steel per token
do
    local recipe = warped_recipe {
        id = "nuts_bolts_from_tokens",
        result = "nuts_bolts",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:result_charges(15)
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "pipe_fittings_from_tokens",
        result = "pipe_fittings",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 4 } }
    content.upsert(recipe)
end

-- 30 cents copper per token
do
    local recipe = warped_recipe {
        id = "scrap_copper_from_tokens",
        result = "scrap_copper",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 400 g steel per token
do
    local recipe = warped_recipe {
        id = "pipe_from_tokens",
        result = "pipe",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 2,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 3 } }
    content.upsert(recipe)
end

-- 30 cents steel per token
do
    local recipe = warped_recipe {
        id = "nail_from_tokens",
        result = "nail",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:result_charges(15)
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 5 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "wire_from_tokens",
        result = "wire",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 5,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 2 } }
    content.upsert(recipe)
end

-- 10000 g soil per token
do
    local recipe = warped_recipe {
        id = "adobe_brick_from_tokens",
        result = "adobe_brick",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 30 cents clay per token
do
    local recipe = warped_recipe {
        id = "brick_from_tokens",
        result = "brick",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 6,
    }
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 30 cents cement per token
do
    local recipe = warped_recipe {
        id = "material_cement_from_tokens",
        result = "material_cement",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 30,
    }
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 10000 g sand per token
do
    local recipe = warped_recipe {
        id = "material_sand_from_tokens",
        result = "material_sand",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 1250,
    }
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 30 cents clay per token
do
    local recipe = warped_recipe {
        id = "clay_lump_from_tokens",
        result = "clay_lump",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 10000 g soil per token
do
    local recipe = warped_recipe {
        id = "material_soil_from_tokens",
        result = "material_soil",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 2 } }
    content.upsert(recipe)
end

-- 30 cents limestone per token
do
    local recipe = warped_recipe {
        id = "material_limestone_from_tokens",
        result = "material_limestone",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:result_charges(50)
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 5200 g stone per token
do
    local recipe = warped_recipe {
        id = "rock_large_from_tokens",
        result = "rock_large",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 3 } }
    content.upsert(recipe)
end

-- 5200 g stone per token
do
    local recipe = warped_recipe {
        id = "rock_from_tokens",
        result = "rock",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 8,
    }
    recipe:tool_any { { id = "fakeitem_infinitystone", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 30 cents steel per token
do
    local recipe = warped_recipe {
        id = "scrap_from_tokens",
        result = "scrap",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:result_charges(2)
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "budget_steel_chunk_from_tokens",
        result = "budget_steel_chunk",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 2 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "lc_steel_chunk_from_tokens",
        result = "lc_steel_chunk",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 2 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "mc_steel_chunk_from_tokens",
        result = "mc_steel_chunk",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 2 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "hc_steel_chunk_from_tokens",
        result = "hc_steel_chunk",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 2 } }
    content.upsert(recipe)
end

-- Treating ch_steel as 2.5x as valuable as mc_steel: 25 cents steel per token
do
    local recipe = warped_recipe {
        id = "ch_steel_chunk_from_tokens",
        result = "ch_steel_chunk",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- Treating qt_steel as 5x as valuable as mc_steel: 25 cents steel per token
do
    local recipe = warped_recipe {
        id = "qt_steel_chunk_from_tokens",
        result = "qt_steel_chunk",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 2 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "budget_steel_lump_from_tokens",
        result = "budget_steel_lump",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 8 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "lc_steel_lump_from_tokens",
        result = "lc_steel_lump",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 8 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "mc_steel_lump_from_tokens",
        result = "mc_steel_lump",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 8 } }
    content.upsert(recipe)
end

-- 375 g steel per token
do
    local recipe = warped_recipe {
        id = "hc_steel_lump_from_tokens",
        result = "hc_steel_lump",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
        result_multiplier = 3,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 8 } }
    content.upsert(recipe)
end

-- Treating ch_steel as 2.5x as valuable as mc_steel: 25 cents steel per token
do
    local recipe = warped_recipe {
        id = "ch_steel_lump_from_tokens",
        result = "ch_steel_lump",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 5 } }
    content.upsert(recipe)
end

-- Treating qt_steel as 5x as valuable as mc_steel: 25 cents steel per token
do
    local recipe = warped_recipe {
        id = "qt_steel_lump_from_tokens",
        result = "qt_steel_lump",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 10 } }
    content.upsert(recipe)
end

-- 25 cents steel per token
do
    local recipe = warped_recipe {
        id = "sheet_metal_small_from_tokens",
        result = "sheet_metal_small",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 1 } }
    content.upsert(recipe)
end

-- 400 g steel per token
do
    local recipe = warped_recipe {
        id = "sheet_metal_from_tokens",
        result = "sheet_metal",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 15 } }
    content.upsert(recipe)
end

-- 400 g steel per token
do
    local recipe = warped_recipe {
        id = "frame_from_tokens",
        result = "frame",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 50 } }
    content.upsert(recipe)
end

-- 400 g steel per token
do
    local recipe = warped_recipe {
        id = "hdframe_from_tokens",
        result = "hdframe",
        subcategory = "CSC_WARP_MATERIALS",
        duration_moves = 100,
        autolearn = true,
    }
    recipe:tool_any { { id = "fakeitem_infinityore", count = 1 } }
    recipe:component_any { { id = "warptoken_material", count = 250 } }
    content.upsert(recipe)
end

content.add(content.Recipe {
    id = "quickheal",
    result = "quickheal",
    uncraft = true,
    reversible = true,
    autolearn = false,
    duration_moves = 200,
    activity_level = 1,
}
    :tool("fakeitem_statue", 1)
    :component("warptoken", 4))

content.add(content.Recipe {
    id = "warpmetalbag",
    result = "warpmetalbag",
    uncraft = true,
    reversible = true,
    autolearn = false,
    duration_moves = 200,
    activity_level = 1,
}
    :tool("fakeitem_statue", 1)
    :component("warptoken", 5))

content.add(content.Recipe {
    id = "warpdirtbag",
    result = "warpdirtbag",
    uncraft = true,
    reversible = true,
    autolearn = false,
    duration_moves = 200,
    activity_level = 1,
}
    :tool("fakeitem_statue", 1)
    :component("warptoken", 5))
