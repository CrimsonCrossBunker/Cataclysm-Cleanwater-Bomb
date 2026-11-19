local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "mana",
    category = "chems",
    name = ccb.content.plural_text("mana core power", "mana core power"),
    description = ccb.content.text_without_extraction("Seeing this is a bug."),
    mass = "10 g",
    volume = "10 ml",
    phase = "solid",
    materials = { "mana" },
    flags = { "PSEUDO", "PERPETUAL" },
    symbol = "?",
    color = "magenta",
    melee_damage = { bash = 1 },
    ammunition = { count = 1, type = "mana" },
}
