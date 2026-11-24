local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_inventor",
    category = "armor",
    name = ccb.content.plural_text("helmet of creative juices", "helmets of creative juices"),
    description = ccb.content.text("The helmet of creative juices may look like a child's homemade toy, but its effects when turned on are real enough.  While wearing it, your thoughts are buffered from the outside world by a soft white noise that varies from person to person as to what they actually hear.  Some hear the ocean, a fan blowing or paper crumpling.  Whatever the sound, it helps you to think faster and more creatively than before."),
    mass = "1383 g",
    volume = "1750 ml",
    materials = { "mc_steel", "plastic" },
    symbol = "[",
    looks_like = "hat_hard",
    color = "green",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_MEDIUM" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    techniques = { "WBLOCK_1" },
    flags = {
        "MORPHIC", "WATERPROOF", "STURDY", "PADDED", "TRADER_AVOID", "PSYSHIELD_PARTIAL", "MUNDANE",
        "INVENTOR_CRAFTED",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = { "battery" } },
    armor = {
        warmth = 20,
        thickness = 1.1,
        portions = {
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                encumbrance_modifiers = { "NONE" },
                coverage = 50,
                covers = { "head" },
                subparts = { "head_ear_l", "head_ear_r" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_helmet_inventor_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "helmet_inventor_on",
            message = ccb.content.text("You turn on the %s."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "helmet_inventor_on",
    copy_from = "helmet_inventor",
    name = ccb.content.plural_text("helmet of creative juices (on)", "helmets of creative juices (on)"),
    revert_to = "helmet_inventor",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "7 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "helmet_inventor",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
        },
    },
}

ccb.content.define_item {
    id = "inventor_leg_weight",
    category = "armor",
    name = ccb.content.plural_text("leg weight suspension system", "leg weight suspension systems"),
    description = ccb.content.text("Compact leg attachments that distribute your weight onto the ground nearby using some kind of force.  It makes you leave giant spherical footprints, but makes carrying heavy weight much easier."),
    mass = "1657 g",
    volume = "1500 ml",
    materials = { "mc_steel", "copper", "leather" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_red",
    flags = { "MORPHIC", "STURDY", "OUTER", "BELTED", "MUNDANE", "INVENTOR_CRAFTED" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 50,
                subparts = { "torso_waist" },
                encumbrance = 2,
                materials = { { id = "leather", coverage = 100, thickness = 2 } },
            },
            {
                materials = {
                    { id = "mc_steel", coverage = 100, thickness = 0.6 },
                    { id = "copper", coverage = 100, thickness = 0.6 },
                },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 20,
                encumbrance = 7,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_inventor_leg_weight_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "inventor_leg_weight_on",
            message = ccb.content.text("You turn on the %s."),
        },
    },
}

ccb.content.define_item {
    id = "inventor_backpack",
    copy_from = "molle_medium_rucksack",
    name = "vacuum backpack",
    description = "A backpack with lot of light aluminum bars inside that hold a perfect vacuum, making the backpack much lighter than it should be.",
    symbol = "[",
    color = "green",
    looks_like = "molle_medium_rucksack",
    flags = { "MORPHIC", "BELTED", "WATER_FRIENDLY", "MUNDANE", "INVENTOR_CRAFTED" },
    materials = { "nylon", "aluminum", "plastic" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "50 L",
            mass_limit = "140 kg",
            max_item_length = "50 cm",
            magazine_well = "5 L",
            moves = 300,
            volume_encumbrance = 0.5,
            weight_multiplier = 0.35,
        },
        {
            kind = "CONTAINER",
            capacity = "3250 ml",
            mass_limit = "4 kg",
            max_item_length = "30 cm",
            moves = 500,
            description = "Pouch sized for a hydration pack.",
        },
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "6 kg",
            max_item_length = "120 cm",
            min_item_length = "20 cm",
            moves = 150,
            ripoff = 2,
            extra_encumbrance = 3,
            holster = true,
            transparent = true,
            description = "Attached with a carabiner or strap.",
            activity_noise = { volume = 8, chance = 10 },
        },
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "6 kg",
            max_item_length = "120 cm",
            min_item_length = "20 cm",
            moves = 150,
            ripoff = 2,
            extra_encumbrance = 3,
            holster = true,
            transparent = true,
            description = "Attached with a carabiner or strap.",
            activity_noise = { volume = 8, chance = 10 },
        },
        {
            kind = "CONTAINER",
            capacity = "5 L",
            mass_limit = "4 kg",
            max_item_length = "150 cm",
            min_item_length = "60 cm",
            moves = 200,
            ripoff = 3,
            extra_encumbrance = 10,
            holster = true,
            transparent = true,
            description = "Tucked between your back and the backpack.",
        },
    },
    use_actions = {
        { kind = "attach_molle", size = 8 },
        { kind = "detach_molle" },
    },
    armor = {
        thickness = 2,
        warmth = 10,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 80,
                volume_encumbrance = 0.15,
                encumbrance = 6,
            },
        },
    },
}

