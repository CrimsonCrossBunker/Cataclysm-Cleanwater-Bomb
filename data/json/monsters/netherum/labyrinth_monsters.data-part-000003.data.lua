local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_fleshborg_1_2",
    name = ccb.content.plural_text("advanced fleshborg", "advanced fleshborgs"),
    description = ccb.content.text("Compared to the cyborgs you've seen elsewhere, this one looks almost inverted.  Its body is made of smooth, segmented, paper-thin metallic plates; fleshy protrusions and bits of bone jut from components growing off this base frame.  In place of one hand is a wired airgun.  It moves with dire purpose, like a trained combat machine."),
    copy_from = "mon_fleshborg_1_1",
    melee_skill = 6,
    dodge = 8,
    melee_dice = 3,
    starting_ammo = { bone_dart = 20 },
    attacks = {
        {
            cooldown = 10,
            move_cost = 100,
            kind = "gun",
            gun = {
                weapon = "bone_dart_launcher",
                ammo = "bone_dart",
                skills = { { id = "throw", level = 4 } },
                strength = 14,
                lock_player = false,
                ranges = { { minimum = 4, maximum = 7, mode = "DEFAULT" } },
                description = ccb.content.text("The fleshborg launches a bony dart at you!"),
            },
            when = "monster_attack_intact_arms",
        },
    },
}
