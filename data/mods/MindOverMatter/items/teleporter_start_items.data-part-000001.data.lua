local ccb = require("ccb")

ccb.content.define_item {
    id = "mom_fifth_sun_eagle_tac_helmet",
    category = "armor",
    name = ccb.content.plural_text("Imperial Navy battle helmet", "Imperial Navy battle helmets"),
    description = ccb.content.text("An all-encompassing helmet, standard issue for Imperial warrior orders.  Containing integral hearing protection and air filtration while still leaving your mouth free, highlights distant targets to provide easier targeting in battlefield conditions, has integral nightvision and thermal sensing, provides some protection against telepathic assault, and looks great while doing it.  This one has the eagle and stars of the Itzcuāuhtli Corps on it."),
    mass = "1180 g",
    volume = "1850 ml",
    price = "2 kUSD",
    survival_price = "100 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "fifth_sun_antiballistic_cloth", "plastic" },
    symbol = "[",
    looks_like = "tac_fullhelmet",
    color = "dark_gray",
    techniques = { "WBLOCK_1" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 672 } } },
    melee_damage = { bash = 1 },
    flags = { "VARSIZE", "WATERPROOF", "MUNDANE", "STURDY", "PADDED", "FIFTH_SUN_TECHNOLOGY" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {
        warmth = 15,
        thickness = 8,
        portions = {
            { encumbrance_modifiers = { "WELL_SUPPORTED" }, coverage = 100, covers = { "head" } },
            { covers = { "eyes" }, rigid_only = true, coverage = 100, encumbrance = 10 },
        },
    },
    artifact = {
        enchantments = {
            "nvg_great", "THERMAL_VISION_GOOD", "ench_mom_fifth_sun_targeting_assistance",
            "ITEM_ENCH_MindOverMatter_mom_fifth_sun_eagle_tac_helmet_3",
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You flip the switch and activate the helmet's functions."),
            target = "mom_fifth_sun_eagle_tac_helmet_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The switch clicks but nothing happens."),
            need_worn = true,
            menu_text = ccb.content.text("Flip the switch"),
        },
    },
}

ccb.content.define_item {
    id = "mom_fifth_sun_eagle_tac_helmet_on",
    copy_from = "mom_fifth_sun_eagle_tac_helmet",
    name = ccb.content.plural_text("Imperial Navy battle helmet (active)", "Imperial Navy battle helmets (active)"),
    description = ccb.content.text("An all-encompassing helmet, standard issue for Imperial warrior orders.  Containing integral hearing protection and air filtration while still leaving your mouth free, highlights distant targets to provide easier targeting in battlefield conditions, has integral nightvision and thermal sensing, provides some protection against telepathic assault, and looks great while doing it.  This one has the eagle and stars of the Itzcuāuhtli Corps on it.  It is currently active."),
    revert_to = "mom_fifth_sun_eagle_tac_helmet",
    inheritance = {
        add = {
            flags = {
                "FIX_FARSIGHT", "FIX_NEARSIGHT", "GAS_PROOF", "PARTIAL_DEAF", "PSYSHIELD_PARTIAL",
                "SUN_GLASSES", "ZOOM", "WATCH", "SPAWN_ACTIVE",
            },
        },
    },
    subtype_order = { "armor", "tool", "artifact" },
    armor = {},
    tool = { power_draw = "10 W" },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "mom_fifth_sun_eagle_tac_helmet",
            message = ccb.content.text("You flip the switch and deactivate the helmet's functions."),
            menu_text = ccb.content.text("Flip the switch"),
        },
    },
}

