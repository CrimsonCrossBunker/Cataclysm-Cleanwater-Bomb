local ccb = require("ccb")

-- For now it'll be a once-a-day item, as making fae blood a comestible made its use as ammo not work.  When comestibles will be usable as ammo, bring back the hat using fae blood as fuel.
ccb.content.define_item {
    id = "theredcap",
    name = ccb.content.plural_text("blood red cap", "blood red caps"),
    description = ccb.content.text("A soft conical hat with the apex bent over.  Commonly worn in antiquity by various cultures in Eastern Europe and Anatolia.  It later signified freedom in both the American and French Revolutions.  Along the brim the cap appears to be the rusty red of old blood."),
    mass = "120 g",
    volume = "250 ml",
    price = "12 USD",
    survival_price = "50 cent",
    materials = { "fae_fur" },
    symbol = "[",
    looks_like = "hat_cotton",
    color = "red",
    flags = { "OVERSIZE", "WATER_FRIENDLY", "NO_UNLOAD", "NO_RELOAD" },
    pockets = { { kind = "MAGAZINE", ammunition = { glamour_charge = 1 }, airtight = true } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {
        warmth = 3,
        thickness = 0.3,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 40, covers = { "head" } } },
    },
    artifact = { charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true } },
    use_actions = { { kind = "cast_spell", spell = "bleeding_cap", no_fail = true, level = 1, need_worn = true } },
}
