local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "skewer",
    cooldown = 20,
    move_cost = 180,
    damage = { { type = "stab", amount = 15, penetration = 15, armor_multiplier = 0.5 } },
    body_part_types = { { id = "torso", weight = 1 } },
    effects = { { id = "bleed", duration = 100, body_part = "torso" }, { id = "downed", duration = 3 } },
    avatar_hit = ccb.content.text("%1$s impales your %2$s with its trident!"),
    npc_hit = ccb.content.text("%1$s impales <npcname>'s %2$s with its trident!"),
    avatar_no_damage = ccb.content.text("%1$s tries to impale your %2$s with its trident, but fails to penetrate your armor!"),
    npc_no_damage = ccb.content.text("%1$s tries to impale <npcname>'s %2$s with its trident, but fails to penetrate their armor!"),
    when = "allow_armed_strike",
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "crush",
    cooldown = 20,
    move_cost = 180,
    damage = { { type = "bash", amount = 8 } },
    effects = { { id = "downed", duration = 3 } },
    body_part_types = {
        { id = "head", weight = 3 },
        { id = "tail", weight = 1 },
        { id = "wing", weight = 1 },
        { id = "arm", weight = 3 },
        { id = "torso", weight = 4 },
    },
    avatar_hit = ccb.content.text("%1$s crushes your %2$s with its greatclub!"),
    npc_hit = ccb.content.text("%1$s crushes <npcname>'s %2$s with its greatclub!"),
    avatar_no_damage = ccb.content.text("%1$s tries to crush your %2$s with its greatclub, but swings wide and stumbles."),
    npc_no_damage = ccb.content.text("%1$s tries to crush <npcname>'s %2$s with its greatclub, but swings wide and stumbles."),
    when = "allow_armed_strike",
}
