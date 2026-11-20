local ccb = require("ccb")

ccb.content.define_fault_fix {
    id = "mend_armor_soft_planishing",
    name = ccb.content.text("Flatten the dent."),
    removes = { "fault_armor_lc_dented", "fault_armor_mc_dented" },
    success_message = ccb.content.text("You flatten the dent in your %s."),
    duration = "30 m",
    skills = { fabrication = 2 },
    proficiency_time_factors = { prof_armorsmithing = 0.8 },
    requirements = { { qualities = { { id = "HAMMER", level = 3 }, { id = "ANVIL", level = 3 } } } },
}

-- Need to heat the armor a bit to make the metal planishable.
ccb.content.define_fault_fix {
    id = "mend_armor_hard_planishing",
    name = ccb.content.text("Flatten the dent."),
    removes = { "fault_armor_hc_dented", "fault_armor_ch_dented", "fault_armor_qt_dented" },
    success_message = ccb.content.text("You flatten the dent in your %s."),
    duration = "30 m",
    skills = { fabrication = 3 },
    proficiency_time_factors = { prof_armorsmithing = 0.8 },
    requirements = { { id = "blacksmithing_standard_fileless", count = 1 } },
}

-- Those recipes assume a cooling period.
ccb.content.define_fault_fix {
    id = "mend_armor_weld_lc",
    name = ccb.content.text("Weld the hole."),
    removes = { "fault_armor_lc_punctured", "fault_armor_mc_punctured" },
    success_message = ccb.content.text("You weld %s hole."),
    duration = "3 h",
    skills = { fabrication = 5 },
    proficiency_time_factors = { prof_armorsmithing = 0.8, prof_welding_basic = 0.9, prof_welding = 0.8 },
    requirements = { { id = "repair_welding_lc_steel", count = 1 } },
}

ccb.content.define_fault_fix {
    id = "mend_armor_weld_hc",
    name = ccb.content.text("Weld the hole."),
    removes = { "fault_armor_hc_punctured" },
    success_message = ccb.content.text("You weld %s hole."),
    duration = "3 h",
    skills = { fabrication = 5 },
    proficiency_time_factors = { prof_armorsmithing = 0.8, prof_welding_basic = 0.9, prof_welding = 0.8 },
    requirements = { { id = "repair_welding_standard", count = 1 } },
}

-- The added material is hardened.
ccb.content.define_fault_fix {
    id = "mend_armor_weld_ch",
    name = ccb.content.text("Weld the hole."),
    removes = { "fault_armor_ch_punctured" },
    success_message = ccb.content.text("You weld %s hole."),
    duration = "3 h",
    skills = { fabrication = 6 },
    proficiency_time_factors = {
        prof_armorsmithing = 0.8,
        prof_welding_basic = 0.9,
        prof_welding = 0.8,
        prof_hardening = 0.8,
    },
    requirements = {
        { id = "forging_standard", count = 1 },
        { id = "repair_welding_standard", count = 1 },
        { id = "carbon", count = 1 },
    },
}

-- The armor is heated to tempering temperature then the weld is done and the armor left to cool in a welding blanket.
ccb.content.define_fault_fix {
    id = "mend_armor_weld_qt",
    name = ccb.content.text("Weld the hole."),
    removes = { "fault_armor_qt_punctured" },
    success_message = ccb.content.text("You weld %s hole."),
    duration = "3 h",
    skills = { fabrication = 7 },
    proficiency_time_factors = {
        prof_armorsmithing = 0.8,
        prof_welding_basic = 0.9,
        prof_welding = 0.8,
        prof_tempering = 0.8,
    },
    requirements = {
        { id = "forging_standard", count = 1 },
        { id = "repair_welding_standard", count = 1 },
        { tools = { { { "welding_blanket", -1 }, { "welding_kit", -1 } } } },
    },
}

