local ccb = require("ccb")

-- 1.082 g/cm3
ccb.content.define_item {
    id = "acetic_anhydride",
    category = "chems",
    name = ccb.content.plural_text("acetic anhydride", "acetic anhydride"),
    description = ccb.content.text("A colorless liquid that smells strongly of vinegar.  If you have enough chemical knowledge, you could use it to easily convert morphine into heroin."),
    materials = { "oil" },
    default_container = "bottle_glass",
    mass = "54100 mg",
    volume = "50 ml",
    price = "50 cent",
    survival_price = "2 cent",
    phase = "liquid",
    symbol = "~",
    color = "dark_gray",
    looks_like = "chem_ethanol",
    display_type = "BY_VOLUME",
    comestible = {
        kind = "INVALID",
        sleepiness = -20,
        servings = 1,
        quench = -99,
        healthy = -20,
        fun = -99,
        freezing_point = -73,
    },
    use_actions = { "POISON", "BLECH" },
}
