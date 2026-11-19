local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_infected",
    name = ccb.content.plural_text("party rocker", "party rockers"),
    copy_from = "mon_feral_human_pipe_fungal_infected",
    description = ccb.content.text("A party rocker who's not dancing with as much energy, and they seem to be stopping often to cough and catch their breath."),
    death = { drops = "party_rocker_death_drop_pipe" },
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar_fungal_corpse",
    name = ccb.content.plural_text("party rocker", "party rockers"),
    copy_from = "mon_feral_human_pipe_fungal_corpse",
    description = ccb.content.text("A party rocker who's grown painful mushroom stalks out of their body, writhing in pain as their last neurons still instruct them to dance."),
    death = { drops = "party_rocker_death_drop_pipe" },
}

ccb.content.define_monster {
    id = "mon_immortal_snail",
    name = ccb.content.plural_text("immortal snail", "immortal snails"),
    description = ccb.content.text("A small nondescript immortal snail that is slowly but relentlessly making its way toward you.  You get a strong feeling you should not touch the snail."),
    copy_from = "mon_snail_forest",
    default_faction = "nether_player_hate",
    volume = "300 ml",
    mass = "100 g",
    difficulty_adjustment = 9001,
    hp = 1000000,
    regenerates = 1000000,
    bleed_rate = 0,
    speed = 70,
    aggression = 100,
    morale = 100,
    vision_day = 60,
    vision_night = 60,
    pathing = {
        max_distance = 60,
        open_doors = false,
        avoid_traps = false,
        avoid_sharp = false,
        avoid_dangerous_fields = false,
    },
    move_skills = { swim = 5, climb = 5 },
    upgrade = false,
    aggressive_to_characters = true,
    melee_skill = 6,
    flags = {
        "NEMESIS", "SMALL_HIDER", "SMALLSLUDGETRAIL", "NOHEAD", "NO_BREATHE", "SEES", "HEARS",
        "ACIDPROOF", "CAN_OPEN_DOORS", "FIREPROOF", "BIOLOGICALPROOF", "SLUDGEPROOF", "SMELLS",
        "STUN_IMMUNE", "WEBWALK", "ALWAYS_SEES_YOU", "NO_FUNG_DMG",
    },
    attacks = {
        {
            cooldown = 0,
            damage = { { type = "pure", amount = 100000 } },
            dodgeable = true,
            blockable = false,
            avatar_hit = ccb.content.text("%s touches you, killing you instantly."),
            avatar_no_damage = ccb.content.text("%s touches you, yet somehow you live!"),
            avatar_miss = ccb.content.text("%s tries to touch you, but misses."),
            kind = "melee",
        },
    },
    inheritance = { remove = { fear_triggers = { "PLAYER_CLOSE" } } },
}
