local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SYLPH_CLOUD_FORM_APPEARANCE",
    name = ccb.content.text_without_extraction("Body of Cloud Appearance"),
    points = 1,
    description = ccb.content.text_without_extraction("This mutation carries the sprite override info for Body of Cloud.  You shouldn't be able to see it in game."),
    valid = false,
    player_display = false,
    appearance = { id = "fd_extinguisher", tile_category = "field" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    flags = { "CANNOT_CONSUME_DRUGS" },
}

ccb.content.define_mutation {
    id = "SYLPH_CANNOT_BE_SLOWED_OR_STOPPED",
    name = ccb.content.text("As Free as the Wind"),
    points = 12,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like the wind, the Sylph goes where they will with no one to stop them.  They are immune to anything that would restrict their movement, such as grabs, terrain costs, or slippery terrain."),
    prerequisites = { "SYLPH_DEX_BONUS_2" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    enchantments = { "INLINE_ENCH_SYLPH_CANNOT_BE_SLOWED_OR_STOPPED_0" },
    flags = { "STEADY", "SLUDGE_IMMUNE", "WEB_WALKER" },
}

ccb.content.define_mutation {
    id = "SYLPH_PAIN_DOESNT_AFFECT_DEX_SPEED",
    name = ccb.content.text("Winds Always At My Back"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The winds surround the Sylph and carry them along regardless of their physical condition.  They suffer no penalties to dexterity or speed due to pain."),
    prerequisites = { "SYLPH_CANNOT_BE_SLOWED_OR_STOPPED" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    enchantments = { "INLINE_ENCH_SYLPH_PAIN_DOESNT_AFFECT_DEX_SPEED_0" },
}
