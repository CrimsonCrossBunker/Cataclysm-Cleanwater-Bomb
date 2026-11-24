local ccb = require("ccb")

ccb.content.define_mutation {
    id = "iso_trait",
    name = ccb.content.text_without_extraction("Lab Diver"),
    points = 0,
    description = ccb.content.text_without_extraction("Secret anchor point trait for gameplay enchantments.  Mod will break if you purify this trait."),
    enchantments = { "iso_ranged_adjust", "iso_pain_adjust" },
    starting_trait = false,
    player_display = false,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "ISO_ELDRITCH_INVISIBLE_AND_INTANGIBLE_GRAPHICS",
    name = ccb.content.text_without_extraction("Wraith Appearance"),
    description = ccb.content.text_without_extraction("Makes you look like a wraith."),
    points = 0,
    starting_trait = false,
    player_display = false,
    purifiable = false,
    valid = false,
    appearance = { id = "mon_darkman", tile_category = "monster" },
}

ccb.content.define_mutation {
    id = "iso_trait_balthazar_uplink",
    name = ccb.content.text("Balthazar Uplink"),
    points = 0,
    description = ccb.content.text("A foreign segment within your mind, it feels like handful of blades floating on the edge of your unconscious.  You could talk to Balthazar if you focused on it."),
    active = true,
    activation_setup_only = false,
    enchantments = { "iso_ench_balthazar_control" },
    on_activate = "talk_balthazar",
    starting_trait = false,
    purifiable = false,
    valid = false,
}
