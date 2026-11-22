local ccb = require("ccb")

ccb.content.define_item {
    id = "longsword",
    copy_from = "longsword",
    name = "longsword",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "HYLIAN_MASTER_SWORD" },
        },
    },
}

ccb.content.define_item {
    id = "sickle",
    copy_from = "sickle",
    name = "sickle",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "HYLIAN_IMPROV_WEAPONS" },
        },
    },
}
