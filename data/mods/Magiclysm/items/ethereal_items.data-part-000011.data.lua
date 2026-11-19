local ccb = require("ccb")

-- Needs to remain an item instead of an effect until enchantment mutations from effects are fixed.
ccb.content.define_item {
    id = "aura_feral",
    name = ccb.content.plural_text("feral aura", "feral auras"),
    description = ccb.content.text("The manifestation of your rage.  It won't disappear until you calm down."),
    mass = "500 mg",
    volume = "1 ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "magical_material" },
    flags = { "PERSONAL", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_aura_feral" } },
}

-- Needs to remain an item instead of an effect until enchantment mutations from effects are fixed.
ccb.content.define_item {
    id = "aura_feral_plus",
    name = ccb.content.plural_text("enhanced feral aura", "enhanced feral auras"),
    description = ccb.content.text("The manifestation of your rage.  It won't disappear until you calm down."),
    mass = "500 mg",
    volume = "1 ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "magical_material" },
    flags = { "PERSONAL", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ench_aura_feral_plus" } },
}

ccb.content.define_item {
    id = "aura_werewolf",
    name = ccb.content.plural_text("werewolf aura", "werewolf auras"),
    description = ccb.content.text("You have become the werewolf.  Boys becoming men, men becoming wolves."),
    mass = "500 mg",
    volume = "1 ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "magical_material" },
    flags = { "PERSONAL", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = {
        enchantments = { "ITEM_ENCH_Magiclysm_aura_werewolf_0", "ITEM_ENCH_Magiclysm_aura_werewolf_1" },
    },
}

ccb.content.define_item {
    id = "dragon_shell_black",
    name = ccb.content.plural_text("Black Dragon Shell", "Black Dragon Shells"),
    description = ccb.content.text("An aura of black and green draconic energy, swirling around your body protecting you and punishing those who strike you."),
    mass = "1 g",
    volume = "1 ml",
    materials = { "concentrated_mana" },
    symbol = "o",
    color = "green",
    flags = {
        "AURA", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "OVERSIZE", "PADDED", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 0,
        thickness = 0.4,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_dragon_shell_black_0" } },
}

ccb.content.define_item {
    id = "subzero_talons",
    name = ccb.content.plural_text("subzero talons", "subzero talons"),
    description = ccb.content.text("Claws made from ice, able to freeze on contact while mauling foes.  You, however, feel only a slight chill on your hands."),
    mass = "100 g",
    volume = "100 ml",
    length = "15 cm",
    price = "1 cent",
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 12 } },
    accuracy = { grip = "weapon", length = "hand", surface = "every", balance = "good" },
    weapon_categories = { "CLAWS" },
    flags = {
        "UNBREAKABLE_MELEE", "NONCONDUCTIVE", "NO_UNWIELD", "MAGIC_FOCUS", "TRADER_AVOID", "NO_REPAIR",
        "NO_SALVAGE", "UNRESTRICTED",
    },
    techniques = { "WBLOCK_2", "RAPID" },
    melee_damage = { bash = 6, cut = 12 },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                encumbrance = 5,
                coverage = 20,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_l", "hand_back_r" },
            },
        },
    },
    artifact = { enchantments = { "ench_subzero_talons" } },
}

ccb.content.define_item {
    id = "item_armor_magus_mage_conjured_armor",
    category = "armor",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.plural_text("force armor", "force armor"),
    description = ccb.content.text("A summoned suit of armor made of pure force.  It gets stronger and sturdier with each spell level and is affected by your intelligence, though its glow also increases."),
    mass = "1 g",
    materials = { "concentrated_mana" },
    flags = {
        "MORPHIC",
        "OUTER",
        "STURDY",
        "NO_REPAIR",
        "NO_SALVAGE",
        "TRADER_AVOID",
        "PADDED",
        "UNRESTRICTED",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 0,
        thickness = 0,
        portions = {
            {
                encumbrance = 8,
                coverage = 100,
                covers = {
                    "head",
                    "torso",
                    "arm_l",
                    "arm_r",
                    "hand_l",
                    "hand_r",
                    "leg_l",
                    "leg_r",
                    "foot_l",
                    "foot_r",
                },
            },
        },
    },
    artifact = {
        enchantments = { "ench_armor_spirit", "ITEM_ENCH_Magiclysm_item_armor_magus_mage_conjured_armor_1" },
    },
}

ccb.content.define_item {
    id = "longsword_holy",
    copy_from = "longsword",
    name = ccb.content.plural_text("force blade", "force blades"),
    description = ccb.content.text("This is a summoned mana sword, between the lighter arming sword and later two-handed swords in size.  It glows shiny, and its edge is sharper the more spell level and intelligence you have."),
    materials = { "concentrated_mana" },
    flags = {
        "UNBREAKABLE_MELEE",
        "NONCONDUCTIVE",
        "NO_REPAIR",
        "NO_SALVAGE",
        "MAGIC_FOCUS",
        "TRADER_AVOID",
    },
    melee_damage = { bash = 11, cut = 1 },
    artifact = { enchantments = { "ench_longsword_holy" } },
}
