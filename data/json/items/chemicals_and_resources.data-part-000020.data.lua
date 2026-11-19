local ccb = require("ccb")

-- density: 0.76–4.20 g/cm3 according to Google, I'm going with the middle ground
ccb.content.define_item {
    id = "silicone",
    name = ccb.content.plural_text("silicone caulk", "silicone caulk"),
    category = "chems",
    description = ccb.content.text("A thick gray paste used as a sealant in many construction projects."),
    mass = "2480 mg",
    volume = "100 ml",
    price = "9 USD 36 cent",
    survival_price = "4 USD",
    stack_size = 10,
    phase = "liquid",
    default_container = "squeeze_tube",
    sealed_container = true,
    symbol = "s",
    color = "light_gray",
    flags = { "UNRECOVERABLE" },
    display_type = "BY_VOLUME",
    ammunition = { type = "components" },
}
