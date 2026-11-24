local ccb = require("ccb")

-- All Fifth Sun technology should go here.
ccb.content.define_item {
    id = "mom_fusion_pistol",
    looks_like = "glock_17",
    name = ccb.content.text("Ch47 Fusion Pistol"),
    description = ccb.content.text("The standard-issue officer's sidearm for the Imperial Navy, guaranteed manufactured on Tlalticpactli itself by scions of the Huey Calpulli, the Ch47 replaced the earlier Ch41 and is widely renowned for its accuracy and ease of maintenance.  This particular Ch47 even bears an eagle and snake on the grip, indicating it was produced in a factory in Anáhuac.  Hopefully it'll make a good melee weapon as well."),
    melee_damage = { bash = 5 },
    mass = "800 g",
    volume = "1 L",
    length = "250 mm",
    symbol = "(",
    color = "red",
    materials = { "superalloy", "steel" },
    pockets = { { kind = "MAGAZINE_WELL", magazine_well = "25 ml", allowed_items = { "mom_fusion_mag" } } },
    flags = { "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE", "NO_REPAIR", "FIFTH_SUN_TECHNOLOGY" },
    gun = {
        reload_noise_volume = 5,
        skill = "pistol",
        dispersion = 150,
        durability = 10,
        loudness = 20,
        reload_time = 200,
        range = 45,
        effects = { "PLASMA", "PLASMA_BUBBLE", "IGNITE" },
        ammunition = { "mom_fusion_ammo" },
    },
}

ccb.content.define_item {
    id = "mom_fusion_mag",
    name = ccb.content.text("Ch47 power pack"),
    description = ccb.content.text("A power pack for the Ch47."),
    mass = "40 g",
    volume = "20 ml",
    materials = { "superalloy" },
    price = "100 USD",
    survival_price = "1 cent",
    symbol = "#",
    color = "red",
    pockets = { { kind = "MAGAZINE", ammunition = { mom_fusion_ammo = 40 } } },
    magazine = { ammunition = { "mom_fusion_ammo" } },
}

ccb.content.define_item {
    id = "mom_fusion_ammo",
    name = ccb.content.text("Ch47 power cartridge"),
    description = ccb.content.text("Power cartridges for the Ch47.  You had better make every shot count, because there's no way you're finding any more of these."),
    mass = "1 g",
    volume = "1 ml",
    price = "1 USD 60 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "superalloy", "steel" },
    symbol = "=",
    color = "red",
    stack_size = 40,
    ammunition = {
        count = 40,
        type = "mom_fusion_ammo",
        damage = { type = "heat", amount = 60, penetration = 30 },
    },
}

ccb.content.define_item {
    id = "mom_fifth_sun_stungun_pistol",
    looks_like = "v29",
    name = ccb.content.text("M12 \"Cochmamauhtia\" Pistol"),
    description = ccb.content.text("The M12 was designed as a less-than-lethal alternative to more dangerous forms of crowd pacification, able to disable a target for up to a minute with a single shot and few to no permanent effects.  While it cannot be said to be nonlethal because it is not safe to use on targets with heart conditions or epilepsy, it is a great improvement over the previous X04 \"Tecuacuilli\" which, on unfortunately not-rare-enough occasions, could cause permanent paralysis.  On this world, though, you don't think the M12's lethality or lack thereof is going to be much of a concern."),
    melee_damage = { bash = 5 },
    mass = "680 g",
    volume = "1 L",
    length = "233 mm",
    symbol = "(",
    color = "cyan",
    materials = { "nether_crystal", "steel" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "25 ml",
            allowed_items = { "mom_fifth_sun_stungun_mag" },
        },
    },
    flags = { "NEVER_JAMS", "NON_FOULING", "NEEDS_NO_LUBE", "NO_REPAIR", "FIFTH_SUN_TECHNOLOGY" },
    gun = {
        reload_noise_volume = 5,
        skill = "pistol",
        dispersion = 100,
        durability = 10,
        loudness = 25,
        reload_time = 200,
        range = 20,
        effects = { "NEURAL_STUNGUN" },
        ammunition = { "mom_fifth_sun_stungun_ammo" },
    },
}

