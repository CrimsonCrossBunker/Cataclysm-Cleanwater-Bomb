local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

content.add(content.Recipe {
    id = "material_quicklime",
    result = "material_quicklime",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "forge", charges = 250 },
            { id = "oxy_torch", charges = 50 }
        })
    :component_any({
            { id = "material_limestone", count = 50 },
            { id = "chem_slaked_lime", count = 500 }
        })
    :requires_skill("chemistry", 2)
    :book("concrete_book", 3)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :proficiency("prof_intro_chemistry")
    :batch_discount(75, 4)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "chem_slaked_lime",
    result = "chem_slaked_lime",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 2,
}
    :component("material_quicklime", 53)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :proficiency("prof_intro_chemistry")
    :batch_discount(99, 2)
    :result_charges(468)
)

content.add(content.Recipe {
    id = "material_cement",
    result = "material_cement",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "forge", charges = 250 },
            { id = "oxy_torch", charges = 50 }
        })
    :component("material_quicklime", 50)
    :component_any({
            { id = "material_sand", count = 50 },
            { id = "material_gravel", count = 50 }
        })
    :requires_skill("chemistry", 3)
    :book("concrete_book", 4)
    :proficiency("prof_intro_chemistry")
    :batch_discount(75, 3)
    :result_charges(150)
)

content.add(content.Recipe {
    id = "material_gravel",
    result = "material_gravel",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component("pebble", 1)
    :quality("HAMMER", 1, 1)
    :quality("ANVIL", 1, 1)
    :result_charges(8)
)

content.add(content.Recipe {
    id = "shredded_rubber",
    result = "shredded_rubber",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component("chunk_rubber", 2)
    :quality("CUT", 1, 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "rubber_tire_chunk",
    result = "rubber_tire_chunk",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chunk_rubber", 16)
    :component("glue_weak", 250)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "paper",
    result = "paper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_any({
            { id = "sheet_metal", count = 1 },
            { id = "wood_panel", count = 1 }
        })
    :component_any({
            { id = "splinter", count = 10 },
            { id = "stick", count = 4 },
            { id = "2x4", count = 4 },
            { id = "withered", count = 20 }
        })
    :component_any({
            { id = "water", count = 4 },
            { id = "water_clean", count = 4 }
        })
    :quality("HAMMER", 1, 1)
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 4)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "scrap_bronze",
    result = "scrap_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "tin", count = 12 },
            { id = "aluminum_foil", count = 371 },
            { id = "chem_aluminium_powder", count = 29 },
            { id = "can_drink", count = 2 },
            { id = "scrap_aluminum", count = 1 }
        })
    :component("copper_scrap_equivalent", 1, true)
    :requirement("forging_standard", 1)
    :book("bronze_book", 2)
    :book("bronze_mag", 3)
    :book("alloy_book", 3)
    :book("textbook_armwest", 3)
    :book("textbook_weapwest", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "scrap_copper",
    result = "scrap_copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :tool_charges("surface_heat", 10, true)
    :component("copper", 50)
    :quality("HAMMER", 1, 1)
)

