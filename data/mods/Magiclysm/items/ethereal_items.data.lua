local ccb = require("ccb")

ccb.content.define_item {
    id = "stonefist",
    name = ccb.content.plural_text("pair of magical armored stone gauntlets", "pairs of magical armored stone gauntlets"),
    description = ccb.content.text("A magical flexible stonelike substance for protection and attack."),
    mass = "1 g",
    volume = "250 ml",
    length = "20 cm",
    price = "1 cent",
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    looks_like = "gauntlets_chitin",
    qualities = { { id = "HAMMER", level = 1 } },
    flags = { "STURDY", "DURABLE_MELEE", "NONCONDUCTIVE", "MAGIC_FOCUS", "UNRESTRICTED" },
    max_worn = 1,
    techniques = { "WBLOCK_3" },
    melee_damage = { bash = 20 },
    armor = {
        warmth = 20,
        environmental_protection = 10,
        portions = {
            {
                materials = { { id = "concentrated_mana", coverage = 100, thickness = 3 } },
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_l", "arm_r", "hand_l", "hand_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "finger_firelighter",
    name = ccb.content.plural_text("finger firelighter", "finger firelighters"),
    description = ccb.content.text("This is a small flame you can hold in your hand.  With a thought, you can cause it to light something on fire, or you can throw it to ignite something flammable."),
    mass = "1 g",
    volume = "1 ml",
    price = "0 cent",
    symbol = ",",
    color = "red",
    light = 8,
    flags = { "TRADER_AVOID", "FIRESTARTER", "FLAMING", "WATER_EXTINGUISH" },
    tool = {},
    use_actions = { { kind = "firestarter", moves = 20 } },
    drop_action = { kind = "emit_actor", emissions = { "emit_tiny_fire" } },
}

ccb.content.define_item {
    id = "electric_lighter",
    name = ccb.content.plural_text("stable spark", "stable sparks"),
    description = ccb.content.text("Small electric spark, that does not disappear under your force.  With a thought, you can cause it to light something on fire, or you can throw it to ignite something flammable."),
    mass = "1 g",
    volume = "1 ml",
    price = "0 cent",
    symbol = ",",
    color = "yellow",
    light = 8,
    flags = { "TRADER_AVOID", "FIRESTARTER" },
    tool = {},
    use_actions = { { kind = "firestarter", moves = 20 } },
    drop_action = { kind = "emit_actor", emissions = { "emit_tiny_fire" } },
}

ccb.content.define_item {
    id = "shield_ice",
    name = ccb.content.plural_text("large shield of magical ice", "large shields of magical ice"),
    category = "armor",
    description = ccb.content.text("A lightweight but tough shield crafted entirely of magical ice."),
    mass = "1 kg",
    volume = "5 L",
    length = "50 cm",
    price = "1 cent",
    accuracy = 1,
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    looks_like = "gauntlets_chitin",
    techniques = { "WBLOCK_3" },
    flags = { "OVERSIZE", "BELTED", "RESTRICT_HANDS", "BLOCK_WHILE_WORN", "UNRESTRICTED" },
    melee_damage = { bash = 14 },
    armor = {
        sided = true,
        thickness = 4,
        portions = { { encumbrance = 10, coverage = 70, covers = { "arm_l", "arm_r", "hand_l", "hand_r" } } },
    },
}

ccb.content.define_item {
    id = "ice_gliders",
    name = ccb.content.plural_text("slick icy coatings", "slick icy coatings"),
    description = ccb.content.text("A magical slick icy coating on your feet.  While quite fast on flat floors, they make it difficult to move on rough terrain."),
    mass = "1 g",
    volume = "250 ml",
    length = "15 cm",
    price = "1 cent",
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "brown",
    looks_like = "boots_plate",
    flags = { "OVERSIZE", "WATERPROOF", "ROLLER_QUAD", "BELTED", "UNRESTRICTED" },
    melee_damage = { bash = 6 },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 30,
        thickness = 0.2,
        environmental_protection = 2,
        portions = { { encumbrance = 0, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_ice_gliders_0" } },
}

ccb.content.define_item {
    id = "stormhammer",
    name = ccb.content.plural_text("The Stormhammer", "The Stormhammers"),
    description = ccb.content.text("A crackling magical warhammer full of lightning to smite your foes with, and of course, to smash things to bits!"),
    mass = "1337 g",
    length = "70 cm",
    color = "brown",
    symbol = "/",
    looks_like = "warhammer",
    materials = { "concentrated_mana" },
    techniques = { "WBLOCK_2", "BRUTAL", "SWEEP", "MOUNTED_CHARGE" },
    copy_from = "warhammer",
    light = 15,
    flags = {
        "NONCONDUCTIVE", "BELT_CLIP", "TRADER_AVOID", "UNBREAKABLE_MELEE", "NO_REPAIR", "NO_SALVAGE",
        "MAGIC_FOCUS",
    },
    volume = "1250 ml",
    qualities = { { id = "HAMMER", level = 1 } },
    melee_damage = { bash = 30 },
    artifact = { enchantments = { "ench_storm_hammer" } },
}

ccb.content.define_item {
    id = "stormglove",
    symbol = "3",
    color = "light_gray",
    looks_like = "gauntlets_chitin",
    name = ccb.content.plural_text("Stormfist", "Stormfists"),
    description = ccb.content.text("Encases your arm and hand in a sheath of crackling magical lightning, you can punch and defend yourself with it in melee combat."),
    materials = { "concentrated_mana" },
    volume = "155 ml",
    mass = "300 g",
    length = "25 cm",
    light = 5,
    flags = {
        "UNBREAKABLE_MELEE", "NONCONDUCTIVE", "TRADER_AVOID", "NO_REPAIR", "NO_SALVAGE", "MAGIC_FOCUS",
        "UNRESTRICTED",
    },
    max_worn = 1,
    accuracy = { grip = "weapon", length = "hand", surface = "any", balance = "neutral" },
    melee_damage = { bash = 6 },
    subtype_order = { "armor", "artifact" },
    armor = {
        thickness = 0.3,
        portions = {
            {
                materials = { { id = "concentrated_mana", coverage = 100, thickness = 1.0 } },
                encumbrance = 2,
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
                materials = { { id = "concentrated_mana", coverage = 100, thickness = 1.0 } },
                encumbrance = 0,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
            },
            {
                materials = { { id = "concentrated_mana", coverage = 100, thickness = 1.0 } },
                encumbrance = 0,
                coverage = 60,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
            },
        },
    },
    artifact = { enchantments = { "ench_stormglove" } },
}

ccb.content.define_item {
    id = "tentacle_whip",
    symbol = "/",
    color = "brown",
    name = ccb.content.plural_text("vicious tentacle whip", "vicious tentacle whips"),
    description = ccb.content.text("A long, writhing, tentacle covered in sharp bonelike blades and spikey protrusions."),
    mass = "2460 g",
    volume = "1975 ml",
    length = "40 cm",
    materials = { "bone", "flesh" },
    techniques = { "PRECISE", "RAPID", "WBLOCK_2" },
    flags = {
        "REACH_ATTACK", "REACH3", "WHIP", "STURDY", "TRADER_AVOID", "UNBREAKABLE_MELEE", "NO_REPAIR",
        "MAGIC_FOCUS",
    },
    category = "weapons",
    melee_damage = { cut = 30 },
    weapon_categories = { "WHIPS" },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_tentacle_whip_0" } },
}

ccb.content.define_item {
    id = "fleshpouch",
    name = ccb.content.plural_text("flesh pouch", "flesh pouches"),
    description = ccb.content.text("A large pouch of tough flesh on your back, filled with tiny tentacles that grasp and hold anything you place inside.  It shifts and adjusts itself to minimize encumbrance."),
    mass = "0 kg",
    volume = "0 L",
    price = "0 cent",
    materials = { "flesh" },
    symbol = "[",
    color = "green",
    pockets = { { kind = "CONTAINER", capacity = "25 L", mass_limit = "75 kg", moves = 60 } },
    flags = {
        "BELTED", "TRADER_AVOID", "WATERPROOF", "STURDY", "OVERSIZE", "NO_TAKEOFF", "NO_REPAIR",
        "NO_SALVAGE", "ZERO_WEIGHT", "UNRESTRICTED",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        thickness = 0.1,
        portions = { { encumbrance = { 5, 10 }, coverage = 40, covers = { "torso" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_fleshpouch_0" } },
}

ccb.content.define_item {
    id = "bonespear",
    symbol = "/",
    color = "light_gray",
    name = ccb.content.plural_text("Wicked Bonespear", "Wicked Bonespears"),
    description = ccb.content.text("This is a wicked spear/halberd hybrid entirely created of bone."),
    materials = { "bone" },
    weapon_categories = { "POLEARMS", "SPEARS" },
    flags = {
        "UNBREAKABLE_MELEE",
        "REACH_ATTACK",
        "SPEAR",
        "NONCONDUCTIVE",
        "SHEATH_SPEAR",
        "NO_REPAIR",
        "MAGIC_FOCUS",
    },
    max_worn = 1,
    techniques = { "WBLOCK_2", "WIDE", "SWEEP", "BRUTAL" },
    mass = "2175 g",
    volume = "2500 ml",
    length = "183 cm",
    melee_damage = { bash = 16, stab = 36 },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_bonespear_0" } },
}

ccb.content.define_item {
    id = "druid_recurve",
    symbol = "(",
    color = "yellow",
    looks_like = "recurbow",
    name = ccb.content.text("Woodbow"),
    description = ccb.content.text("A magically conjured ornate recurve bow of solid flexible wood.  A matching conjured wooden arrow appears when you draw the string back for firing."),
    flags = {
        "FIRE_TWOHAND", "PRIMITIVE_RANGED_WEAPON", "BELTED", "UNBREAKABLE_MELEE", "NONCONDUCTIVE",
        "NO_REPAIR", "SHEATH_BOW", "NO_SALVAGE", "WATERPROOF_GUN", "NO_TURRET", "RELOAD_AND_SHOOT",
        "NEVER_JAMS",
    },
    max_worn = 1,
    min_strength = 9,
    mass = "540 g",
    length = "140 cm",
    accuracy = 1,
    pockets = { { kind = "MAGAZINE", ammunition = { arrow = 1 }, open_container = true } },
    volume = "2500 ml",
    melee_damage = { bash = 12 },
    gun = {
        skill = "archery",
        ammunition = { "arrow" },
        reload_noise_volume = 3,
        loudness = 6,
        damage = { type = "stab", amount = 9 },
        clip_size = 1,
        range = 14,
        dispersion = 950,
        durability = 6,
    },
}

ccb.content.define_item {
    id = "druid_quiver",
    name = ccb.content.text("Woodquiver"),
    description = ccb.content.text("A magically conjured quiver, marvelously light and easy to wear despite the arrows it holds."),
    mass = "260 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "10 USD",
    melee_damage = { bash = 2 },
    materials = { "leather" },
    symbol = "[",
    looks_like = "quiver",
    color = "green",
    pockets = {
        {
            ammunition = { arrow = 60, bolt = 60, arrow_orichalcum = 60 },
            weight_multiplier = 0.33333,
            volume_multiplier = 0.33333,
            moves = 20,
        },
    },
    flags = { "BELTED", "OVERSIZE", "TRADER_AVOID", "WATER_FRIENDLY", "TARDIS", "UNRESTRICTED" },
    max_worn = 1,
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 5 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "druid_quiver_plus",
    name = ccb.content.text("Woodquiver"),
    description = ccb.content.text("A magically conjured quiver, marvelously light and easy to wear despite the arrows it holds.  This is an enhanced version, created by your increased mastery of the spell."),
    mass = "260 g",
    volume = "500 ml",
    price = "65 USD",
    survival_price = "10 USD",
    melee_damage = { bash = 2 },
    materials = { "leather" },
    symbol = "[",
    looks_like = "quiver",
    color = "green",
    pockets = {
        {
            ammunition = { arrow = 120, bolt = 120, arrow_orichalcum = 120 },
            weight_multiplier = 0.16667,
            volume_multiplier = 0.16667,
            moves = 20,
        },
    },
    flags = { "BELTED", "OVERSIZE", "TRADER_AVOID", "WATER_FRIENDLY", "TARDIS", "UNRESTRICTED" },
    max_worn = 1,
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = { 3, 5 },
                coverage = 25,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_l", "leg_upper_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "druid_naturearrows1",
    copy_from = "arrow_heavy_fire_hardened_fletched",
    name = ccb.content.text("nature's arrow"),
    looks_like = "arrow_heavy_fire_hardened_fletched",
    description = ccb.content.text("A magically conjured arrow made of twisted wood."),
    ammunition = { damage = { type = "stab", penetration = 3 }, count = 1, recovery_chance = 87 },
}

ccb.content.define_item {
    id = "arrow_druid",
    copy_from = "arrow_heavy_fire_hardened_fletched",
    name = ccb.content.text("twisted wooden arrow"),
    looks_like = "arrow_heavy_fire_hardened_fletched",
    description = ccb.content.text("A arrow that looks more like it was grown than carved.  Despite that, it flies straight and true.  It explodes into a mass of entangling vegetation when it hits its target."),
    ammunition = {
        damage = { type = "stab", penetration = 2 },
        count = 1,
        recovery_chance = 83,
        effects = { "TANGLE" },
    },
}

ccb.content.define_item {
    id = "armor_frost",
    category = "armor",
    name = ccb.content.plural_text("frost armor", "frost armor"),
    description = ccb.content.text("A thin layer of magical ice, covering the entire body.  It doesn't provide much armor, instead dealing significant damage to enemies that try to attack you."),
    mass = "5000 g",
    volume = "5 L",
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    flags = {
        "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "PERSONAL", "STURDY", "NO_TAKEOFF", "NONCONDUCTIVE",
        "PADDED", "UNRESTRICTED",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 0,
        thickness = 0.5,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 8,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_armor_frost_0" } },
}

ccb.content.define_item {
    id = "aura_stoneskin",
    category = "armor",
    name = ccb.content.plural_text("stoneskin coating", "stoneskin coating"),
    description = ccb.content.text("A thin layer of shifting, almost fluid living rock, covering the entire body."),
    mass = "100 g",
    volume = "25 L",
    materials = { "stone" },
    symbol = "[",
    color = "light_gray",
    flags = { "OVERSIZE", "PERSONAL", "STURDY", "PADDED" },
    max_worn = 1,
    armor = {
        warmth = 5,
        thickness = 2.6,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 16,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "overcharge_burn_scar",
    name = ccb.content.plural_text("overcharge burn", "overcharge burns"),
    description = ccb.content.text("Ouch, this really smarts!  It'll go away soon, maybe?"),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "~",
    color = "light_red",
    materials = { "magical_material" },
    flags = { "NO_TAKEOFF", "TRADER_AVOID", "BLIND" },
    subtype_order = { "armor", "artifact" },
    armor = { portions = { { encumbrance = 18, covers = { "eyes", "mouth" } } } },
    artifact = { enchantments = { "ench_overcharge_burn_scar" } },
}

ccb.content.define_item {
    id = "protect_env",
    name = ccb.content.plural_text("aura of protection", "auras of protection"),
    description = ccb.content.text("An all-encompassing, invisible layer of magical aura that protects you from the environment."),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "o",
    color = "blue",
    materials = { "magical_material" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    armor = {
        environmental_protection = 15,
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
}

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

ccb.content.define_item {
    id = "aura_auroral_guard",
    category = "armor",
    name = ccb.content.plural_text("auroral shell", "auroral shell"),
    description = ccb.content.text("A sturdy shell that wraps your body, granting a sturdy defense."),
    mass = "400 g",
    volume = "25 L",
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    flags = { "OVERSIZE", "PERSONAL", "STURDY", "PADDED" },
    max_worn = 1,
    armor = {
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
        thickness = 3.3,
        environmental_protection = 8,
    },
}

ccb.content.define_item {
    id = "alchemist_pocket",
    category = "armor",
    name = ccb.content.text("ethereal pocket"),
    description = ccb.content.text("A small ethereal pocket located under your left arm.  You can store your potions here, but it seems it has no real limitations."),
    mass = "1 g",
    volume = "1 ml",
    materials = { "concentrated_mana" },
    symbol = "x",
    color = "magenta",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "10 L",
            mass_limit = "20 kg",
            max_item_length = "50 cm",
            moves = 60,
            weight_multiplier = 0,
        },
    },
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "BELTED",
        "WATERPROOF",
        "PADDED",
        "TARDIS",
    },
    armor = { portions = { { covers = { "arm_l" }, coverage = 0, encumbrance = 0 } } },
}

ccb.content.define_item {
    id = "flask_ethereal_rebreather",
    name = ccb.content.plural_text("air bubble", "air bubble"),
    description = ccb.content.text("Now you can breath under water, like a fish."),
    category = "clothing",
    mass = "0 g",
    materials = { "concentrated_mana" },
    volume = "1 ml",
    symbol = "0",
    color = "white",
    flags = {
        "WATER_FRIENDLY", "SEMITANGIBLE", "OVERSIZE", "AURA", "ZERO_WEIGHT", "NO_TAKEOFF",
        "NONCONDUCTIVE", "TRADER_AVOID", "REBREATHER", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 25,
        portions = { { encumbrance = 0, coverage = 75, covers = { "head", "mouth", "eyes" } } },
    },
}

ccb.content.define_item {
    id = "thought_shield_item",
    name = ccb.content.plural_text("thought shields", "thought shields"),
    description = ccb.content.text("These two tiny shields on your temples should protect your mind from outside influences"),
    category = "clothing",
    mass = "0 g",
    materials = { "concentrated_mana" },
    volume = "1 ml",
    symbol = "0",
    color = "white",
    flags = {
        "WATER_FRIENDLY", "SEMITANGIBLE", "OVERSIZE", "AURA", "ZERO_WEIGHT", "NO_TAKEOFF",
        "NONCONDUCTIVE", "TRADER_AVOID", "PSYSHIELD_PARTIAL", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS",
        "MAGICAL_MIND_PROTECTION",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 1,
        portions = { { encumbrance = 0, coverage = 75, covers = { "head", "mouth", "eyes" } } },
    },
}

ccb.content.define_item {
    id = "thought_shield_plus_item",
    name = ccb.content.plural_text("thought suit", "thought suit"),
    description = ccb.content.text("The tiny shields all over your body should protect your mind from outside influences and your body from being moved by outside magic"),
    category = "clothing",
    mass = "0 g",
    materials = { "concentrated_mana" },
    volume = "1 ml",
    symbol = "0",
    color = "white",
    flags = {
        "WATER_FRIENDLY", "SEMITANGIBLE", "OVERSIZE", "AURA", "ZERO_WEIGHT", "NO_TAKEOFF",
        "NONCONDUCTIVE", "TRADER_AVOID", "PSYSHIELD_PARTIAL", "PORTAL_PROOF", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS", "MAGICAL_MIND_PROTECTION",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 0,
                coverage = 75,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "elastic_potential_energy",
    category = "spare_parts",
    price = "120 USD",
    survival_price = "2 cent",
    name = ccb.content.plural_text("elastic potential energy", "elastic potential energy"),
    symbol = "=",
    color = "yellow",
    description = ccb.content.text("Some free-floating elastic potential energy."),
    flags = { "TRADER_AVOID", "ZERO_WEIGHT" },
    materials = { "battery" },
    volume = "0 ml",
    ammunition = { effects = { "COOKOFF" }, type = "elastic_potential_energy", count = 100 },
}

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

ccb.content.define_item {
    id = "item_druid_goodberry",
    name = ccb.content.plural_text("handful of goodberries", "handfuls of goodberries"),
    description = ccb.content.text("A set of magical berries.  They look absolutely delicious."),
    mass = "144 g",
    color = "pink",
    symbol = "%",
    price = "1 USD 78 cent",
    survival_price = "1 USD",
    materials = { "fruit" },
    volume = "250 ml",
    flags = { "EDIBLE_FROZEN", "TRADER_AVOID", "RELIC_PINK" },
    comestible = {
        shelf_life = "24 hours",
        kind = "FOOD",
        quench = 3,
        calories = 1500,
        fun = 6,
        vitamins = {
            { id = "vitC", amount = 50 },
            { id = "iron", amount = 50 },
            { id = "calcium", amount = 50 },
            { id = "fruit_allergen", amount = 1 },
        },
        on_consume = "eat_druid_goodberry",
    },
}
