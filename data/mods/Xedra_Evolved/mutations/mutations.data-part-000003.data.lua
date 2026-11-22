local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DHAMPIR_AVOID_EAT_SLEEP_DRINK",
    name = ccb.content.text("The Blood is the Life"),
    points = 5,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("While you must normally eat, sleep, and drink as a mortal must, in times of need you can put that off.  Activate this trait to reduce your need for food, water, and sleep to zero.  While active, the Blood is the Life will continually expend the power in your blood, and when it wears off, you will become exhausted in proportion to how long the trait was active.  You spend <color_yellow>much more blood</color> if outdoors in the sunlight.\n\n<color_light_red>Initial Blood Cost:</color> 1 ml (<u_val:blood_amount_for_graph> ml current)\n<color_light_red>Periodic Blood Cost:</color> 1 ml per minute"),
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You draw on the power in your blood to stave off mortal needs."),
    on_activate = "dhampir_avoid_needs_on",
    on_process = "dhampir_avoid_needs_process",
    on_deactivate = "dhampir_avoid_needs_off",
    enchantments = { "INLINE_ENCH_DHAMPIR_AVOID_EAT_SLEEP_DRINK_0" },
}
