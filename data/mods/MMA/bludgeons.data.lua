local ccb = require("ccb")

ccb.content.define_item {
    id = "cudgel",
    copy_from = "cudgel",
    name = "cudgel",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "HYLIAN_IMPROV_WEAPONS" },
        },
    },
}

ccb.content.define_item {
    id = "ladle",
    copy_from = "ladle",
    name = "ladle",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "HYLIAN_IMPROV_WEAPONS" },
        },
    },
}

ccb.content.define_item {
    id = "stick",
    copy_from = "stick",
    name = "stick",
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "HYLIAN_IMPROV_WEAPONS" },
        },
    },
}

ccb.content.define_item {
    id = "torch",
    copy_from = "torch",
    name = ccb.content.plural_text("torch", "torches"),
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "HYLIAN_IMPROV_WEAPONS" },
        },
    },
}

ccb.content.define_item {
    id = "torch_lit",
    copy_from = "torch_lit",
    name = ccb.content.plural_text("torch", "torches"),
    tool = {},
    inheritance = {
        add = {
            weapon_categories = { "HYLIAN_IMPROV_WEAPONS" },
        },
    },
}
