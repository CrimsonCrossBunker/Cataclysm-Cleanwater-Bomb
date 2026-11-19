local ccb = require("ccb")

ccb.content.define_item {
    id = "suspenders_holster",
    name = ccb.content.plural_text("holster suspenders", "holster suspenders"),
    description = ccb.content.text("A pair of leather suspenders with a holster placed near the stomach."),
    copy_from = "suspenders_leather",
    flags = { "BELTED", "WATER_FRIENDLY" },
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "250 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 50,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = { 3, 4 },
                coverage = 75,
                covers = { "torso" },
                subparts = { "torso_waist" },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Store tool or blade"),
            message = ccb.content.text("You put your %1$s in your %2$s"),
        },
    },
}
