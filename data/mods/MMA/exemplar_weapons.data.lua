local ccb = require("ccb")

ccb.content.define_item {
    id = "scimitar",
    copy_from = "scimitar",
    name = "shamshir",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "EXEMPLAR_WEAPON_DESERT_WIND" },
        },
    },
}

ccb.content.define_item {
    id = "rapier",
    copy_from = "rapier",
    name = "rapier",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "EXEMPLAR_WEAPON_DIAMOND_MIND" },
        },
    },
}

ccb.content.define_item {
    id = "katana",
    copy_from = "katana",
    name = ccb.content.plural_text("katana", "katana"),
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "EXEMPLAR_WEAPON_IRON_HEART" },
        },
    },
}

ccb.content.define_item {
    id = "sword_xiphos",
    copy_from = "sword_xiphos",
    name = ccb.content.plural_text("xiphos", "xiphe"),
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "EXEMPLAR_WEAPON_SETTING_SUN" },
        },
    },
}

ccb.content.define_item {
    id = "zweihander",
    copy_from = "zweihander",
    name = "zweihänder",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "EXEMPLAR_WEAPON_STONE_DRAGON" },
        },
    },
}

ccb.content.define_item {
    id = "kukri",
    copy_from = "kukri",
    name = "kukri",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "EXEMPLAR_WEAPON_TIGER_CLAW" },
        },
    },
}
