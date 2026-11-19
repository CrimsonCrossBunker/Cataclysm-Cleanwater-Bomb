local ccb = require("ccb")

-- transforms over a day
ccb.content.define_item {
    id = "migo_plate",
    category = "armor",
    copy_from = "migo_plate_base",
    name = ccb.content.plural_text("iridescent carapace plate", "iridescent carapace plates"),
    description = ccb.content.text("A chunk of otherworldly carapace that seems to have been forced into the shape of a ballistic plate with a slightly concave profile.  Scarred into the outer surface is the label \"STRIKE FACE\".  It looks like you could force it into a ballistic vest."),
    mass = "2000 g",
    volume = "1533 ml",
    revert_to = "migo_plate_overgrown",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "TRADER_AVOID", "SPAWN_ACTIVE" },
    armor = {
        thickness = 8,
        broken_item = "migo_plate_undergrown",
        portions = {
            {
                encumbrance = 2,
                coverage = 42,
                covers = { "torso" },
                subparts = { "torso_upper" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 4.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    countdown_action = {
        kind = "message",
        message = ccb.content.text_without_extraction("The iridescent carapace plate expands as it grows."),
    },
    countdown_interval = "24 hours",
}

-- transforms over a day
ccb.content.define_item {
    id = "migo_plate_undergrown",
    category = "armor",
    copy_from = "migo_plate_base",
    name = ccb.content.plural_text("undergrown iridescent carapace plate", "undergrown iridescent carapace plates"),
    description = ccb.content.text("A chunk of otherworldly carapace that seems to have been forced into the shape of a ballistic plate with a slightly concave profile.  Scarred into the outer surface is the label \"STRIKE FACE\".  The armor coverage is spotty and it appears to be oozing and pulsing like it is in pain."),
    mass = "1500 g",
    volume = "1533 ml",
    revert_to = "migo_plate",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "TRADER_AVOID", "SPAWN_ACTIVE" },
    armor = {
        thickness = 6,
        broken_item = "migo_plate_naked",
        portions = {
            {
                encumbrance = 2,
                coverage = 39,
                covers = { "torso" },
                subparts = { "torso_upper" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 2.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
    countdown_action = {
        kind = "message",
        message = ccb.content.text_without_extraction("The iridescent carapace plate expands as it grows."),
    },
    countdown_interval = "24 hours",
}
