local ccb = require("ccb")

-- Name comes from Genesis 29:17
ccb.content.define_mutation {
    id = "LILIN_TEMPORARY_GLORIOUS",
    name = ccb.content.text("Of Beautiful Form"),
    description = ccb.content.text("You can use your powers to spin a web of illusion around yourself, increasing your attractiveness to a supernatural degree.  While the harsh light of the sun destroys the illusion, you need merely to move back into the shadows to restore it."),
    points = 2,
    purifiable = false,
    prerequisites = { "BEAUTIFUL" },
    secondary_prerequisites = { "LILIN_BONUS_PERSUASION" },
    categories = { "LILIN" },
    replacements = { "LILIN_TEMPORARY_GLORIOUS_2" },
    active = true,
    activation_setup_only = true,
    activation_message = "",
    on_activate = "lilin_temporary_glorious_on",
    on_process = "lilin_temporary_glorious_process",
    on_deactivate = "lilin_temporary_glorious_off",
}

-- Name comes from II Samuel 14:25
ccb.content.define_mutation {
    id = "LILIN_TEMPORARY_GLORIOUS_2",
    name = ccb.content.text("Without Blemish"),
    description = ccb.content.text("You can use your powers to spin a web of illusion around yourself, increasing your attractiveness to a supernatural degree.  While the harsh light of the sun destroys the illusion, you need merely to move back into the shadows to restore it.  You have grown so powerful that this illusion requires almost no effort and can be <color_green>maintained for weeks</color> at a time."),
    points = 2,
    purifiable = false,
    prerequisites = { "LILIN_TEMPORARY_GLORIOUS" },
    secondary_prerequisites = { "LILIN_LIMB_SCORE_BONUSES_AT_NIGHT" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    active = true,
    activation_setup_only = true,
    activation_message = "",
    on_activate = "lilin_temporary_glorious_on",
    on_process = "lilin_temporary_glorious_process",
    on_deactivate = "lilin_temporary_glorious_off",
}

ccb.content.define_mutation {
    id = "LILIN_ATTRIBUTE_BONUSES",
    name = ccb.content.text("Might of the Nephilim"),
    description = ccb.content.text("Like the monstrous children of angels and humans, your prowess surpasses mortal limits.  Activate this trait to empower yourself."),
    points = 4,
    purifiable = false,
    categories = { "LILIN" },
    active = true,
    activation_setup_only = true,
    activation_message = "",
    on_activate = "lilin_attribute_bonuses_on",
    on_deactivate = "lilin_attribute_bonuses_off",
}
