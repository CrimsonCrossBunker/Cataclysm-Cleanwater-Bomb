local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "euzhvil_slam",
    cooldown = 1,
    move_cost = 200,
    accuracy = 4,
    damage = { { type = "bash", amount = 20 } },
    avatar_hit = ccb.content.text("%1$s slams you!"),
    npc_hit = ccb.content.text("%1$s slams <npcname>!"),
    avatar_miss = ccb.content.text("%1$s tries to slam you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to slam <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s slams you without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s slams <npcname> without penetrating their armor."),
}
