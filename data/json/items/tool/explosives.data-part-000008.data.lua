local ccb = require("ccb")

ccb.content.define_item {
    id = "gelled_molotov",
    copy_from = "molotov",
    name = ccb.content.plural_text("gelled Molotov", "gelled Molotovs"),
    description = ccb.content.text("An older brother of the generic Molotov cocktail, this wicked beverage uses thickened gasoline or straight napalm.  It, surprisingly, does not make for a fire of much higher temperature, but what it does is make the burning mixture ever more sticky."),
    survival_price = "6 USD",
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "gelled_molotov_lit",
            message = ccb.content.text("You light the gelled Molotov!"),
            moves = 250,
            need_fire = 1,
            menu_text = ccb.content.text("Light rag"),
        },
    },
}
