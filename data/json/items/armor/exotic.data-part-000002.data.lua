local ccb = require("ccb")

ccb.content.define_item {
    id = "migo_sideplate_overgrown",
    copy_from = "migo_plate_overgrown",
    name = ccb.content.text("overgrown iridescent carapace side plate"),
    armor = {
        broken_item = "migo_sideplate",
        portions = {
            {
                encumbrance = 2,
                coverage = 35,
                covers = { "torso" },
                subparts = { "torso_lower" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 5.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    inheritance = {
        add = { flags = { "ABLATIVE_MEDIUM" } },
        remove = { flags = { "ABLATIVE_LARGE" } },
        scale = { volume = 0.5, mass = 0.5 },
    },
}

ccb.content.define_item {
    id = "migo_sideplate",
    copy_from = "migo_plate",
    name = ccb.content.text("iridescent carapace side plate"),
    revert_to = "migo_sideplate_overgrown",
    armor = {
        broken_item = "migo_sideplate_undergrown",
        portions = {
            {
                encumbrance = 1,
                coverage = 32,
                covers = { "torso" },
                subparts = { "torso_lower" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 4.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    inheritance = {
        add = { flags = { "ABLATIVE_MEDIUM" } },
        remove = { flags = { "ABLATIVE_LARGE" } },
        scale = { volume = 0.5, mass = 0.5 },
    },
}

ccb.content.define_item {
    id = "migo_sideplate_undergrown",
    copy_from = "migo_plate_undergrown",
    name = ccb.content.text("undergrown iridescent carapace side plate"),
    revert_to = "migo_sideplate",
    armor = {
        broken_item = "migo_sideplate_naked",
        portions = {
            {
                encumbrance = 1,
                coverage = 29,
                covers = { "torso" },
                subparts = { "torso_lower" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 2.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    inheritance = {
        add = { flags = { "ABLATIVE_MEDIUM" } },
        remove = { flags = { "ABLATIVE_LARGE" } },
        scale = { volume = 0.5, mass = 0.5 },
    },
}

ccb.content.define_item {
    id = "migo_sideplate_naked",
    copy_from = "migo_plate_naked",
    name = ccb.content.plural_text("small plate of scarred flesh", "small plates of scarred flesh"),
    revert_to = "migo_sideplate_undergrown",
    armor = {
        portions = {
            {
                encumbrance = 1,
                coverage = 0,
                covers = { "torso" },
                subparts = { "torso_lower" },
                materials = { { id = "flesh", coverage = 100, thickness = 4.0 } },
            },
        },
    },
    inheritance = {
        add = { flags = { "ABLATIVE_MEDIUM" } },
        remove = { flags = { "ABLATIVE_LARGE" } },
        scale = { volume = 0.5, mass = 0.5 },
    },
}