ccb.content.define_item {
    id = "inventor_leg_weight_on",
    copy_from = "inventor_leg_weight",
    name = ccb.content.plural_text("leg weight suspension system", "leg weight suspension systems"),
    revert_to = "inventor_leg_weight",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "5 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            target = "inventor_leg_weight",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
        },
    },
}

ccb.content.define_item {
    id = "inventor_jump_boots",
    category = "armor",
    name = ccb.content.plural_text("jump driver", "jump drivers"),
    description = ccb.content.text("Heavily mechanized boots with small integrated battery slot inside.  Upon activation make you jump higher and farther."),
    mass = "1657 g",
    volume = "1500 ml",
    materials = { "leather", "kevlar", "rubber", "mc_steel" },
    symbol = "[",
    looks_like = "legguard_hard",
    color = "light_red",
    flags = { "MORPHIC", "STURDY", "OUTER", "SOFT", "MUNDANE", "INVENTOR_CRAFTED" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_MEDIUM" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 150, ammo_types = "battery" },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.25 },
                    { id = "kevlar", coverage = 100, thickness = 1.25 },
                    { id = "mc_steel", coverage = 5, thickness = 1.25 },
                },
                encumbrance = 7,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 0.1 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
                coverage = 100,
            },
        },
    },
    use_actions = { { kind = "cast_spell", spell = "jump_boots_leap", no_fail = true, level = 0 } },
}

