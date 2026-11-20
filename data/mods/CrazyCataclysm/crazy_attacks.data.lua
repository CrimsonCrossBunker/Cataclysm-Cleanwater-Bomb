local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "party_rocker_pipe",
    cooldown = 1,
    move_cost = 67,
    accuracy = 3,
    damage = { { type = "bash", amount = 4 }, { type = "cut", amount = 4 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a pipe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a pipe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "party_rocker_bottle",
    cooldown = 1,
    move_cost = 67,
    accuracy = 3,
    damage = { { type = "bash", amount = 1 }, { type = "cut", amount = 6 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a bottle!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a bottle!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}
