local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "teleport_touch",
    move_cost = 80,
    cooldown = 15,
    accuracy = 5,
    damage = { { type = "psi_teleporter_teleporting_damage", amount = 2, penetration = 10 } },
    blockable = false,
    avatar_hit = ccb.content.text("%1$s touches you and the world warps around you!"),
    npc_hit = ccb.content.text("%1$s touches <npcname> and the world warps around them!"),
    avatar_miss = ccb.content.text("%s reaches for you but you avoid their touch!"),
    npc_miss = ccb.content.text("%s reaches for <npcname> but they dodge!"),
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "psychic_shriek",
    cooldown = 5,
    move_cost = 100,
    range = 3,
    damage = { { type = "psi_telepathic_damage", amount = 10 } },
    avatar_hit = ccb.content.text("%1$s shrieks at your %2$s!"),
    npc_hit = ccb.content.text("%1$s shrieks at <npcname>!"),
    avatar_no_damage = ccb.content.text("%1$s's shriek radiates out at you without doing any damage."),
    npc_no_damage = ccb.content.text("%1$s's shriek radiates out at <npcname> without doing any damage."),
    avatar_miss = ccb.content.text("%s's shriek radiates at you, but you dodge!"),
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "mind_blast_monster",
    move_cost = 80,
    cooldown = 15,
    accuracy = 5,
    range = 10,
    damage = { { type = "psi_telepathic_damage", amount = 15, penetration = 0 } },
    dodgeable = false,
    blockable = false,
    avatar_hit = ccb.content.text("%1$s looks at you and your mind reels!"),
    npc_hit = ccb.content.text("%1$s looks at <npcname> and they flinch as if struck!"),
    avatar_miss = ccb.content.text("%s looks at you but nothing happens!"),
    npc_miss = ccb.content.text("%s looks at <npcname> but nothing happens!"),
}
