local ccb = require("ccb")

ccb.content.define_item {
    id = "ink_abstract",
    category = "chems",
    price = "30 USD",
    survival_price = "5 USD",
    name = ccb.content.plural_text("ink abstract", "ink abstract"),
    symbol = "=",
    color = "white",
    description = ccb.content.text("The Platonic essence of ink.  You probably shouldn't have access to this."),
    default_container = "clay_pot",
    materials = { "fruit", "water" },
    phase = "liquid",
    volume = "25 ml",
    mass = "1250 mg",
    ammunition = { type = "components", count = 10 },
}

ccb.content.define_item {
    id = "homemade_ink",
    copy_from = "ink_abstract",
    name = ccb.content.plural_text("homemade ink", "homemade ink"),
    description = ccb.content.text("A simple ink made by boiling fruit and vinegar together until it becomes thicker and darker.  It won't last through the ages but you can write with it."),
    color = "yellow",
    ammunition = {},
}

ccb.content.define_item {
    id = "magical_ink_simple",
    copy_from = "ink_abstract",
    name = ccb.content.plural_text("magical ink, apprentice", "magical ink, apprentice"),
    description = ccb.content.text("A simple ink made by boiling fruit and vinegar with herbs.  It won't hold anything more than a rudimentary enchantment."),
    color = "yellow",
    ammunition = {},
}
