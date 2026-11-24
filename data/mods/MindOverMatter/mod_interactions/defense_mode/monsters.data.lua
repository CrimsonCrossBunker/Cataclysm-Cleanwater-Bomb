local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_human_bio_dm",
    copy_from = "mon_feral_human_bio",
    species = { "HUMAN" },
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_clair_dm",
    copy_from = "mon_feral_human_clair",
    species = { "HUMAN" },
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_pyrokin_dm",
    copy_from = "mon_feral_human_pyrokin",
    species = { "HUMAN" },
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_telekin_dm",
    copy_from = "mon_feral_human_telekin",
    species = { "HUMAN" },
    attacks = {
        {
            id = "psi_telekin1_telegrab",
            spell = { id = "telekinetic_pull_monster", min_level = 2 },
            cooldown = 15,
            casting_message = ccb.content.text("%1$s stares at %3$s and %3$s is lifted up and pulled towards them!"),
            kind = "spell",
        },
        {
            cooldown = 5,
            move_cost = 50,
            kind = "gun",
            gun = {
                weapon = "feral_human_thrown_rock",
                ammo = "rock",
                empty_sound = "",
                skills = { { id = "throw", level = 6 } },
                strength = 11,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 10, mode = "DEFAULT" } },
                description = ccb.content.text("%1$s makes a throwing motion and one of the rocks around them suddenly launches like a bullet!"),
            },
        },
        {
            id = "smash",
            move_cost = 80,
            cooldown = 10,
            damage = { { type = "psi_telekinetic_damage", amount = 10, penetration = 10 } },
            minimum_hit_size = 12,
            range = 6,
            throw_strength = 30,
            blockable = false,
            effects_require_damage = false,
            avatar_hit = ccb.content.text_without_extraction("%1$s stares at you and a powerful force hurls you through the air!"),
            npc_hit = ccb.content.text_without_extraction("%1$s stares at <npcname> and a powerful force hurls them through the air!"),
            avatar_miss = ccb.content.text_without_extraction("%s stares at you, and you feel a crushing pressure for a moment before the feeling vanishes!"),
            npc_miss = ccb.content.text_without_extraction("%s stares at <npcname> but nothing happens!"),
        },
    },
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_teep_dm",
    copy_from = "mon_feral_human_teep",
    species = { "HUMAN" },
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_porter_dm",
    copy_from = "mon_feral_human_porter",
    species = { "HUMAN" },
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_vita_dm",
    copy_from = "mon_feral_human_vita",
    species = { "HUMAN" },
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}