ccb.content.define_item {
    id = "mom_fifth_sun_stungun_mag",
    name = ccb.content.text("M12 power pack"),
    description = ccb.content.text("A power pack for the Ch47."),
    mass = "40 g",
    volume = "20 ml",
    materials = { "nether_crystal", "steel" },
    price = "100 USD",
    survival_price = "1 cent",
    symbol = "#",
    color = "red",
    pockets = { { kind = "MAGAZINE", ammunition = { mom_fifth_sun_stungun_ammo = 25 } } },
    magazine = { ammunition = { "mom_fusion_ammo" } },
}

ccb.content.define_item {
    id = "mom_fifth_sun_stungun_ammo",
    name = ccb.content.text("M12 power cartridge"),
    description = ccb.content.text("Power cartridges for the M12.  You had better make every shot count, because there's no way you're finding any more of these."),
    mass = "1 g",
    volume = "1 ml",
    price = "1 USD 60 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "superalloy", "steel" },
    symbol = "=",
    color = "red",
    stack_size = 40,
    ammunition = { count = 40, type = "mom_fifth_sun_stungun_ammo", damage = { type = "electric", amount = 3 } },
}

ccb.content.define_item {
    id = "mom_lightning_rifle",
    looks_like = "laser_rifle",
    name = ccb.content.text("G-Tz77 \"Tlapetlaniliztli\" battle rifle"),
    description = ccb.content.text("A shipboard battle rifle, whose non-kinetic ammunition was designed to avoid puncturing ship hulls during engagements.  The G-Tz77 has been a mainstay of the Imperial Navy for decades at this point and seen service on the surface of and in orbit around dozens of worlds.  This is just one more in its long history of protecting the Ēxcān Tlahtōlōyān."),
    mass = "2950 g",
    volume = "3 L",
    length = "900 mm",
    price = "16 kUSD",
    survival_price = "200 USD",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "clumsy" },
    materials = { "steel", "plastic", "nether_crystal" },
    symbol = "(",
    color = "cyan",
    faults = { { fault = "fault_overheat_melting" }, { fault = "fault_overheat_safety" } },
    melee_damage = { bash = 12 },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            magazine_well = "50 ml",
            allowed_items = { "mom_lightning_rifle_mag" },
        },
    },
    flags = {
        "NEVER_JAMS",
        "NO_REPAIR",
        "NON_FOULING",
        "NEEDS_NO_LUBE",
        "NO_REPAIR",
        "FIFTH_SUN_TECHNOLOGY",
    },
    variant_kind = "generic",
    variants = {
        {
            id = "mom_lightning_rifle_standard",
            name = ccb.content.text("G-Tz77 \"Tlapetlaniliztli\" battle rifle"),
            description = ccb.content.text("A shipboard battle rifle, whose non-kinetic ammunition was designed to avoid puncturing ship hulls during engagements.  The G-Tz77 has been a mainstay of the Imperial Navy for decades at this point and seen service on the surface of and in orbit around dozens of worlds.  This is just one more in its long history of protecting the Ēxcān Tlahtōlōyān."),
            weight = 1,
        },
        {
            id = "mom_lightning_rifle_non_fifth_sun",
            name = ccb.content.text("odd rifle"),
            description = ccb.content.text("This is recognizably a rifle but it's like nothing you've ever seen.  The magazine seems to be inserted into the stock and the barrel is almost as big around as your wrist.  When you hold it, some kind of electronic display above the grip shows a series of odd symbols."),
            weight = 1000,
        },
    },
    gun = {
        reload_noise_volume = 0,
        skill = "rifle",
        range = 35,
        damage = { type = "electric", amount = 0, penetration = 0 },
        dispersion = 10,
        durability = 8,
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { id = "AUTO", label = ccb.content.text("auto-rpm"), rpm = 1200 },
        },
        loudness = 12,
        reload_time = 250,
        effects = { "LIGHTNING_TRAIL", "BOUNCE" },
        ammunition = { "mom_lightning_rifle_ammo" },
    },
}

