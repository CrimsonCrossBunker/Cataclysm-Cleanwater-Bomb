local ccb = require("ccb")

ccb.content.define_item {
    id = "migo_plate_base",
    abstract = true,
    name = ccb.content.text("generic migo plate"),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "alien_carapace", "flesh" },
    symbol = ",",
    color = "dark_gray",
    armor = { damage_verb = ccb.content.text("crumbles as blood oozes from its insides") },
}

ccb.content.define_item {
    id = "migo_plate_overgrown",
    category = "armor",
    copy_from = "migo_plate_base",
    name = ccb.content.text("overgrown iridescent carapace plate"),
    description = ccb.content.text("A chunk of otherworldly carapace that looks like it was at one point shaped like armor, but is now bulky and overgrown with sharp pieces jutting out haphazardly.  Scarred into the outer surface you can barely make out the label \"STRIKE FACE\".  It looks like you could force it into a ballistic vest."),
    mass = "2800 g",
    volume = "1533 ml",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "TRADER_AVOID" },
    armor = {
        thickness = 10,
        broken_item = "migo_plate",
        portions = {
            {
                encumbrance = 6,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper" },
                materials = {
                    { id = "alien_carapace", coverage = 100, thickness = 5.0 },
                    { id = "flesh", coverage = 95, thickness = 4.0 },
                },
            },
        },
    },
}
