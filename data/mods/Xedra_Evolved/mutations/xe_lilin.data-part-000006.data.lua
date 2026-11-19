local ccb = require("ccb")

ccb.content.define_mutation {
    id = "LILIN_HOLD_MORE_RUACH",
    name = ccb.content.text("Ruach Spring"),
    description = ccb.content.text("Your powers have expanded and you are now capable of holding more ruach."),
    points = 2,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_GAIN_MORE_FOCUS" },
    replacements = { "LILIN_HOLD_MORE_RUACH_2" },
    categories = { "LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_HOLD_MORE_RUACH_2",
    name = ccb.content.text("Ruach Well"),
    description = ccb.content.text("Your powers have expanded and you are now capable of holding even more ruach."),
    points = 6,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_HOLD_MORE_RUACH" },
    secondary_prerequisites = {
        "LILIN_ATTRIBUTE_BONUSES_STRENGTH", "LILIN_ATTRIBUTE_BONUSES_DEXTERITY",
        "LILIN_ATTRIBUTE_BONUSES_PERCEPTION",
    },
    replacements = { "LILIN_HOLD_MORE_RUACH_3" },
    categories = { "LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_HOLD_MORE_RUACH_3",
    name = ccb.content.text("Ruach Sea"),
    description = ccb.content.text("Your powers have expanded and you are now capable of holding an enormous amount of ruach."),
    points = 10,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_HOLD_MORE_RUACH_2" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

-- This is a reference to Proverbs 23:5
ccb.content.define_mutation {
    id = "LILIN_RUACH_EFFICIENCY",
    name = ccb.content.text("Glancing at Riches"),
    description = ccb.content.text("You've learned how to more efficiently use your ruach, greedily keeping some behind for yourself when you activate your powers.  Powers that cost ruach have their initial and periodic costs reduced by 15%.  This does not reduce the continual ruach cost of staying alive."),
    points = 5,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_HOLD_MORE_RUACH", "LILIN_HOLD_MORE_RUACH_2", "LILIN_HOLD_MORE_RUACH_3" },
    secondary_prerequisites = { "LILIN_GAIN_MORE_FOCUS" },
    replacements = { "LILIN_RUACH_EFFICIENCY_UPGRADE" },
    categories = { "LILIN" },
}

-- This is a reference to Jeremiah 5:27
ccb.content.define_mutation {
    id = "LILIN_RUACH_EFFICIENCY_UPGRADE",
    name = ccb.content.text("Like a Cage Full of Birds"),
    description = ccb.content.text("You jealously parcel out your ruach, only spending exactly as much as you need and no more.  Powers that cost ruach have their initial and periodic costs reduced by 15%, with an additional reduction that grows based on your total amount of ruach, to a maximum reduction of 33%.  This does not reduce the continual ruach cost of staying alive."),
    points = 10,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_TEMPORARY_GLORIOUS_2" },
    secondary_prerequisites = { "LILIN_RUACH_EFFICIENCY" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

-- This is a reference to Psalms 139:12
ccb.content.define_mutation {
    id = "LILIN_READ_CRAFT_IN_DARKNESS",
    name = ccb.content.text("The Darkness is not Dark to You"),
    description = ccb.content.text("You have adapted so well to the night that it doesn't hinder your actions at all.  You can read and craft in any light levels."),
    points = 4,
    purifiable = false,
    prerequisites = { "LILIN_NIGHT_VISION" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    flags = { "CRAFT_IN_DARKNESS", "READ_IN_DARKNESS" },
}

-- This is a reference to Psalms 139:12
ccb.content.define_mutation {
    id = "LILIN_NIGHT_VISION_UPGRADE",
    name = ccb.content.text("The Night Shines Like the Day"),
    description = ccb.content.text("Your eyes have fully adapted to the darkness, allowing you to see as well in the dark as humans see in the light.  However, the light of the sun is dazzling now."),
    points = 7,
    mixed_effect = true,
    purifiable = false,
    prerequisites = { "LILIN_NIGHT_VISION" },
    secondary_prerequisites = { "LILIN_READ_CRAFT_IN_DARKNESS" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_NIGHT_VISION_UPGRADE_0", "INLINE_ENCH_LILIN_NIGHT_VISION_UPGRADE_1" },
    flags = { "MYOPIC_IN_LIGHT_SUPERNATURAL" },
}

-- This is a reference to Jeremiah 31:35
-- prerequisites are having at least one power amplified by the moon.  As this is written, only one such power exists.
ccb.content.define_mutation {
    id = "LILIN_STRONGER_MOON",
    name = ccb.content.text("The Moon Shall Shine at Night"),
    description = ccb.content.text("You are closely attuned to the moon, and some of your powers grow stronger with it.  Any ability you have that is amplified the fuller the moon is will not be weakened as much by an incomplete but non-new moon."),
    points = 3,
    purifiable = false,
    prerequisites = { "LILIN_UNARMED_EXTRA_DAMAGE" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_OWL_FORM_PASS_THROUGH_WALLS",
    name = ccb.content.text("Like an Unclean Spirit"),
    description = ccb.content.text("Your owl form is half spirit and half flesh.  You have a high chance to dodge any attacks against you, and may pass straight through walls as long as it is night."),
    points = 6,
    purifiable = false,
    prerequisites = { "LILIN_TURN_INTO_OWL" },
    secondary_prerequisites = { "LILIN_UNCANNY_DODGE_WHILE_REAPING" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
}

ccb.content.define_mutation {
    id = "LILIN_LIMB_SCORE_BONUSES_AT_NIGHT",
    name = ccb.content.text("The Night-Hunter"),
    description = ccb.content.text("You are at home in the night, and your prowess is heightened while the moon is up as long as you have any ruach within you."),
    points = 8,
    starting_trait = false,
    purifiable = false,
    prerequisites = { "LILIN_UNARMED_EXTRA_DAMAGE", "LILIN_SPEED_DODGE_BOOST" },
    secondary_prerequisites = { "LILIN_READ_CRAFT_IN_DARKNESS" },
    categories = { "LILIN" },
    threshold_requirements = { "THRESH_LILIN" },
    enchantments = { "INLINE_ENCH_LILIN_LIMB_SCORE_BONUSES_AT_NIGHT_0" },
}
