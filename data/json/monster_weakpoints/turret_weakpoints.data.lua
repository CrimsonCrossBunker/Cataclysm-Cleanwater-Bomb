local ccb = require("ccb")

-- Low coverage values reflect the player being jumpy and trying to avoid standing still.
ccb.content.define_weakpoint_set {
    id = "wps_turret",
    points = {
        {
            id = "main_motor",
            name = ccb.content.text("the main motor"),
            coverage = 15,
            difficulty = { melee = 4, ranged = 6 },
            attack_coverage = { bash = 0.5 },
            armor_multiplier = { stab = 0.5, cut = 1.1 },
            effects = {
                {
                    effect = "stunned",
                    chance = 35,
                    duration = { "2 seconds", "3 seconds" },
                    message = ccb.content.text("The %s's motor starts to jam up!"),
                    damage_percent = { 5, 20 },
                },
                {
                    effect = "stunned",
                    chance = 55,
                    permanent = true,
                    message = ccb.content.text("The %s's motor grinds to a halt!"),
                    damage_percent = { 21, 100 },
                },
            },
        },
        {
            id = "camera",
            name = ccb.content.text("the camera"),
            head = true,
            coverage = 5,
            difficulty = { broad = 6, point = 7 },
            effects = {
                {
                    effect = "blind",
                    chance = 40,
                    message = ccb.content.text("The %s's camera is lightly scratched!"),
                    damage_percent = { 1, 5 },
                },
                {
                    effect = "blind",
                    duration = { "3 seconds", "4 seconds" },
                    chance = 70,
                    message = ccb.content.text("The %s's camera is cracked!"),
                    damage_percent = { 6, 25 },
                },
                {
                    effect = "blind",
                    permanent = true,
                    chance = 90,
                    message = ccb.content.text("The %s's camera lens shatters into pieces!"),
                    damage_percent = { 26, 100 },
                },
            },
        },
        {
            id = "turret_gun",
            name = ccb.content.text("the weapon"),
            head = true,
            coverage = 20,
            difficulty = { melee = 4, ranged = 5 },
            armor_multiplier = { bash = 0.5, stab = 0.5, cut = 0.75 },
            effects = {
                {
                    effect = "stunned",
                    chance = 50,
                    message = ccb.content.text("The %s struggles to clear its jammed weapon!"),
                    damage_percent = { 15, 30 },
                },
                {
                    effect = "stunned",
                    chance = 55,
                    permanent = true,
                    message = ccb.content.text("A round gets stuck in the %s's misshapen barrel, disabling the weapon!"),
                    damage_percent = { 31, 100 },
                },
            },
        },
        {
            id = "turret_shaft",
            name = ccb.content.text("the shaft"),
            coverage = 30,
            difficulty = { melee = 1, ranged = 6 },
            armor_multiplier = { bash = 0.75, stab = 1.5 },
        },
    },
}

-- Coverage is higher because searchlights are not very threatening.
ccb.content.define_weakpoint_set {
    id = "wps_searchlight",
    points = {
        {
            id = "camera",
            name = ccb.content.text("the camera"),
            head = true,
            coverage = 10,
            difficulty = { broad = 6, point = 7 },
            effects = {
                {
                    effect = "blind",
                    chance = 40,
                    message = ccb.content.text("The %s's camera is lightly scratched!"),
                    damage_percent = { 1, 5 },
                },
                {
                    effect = "blind",
                    duration = { "3 seconds", "4 seconds" },
                    chance = 70,
                    message = ccb.content.text("The %s's camera is cracked!"),
                    damage_percent = { 6, 25 },
                },
                {
                    effect = "blind",
                    permanent = true,
                    chance = 90,
                    message = ccb.content.text("The %s's camera lens shatters into pieces!"),
                    damage_percent = { 26, 100 },
                },
            },
        },
        {
            id = "spotlight",
            name = ccb.content.text("the spotlight"),
            head = true,
            coverage = 25,
            difficulty = { broad = 3, point = 4 },
            armor_multiplier = { all = 0.5 },
        },
    },
}