ccb.content.define_item {
    id = "aura_force",
    category = "armor",
    name = ccb.content.plural_text("force shield", "force shields"),
    description = ccb.content.text("A small, thin torus with a huge battery case, and a belt.  You can activate it to emit a field that covers your whole body which will decelerate all objects it touches."),
    mass = "270 g",
    volume = "660 ml",
    materials = { "aluminum", "leather", "mc_steel", "copper" },
    symbol = "[",
    color = "blue",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_LIGHT", "BATTERY_MEDIUM" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    techniques = { "WBLOCK_1" },
    flags = {
        "MORPHIC",
        "WATERPROOF",
        "STURDY",
        "SOFT",
        "TRADER_AVOID",
        "BELTED",
        "MUNDANE",
        "INVENTOR_CRAFTED",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = {
        warmth = 0,
        thickness = 3,
        portions = {
            {
                covers = { "torso" },
                coverage = 50,
                subparts = { "torso_waist" },
                encumbrance = 2,
                materials = { { id = "leather", coverage = 100, thickness = 2 } },
            },
            {
                materials = { { id = "aluminum", coverage = 100, thickness = 0.7 } },
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                coverage = 25,
                encumbrance = 7,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_aura_force_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "aura_force_on",
            need_charges = 1,
            message = ccb.content.text("The torus starts to emit invisible waves."),
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "aura_force_on",
    copy_from = "aura_force",
    name = ccb.content.plural_text("force shield (on)", "force shields (on)"),
    revert_to = "aura_force",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "250 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "aura_force",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("Torus stops working."),
        },
    },
}

ccb.content.define_item {
    id = "vision_halo",
    category = "armor",
    name = ccb.content.plural_text("electronic halo", "electronic halos"),
    description = ccb.content.text("A compact crown boasting a built-in processor and several tiny projectors that beam information directly onto your eye.  It's equipped with enough internal storage and RAM to support a basic AI.  Along with multiple cameras providing 360-degree coverage, this setup enables you to tackle tasks far more efficiently than before.  Plus, there's a battle mode that activates an energy-intensive radiation detector."),
    mass = "155 g",
    volume = "490 ml",
    materials = { "aluminum", "copper" },
    symbol = "[",
    looks_like = "glasses_safety",
    color = "light_gray",
    flags = {
        "MORPHIC", "WATCH", "ALARMCLOCK", "SKINTIGHT", "WATER_BREAK", "CALORIES_INTAKE", "ELECTRONIC",
        "MUNDANE", "INVENTOR_CRAFTED",
    },
    faults = { { group = "electronic_general" } },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_ULTRA_LIGHT", "BATTERY_LIGHT" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "light_minus_disposable_cell",
        },
        {
            kind = "E_FILE_STORAGE",
            rigid = true,
            capacity = "1 ml",
            mass_limit = "1 g",
            weight_multiplier = 0.0,
            memory_capacity = "2 TB",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = {
        thickness = 0.1,
        portions = { { coverage = 10, encumbrance = 1, covers = { "head" }, subparts = { "head_crown" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_vision_halo_0" } },
    use_actions = {
        "CAMERA",
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "transform",
            target = "vision_halo_on",
            message = ccb.content.text("You turn on the %s."),
            menu_text = ccb.content.text("Turn on a battle mode"),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "vision_halo_on",
    category = "armor",
    name = ccb.content.plural_text("electronic halo (on)", "electronic halos (on)"),
    copy_from = "vision_halo",
    revert_to = "vision_halo",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "500 W" },
    armor = {},
    use_actions = {
        "CAMERA",
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        {
            kind = "transform",
            target = "vision_halo",
            message = ccb.content.text("You turn off the %s."),
            menu_text = ccb.content.text("Turn off battle mode"),
            need_charges = 0,
        },
    },
}

-- Contain a single big item.  No weight reduction.
ccb.content.define_item {
    id = "inventor_carry_hands",
    copy_from = "molle_medium_rucksack",
    name = ccb.content.plural_text("Carry-Hands", "Carry-Hands"),
    description = ccb.content.text("A passive exoskeleton consisting of two metal arms ready to hold anything.  The arms refuse to hold more than a single thing at a time and won't make it easier to carry heavy items."),
    materials = { "steel" },
    symbol = "[",
    looks_like = "clamp",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "5000 L",
            mass_limit = "5000 kg",
            max_item_length = "5000 cm",
            moves = 100,
            holster = true,
        },
    },
    flags = { "MORPHIC", "BELTED", "WATER_FRIENDLY", "MUNDANE", "INVENTOR_CRAFTED" },
    armor = {
        warmth = 0,
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 50 },
                coverage = 20,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "inventor_fists",
    symbol = "3",
    color = "light_gray",
    name = ccb.content.text("heavy CQC system"),
    description = ccb.content.text("This robust system begins at your hands, where it features a squarish steel frame enhanced with strategic protrusions to amplify impact damage by focusing the point of contact.  It extends along your forearms with thick, hardened steel shields protecting both your limbs and the underlying hydraulic mechanisms.  Aluminum tubes channel these hydraulics up into your upper arms, culminating at your back where the central hub for the hydraulic servos is located.  While the system recovers some energy with each movement, its substantial weight and bulk significantly limit the use of your hands for anything else."),
    materials = { "aluminum", "mc_steel" },
    volume = "11678 ml",
    mass = "3970 g",
    flags = { "MORPHIC", "DURABLE_MELEE", "PADDED", "MUNDANE", "INVENTOR_CRAFTED", "PROVIDES_TECHNIQUES" },
    techniques = { "WBLOCK_3", "BRUTAL", "SWEEP" },
    melee_damage = { bash = 28 },
    armor = {
        thickness = 1,
        portions = {
            {
                materials = { { id = "mc_steel", coverage = 100, thickness = 5 } },
                encumbrance = 7,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r", "hand_wrist_l", "hand_wrist_r" },
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "aluminum", coverage = 25, thickness = 1.0 },
                    { id = "mc_steel", coverage = 100, thickness = 2.5 },
                },
                encumbrance = 7,
                coverage = 50,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r", "arm_elbow_l", "arm_elbow_r" },
                breathability = "GOOD",
            },
            {
                materials = { { id = "aluminum", coverage = 100, thickness = 1.0 } },
                encumbrance = 7,
                coverage = 25,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r", "arm_shoulder_l", "arm_shoulder_r" },
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "aluminum", coverage = 100, thickness = 1.0 },
                    { id = "mc_steel", coverage = 100, thickness = 0.3 },
                },
                encumbrance = 11,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_upper" },
                breathability = "GOOD",
            },
        },
    },
}

