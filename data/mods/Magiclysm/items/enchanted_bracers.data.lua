local ccb = require("ccb")

ccb.content.define_item {
    id = "mbracer_steel_pair",
    category = "armor",
    name = ccb.content.plural_text("pair of steel bracers", "pairs of steel bracers"),
    description = ccb.content.text("A full assembly of medieval arm protection."),
    mass = "1520 g",
    volume = "2500 ml",
    price = "200 USD",
    accuracy = -1,
    materials = { "steel", "leather" },
    symbol = "[",
    color = "light_gray",
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN", "WATER_FRIENDLY" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 10,
        thickness = 5,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 3,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 90,
                vitals_coverage = 70,
                subparts = { "arm_lower_r", "arm_lower_l" },
            },
        },
    },
}

ccb.content.define_item {
    id = "mbracer_steel_single",
    copy_from = "mbracer_steel_pair",
    name = ccb.content.plural_text("steel bracer", "steel bracers"),
    mass = "770 g",
    volume = "1250 ml",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { sided = true },
}

ccb.content.define_item {
    id = "mbracer_defense_lesser",
    copy_from = "mbracer_steel_single",
    name = ccb.content.plural_text("bracer of lesser defense", "bracers of lesser defense"),
    survival_price = "950 USD",
    description = ccb.content.text("A light but extremely sturdy steel bracer with an ornate shield engraved on the top, silver accentuates the intricate design.  It protects your body with a light aura to reduce damage you take."),
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = { thickness = 6 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mbracer_defense_lesser_0" } },
}

ccb.content.define_item {
    id = "mbracer_defense_greater",
    copy_from = "mbracer_steel_single",
    survival_price = "1850 USD",
    name = ccb.content.plural_text("bracer of greater defense", "bracers of greater defense"),
    description = ccb.content.text("A light but extremely sturdy steel bracer with an ornate shield engraved on the top, gold accentuates the intricate design.  It protects your body with a strong aura to reduce damage you take."),
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = { thickness = 6 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mbracer_defense_greater_0" } },
}

ccb.content.define_item {
    id = "mbracer_lightning_lesser",
    copy_from = "mbracer_steel_single",
    name = ccb.content.plural_text("lesser bracer of lightning", "lesser bracers of lightning"),
    survival_price = "750 USD",
    description = ccb.content.text("A light but extremely sturdy steel bracer with an ornate bundle of lightning bolts engraved on the top, silver accentuates the intricate design.  It protects your body with a light aura to reduce electrical damage you take, as well as being able to release a Jolt spell 3 times a day."),
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 3 } } },
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN", "NO_UNLOAD", "NO_RELOAD" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = {
        charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true },
        enchantments = { "ITEM_ENCH_Magiclysm_mbracer_lightning_lesser_0" },
    },
    use_actions = { { kind = "cast_spell", spell = "jolt", no_fail = true, level = 15, need_worn = true } },
}

ccb.content.define_item {
    id = "mbracer_lightning_greater",
    copy_from = "mbracer_steel_single",
    name = ccb.content.plural_text("greater bracer of lightning", "greater bracers of lightning"),
    survival_price = "1750 USD",
    description = ccb.content.text("A light but extremely sturdy steel bracer with an ornate bundle of lightning bolts engraved on the top, gold accentuates the intricate design.  It protects your body with a strong aura to reduce electrical damage you take, as well as being able to release a Lightning Bolt spell 3 times a day."),
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 3 } } },
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN", "NO_UNLOAD", "NO_RELOAD" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = {
        charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true },
        enchantments = { "ITEM_ENCH_Magiclysm_mbracer_lightning_greater_0" },
    },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "lightning_bolt",
            no_fail = true,
            level = 15,
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "mbracer_archery",
    copy_from = "vambrace_larmor",
    name = ccb.content.plural_text("pair of bracers of archery", "pairs of bracers of archery"),
    survival_price = "750 USD",
    description = ccb.content.text("A set of leather bracers worked with images of arrows in flight and scenes of hunting parties.  Bows you wield will be more accurate and do more damage while you wear these, and you can shoot your arrows farther as well."),
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mbracer_archery_0" } },
}

ccb.content.define_item {
    id = "mbracer_blinding_strike",
    copy_from = "vambrace_larmor",
    survival_price = "1850 USD",
    name = ccb.content.plural_text("bracers of the blinding strike", "bracers of the blinding strike"),
    description = ccb.content.text("A pair of light leather bracers with inlays of mithril looking like vines with tiny, leaf-shaped leaves branching off of the vines.  It slightly increases your attack speed at all times, and you may activate it to greatly increase your attack speed for a short time."),
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 3 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = {
        charge = { recharge_type = "periodic", interval = "8 h", regenerate_ammo = true },
        enchantments = { "ITEM_ENCH_Magiclysm_mbracer_blinding_strike_0" },
    },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "mbracer_blinding_strike_spell",
            no_fail = true,
            level = 0,
            need_worn = true,
        },
    },
}
