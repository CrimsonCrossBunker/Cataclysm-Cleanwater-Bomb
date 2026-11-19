local ccb = require("ccb")

ccb.content.define_item {
    id = "combat_exoskeleton_armor_head_heavy",
    category = "armor",
    name = ccb.content.text("heavy combat exoskeleton head armor"),
    description = ccb.content.text("Put the tank in tank suit with this 6mm thick exoskeleton armor, it even feels like wearing a real tank, you should stay wary of anti-materiel rounds though."),
    symbol = "[",
    price = "2000 USD",
    survival_price = "600 USD",
    volume = "3300 ml",
    mass = "3500 g",
    flags = { "EXO_HELMET_PLATE", "STURDY", "CANT_WEAR" },
    pockets = {
        {
            kind = "CONTAINER",
            volume_encumbrance = 0,
            capacity = "300 ml",
            mass_limit = "500 g",
            max_item_length = "14 cm",
            moves = 100,
            description = ccb.content.text("Pocket for a flashlight attachment."),
            allowed_flags = { "HELMET_HEAD_ATTACHMENT" },
            transparent = true,
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "2 L",
            mass_limit = "2 kg",
            moves = 250,
            description = ccb.content.text("Pocket for a front night vision attachment."),
            allowed_flags = { "HELMET_FRONT_ATTACHMENT" },
            inherits_flags = false,
        },
    },
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "head" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "mouth" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 6 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "eyes" },
                encumbrance = 0,
                coverage = 100,
                materials = { { id = "lvl4ballisticglass", thickness = 2 } },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_torso_heavy",
    category = "armor",
    name = ccb.content.text("heavy combat exoskeleton torso armor"),
    description = ccb.content.text("Put the tank in tank suit with this 6mm thick exoskeleton armor, it even feels like wearing a real tank, you should stay wary of anti-materiel rounds though."),
    symbol = "[",
    price = "2000 USD",
    survival_price = "600 USD",
    volume = "12000 ml",
    mass = "12700 g",
    flags = { "EXO_TORSO_PLATE", "STURDY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "torso" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_arm_heavy",
    category = "armor",
    name = ccb.content.text("heavy combat exoskeleton arm armor"),
    description = ccb.content.text("Put the tank in tank suit with this 6mm thick exoskeleton armor, it even feels like wearing a real tank, you should stay wary of anti-materiel rounds though."),
    symbol = "[",
    price = "2000 USD",
    survival_price = "600 USD",
    volume = "9700 ml",
    mass = "10300 g",
    flags = { "EXO_ARM_PLATE", "STURDY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "arm_r", "arm_l" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_back_r", "hand_back_l", "hand_wrist_r", "hand_wrist_l" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_palm_r", "hand_palm_l", "hand_fingers_r", "hand_fingers_l" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 1.1, ignore_sheet_thickness = true },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_leg_heavy",
    category = "armor",
    name = ccb.content.text("heavy combat exoskeleton leg armor"),
    description = ccb.content.text("Put the tank in tank suit with this 6mm thick exoskeleton armor, it even feels like wearing a real tank, you should stay wary of anti-materiel rounds though."),
    symbol = "[",
    price = "2000 USD",
    survival_price = "600 USD",
    volume = "10000 ml",
    mass = "10600 g",
    flags = { "EXO_LEG_PLATE", "STURDY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "leg_r", "leg_l" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "foot_r", "foot_l" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_head_medium",
    copy_from = "combat_exoskeleton_armor_head_heavy",
    name = ccb.content.text("medium combat exoskeleton head armor"),
    description = ccb.content.text("This 4mm thick exoskeleton armor will allow you to withstand a lead storm while also giving you the mobility to escape it, if the hail ends up being made of heavier calibers than standard rifle rounds."),
    volume = "2700 ml",
    mass = "2800 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "head" },
                encumbrance = 6,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "mouth" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 4 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "eyes" },
                encumbrance = 0,
                coverage = 100,
                materials = { { id = "lvl4ballisticglass", thickness = 2 } },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_torso_medium",
    copy_from = "combat_exoskeleton_armor_torso_heavy",
    name = ccb.content.text("medium combat exoskeleton torso armor"),
    description = ccb.content.text("This 4mm thick exoskeleton armor will allow you to withstand a lead storm while also giving you the mobility to escape it, if the hail ends up being made of heavier calibers than standard rifle rounds."),
    volume = "9600 ml",
    mass = "10200 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "torso" },
                encumbrance = 6,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_arm_medium",
    copy_from = "combat_exoskeleton_armor_arm_heavy",
    name = ccb.content.text("medium combat exoskeleton arm armor"),
    description = ccb.content.text("This 4mm thick exoskeleton armor will allow you to withstand a lead storm while also giving you the mobility to escape it, if the hail ends up being made of heavier calibers than standard rifle rounds."),
    volume = "7700 ml",
    mass = "8200 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "arm_r", "arm_l" },
                encumbrance = 6,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_back_r", "hand_back_l", "hand_wrist_r", "hand_wrist_l" },
                encumbrance = 6,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_palm_r", "hand_palm_l", "hand_fingers_r", "hand_fingers_l" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 1.1, ignore_sheet_thickness = true },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_leg_medium",
    copy_from = "combat_exoskeleton_armor_leg_heavy",
    name = ccb.content.text("medium combat exoskeleton leg armor"),
    description = ccb.content.text("This 4mm thick exoskeleton armor will allow you to withstand a lead storm while also giving you the mobility to escape it, if the hail ends up being made of heavier calibers than standard rifle rounds."),
    volume = "8000 ml",
    mass = "8500 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "leg_r", "leg_l" },
                encumbrance = 6,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "foot_r", "foot_l" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                encumbrance = 6,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_head_light",
    copy_from = "combat_exoskeleton_armor_head_heavy",
    name = ccb.content.text("light combat exoskeleton head armor"),
    description = ccb.content.text("This 2mm thick exoskeleton armor was designed when the testing of heavier versions concluded that mobility is actually the most important attribute on the battlefield, especially when you can still brush off small caliber rounds."),
    volume = "2000 ml",
    mass = "2300 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "head" },
                encumbrance = 4,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "mouth" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 2 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "eyes" },
                encumbrance = 0,
                coverage = 100,
                materials = { { id = "lvl4ballisticglass", thickness = 2 } },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_torso_light",
    copy_from = "combat_exoskeleton_armor_torso_heavy",
    name = ccb.content.text("light combat exoskeleton torso armor"),
    description = ccb.content.text("This 2mm thick exoskeleton armor was designed when the testing of heavier versions concluded that mobility is actually the most important attribute on the battlefield, especially when you can still brush off small caliber rounds."),
    volume = "7200 ml",
    mass = "8200 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "torso" },
                encumbrance = 4,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_arm_light",
    copy_from = "combat_exoskeleton_armor_arm_heavy",
    name = ccb.content.text("light combat exoskeleton arm armor"),
    description = ccb.content.text("This 2mm thick exoskeleton armor was designed when the testing of heavier versions concluded that mobility is actually the most important attribute on the battlefield, especially when you can still brush off small caliber rounds."),
    volume = "5800 ml",
    mass = "6600 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "arm_r", "arm_l" },
                encumbrance = 4,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_back_r", "hand_back_l", "hand_wrist_r", "hand_wrist_l" },
                encumbrance = 4,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_palm_r", "hand_palm_l", "hand_fingers_r", "hand_fingers_l" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 1 },
                    { id = "kevlar_layered", thickness = 1.1, ignore_sheet_thickness = true },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_leg_light",
    copy_from = "combat_exoskeleton_armor_leg_heavy",
    name = ccb.content.text("light combat exoskeleton leg armor"),
    description = ccb.content.text("This 2mm thick exoskeleton armor was designed when the testing of heavier versions concluded that mobility is actually the most important attribute on the battlefield, especially when you can still brush off small caliber rounds."),
    volume = "6000 ml",
    mass = "6800 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "leg_r", "leg_l" },
                encumbrance = 4,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "foot_r", "foot_l" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                encumbrance = 4,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_head_heavy_reinforced",
    copy_from = "combat_exoskeleton_armor_head_heavy",
    name = ccb.content.text("reinforced heavy combat exoskeleton head armor"),
    description = ccb.content.text("Put the tank in tank suit with this 6mm thick exoskeleton armor, it even feels like wearing a real tank, you should stay wary of anti-materiel rounds though.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "3600 ml",
    mass = "3900 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "head" },
                encumbrance = 12,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "mouth" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 6 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "eyes" },
                encumbrance = 0,
                coverage = 100,
                materials = { { id = "lvl4ballisticglass", thickness = 2 } },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_torso_heavy_reinforced",
    copy_from = "combat_exoskeleton_armor_torso_heavy",
    name = ccb.content.text("reinforced heavy combat exoskeleton torso armor"),
    description = ccb.content.text("Put the tank in tank suit with this 6mm thick exoskeleton armor, it even feels like wearing a real tank, you should stay wary of anti-materiel rounds though.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "13200 ml",
    mass = "14000 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "torso" },
                encumbrance = 12,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_arm_heavy_reinforced",
    copy_from = "combat_exoskeleton_armor_arm_heavy",
    name = ccb.content.text("reinforced heavy combat exoskeleton arm armor"),
    description = ccb.content.text("Put the tank in tank suit with this 6mm thick exoskeleton armor, it even feels like wearing a real tank, you should stay wary of anti-materiel rounds though.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "10700 ml",
    mass = "11300 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "arm_r", "arm_l" },
                encumbrance = 12,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_back_r", "hand_back_l", "hand_wrist_r", "hand_wrist_l" },
                encumbrance = 12,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_palm_r", "hand_palm_l", "hand_fingers_r", "hand_fingers_l" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 1.1, ignore_sheet_thickness = true },
                    { id = "qt_steel_chain", thickness = 1.2 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_leg_heavy_reinforced",
    copy_from = "combat_exoskeleton_armor_leg_heavy",
    name = ccb.content.text("reinforced heavy combat exoskeleton leg armor"),
    description = ccb.content.text("Put the tank in tank suit with this 6mm thick exoskeleton armor, it even feels like wearing a real tank, you should stay wary of anti-materiel rounds though.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "11000 ml",
    mass = "11700 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "leg_r", "leg_l" },
                encumbrance = 12,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "foot_r", "foot_l" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                encumbrance = 12,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 6, coverage = 95 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_head_medium_reinforced",
    copy_from = "combat_exoskeleton_armor_head_heavy",
    name = ccb.content.text("reinforced medium combat exoskeleton head armor"),
    description = ccb.content.text("This 4mm thick exoskeleton armor will allow you to withstand a lead storm while also giving you the mobility to escape it, if the hail ends up being made of heavier calibers than standard rifle rounds.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "3000 ml",
    mass = "3100 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "head" },
                encumbrance = 10,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "mouth" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 4 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "eyes" },
                encumbrance = 0,
                coverage = 100,
                materials = { { id = "lvl4ballisticglass", thickness = 2 } },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_torso_medium_reinforced",
    copy_from = "combat_exoskeleton_armor_torso_heavy",
    name = ccb.content.text("reinforced medium combat exoskeleton torso armor"),
    description = ccb.content.text("This 4mm thick exoskeleton armor will allow you to withstand a lead storm while also giving you the mobility to escape it, if the hail ends up being made of heavier calibers than standard rifle rounds.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "10600 ml",
    mass = "11200 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "torso" },
                encumbrance = 10,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_arm_medium_reinforced",
    copy_from = "combat_exoskeleton_armor_arm_heavy",
    name = ccb.content.text("reinforced medium combat exoskeleton arm armor"),
    description = ccb.content.text("This 4mm thick exoskeleton armor will allow you to withstand a lead storm while also giving you the mobility to escape it, if the hail ends up being made of heavier calibers than standard rifle rounds.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "8500 ml",
    mass = "9000 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "arm_r", "arm_l" },
                encumbrance = 10,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_back_r", "hand_back_l", "hand_wrist_r", "hand_wrist_l" },
                encumbrance = 10,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_palm_r", "hand_palm_l", "hand_fingers_r", "hand_fingers_l" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 1.1, ignore_sheet_thickness = true },
                    { id = "qt_steel_chain", thickness = 1.2 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_leg_medium_reinforced",
    copy_from = "combat_exoskeleton_armor_leg_heavy",
    name = ccb.content.text("reinforced medium combat exoskeleton leg armor"),
    description = ccb.content.text("This 4mm thick exoskeleton armor will allow you to withstand a lead storm while also giving you the mobility to escape it, if the hail ends up being made of heavier calibers than standard rifle rounds.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "8800 ml",
    mass = "9400 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "leg_r", "leg_l" },
                encumbrance = 10,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "foot_r", "foot_l" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                encumbrance = 10,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 4, coverage = 95 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_head_light_reinforced",
    copy_from = "combat_exoskeleton_armor_head_heavy",
    name = ccb.content.text("reinforced light combat exoskeleton head armor"),
    description = ccb.content.text("This 2mm thick exoskeleton armor was designed when the testing of heavier versions concluded that mobility is actually the most important attribute on the battlefield, especially when you can still brush off small caliber rounds.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "2200 ml",
    mass = "2500 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "head" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "mouth" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel", thickness = 2 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "eyes" },
                encumbrance = 0,
                coverage = 100,
                materials = { { id = "lvl4ballisticglass", thickness = 2 } },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_torso_light_reinforced",
    copy_from = "combat_exoskeleton_armor_torso_heavy",
    name = ccb.content.text("reinforced light combat exoskeleton torso armor"),
    description = ccb.content.text("This 2mm thick exoskeleton armor was designed when the testing of heavier versions concluded that mobility is actually the most important attribute on the battlefield, especially when you can still brush off small caliber rounds.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "7900 ml",
    mass = "9000 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "torso" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_arm_light_reinforced",
    copy_from = "combat_exoskeleton_armor_arm_heavy",
    name = ccb.content.text("reinforced light combat exoskeleton arm armor"),
    description = ccb.content.text("This 2mm thick exoskeleton armor was designed when the testing of heavier versions concluded that mobility is actually the most important attribute on the battlefield, especially when you can still brush off small caliber rounds.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "6400 ml",
    mass = "7300 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "arm_r", "arm_l" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_back_r", "hand_back_l", "hand_wrist_r", "hand_wrist_l" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "hand_r", "hand_l" },
                subparts = { "hand_palm_r", "hand_palm_l", "hand_fingers_r", "hand_fingers_l" },
                encumbrance = 0,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 1 },
                    { id = "kevlar_layered", thickness = 1.1, ignore_sheet_thickness = true },
                    { id = "qt_steel_chain", thickness = 1.2 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}

ccb.content.define_item {
    id = "combat_exoskeleton_armor_leg_light_reinforced",
    copy_from = "combat_exoskeleton_armor_leg_heavy",
    name = ccb.content.text("reinforced light combat exoskeleton leg armor"),
    description = ccb.content.text("This 2mm thick exoskeleton armor was designed when the testing of heavier versions concluded that mobility is actually the most important attribute on the battlefield, especially when you can still brush off small caliber rounds.  This armor has been reinforced with chainmail to fill its gaps."),
    volume = "6600 ml",
    mass = "7500 g",
    armor = {
        portions = {
            {
                layers = { "OUTER" },
                covers = { "leg_r", "leg_l" },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
            {
                layers = { "OUTER" },
                covers = { "foot_r", "foot_l" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                encumbrance = 8,
                coverage = 100,
                materials = {
                    { id = "nylon", thickness = 1, coverage = 5 },
                    { id = "plastic_pad", thickness = 2 },
                    { id = "kevlar_layered", thickness = 4.4 },
                    { id = "qt_steel_chain", thickness = 1.2 },
                    { id = "qt_steel", thickness = 2, coverage = 95 },
                },
            },
        },
    },
    inheritance = { scale = { price = 1.1, survival_price = 1.1 } },
}
