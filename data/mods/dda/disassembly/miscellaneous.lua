local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

local function disassembly(result, moves, activity, options)
    options = options or {}
    options.id = "uncraft_" .. result
    options.result = result
    options.uncraft = true
    options.reversible = true
    options.autolearn = false
    options.duration_moves = moves
    options.activity_level = activity
    return content.Recipe(options)
end

content.add(disassembly("urbexmap", 3000, NO_EXERCISE, { flags = { "BLIND_EASY" } })
    :component("paper", 10)
)

content.add(disassembly("saline_bag_250_empty", 500, MODERATE_EXERCISE)
    :component("plastic_sheet_small", 1)
)

content.add(disassembly("saline_bag_500_empty", 500, MODERATE_EXERCISE)
    :component("plastic_sheet_small", 2)
)

content.add(disassembly("saline_bag_1000_empty", 500, MODERATE_EXERCISE)
    :component("plastic_sheet_small", 4)
)

content.add(disassembly("saline_bag_2000_empty", 500, MODERATE_EXERCISE)
    :component("plastic_sheet_small", 8)
)

content.add(disassembly("mre_bag_jam", 500, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("aluminum_foil", 37)
    :component("plastic_sheet_small", 1)
)

content.add(disassembly("mre_bag_dessert", 500, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("aluminum_foil", 111)
    :component("plastic_sheet_small", 4)
)

content.add(disassembly("mre_bag_spread", 500, NO_EXERCISE)
    :quality("CUT", 1, 1)
    :component("aluminum_foil", 37)
    :component("plastic_sheet_small", 1)
)

content.add(disassembly("stirling_kit_box", 24000, LIGHT_EXERCISE)
    :quality("CUT", 2, 1)
    :component("cardboard", 40)
)

content.add(disassembly("robot_kit_box", 24000, LIGHT_EXERCISE)
    :quality("CUT", 2, 1)
    :component("cardboard", 40)
)

content.add(disassembly("bottle_glass_seasoning_small", 100, LIGHT_EXERCISE, { flags = { "BLIND_EASY" } })
    :component("glass_shard", 2)
)

content.add(disassembly("bag_durasack", 30000, LIGHT_EXERCISE, { flags = { "BLIND_EASY" } })
    :quality("CUT", 2, 1)
    :component("plastic_sheet", 18)
)

content.add(disassembly("bag_durasack_cement", 30000, LIGHT_EXERCISE, { flags = { "BLIND_EASY" } })
    :component("plastic_sheet", 18)
    :component("paper", 1)
)

content.add(disassembly("ammunition_can_30", 42000, BRISK_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("sheet_metal_small", 3)
    :component("scrap", 2)
)

content.add(disassembly("ammunition_can_50", 60000, BRISK_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("sheet_metal_small", 5)
    :component("scrap", 4)
)

content.add(disassembly("ammunition_can_fat_50", 78000, BRISK_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("sheet_metal_small", 8)
    :component("scrap", 3)
)

content.add(disassembly("ammunition_can_pa120", 102000, BRISK_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("sheet_metal_small", 12)
    :component("scrap", 4)
)

content.add(disassembly("ammunition_box_grenade", 150000, BRISK_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("sheet_metal_small", 18)
    :component("scrap", 6)
)

content.add(disassembly("ammunition_box_carlgustav_he", 360000, BRISK_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("sheet_metal", 2)
    :component("sheet_metal_small", 24)
    :component("scrap", 6)
)

content.add(disassembly("ammunition_box_carlgustav_hedp", 360000, BRISK_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("sheet_metal", 2)
    :component("sheet_metal_small", 24)
    :component("scrap", 6)
)

content.add(disassembly("corpse_yugg_mutflesh", 540000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("mutflesh", 1500)
)

content.add(disassembly("broken_flailer_radiosphere", 12000, LIGHT_EXERCISE)
    :quality("CUT", 2, 1)
    :component("cotton_patchwork", 18)
)

content.add(disassembly("bigmirror", 180000, LIGHT_EXERCISE)
    :quality("CUT_GLASS", 1, 1)
    :quality("HAMMER", 1, 1)
    :component("glass_sheet", 2)
    :component("scrap_aluminum", 10)
)

content.add(disassembly("foot_locker", 90000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("SCREW", 1, 1)
    :component("sheet_metal_small", 12)
    :component("scrap", 3)
    :component("hinge", 2)
    :component("lock", 1)
    :component("nuts_bolts", 8)
)

content.add(disassembly("foot_locker_aluminum", 90000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("SCREW", 1, 1)
    :component("material_aluminium_ingot", 12)
    :component("scrap_aluminum", 3)
    :component("hinge", 2)
    :component("lock", 1)
    :component("nuts_bolts", 8)
)

content.add(disassembly("blade_scythe", 0, MODERATE_EXERCISE)
    :component("ch_steel_lump", 1)
)

content.add(disassembly("young_koji_done", 6000, LIGHT_EXERCISE)
    :component("koji", 5)
)

content.add(disassembly("handflare", 2000, MODERATE_EXERCISE, { skill = "fabrication", difficulty = 1 })
    :quality("CUT", 2, 1)
    :component("incendiary", 75)
)

content.add(disassembly("rock_large", 30000, MODERATE_EXERCISE, { skill = "fabrication" })
    :tool_any({
            { id = "pickaxe_list", charges = 1, requirement = true },
            { id = "jackhammering_standard_1_10", charges = 1, requirement = true }
        })
    :component("rock", 24)
)

content.add(disassembly("exodii_ingot_plastic", 5760000, MODERATE_EXERCISE)
    :tool_any({
            { id = "reciprocating_saw", charges = 500 },
            { id = "circsaw_off", charges = 500 }
        })
    :component("10l_plastic", 80)
)

content.add(disassembly("10l_plastic", 60000, MODERATE_EXERCISE)
    :tool_any({
            { id = "reciprocating_saw", charges = 10 },
            { id = "circsaw_off", charges = 10 }
        })
    :component("5l_plastic", 2)
)

content.add(disassembly("5l_plastic", 360000, MODERATE_EXERCISE)
    :tool_any({
            { id = "reciprocating_saw", charges = 50 },
            { id = "circsaw_off", charges = 50 }
        })
    :component("plastic_chunk", 100)
)

content.add(disassembly("atgm_spent", 180000, MODERATE_EXERCISE, { skill = "fabrication" })
    :quality("SAW_M", 1, 1)
    :component("mc_steel_chunk", 38)
)

content.add(disassembly("mattress", 2200, MODERATE_EXERCISE, { skill = "tailor", difficulty = 1 })
    :quality("CUT", 2, 1)
    :component("sheet_cotton", 7)
    :component("cotton_patchwork", 4)
    :component("sheet", 4)
    :component("qt_wire", 20)
)

content.add(disassembly("character_sheet", 100, MODERATE_EXERCISE)
    :component("paper", 3)
)

content.add(disassembly("sole_rubber", 24000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("chunk_rubber", 3)
)

content.add(disassembly("tire_medium", 30000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_strip", 1)
)

content.add(disassembly("tire_medium_slick", 42000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_strip", 2)
)

content.add(disassembly("tire_motorbike", 30000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_strip", 1)
)

content.add(disassembly("tire_motorbike_or", 30000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_strip", 1)
)

content.add(disassembly("tire_wide", 60000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_strip", 3)
)

content.add(disassembly("tire_wide_or", 60000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_strip", 3)
)

content.add(disassembly("tire_bicycle", 30000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_chunk", 3)
)

content.add(disassembly("tire_bicycle_or", 30000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_chunk", 3)
)

content.add(disassembly("rubber_tire_strip", 30000, MODERATE_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_chunk", 5)
)

content.add(disassembly("rubber_slug", 1000, MODERATE_EXERCISE, { flags = { "BLIND_EASY" } })
    :component("chunk_rubber", 1)
)

content.add(disassembly("parachute_mil", 2160000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("sheet_nylon_patchwork", 1972)
)

content.add(disassembly("pallet", 180000, MODERATE_EXERCISE)
    :quality("PRYING_NAIL", 1, 1)
    :component("2x4", 3)
    :component("plank_short", 9)
    :component("nail", 117)
    :component("splinter", 61)
)

content.add(disassembly("432gal_drum_rubber", 2520000, LIGHT_EXERCISE)
    :quality("CUT", 2, 1)
    :component("rubber_tire_chunk", 65)
    :component("scrap", 89)
    :component("water_faucet", 2)
)

content.add(disassembly("shrink_wrap", 500, LIGHT_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :component("plastic_sheet_small", 10)
)

content.add(disassembly("skull_human", 1000, MODERATE_EXERCISE, { flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone_human", 4)
)

content.add(disassembly("skull_human_tainted", 1000, MODERATE_EXERCISE, { skill = "fabrication", flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone_tainted", 4)
)

content.add(disassembly("skull_canis", 1000, MODERATE_EXERCISE, { flags = { "BLIND_EASY" } })
    :quality("HAMMER", 1, 1)
    :component("bone", 2)
)

content.add(disassembly("chalice", 6000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :component("gold_small", 10)
)

content.add(disassembly("pillowcase", 1500, LIGHT_EXERCISE)
    :quality("FABRIC_CUT", 1, 1)
    :quality("CUT", 2, 1)
    :component("sheet_cotton", 3)
    :component("zipper_short_plastic", 1)
    :component("scrap_cotton", 18)
)

-- This recipe somehow manages to lose cotton while creating mass out of thin air. Honestly remarkable, but for
-- me it means I have to look into the weight for thread later on
content.add(disassembly("blanket", 60000, LIGHT_EXERCISE)
    :quality("FABRIC_CUT", 1, 1)
    :quality("CUT", 2, 1)
    :component("sheet_cotton", 20)
    :component("thread", 150)
)

-- This recipe is based off of the blanket recipe above it, with half of the cotton sheets being replaced by
-- patchwork fur sheets.
content.add(disassembly("fur_blanket", 60000, LIGHT_EXERCISE)
    :quality("FABRIC_CUT", 1, 1)
    :quality("CUT", 2, 1)
    :component("sheet_cotton", 10)
    :component("sheet_fur_patchwork", 10)
    :component("thread", 150)
)

content.add(disassembly("quilt", 90000, LIGHT_EXERCISE)
    :quality("FABRIC_CUT", 1, 1)
    :quality("CUT", 2, 1)
    :component("sheet_felt", 32)
    :component("thread", 175)
    :component("cotton_ball", 135)
)

content.add(disassembly("quilt_patchwork", 90000, LIGHT_EXERCISE)
    :quality("FABRIC_CUT", 1, 1)
    :quality("CUT", 2, 1)
    :component("sheet_felt_patchwork", 32)
    :component("thread", 145)
    :component("cotton_ball", 135)
)

content.add(disassembly("crackpipe", 100, NO_EXERCISE)
    :component("glass_shard", 3)
)

content.add(disassembly("pipe_glass", 100, NO_EXERCISE, { flags = { "BLIND_EASY" } })
    :component("glass_shard", 2)
)

content.add(disassembly("water_faucet", 18000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("lc_steel_chunk", 3)
    :component("scrap", 3)
)

content.add(disassembly("teddy_bear", 12000, LIGHT_EXERCISE)
    :quality("FABRIC_CUT", 1, 1)
    :component("sheet_cotton", 2)
    :component("cotton_patchwork", 4)
    :component("down_feather", 5)
)

content.add(disassembly("well_pump", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("chunk_cast_iron", 9)
)

content.add(disassembly("ceramic_mug", 100, NO_EXERCISE, { flags = { "BLIND_EASY" } })
    :component("ceramic_shard", 2)
)

content.add(disassembly("casserole", 100, NO_EXERCISE, { flags = { "BLIND_EASY" } })
    :component("ceramic_shard", 9)
)

content.add(disassembly("fuel_tin", 6000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap", 7)
)

content.add(disassembly("bag_body_bag", 3000, LIGHT_EXERCISE)
    :quality("CUT", 1, 1)
    :component("zipper_long_plastic", 1)
    :component("plastic_sheet", 4)
)

content.add(disassembly("dry_seaweed_pile", 1000, NO_EXERCISE)
    :component("dry_seaweed", 20)
)

content.add(disassembly("seaweed_pile", 1000, NO_EXERCISE)
    :component("seaweed", 20)
)

content.add(disassembly("butterfly_net_makeshift", 12000, LIGHT_EXERCISE)
    :quality("CUT", 2, 1)
    :component("splinter", 2)
    :component("sheet_canvas", 1)
)

content.add(disassembly("butterfly_net_collapsible", 18000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap_aluminum", 3)
    :component("sheet_canvas", 1)
)

content.add(disassembly("discharged_storage_battery", 120000, NO_EXERCISE, { skill = "electronics" })
    :quality("CUT", 2, 1)
    :quality("CUT_FINE", 2, 1)
    :component("plastic_chunk", 2)
    :component("scrap", 7)
    :component("copper", 13)
    :component("aluminum_foil", 400)
    :component("graphite", 98)
    :component("waste_electrolyte_slurry", 1)
)

content.add(disassembly("nl_kipple_scrap_steel", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 1, 1)
    :component("scrap", 4)
)

content.add(disassembly("nl_kipple_scrap_alu", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 1, 1)
    :component("scrap_aluminum", 10)
)

content.add(disassembly("nl_kipple_scrap_copper", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 1, 1)
    :component("scrap_copper", 2)
)

content.add(disassembly("nl_kipple_scrap_plastic", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 1, 1)
    :component("plastic_chunk", 10)
)

-- TODO MAKE A RECIPE FOR THIS AND A BOOK
content.add(disassembly("exodii_wire_kit", 24000, LIGHT_EXERCISE, { skill = "electronics", difficulty = 1 })
    :requirement("soldering_standard", 4)
    :quality("SCREW", 1, 1)
    :component("exodii_micro_computer", 1)
    :component("exodii_micro_module", 1)
    :component("e_scrap", 10)
    :component("clockworks", 1)
)

-- TODO MAKE A RECIPE FOR THIS AND A BOOK
content.add(disassembly("exodii_ac_kit", 24000, LIGHT_EXERCISE, { skill = "electronics", difficulty = 1 })
    :requirement("soldering_standard", 4)
    :quality("SCREW", 1, 1)
    :component("exodii_micro_module", 1)
    :component("e_scrap", 10)
    :component("clockworks", 2)
    :component("pipe", 1)
)

content.add(disassembly("10l_iron", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_iron", 2)
)

content.add(disassembly("5l_iron", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("lump_cast_iron", 39)
)

content.add(disassembly("lump_cast_iron", 90000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("chunk_cast_iron", 4)
)

content.add(disassembly("chunk_cast_iron", 30000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap_cast_iron", 5)
)

content.add(disassembly("sheet_metal", 15000, MODERATE_EXERCISE, { skill = "fabrication", difficulty = 1 })
    :quality("SAW_M", 2, 1)
    :component("sheet_metal_small", 24)
)

content.add(disassembly("sheet_metal_small", 1200, MODERATE_EXERCISE)
    :quality("SAW_M", 2, 1)
    :component("scrap", 5)
)

content.add(disassembly("sheet_aluminum", 15000, MODERATE_EXERCISE, { skill = "fabrication", difficulty = 1 })
    :quality("SAW_M", 2, 1)
    :component("sheet_aluminum_small", 24)
)

content.add(disassembly("sheet_aluminum_small", 1200, MODERATE_EXERCISE)
    :quality("SAW_M", 2, 1)
    :component("scrap_aluminum", 1)
)

content.add(disassembly("railroad_track_item", 90000, BRISK_EXERCISE)
    :quality("SAW_M", 2, 1)
    :component("railroad_track_item_half", 2)
)

content.add(disassembly("railroad_track_item_half", 300000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 45)
    :component("mc_steel_lump", 30)
)

content.add(disassembly("exodii_ingot_tin", 5760000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 500)
    :component("10l_tin", 80)
)

content.add(disassembly("10l_tin", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_tin", 2)
)

content.add(disassembly("5l_tin", 150000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 20)
    :component("1l_tin", 5)
)

content.add(disassembly("1l_tin", 180000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap_tin", 138)
)

content.add(disassembly("exodii_ingot_lead", 5760000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 500)
    :component("10l_lead", 80)
)

content.add(disassembly("10l_lead", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_lead", 2)
)

content.add(disassembly("5l_lead", 150000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 20)
    :component("1l_lead", 5)
)

content.add(disassembly("1l_lead", 180000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("lead", 2268)
)

content.add(disassembly("10l_silver", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_silver", 2)
)

content.add(disassembly("5l_silver", 150000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 20)
    :component("1l_silver", 5)
)

content.add(disassembly("1l_silver", 180000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("silver_small", 1993)
)

content.add(disassembly("10l_gold", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_gold", 2)
)

content.add(disassembly("5l_gold", 150000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 20)
    :component("1l_gold", 5)
)

content.add(disassembly("1l_gold", 180000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("gold_small", 1000)
)

content.add(disassembly("10l_platinum", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_platinum", 2)
)

content.add(disassembly("5l_platinum", 150000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 20)
    :component("1l_platinum", 5)
)

content.add(disassembly("1l_platinum", 180000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("platinum_small", 1000)
)

content.add(disassembly("exodii_ingot_zinc", 5760000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 500)
    :component("10l_zinc", 80)
)

content.add(disassembly("10l_zinc", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_zinc", 2)
)

content.add(disassembly("5l_zinc", 180000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("1l_zinc", 5)
)

content.add(disassembly("1l_zinc", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("zinc_metal", 1000)
)

content.add(disassembly("exodii_ingot_lc_steel", 5760000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 500)
    :component("10l_steel", 80)
)

content.add(disassembly("10l_steel", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_steel", 2)
)

content.add(disassembly("5l_steel", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("lc_steel_lump", 39)
)

content.add(disassembly("exodii_ingot_copper", 5760000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 500)
    :component("10l_copper", 80)
)

content.add(disassembly("10l_copper", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_copper", 2)
)

content.add(disassembly("5l_copper", 180000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("1l_copper", 5)
)

content.add(disassembly("1l_copper", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("scrap_copper", 34)
)

content.add(disassembly("10l_brass", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_brass", 2)
)

content.add(disassembly("5l_brass", 180000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("1l_brass", 5)
)

content.add(disassembly("1l_brass", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("scrap_brass", 20)
)

content.add(disassembly("10l_bronze", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_bronze", 2)
)

content.add(disassembly("5l_bronze", 180000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("1l_bronze", 5)
)

-- Slight loss from rounding
content.add(disassembly("1l_bronze", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("scrap_bronze", 24)
)

content.add(disassembly("exodii_ingot_aluminum", 5760000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 500)
    :component("10l_aluminum", 80)
)

content.add(disassembly("10l_aluminum", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_aluminum", 2)
)

content.add(disassembly("5l_aluminum", 180000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("1l_aluminum", 5)
)

content.add(disassembly("1l_aluminum", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("material_aluminium_ingot", 10)
)

content.add(disassembly("10l_lc_steel", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_lc_steel", 2)
)

content.add(disassembly("5l_lc_steel", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("lc_steel_lump", 39)
)

content.add(disassembly("10l_mc_steel", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_mc_steel", 2)
)

content.add(disassembly("5l_mc_steel", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("mc_steel_lump", 39)
)

content.add(disassembly("10l_hc_steel", 60000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 10)
    :component("5l_hc_steel", 2)
)

content.add(disassembly("5l_hc_steel", 360000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 50)
    :component("hc_steel_lump", 39)
)

content.add(disassembly("tin_plate", 6000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap_tin", 5)
)

content.add(disassembly("tin_cup", 6000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap_tin", 4)
)

content.add(disassembly("bowl_pewter", 6000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap_tin", 5)
)

content.add(disassembly("lc_steel_bar_round", 270000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 25)
    :component("lc_steel_chunk", 79)
)

content.add(disassembly("mc_steel_bar_round", 270000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 25)
    :component("mc_steel_chunk", 79)
)

content.add(disassembly("hc_steel_bar_round", 270000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 25)
    :component("hc_steel_chunk", 79)
)

content.add(disassembly("aluminum_bar_round", 150000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap_aluminum", 5)
)

content.add(disassembly("small_aluminum_bar_round", 90000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("scrap_aluminum", 2)
)

content.add(disassembly("small_lc_steel_bar_round", 180000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("lc_steel_chunk", 1)
)

content.add(disassembly("small_mc_steel_bar_round", 180000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :component("mc_steel_chunk", 1)
)

content.add(disassembly("small_hc_steel_bar_round", 180000, MODERATE_EXERCISE)
    :tool_charges("angle_grinder", 25)
    :component("hc_steel_chunk", 1)
)

content.add(disassembly("steel_section_long", 270000, MODERATE_EXERCISE)
    :requirement("metal_removal_standard", 25)
    :component("steel_section_short", 2)
)

content.add(disassembly("rigid_plastic_sheet", 30000, MODERATE_EXERCISE)
    :quality("SAW_W", 2, 1)
    :component("polycarbonate_chunk", 50)
)

content.add(disassembly("knuckle_steel", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 1, 1)
    :component("scrap", 4)
    :component("cotton_patchwork", 4)
)

content.add(disassembly("bat_metal_bolt", 12000, MODERATE_EXERCISE)
    :quality("WRENCH", 1, 1)
    :component("material_aluminium_ingot", 3)
    :component("nuts_bolts", 20)
)

content.add(disassembly("halberd_crude", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :component("spear_shaft", 1)
    :component("mc_steel_lump", 2)
)

content.add(disassembly("naginata_machete", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :component("spear_shaft", 1)
    :component("blade", 1)
    :component("nuts_bolts", 2)
    :component("splinter", 1)
    :component("scrap", 2)
)

content.add(disassembly("naginata_machete_temp", 12000, MODERATE_EXERCISE)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :component("spear_shaft", 1)
    :component("blade", 1)
    :component("nuts_bolts", 2)
    :component("splinter", 1)
    :component("scrap", 2)
)

content.add(disassembly("grenade", 6000, LIGHT_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SCREW", 1, 1)
    :component("delay_fuze", 1)
    :component("canister_empty", 1)
    :component("chem_compositionb", 200)
)

content.add(disassembly("grenade_inc", 6000, MODERATE_EXERCISE, { skill = "fabrication", difficulty = 3 })
    :quality("SCREW", 1, 1)
    :component("delay_fuze", 1)
    :component("canister_empty", 1)
    :component("incendiary", 150)
)

content.add(disassembly("landmine", 6000, LIGHT_EXERCISE, { skill = "fabrication", difficulty = 4 })
    :quality("SCREW", 1, 1)
    :component("delay_fuze", 1)
    :component("canister_empty", 1)
    :component("chem_compositionb", 75)
)

content.add(disassembly("spear_stone_simple", 30000, MODERATE_EXERCISE)
    :quality("CUT", 1, 1)
    :component("stick_long", 1)
    :component("sharp_rock", 1)
    :component("cordage_6", 1)
)

content.add(disassembly("spear_stone", 30000, MODERATE_EXERCISE)
    :quality("CUT", 1, 1)
    :component("spear_shaft", 1)
    :component("sharp_rock", 1)
    :component("cordage_6", 1)
)

content.add(disassembly("spear_knife_superior", 60000, MODERATE_EXERCISE)
    :quality("CUT", 1, 1)
    :quality("PRYING_NAIL", 1, 1)
    :component("stick_long", 1)
    :component("knife_huge", 1)
    :component("nail", 2)
    :component("string_36", 2)
)

content.add(disassembly("spear_knife_proper", 60000, MODERATE_EXERCISE)
    :quality("CUT", 1, 1)
    :quality("PRYING_NAIL", 1, 1)
    :component("spear_shaft", 1)
    :component("knife_huge", 1)
    :component("nail", 2)
    :component("string_36", 2)
)

content.add(disassembly("simple_pike_pipe", 60000, MODERATE_EXERCISE)
    :component("pipe", 4)
    :component("pipe_fittings", 4)
    :component("scrap", 12)
)

content.add(disassembly("pike_pipe", 150000, MODERATE_EXERCISE)
    :quality("SAW_M", 2, 1)
    :component("pipe", 4)
    :component("scrap", 12)
    :component("lump_cast_iron", 2)
)

content.add(disassembly("compositebow", 3000, MODERATE_EXERCISE)
    :component("splinter", 2)
    :component("string_36", 2)
)

content.add(disassembly("compositecrossbow", 3000, MODERATE_EXERCISE)
    :component("splinter", 7)
    :component("string_36", 1)
)

content.add(disassembly("coilgun", 180000, MODERATE_EXERCISE)
    :component("plastic_chunk", 8)
    :component("processor", 1)
    :component("circuit", 2)
    :component("power_supply", 2)
    :component("amplifier", 1)
    :component("e_scrap", 25)
    :component("scrap", 8)
    :component("cable", 27)
)
