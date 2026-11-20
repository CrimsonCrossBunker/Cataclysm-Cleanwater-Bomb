local ccb = require("ccb")

ccb.content.define_item {
    id = "whistle_multitool",
    category = "tools",
    name = ccb.content.plural_text("whistle multitool", "whistle multitools"),
    description = ccb.content.text("A cheap gadget combining a whistle, thermometer, magnifying glass, and compass."),
    mass = "7 g",
    volume = "25 ml",
    price = "2 USD",
    survival_price = "2 USD 50 cent",
    materials = { "plastic" },
    symbol = ";",
    color = "dark_gray",
    flags = { "FIRESTARTER", "THERMOMETER" },
    tool = {},
    use_actions = {
        {
            kind = "manualnoise",
            moves = 100,
            volume = 100,
            sound_message = ccb.content.text("FWEEEET!"),
            sound_id = "misc",
            sound_variant = "whistle",
            message = ccb.content.text("You blow the whistle."),
        },
        "WEATHER_TOOL",
        { kind = "firestarter", moves = 1000, slow_moves = 25000, need_sunlight = true },
    },
}
