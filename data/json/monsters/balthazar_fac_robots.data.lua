local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_secubot_balthazar",
    copy_from = "mon_secubot",
    default_faction = "balthazar",
    aggression = 9,
    aggressive_to_characters = true,
    anger_triggers = { "FRIEND_ATTACKED", "FRIEND_DIED", "HURT" },
    starting_ammo = { ["556"] = 60 },
    pathing = { max_distance = 30, avoid_traps = true },
    death = {
        outcome = { corpse = "BROKEN", on_death = "w16b_mon_die_dda_ff5c065ee8cb" },
    },
}

ccb.content.define_monster {
    id = "mon_turret_rifle_balthazar",
    copy_from = "mon_turret_rifle",
    default_faction = "balthazar",
    aggression = 9,
    aggressive_to_characters = true,
    anger_triggers = { "FRIEND_ATTACKED", "FRIEND_DIED", "HURT" },
    starting_ammo = { ["556"] = 1600 },
    death = {
        outcome = { corpse = "BROKEN", on_death = "w16b_mon_die_dda_2b4325f0fd26" },
    },
}
