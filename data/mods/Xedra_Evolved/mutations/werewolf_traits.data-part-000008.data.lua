local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_PRIMAL_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Primal Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are a gigantic atavistic wolf.  This provides the actual effects of primal form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_0", "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_1",
        "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_2", "INLINE_ENCH_WEREWOLF_PRIMAL_FORM_TRAITS_3",
    },
    flags = { "MUTE", "QUADRUPED_RUN", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT", "SHAPESHIFT_SIZE_HUGE" },
    integrated_armor = { "integrated_werewolf_primal_form_fur", "integrated_werewolf_primal_form_fangs" },
    appearance = { id = "mon_direwolf", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_CLOSE_TEAR_IN_REALITY",
    name = ccb.content.text("Mending Rent Veils"),
    points = 2,
    description = ccb.content.text("The world is falling apart but that is no reason to cease the hunt.  You can close a tear in reality, if you can get close enough to it."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    spells_learned = { xe_werewolf_close_tear_in_reality_spell = 1 },
}
