local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "bloodthorne_druid_aura_of_vines_retaliate",
    name = ccb.content.text_without_extraction("Entanglement of Vines Retaliation"),
    description = ccb.content.text_without_extraction("Hits targets when you have Entanglement of Vines active.  You shouldn't see this."),
    message = "",
    valid_targets = { "hostile" },
    flags = { "SILENT", "RANDOM_DAMAGE" },
    magic_type = "xedra_bloodthorne_sorcery",
    skill = "deduction",
    spell_class = "BLOODTHORNE_SORCERY",
    effect = "attack",
    effect_data = "bleed",
    shape = "blast",
    damage_type = "cut",
    min_damage = 5,
    max_damage = 25,
    min_range = 2,
    max_range = 2,
}

ccb.content.define_spell {
    id = "bloodthorne_druid_whip_targets_in_nature_spell",
    skill = "deduction",
    shape = "blast",
    effect = "attack",
    effect_data = "",
    spell_class = "BLOODTHORNE_SORCERY",
    damage_type = "stab",
    magic_type = "xedra_bloodthorne_sorcery",
    name = "Verdant Scourge",
    description = "You can bring the fury of nature to bear on your enemies.  When a target is in thick grass, shrubbery, or other foliage, or is affected by Hungry Thirsty Roots, you can cause the plants to grow long thorns and pierce them.",
    message = "",
    flags = { "VERBAL", "RANDOM_DAMAGE", "SILENT" },
    valid_targets = { "hostile" },
    min_damage = { handler = "wave14a_xedra_evolved_stat_216", fallback = 0 },
    max_damage = { handler = "wave14a_xedra_evolved_stat_217", fallback = 0 },
    min_range = 15,
    max_range = 15,
    min_aoe = { handler = "wave14a_xedra_evolved_stat_218", fallback = 0 },
    max_aoe = { handler = "wave14a_xedra_evolved_stat_218", fallback = 0 },
    base_energy_cost = { handler = "wave14a_xedra_evolved_stat_219", fallback = 0 },
    base_casting_time = 175,
    target_when = "wave14a_xedra_evolved_cond_3",
}