ccb.content.define_item {
    id = "inventor_electric_fist",
    symbol = "3",
    color = "light_gray",
    looks_like = "gauntlets_chitin",
    name = ccb.content.plural_text("\"Overture\"", "\"Overtures\""),
    description = ccb.content.text("A bulky mess of coils and wires that goes from your fists to your shoulder, and a slot for a small battery behind the elbow.  Upon activation it will start to emit huge electrical charges, frying your enemies when attacked in melee."),
    materials = { "aluminum", "copper" },
    volume = "155 ml",
    mass = "300 g",
    length = "25 cm",
    melee_damage = { electric = 10 },
    max_worn = 1,
    flags = { "MORPHIC", "TRADER_AVOID", "MUNDANE", "INVENTOR_CRAFTED" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_ULTRA_LIGHT", "BATTERY_LIGHT" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "light_minus_disposable_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = {
        thickness = 0.3,
        portions = { { encumbrance = 4, coverage = 45, covers = { "arm_l", "arm_r" } } },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_inventor_electric_fist_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "inventor_electric_fist_act",
            message = ccb.content.text("You turn on the %s."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "inventor_fists_plus",
    copy_from = "inventor_fists",
    name = "advanced heavy CQC system",
    description = "An advanced version of the heavy CQC system.  It contain a self-recharging pneumatic tank that slowly builds pressure that you can use in a fight.",
    symbol = "3",
    color = "light_gray",
    techniques = { "WBLOCK_3", "BRUTAL", "SWEEP", "CQB_BRUTAL" },
    pockets = {
        {
            kind = "MAGAZINE",
            airtight = true,
            ammunition = { oxygen = 3 },
        },
    },
    tool = {},
    armor = {},
    artifact = {
        charge = { recharge_type = "periodic", interval = "1 m", regenerate_ammo = true },
    },
    subtype_order = { "tool", "armor", "artifact" },
}

ccb.content.define_item {
    id = "inventor_electric_fist_act",
    copy_from = "inventor_electric_fist",
    symbol = "3",
    color = "light_gray",
    name = ccb.content.plural_text("\"Overture\" (on)", "\"Overtures\" (on)"),
    revert_to = "inventor_electric_fist",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "50 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "inventor_electric_fist",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
        },
    },
}

ccb.content.define_item {
    id = "wolf_mask",
    category = "clothing",
    name = ccb.content.plural_text("wolf's mask", "wolf's masks"),
    description = ccb.content.text("A huge, respirator-like mask covering the whole head except for the right eye.  Upon activation it protects you lungs from toxic gases as well as improving your breathing and stamina."),
    mass = "405 g",
    volume = "1479 ml",
    materials = { "aluminum" },
    symbol = "[",
    looks_like = "mask_gas",
    color = "dark_gray",
    flags = { "MORPHIC", "MUNDANE", "INVENTOR_CRAFTED" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_ULTRA_LIGHT", "BATTERY_LIGHT" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "light_minus_disposable_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = {
        thickness = 0.4,
        environmental_protection = 4,
        portions = {
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 3 },
            {
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 7,
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_wolf_mask_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "wolf_mask_act",
            message = ccb.content.text("You turn on the %s."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

ccb.content.define_item {
    id = "wolf_mask_act",
    copy_from = "wolf_mask",
    name = ccb.content.plural_text("wolf's mask (on)", "wolf's masks (on)"),
    revert_to = "wolf_mask",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "5 W" },
    armor = { environmental_protection = 25 },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "wolf_mask",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You turn off the %s."),
        },
    },
}

ccb.content.define_item {
    id = "magnetic_holster",
    name = ccb.content.plural_text("magnetic holster", "magnetic holsters"),
    looks_like = "shoulder_strap",
    description = ccb.content.text("A long strap with small, powerful gravity field emitters on the surface.  Allows one to strap and carry almost anything."),
    mass = "250 g",
    volume = "250 ml",
    materials = { "plastic", "aluminum" },
    symbol = "[",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            holster = true,
            rigid = true,
            capacity = "20 L",
            mass_limit = "15 kg",
            max_item_length = "300 cm",
            moves = 50,
        },
    },
    flags = { "MORPHIC", "BELTED", "OVERSIZE", "MUNDANE", "INVENTOR_CRAFTED", "TARDIS" },
    armor = {
        sided = true,
        thickness = 1,
        portions = { { encumbrance = 1, coverage = 5, covers = { "torso" }, subparts = { "torso_upper" } } },
    },
    use_actions = { { kind = "holster" } },
}

ccb.content.define_item {
    id = "crafting_assistant",
    category = "armor",
    name = ccb.content.plural_text("Crafting Assistant Robot", "Crafting Assistant Robots"),
    description = ccb.content.text("A bulky wearable robot that significantly helps with all crafting tasks while powered.  It has some strange obsession with frequently taking apart and reassembling its own arms and its programming is far too focused on creation and disassembly for it to have any combat or destructive use."),
    mass = "7500 g",
    volume = "5550 ml",
    looks_like = "bot_nursebot",
    materials = { "steel", "aluminum" },
    symbol = "[",
    color = "light_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            airtight = true,
            watertight = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
        },
    },
    flags = {
        "MORPHIC", "BELTED", "ALLOWS_NATURAL_ATTACKS", "WATER_FRIENDLY", "OVERSIZE", "ELECTRONIC",
        "INVENTOR_CRAFTED",
    },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = { "battery" } },
    armor = { portions = { { coverage = 50, covers = { "torso" }, subparts = { "torso_hanging_back" } } } },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_crafting_assistant_0" } },
    use_actions = {
        {
            kind = "transform",
            target = "crafting_assistant_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
            message = ccb.content.text("The assistant deploys its new arms, ready to help with crafting."),
        },
    },
}

