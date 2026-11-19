local ccb = require("ccb")

ccb.content.define_item {
    id = "mboots_sevenleague",
    copy_from = "boots_hiking",
    name = ccb.content.plural_text("seven league boots", "pairs of seven league boots"),
    looks_like = "boots_hiking",
    survival_price = "750 USD",
    description = ccb.content.text("Rugged yet extremely comfortable and well fitting boots of worn leather and steel, they look like they've seen a lot of use and will likely see a lot more.  They make your movement a lot less work."),
    flags = { "WATERPROOF", "STURDY" },
    materials = { "leather" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 30,
        thickness = 3,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 3.0 } },
                encumbrance = 6,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mboots_sevenleague_0" } },
}

ccb.content.define_item {
    id = "mboots_haste",
    copy_from = "boots_hiking",
    name = ccb.content.plural_text("boots of haste", "pairs of boots of haste"),
    looks_like = "boots_hiking",
    survival_price = "950 USD",
    description = ccb.content.text("Rugged yet extremely comfortable and well fitting boots of worn leather and steel, they look like they've seen a lot of use and will likely see a lot more.  They make your movement a lot less work."),
    flags = { "WATERPROOF", "STURDY" },
    materials = { "leather" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 30,
        thickness = 3,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 3.0 } },
                encumbrance = 6,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    artifact = {
        enchantments = { "ITEM_ENCH_Magiclysm_mboots_haste_0", "ITEM_ENCH_Magiclysm_mboots_haste_1" },
    },
}

ccb.content.define_item {
    id = "mboots_escape",
    copy_from = "boots_hiking",
    name = ccb.content.plural_text("escape boots", "escape boots"),
    looks_like = "boots_hiking",
    survival_price = "550 USD",
    description = ccb.content.text("Rugged yet extremely comfortable and well fitting boots of worn leather and steel, these boots can be activated once a day to escape from nasty situations, teleporting you a good distance in a random direction."),
    pockets = { { kind = "MAGAZINE", ammunition = { crystallized_mana = 1 } } },
    flags = { "WATERPROOF", "STURDY", "NO_UNLOAD", "NO_RELOAD" },
    materials = { "leather" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {
        warmth = 30,
        thickness = 3,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 3.0 } },
                encumbrance = 6,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    artifact = { charge = { recharge_type = "periodic", interval = "24 h", regenerate_ammo = true } },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "magus_escape",
            no_fail = true,
            level = 10,
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "mboots_freerunner",
    copy_from = "boots_hiking",
    name = ccb.content.plural_text("freerunner's boots", "freerunner's boots"),
    looks_like = "boots_hiking",
    survival_price = "350 USD",
    description = ccb.content.text("Rugged yet extremely comfortable and well fitting boots of worn leather and steel, seeming a bit more flexible and breathable than typical for their materials.  The enchantment they bear helps guide their wearer in their motions, to make movement around and over obstacles much more fluid and efficient."),
    flags = { "WATERPROOF", "STURDY" },
    materials = { "leather" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 3.0 } },
                encumbrance = 6,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mboots_freerunner_0" } },
}

ccb.content.define_item {
    id = "mboots_grounding",
    copy_from = "boots_hiking",
    name = ccb.content.plural_text("boots of grounding", "pairs of boots of grounding"),
    looks_like = "boots_hiking",
    survival_price = "350 USD",
    description = ccb.content.text("Rugged yet extremely comfortable and well fitting boots of leather with small engraved runes seemingly filled with rubber.  When worn, you are immune to damage from electricity."),
    flags = { "WATERPROOF", "STURDY" },
    materials = { "leather" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 30,
        thickness = 3,
        environmental_protection = 3,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 3.0 } },
                encumbrance = 6,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mboots_grounding_0" } },
}

ccb.content.define_item {
    id = "boots_of_elvenkind",
    category = "armor",
    name = ccb.content.plural_text("pair of boots of elvenkind", "pairs of boots of elvenkind"),
    description = ccb.content.text("One of the traditional items of the ancient elven warrior societies, these soft leather boots are worked with silver inlays in the shape of vines and leaves.  They allow the wearer to walk in complete silence and move faster when in the wilderness."),
    mass = "902 g",
    volume = "2 L",
    price = "3 kUSD",
    survival_price = "150 USD",
    accuracy = -1,
    materials = { "leather" },
    symbol = "[",
    looks_like = "boots",
    color = "brown",
    flags = { "VARSIZE", "STURDY" },
    melee_damage = { bash = 4 },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 15,
        thickness = 3,
        environmental_protection = 2,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "leather", coverage = 100, thickness = 3.0 } },
                encumbrance = 6,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "leather", coverage = 100, thickness = 0.3 } },
                coverage = 100,
            },
        },
    },
    artifact = {
        enchantments = { "ITEM_ENCH_Magiclysm_boots_of_elvenkind_0", "ITEM_ENCH_Magiclysm_boots_of_elvenkind_1" },
    },
}
