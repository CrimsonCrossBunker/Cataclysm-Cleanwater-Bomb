local ccb = require("ccb")

-- Feral melee skill + weapon's to hit, so 3+0=3
-- all melee damage is decreased by 10% with assumption it is at least `|/` broken
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_pipe",
    cooldown = 1,
    move_cost = 80,
    accuracy = 3,
    damage = { { type = "bash", amount = 9 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a pipe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a pipe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3+0=3
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_crowbar",
    cooldown = 1,
    move_cost = 97,
    accuracy = 3,
    damage = { { type = "bash", amount = 17 }, { type = "cut", amount = 1 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a crowbar!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a crowbar!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 6+3=9
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_PR24",
    cooldown = 1,
    move_cost = 108,
    accuracy = 9,
    damage = { { type = "bash", amount = 13 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a baton!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a baton!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3-1=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_stick",
    cooldown = 1,
    move_cost = 130,
    accuracy = 2,
    damage = { { type = "bash", amount = 13 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a stick!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a stick!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3+0=3
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_axe",
    cooldown = 1,
    move_cost = 134,
    accuracy = 3,
    damage = { { type = "bash", amount = 13 }, { type = "cut", amount = 25 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an axe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an axe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3-1=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_shotgun_melee",
    cooldown = 1,
    move_cost = 160,
    accuracy = 2,
    damage = { { type = "bash", amount = 12 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a shotgun!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a shotgun!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 2+1=3
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_broom",
    cooldown = 1,
    move_cost = 100,
    accuracy = 3,
    damage = { { type = "bash", amount = 4 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a broom!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a broom!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3-1=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_knife_chef",
    cooldown = 1,
    move_cost = 72,
    accuracy = 2,
    damage = { { type = "bash", amount = 2 }, { type = "stab", amount = 14 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a knife!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a knife!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 2-1=1
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_candlestick",
    cooldown = 1,
    move_cost = 69,
    accuracy = 1,
    damage = { { type = "bash", amount = 3 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a candlestick!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a candlestick!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4+2=6
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_rapier",
    cooldown = 1,
    move_cost = 107,
    accuracy = 6,
    damage = { { type = "bash", amount = 3 }, { type = "stab", amount = 26 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a rapier!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a rapier!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4+2=6
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_rapier_fake",
    cooldown = 1,
    move_cost = 95,
    accuracy = 6,
    damage = { { type = "bash", amount = 8 }, { type = "stab", amount = 3 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a rapier!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a rapier!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3+1=4
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_battleaxe",
    cooldown = 1,
    move_cost = 139,
    accuracy = 4,
    damage = { { type = "bash", amount = 17 }, { type = "cut", amount = 3 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a battle axe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a battle axe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3+1=4
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_mace",
    cooldown = 1,
    move_cost = 97,
    accuracy = 4,
    damage = { { type = "bash", amount = 14 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a mace!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a mace!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4+0=4
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_wrench_large",
    cooldown = 1,
    move_cost = 100,
    accuracy = 4,
    damage = { { type = "bash", amount = 11 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a wrench!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a wrench!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4-2=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_lug_wrench",
    cooldown = 1,
    move_cost = 98,
    accuracy = 2,
    damage = { { type = "bash", amount = 10 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a lug wrench!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a lug wrench!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4-2=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_mop_folded",
    cooldown = 1,
    move_cost = 89,
    accuracy = 2,
    damage = { { type = "bash", amount = 3 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a mop!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a mop!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4+0=4
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_crash_axe",
    cooldown = 1,
    move_cost = 96,
    accuracy = 4,
    damage = { { type = "bash", amount = 9 }, { type = "cut", amount = 18 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with an axe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with an axe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 6-1=5
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_knife_combat",
    cooldown = 1,
    move_cost = 82,
    accuracy = 5,
    damage = { { type = "stab", amount = 20 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a knife!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a knife!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3-1=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_knife_combat_low_skill",
    cooldown = 1,
    move_cost = 82,
    accuracy = 2,
    damage = { { type = "stab", amount = 20 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a knife!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a knife!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3-1=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_spear_knife",
    cooldown = 1,
    move_cost = 119,
    accuracy = 2,
    range = 2,
    damage = { { type = "bash", amount = 4 }, { type = "stab", amount = 23 } },
    avatar_hit = ccb.content.text("%1$s thrusts a spear at your %2$s, slashing it!"),
    npc_hit = ccb.content.text("%1$s thrusts a spear at <npcname>'s %2$s, slashing it!"),
    avatar_no_damage = ccb.content.text("%1$s thrusts a spear at your %2$s, but glances off your armor!"),
    npc_no_damage = ccb.content.text("%1$s thrusts a spear at <npcname>'s %2$s, but glances off armor!"),
    avatar_miss = ccb.content.text("%s thrusts a spear at you, but you evade!"),
    npc_miss = ccb.content.text("%s thrusts a spear at <npcname>, but they evade!"),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3-1=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_hammer",
    cooldown = 1,
    move_cost = 79,
    accuracy = 2,
    damage = { { type = "bash", amount = 8 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a hammer!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a hammer!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3+3=6
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_shovel",
    cooldown = 1,
    move_cost = 154,
    accuracy = 6,
    damage = { { type = "bash", amount = 13 }, { type = "cut", amount = 3 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a shovel!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a shovel!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 6-1=5
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_makeshift_machete",
    cooldown = 1,
    move_cost = 106,
    accuracy = 5,
    damage = { { type = "bash", amount = 5 }, { type = "cut", amount = 14 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a machete!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a machete!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4-3=1
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_scalpel",
    cooldown = 1,
    move_cost = 65,
    accuracy = 1,
    damage = { { type = "cut", amount = 6 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a scalpel!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a scalpel!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 6+0=6
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_heavy_flashlight",
    cooldown = 1,
    move_cost = 79,
    accuracy = 6,
    damage = { { type = "bash", amount = 7 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a flashlight!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a flashlight!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4-2=2
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_m18",
    cooldown = 1,
    move_cost = 84,
    accuracy = 2,
    damage = { { type = "bash", amount = 7 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a gun!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a gun!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 6-1=5
-- Stats based on AR-15/M4 Carbine (they are identical in melee), since that's what mad militia drops. Move cost was tested on a 10 in all stats character ingame, since HHG doesn't account for the default attachments
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_feral_militia_gun",
    cooldown = 1,
    move_cost = 179,
    accuracy = 5,
    damage = { { type = "bash", amount = 11 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a rifle!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a rifle!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 4-1=3
-- Stats based on M4 Carbine with an attached combat knife, since that's the most common gun feral marines drop. Move cost was tested on a 10 in all stats character ingame, since HHG doesn't account for the default attachments
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_feral_m4_carbine_bayonet",
    cooldown = 1,
    move_cost = 196,
    accuracy = 3,
    damage = { { type = "bash", amount = 11 }, { type = "stab", amount = 20 } },
    avatar_hit = ccb.content.text("%1$s lunges their bayonet at your %2$s, stabbing it!"),
    npc_hit = ccb.content.text("%1$s lunges their bayonet at <npcname>'s %2$s, stabbing it!"),
    avatar_no_damage = ccb.content.text("%1$s thrusts their bayonet at your %2$s, but it glances off your armor!"),
    npc_no_damage = ccb.content.text("%1$s thrusts their bayonet at <npcname>'s %2$s, but glances off armor!"),
    avatar_miss = ccb.content.text("%s thrusts their bayonet at you, but you evade!"),
    npc_miss = ccb.content.text("%s thrusts their bayonet at <npcname>, but they evade!"),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 6+2=8
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_baton-extended",
    cooldown = 1,
    move_cost = 79,
    accuracy = 8,
    damage = { { type = "bash", amount = 9 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a baton!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a baton!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 3+0=3
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_mace_pipe",
    cooldown = 1,
    move_cost = 103,
    accuracy = 3,
    damage = { { type = "bash", amount = 18 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a pipe!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a pipe!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}

-- Feral melee skill + weapon's to hit, so 5-2=3
ccb.content.define_monster_attack {
    kind = "melee",
    id = "feral_weapon_shiv",
    cooldown = 1,
    move_cost = 69,
    accuracy = 3,
    damage = { { type = "cut", amount = 6 } },
    avatar_hit = ccb.content.text("%1$s hits your %2$s with a shiv!"),
    npc_hit = ccb.content.text("%1$s hits <npcname>'s %2$s with a shiv!"),
    avatar_miss = ccb.content.text("%1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s hits your %2$s without penetrating your armor."),
    npc_no_damage = ccb.content.text("%1$s hits <npcname>'s %2$s without penetrating their armor."),
    when = "allow_armed_strike",
}
