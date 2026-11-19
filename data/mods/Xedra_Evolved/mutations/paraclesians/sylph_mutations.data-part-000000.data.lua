local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SYLPH_SKIN_1",
    name = ccb.content.text("Sylph Skin"),
    points = 0,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Your skin has turned the rolling grey of the clouds.  Your skin is now an ever-shifting color of clouds shifting from stormy to rainy to barely there.  This has no gameplay effects."),
    types = { "skin_tone" },
    additions = { "SYLPH_SKIN_2" },
    categories = { "SYLPH" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "SYLPH_SKIN_2",
    name = ccb.content.text("Cloud Skin"),
    points = 2,
    visibility = 5,
    ugliness = 3,
    description = ccb.content.text("Your skin is clearly separate from the air around you but has become its own weather system.  If someone reaches out and touches you, they will clearly feel you but you look like someone might reach right through you."),
    types = { "SKIN" },
    categories = { "SYLPH" },
    purifiable = false,
    prerequisites = { "SYLPH_SKIN_1" },
    replacements = { "SYLPH_SKIN_3" },
    wet_protection = {
        { part = "head", ignored = 2 },
        { part = "leg_l", ignored = 5 },
        { part = "leg_r", ignored = 5 },
        { part = "foot_l", ignored = 2 },
        { part = "foot_r", ignored = 2 },
        { part = "arm_l", ignored = 4 },
        { part = "arm_r", ignored = 4 },
        { part = "hand_l", ignored = 1 },
        { part = "hand_r", ignored = 1 },
        { part = "torso", ignored = 10 },
    },
    enchantments = { "INLINE_ENCH_SYLPH_SKIN_2_0" },
    integrated_armor = { "integrated_cloud_skin" },
}

ccb.content.define_mutation {
    id = "SYLPH_SKIN_3",
    name = ccb.content.text("Storm Skin"),
    points = 3,
    visibility = 10,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your skin is a roiling storm.  Your flexibility is greatly increased, your ability to ignore temperatures hot and cold have greatly increased but your ability to carry objects has been reduced."),
    types = { "SKIN" },
    prerequisites = { "SYLPH_SKIN_2" },
    threshold_requirements = { "THRESH_SYLPH" },
    categories = { "SYLPH" },
    purifiable = false,
    wet_protection = {
        { part = "head", ignored = 5 },
        { part = "leg_l", ignored = 16 },
        { part = "leg_r", ignored = 16 },
        { part = "foot_l", ignored = 5 },
        { part = "foot_r", ignored = 5 },
        { part = "arm_l", ignored = 14 },
        { part = "arm_r", ignored = 14 },
        { part = "hand_l", ignored = 4 },
        { part = "hand_r", ignored = 4 },
        { part = "torso", ignored = 30 },
    },
    enchantments = { "INLINE_ENCH_SYLPH_SKIN_3_0" },
    integrated_armor = { "integrated_storm_skin" },
}

ccb.content.define_mutation {
    id = "BREATHE_WO_AIR",
    name = ccb.content.text("Breathe Without Air"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to breathe without oxygen.  This will prevent damage from a lack of oxygen."),
    categories = { "SYLPH" },
    purifiable = false,
    flags = { "GILLS", "INHALED_TOXIN_IMMUNE", "SUFFOCATION_IMMUNE" },
}

ccb.content.define_mutation {
    id = "SYLPH_EYES",
    name = ccb.content.text("Sylph Eyes"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph's eyes begin reflecting their mood with lightning and storms when angry and clear skies when happy.  Glare no longer impacts them, and they have much better daytime vision and much faster reaction times."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_EYES_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_EARS",
    name = ccb.content.text("Sylph Ears"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("The Sylph's ears are longer and pointed, like a wisp of cloud trailing across the sky.  They can hear better and no matter how loud the thunder, their ears will not ring from it."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_EARS_0" },
    flags = { "IMMUNE_HEARING_DAMAGE" },
}

ccb.content.define_mutation {
    id = "SYLPH_LOUDER_SHOUTING",
    name = ccb.content.text("Voice of Thunder"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Sylph can make their voice boom like a peal of thunder, shouting so loudly that they can be heard from hundreds of yards away."),
    prerequisites = { "CLAP_OF_THUNDER" },
    secondary_prerequisites = { "BREATHE_WO_AIR" },
    categories = { "SYLPH" },
    purifiable = false,
    active = true,
    activation_setup_only = false,
    enchantments = { "ench_sylph_louder_shouting" },
}

ccb.content.define_mutation {
    id = "CLAP_OF_THUNDER",
    name = ccb.content.text("Clap of Thunder"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to create a loud clap of thunder noise at a distance."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { clap_of_thunder = 1 },
}

ccb.content.define_mutation {
    id = "OMINOUS_WIND",
    name = ccb.content.text("Ominous Wind"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to summon and ominous wind that damages sapient creatures morale."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { ominous_wind = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_CHARGE_DASH",
    name = ccb.content.text("Stormwind Stride"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to rush forward in a burst of wind."),
    prerequisites = { "SYLPH_SPEED_INCREASE", "SYLPH_SPEED_INCREASE2" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_charge_dash_spell = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_SPEED_ALLY_BUFF",
    name = ccb.content.text("Favonian Murmuration"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability increase the speed of one of their allies."),
    prerequisites = { "SYLPH_CHARGE_DASH" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_increase_ally_speed_spell = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_REVEAL_OVERMAP",
    name = ccb.content.text("Like a Bird on the Wing"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to see surrounding terrain as though standing on high."),
    prerequisites = { "SYLPH_PER_BONUS_1" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_reveal_overmap_spell = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_BONUS_MELEE_RANGE",
    name = ccb.content.text("Breeze-Cutting Blows"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to strike so precisely that the air will carry their melee attacks a short distance."),
    prerequisites = { "SYLPH_BONUS_RANGE", "SYLPH_DEX_BONUS_2" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_bonus_melee_range_spell = 1 },
}

ccb.content.define_mutation {
    id = "SLOWFALL",
    name = ccb.content.text("Slow Fall"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph ceases to fall at speeds that would damage themselves, no matter how high the fall is."),
    replacements = { "SYLPH_GLIDING" },
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SLOWFALL_0" },
    flags = { "FEATHER_FALL" },
}

ccb.content.define_mutation {
    id = "SYLPH_GLIDING",
    name = ccb.content.text("Carried on the Breeze"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph can direct their falls, moving horizontally in a gust of wind if they step off a ledge and landing safely on the ground."),
    prerequisites = { "SLOWFALL" },
    additions = { "SYLPH_JUMP_HIGH" },
    categories = { "SYLPH" },
    purifiable = false,
    flags = { "GLIDE", "FEATHER_FALL" },
}