ccb.content.define_item {
    id = "mom_fifth_sun_standard_body_armor",
    category = "armor",
    name = ccb.content.plural_text("pāncahcallō torso armor", "sets of pāncahcallō torso armor"),
    description = ccb.content.text("A set of torso and upper-arm armor made with mixed leather overlaid with sheets of ichcayolli, pāncahcallō armor derives its effectiveness from the integral generator capable of projecting an ehēcatepantli barrier that provides most of the armor's protection."),
    mass = "3250 g",
    volume = "3500 ml",
    price = "5000 USD",
    survival_price = "300 USD",
    materials = { "leather" },
    symbol = "[",
    length = "60 cm",
    looks_like = "armor_larmor_chest",
    color = "white",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 672 } } },
    flags = { "VARSIZE", "STURDY", "MUNDANE", "OUTER", "NO_REPAIR", "FIFTH_SUN_TECHNOLOGY" },
    subtype_order = { "armor", "tool", "artifact" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 95,
                encumbrance = 20,
                materials = {
                    { id = "leather", coverage = 100, thickness = 2 },
                    {
                        id = "fifth_sun_antiballistic_cloth",
                        coverage = 95,
                        thickness = 2.4,
                        ignore_sheet_thickness = true,
                    },
                },
            },
            {
                covers = { "arm_l", "arm_r" },
                coverage = 90,
                encumbrance = 8,
                materials = {
                    { id = "leather", coverage = 100, thickness = 1.1 },
                    {
                        id = "fifth_sun_antiballistic_cloth",
                        coverage = 95,
                        thickness = 1.2,
                        ignore_sheet_thickness = true,
                    },
                },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
        },
        warmth = 20,
    },
    tool = {},
    artifact = { enchantments = { "ITEM_ENCH_MindOverMatter_mom_fifth_sun_standard_body_armor_0" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You flip the switch and activate the ehēcatepantli barrier."),
            target = "mom_fifth_sun_standard_body_armor_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The switch clicks but nothing happens."),
            need_worn = true,
            menu_text = ccb.content.text("Flip the switch"),
        },
    },
}

ccb.content.define_item {
    id = "mom_fifth_sun_standard_body_armor_on",
    copy_from = "mom_fifth_sun_standard_body_armor",
    name = ccb.content.plural_text("pāncahcallō torso armor (active)", "sets of pāncahcallō torso armor (active)"),
    description = ccb.content.text("A set of torso and upper-arm armor made with mixed leather overlaid with sheets of ichcayolli, pāncahcallō armor derives its effectiveness from the integral generator capable of projecting an ehēcatepantli barrier that provides most of the armor's protection.  The ehēcatepantli is currently active."),
    revert_to = "mom_fifth_sun_standard_body_armor",
    inheritance = { add = { flags = { "NO_TAKEOFF", "SPAWN_ACTIVE" } } },
    subtype_order = { "armor", "tool", "artifact" },
    armor = {},
    tool = { power_draw = "15 W" },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "mom_fifth_sun_standard_body_armor",
            message = ccb.content.text("You flip the switch and deactivate the ehēcatepantli barrier."),
            menu_text = ccb.content.text("Flip the switch"),
        },
    },
}

ccb.content.define_item {
    id = "mom_fifth_sun_standard_body_armor_non_fifth_sun",
    copy_from = "mom_fifth_sun_standard_body_armor",
    name = ccb.content.plural_text("strange body armor", "sets of strange body armor"),
    description = ccb.content.text("A set of leather armor covered in some kind of very stiff white cloth.  A small textured box is attached to the left side, easily accessible with either hand.  The box has a switch of some kind and several odd pictographs around the switch."),
    subtype_order = { "armor", "tool", "artifact" },
    armor = {},
    tool = {},
    artifact = {
        enchantments = { "ITEM_ENCH_MindOverMatter_mom_fifth_sun_standard_body_armor_non_fifth_sun_0" },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You flip the switch."),
            target = "mom_fifth_sun_standard_body_armor_non_fifth_sun_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("The switch clicks but nothing happens."),
            need_worn = true,
            menu_text = ccb.content.text("Flip the switch"),
        },
    },
}

ccb.content.define_item {
    id = "mom_fifth_sun_standard_body_armor_non_fifth_sun_on",
    copy_from = "mom_fifth_sun_standard_body_armor_on",
    name = ccb.content.plural_text("strange body armor (active)", "sets of strange body armor (active)"),
    description = ccb.content.text("A set of leather armor covered in some kind of very stiff white cloth.  A small textured box is attached to the left side, easily accessible with either hand.  The box has a switch of some kind and several odd pictographs around the switch.  The switch is currently flipped."),
    revert_to = "mom_fifth_sun_standard_body_armor_non_fifth_sun",
    inheritance = { add = { flags = { "NO_TAKEOFF", "SPAWN_ACTIVE" } } },
    subtype_order = { "armor", "tool", "artifact" },
    armor = {},
    tool = { power_draw = "15 W" },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "mom_fifth_sun_standard_body_armor_non_fifth_sun",
            message = ccb.content.text("You flip the switch."),
            menu_text = ccb.content.text("Flip the switch"),
        },
    },
}
