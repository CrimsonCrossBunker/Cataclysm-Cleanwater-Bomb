local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "inject_warping_poison",
    cooldown = 25,
    move_cost = 150,
    damage = { { type = "stab", amount = 15, penetration = 8, armor_multiplier = 0.5 } },
    minimum_hit_size = 4,
    avatar_hit = ccb.content.text("%1$s bites and injects poison into your %2$s!"),
    npc_hit = ccb.content.text("%1$s bites and injects poison into <npcname>!"),
    avatar_miss = ccb.content.text("%1$s tries to bite your %2$s, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to bite <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s tries to bite your %2$s, but fails to penetrate your armor."),
    npc_no_damage = ccb.content.text("%1$s tries to bite <npcname>, but fails to penetrate their armor."),
    dodgeable = true,
    blockable = true,
    on_hit = "inject_warping_poison",
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "xe_light_healing",
    name = ccb.content.text_without_extraction("Cure Light Wounds"),
    description = ccb.content.text_without_extraction("Heals a little bit of damage on the target."),
    valid_targets = { "self" },
    min_damage = -5,
    max_damage = -20,
    damage_increment = -1.0,
    max_level = 15,
    min_range = 0,
    max_range = 4,
    range_increment = 0.75,
    effect = "attack",
    shape = "blast",
    base_casting_time = 300,
    base_energy_cost = 800,
    flags = { "SOMATIC", "VERBAL", "NO_PROJECTILE" },
    spell_class = "NONE",
    difficulty = 2,
    energy_source = "NONE",
}

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

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "death_ratking",
    name = ccb.content.text_without_extraction("Rat King Death"),
    description = ccb.content.text_without_extraction("Rat king dies."),
    valid_targets = { "hostile", "ally" },
    shape = "blast",
    flags = { "NO_EXPLOSION_SFX" },
    effect = "remove_effect",
    effect_data = "rat",
    min_range = 48,
    max_range = 48,
    extra_spells = { { spell = "ratking_summon_rats", self = true } },
}

ccb.content.define_spell {
    id = "vampire_suck",
    shape = "blast",
    damage_type = "stab",
    name = ccb.content.text_without_extraction("Sucking bite"),
    description = ccb.content.text_without_extraction("Sucks blood from one foe."),
    flags = { "NO_HANDS", "NO_LEGS" },
    valid_targets = { "hostile" },
    min_damage = 15,
    damage_increment = 1.0,
    max_damage = 25,
    min_range = 1,
    max_range = 1,
    max_level = 10,
    impact_handler = "w16b_sp_imp_xedra_evolved_f971d7739905",
    extra_spells = {
        { spell = "xe_light_healing", self = true },
    },
}
