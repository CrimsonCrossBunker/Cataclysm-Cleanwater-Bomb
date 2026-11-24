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

ccb.content.define_monster_attack {
    kind = "melee",
    id = "android_drop",
    cooldown = 10,
    move_cost = 100,
    minimum_hit_size = 4,
    attack_upper = false,
    damage = { { type = "bash", amount = 18, penetration = 15 } },
    effects_require_damage = true,
    avatar_hit = ccb.content.text("%1$s lifts you with its arm and slams you into the ground!"),
    npc_hit = ccb.content.text("%1$s effortlessly lifts <npcname> before slamming them into the ground!"),
    avatar_no_damage = ccb.content.text("%1$s tries to grab you, but finds no grip on your armor!"),
    npc_no_damage = ccb.content.text("%1$s tries to grab <npcname>, but finds no grip on their armor!"),
    avatar_miss = ccb.content.text("%s reaches for you with its arm, but you slip out of the way!"),
    npc_miss = ccb.content.text("%s tries to grab <npcname>, but they slip out of the way!"),
    effects = { { id = "downed", duration = 3 } },
    when = "allow_android_drop",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "android_crush",
    cooldown = 5,
    move_cost = 80,
    damage = { { type = "bash", amount = 30, penetration = 15 } },
    minimum_damage_multiplier = 0.3,
    avatar_hit = ccb.content.text("%1$s crushes your %2$s with a vicious stomp!"),
    npc_hit = ccb.content.text("%1$s crushes <npcname> underfoot!"),
    avatar_no_damage = ccb.content.text("%1$s's attempt to crush your %2$s is deflected by your armor."),
    npc_no_damage = ccb.content.text("%1$s's attempt to crush <npcname> is deflected by their armor."),
    avatar_miss = ccb.content.text("You roll out of the way of %1$s's stomp!"),
    npc_miss = ccb.content.text("<npcname> rolls out of the way of %1$s's stomp!"),
    when = "allow_android_crush",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "android_crush_monster",
    cooldown = 1,
    move_cost = 80,
    damage = { { type = "bash", amount = 1200, penetration = 15 } },
    minimum_damage_multiplier = 0.3,
    avatar_hit = ccb.content.text("%1$s crushes your %2$s with a vicious stomp!"),
    npc_hit = ccb.content.text("%1$s crushes <npcname> underfoot!"),
    avatar_no_damage = ccb.content.text("%1$s's attempt to crush your %2$s is deflected by your armor."),
    npc_no_damage = ccb.content.text("%1$s's attempt to crush <npcname> is deflected by their armor."),
    avatar_miss = ccb.content.text("You roll out of the way of %1$s's stomp!"),
    npc_miss = ccb.content.text("<npcname> rolls out of the way of %1$s's stomp!"),
    when = "allow_android_crush_monster",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "zenit_control",
    cooldown = 3,
    move_cost = 0,
    range = 35,
    dodgeable = false,
    blockable = false,
    damage = { { type = "bash", amount = 0 } },
    avatar_hit = "",
    npc_hit = "",
    avatar_miss = "",
    npc_miss = "",
    avatar_no_damage = "",
    npc_no_damage = "",
    on_hit = "zenit_control",
}

-- Effects only get applied on damaging hits so AP
ccb.content.define_monster_attack {
    kind = "melee",
    id = "garlander_web",
    cooldown = 6,
    move_cost = 210,
    damage = { { type = "bash", amount = 2, penetration = 12 } },
    minimum_hit_size = 34,
    effects = { { id = "webbed", duration = 300 }, { id = "webbed", duration = 300 } },
    accuracy = 7,
    blockable = false,
    avatar_hit = ccb.content.text("%s grasps at you with silk-covered legs, engulfing you in sticky webs!"),
    npc_hit = ccb.content.text("%s grabs <npcname> and covers them in sticky webs!"),
    avatar_miss = ccb.content.text("%s tries to grab you, but you dodge!"),
    npc_miss = ccb.content.text("%s tries to grab <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%s tries to grasp you, but it slides off your armor."),
    npc_no_damage = ccb.content.text("%s tries to grasp <npcname>, but its legs slide of their armor."),
}

ccb.content.define_spell {
    id = "shock_mine_control",
    shape = "blast",
    name = ccb.content.text_without_extraction("Sock mine control"),
    description = ccb.content.text_without_extraction("Shock mines control themselves using this one."),
    message = "",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "self" },
    min_range = 1,
    max_range = 1,
    impact_handler = "w16b_sp_imp_aftershock_exoplanet_6683a9b08ada",
}
