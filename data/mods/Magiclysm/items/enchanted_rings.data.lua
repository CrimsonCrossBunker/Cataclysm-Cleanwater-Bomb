local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mring_copper",
    abstract = true,
    name = ccb.content.text_without_extraction("copper magic ring"),
    description = ccb.content.text_without_extraction("A generic copper magic ring."),
    mass = "4 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "20 USD",
    materials = { "copper" },
    symbol = "[",
    color = "light_red",
    looks_like = "copper_ring",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "SKINTIGHT", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        warmth = 0,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mring_silver",
    abstract = true,
    name = ccb.content.text_without_extraction("silver magic ring"),
    description = ccb.content.text_without_extraction("A generic silver magic ring."),
    mass = "5 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "20 USD",
    materials = { "silver" },
    symbol = "[",
    color = "light_gray",
    looks_like = "silver_ring",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "SKINTIGHT", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        warmth = 0,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mring_gold",
    abstract = true,
    name = ccb.content.text_without_extraction("gold magic ring"),
    description = ccb.content.text_without_extraction("A generic gold magic ring."),
    mass = "9 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "20 USD",
    materials = { "gold" },
    symbol = "[",
    color = "yellow",
    looks_like = "gold_ring",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "SKINTIGHT", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        warmth = 0,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mring_platinum",
    abstract = true,
    name = ccb.content.text_without_extraction("platinum magic ring"),
    description = ccb.content.text_without_extraction("A generic platinum magic ring"),
    mass = "11 g",
    volume = "1 ml",
    price = "50 USD",
    survival_price = "20 USD",
    materials = { "platinum" },
    symbol = "[",
    color = "light_gray",
    looks_like = "platinum_ring",
    flags = { "WATER_FRIENDLY", "ALLOWS_NATURAL_ATTACKS", "ONE_PER_LAYER", "SKINTIGHT", "UNRESTRICTED" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        sided = true,
        warmth = 0,
        portions = {
            {
                encumbrance = 0,
                coverage = 0,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_l", "hand_fingers_r" },
                rigid_only = true,
            },
        },
    },
}

ccb.content.define_item {
    id = "mring_wizardry_minor",
    copy_from = "mring_copper",
    name = ccb.content.plural_text("minor ring of wizardry", "minor rings of wizardry"),
    description = ccb.content.text("A thin copper band ring, engraved with a single sealed scroll.  Increases mana capacity slightly."),
    survival_price = "1000 USD",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_wizardry_minor_0" } },
}

ccb.content.define_item {
    id = "mring_wizardry_lesser",
    copy_from = "mring_silver",
    survival_price = "2000 USD",
    name = ccb.content.plural_text("lesser ring of wizardry", "lesser rings of wizardry"),
    description = ccb.content.text("A thin silver band ring, engraved with two sealed scrolls.  Increases mana capacity somewhat."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_wizardry_lesser_0" } },
}

ccb.content.define_item {
    id = "mring_wizardry_moderate",
    copy_from = "mring_gold",
    name = ccb.content.plural_text("ring of wizardry", "rings of wizardry"),
    survival_price = "4000 USD",
    description = ccb.content.text("A thin gold band ring, engraved with a bound book.  Increases mana capacity moderately."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_wizardry_moderate_0" } },
}

ccb.content.define_item {
    id = "mring_wizardry_greater",
    copy_from = "mring_platinum",
    name = ccb.content.plural_text("greater ring of wizardry", "greater rings of wizardry"),
    survival_price = "8000 USD",
    description = ccb.content.text("A thin platinum band ring, engraved with two bound books.  Increases mana capacity greatly."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_wizardry_greater_0" } },
}

ccb.content.define_item {
    id = "mring_blades_lesser",
    copy_from = "mring_silver",
    name = ccb.content.plural_text("ring of blades", "rings of blades"),
    survival_price = "300 USD",
    description = ccb.content.text("An ornate silver ring engraved with daggers that conjures three mundane throwing knives on activation."),
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { crystallized_mana = 5 } } },
    inheritance = { add = { flags = { "NO_UNLOAD", "NO_RELOAD" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1 },
    armor = {},
    artifact = { charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true } },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "conj_throwing_blade3",
            no_fail = true,
            level = 1,
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "mring_dodge_bonus_1",
    copy_from = "mring_silver",
    name = ccb.content.plural_text("eel ring", "eel rings"),
    survival_price = "1500 USD",
    description = ccb.content.text("A thin silver band ring, depicting an eel coiled on itself.  Allows you to dodge an extra attack per turn."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_dodge_bonus_1_0" } },
}

ccb.content.define_item {
    id = "mring_dodge_bonus_2",
    copy_from = "mring_gold",
    survival_price = "3000 USD",
    name = ccb.content.plural_text("bicephalous eel ring", "bicephalous eel rings"),
    description = ccb.content.text("A thin gold band ring, depicting a bicephalous eel coiled on itself.  Allows you to dodge two extra attacks per turn."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_dodge_bonus_2_0" } },
}

ccb.content.define_item {
    id = "mring_strength_1",
    copy_from = "mring_copper",
    survival_price = "1000 USD",
    name = ccb.content.plural_text("ring of strength +1", "rings of strength +1"),
    description = ccb.content.text("A copper ring that makes you a little stronger when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_strength_1_0" } },
}

ccb.content.define_item {
    id = "mring_strength_2",
    copy_from = "mring_silver",
    survival_price = "2000 USD",
    name = ccb.content.plural_text("ring of strength +2", "rings of strength +2"),
    description = ccb.content.text("A silver ring that makes you a good bit stronger when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_strength_2_0" } },
}

ccb.content.define_item {
    id = "mring_strength_3",
    copy_from = "mring_gold",
    survival_price = "4000 USD",
    name = ccb.content.plural_text("ring of strength +3", "rings of strength +3"),
    description = ccb.content.text("A golden ring that makes you surprisingly stronger when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_strength_3_0" } },
}

ccb.content.define_item {
    id = "mring_strength_4",
    copy_from = "mring_platinum",
    survival_price = "6000 USD",
    name = ccb.content.plural_text("ring of strength +4", "rings of strength +4"),
    description = ccb.content.text("A platinum ring that makes you much stronger when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_strength_4_0" } },
}

