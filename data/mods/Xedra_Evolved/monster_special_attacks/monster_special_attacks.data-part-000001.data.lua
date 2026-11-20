local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "salamagman_handaxe",
    cooldown = 1,
    move_cost = 134,
    accuracy = 4,
    damage = { { type = "bash", amount = 14 }, { type = "cut", amount = 28 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an axe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an hand axe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "salamagman_battleaxe",
    cooldown = 1,
    move_cost = 134,
    accuracy = 5,
    damage = { { type = "bash", amount = 14 }, { type = "cut", amount = 28 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an axe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an axe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "salamagman_macuahuitl",
    cooldown = 1,
    move_cost = 134,
    accuracy = 5,
    damage = { { type = "bash", amount = 14 }, { type = "cut", amount = 36 }, { type = "heat", amount = 12 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an axe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an axe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "march_lord_sword_spring",
    cooldown = 2,
    move_cost = 119,
    accuracy = 8,
    damage = {
        { type = "bash", amount = 8 },
        { type = "cut", amount = 42 },
        { type = "biological", amount = 9 },
    },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an ethereal blade!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an ethereal blade!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "march_lord_sword_summer",
    cooldown = 2,
    move_cost = 119,
    accuracy = 8,
    damage = { { type = "bash", amount = 8 }, { type = "cut", amount = 42 }, { type = "heat", amount = 9 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an ethereal blade!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an ethereal blade!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "march_lord_sword_autumn",
    cooldown = 2,
    move_cost = 119,
    accuracy = 8,
    damage = {
        { type = "bash", amount = 8 },
        { type = "cut", amount = 42 },
        { type = "withering_damage", amount = 9 },
    },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an ethereal blade!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an ethereal blade!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "march_lord_sword_winter",
    cooldown = 2,
    move_cost = 119,
    accuracy = 8,
    damage = { { type = "bash", amount = 8 }, { type = "cut", amount = 42 }, { type = "cold", amount = 9 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an ethereal blade!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an ethereal blade!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "ice_spray",
    cooldown = 5,
    move_cost = 100,
    range = 8,
    damage = { { type = "cold", amount = 6 }, { type = "cut", amount = 6 } },
    avatar_hit = ccb.content.text("%1$s sprays icicles at your %2$s!"),
    npc_hit = ccb.content.text("%1$s sprays icicles at <npcname>!"),
    avatar_no_damage = ccb.content.text("%1$s sprays icicles out at you without doing any damage."),
    npc_no_damage = ccb.content.text("%1$s sprays icicles out at <npcname> without doing any damage."),
    avatar_miss = ccb.content.text("%s sprays icicles at you, but you dodge!"),
    npc_miss = ccb.content.text("%s sprays icicles at <npcname>, but they dodge!"),
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "ratatosks_curse",
    cooldown = 10,
    move_cost = 100,
    minimum_hit_size = 4,
    attack_upper = false,
    damage = { { type = "bash", amount = 0 } },
    effects_require_damage = false,
    avatar_hit = ccb.content.text("%1$s curses you and you fall to the ground!"),
    npc_hit = ccb.content.text("%1$s curses <npcname> and they fall to the ground!"),
    avatar_no_damage = ccb.content.text("%1$s tries to curse %2$s and knock you down!"),
    npc_no_damage = ccb.content.text("%1$s tries to curse and knock <npcname> down!"),
    avatar_miss = ccb.content.text("%1$s tries to curse your %2$s but you dodge!"),
    npc_miss = ccb.content.text("%s tries to curse and knock down <npcname>, but they dodge!"),
    effects = { { id = "downed", duration = 3 }, { id = "stunned", duration = 100 } },
}
