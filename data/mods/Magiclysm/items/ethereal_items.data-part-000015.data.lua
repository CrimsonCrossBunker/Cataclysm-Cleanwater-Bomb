local ccb = require("ccb")

-- Recharge time is 2 seconds due to bug #48019, making it actually 1 second. Reduce to 1 second if that ever gets fixed.
ccb.content.define_item {
    id = "technomancer_summoned_ups",
    category = "tool_magazine",
    name = ccb.content.plural_text("technomantic power supply", "technomantic power supplies"),
    description = ccb.content.text("A smoothly-curved conglomeration of mana, humming softly as it provides power."),
    mass = "125 g",
    volume = "65 ml",
    materials = { "concentrated_mana" },
    symbol = "=",
    color = "yellow",
    looks_like = "spiral_stone",
    flags = { "TRADER_AVOID", "NO_DROP", "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD" },
    max_worn = 1,
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1 } } },
    subtype_order = { "magazine", "artifact" },
    magazine = { ammunition = { "battery" }, capacity = 1 },
    artifact = { charge = { recharge_type = "periodic", interval = "2 s", regenerate_ammo = true } },
}

ccb.content.define_item {
    id = "druid_bramble_spear_item",
    name = ccb.content.plural_text("spear of brambles", "spears of brambles"),
    looks_like = "spear_wood",
    description = ccb.content.text("A twisted wooden spear whose branches twine together into a vicious point sticky with sap."),
    mass = "1200 g",
    survival_price = "1 cent",
    color = "green",
    symbol = "/",
    materials = { "wood" },
    techniques = { "WBLOCK_1", "IMPALE" },
    volume = "1750 ml",
    length = "180 cm",
    melee_damage = { bash = 5, stab = 26 },
    accuracy = { grip = "weapon", length = "long", surface = "point", balance = "good" },
    flags = {
        "SPEAR",
        "REACH_ATTACK",
        "NONCONDUCTIVE",
        "SHEATH_SPEAR",
        "UNBREAKABLE_MELEE",
        "NO_REPAIR",
        "NO_SALVAGE",
    },
    weapon_categories = { "POLEARMS", "SPEARS" },
    price = "1 cent",
    qualities = { { id = "COOK", level = 1 } },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_druid_bramble_spear_item_0" } },
}

--  'Tornskin' but working right.  Values copied from the Bark mutation.
ccb.content.define_item {
    id = "druid_thorn_skin_item",
    name = ccb.content.plural_text("Thornskin", "Thornskins"),
    description = ccb.content.text("Your skin is bark-like and covered in thorns."),
    mass = "6 kg",
    volume = "7500 ml",
    price = "0 cent",
    materials = { "wood" },
    symbol = "x",
    color = "brown",
    flags = {
        "PERSONAL", "OVERSIZE", "PADDED", "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "TRADER_AVOID",
        "NO_REPAIR", "NO_TAKEOFF", "NONCONDUCTIVE",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "wood", coverage = 100, thickness = 4 },
                    { id = "wood", coverage = 75, thickness = 6 },
                },
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_druid_thorn_skin_item_0" } },
}

ccb.content.define_item {
    id = "item_biomancer_scalpel_fingers",
    category = "armor",
    name = ccb.content.plural_text("flensing fingers", "flensing fingers"),
    description = ccb.content.text("Your fingers are a series of knives made of bone and flesh.  Enemies beware."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "flesh" },
    symbol = ",",
    color = "magenta",
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "ZERO_WEIGHT", "UNBREAKABLE", "PERSONAL", "PADDED" },
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 5 }, { id = "BUTCHER", level = 14 } },
    melee_damage = { stab = 12 },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_item_biomancer_scalpel_fingers_0" } },
}

ccb.content.define_item {
    id = "aura_druid_breathing_water",
    name = ccb.content.plural_text("Aquatic Mantle", "Aquatic Mantles"),
    description = ccb.content.text("Covered in magical seaweed, you can travel and breathe underwater as long as this spell is in effect."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    materials = { "veggy" },
    symbol = "O",
    color = "blue",
    flags = {
        "AURA", "OVERSIZE", "PADDED", "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "TRADER_AVOID",
        "REBREATHER", "WATER_FRIENDLY", "NO_REPAIR", "NO_TAKEOFF", "ZERO_WEIGHT", "NONCONDUCTIVE",
        "WATERPROOF", "SWIM_GOGGLES",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_aura_druid_breathing_water_0" } },
}

ccb.content.define_item {
    id = "aura_bearmantle",
    name = ccb.content.plural_text("bearmantle", "bearmantles"),
    description = ccb.content.text("Think as the bear.  Move as the bear.  Sleep as the bear."),
    mass = "0 g",
    volume = "0 ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "magical_material" },
    flags = {
        "PERSONAL", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "ZERO_WEIGHT", "NO_TAKEOFF",
        "INTEGRATED", "NONCONDUCTIVE",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_aura_bearmantle_0" } },
}

ccb.content.define_item {
    id = "item_animist_luck_bone",
    copy_from = "bone",
    name = ccb.content.plural_text("luck-bone", "luck-bones"),
    description = ccb.content.text("A bone from some creature or other, inhabited by benevolent spirits."),
    color = "white",
    price = "0 cent",
    mass = "225 g",
    symbol = "%",
    survival_price = "10 cent",
    volume = "250 ml",
    length = "40 cm",
    artifact = { enchantments = { "ench_luck_bone" } },
}

ccb.content.define_item {
    id = "technomancer_far_sight_lens",
    copy_from = "lens",
    name = ccb.content.plural_text("enchanted lens", "enchanted lenses"),
    description = ccb.content.text("This lens has been etched with small symbols and infused with mana.  Holding it up to your eye allows you to see further than any mundane binoculars allow."),
    flags = { "ENHANCED_VISION", "TRADER_AVOID" },
    artifact = { enchantments = { "ench_technomancer_far_sight_lens" } },
}