ccb.content.define_item {
    id = "mring_dexterity_1",
    copy_from = "mring_copper",
    survival_price = "1000 USD",
    name = ccb.content.plural_text("ring of dexterity +1", "rings of dexterity +1"),
    description = ccb.content.text("A copper ring that makes you a little more agile when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_dexterity_1_0" } },
}

ccb.content.define_item {
    id = "mring_dexterity_2",
    copy_from = "mring_silver",
    survival_price = "2000 USD",
    name = ccb.content.plural_text("ring of dexterity +2", "rings of dexterity +2"),
    description = ccb.content.text("A silver ring that makes you a good bit more agile when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_dexterity_2_0" } },
}

ccb.content.define_item {
    id = "mring_dexterity_3",
    copy_from = "mring_gold",
    survival_price = "4000 USD",
    name = ccb.content.plural_text("ring of dexterity +3", "rings of dexterity +3"),
    description = ccb.content.text("A golden ring that makes you surprisingly more agile when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_dexterity_3_0" } },
}

ccb.content.define_item {
    id = "mring_dexterity_4",
    copy_from = "mring_platinum",
    survival_price = "6000 USD",
    name = ccb.content.plural_text("ring of dexterity +4", "rings of dexterity +4"),
    description = ccb.content.text("A platinum ring that makes you much more agile when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_dexterity_4_0" } },
}

ccb.content.define_item {
    id = "mring_intelligence_1",
    copy_from = "mring_copper",
    survival_price = "1000 USD",
    name = ccb.content.plural_text("ring of intelligence +1", "rings of intelligence +1"),
    description = ccb.content.text("A copper ring that makes you a little more intelligent when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_intelligence_1_0" } },
}

ccb.content.define_item {
    id = "mring_intelligence_2",
    copy_from = "mring_silver",
    survival_price = "2000 USD",
    name = ccb.content.plural_text("ring of intelligence +2", "rings of intelligence +2"),
    description = ccb.content.text("A silver ring that makes you a good bit more intelligent when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_intelligence_2_0" } },
}

ccb.content.define_item {
    id = "mring_intelligence_3",
    copy_from = "mring_gold",
    survival_price = "4000 USD",
    name = ccb.content.plural_text("ring of intelligence +3", "rings of intelligence +3"),
    description = ccb.content.text("A golden ring that makes you surprisingly more intelligent when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_intelligence_3_0" } },
}

ccb.content.define_item {
    id = "mring_intelligence_4",
    copy_from = "mring_platinum",
    survival_price = "6000 USD",
    name = ccb.content.plural_text("ring of intelligence +4", "rings of intelligence +4"),
    description = ccb.content.text("A platinum ring that makes you much more intelligent when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_intelligence_4_0" } },
}

ccb.content.define_item {
    id = "mring_perception_1",
    copy_from = "mring_copper",
    survival_price = "1000 USD",
    name = ccb.content.plural_text("ring of perception +1", "rings of perception +1"),
    description = ccb.content.text("A copper ring that makes you a little more perceptive when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_perception_1_0" } },
}

ccb.content.define_item {
    id = "mring_perception_2",
    copy_from = "mring_silver",
    survival_price = "2000 USD",
    name = ccb.content.plural_text("ring of perception +2", "rings of perception +2"),
    description = ccb.content.text("A silver ring that makes you a good bit more perceptive when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_perception_2_0" } },
}

