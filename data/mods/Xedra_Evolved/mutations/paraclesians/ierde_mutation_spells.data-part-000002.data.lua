local ccb = require("ccb")

ccb.content.define_spell {
    id = "ierde_cultivate_goblin_fruit",
    skill = "deduction",
    shape = "blast",
    spell_class = "IERDE",
    magic_type = "xe_fey_magick",
    name = "Cultivate Goblin Fruit",
    description = "You may spin a bit of fae magic into the earth, bringing forth a goblin fruit.  Goblin fruit have a variety of effects, never predictable but always at least somewhat beneficial.  This spell may only be cast on earth or stone.",
    teachable = false,
    flags = { "SOMATIC", "VERBAL", "NO_LEGS", "NO_HANDS" },
    valid_targets = { "self" },
    base_energy_cost = 450,
    difficulty = 8,
    max_level = { handler = "w16b_sp_stat_xedra_evolved_893d5f083442", fallback = 0 },
    base_casting_time = 180000,
    final_casting_time = 100,
    casting_time_increment = -6000,
    impact_handler = "w16b_sp_imp_xedra_evolved_adf75aced3d4",
}
