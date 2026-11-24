local ccb = require("ccb")

ccb.content.define_item {
    id = "phrygian_cap",
    name = ccb.content.text("phrygian cap"),
    description = ccb.content.text("A soft conical hat with the apex bent over.  Commonly worn in antiquity by various cultures in Eastern Europe and Anatolia.  It later signified freedom in both the American and French Revolutions."),
    mass = "120 g",
    volume = "250 ml",
    price = "12 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "hat_cotton",
    color = "brown_green",
    flags = { "VARSIZE", "WATER_FRIENDLY" },
    armor = {
        warmth = 3,
        thickness = 0.3,
        portions = { { encumbrance_modifiers = { "NONE" }, coverage = 40, covers = { "head" } } },
    },
}

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

ccb.content.define_spell {
    id = "bleeding_cap",
    name = ccb.content.text("Bleeding Cap"),
    description = ccb.content.text("Blood starts seeping out of the cap, down your face."),
    valid_targets = { "self" },
    flags = { "NO_LEGS", "SILENT" },
    min_range = 0,
    max_range = 0,
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "bloody_cap",
    shape = "blast",
    spell_class = "NONE",
    energy_source = "NONE",
    difficulty = 5,
    max_level = 20,
    base_casting_time = 0,
    base_energy_cost = 1,
    min_duration = 6000,
    max_duration = 60000,
    duration_increment = 4000,
}

-- I added a helmet to the summon
ccb.content.define_item {
    id = "bloody_cap",
    category = "armor",
    copy_from = "xl_mt_chainmail_hood",
    name = ccb.content.plural_text("bloody redcap", "bloody redcap"),
    description = ccb.content.text("The cap develops a fearsome aura as the blood pours back out of the fibers."),
    materials = { "moon_tears_fine_chain" },
    light = 2,
    flags = { "OVERSIZE", "PERSONAL", "VARSIZE", "STURDY", "NO_REPAIR", "NO_SALVAGE", "TRADER_AVOID" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 0,
        thickness = 2,
        portions = {
            {
                encumbrance = 5,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_bloody_cap_0" } },
}
