local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "hypo_pkill",
    cooldown = 5,
    move_cost = 0,
    damage = { { type = "stab", amount = 5, penetration = 15, armor_multiplier = 0.2 } },
    effects = { { id = "pkill3", duration = 300 }, { id = "pkill2", duration = 600 } },
    avatar_hit = ccb.content.text("%1$s injects you with a syringe!"),
    npc_hit = ccb.content.text("%1$s injects <npcname> with a syringe!"),
    avatar_no_damage = ccb.content.text("%1$s tries to inject you, but fails to penetrate your armor!"),
    npc_no_damage = ccb.content.text("%1$s tries to inject <npcname>, but fails to penetrate their armor!"),
}
