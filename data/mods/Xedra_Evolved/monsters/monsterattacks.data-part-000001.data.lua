local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "sharp_objects",
    cooldown = 25,
    move_cost = 150,
    damage = { { type = "stab", amount = 10, penetration = 8, armor_multiplier = 0.5 } },
    minimum_hit_size = 4,
    effects = { { id = "bleed", duration = 100, affect_hit_body_part = true } },
    avatar_hit = ccb.content.text("%1$s impales your %2$s!"),
    npc_hit = ccb.content.text("%1$s impales <npcname>!"),
    avatar_miss = ccb.content.text("%1$s tries to impale your %2$s, but you dodge!"),
    npc_miss = ccb.content.text("%1$s tries to impale <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s tries to impale your %2$s, but fails to penetrate your armor."),
    npc_no_damage = ccb.content.text("%1$s tries to impale <npcname>, but fails to penetrate their armor."),
    dodgeable = true,
    blockable = true,
}
