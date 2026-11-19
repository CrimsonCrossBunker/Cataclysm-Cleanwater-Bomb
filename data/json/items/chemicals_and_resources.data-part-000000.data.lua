local ccb = require("ccb")

ccb.content.define_item {
    id = "anesthetic",
    name = ccb.content.plural_text("anesthetic", "anesthetic"),
    category = "chems",
    description = ccb.content.text("A variety of powerful hypnotic, analgesic, and stimulative drugs.  It's intended for use in specialized medical equipment, and can't be administered manually.  You can reload an anesthesia kit with it."),
    mass = "714 mg",
    volume = "540 ml",
    price = "83 USD 33 cent",
    survival_price = "30 USD",
    phase = "liquid",
    default_container = "jar_3l_glass_sealed",
    sealed_container = false,
    symbol = "!",
    color = "cyan",
    looks_like = "ether",
    display_type = "BY_VOLUME",
    ammunition = { type = "anesthetic", count = 420 },
}