-- There is a loss of approximately 4.687 grams, for the math check #74702.
content.add(content.Recipe {
    id = "copper",
    result = "copper",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_charges("surface_heat", 10, true)
    :component("copper_wire", 21)
    :quality("HAMMER", 1, 1)
    :result_charges(19)
)

content.add(content.Recipe {
    id = "plastic_chunk_from_plastic_bags",
    result = "plastic_chunk",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_charges("surface_heat", 4, true)
    :component_any({
            { id = "stopcock", count = 11 },
            { id = "button_plastic", count = 25 },
            { id = "bottle_folding", count = 4 },
            { id = "plastic_straw", count = 3 },
            { id = "plastic_knife", count = 2 },
            { id = "plastic_spoon", count = 2 },
            { id = "plastic_spoon_kids", count = 4 },
            { id = "plastic_fork", count = 2 },
            { id = "plastic_plate", count = 4 },
            { id = "plastic_six_dice", count = 11 },
            { id = "bag_zipper", count = 25 },
            { id = "cup_plastic", count = 25 },
            { id = "bag_plastic", count = 10 },
            { id = "bag_plastic_small", count = 20 },
            { id = "plastic_sheet_small", count = 10 },
            { id = "tumbler_plastic", count = 4 },
            { id = "plastic_bowl_kids", count = 8 },
            { id = "sippy_cup", count = 4 },
            { id = "gasket_plastic", count = 1 }
        })
    :quality("BOIL", 1, 1)
    :proficiency("prof_plasticworking", { required = false, time_multiplier = 1.5 })
)

-- This recipe makes galalith plastic, which isn't actually moldable.  The realistic way to make use of this
-- process is to produce a large enough block or sheet of plastic, and then carve the item you need out of
-- it.
content.add(content.Recipe {
    id = "plastic_chunk",
    result = "plastic_chunk",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
    result_multiplier = 15,
}
    :tool_charges("surface_heat", 15, true)
    :component("milk_standard_raw", 15, true)
    :component("vinegar", 4)
    :component("chem_formaldehyde", 1)
    :quality("CHEM", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_organic_chemistry")
    :batch_discount(80, 4)
)

content.add(content.Recipe {
    id = "chem_sulphur",
    result = "chem_sulphur",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chunk_sulfur", 1)
    :quality("HAMMER", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :result_charges(1562)
)

content.add(content.Recipe {
    id = "chem_borax",
    result = "chem_borax",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chunk_borax", 1)
    :quality("HAMMER", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "chem_caco3_from_calcite",
    result = "chem_caco3",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    name = content.text("%s from calcite"),
}
    :component("chunk_caco3", 1)
    :quality("HAMMER", 2, 1)
    :quality("FINE_GRIND", 1, 1)
    :result_charges(866)
)

content.add(content.Recipe {
    id = "flux_ash",
    result = "flux_ash",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    result_multiplier = 4,
}
    :component("material_sand", 1)
    :component("ash", 1)
    :component("material_limestone", 1)
    :quality("FINE_GRIND", 1, 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "graphite",
    result = "graphite",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("chunk_graphite", 1)
    :quality("HAMMER", 1, 1)
    :quality("FINE_GRIND", 1, 1)
    :result_charges(275)
)

-- TODO: inputs not balanced to 176g output
-- TODO: water / sand amounts excessive; also can recover some of it as byproducts
content.add(content.Recipe {
    id = "chem_aluminium_powder",
    result = "chem_aluminium_powder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component_any({
            { id = "material_aluminium_ingot", count = 1 },
            { id = "can_drink", count = 6 },
            { id = "scrap_aluminum", count = 2 },
            { id = "aluminum_foil", count = 40 }
        })
    :component_any({
            { id = "water", count = 5 },
            { id = "water_clean", count = 5 }
        })
    :component("material_sand", 25)
    :quality("SAW_M", 1, 1)
    :result_charges(100)
)

-- input 78×1785mg = 139.23g / output 200×653.9mg = 130.78g / 6.07% loss
-- TODO: water / sand amounts excessive; also can recover some of it as byproducts
content.add(content.Recipe {
    id = "chem_zinc_powder",
    result = "chem_zinc_powder",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_OTHER",
    duration_moves = 24000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :component("zinc_metal", 78)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("material_sand", 15)
    :quality("SAW_M", 1, 1)
    :quality("GRIND", 1, 1)
    :result_charges(200)
)

-- primitive recipe used for thousands of years before modern era.  Folk craft teachers refer to this as the
-- clumping method that is not appropriate for beginners.
content.add(content.Recipe {
    id = "felt_patch",
    result = "felt_patch",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
    result_multiplier = 27,
}
    :component("soap", 5)
    :component("water_clean", 3)
    :component("wool_staple", 4)
    :requires_skill("survival", 3)
    :batch_discount(99, 1)
)

content.add(content.Recipe {
    id = "wool_staple",
    result = "wool_staple",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool("carding_paddles", 1)
    :component("felt_patch", 7)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_cotton_ball", kind = "collection" }
    byproducts:entry { item = "seed_cotton_boll", probability = 100, count = { 2, 2 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "cotton_ball",
    result = "cotton_ball",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 54000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    result_multiplier = 10,
}
    :tool("carding_paddles", 1)
    :component("cotton_boll", 1)
    :byproducts_from_group("recipe_byproducts_cotton_ball")
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_cotton_ball_spinningwheel", kind = "collection" }
    byproducts:entry { item = "seed_cotton_boll", probability = 100, count = { 2, 2 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "cotton_ball_spinningwheel",
    result = "cotton_ball",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 2700,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    result_multiplier = 10,
}
    :tool("spinwheelitem", 1)
    :component("cotton_boll", 1)
    :batch_discount(70, 1)
    :byproducts_from_group("recipe_byproducts_cotton_ball_spinningwheel")
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_cotton_ball_electric_spinwheel", kind = "collection" }
    byproducts:entry { item = "seed_cotton_boll", probability = 100, count = { 2, 2 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "cotton_ball_electric_spinwheel",
    result = "cotton_ball",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 2700,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
    result_multiplier = 10,
}
    :tool_charges("electric_spinwheel", 1)
    :component("cotton_boll", 1)
    :batch_discount(70, 1)
    :byproducts_from_group("recipe_byproducts_cotton_ball_electric_spinwheel")
)

content.add(content.Recipe {
    id = "thread",
    result = "thread",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :tool("distaff_spindle", 1)
    :component("cotton_ball", 3)
    :requires_skill("fabrication", 1)
    :proficiency("prof_spinning", { skill_penalty = 0.5, time_multiplier = 6 })
    :result_charges(50)
)

content.add(content.Recipe {
    id = "thread_with_spinningwheel_from_cotton_ball",
    result = "thread",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 3000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component("cotton_ball", 3)
    :proficiency("prof_spinning", { skill_penalty = 0.5, time_multiplier = 6 })
    :batch_discount(70, 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "thread_with_electric_spinwheel_from_cotton_ball",
    result = "thread",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 2)
    :component("cotton_ball", 3)
    :proficiency("prof_spinning", { skill_penalty = 0.5, time_multiplier = 6 })
    :batch_discount(70, 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "thread_canvas_from_thread",
    result = "thread_canvas",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component_any({
            { id = "thread", count = 3 },
            { id = "sinew", count = 3 },
            { id = "yarn", count = 3 },
            { id = "plant_fibre", count = 3 }
        })
    :proficiency("prof_fibers")
    :result_charges(1)
)

content.add(content.Recipe {
    id = "thread_canvas_with_spinningwheel",
    result = "thread_canvas",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "thread", count = 150 },
            { id = "sinew", count = 150 },
            { id = "yarn", count = 150 },
            { id = "plant_fibre", count = 150 },
            { id = "cotton_ball", count = 9 }
        })
    :proficiency("prof_spinning", { required = false, time_multiplier = 1.5 })
    :batch_discount(70, 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "thread_canvas_with_electric_spinwheel",
    result = "thread_canvas",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 11)
    :component_any({
            { id = "thread", count = 150 },
            { id = "sinew", count = 150 },
            { id = "yarn", count = 150 },
            { id = "plant_fibre", count = 150 },
            { id = "cotton_ball", count = 9 }
        })
    :proficiency("prof_spinning", { required = false, time_multiplier = 1.5 })
    :batch_discount(70, 1)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "grass_yarn",
    result = "grass_yarn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :tool("distaff_spindle", 1)
    :component_any({
            { id = "straw_pile", count = 5 },
            { id = "withered", count = 5 }
        })
    :quality("CUT", 2, 1)
    :proficiency("prof_spinning")
    :proficiency("prof_fibers")
)

content.add(content.Recipe {
    id = "grass_yarn_spinningwheel",
    result = "grass_yarn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 9000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component_any({
            { id = "straw_pile", count = 5 },
            { id = "withered", count = 5 }
        })
    :quality("CUT", 1, 1)
    :proficiency("prof_spinning")
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "grass_yarn_electric_spinwheel",
    result = "grass_yarn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 4)
    :component_any({
            { id = "straw_pile", count = 5 },
            { id = "withered", count = 5 }
        })
    :quality("CUT", 1, 1)
    :proficiency("prof_spinning")
    :proficiency("prof_fibers")
    :batch_discount(70, 1)
)

content.add(content.Recipe {
    id = "yarn",
    result = "yarn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :tool("distaff_spindle", 1)
    :component("wool_staple", 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_spinning", { time_multiplier = 6 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "yarn_spinningwheel",
    result = "yarn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 9000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool("spinwheelitem", 1)
    :component("wool_staple", 1)
    :quality("CUT", 1, 1)
    :proficiency("prof_spinning", { time_multiplier = 6 })
    :batch_discount(70, 1)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "yarn_electric_spinwheel",
    result = "yarn",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 9000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :tool_charges("electric_spinwheel", 4)
    :component("wool_staple", 1)
    :quality("CUT", 1, 1)
    :proficiency("prof_spinning", { time_multiplier = 6 })
    :batch_discount(70, 1)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "sheet",
    result = "sheet",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork", 12)
)

content.add(content.Recipe {
    id = "sheet_kevlar_patchwork",
    result = "sheet_kevlar_patchwork",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("kevlar_patch", 8)
    :requirement("sewing_kevlar", 15)
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "sheet_kevlar",
    result = "sheet_kevlar",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :tool("loom_frame", 1)
    :tool("shed_stick", 1)
    :component("thread_kevlar", 100)
    :quality("CUT", 2, 1)
    :book("manual_tailor", 4)
    :book("textbook_tailor", 4)
    :book("tailor_portfolio", 5)
)

content.add(content.Recipe {
    id = "kevlar_patch",
    result = "kevlar_patch",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("scrap_kevlar", 4)
    :requirement("sewing_kevlar", 4)
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "nylon_from_scraps",
    result = "nylon",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("scrap_nylon", 4)
    :component("thread", 10)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "rigid_kevlar_plate",
    result = "rigid_kevlar_plate",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component_any({
            { id = "sheet_kevlar", count = 16 },
            { id = "sheet_kevlar_layered", count = 1 }
        })
    :requirement("glue_strong", 450)
    :proficiency("prof_polymerworking")
)

content.add(content.Recipe {
    id = "sheet_cotton",
    result = "sheet_cotton",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :tool("loom_frame", 1)
    :tool("shed_stick", 1)
    :component("thread", 50)
    :quality("CUT", 2, 1)
    :proficiency("prof_weaving")
)

content.add(content.Recipe {
    id = "sheet_cotton_patchwork",
    result = "sheet_cotton_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("cotton_patchwork", 8)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "cotton_patchwork",
    result = "cotton_patchwork",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("scrap_cotton", 4)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sheet_canvas",
    result = "sheet_canvas",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :tool("loom_frame", 1)
    :tool("shed_stick", 1)
    :component("thread_canvas", 80)
    :component("wax_any", 1, true)
    :quality("CUT", 2, 1)
    :proficiency("prof_weaving")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "sheet_denim_patchwork",
    result = "sheet_denim_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("denim_patch", 8)
    :component("filament", 15, true)
    :quality("SEW", 2, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sheet_canvas_patchwork",
    result = "sheet_canvas_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("canvas_patch", 8)
    :component("filament_canvas", 15, true)
    :quality("SEW", 2, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "canvas_patch",
    result = "canvas_patch",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("scrap_canvas", 4)
    :component("filament_canvas", 15, true)
    :quality("SEW", 2, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sheet_neoprene_patchwork",
    result = "sheet_neoprene_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("neoprene", 8)
    :component("filament", 15, true)
    :quality("SEW_CURVED", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sheet_nomex_patchwork",
    result = "sheet_nomex_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("nomex", 8)
    :component("thread_nomex", 15)
    :quality("SEW_CURVED", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "tanned_hide",
    result = "tanned_hide",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 216000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component("tanned_pelt", 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "tanned_hide_from_pieces",
    result = "tanned_hide",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("leather", 8)
    :component("filament", 4, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
)

content.add(content.Recipe {
    id = "leather",
    result = "leather",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "survival",
    difficulty = 1,
}
    :component("fur", 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "steel_chunk",
    result = "steel_chunk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("scrap", 5)
    :requirement("forging_standard", 1)
    :batch_discount(90, 4)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "steel_lump",
    result = "steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :requirement("forging_standard", 4)
    :requirement("steel_chunk_any", 4)
    :batch_discount(90, 4)
)

-- Primitive cementation: pack low-carbon steel in charcoal in a sealed clay vessel and heat it over a fire
-- to diffuse carbon into medium-carbon steel.
content.add(content.Recipe {
    id = "mc_steel_chunk_primitive",
    result = "mc_steel_chunk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "fire", count = 1 },
            { id = "hotplate", charges = 2 }
        })
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "metalworking_tongs", count = 1 },
            { id = "metalworking_tongs_bronze", count = 1 }
        })
    :component("lc_steel_chunk", 1)
    :requirement("carbon", 1)
    :batch_discount(90, 4)
)

-- Primitive case hardening: pack low-carbon steel in charcoal in a sealed clay vessel and heat it longer
-- than plain carburizing so only the surface layer is enriched with carbon.
content.add(content.Recipe {
    id = "ch_steel_chunk_primitive",
    result = "ch_steel_chunk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "fire", count = 1 },
            { id = "hotplate", charges = 2 }
        })
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "metalworking_tongs", count = 1 },
            { id = "metalworking_tongs_bronze", count = 1 }
        })
    :component("lc_steel_chunk", 1)
    :requirement("carbon", 2)
    :batch_discount(90, 4)
)

-- Primitive quench and temper: heat medium-carbon steel over a fire, quench it in a tank of water, then
-- temper it over low heat to make tempered steel.
content.add(content.Recipe {
    id = "qt_steel_chunk_primitive",
    result = "qt_steel_chunk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_any({
            { id = "fire", count = 1 },
            { id = "hotplate", charges = 2 }
        })
    :tool_any({
            { id = "water", charges = 1 },
            { id = "water_clean", charges = 1 }
        })
    :tool("metal_tank", 1)
    :tool_any({
            { id = "metalworking_tongs", count = 1 },
            { id = "metalworking_tongs_bronze", count = 1 }
        })
    :component("mc_steel_chunk", 1)
    :batch_discount(90, 4)
)

-- Primitive finery process: heat high-carbon steel or cast iron in an oxidizing fire and hammer it to burn
-- off excess carbon, yielding standard steel.
content.add(content.Recipe {
    id = "steel_chunk_primitive_decarburizing",
    result = "steel_chunk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "fire", count = 1 },
            { id = "hotplate", charges = 2 }
        })
    :tool_any({
            { id = "metalworking_tongs", count = 1 },
            { id = "metalworking_tongs_bronze", count = 1 }
        })
    :component_any({
            { id = "hc_steel_chunk", count = 1 },
            { id = "chunk_cast_iron", count = 1 }
        })
    :quality("HAMMER", 1, 1)
    :batch_discount(90, 4)
)

-- Primitive bloomery-style refining: heat and hammer budget steel chunks to drive out slag and impurities,
-- yielding standard steel.
content.add(content.Recipe {
    id = "steel_chunk_primitive_scrap_refining",
    result = "steel_chunk",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "fire", count = 1 },
            { id = "hotplate", charges = 2 }
        })
    :tool_any({
            { id = "metalworking_tongs", count = 1 },
            { id = "metalworking_tongs_bronze", count = 1 }
        })
    :component("budget_steel_chunk", 2)
    :quality("HAMMER", 1, 1)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "tin_from_bowl",
    result = "tin",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "chemistry",
    difficulty = 4,
}
    :tool_charges("electrolysis_kit", 100)
    :tool_any({
            { id = "jar_glass_sealed", count = 1 },
            { id = "jar_3l_glass_sealed", count = 1 }
        })
    :component("any_strong_acid", 1, true)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component_any({
            { id = "tin_plate", count = 1 },
            { id = "tin_cup", count = 1 },
            { id = "bowl_pewter", count = 1 }
        })
    :book("textbook_chemistry", 4)
    :book("textbook_fabrication", 4)
    :book("welding_book", 4)
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
    :batch_discount(50, 2)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "tin_from_scrap",
    result = "tin",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("chemistry_set", 50)
    :tool_any({
            { id = "jar_glass_sealed", count = 1 },
            { id = "jar_3l_glass_sealed", count = 1 }
        })
    :component("scrap_tin", 4)
    :batch_discount(75, 3)
    :result_charges(100)
)

content.add(content.Recipe {
    id = "vine_30",
    result = "vine_30",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 45000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("vine_6", 5)
)

content.add(content.Recipe {
    id = "fuse",
    result = "fuse",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 1,
}
    :tool_charges("surface_heat", 7, true)
    :component("string_36", 4)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("chem_saltpetre", 7)
    :component("sugar", 5)
    :quality("CHEM", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_intro_chemistry")
    :batch_discount(50, 2)
    :result_charges(50)
)

content.add(content.Recipe {
    id = "fuse_with gunpowder",
    result = "fuse",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("string_36", 1)
    :component_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component_any({
            { id = "chem_black_powder", count = 6 },
            { id = "gunpowder", count = 60 }
        })
    :quality("CONTAIN", 1, 1)
    :quality("CUT", 2, 1)
    :proficiency("prof_handloading")
    :batch_discount(60, 2)
    :result_charges(6)
)

content.add(content.Recipe {
    id = "fuse_with paper & gunpowder",
    result = "fuse",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 24000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("rolling_paper", 1)
    :component_any({
            { id = "chem_black_powder", count = 3 },
            { id = "red_phosphorous_small", count = 3 },
            { id = "gunpowder", count = 30 }
        })
    :proficiency("prof_handloading")
    :batch_discount(30, 2)
    :result_charges(3)
)

content.add(content.Recipe {
    id = "lc_wire_debarbing barbed wire",
    result = "lc_wire",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :tool_any({
            { id = "boltcutters", count = 1 },
            { id = "pliers", count = 1 },
            { id = "toolset", count = 1 },
            { id = "multitool", count = 1 }
        })
    :component("wire_barbed", 1)
)

content.add(content.Recipe {
    id = "wire_mesh",
    result = "wire_mesh",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 6,
}
    :tool("draw_plate", 1)
    :tool_any({
            { id = "pliers", count = 1 },
            { id = "toolset", count = 1 },
            { id = "multitool", count = 1 }
        })
    :component("lc_wire", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_wiremaking")
)

content.add(content.Recipe {
    id = "small_aluminum_bar_round",
    result = "small_aluminum_bar_round",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("fake_lathe", 30)
    :component("aluminum_bar_round", 1)
    :proficiency("prof_machining_basic")
    :byproduct("scrap_aluminum", 3)
)

content.add(content.Recipe {
    id = "small_lc_steel_bar_round",
    result = "small_lc_steel_bar_round",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("fake_lathe", 45)
    :component("lc_steel_bar_round", 1)
    :proficiency("prof_machining_basic")
    :byproduct("scrap", 9)
)

content.add(content.Recipe {
    id = "small_mc_steel_bar_round",
    result = "small_mc_steel_bar_round",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 300000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_charges("fake_lathe", 50)
    :component("mc_steel_bar_round", 1)
    :proficiency("prof_machining_basic")
    :byproduct("scrap", 9)
)

content.add(content.Recipe {
    id = "small_hc_steel_bar_round",
    result = "small_hc_steel_bar_round",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("fake_lathe", 60)
    :component("hc_steel_bar_round", 1)
    :proficiency("prof_machining_basic")
    :byproduct("scrap", 9)
)

-- This energy requirement is for charcoal forges, and should be revised when forges stop being copies of one
-- another
-- For glass*making*, energy costs is about 2321MJ for ~907.2kg, or ~2.56MJ/kg. (cited figure: 2.2 MMBtu/one
-- short ton of glass)
-- https://www.energystar.gov/sites/default/files/buildings/tools/Glass-Guide.pdf Optimally and not
-- accounting for losses...
-- This recipe produces 300g of glass, so it costs about 768kJ. Say 800.
content.add(content.Recipe {
    id = "glass_shard",
    result = "glass_shard",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
    result_multiplier = 4,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "sheet_metal", count = 1 },
            { id = "fire_brick", count = 1 },
            { id = "anvil", count = 1 },
            { id = "anvil_crude", count = 1 },
            { id = "anvil_bronze", count = 1 },
            { id = "casting_mold_small", count = 1 }
        })
    :tool_any({
            { id = "forge", charges = 26 },
            { id = "oxy_torch", charges = 3 }
        })
    :component("material_sand", 10)
    :component("chem_washing_soda", 41)
    :component_any({
            { id = "material_quicklime", count = 2 },
            { id = "material_limestone", count = 2 },
            { id = "chem_slaked_lime", count = 20 }
        })
    :requires_skill("chemistry", 4)
    :book("glassblowing_book", 5)
    :proficiency("prof_glassblowing")
    :proficiency("prof_intro_chemistry")
    :proficiency("prof_inorganic_chemistry")
)

content.add(content.Recipe {
    id = "glass_tinted",
    result = "glass_tinted",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :tool_any({
            { id = "sheet_metal_small", count = 1 },
            { id = "sheet_metal", count = 1 }
        })
    :tool_charges("forge", 60)
    :component("glass_shard", 2)
    :component("chem_sulphur", 1)
    :component("scrap", 1)
    :component("charcoal", 1)
    :quality("CHEM", 1, 1)
    :book("glassblowing_book", 4)
    :book("textbook_fabrication", 5)
    :book("welding_book", 5)
    :proficiency("prof_glassblowing")
    :proficiency("prof_intro_chemistry")
    :batch_discount(90, 2)
)

content.add(content.Recipe {
    id = "button_plastic_wood",
    result = "button_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    variant = "wood",
}
    :component_any({
            { id = "mop", count = 1 },
            { id = "stick", count = 1 },
            { id = "broom", count = 1 }
        })
    :quality("SAW_W", 1, 1)
    :quality_any({
            { id = "PUNCH", level = 1, count = 1 },
            { id = "DRILL", level = 1, count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("wood_sealant_any_small", 1)
    :proficiency("prof_carving", { time_multiplier = 1.25, skill_penalty = 0.125 })
    :result_charges(50)
)

content.add(content.Recipe {
    id = "button_plastic_bone",
    result = "button_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 780000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
    variant = "bone",
}
    :tool_charges("water_boiling_heat", 1, true)
    :tool_any({
            { id = "water", count = 1 },
            { id = "water_clean", count = 1 }
        })
    :component("bone_sturdy", 1, true)
    :quality("SAW_W", 1, 1)
    :quality_any({
            { id = "PUNCH", level = 1, count = 1 },
            { id = "DRILL", level = 1, count = 1 }
        })
    :quality("CUT", 2, 1)
    :quality("FILE", 1, 1)
    :quality("BOIL", 1, 1)
    :proficiency("prof_carving", { time_multiplier = 1.25, skill_penalty = 0.125 })
    :result_charges(50)
)

content.add(content.Recipe {
    id = "button_plastic",
    result = "button_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :tool_charges("surface_heat", 5, true)
    :component("plastic_chunk", 1)
    :quality("CUT", 2, 1)
    :quality_any({
            { id = "PUNCH", level = 1, count = 1 },
            { id = "DRILL", level = 1, count = 1 }
        })
    :proficiency("prof_plasticworking")
    :result_charges(25)
)

content.add(content.Recipe {
    id = "button_plastic_steel",
    result = "button_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    variant = "steel",
}
    :tool_charges("hotcut_any", 1, true)
    :tool_any({
            { id = "nail", count = 1 },
            { id = "bronze_nail", count = 1 }
        })
    :component("scrap", 1)
    :quality("FILE", 1, 1)
    :requirement("blacksmithing_scrap", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(85, 2)
    :result_charges(5)
)

-- The idea is that you make bas-relief prints including the holes in the clay, pour then break the clay to
-- get the buttons and file them down.
content.add(content.Recipe {
    id = "button_plastic_bronze",
    result = "button_plastic",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
    variant = "bronze",
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("scrap_bronze", 1)
    :component("clay_lump", 1)
    :quality("CUT", 2, 1)
    :quality("FILE", 1, 1)
    :requirement("forging_standard", 1)
    :proficiency("prof_metalworking")
    :proficiency("prof_redsmithing")
    :proficiency("prof_redsmithing_adv")
    :batch_discount(50, 2)
    :result_charges(20)
)

content.add(content.Recipe {
    id = "cannonball_4lb",
    result = "cannonball_4lb",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :requirement("forging_standard", 8)
    :requirement("steel_chunk_any", 8)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "lc_steel_lump",
    result = "lc_steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("metal_tank", 1)
    :tool_charges("forge", 500)
    :component_any({
            { id = "budget_steel_lump", count = 1 },
            { id = "budget_steel_chunk", count = 4 },
            { id = "scrap", count = 20 }
        })
    :component_any({
            { id = "coal_lump", count = 64 },
            { id = "charcoal", count = 40 }
        })
    :book("reference_fabrication1", 5)
    :book("welding_book", 5)
    :book("alloy_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(90, 2)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "mc_steel_lump",
    result = "mc_steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("metal_tank", 1)
    :tool_charges("forge", 500)
    :component_any({
            { id = "budget_steel_lump", count = 1 },
            { id = "lc_steel_lump", count = 1 },
            { id = "budget_steel_chunk", count = 4 },
            { id = "lc_steel_chunk", count = 4 },
            { id = "scrap", count = 20 }
        })
    :component_any({
            { id = "coal_lump", count = 77 },
            { id = "charcoal", count = 48 }
        })
    :book("reference_fabrication1", 5)
    :book("welding_book", 5)
    :book("alloy_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(90, 2)
)

content.add(content.Recipe {
    id = "hc_steel_lump",
    result = "hc_steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("metal_tank", 1)
    :tool_charges("forge", 500)
    :component_any({
            { id = "budget_steel_lump", count = 1 },
            { id = "lc_steel_lump", count = 1 },
            { id = "mc_steel_lump", count = 1 },
            { id = "budget_steel_chunk", count = 4 },
            { id = "lc_steel_chunk", count = 4 },
            { id = "mc_steel_chunk", count = 4 },
            { id = "scrap", count = 20 }
        })
    :component_any({
            { id = "coal_lump", count = 90 },
            { id = "charcoal", count = 68 }
        })
    :book("reference_fabrication1", 5)
    :book("welding_book", 5)
    :book("alloy_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(90, 2)
)

content.add(content.Recipe {
    id = "steel_lump_from_other_steel",
    result = "steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 5,
}
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("metal_tank", 1)
    :tool_charges("forge", 200)
    :component_any({
            { id = "hc_steel_lump", count = 1 },
            { id = "hc_steel_chunk", count = 4 },
            { id = "mc_steel_lump", count = 1 },
            { id = "mc_steel_chunk", count = 4 },
            { id = "lc_steel_lump", count = 1 },
            { id = "lc_steel_chunk", count = 4 }
        })
    :book("reference_fabrication1", 5)
    :book("welding_book", 5)
    :book("alloy_book", 5)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :batch_discount(90, 2)
)

content.add(content.Recipe {
    id = "stick_stick_from_plank",
    result = "stick",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("2x4", 1)
    :quality("CUT", 2, 1)
    :learn_automatically("fabrication", 0)
    :proficiency("prof_carving", { time_multiplier = 2, skill_penalty = 0 })
    :byproduct("splinter", 5)
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_budget_steel_chunk", kind = "collection" }
    byproducts:entry { item = "slag", probability = 100, count = { 5, 5 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "budget_steel_chunk",
    result = "budget_steel_chunk",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 90000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("scrap", 6)
    :requirement("forging_standard", 1)
    :batch_discount(90, 4)
    :byproducts_from_group("recipe_byproducts_budget_steel_chunk")
)

do
    local byproducts = content.ItemGroup { id = "recipe_byproducts_budget_steel_lump_from_scrap", kind = "collection" }
    byproducts:entry { item = "slag", probability = 100, count = { 20, 20 } }
    content.add(byproducts)
end

content.add(content.Recipe {
    id = "budget_steel_lump_from_scrap",
    result = "budget_steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("scrap", 24)
    :requirement("forging_standard", 4)
    :batch_discount(90, 4)
    :byproducts_from_group("recipe_byproducts_budget_steel_lump_from_scrap")
)

content.add(content.Recipe {
    id = "budget_steel_lump",
    result = "budget_steel_lump",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("budget_steel_chunk", 4)
    :requirement("forging_standard", 4)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "plastic_sheet_with_duct_tape",
    result = "plastic_sheet",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("plastic_sheet_small", 8)
    :component("duct_tape", 40)
    :quality("CUT", 1, 1)
)

content.add(content.Recipe {
    id = "plastic_sheet_small",
    result = "plastic_sheet_small",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :tool("cotton_patchwork", 1)
    :component_any({
            { id = "bag_plastic", count = 1 },
            { id = "bag_plastic_small", count = 1 }
        })
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
)

content.add(content.Recipe {
    id = "plastic_sheet_with_heat",
    result = "plastic_sheet",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :tool_charges("surface_heat", 5, true)
    :tool("cotton_patchwork", 1)
    :component("plastic_sheet_small", 8)
    :quality("CUT", 1, 1)
    :quality("COOK", 2, 1)
)

content.add(content.Recipe {
    id = "sheet_faux_fur_patchwork",
    result = "sheet_faux_fur_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("faux_fur", 8)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
)

content.add(content.Recipe {
    id = "sheet_fur_patchwork",
    result = "sheet_fur_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("fur", 8)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
)

content.add(content.Recipe {
    id = "sheet_leather_patchwork",
    result = "sheet_leather_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("leather", 8)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
    :quality("LEATHER_AWL", 1, 1)
)

content.add(content.Recipe {
    id = "sheet_felt_patchwork",
    result = "sheet_felt_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("felt_patch", 8)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sheet_lycra_patchwork",
    result = "sheet_lycra_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("lycra_patch", 8)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "sheet_nylon_patchwork",
    result = "sheet_nylon_patchwork",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
}
    :component("nylon", 8)
    :component("filament", 15, true)
    :quality("SEW", 1, 1)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "material_aluminium_ingot",
    result = "material_aluminium_ingot",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component("scrap_aluminum", 5)
    :requirement("forging_standard", 4)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "scrap_aluminum_melted_foil",
    result = "scrap_aluminum",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :tool_charges("surface_heat", 10, true)
    :component("aluminum_foil", 371)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "scrap_aluminum_assorted_scrap",
    result = "scrap_aluminum",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 500,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "fabrication",
}
    :component("can_drink", 2)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "scrap_brass",
    result = "scrap_brass",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 0,
    name = content.text("%s from casings"),
}
    :tool_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "unprimed_3030_casing", count = 43 },
            { id = "unprimed_270win_casing", count = 43 },
            { id = "unprimed_460sw_casing", count = 43 },
            { id = "unprimed_450_casing", count = 75 },
            { id = "unprimed_500_casing", count = 43 },
            { id = "unprimed_77arisaka_casing", count = 60 },
            { id = "unprimed_300_casing", count = 43 },
            { id = "unprimed_454_casing", count = 43 },
            { id = "unprimed_357mag_casing", count = 100 },
            { id = "unprimed_50beowulf_casing", count = 75 },
            { id = "unprimed_30carbine_casing", count = 50 },
            { id = "unprimed_38_casing", count = 100 },
            { id = "unprimed_44_casing", count = 75 },
            { id = "unprimed_762R_casing", count = 43 },
            { id = "unprimed_338lapua_casing", count = 17 },
            { id = "unprimed_762_casing", count = 50 },
            { id = "unprimed_762_25_casing", count = 75 },
            { id = "unprimed_762_51_casing", count = 50 },
            { id = "unprimed_38super_casing", count = 100 },
            { id = "unprimed_545_casing", count = 75 },
            { id = "unprimed_10mm_casing", count = 100 },
            { id = "unprimed_45colt_casing", count = 75 },
            { id = "unprimed_380_casing", count = 100 },
            { id = "unprimed_357sig_casing", count = 100 },
            { id = "unprimed_57mm_casing", count = 150 },
            { id = "unprimed_300blk_casing", count = 50 },
            { id = "unprimed_32_casing", count = 150 },
            { id = "unprimed_50_casing", count = 17 },
            { id = "unprimed_45_casing", count = 75 },
            { id = "unprimed_40_casing", count = 100 },
            { id = "unprimed_458wm_casing", count = 23 },
            { id = "unprimed_50ae_casing", count = 50 },
            { id = "unprimed_4570_casing", count = 75 },
            { id = "unprimed_9mm_casing", count = 100 },
            { id = "unprimed_9x18mm_casing", count = 100 },
            { id = "unprimed_123ln_casing", count = 43 },
            { id = "unprimed_3006_casing", count = 43 },
            { id = "unprimed_308_casing", count = 50 },
            { id = "unprimed_223_casing", count = 60 },
            { id = "unprimed_303_casing", count = 43 },
            { id = "3030_casing", count = 43 },
            { id = "270win_casing", count = 43 },
            { id = "460sw_casing", count = 43 },
            { id = "450_casing", count = 75 },
            { id = "500_casing", count = 43 },
            { id = "77arisaka_casing", count = 60 },
            { id = "300_casing", count = 43 },
            { id = "454_casing", count = 43 },
            { id = "357mag_casing", count = 100 },
            { id = "50beowulf_casing", count = 75 },
            { id = "30carbine_casing", count = 50 },
            { id = "38_casing", count = 100 },
            { id = "44_casing", count = 75 },
            { id = "762R_casing", count = 43 },
            { id = "338lapua_casing", count = 17 },
            { id = "762_casing", count = 50 },
            { id = "762_25_casing", count = 75 },
            { id = "762_51_casing", count = 50 },
            { id = "38super_casing", count = 100 },
            { id = "545_casing", count = 75 },
            { id = "10mm_casing", count = 100 },
            { id = "45colt_casing", count = 75 },
            { id = "380_casing", count = 100 },
            { id = "357sig_casing", count = 100 },
            { id = "57mm_casing", count = 150 },
            { id = "300blk_casing", count = 50 },
            { id = "32_casing", count = 150 },
            { id = "50_casing", count = 17 },
            { id = "45_casing", count = 75 },
            { id = "40_casing", count = 100 },
            { id = "458wm_casing", count = 23 },
            { id = "50ae_casing", count = 50 },
            { id = "4570_casing", count = 75 },
            { id = "9mm_casing", count = 100 },
            { id = "9x18mm_casing", count = 100 },
            { id = "123ln_casing", count = 43 },
            { id = "3006_casing", count = 43 },
            { id = "308_casing", count = 50 },
            { id = "223_casing", count = 60 },
            { id = "303_casing", count = 43 },
            { id = "22_casing", count = 150 },
            { id = "33_naval_casing", count = 4 },
            { id = "273x110casing", count = 16 },
            { id = "273x44casing", count = 30 }
        })
    :requirement("forging_standard", 1)
    :batch_discount(90, 4)
)