ccb.content.define_item {
    id = "mring_perception_3",
    copy_from = "mring_gold",
    survival_price = "4000 USD",
    name = ccb.content.plural_text("ring of perception +3", "rings of perception +3"),
    description = ccb.content.text("A golden ring that makes you eye-openingly more perceptive when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_perception_3_0" } },
}

ccb.content.define_item {
    id = "mring_perception_4",
    copy_from = "mring_platinum",
    survival_price = "6000 USD",
    name = ccb.content.plural_text("ring of perception +4", "rings of perception +4"),
    description = ccb.content.text("A platinum ring that makes you much more perceptive when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_perception_4_0" } },
}

ccb.content.define_item {
    id = "mring_speed_3",
    copy_from = "mring_copper",
    survival_price = "1700 USD",
    name = ccb.content.plural_text("ring of speed +3", "rings of speed +3"),
    description = ccb.content.text("A copper ring that makes you a little faster when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_speed_3_0" } },
}

ccb.content.define_item {
    id = "mring_speed_5",
    copy_from = "mring_silver",
    survival_price = "2500 USD",
    name = ccb.content.plural_text("ring of speed +5", "rings of speed +5"),
    description = ccb.content.text("A silver ring that makes you a good bit faster when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_speed_5_0" } },
}

ccb.content.define_item {
    id = "mring_speed_7",
    copy_from = "mring_gold",
    survival_price = "5000 USD",
    name = ccb.content.plural_text("ring of speed +7", "rings of speed +7"),
    description = ccb.content.text("A golden ring that makes you quite hasty when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_speed_7_0" } },
}

ccb.content.define_item {
    id = "mring_speed_10",
    copy_from = "mring_platinum",
    survival_price = "8000 USD",
    name = ccb.content.plural_text("ring of speed +10", "rings of speed +10"),
    description = ccb.content.text("A platinum ring that makes you much faster when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_speed_10_0" } },
}

ccb.content.define_item {
    id = "mring_protection_2",
    copy_from = "mring_copper",
    survival_price = "1000 USD",
    name = ccb.content.plural_text("ring of protection +2", "rings of protection +2"),
    description = ccb.content.text("A copper ring that reduces some of the force of damage you take when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_protection_2_0" } },
}

ccb.content.define_item {
    id = "mring_protection_4",
    copy_from = "mring_silver",
    survival_price = "2000 USD",
    name = ccb.content.plural_text("ring of protection +4", "rings of protection +4"),
    description = ccb.content.text("A silver ring that appreciably reduces some of the force of damage you take when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_protection_4_0" } },
}

ccb.content.define_item {
    id = "mring_protection_6",
    copy_from = "mring_gold",
    survival_price = "4000 USD",
    name = ccb.content.plural_text("ring of protection +6", "rings of protection +6"),
    description = ccb.content.text("A golden ring that greatly reduces some of the force of damage you take when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_protection_6_0" } },
}

ccb.content.define_item {
    id = "mring_protection_8",
    copy_from = "mring_platinum",
    survival_price = "8000 USD",
    name = ccb.content.plural_text("ring of protection +8", "rings of protection +8"),
    description = ccb.content.text("A platinum ring that vastly reduces some of the force of damage you take when you wear it."),
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_mring_protection_8_0" } },
}

ccb.content.define_item {
    id = "storage_ring_lesser",
    copy_from = "mring_platinum",
    name = ccb.content.plural_text("lesser storage ring", "lesser storage rings"),
    price = "3000 USD",
    length = "2 cm",
    survival_price = "1000 USD",
    description = ccb.content.text("A glistening ring holding a small dimensional space inside.  Can store only a little but you can draw items instantly."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "1 L",
            mass_limit = "1 kg",
            max_item_length = "35 cm",
            moves = 1,
            holster = true,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0.0,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stick what into your ring"),
            message = ccb.content.text("You tuck your %s into your %s"),
        },
    },
}

ccb.content.define_item {
    id = "storage_ring_greater",
    copy_from = "mring_platinum",
    name = ccb.content.plural_text("greater storage ring", "greater storage rings"),
    price = "9000 USD",
    length = "2 cm",
    survival_price = "1750 USD",
    description = ccb.content.text("A glistening ring holding a small dimensional space inside.  Capable of storing a medium-sized weapon you can draw instantly."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "2 L",
            mass_limit = "2500 g",
            max_item_length = "100 cm",
            moves = 1,
            holster = true,
            weight_multiplier = 0.0,
            volume_multiplier = 0.0,
            volume_encumbrance = 0.0,
        },
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Stick what into your ring"),
            message = ccb.content.text("You tuck your %s into your %s"),
        },
    },
}

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
