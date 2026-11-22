local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_amalgamation_vitakinetic_debuffer",
    name = "enervating amalgamation",
    description = "An elongated body moving irregularly on five legs, with two flexible tentacles waving in the air as it moves.  It seems to have no head, with a ring of black spots on top that might be sensory organs.  Its skin is perfectly smooth and greyish-white, without a single spot or blemish.",
    copy_from = "mon_amalgamation_abstract_small",
    symbol = "ä",
    speed = 95,
    regenerates = 3,
    attacks = {
        {
            kind = "melee",
            id = "mon_amalgamation_vitakinetic_debuff",
            move_cost = 60,
            accuracy = 6,
            dodgeable = true,
            blockable = true,
            cooldown = { 7, 21 },
            damage = {
                { type = "biological", amount = 1 },
            },
            avatar_hit = "%1$s touches you and you feel weaker!",
            avatar_miss = "%1$s tries to touch you, but you dodge!",
            avatar_no_damage = "%1$s touches you and you feel weaker!",
            npc_hit = "%1$s touches <npcname> and they flinch!",
            npc_miss = "%1$s tries to touch <npcname>, but they dodge!",
            npc_no_damage = "%1$s touches <npcname> and they flinch!",
            when = "w16b_mon_when_mindovermatter_eb30c877ac7c",
            on_hit = "w16b_mon_hit_mindovermatter_6cf230094803",
        },
    },
    inheritance = {
        add = {
            flags = { "HIT_AND_RUN" },
        },
    },
}
