local ccb = require("ccb")

ccb.content.define_item {
    id = "portable_dark_age",
    category = "weapons",
    name = ccb.content.plural_text("portable dark age", "portable dark ages"),
    description = ccb.content.text("In this device the Mad Genius creates an extremely strong magnetic field.  Then in the next step of its creation they split that field in two in such a way it is perpetually trying to reconnect.  When activated the timer counts down til the moment the two fields reconnect.  Upon reconnection, energy is released in the form of EMP."),
    mass = "400 g",
    volume = "200 ml",
    price = "600 USD",
    survival_price = "300 USD",
    materials = { "lc_steel", "plastic" },
    symbol = "0",
    explode_in_fire = false,
    color = "light_gray",
    flags = { "RADIO_MODABLE", "RADIO_INVOKE_PROC", "BOMB", "GRENADE", "WATER_BREAK" },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "transform",
            need_wielding = true,
            target = "portable_dark_age_apct",
            message = ccb.content.text("You activate the portable dark age."),
            target_timer = "50 seconds",
            menu_text = ccb.content.text("Activate"),
        },
    },
}
