local ccb = require("ccb")

ccb.content.define_item {
    id = "biomancer_booster_sludge",
    name = ccb.content.plural_text("biomancer booster sludge", "biomancer booster sludge"),
    description = "A thick purple liquid that is filled to the brim with arcane energy.  With the right tool, it can be used to boost your biomancer caster level.",
    symbol = "~",
    color = "pink",
    phase = "liquid",
    default_container = "flask_glass",
    mass = "265 g",
    volume = "250 ml",
    price = "0 cent",
    flags = { "NO_INGEST" },
    comestible = { kind = "MED", servings = 1 },
    ammunition = { type = "biomancer_booster_sludge" },
    subtype_order = { "comestible", "ammunition" },
}
