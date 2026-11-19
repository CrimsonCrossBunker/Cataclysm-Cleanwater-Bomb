local ccb = require("ccb")

ccb.content.define_mutation {
    id = "VAMPIRE_BAT_FORM_TRAITS",
    name = ccb.content.text_without_extraction("Bat Form"),
    points = 0,
    description = ccb.content.text_without_extraction("You are a bat.  This provides the actual effects of bat form.  Should not be player-visible."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = {
        "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_0", "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_1",
        "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_2", "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_3",
        "INLINE_ENCH_VAMPIRE_BAT_FORM_TRAITS_4",
    },
    flags = {
        "DRACULIN_VENOM", "TOUGH_FEET", "MUTE", "LEVITATION", "TEMPORARY_SHAPESHIFT",
        "SHAPESHIFT_SIZE_TINY", "TEMPORARY_SHAPESHIFT_NO_HANDS",
    },
    appearance = { id = "mon_bat", tile_category = "monster" },
}
