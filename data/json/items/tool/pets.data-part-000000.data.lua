local ccb = require("ccb")

ccb.content.define_item {
    id = "horse_tack",
    name = ccb.content.plural_text("horse tack", "horse tacks"),
    description = ccb.content.text("A saddle and associated tack that helps a rider mount a tamed animal capable of being ridden."),
    mass = "2 kg",
    volume = "7 L",
    price = "0 cent",
    survival_price = "10 USD",
    materials = { "leather", "steel" },
    symbol = "M",
    color = "yellow",
    flags = { "TACK" },
    subtype_order = { "tool", "pet_equipment" },
    tool = {},
    pet_equipment = { slots = { "saddle" }, passive_effects = { "monster_saddled" }, mount_threshold_delta = -1 },
}

ccb.content.define_item {
    id = "horse_bridle",
    name = ccb.content.plural_text("horse bridle", "horse bridles"),
    description = ccb.content.text("A leather headstall, bit, and reins fitted separately from the saddle to help keep a horse calm around threats."),
    mass = "700 g",
    volume = "2 L",
    price = "60 USD",
    survival_price = "8 USD",
    materials = { "leather", "steel" },
    symbol = "M",
    color = "brown",
    subtype_order = { "tool", "pet_equipment" },
    tool = {},
    pet_equipment = { slots = { "bridle" }, fear_multiplier = 0.75 },
}

ccb.content.define_item {
    id = "horse_stirrups",
    name = ccb.content.plural_text("horse stirrups (pair)", "horse stirrups (pair)"),
    description = ccb.content.text("A matched pair of metal stirrups with leather straps.  Attached to a saddle, they improve a rider's aim in mounted melee combat."),
    mass = "1500 g",
    volume = "2 L",
    price = "80 USD",
    survival_price = "12 USD",
    materials = { "steel", "leather" },
    symbol = "[",
    color = "light_gray",
    flags = { "STIRRUP" },
    subtype_order = { "tool", "pet_equipment" },
    tool = {},
    pet_equipment = { slots = { "stirrup" }, melee_hit_multiplier = 1.1 },
}
