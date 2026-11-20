local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_crowbar",
    description = ccb.content.text("Their pupils are dilated and what can be seen of the iris and sclera are bloodshot.  This crowbar-wielding maniac still breathes, but the zombies treat them like one of their own."),
    copy_from = "mon_feral_human_pipe",
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 3 } },
                strength = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The feral human throws a rock!"),
            },
            when = "monster_attack_intact_arms",
        },
        { id = "feral_weapon_crowbar" },
        { reference = "PARROT_AT_DANGER", cooldown = 0 },
    },
    fungalize_into = "mon_feral_human_crowbar_fungal_infected",
    death = { drops = "feral_humans_death_drops_crowbar" },
}
