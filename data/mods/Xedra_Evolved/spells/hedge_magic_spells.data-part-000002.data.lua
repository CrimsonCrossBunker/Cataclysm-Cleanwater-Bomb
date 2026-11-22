local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "hedge_make_plants_grow_real",
    name = ccb.content.text_without_extraction("To Bring Health to the Soil and Life to the Crops Real"),
    description = ccb.content.text_without_extraction("The actual effect of the charm.  Should not be player-visible"),
    message = "",
    magic_type = "xe_hedge_magick",
    valid_targets = { "ground" },
    spell_class = "HEDGE_MAGIC",
    skill = "survival",
    effect = "fertilize_plant",
    min_damage = 30,
    max_damage = 30,
    shape = "blast",
    min_aoe = 2,
    max_aoe = 2,
    max_level = 1,
}

ccb.content.define_spell {
    id = "hedge_make_plants_grow",
    skill = "survival",
    components = "spell_components_hedge_make_plants_grow",
    shape = "blast",
    spell_class = "HEDGE_MAGIC",
    magic_type = "xe_hedge_magick",
    name = "To Bring Health to the Soil and Life to the Crops",
    description = "While standing on soil or turned earth, perform a ritual to increase the bounty of the crops.  The casting of this charm must end within one hour of noon.",
    message = "You dance slowly over the living earth, letting the seeds fall at the appropriate time, and as the sun climbs to its zenith you recite the last words of the charm.",
    caster_condition_fail_message = "You must be standing on dirt to use this charm.",
    flags = { "VERBAL", "SOMATIC", "NO_FAIL" },
    valid_targets = { "self" },
    min_aoe = 2,
    max_aoe = 2,
    difficulty = 70,
    max_level = 1,
    base_casting_time = 720000,
    caster_when = "w16b_sp_cast_xedra_evolved_b33d767f4330",
    impact_handler = "w16b_sp_imp_xedra_evolved_c561fffe8052",
}
