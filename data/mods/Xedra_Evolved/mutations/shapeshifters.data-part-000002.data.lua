local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_HYBRID_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Werewolf Hybrid Form"),
    points = 99,
    description = ccb.content.text_without_extraction("You are a hybrid of wolf and human.  This provides the actual effects of werewolf hybrid form.  Should not be player-visible"),
    visibility = 30,
    ugliness = 30,
    scent_intensity = 1800,
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    enchantments = { "INLINE_ENCH_WEREWOLF_HYBRID_FORM_TRAITS_0", "INLINE_ENCH_WEREWOLF_HYBRID_FORM_TRAITS_1" },
    integrated_armor = { "integrated_claws_werewolf" },
    flags = {
        "HANDS_CANNOT_USE_FIREARMS", "NO_SPELLCASTING", "TOUGH_FEET", "TEMPORARY_SHAPESHIFT",
        "SHAPESHIFT_SIZE_HUGE",
    },
    appearance = { id = "mon_loup_garou", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "WEREWOLF_HEAD",
    name = ccb.content.text_without_extraction("Werewolf Hybrid Form Head"),
    points = 99,
    description = ccb.content.text_without_extraction("You are a hybrid of wolf and human, and this is your head.  Should not be player-visible"),
    visibility = 0,
    ugliness = 0,
    valid = false,
    starting_trait = false,
    purifiable = false,
    player_display = false,
    types = { "TEETH" },
    integrated_armor = { "integrated_werewolf_teeth" },
}
