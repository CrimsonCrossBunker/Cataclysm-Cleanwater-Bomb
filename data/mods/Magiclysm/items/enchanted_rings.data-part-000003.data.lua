local ccb = require("ccb")

ccb.content.define_item {
    id = "mring_fire_protection",
    copy_from = "mring_gold",
    survival_price = "6000 USD",
    name = ccb.content.plural_text("ring of fire protection", "rings of fire protection"),
    description = ccb.content.text("A crimsonite ring with a dappled pattern that protects you from fire."),
    replace_materials = { gold = "crimsonite_metal" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_fire_protection_0" } },
}

ccb.content.define_item {
    id = "mring_flying",
    copy_from = "mring_platinum",
    survival_price = "10000 USD",
    name = ccb.content.plural_text("ring of flying", "rings of flying"),
    description = ccb.content.text("A platinum ring that allows you fly for a short time each day, and prevents fall damage while worn."),
    pockets = { { kind = "MAGAZINE", ammunition = { crystallized_mana = 1 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = {
        charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true },
        enchantments = { "ITEM_ENCH_Magiclysm_mring_flying_0" },
    },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "ring_of_flight_spell",
            no_fail = true,
            level = 0,
            need_worn = true,
        },
    },
}

-- Extremely valuable in the apocalypse.
ccb.content.define_item {
    id = "mring_sustenance",
    copy_from = "mring_gold",
    survival_price = "25000 USD",
    name = ccb.content.plural_text("ring of sustenance", "rings of sustenance"),
    description = ccb.content.text("A golden ring that greatly reduces your need to eat, drink, or sleep while it is worn.  It will do nothing for feelings of hunger, and it requires a full day of being worn for the magic to take effect."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_sustenance_0" } },
}
