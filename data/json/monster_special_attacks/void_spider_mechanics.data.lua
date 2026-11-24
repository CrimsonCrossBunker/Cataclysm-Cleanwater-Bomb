local ccb = require("ccb")

ccb.content.define_trap {
    id = "tr_void_spider_entry",
    name = "",
    color = "green",
    symbol = "#",
    visibility = 99,
    always_invisible = true,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 0,
    flags = { "UNDODGEABLE", "AVATAR_ONLY", "CONSUME_ON_TRIGGER" },
    action = "none",
    trigger_handler = "enter_void_spider_lair",
}

ccb.content.define_monster_attack {
    id = "void_spider_control",
    kind = "scripted",
    cooldown = 1,
    range = 35,
    action = "void_spider_control",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "void_spider_bite",
    cooldown = 1,
    move_cost = 100,
    damage = { { type = "stab", amount = 12, penetration = 30000 } },
    minimum_hit_size = 4,
    effects = { { id = "venom_blind", duration = 120 } },
    avatar_hit = ccb.content.text("%1$s's immaterial limbs crawl over you and sink their fangs in your %2$s!"),
    npc_hit = ccb.content.text("%1$s's immaterial limbs sink into <npcname>!"),
    avatar_miss = ccb.content.text("%1$s's hanging limbs try to bite you, but you dodge!"),
    npc_miss = ccb.content.text("%1$s's hanging limbs try to bite <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s's hanging limbs try to bite your %2$s, but fails to penetrate your armor!"),
    npc_no_damage = ccb.content.text("%1$s's hanging limbs try to bite <npcname>, but fails to penetrate their armor!"),
    when = "allow_void_spider_bite",
}
