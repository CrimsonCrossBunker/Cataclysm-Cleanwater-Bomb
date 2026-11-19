local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_acidic",
    name = ccb.content.plural_text("acidic zombie", "acidic zombies"),
    description = ccb.content.text("A sickly-looking zombie.  Its skin looks especially thin, with a sticky, yellow fluid flowing through the clearly visible veins."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 5,
    hp = 65,
    color = "light_gray_yellow",
    melee_skill = 3,
    harvest = "zombie_humanoid_acid",
    upgrade = { half_life = 120, monster = "mon_zombie_spitter" },
    fungalize_into = "mon_zombie_acidic_dusted",
    inheritance = {
        add = {
            flags = { "ACIDPROOF", "ACID_BLOOD", "CLUMSY_ATTACKS" },
            attacks = { { reference = "ACID_BARF", cooldown = 10 } },
        },
    },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}