ccb.content.define_item {
    id = "mom_lightning_rifle_mag",
    name = ccb.content.text("G-Tz77 power pack"),
    description = ccb.content.text("A power pack for the G-Tz77."),
    mass = "100 g",
    volume = "45 ml",
    materials = { "steel" },
    price = "100 USD",
    survival_price = "1 cent",
    symbol = "#",
    color = "red",
    pockets = { { kind = "MAGAZINE", ammunition = { mom_lightning_rifle_ammo = 120 } } },
    flags = { "MAG_COMPACT" },
    magazine = { ammunition = { "mom_lightning_rifle_ammo" } },
}

ccb.content.define_item {
    id = "mom_lightning_rifle_ammo",
    name = ccb.content.text("G-Tz77 power cartridge"),
    description = ccb.content.text("Power cartridges for the G-Tz77.  You had better make every shot count, because there's no way you're finding any more of these."),
    mass = "1 g",
    volume = "1 ml",
    price = "1 USD 60 cent",
    survival_price = "8 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "nether_crystal", "steel" },
    symbol = "=",
    color = "cyan",
    stack_size = 120,
    ammunition = {
        count = 120,
        type = "mom_lightning_rifle_ammo",
        damage = { type = "electric", amount = 80, penetration = 15 },
    },
}

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

