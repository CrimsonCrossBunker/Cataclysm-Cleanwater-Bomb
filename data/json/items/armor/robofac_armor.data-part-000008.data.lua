local ccb = require("ccb")

-- Tier 1 mantle
ccb.content.define_item {
    id = "robofac_basic_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 prototype mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  Several buckles and straps allow it to be adjusted to fit you comfortably.  Despite its rough finish, it's clear that a lot of thought has gone into the ergonomics and weight.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 mantle
ccb.content.define_item {
    id = "robofac_rubber_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 kinetic mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  This model incorporates a rubber coating that diffuses impacts and provides excellent protection from blunt trauma, even if it does feel a bit like a rain coat.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 mantle
ccb.content.define_item {
    id = "robofac_nomex_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 turnout mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  This model features heat-resistant materials in the construction, providing protection from extreme heat without sacrificing its overall performance.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.356 } },
}

-- Tier 2 mantle
ccb.content.define_item {
    id = "robofac_kevlar_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 ballistic mantle"),
    description = ccb.content.text("3D printed armor for the upper body, made of thick and pliable polymer with metallic fibers for reinforcement.  Thanks to a slim under-layer of synthetic fibers, it provides fantastic defense from small-arms fire, and could take the edge off of a rifle bullet, too.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 mantle
ccb.content.define_item {
    id = "robofac_military_mantle",
    copy_from = "robofac_mantle",
    name = ccb.content.text("Hub 01 soldier mantle"),
    description = ccb.content.text("3D printed armor for the upper body, sporting a professional finish and stellar ergonomics.  Made of extremely tough UHMW polyethylene combined with treated aramid fabric, it provides military-grade defense against zombies, bullets, zombies with bullets, and plenty of other things that the Cataclysm can throw at you.  Designed to clip to the chest and shoulders, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

-- Tier 1 skirt
ccb.content.define_item {
    id = "robofac_basic_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 prototype skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, consisting of a skirt made of segmented armor plates.  It features a simple integrated belt to let it fit any waist size.  Despite its rough finish, it's clear that a lot of thought has gone into the ergonomics and weight.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 skirt
ccb.content.define_item {
    id = "robofac_rubber_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 kinetic skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, consisting of a skirt made of segmented armor plates.  This model resembles scale armor, and provides excellent protection from blunt trauma.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 skirt
ccb.content.define_item {
    id = "robofac_nomex_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 turnout skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, consisting of a skirt made of segmented armor plates.  This version incorporates tight-fitting leggings that provide some protection from extreme heat.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.365 } },
}

-- Tier 2 skirt
ccb.content.define_item {
    id = "robofac_kevlar_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 ballistic skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, consisting of a skirt made of segmented armor plates.  It includes a reinforcing layer of aramid fabric in addition to leg sleeves made of high-strength material, protecting your sensitive bits from small-arms fire.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 skirt
ccb.content.define_item {
    id = "robofac_military_skirt",
    copy_from = "robofac_skirt",
    name = ccb.content.text("Hub 01 soldier skirt"),
    description = ccb.content.text("3D printed armor for the thighs and knees, sporting a professional finish and stellar ergonomics.  Composed of segmented polyethylene armor plates featuring a dense metal core sandwiched between layers of composite-grade aramid fabric, it provides excellent protection for the upper legs to ensure that you'll stay on your feet when it really matters.  Designed to clip to the waist, its interior reads \"ATTACH TO MODULAR DEFENSE SYSTEM\"."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

-- Tier 1 vambraces
ccb.content.define_item {
    id = "robofac_basic_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 prototype vambraces (pair)", "Hub 01 prototype vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, made of large and flexible polymer sheets wrapped around the forearm.  The end of each sheet features a clip and drawstring, to fit the armor to any size.  Despite the rough finish, it fits securely, and feels quite comfortable."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 vambraces
ccb.content.define_item {
    id = "robofac_rubber_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 kinetic vambraces (pair)", "Hub 01 kinetic vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, made of large and flexible polymer sheets wrapped around the forearm.  These ones are built in an overlapping pattern that diffuses impacts and provides excellent protection from blunt trauma."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 vambraces
ccb.content.define_item {
    id = "robofac_nomex_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 turnout vambraces (pair)", "Hub 01 turnout vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, made of large and flexible polymer sheets wrapped around the forearm.  These ones include Nomex sleeves to protect your arms from extreme heat."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.365 } },
}

-- Tier 2 vambraces
ccb.content.define_item {
    id = "robofac_kevlar_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 ballistic vambraces (pair)", "Hub 01 ballistic vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, made of large and flexible polymer sheets wrapped around the forearm.  These ones include aramid arm sleeves that do a great job of slowing down bullets and preventing them from shredding your arms."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 vambraces
ccb.content.define_item {
    id = "robofac_military_vambraces",
    copy_from = "robofac_vambraces",
    name = ccb.content.plural_text("Hub 01 soldier vambraces (pair)", "Hub 01 soldier vambraces (pair)"),
    description = ccb.content.text("3D printed arm guards, sporting a professional finish and stellar ergonomics.  With thick bullet-resistant arm sleeves, flexible but extremely tough thermoplastic plates, and special attention given to areas reflexively used to protect the face from attacks, it provides first-rate protection against all the horrors that the apocalypse has brought to bear."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

-- Tier 1 greaves
ccb.content.define_item {
    id = "robofac_basic_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 prototype greaves (pair)", "Hub 01 prototype greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, consisting of thick knee pads and a pair of large, flexible polymer plates for securing around the calves to protect the tibias of each leg.  Two straps on each plate can be tightened or loosened to fit different leg sizes.  Despite the rough finish, it doesn't impede your movement, and fits comfortably against your body."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 greaves
ccb.content.define_item {
    id = "robofac_rubber_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 kinetic greaves (pair)", "Hub 01 kinetic greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, consisting of thick knee pads and a pair of large, flexible polymer plates for securing around the calves to protect the tibias of each leg.  Thick padding and rubber lining provide excellent protection from blunt trauma."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 greaves
ccb.content.define_item {
    id = "robofac_nomex_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 turnout greaves (pair)", "Hub 01 turnout greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, consisting of thick knee pads and a pair of large, flexible polymer plates for securing around the calves to protect the tibias of each leg.  Heat-resistant leg sleeves and a breathable design provide adequate protection from extreme heat without sacrificing your mobility or core protection."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.365 } },
}

-- Tier 2 greaves
ccb.content.define_item {
    id = "robofac_kevlar_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 ballistic greaves (pair)", "Hub 01 ballistic greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, consisting of thick knee pads and a pair of large, flexible polymer plates for securing around the calves to protect the tibias of each leg.  This model features leggings made of durable aramid and a reinforced plate design; combined, they do a good job of mitigating damage from small-arms fire."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 greaves
ccb.content.define_item {
    id = "robofac_military_greaves",
    copy_from = "robofac_greaves",
    name = ccb.content.plural_text("Hub 01 soldier greaves (pair)", "Hub 01 soldier greaves (pair)"),
    description = ccb.content.text("3D printed leg guards, sporting a professional finish and stellar ergonomics.  Layered UHMW thermoplastic plates and bullet-resistant aramid padding combine to keep your lower leg bones protected and unbroken, even when knee-deep in the dead."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

-- Tier 1 helmet
ccb.content.define_item {
    id = "robofac_basic_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 prototype helmet"),
    description = ccb.content.text("3D printed armor for the head, made of thick polymer plates woven with metallic fibers.  Despite its rough finish, it's clear that a lot of thought has gone into the ergonomics and weight.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = { { id = "plastic", portions = 5 }, { id = "aluminum", portions = 2 } },
    armor = {},
}

-- Tier 2 helmet
ccb.content.define_item {
    id = "robofac_rubber_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 kinetic helmet"),
    description = ccb.content.text("3D printed armor for the head, made of thick polymer plates woven with metallic fibers.  This model is covered in countless rubber hexagons, and offers superior protection against blunt trauma.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "rubber", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.576 } },
}

-- Tier 2 helmet
ccb.content.define_item {
    id = "robofac_nomex_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 turnout helmet"),
    description = ccb.content.text("3D printed armor for the head, made of thick polymer plates woven with metallic fibers.  This version incorporates a tight fitting Nomex layer for some protection against heat.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "nomex", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.365 } },
}

-- Tier 2 helmet
ccb.content.define_item {
    id = "robofac_kevlar_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 ballistic helmet"),
    description = ccb.content.text("3D printed armor for the head, made of thick polymer plates woven with metallic fibers.  This one has extra Kevlar and steel layering, to provide superior protection against small arms.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = {
        { id = "plastic", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_layered", portions = 4 },
    },
    armor = {},
    inheritance = { scale = { mass = 1.5 } },
}

-- Tier 3 helmet
ccb.content.define_item {
    id = "robofac_military_helmet",
    copy_from = "robofac_helmet",
    name = ccb.content.text("Hub 01 soldier helmet"),
    description = ccb.content.text("3D printed armor for the head, sporting a professional finish and stellar ergonomics.  Composed of a dense metal shell sandwiched between layers of composite-grade aramid fabric, it provides excellent protection, ensuring you'll keep your head against whatever the Cataclysm throws at you.  Designed to clip to some kind of attachment point, its interior reads \"ATTACH TO MODULAR HEADGEAR\"."),
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "qt_steel", portions = 1 },
        { id = "kevlar_rigid", portions = 4 },
    },
    armor = {},
    inheritance = { add = { flags = { "STURDY" } }, scale = { mass = 1.5 } },
}

ccb.content.define_item {
    id = "hub_meteorology_pack",
    name = ccb.content.text("Hub 01 hazardous meteorology pack"),
    description = ccb.content.text("A 3D printed pack frame for the true frontier explorer.  While this resembles a standard military or hiking pack frame, this one appears to be made entirely of lightweight plastics and artificial fabrics.  This cumbersome contraption eschews the modular nature of standard frame packs in favor of ergonomic, pre-fabricated attachment points.  The back of the frame is a thin, solid piece with a slot labeled \"SOLAR PANEL\".  The base of the frame has two custom-fit slots labeled \"UPS\" and \"WORKSTATION\".  Hanging from the bottom are two wide loops labeled \"TENT\" and \"ROLLMAT\".  The frame itself has several large clips, each labeled with \"HEW SYSTEM\" in small text.  The pack is secured by shoulder straps - the left shoulder strap proudly displays the Hub 01 logo, while the right strap has \"HE\" sewn in bright white letters."),
    mass = "1200 g",
    volume = "4500 ml",
    length = "70 cm",
    price = "400 USD",
    survival_price = "30 USD",
    materials = {
        { id = "thermo_resin", portions = 2 },
        { id = "plastic", portions = 2 },
        { id = "nylon", portions = 1 },
    },
    symbol = "[",
    looks_like = "backpack",
    color = "brown",
    pockets = {
        {
            kind = "CONTAINER",
            allowed_items = { "folding_solar_panel" },
            moves = 300,
            capacity = "7500 ml",
            mass_limit = "5800 g",
            max_item_length = "54 cm",
            description = ccb.content.text("Secured in a slot labeled \"SOLAR PANEL.\""),
        },
        {
            kind = "CONTAINER",
            allowed_items = {
                "mobile_weather_station",
                "xedra_mobile_weather_station",
                "robofac_mobile_weather_station",
            },
            capacity = "90000 ml",
            mass_limit = "6300 g",
            max_item_length = "61 cm",
            moves = 300,
            description = ccb.content.text("Attached to points labeled \"HEW SYSTEM.\""),
        },
        {
            kind = "CONTAINER",
            allowed_items = { "laptop" },
            capacity = "710 ml",
            mass_limit = "1330 g",
            max_item_length = "323 mm",
            moves = 300,
            description = ccb.content.text("Secured in a slot labeled \"WORKSTATION.\""),
        },
        {
            kind = "CONTAINER",
            allowed_items = { "UPS_off", "UPS_OFF", "UPS_ON" },
            capacity = "3100 ml",
            mass_limit = "1400 g",
            max_item_length = "15 cm",
            moves = 300,
            description = ccb.content.text("Secured in a slot labeled \"UPS.\""),
        },
        {
            kind = "CONTAINER",
            allowed_items = { "tent_kit" },
            moves = 300,
            capacity = "2600 ml",
            mass_limit = "1200 g",
            max_item_length = "91 cm",
            extra_encumbrance = 1,
            description = ccb.content.text("Secured under compression straps labeled \"TENT.\""),
            ripoff = 5,
            transparent = true,
        },
        {
            kind = "CONTAINER",
            allowed_items = { "rollmat" },
            moves = 300,
            capacity = "1100 ml",
            mass_limit = "300 g",
            max_item_length = "11 cm",
            extra_encumbrance = 1,
            description = ccb.content.text("Secured under compression straps labeled \"ROLLMAT.\""),
            ripoff = 5,
            transparent = true,
        },
    },
    flags = { "BELTED", "WATERPROOF" },
    armor = {
        warmth = 8,
        thickness = 2,
        portions = {
            {
                encumbrance = { 10, 30 },
                coverage = 95,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

-- made of metallized polyethylene terephthalate, or MPET, so basically an emergency blanket
ccb.content.define_item {
    id = "robofac_poncho_liner",
    category = "clothing",
    symbol = "[",
    color = "dark_gray",
    name = ccb.content.text("Hub 01 MPET poncho liner"),
    description = ccb.content.text("Often called a \"woobie\" by soldiers, this sleeping bag-like poncho liner can be attached under a poncho or used as a blanket.  This one is made of space-age metallized polyethylene terephthalate, or MPET, the same reflective material used on spacecraft, spacesuits, emergency blankets, and mundane food packaging.  The Hub 01 logo is stamped on one corner.  It folds into a very compact form when not in use."),
    price = "50 USD",
    survival_price = "50 cent",
    materials = { { id = "plastic", portions = 99 }, { id = "aluminum", portions = 1 } },
    mass = "50 g",
    volume = "200 ml",
    flags = { "OVERSIZE", "BELTED" },
    armor = {
        warmth = 10,
        environmental_protection = 4,
        thickness = 0.01,
        portions = {
            {
                encumbrance = 3,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
                coverage = 100,
            },
            {
                encumbrance = 3,
                covers = { "arm_l", "arm_r" },
                subparts = {
                    "arm_shoulder_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                    "arm_upper_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                },
                coverage = 100,
            },
            {
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r" },
                coverage = 90,
            },
            {
                coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}
