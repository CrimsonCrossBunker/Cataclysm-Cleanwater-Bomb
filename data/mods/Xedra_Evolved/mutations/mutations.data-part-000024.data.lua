local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_WOLF_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Wolf Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are a wolf.  This provides the actual effects of wolf form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_0", "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_1",
        "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_2", "INLINE_ENCH_VAMPIRE_WOLF_FORM_TRAITS_3",
    },
    flags = {
        "MUTE",
        "QUADRUPED_RUN",
        "TOUGH_FEET",
        "TEMPORARY_SHAPESHIFT",
        "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_wolf", tile_category = "monster" },
}
