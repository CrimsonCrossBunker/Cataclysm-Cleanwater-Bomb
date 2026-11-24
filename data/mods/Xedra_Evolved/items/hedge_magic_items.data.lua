local ccb = require("ccb")

ccb.content.define_item {
    id = "item_hedge_make_plants_grow",
    name = ccb.content.plural_text("life of the crops", "life of the crops"),
    mass = "0 g",
    color = "green",
    flags = { "TRADER_AVOID", "ZERO_WEIGHT", "FERTILIZER" },
    symbol = "°",
    description = ccb.content.text("Use this to fertilize your crops."),
    materials = { "powder" },
    volume = "0 ml",
    category = "chems",
    comestible = { kind = "FOOD", quench = -10, healthy = -2, fun = -15 },
}

ccb.content.define_item {
    id = "item_hedge_see_fae_necklace",
    name = ccb.content.plural_text("Faesight Charm", "Faesight Charms"),
    description = ccb.content.text("A small sack with herbs in it to warn you if the Fair Folk are nearby.  You had better wear it under your clothes.  You wouldn't want them to know you're avoiding them.  It's awaiting you to speak the final words of the charm and activate it."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { glamour_charge = 360 } } },
    mass = "100 g",
    volume = "150 ml",
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "leather", "veggy" },
    color = "green",
    symbol = ",",
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "MUNDANE", "HEDGE_ENCHANTED" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { turns_per_charge = 25, ammo_types = "glamour_charge" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_0" } },
    use_actions = {
        {
            kind = "transform",
            need_charges = 1,
            target = "item_hedge_see_fae_necklace_on",
            message = ccb.content.text("You recite that last part of the charm."),
            need_worn = true,
        },
    },
}

ccb.content.define_item {
    id = "item_hedge_see_fae_necklace_on",
    name = ccb.content.plural_text("Faesight Charm (active)", "Faesight Charms (active)"),
    description = ccb.content.text("A small sack with herbs in it to warn you if the Fair Folk are nearby.  You had better wear it under your clothes.  You wouldn't want them to know you're avoiding them."),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { glamour_charge = 360 } } },
    mass = "45 g",
    volume = "50 ml",
    materials = { "leather", "veggy" },
    color = "green",
    symbol = ",",
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "HEDGE_ENCHANTED", "SPAWN_ACTIVE" },
    revert_to = "item_hedge_see_fae_necklace_done",
    subtype_order = { "tool", "armor", "artifact" },
    tool = {
        turns_per_charge = 25,
        revert_message = ccb.content.text("Your otherworldly senses fade."),
        ammo_types = "glamour_charge",
    },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_on_0" } },
}

ccb.content.define_item {
    id = "item_hedge_see_fae_necklace_done",
    name = ccb.content.plural_text("Faesight Charm", "Faesight Charms"),
    description = ccb.content.text("A small sack with herbs in it to warn you if the Fair Folk are nearby.  You had better wear it under your clothes.  You wouldn't want them to know you're avoiding them.  This charm seems lifeless somehow, its energy spent."),
    mass = "45 g",
    volume = "50 ml",
    materials = { "leather", "veggy" },
    color = "green",
    symbol = ",",
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "MUNDANE" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_see_fae_necklace_done_0" } },
}

ccb.content.define_item {
    id = "item_hedge_nether_eye_paste",
    name = ccb.content.plural_text("Blood-and-Ash Paste", "Blood-and-Ash Paste"),
    description = ccb.content.text("A disgusting mixture of blood, ashes, and certain herbs.  Using it will allow you to see otherworldly creatures even through walls or in darkness."),
    mass = "265 g",
    volume = "250 ml",
    price = "2 USD",
    survival_price = "1 USD",
    symbol = "q",
    color = "blue",
    flags = { "EATEN_COLD", "HEDGE_ENCHANTED" },
    phase = "solid",
    comestible = {
        kind = "MED",
        shelf_life = "10 days",
        fun = -5,
        on_consume = "consume_item_hedge_nether_eye_paste",
    },
}

ccb.content.define_item {
    id = "item_hedge_changeling_snare",
    name = "betweener's maze",
    description = "A yarn contraption similar to a cat's cradle that looks like a three dimensional maze.  When placed properly, it can fascinate the changeling blooded.",
    symbol = "*",
    color = "green_green",
    category = "traps",
    mass = "20 g",
    volume = "100 ml",
    length = "20 cm",
    price = "250 USD",
    survival_price = "5 USD",
    flags = { "SINGLE_USE", "HEDGE_ENCHANTED" },
    materials = { "wool" },
    properties = { capture_species = "CHANGELING" },
    use_actions = {
        {
            kind = "place_trap",
            trap = "tr_fae_snare",
            moves = 150,
            practice = 2,
            done_message = "You place the betweener's maze.",
        },
    },
    tool = {},
}

