local ccb = require("ccb")

ccb.content.define_item {
    id = "aura_druid_waterwalk",
    name = ccb.content.plural_text("Waterstrider's Walk", "Waterstrider's Walks"),
    description = ccb.content.text("You can easily walk on the surface of the water."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    materials = { "concentrated_mana" },
    symbol = "O",
    color = "blue",
    flags = {
        "AURA", "SEMITANGIBLE", "PADDED", "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "TRADER_AVOID",
        "WATER_FRIENDLY", "NO_REPAIR", "NO_TAKEOFF", "ZERO_WEIGHT", "NONCONDUCTIVE", "FLOTATION",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_aura_druid_waterwalk_0" } },
}

ccb.content.define_item {
    id = "aura_caustic",
    name = ccb.content.plural_text("acid aura", "acid auras"),
    description = ccb.content.text("An aura of thin acid, swirling around your body ready to corrode when struck or while striking."),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "o",
    color = "blue",
    materials = { "magical_material" },
    flags = {
        "AURA",
        "TRADER_AVOID",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "OVERSIZE",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_aura_caustic" } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_2",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_3",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 4000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_4",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 8000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_5",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 16000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups_6",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    copy_from = "technomancer_summoned_ups",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 32000 } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}
