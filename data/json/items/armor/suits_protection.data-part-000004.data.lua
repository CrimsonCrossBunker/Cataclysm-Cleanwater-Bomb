local ccb = require("ccb")

ccb.content.define_item {
    id = "chainmail_junk_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "budget_steel_chain" },
    name = ccb.content.text("chainmail hauberk"),
    armor = {
        portions = {
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "torso", "arm_l", "arm_r" },
                coverage = 97,
                encumbrance = 14,
            },
            {
                materials = { { id = "steel", coverage = 100, thickness = 1.2 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 50,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "lc_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_lc_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "lc_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "lc_steel_chain" },
    name = ccb.content.text("mild steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_mc_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "mc_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "mc_steel_chain" },
    name = ccb.content.text("medium steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_hc_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "hc_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "hc_steel_chain" },
    name = ccb.content.text("high steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_ch_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "ch_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "ch_steel_chain" },
    name = ccb.content.text("hardened steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_hauberk",
    copy_from = "base_chainmail_hauberk",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "xl_qt_chainmail_hauberk",
    copy_from = "xl_chainmail_hauberk",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail hauberk"),
    armor = {},
}

ccb.content.define_item {
    id = "qt_chainmail_hauberk_xs",
    copy_from = "xs_chainmail_hauberk",
    replace_materials = { steel = "qt_steel_chain" },
    name = ccb.content.text("tempered steel chainmail hauberk"),
    armor = {},
}
