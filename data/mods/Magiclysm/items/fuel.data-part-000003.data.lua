local ccb = require("ccb")

ccb.content.define_item {
    id = "mana_infused_blood",
    name = ccb.content.plural_text("mana infused blood", "mana infused blood"),
    description = "Blood that is filled to the brim with arcane energy.  It releases a faint blue glow.",
    symbol = "~",
    color = "light_blue",
    phase = "liquid",
    default_container = "flask_glass",
    mass = "265 g",
    volume = "250 ml",
    price = "0 cent",
    flags = { "NO_INGEST" },
    use_actions = {
        { kind = "cast_spell", spell = "mana_doping", level = 0, no_fail = true },
    },
    comestible = { kind = "MED", tool = "syringe", quench = 50, servings = 1 },
    ammunition = { type = "mana_infused_blood" },
    subtype_order = { "comestible", "ammunition" },
}
