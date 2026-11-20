local ccb = require("ccb")

ccb.content.define_monster_attack {
    kind = "melee",
    id = "flaming_whip",
    cooldown = 20,
    move_cost = 500,
    range = 15,
    damage = { { type = "heat", amount = 30, penetration = 3, armor_multiplier = 0.5 } },
    body_part_types = {
        { id = "leg", weight = 4 },
        { id = "head", weight = 2 },
        { id = "tail", weight = 3 },
        { id = "wing", weight = 3 },
        { id = "arm", weight = 4 },
        { id = "torso", weight = 6 },
    },
    effects = { { id = "onfire", duration = 1, chance = 10, affect_hit_body_part = true } },
    avatar_hit = ccb.content.text("%1$s lashes you with its flaming whip!"),
    npc_hit = ccb.content.text("%1$s lashes <npcname> with its flaming whip!"),
    avatar_miss = ccb.content.text("%1$s lashes you with its flaming whip, but you dodge!"),
    npc_miss = ccb.content.text("%1$s lashes <npcname> with its flaming whip, but they dodge!"),
    avatar_no_damage = ccb.content.text("%1$s lashes you with its flaming whip, but fails to penetrate your armor!"),
    npc_no_damage = ccb.content.text("%1$s lashes <npcname> with its flaming whip, but fails to penetrate their armor!"),
    dodgeable = true,
    no_adjacent = true,
}

ccb.content.define_monster_attack {
    kind = "melee",
    id = "shock_punch",
    cooldown = 1,
    move_cost = 80,
    damage = { { type = "electric", amount = 40, penetration = 8, armor_multiplier = 2.5 } },
    minimum_hit_size = 4,
    effects = { { id = "stunned", duration = 5 } },
    avatar_hit = ccb.content.text("Electric current stream through your body!"),
    npc_hit = ccb.content.text("Electric current stream through <npcname>!"),
    avatar_miss = ccb.content.text("The %1$s tries to hit you, but you dodge!"),
    npc_miss = ccb.content.text("The %1$s tries to hit <npcname>, but they dodge!"),
    avatar_no_damage = ccb.content.text("The %1$s tries to hit you, but fails to penetrate your armor!"),
    npc_no_damage = ccb.content.text("The %1$s tries to hit <npcname>, but fails to penetrate their armor!"),
    dodgeable = true,
}
