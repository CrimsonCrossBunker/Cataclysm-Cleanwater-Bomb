local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_starer_pipe",
    name = ccb.content.plural_text("starer", "starers"),
    description = ccb.content.text("A horribly burned human, reeking of charred meat.  Their flesh has mended into a leathery shell, and the pupils of their wide-open eyes are dilated and the iris and sclera are bloodshot.  Somehow they still breathe, in deep, ragged gulps."),
    copy_from = "mon_feral_human_pipe",
    looks_like = "mon_zombie_scorched",
    default_faction = "fungus",
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 2 } },
                dexterity = 6,
                perception = 6,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The starer throws a rock!"),
            },
            when = "monster_attack_intact_arms",
        },
        { id = "feral_weapon_pipe" },
    },
    harvest = "exempt",
    flags = {
        "SEES", "HEARS", "SMELLS", "WARM", "BASHES", "GROUP_BASH", "HUMAN", "CAN_OPEN_DOORS",
        "PATH_AVOID_DANGER", "DROPS_AMMO", "NO_FUNG_DMG", "WIELDED_WEAPON",
    },
    death = {
        drops = "starer_death_drops_pipe",
        outcome = {
            spell = { id = "death_smokeburst", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_starer_crowbar",
    description = ccb.content.text("A horribly burned human, reeking of charred meat.  Their flesh has mended into a leathery shell, and the pupils of their wide-open eyes are dilated and the iris and sclera are bloodshot.  Somehow they still breathe, in deep, ragged gulps."),
    copy_from = "mon_starer_pipe",
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 2 } },
                dexterity = 6,
                perception = 6,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 5, mode = "DEFAULT" } },
                description = ccb.content.text("The starer throws a rock!"),
            },
            when = "monster_attack_intact_arms",
        },
        { id = "feral_weapon_crowbar" },
    },
    death = { drops = "starer_death_drops_crowbar" },
}

ccb.content.define_monster {
    id = "mon_starer_axe",
    description = ccb.content.text("A horribly burned human, reeking of charred meat.  Their flesh has mended into a leathery shell, and the pupils of their wide-open eyes are dilated and the iris and sclera are bloodshot.  Somehow they still breathe, in deep, ragged gulps."),
    copy_from = "mon_starer_pipe",
    attacks = { { id = "feral_weapon_axe" } },
    death = { drops = "starer_death_drops_axe" },
}
