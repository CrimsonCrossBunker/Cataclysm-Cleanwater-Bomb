local ccb = require("ccb")

ccb.content.define_item {
    id = "portable_dark_age_apct",
    category = "weapons",
    name = ccb.content.plural_text("active EMP bomb", "active EMP bombs"),
    description = ccb.content.text("The Portable Dark Age™ is now active and will soon end all electronic devices in range.  Prepare yourself for a life without mp3s and cell phones, at least in the closest 60 meters."),
    mass = "400 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "lc_steel", "plastic" },
    symbol = "*",
    explode_in_fire = false,
    color = "light_gray",
    flags = { "TRADER_AVOID", "WATER_BREAK" },
    melee_damage = { bash = 2 },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Summon Dark Age"),
        },
    },
    countdown_action = { kind = "explosion", draw_radius = 60, draw_color = "light_blue", emp_radius = 60 },
}
