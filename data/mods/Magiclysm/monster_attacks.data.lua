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

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "teravolt_explosion",
    name = ccb.content.text_without_extraction("Teravolt Explosion"),
    description = ccb.content.text_without_extraction("Create a giant explosion with spark field.  You can see it only in debug mode."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ground" },
    flags = { "RANDOM_AOE", "RANDOM_DAMAGE", "SPLIT_DAMAGE" },
    min_damage = 40,
    max_damage = 80,
    min_aoe = 3,
    max_aoe = 6,
    damage_type = "electric",
    field = "fd_electricity",
    min_field_intensity = 1,
    max_field_intensity = 7,
    field_intensity_variance = 1,
    field_chance = 1,
    sound_description = ccb.content.text("a crackle"),
    message = "",
}

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

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electric_turret_line",
    name = ccb.content.text_without_extraction("Lightning Line Attack"),
    description = ccb.content.text_without_extraction("Line heat attack for stormcaller's thunder pillar."),
    effect = "attack",
    shape = "cone",
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "RANDOM_DAMAGE", "RANDOM_AOE", "SPLIT_DAMAGE" },
    min_damage = 55,
    max_damage = 105,
    min_range = 5,
    max_range = 12,
    min_aoe = 15,
    max_aoe = 35,
    field = "fd_electricity",
    min_field_intensity = 2,
    max_field_intensity = 5,
    field_chance = 1,
    damage_type = "heat",
    sound_description = ccb.content.text("a crackle"),
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "electric_turret_blast",
    name = ccb.content.text_without_extraction("Lightning Blast Attack"),
    description = ccb.content.text_without_extraction("Blast electric attack for stormcaller's thunder pillar."),
    effect = "attack",
    shape = "blast",
    valid_targets = { "hostile", "ground" },
    flags = { "LOUD", "RANDOM_DAMAGE", "RANDOM_AOE", "SPLIT_DAMAGE" },
    min_damage = 40,
    max_damage = 65,
    min_range = 10,
    max_range = 25,
    min_aoe = 2,
    max_aoe = 6,
    field = "fd_electricity",
    min_field_intensity = 2,
    max_field_intensity = 5,
    field_chance = 2,
    damage_type = "electric",
    sound_description = ccb.content.text("a crackle"),
}