-- These fixes involve fastening a metal sheet to patch the hole.
ccb.content.define_fault_fix {
    id = "mend_armor_lc_patch",
    name = ccb.content.text("Patch the hole."),
    removes = { "fault_armor_lc_punctured" },
    success_message = ccb.content.text("You patch the hole in %s."),
    duration = "1 h",
    skills = { fabrication = 3 },
    proficiency_time_factors = { prof_armorsmithing = 0.5 },
    requirements = { { id = "rivet_setting", count = 4 }, { components = { { { "sheet_metal_small", 1 } } } } },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_lc_patch",
    id = "mend_armor_mc_patch",
    name = ccb.content.text("Patch the hole."),
    removes = { "fault_armor_mc_punctured" },
    requirements = {
        { id = "rivet_setting", count = 4 },
        { components = { { { "mc_sheet_metal_small", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_lc_patch",
    id = "mend_armor_hc_patch",
    name = ccb.content.text("Patch the hole."),
    removes = { "fault_armor_hc_punctured" },
    requirements = {
        { id = "rivet_setting", count = 4 },
        { components = { { { "hc_sheet_metal_small", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_lc_patch",
    id = "mend_armor_ch_patch",
    name = ccb.content.text("Patch the hole."),
    removes = { "fault_armor_ch_punctured" },
    requirements = {
        { id = "rivet_setting", count = 4 },
        { components = { { { "ch_sheet_metal_small", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_lc_patch",
    id = "mend_armor_qt_patch",
    name = ccb.content.text("Patch the hole."),
    removes = { "fault_armor_qt_punctured" },
    requirements = {
        { id = "rivet_setting", count = 4 },
        { components = { { { "qt_sheet_metal_small", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    id = "mend_armor_patch_forge_lc",
    name = ccb.content.text("Patch the hole using a forge."),
    removes = { "fault_armor_lc_punctured" },
    success_message = ccb.content.text("You weld %s hole."),
    duration = "3 h",
    skills = { fabrication = 5 },
    proficiency_time_factors = { prof_armorsmithing = 0.8, prof_blacksmithing = 0.6 },
    requirements = {
        { id = "blacksmithing_standard", count = 1 },
        { components = { { { "lc_steel_chunk", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_patch_forge_lc",
    id = "mend_armor_patch_forge_mc",
    name = ccb.content.text("Patch the hole using a forge."),
    removes = { "fault_armor_mc_punctured" },
    requirements = {
        { id = "blacksmithing_standard", count = 1 },
        { components = { { { "mc_steel_chunk", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_patch_forge_lc",
    id = "mend_armor_patch_forge_hc",
    name = ccb.content.text("Patch the hole using a forge."),
    removes = { "fault_armor_hc_punctured" },
    requirements = {
        { id = "blacksmithing_standard", count = 1 },
        { components = { { { "hc_steel_chunk", 1 } } } },
    },
}

ccb.content.define_fault_fix {
    id = "mend_armor_patch_forge_ch",
    name = ccb.content.text("Patch the hole using a forge."),
    removes = { "fault_armor_ch_punctured" },
    success_message = ccb.content.text("You weld %s hole."),
    duration = "3 h",
    skills = { fabrication = 6 },
    proficiency_time_factors = { prof_armorsmithing = 0.9, prof_blacksmithing = 0.9, prof_hardening = 0.8 },
    requirements = {
        { id = "blacksmithing_standard", count = 1 },
        { components = { { { "lc_steel_chunk", 1 } } } },
        { id = "carbon", count = 1 },
    },
}

ccb.content.define_fault_fix {
    id = "mend_armor_patch_forge_qt",
    name = ccb.content.text("Patch the hole using a forge."),
    removes = { "fault_armor_qt_punctured" },
    success_message = ccb.content.text("You weld %s hole."),
    duration = "3 h",
    skills = { fabrication = 7 },
    proficiency_time_factors = { prof_armorsmithing = 0.9, prof_blacksmithing = 0.9, prof_tempering = 0.8 },
    requirements = {
        { id = "blacksmithing_standard", count = 1 },
        { components = { { { "mc_steel_chunk", 1 } } } },
        { tools = { { { "metal_tank", -1 } }, { { "water", -120 }, { "water_clean", -120 } } } },
    },
}

-- This assumes forging an entirely new part from scratch, the part is assumed to be half a chestplate since chestplates are almost always made of 2 parts.
ccb.content.define_fault_fix {
    id = "mend_armor_lc_replace",
    name = ccb.content.text("Replace the damaged part with a new one."),
    removes = { "fault_armor_lc_punctured", "fault_armor_lc_dented" },
    success_message = ccb.content.text("You replace the damaged %s part."),
    mod_damage = -1000,
    mod_degradation = -50,
    duration = "6 d",
    skills = { fabrication = 6 },
    proficiency_time_factors = { prof_armorsmithing = 0.9, prof_blacksmithing = 0.9 },
    requirements = {
        { qualities = { { id = "CHISEL", level = 3 } } },
        { tools = { { { "swage", -1 } } } },
        { id = "blacksmithing_standard", count = 10 },
        { id = "lc_steel_standard", count = 3 },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_lc_replace",
    id = "mend_armor_mc_replace",
    name = ccb.content.text("Replace the damaged part with a new one."),
    removes = { "fault_armor_mc_punctured", "fault_armor_mc_dented" },
    requirements = {
        { qualities = { { id = "CHISEL", level = 3 } } },
        { tools = { { { "swage", -1 } } } },
        { id = "blacksmithing_standard", count = 10 },
        { id = "mc_steel_standard", count = 3 },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_lc_replace",
    id = "mend_armor_hc_replace",
    name = ccb.content.text("Replace the damaged part with a new one."),
    removes = { "fault_armor_hc_punctured", "fault_armor_hc_dented" },
    requirements = {
        { qualities = { { id = "CHISEL", level = 3 } } },
        { tools = { { { "swage", -1 } } } },
        { id = "blacksmithing_standard", count = 10 },
        { id = "hc_steel_standard", count = 3 },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_lc_replace",
    id = "mend_armor_ch_replace",
    name = ccb.content.text("Replace the damaged part with a new one."),
    removes = { "fault_armor_ch_punctured", "fault_armor_ch_dented" },
    proficiency_time_factors = { prof_armorsmithing = 0.9, prof_blacksmithing = 0.9, prof_hardening = 0.9 },
    requirements = {
        { qualities = { { id = "CHISEL", level = 3 } } },
        { tools = { { { "swage", -1 } } } },
        { id = "blacksmithing_standard", count = 10 },
        { id = "lc_steel_standard", count = 3 },
        { id = "carbon", count = 3 },
    },
}

ccb.content.define_fault_fix {
    copy_from = "mend_armor_lc_replace",
    id = "mend_armor_qt_replace",
    name = ccb.content.text("Replace the damaged part with a new one."),
    duration = "6 d 21h 36m",
    removes = { "fault_armor_qt_punctured", "fault_armor_qt_dented" },
    proficiency_time_factors = { prof_armorsmithing = 0.9, prof_blacksmithing = 0.9, prof_tempering = 0.9 },
    requirements = {
        { qualities = { { id = "CHISEL", level = 3 } } },
        {
            tools = {
                { { "hotcut_any", 1, "LIST" } },
                { { "metal_tank", -1 } },
                { { "water", -120 }, { "water_clean", -120 } },
            },
        },
        { id = "blacksmithing_standard", count = 10 },
        { id = "mc_steel_standard", count = 3 },
    },
}

ccb.content.define_fault_fix {
    id = "mend_armor_articulation_replace_rivets",
    name = ccb.content.text("Replace the rivets."),
    removes = { "fault_armor_rivets_broken" },
    success_message = ccb.content.text("You replace %s rivets."),
    mod_damage = -1000,
    mod_degradation = -5,
    duration = "2 h",
    skills = { fabrication = 2 },
    proficiency_time_factors = { prof_armorsmithing = 0.9, prof_articulation = 0.8 },
    requirements = { { id = "rivet_replacement", count = 4 } },
}

-- This is to be specifically used with rivet-fastened straps.
ccb.content.define_fault_fix {
    id = "mend_armor_articulation_replace_straps_rivets",
    name = ccb.content.text("Replace the straps."),
    removes = { "fault_armor_straps_cut" },
    success_message = ccb.content.text("You replace %s straps."),
    mod_damage = -1000,
    mod_degradation = -5,
    duration = "2 h",
    skills = { tailor = 2 },
    proficiency_time_factors = { prof_armorsmithing = 0.9, prof_closures = 0.8 },
    requirements = {
        { id = "strap_small", count = 2 },
        { id = "rivet_replacement", count = 4 },
        { qualities = { { id = "FABRIC_CUT", level = 2 }, { id = "LEATHER_AWL", level = 1 } } },
    },
}

ccb.content.define_fault_fix {
    id = "mend_armor_cotton_tear_stitch",
    name = ccb.content.text("Stitch the fabric back together"),
    removes = { "fault_cotton_torn" },
    success_message = ccb.content.text("You stitch the tear in %s back up."),
    mod_damage = -1000,
    mod_degradation = -25,
    duration = "10 m",
    skills = { tailor = 1 },
    requirements = { { id = "filament", count = 1 }, { qualities = { { id = "SEW", level = 1 } } } },
}

ccb.content.define_fault_fix {
    id = "mend_armor_cotton_hole_close",
    name = ccb.content.text("Patch the hole."),
    removes = { "fault_cotton_hole" },
    success_message = ccb.content.text("You patch the hole in %s."),
    mod_damage = -1000,
    mod_degradation = -25,
    duration = "20 m",
    skills = { tailor = 1 },
    requirements = { { id = "tailoring_cotton_small_simple", count = 1 } },
}

ccb.content.define_fault_fix {
    id = "mend_armor_denim_tear_stitch",
    name = ccb.content.text("Stitch the fabric back together"),
    removes = { "fault_denim_torn" },
    copy_from = "mend_armor_cotton_tear_stitch",
}

ccb.content.define_fault_fix {
    id = "mend_armor_denim_hole_close",
    name = ccb.content.text("Patch the hole"),
    removes = { "fault_denim_hole" },
    copy_from = "mend_armor_cotton_tear_stitch",
    requirements = { { id = "tailoring_denim_small_simple", count = 1 } },
}

ccb.content.define_fault_fix {
    id = "mend_armor_nl_phase_goo",
    name = ccb.content.text("Wipe off the out-of-phase goo"),
    removes = { "fault_nl_phase_goo" },
    success_message = ccb.content.text("You wipe off the goo."),
    duration = "120 s",
}
