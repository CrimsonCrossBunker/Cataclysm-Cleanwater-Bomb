local ccb = require("ccb")

ccb.content.define_item {
    id = "flaming_fist",
    symbol = "3",
    color = "red",
    name = ccb.content.text("flaming fist"),
    description = ccb.content.text("A heavy metal guard that covers the fist and increases striking power, with stout padding underneath to protect the wearers hand.  It has been enchanted to emit dark magical flames that only harm enemies."),
    looks_like = "cestus",
    materials = { "steel", "leather" },
    volume = "500 ml",
    mass = "970 g",
    survival_price = "1 kUSD 240 USD",
    qualities = { { id = "HAMMER", level = 1 } },
    flags = { "DURABLE_MELEE", "NONCONDUCTIVE", "FLAMING", "RELIC_PINK" },
    max_worn = 1,
    melee_damage = { bash = 2, heat = 7 },
    armor = {
        portions = {
            {
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.0 },
                    { id = "steel", coverage = 75, thickness = 0.5 },
                },
                encumbrance = 5,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                subparts = {
                    "hand_wrist_l",
                    "hand_wrist_r",
                    "hand_palm_l",
                    "hand_palm_r",
                    "hand_back_l",
                    "hand_back_r",
                },
            },
            {
                materials = { { id = "leather", coverage = 100, thickness = 1.0 } },
                encumbrance = 0,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "gauntlet_pounding",
    symbol = "3",
    color = "light_gray",
    name = ccb.content.plural_text("gauntlet of pounding", "gauntlets of pounding"),
    description = ccb.content.text("A large gleaming metal gauntlet covered in magical symbols that allows you to land astoundingly powerful blows."),
    materials = { "steel", "leather" },
    volume = "1 L",
    mass = "981 g",
    accuracy = 1,
    survival_price = "1 kUSD 450 USD",
    qualities = { { id = "HAMMER", level = 2 } },
    techniques = { "WBLOCK_1", "BRUTAL" },
    flags = { "DURABLE_MELEE", "NONCONDUCTIVE", "OVERSIZE", "MESSY" },
    melee_damage = { bash = 16 },
    armor = { portions = { { encumbrance = 8, coverage = 20, covers = { "hand_r" } } } },
}

ccb.content.define_item {
    id = "rune_earthshaper_weapon",
    symbol = "3",
    color = "light_gray",
    name = ccb.content.plural_text("Earthshaper cestus", "Earthshaper cesti"),
    description = ccb.content.text("A stone battle glove with carved runes encasing the hand, protecting it while increasing striking power.  There is an Earthshaper rune embedded in the palm."),
    materials = { "stone", "leather", "steel" },
    volume = "500 ml",
    mass = "873 g",
    accuracy = 1,
    qualities = { { id = "HAMMER", level = 1 } },
    techniques = { "WBLOCK_1", "BRUTAL" },
    flags = { "DURABLE_MELEE", "TRADER_AVOID", "MAGIC_FOCUS", "SPELLCASTING_AID", "NONCONDUCTIVE" },
    melee_damage = { bash = 13 },
    armor = { portions = { { encumbrance = 5, coverage = 20, covers = { "hand_r" } } } },
}
