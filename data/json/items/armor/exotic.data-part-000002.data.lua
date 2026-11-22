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

ccb.content.define_item {
    id = "migo_plate_naked",
    copy_from = "migo_plate_base",
    name = ccb.content.plural_text("plate of scarred flesh", "plates of scarred flesh"),
    description = "A chunk of otherworldly flesh that seems to have been forced into the shape of a ballistic plate with a slightly concave profile.  There is no armor left on this plate, just a mass of writhing alien flesh oozing in pain.  However, it looks like it is slowly growing back.",
    symbol = ",",
    color = "dark_gray",
    category = "armor",
    mass = "1000 g",
    volume = "1533 ml",
    price = "0 cent",
    survival_price = "0 cent",
    revert_to = "migo_plate_undergrown",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "TRADER_AVOID", "SPAWN_ACTIVE" },
    materials = { "flesh" },
    countdown_interval = "24 hours",
    countdown_action = {
        kind = "message",
        message = "The plate of scarred flesh expands as it grows.",
    },
    armor = {
        thickness = 4,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_upper" },
                coverage = 0,
                encumbrance = 2,
                materials = {
                    { id = "flesh", thickness = 4.0, coverage = 100 },
                },
            },
        },
    },
    inheritance = {
        remove = {
            materials = { "alien_carapace" },
        },
    },
}
