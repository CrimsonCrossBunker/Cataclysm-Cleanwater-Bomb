local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "mag_summon_mushrooms",
    name = ccb.content.text_without_extraction("Summon mushrooms"),
    description = ccb.content.text_without_extraction("Summons some mushrooms, extra effect summons some morels"),
    valid_targets = { "self" },
    flags = { "PERMANENT", "NO_LEGS", "NO_EXPLOSION_SFX", "NO_PROJECTILE", "SPAWN_GROUP", "RANDOM_DAMAGE" },
    difficulty = 0,
    min_damage = { handler = "scaled_mag_summon_mushrooms_min_damage", fallback = 3.0 },
    max_damage = { handler = "scaled_mag_summon_mushrooms_max_damage", fallback = 8.0 },
    effect = "spawn_item",
    effect_data = "mushroom_collection",
    shape = "blast",
    base_energy_cost = 0,
    final_energy_cost = 0,
    base_casting_time = 0,
    final_casting_time = 0,
}