ccb.content.define_item {
    id = "item_hedge_cure_cold_or_flu",
    copy_from = "tea",
    name = ccb.content.text("Curative tea"),
    description = ccb.content.text("Tea with herbs, iron, and a bit of magick.  If you're sick, there's nothing better for your body than this."),
    comestible = {},
}

ccb.content.define_item {
    id = "item_hedge_turn_into_bear_off",
    name = ccb.content.text("drained bearskin talisman"),
    description = ccb.content.text("A heavy fur mantle attached to the skull of a bear.  The charm worked into it has been expended."),
    mass = "2368 g",
    volume = "4 L",
    price = "245 USD",
    survival_price = "7 USD 50 cent",
    materials = { "fur", "bone" },
    symbol = "[",
    looks_like = "cloak_leather",
    color = "brown",
    flags = { "OVERSIZE", "HOOD", "TRADER_AVOID", "BELTED", "RAINPROOF" },
    armor = {
        warmth = 60,
        thickness = 2,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 6,
                coverage = 65,
                covers = { "torso", "arm_l", "arm_r" },
                subparts = {
                    "torso_upper",
                    "torso_neck",
                    "arm_shoulder_l",
                    "arm_upper_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                },
            },
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
            },
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 60,
                covers = { "head" },
                subparts = { "head_forehead" },
            },
        },
    },
}

ccb.content.define_item {
    id = "item_hedge_turn_into_bear",
    name = ccb.content.text("bearskin talisman"),
    copy_from = "item_hedge_turn_into_bear_off",
    description = ccb.content.text("A heavy fur mantle attached to the skull of a bear.  When you put it on, the charm will take effect and grant you the bear's power."),
    armor = {},
    inheritance = { add = { flags = { "SKINCHANGED", "HEDGE_ENCHANTED" } } },
}

ccb.content.define_item {
    id = "item_hedge_astral_projection_cord",
    name = ccb.content.plural_text("[Ψ]silver cord", "[Ψ]silver cord"),
    description = ccb.content.text("A thin silver cord, stretching off into the distance, connecting you to your body.  You could follow it back to return."),
    mass = "0 g",
    volume = "0 L",
    price = "1 cent",
    survival_price = "1 cent",
    symbol = "[",
    color = "light_gray",
    flags = {
        "PERSONAL", "UNBREAKABLE", "ZERO_WEIGHT", "ALLOWS_NATURAL_ATTACKS", "INTEGRATED", "PADDED",
        "SEMITANGIBLE", "WATER_FRIENDLY", "NO_DROP",
    },
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { environmental_protection = 0 },
}

-- Kamea is Hebrew for amulet
ccb.content.define_item {
    id = "item_hedge_raziel_amulet_protection",
    copy_from = "copper_necklace",
    looks_like = "copper_necklace",
    name = ccb.content.plural_text("Kamea of Protection", "Kameas of Protection"),
    description = ccb.content.text("A copper amulet, engraved with the names of angels and some of the secret names of God.  According to the text of the Sefer Raziel, wearing it will protect you from harm."),
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "MUNDANE", "HEDGE_ENCHANTED" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_raziel_amulet_protection_0" } },
}

-- Kamea is Hebrew for amulet
ccb.content.define_item {
    id = "item_hedge_raziel_amulet_protection_done",
    copy_from = "copper_necklace",
    looks_like = "copper_necklace",
    name = ccb.content.plural_text("Kamea of Protection (scratched)", "Kameas of Protection (scratched)"),
    description = ccb.content.text("A copper amulet, engraved with the names of angels and some of the secret names of God.  According to the text of the Sefer Raziel, wearing it will protect you from harm.  Some of the text on the amulet is scratched."),
    flags = { "ONE_PER_LAYER", "SKINTIGHT", "NO_UNLOAD", "NO_RELOAD", "MUNDANE" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = {},
}

ccb.content.define_item {
    id = "item_hedge_witchlight",
    name = "Witchlight",
    description = "A bobbing ball of blueish-green light, just bright enough to read by.",
    symbol = "x",
    color = "yellow",
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    light = 10,
    max_worn = 1,
    flags = {
        "SEMITANGIBLE",
        "AURA",
        "OVERSIZE",
        "PADDED",
        "ALLOWS_NATURAL_ATTACKS",
        "TRADER_AVOID",
        "NO_REPAIR",
        "NO_DROP",
        "ZERO_WEIGHT",
        "NONCONDUCTIVE",
    },
    armor = {},
    artifact = {
        enchantments = { "ITEM_ENCH_Xedra_Evolved_item_hedge_witchlight_0" },
    },
    subtype_order = { "armor", "artifact" },
}
