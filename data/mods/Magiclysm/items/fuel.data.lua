local ccb = require("ccb")

ccb.content.define_item {
    id = "dragon_blood",
    name = ccb.content.plural_text("dragon blood", "dragon blood"),
    mass = "1 g",
    color = "red",
    default_container = "flask_glass",
    symbol = "~",
    description = ccb.content.text("Blood of a dragon, it radiates warmth and looking at it you see moving patterns form and disappear in it as if looking at an actual fire."),
    price = "1 USD 50 cent",
    materials = { "dragon_blood" },
    volume = "1 ml",
    phase = "liquid",
    category = "fuel",
    ammunition = {
        type = "dragon_blood",
        damage = { type = "stab", amount = 5, penetration = 5 },
        range = 4,
        effects = { "FLAME", "STREAM", "IGNITE" },
    },
}

ccb.content.define_item {
    id = "blood",
    copy_from = "blood",
    name = ccb.content.plural_text("blood", "blood"),
    color = "red",
    symbol = "~",
    category = "fuel",
    ammunition = { type = "blood" },
}

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

ccb.content.define_item {
    id = "blood_tainted",
    copy_from = "blood_tainted",
    name = ccb.content.plural_text("tainted blood", "tainted blood"),
    symbol = "~",
    category = "fuel",
    mass = "1048 mg",
    volume = "1 ml",
    ammunition = { type = "blood_tainted" },
    comestible = { calories = 2 },
    subtype_order = { "ammunition", "comestible" },
}
