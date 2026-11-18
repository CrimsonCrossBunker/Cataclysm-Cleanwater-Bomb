local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "helmet_nomad",
    result = "helmet_nomad",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "hat_ball", count = 1 },
            { id = "hat_boonie", count = 1 },
            { id = "hat_golf", count = 1 }
        })
    :component_any({
            { id = "glasses_safety", count = 1 },
            { id = "glasses_bal", count = 1 },
            { id = "goggles_ski", count = 1 },
            { id = "face_shield_plastic", count = 1 },
            { id = "goggles_chem", count = 1 }
        })
    :component_any({
            { id = "leather", count = 8 },
            { id = "tanned_hide", count = 2 },
            { id = "sheet_leather", count = 2 },
            { id = "sheet_leather_patchwork", count = 2 }
        })
    :component_any({
            { id = "sheet_denim", count = 10 },
            { id = "sheet_denim_patchwork", count = 10 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 80)
    :requirement("fastener_small", 4)
    :book("bp_nomad_cowl", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xs_helmet_nomad",
    result = "xs_helmet_nomad",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "hat_ball", count = 1 },
            { id = "hat_boonie", count = 1 },
            { id = "hat_golf", count = 1 }
        })
    :component_any({
            { id = "glasses_safety", count = 1 },
            { id = "glasses_bal", count = 1 },
            { id = "goggles_ski", count = 1 },
            { id = "face_shield_plastic", count = 1 },
            { id = "goggles_chem", count = 1 }
        })
    :component_any({
            { id = "leather", count = 8 },
            { id = "tanned_hide", count = 2 },
            { id = "sheet_leather", count = 2 },
            { id = "sheet_leather_patchwork", count = 2 }
        })
    :component_any({
            { id = "sheet_denim", count = 8 },
            { id = "sheet_denim_patchwork", count = 8 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 60)
    :requirement("fastener_small", 4)
    :book("bp_nomad_cowl", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "xl_helmet_nomad",
    result = "xl_helmet_nomad",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 810000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "hat_ball", count = 1 },
            { id = "hat_boonie", count = 1 },
            { id = "hat_golf", count = 1 }
        })
    :component_any({
            { id = "glasses_safety", count = 1 },
            { id = "glasses_bal", count = 1 },
            { id = "goggles_ski", count = 1 },
            { id = "face_shield_plastic", count = 1 },
            { id = "goggles_chem", count = 1 }
        })
    :component_any({
            { id = "leather", count = 12 },
            { id = "tanned_hide", count = 3 },
            { id = "sheet_leather", count = 3 },
            { id = "sheet_leather_patchwork", count = 3 }
        })
    :component_any({
            { id = "sheet_denim", count = 15 },
            { id = "sheet_denim_patchwork", count = 15 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 120)
    :requirement("fastener_small", 6)
    :book("bp_nomad_cowl", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)

-- nomad jumpsuit
content.add(content.Recipe {
    id = "armor_nomad",
    result = "armor_nomad",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1560000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "leather", count = 16 },
            { id = "tanned_hide", count = 4 },
            { id = "sheet_leather", count = 4 },
            { id = "sheet_leather_patchwork", count = 4 }
        })
    :component_any({
            { id = "sheet_denim", count = 12 },
            { id = "sheet_denim_patchwork", count = 12 }
        })
    :component_any({
            { id = "leather_belt", count = 4 },
            { id = "webbing_belt", count = 4 }
        })
    :component_any({
            { id = "jeans", count = 1 },
            { id = "sheet_denim", count = 8 },
            { id = "sheet_denim_patchwork", count = 8 }
        })
    :component_any({
            { id = "jacket_jean", count = 1 },
            { id = "jacket_flannel", count = 1 },
            { id = "sheet_denim", count = 10 },
            { id = "sheet_denim_patchwork", count = 10 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 240)
    :requirement("fastener_large", 4)
    :book("bp_nomad_jumpsuit", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 6)
    :byproduct("denim_patch", 2)
    :byproduct("scrap_denim", 7)
)

-- nomad jumpsuit
content.add(content.Recipe {
    id = "armor_nomad_upgrade light jumpsuit",
    result = "armor_nomad",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 840000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("armor_nomad_light", 1)
    :component_any({
            { id = "leather", count = 4 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 }
        })
    :component_any({
            { id = "sheet_denim", count = 12 },
            { id = "sheet_denim_patchwork", count = 12 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 120)
    :requirement("fastener_large", 1)
    :book("bp_nomad_jumpsuit", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :byproduct("scrap_leather", 7)
    :byproduct("denim_patch", 2)
    :byproduct("scrap_denim", 7)
)

content.add(content.Recipe {
    id = "armor_nomad_light",
    result = "armor_nomad_light",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 840000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component_any({
            { id = "leather", count = 12 },
            { id = "tanned_hide", count = 3 },
            { id = "sheet_leather", count = 3 },
            { id = "sheet_leather_patchwork", count = 3 }
        })
    :component_any({
            { id = "sheet_denim", count = 6 },
            { id = "sheet_denim_patchwork", count = 6 }
        })
    :component_any({
            { id = "leather_belt", count = 4 },
            { id = "webbing_belt", count = 4 }
        })
    :component_any({
            { id = "jeans", count = 1 },
            { id = "sheet_denim", count = 8 },
            { id = "sheet_denim_patchwork", count = 8 }
        })
    :component_any({
            { id = "jacket_jean", count = 1 },
            { id = "jacket_flannel", count = 1 },
            { id = "sheet_denim", count = 10 },
            { id = "sheet_denim_patchwork", count = 10 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 120)
    :requirement("fastener_large", 3)
    :book("bp_nomad_jumpsuit", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :byproduct("scrap_leather", 3)
    :byproduct("denim_patch", 1)
    :byproduct("scrap_denim", 3)
)

-- advanced nomad jumpsuit
content.add(content.Recipe {
    id = "armor_nomad_advanced",
    result = "armor_nomad_advanced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1260000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("armor_nomad", 1)
    :component("exodii_wire_kit", 1)
    :component("exodii_ac_kit", 1)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 90)
    :requirement("soldering_standard", 10)
    :book("bp_nomad_jumpsuit", 4)
)

-- nomad harness
content.add(content.Recipe {
    id = "nomad_rig",
    result = "nomad_rig",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 1980000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "leather", count = 4 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 }
        })
    :component_any({
            { id = "sheet_denim", count = 4 },
            { id = "sheet_denim_patchwork", count = 4 }
        })
    :component("exodii_wire_kit", 1)
    :component_any({
            { id = "flashlight", count = 1 },
            { id = "heavy_flashlight", count = 1 }
        })
    :component("plastic_sheet", 2)
    :component_any({
            { id = "vest", count = 1 },
            { id = "tacvest", count = 1 },
            { id = "light_load_bearing_vest", count = 1 },
            { id = "load_bearing_vest", count = 1 }
        })
    :component_any({
            { id = "purse", count = 2 },
            { id = "leather_pouch", count = 4 },
            { id = "dump_pouch", count = 2 },
            { id = "fanny", count = 2 }
        })
    :component_any({
            { id = "tool_belt", count = 1 },
            { id = "legrig", count = 1 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 150)
    :requirement("soldering_standard", 10)
    :book("bp_nomad_jumpsuit", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :byproduct("scrap_leather", 11)
    :byproduct("denim_patch", 1)
    :byproduct("scrap_denim", 3)
)

content.add(content.Recipe {
    id = "nomad_bodyglove_1",
    result = "nomad_bodyglove_1",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 1320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 4,
    flags = { "SECRET" },
}
    :component("chunk_rubber", 2)
    :component("glue_weak", 500)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 90)
    :requirement("fastener_large", 2)
    :requirement("tailoring_lycra_patchwork", 1)
    :requirement("tailoring_cotton_patchwork", 1)
    :book("bp_nomad_bodyglove", 3)
    :proficiency("prof_closures")
    :proficiency("prof_elastics")
    :byproduct("scrap_cotton", 5)
    :byproduct("scrap_lycra", 4)
)

content.add(content.Recipe {
    id = "nomad_bodyglove_2",
    result = "nomad_bodyglove_2",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component("chunk_rubber", 2)
    :component("thread_kevlar", 20)
    :component("glue_weak", 500)
    :quality("LEATHER_AWL", 1, 1)
    :requirement("sewing_standard", 90)
    :requirement("fastener_large", 2)
    :requirement("tailoring_lycra_patchwork", 1)
    :requirement("tailoring_cotton_patchwork", 1)
    :book("bp_nomad_bodyglove", 4)
    :proficiency("prof_closures")
    :proficiency("prof_elastics")
    :proficiency("prof_polymerworking")
    :byproduct("scrap_cotton", 5)
    :byproduct("scrap_lycra", 4)
)

content.add(content.Recipe {
    id = "nomad_papr_blower_273diyua_off",
    result = "nomad_papr_blower_273diyua_off",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component_any({
            { id = "leather", count = 4 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 }
        })
    :component("sheath", 1)
    :component("exodii_wire_kit", 1)
    :component_any({
            { id = "basic_papr_belt_off", count = 1 },
            { id = "military_papr_blower_off", count = 1 },
            { id = "molle_papr_blower_off", count = 1 }
        })
    :component("plastic_sheet", 2)
    :component("tool_belt", 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 150)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 3)
    :book("bp_nomad_jumpsuit", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :byproduct("scrap_leather", 11)
)

content.add(content.Recipe {
    id = "nomad_papr_blower_273grenade_off",
    result = "nomad_papr_blower_273grenade_off",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component_any({
            { id = "leather", count = 4 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 }
        })
    :component("sheath", 1)
    :component("exodii_wire_kit", 1)
    :component_any({
            { id = "basic_papr_belt_off", count = 1 },
            { id = "military_papr_blower_off", count = 1 },
            { id = "molle_papr_blower_off", count = 1 }
        })
    :component("plastic_sheet", 2)
    :component("tool_belt", 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 150)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 3)
    :book("bp_nomad_jumpsuit", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :byproduct("scrap_leather", 11)
)

content.add(content.Recipe {
    id = "nomad_papr_blower_magpouch_off",
    result = "nomad_papr_blower_magpouch_off",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component_any({
            { id = "leather", count = 4 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather", count = 1 },
            { id = "sheet_leather_patchwork", count = 1 }
        })
    :component("sheath", 1)
    :component("exodii_wire_kit", 1)
    :component_any({
            { id = "basic_papr_belt_off", count = 1 },
            { id = "military_papr_blower_off", count = 1 },
            { id = "molle_papr_blower_off", count = 1 }
        })
    :component("plastic_sheet", 2)
    :component("tool_belt", 1)
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 150)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 3)
    :book("bp_nomad_jumpsuit", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :byproduct("scrap_leather", 11)
)

content.add(content.Recipe {
    id = "helmet_nomad_papr",
    result = "helmet_nomad_papr",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "tailor",
    difficulty = 5,
    flags = { "SECRET" },
}
    :component_any({
            { id = "hat_ball", count = 1 },
            { id = "hat_boonie", count = 1 },
            { id = "hat_golf", count = 1 }
        })
    :component("hose", 4)
    :component_any({
            { id = "helmet_motor", count = 1 },
            { id = "basic_papr_helmet", count = 1 },
            { id = "divemask_full_modular", count = 1 },
            { id = "face_shield_plastic", count = 2 },
            { id = "flight_helmet", count = 1 }
        })
    :component_any({
            { id = "leather", count = 8 },
            { id = "tanned_hide", count = 2 },
            { id = "sheet_leather", count = 2 },
            { id = "sheet_leather_patchwork", count = 2 }
        })
    :component("chunk_rubber", 16)
    :component_any({
            { id = "sheet_denim", count = 10 },
            { id = "sheet_denim_patchwork", count = 10 }
        })
    :quality("LEATHER_AWL", 1, 1)
    :quality("SEW", 2, 1)
    :quality("FABRIC_CUT", 1, 1)
    :requirement("filament_canvas", 80)
    :requirement("fastener_small", 4)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 3)
    :book("bp_nomad_cowl", 4)
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_closures")
)
