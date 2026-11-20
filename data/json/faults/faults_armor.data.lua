local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_armor_lc_dented",
    name = ccb.content.text("Dented"),
    description = ccb.content.text("A metal plate was dented."),
    severity = "minor",
    item_prefix = ccb.content.text("dented", "prefix"),
    message = ccb.content.text("%s was dented!"),
    degradation_mod = 5,
    price_modifier = 0.8,
    armor = {
        { damage_type = "bash", multiply = 0.8 },
        { damage_type = "cut", multiply = 0.9 },
        { damage_type = "stab", multiply = 0.8 },
    },
}

ccb.content.define_fault {
    copy_from = "fault_armor_lc_dented",
    id = "fault_armor_mc_dented",
    name = ccb.content.text("Dented"),
    description = ccb.content.text("A metal plate was dented."),
}

ccb.content.define_fault {
    copy_from = "fault_armor_lc_dented",
    id = "fault_armor_hc_dented",
    name = ccb.content.text("Dented"),
    description = ccb.content.text("A metal plate was dented."),
}

ccb.content.define_fault {
    copy_from = "fault_armor_lc_dented",
    id = "fault_armor_ch_dented",
    name = ccb.content.text("Dented"),
    description = ccb.content.text("A metal plate was dented."),
}

ccb.content.define_fault {
    copy_from = "fault_armor_lc_dented",
    id = "fault_armor_qt_dented",
    name = ccb.content.text("Dented"),
    description = ccb.content.text("A metal plate was dented."),
}

ccb.content.define_fault {
    id = "fault_armor_lc_punctured",
    name = ccb.content.text("Punctured"),
    description = ccb.content.text("A metal plate was punctured."),
    severity = "major",
    item_prefix = ccb.content.text("punctured"),
    message = ccb.content.text("%s was punctured!"),
    degradation_mod = 5,
    price_modifier = 0.8,
    armor = {
        { damage_type = "bash", multiply = 0.8 },
        { damage_type = "cut", multiply = 0.9 },
        { damage_type = "stab", multiply = 0.7 },
    },
}

ccb.content.define_fault {
    copy_from = "fault_armor_lc_punctured",
    id = "fault_armor_mc_punctured",
    name = ccb.content.text("Punctured"),
    description = ccb.content.text("A metal plate was punctured."),
}

ccb.content.define_fault {
    copy_from = "fault_armor_lc_punctured",
    id = "fault_armor_hc_punctured",
    name = ccb.content.text("Punctured"),
    description = ccb.content.text("A metal plate was punctured."),
}

ccb.content.define_fault {
    copy_from = "fault_armor_lc_punctured",
    id = "fault_armor_ch_punctured",
    name = ccb.content.text("Punctured"),
    description = ccb.content.text("A metal plate was punctured."),
}

ccb.content.define_fault {
    copy_from = "fault_armor_lc_punctured",
    id = "fault_armor_qt_punctured",
    name = ccb.content.text("Punctured"),
    description = ccb.content.text("A metal plate was punctured."),
}

ccb.content.define_fault {
    id = "fault_armor_rivets_broken",
    name = ccb.content.text("Damaged rivets"),
    description = ccb.content.text("Some of the rivets were broken."),
    severity = "minor",
    item_prefix = ccb.content.text("damaged", "prefix"),
    message = ccb.content.text("%s's rivets were broken!"),
    degradation_mod = 5,
    price_modifier = 0.9,
    encumbrance_mult = 1.5,
    armor = {
        { damage_type = "bash", multiply = 0.9 },
        { damage_type = "cut", multiply = 0.9 },
        { damage_type = "stab", multiply = 0.9 },
    },
}

ccb.content.define_fault {
    id = "fault_armor_straps_cut",
    name = ccb.content.text("Cut straps"),
    description = ccb.content.text("Some of the straps were cut."),
    severity = "minor",
    item_prefix = ccb.content.text("damaged", "prefix"),
    message = ccb.content.text("%s's straps were cut!"),
    degradation_mod = 5,
    price_modifier = 0.9,
    encumbrance_mult = 1.5,
    armor = {
        { damage_type = "bash", multiply = 0.9 },
        { damage_type = "cut", multiply = 0.9 },
        { damage_type = "stab", multiply = 0.9 },
    },
}

ccb.content.define_fault {
    id = "fault_cotton_torn",
    name = ccb.content.text("Torn cotton"),
    description = ccb.content.text("There's a tear in the fabric."),
    severity = "minor",
    message = ccb.content.text("%s's fabric was torn!"),
    fault_type = "mechanical_damage",
    degradation_mod = 25,
    price_modifier = 0.7,
    armor = {
        { damage_type = "bash", multiply = 0.9 },
        { damage_type = "cut", multiply = 0.9 },
        { damage_type = "stab", multiply = 0.9 },
    },
}

ccb.content.define_fault {
    id = "fault_cotton_hole",
    name = ccb.content.text("Hole"),
    description = ccb.content.text("There's a big hole in the fabric."),
    severity = "minor",
    message = ccb.content.text("A hole is ripped into the %s!"),
    fault_type = "mechanical_damage",
    affected_by_degradation = true,
    degradation_mod = 5,
    price_modifier = 0.7,
    armor = {
        { damage_type = "bash", multiply = 0.85 },
        { damage_type = "cut", multiply = 0.85 },
        { damage_type = "stab", multiply = 0.85 },
    },
}

ccb.content.define_fault {
    id = "fault_denim_torn",
    name = ccb.content.text("Torn denim"),
    description = ccb.content.text("There's a tear in the fabric."),
    copy_from = "fault_cotton_torn",
}

ccb.content.define_fault {
    id = "fault_denim_hole",
    name = ccb.content.text("Hole"),
    description = ccb.content.text("There's a big hole in the fabric."),
    copy_from = "fault_cotton_hole",
}

ccb.content.define_fault {
    id = "fault_nl_phase_goo",
    name = ccb.content.text("Out of phase"),
    description = ccb.content.text("The object is covered in dimensionally-altered goo, lowering its protective value.  You think you could mend the problem by just wiping it off."),
    severity = "major",
    item_prefix = ccb.content.text("out-of-phase"),
    message = ccb.content.text("Out-of-phase goo sticks to the %s!"),
    degradation_mod = 0,
    price_modifier = 0,
    armor = {
        { damage_type = "bash", multiply = 0.5 },
        { damage_type = "cut", multiply = 0.5 },
        { damage_type = "stab", multiply = 0.5 },
    },
}