ccb.content.define_item {
    id = "crafting_assistant_on",
    copy_from = "crafting_assistant",
    name = ccb.content.plural_text("Crafting Assistant Robot (on)", "Crafting Assistant Robot (on)"),
    revert_to = "crafting_assistant",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor" },
    tool = { power_draw = "1550 W" },
    armor = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "crafting_assistant",
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("The assistant retracts and recycles its arms."),
        },
    },
}

ccb.content.define_item {
    id = "xedra_inventor_damage_reversal_device",
    name = "Injury Reset Device",
    description = "A bulky wristwatch that attaches to your arm.  Using it will revert the last injury that you have suffered.  Also tells the time.",
    symbol = "[",
    color = "light_gray",
    category = "armor",
    looks_like = "wristwatch",
    mass = "100 g",
    volume = "50 ml",
    flags = {
        "MORPHIC",
        "WATCH",
        "ALARMCLOCK",
        "BELTED",
        "ALLOWS_NATURAL_ATTACKS",
        "WATER_FRIENDLY",
        "OVERSIZE",
        "ELECTRONIC",
        "INVENTOR_CRAFTED",
        "STURDY",
        "PADDED",
    },
    materials = { "kevlar", "mc_steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            capacity = "20 L",
            mass_limit = "20 kg",
            default_magazine = "medium_battery_cell",
            rigid = true,
            watertight = true,
            airtight = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
        },
    },
    faults = {
        { group = "electronic_general" },
    },
    tool = {
        charges_per_use = 300,
        ammo_types = { "battery" },
    },
    armor = {
        sided = true,
        portions = {
            {
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                coverage = 50,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}
