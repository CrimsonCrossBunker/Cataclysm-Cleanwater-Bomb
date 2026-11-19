local ccb = require("ccb")

ccb.content.define_item {
    id = "diving_watch",
    name = ccb.content.plural_text("diver's watch", "diver's watches"),
    description = ccb.content.text("A waterproof, self-winding watch on a stainless steel watchband.  Tells the time and current temperature.  Activate to check the digital thermometer."),
    mass = "100 g",
    volume = "90 ml",
    price = "120 USD",
    survival_price = "7 USD",
    materials = { "steel" },
    symbol = "[",
    looks_like = "gold_watch",
    color = "light_gray",
    flags = {
        "WATCH",
        "ALARMCLOCK",
        "WATER_FRIENDLY",
        "THERMOMETER",
        "BELTED",
        "ALLOWS_NATURAL_ATTACKS",
        "OVERSIZE",
    },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
    use_actions = { "WEATHER_TOOL" },
}