ccb.content.define_item {
    id = "itzcuauhtli_cape",
    copy_from = "cloak",
    name = ccb.content.plural_text("Itzcuāuhtli Corps tilmàtli", "Itzcuāuhtli Corps tilmàtli"),
    description = ccb.content.text("A formal dress cape for the Itzcuāuhtli Corps in crimson and gold, with the eagle's head over a field of stars insignia on the left shoulder, worn by generations of those who sought out new worlds in service to the Huey Tlatoani and the Ēxcān Tlahtōlōyān.  You're pretty sure this is the furthest anyone wearing one has ever been from Anáhuac."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } }, remove = { flags = { "HOOD" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_hat",
    copy_from = "beret",
    name = ccb.content.text("Imperial navy cap"),
    description = ccb.content.text("A flat crimson hat worn by members of the Imperial navy at formal events.  This one has the black circle of the Yohualli Ehēcatl on it."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_holster",
    copy_from = "holster",
    name = ccb.content.text("Ch47 holster"),
    description = ccb.content.text("A holster for the Ch47.  You could put one of the primitive local ranged weapons in here too, if you had to."),
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "250 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 50,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_holster_m12",
    copy_from = "holster",
    name = ccb.content.text("M12 holster"),
    description = ccb.content.text("A holster for the M12.  You could put one of the primitive local ranged weapons in here too, if you had to."),
    pockets = {
        {
            magazine_well = "350 ml",
            kind = "CONTAINER",
            holster = true,
            min_item_volume = "250 ml",
            capacity = "1000 ml",
            mass_limit = "2 kg",
            max_item_length = "30 cm",
            moves = 50,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_tunic",
    copy_from = "dress_shirt",
    name = ccb.content.text("Yohualli Ehēcatl division tunic"),
    description = ccb.content.text("A dress tunic, in gold and crimson, slashed with black bars.  This would immediately mark your exact rank and position to anyone else in the Imperial Navy, if you ever see another one again."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_tunic_jaguar",
    copy_from = "dress_shirt",
    name = ccb.content.text("Ocēlōpilli dress tunic"),
    description = ccb.content.text("A dress tunic, in gold and crimson, slashed with yellow bars.  This marks the wearer as one of the Jaguar Warrior special forces."),
    variant_kind = "generic",
    variants = {
        {
            id = "itzcuauhtli_tunic_jaguar_standard",
            name = ccb.content.text("Ocēlōpilli dress tunic"),
            description = ccb.content.text("A dress tunic, in gold and crimson, slashed with yellow bars.  This marks the wearer as one of the Jaguar Warrior special forces."),
            weight = 1,
        },
        {
            id = "itzcuauhtli_tunic_jaguar_non_fifth_sun",
            name = ccb.content.plural_text("uniform dress shirt", "uniform dress shirt"),
            description = ccb.content.text("Some sort of uniform dress shirt in a blood-red crimson color with gold accents and a series of yellow bars on the left side.  You can't recall any military that dresses quite like this."),
            weight = 1,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_pants",
    copy_from = "pants",
    name = ccb.content.plural_text("Itzcuāuhtli Corps pants", "Itzcuāuhtli Corps pants"),
    description = ccb.content.text("A set of gold and crimson uniform pants.  The days of wearing only a maxtlatl are gone following the expansion of the empire out from Anáhuac, and considering the local climate, you're grateful for it."),
    variant_kind = "generic",
    variants = {
        {
            id = "itzcuauhtli_pants_standard",
            name = ccb.content.plural_text("Itzcuāuhtli Corps pants", "Itzcuāuhtli Corps pants"),
            description = ccb.content.text("A set of gold and crimson uniform pants.  The days of wearing only a maxtlatl are gone following the expansion of the empire out from Anáhuac, and considering the local climate, you're grateful for it."),
            weight = 1,
        },
        {
            id = "itzcuauhtli_pants_non_fifth_sun",
            name = ccb.content.plural_text("uniform pants", "uniform pants"),
            description = ccb.content.text("Some sort of uniform pants in a blood-red crimson color with gold accents.  You can't recall any military that dresses quite like this."),
            weight = 1,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_boots",
    copy_from = "boots",
    name = ccb.content.plural_text("naval boots", "naval boots"),
    description = ccb.content.text("Simple black leather boots.  It's a good thing you weren't transporting a planetary tlatoani when the accident happened or you might have ended up on this gods-forsaken hellhole barefoot."),
    variant_kind = "generic",
    variants = {
        {
            id = "itzcuauhtli_boots_standard",
            name = ccb.content.plural_text("naval boots", "naval boots"),
            description = ccb.content.text("Simple black leather boots.  It's a good thing you weren't transporting a planetary tlatoani when the accident happened or you might have ended up on this gods-forsaken hellhole barefoot."),
            weight = 1,
        },
        {
            id = "itzcuauhtli_boots_standard_non_fifth_sun",
            name = ccb.content.plural_text("black leather boots", "black leather boots"),
            description = ccb.content.text("Simple black leather boots."),
            weight = 1,
        },
    },
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_wrist_computer",
    name = ccb.content.plural_text("māchīuhpōhualhuaztli", "māchīuhpōhualhuaztimeh"),
    description = "Your trustworthy connection to the local mātlatzālantli, the māchīuhpōhualhuaztli allows you to store and read texts through tonaltēzcatl projection, look up info, keep track of your biometrics, play games, record visuals or sound, connect with far-distant friends and family, act as a calendar and event planner, and even identify you to agents of the government or, gods forbid, the Tlamachchiuhqueh, should that become necessary.  There's nothing to connect to on this blighted world, but the other functions should still work.",
    symbol = "[",
    color = "cyan",
    category = "clothing",
    variant_kind = "generic",
    mass = "30 g",
    volume = "100 ml",
    price = "500000 USD",
    survival_price = "50 USD",
    e_port = "laptop",
    flags = {
        "WATCH",
        "WATER_FRIENDLY",
        "ALARMCLOCK",
        "BELTED",
        "CALORIES_INTAKE",
        "NO_UNLOAD",
        "NO_RELOAD",
        "ALLOWS_NATURAL_ATTACKS",
        "OVERSIZE",
        "NO_REPAIR",
        "FIFTH_SUN_TECHNOLOGY",
    },
    materials = {
        { id = "nether_crystal", portions = 5 },
        { id = "plastic", portions = 95 },
    },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { battery = 10000 },
        },
        {
            kind = "E_FILE_STORAGE",
            capacity = "1 ml",
            mass_limit = "1 g",
            memory_capacity = "512 TB",
            weight_multiplier = 0,
            rigid = true,
        },
    },
    variants = {
        {
            id = "itzcuauhtli_wrist_computer_standard",
            name = ccb.content.plural_text("māchīuhpōhualhuaztli", "māchīuhpōhualhuaztimeh"),
            description = "Your trustworthy connection to the local mātlatzālantli, the māchīuhpōhualhuaztli allows you to store and read texts through tonaltēzcatl projection, look up info, keep track of your biometrics, play games, record visuals or sound, connect with far-distant friends and family, act as a calendar and event planner, and even identify you to agents of the government or, gods forbid, the Tlamachchiuhqueh, should that become necessary.  There's nothing to connect to on this blighted world, but the other functions should still work.",
            weight = 1,
        },
        {
            id = "itzcuauhtli_wrist_computer_non_fifth_sun",
            name = ccb.content.plural_text("strange watch", "strange watches"),
            description = "This looks like a smartwatch but it doesn't have a screen.  There are two buttons on each side, and when you press one of them, a series of glowing holograms spring up over your wrist.  They depict what looks like a menu, but everything is written in blobby symbols that look vaguely…Mayan?  You've never seen anything like this before.",
            weight = 1,
        },
    },
    use_actions = {
        "E_FILE_DEVICE",
        "EBOOKSAVE",
        "CAMERA",
        "CALORIES_INTAKE_TRACKER",
        "PORTABLE_GAME",
        "FITNESS_CHECK",
    },
    tool = { charges_per_use = 1, transfer_rate = "1 GB" },
    armor = {
        sided = true,
        portions = {
            {
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
                coverage = 100,
            },
        },
    },
    subtype_order = { "tool", "armor" },
}

ccb.content.define_item {
    id = "itzcuauhtli_pants_army",
    copy_from = "pants_army",
    name = ccb.content.plural_text("Itzcuāuhtli Corps combat uniform pants", "Itzcuāuhtli Corps combat uniform pants"),
    description = ccb.content.text("The standard combat uniform of the Itzcuāuhtli Corps, in shades of dark green and grey.  These are pants, with several pockets."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_combat_shirt",
    copy_from = "combat_shirt",
    name = ccb.content.plural_text("Itzcuāuhtli Corps combat uniform shirt", "Itzcuāuhtli Corps combat uniform shirt"),
    description = ccb.content.text("The standard combat uniform of the Itzcuāuhtli Corps, in shades of dark green and grey.  This is a shirt."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "itzcuauhtli_jacket_army_modern",
    copy_from = "jacket_army_modern",
    name = ccb.content.plural_text("Itzcuāuhtli Corps combat uniform jacket", "Itzcuāuhtli Corps combat uniform jacket"),
    description = ccb.content.text("The standard combat uniform of the Itzcuāuhtli Corps, in shades of dark green and grey.  This is a jacket.  It has the eagle over a field of stars symbol of the Itzcuāuhtli Corps on both shoulders."),
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}

ccb.content.define_item {
    id = "holy_symbol_fifth_sun",
    copy_from = "holy_symbol",
    name = ccb.content.text("Imperial Church holy symbol"),
    description = ccb.content.text("A necklace made of fine gold chain, bearing an image of Jesucristo as the Ultimate Sacrifice as a pendant, his heart clearly visible through his chest.  Under his left hand is a raindrop, representing the Aeon Tláloc, and under his right hand is a sun disc, representing the Aeon Huītzilōpōchtli."),
    variants = {},
    armor = {},
    inheritance = { add = { flags = { "FIFTH_SUN_TECHNOLOGY" } } },
}
