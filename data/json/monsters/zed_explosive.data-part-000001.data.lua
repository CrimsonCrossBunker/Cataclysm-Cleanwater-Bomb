local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_gasbag",
    name = ccb.content.plural_text("bloated zombie", "bloated zombies"),
    description = ccb.content.text("With its gray skin swollen to near-rupture with putrid gas, this cyst-covered zombie looks like it could violently burst under the slightest of disturbances."),
    copy_from = "mon_boomer",
    hp = 15,
    speed = 80,
    color = "magenta_yellow",
    emissions = { { id = "emit_toxic_leak", delay = "1 s" } },
    attacks = { { reference = "SUICIDE", cooldown = 20 }, { reference = "scratch", cooldown = 15 } },
    fungalize_into = "mon_gasbag_dusted",
    armor = { electric = 1 },
    inheritance = {
        remove = {
            flags = { "BILE_BLOOD", "BASHES", "GROUP_BASH", "GRABS", "PUSH_MON" },
            attacks = { "boomer_bile" },
        },
    },
    death = {
        outcome = {
            message = ccb.content.text("The %s explodes!"),
            spell = { id = "death_gas", hit_self = true },
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_relax_gasbag",
    name = ccb.content.plural_text("sleepwalker zombie", "sleepwalker zombies"),
    description = ccb.content.text("A zombie swollen with a bluish, oddly sweet smelling gas.  It stumbles around even more than regular zombies, as if heavily intoxicated."),
    copy_from = "mon_zombie_gasbag",
    difficulty_adjustment = 10,
    hp = 40,
    speed = 70,
    color = "magenta_cyan",
    emissions = { { id = "emit_relax_gas_leak", delay = "1 s" } },
    death = {
        outcome = {
            message = ccb.content.text("The %s explodes!"),
            spell = { id = "death_relax_gas", hit_self = true },
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_tear_gasbag",
    name = ccb.content.plural_text("swollen tearjerker", "swollen tearjerkers"),
    description = ccb.content.text("A bloated corpse, its ballooning skin blistered and rashy and its face caked in mucus.  The off-color orange gas that occasionally leaks from it makes your eyes water and smells faintly of pepper."),
    copy_from = "mon_zombie_gasbag",
    difficulty_adjustment = 9,
    hp = 45,
    speed = 60,
    color = "yellow",
    melee_skill = 2,
    vision_night = 2,
    emissions = { { id = "emit_tear_gas_leak", delay = "1 s" } },
    death = {
        outcome = {
            message = ccb.content.text("The %s explodes!"),
            spell = { id = "death_tearburst", hit_self = true },
            corpse = "NO_CORPSE",
        },
    },
}
