local ccb = require("ccb")

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
