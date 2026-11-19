local ccb = require("ccb")

ccb.content.define_item {
    id = "mag_awakened_water",
    name = ccb.content.plural_text("glowing awakened water", "glowing awakened water"),
    description = ccb.content.text("A nutrient-rich elixir for wildwood entities.  No longer fit for consumption."),
    category = "fuel",
    mass = "750 mg",
    volume = "200ml",
    price = "2 USD",
    survival_price = "20 cent",
    phase = "liquid",
    default_container = "bottle_gourd",
    materials = { "mag_awakened_water" },
    symbol = "=",
    color = "light_blue",
    stack_size = 20,
    ammunition = { count = 225, type = "mag_awakened_water" },
}
