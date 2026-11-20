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
