local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HOMULLUS_SKIN_1",
    name = ccb.content.text("Mannequin Skin"),
    points = 0,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Your skin has turned pearlescent white, similar to antique dolls.  This has no gameplay effects."),
    types = { "skin_tone" },
    categories = { "HOMULLUS" },
    purifiable = false,
    additions = { "HOMULLUS_SKIN_2" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_SKIN_2",
    name = ccb.content.text("Porcelain Skin"),
    points = 2,
    visibility = 10,
    ugliness = -3,
    description = ccb.content.text("Your skin has smoothed and all your prior blemishes have faded away.  This somewhat reduces wet effects and leads to a more durable yet harder to heal body."),
    types = { "SKIN", "BODY_ARMOR" },
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "HOMULLUS_SKIN_1" },
    replacements = { "HOMULLUS_SKIN_3" },
    enchantments = { "INLINE_ENCH_HOMULLUS_SKIN_2_0" },
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
    integrated_armor = { "integrated_porcelain_skin" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_SKIN_3",
    name = ccb.content.text("Latex Skin"),
    points = 3,
    visibility = 10,
    ugliness = -6,
    mixed_effect = true,
    description = ccb.content.text("Your skin has become latex like.  While it provides additional protection and attractiveness it also heals at a much slower rate."),
    types = { "SKIN", "BODY_ARMOR" },
    prerequisites = { "HOMULLUS_SKIN_2" },
    threshold_requirements = { "THRESH_HOMULLUS" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_SKIN_3_0" },
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
    integrated_armor = { "integrated_latex_skin" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_EYES",
    name = ccb.content.text("Homullus Eyes"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Homullus's eyes begin change to look like doll's eyes, always staring at the world.  Glare no longer impacts them."),
    types = { "EYES" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_EYES_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_BETTER_AT_LYING",
    name = ccb.content.text("Trust Me"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text(" 'Men were deceivers ever,' as the quotation runs.  To be human is to be a liar.  You are much more successful at lying to people now."),
    categories = { "HOMULLUS" },
    purifiable = false,
    social_modifiers = { lie = 40 },
}

-- Ideally this would detect even non-allied NPCs nearby instead of just a location where NPCs are likely to be
ccb.content.define_mutation {
    id = "HOMULLUS_DREAMWALKER",
    name = ccb.content.text("Dreamwalker"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "HOMULLUS_SKIN_1" },
    description = ccb.content.text("From the dreams of mortals, you can spin remnants of fantasy into material substance.  When you sleep near mortals, you have a chance to awaken with some dreamdross nearby."),
    categories = { "HOMULLUS" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "HOMULLUS_CHARM_FERALS",
    name = ccb.content.text("One of Us"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("With this ability, the Homullus can reach out to a feral's fractured mind and twist it, convincing them to function as an ally."),
    prerequisites = { "HOMULLUS_BETTER_AT_LYING" },
    categories = { "HOMULLUS" },
    purifiable = false,
    spells_learned = { homullus_charm_feral_spell = 1 },
}

ccb.content.define_mutation {
    id = "FREE_WILL",
    name = ccb.content.text("Free Will"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Dollkin has resistance to attacks on its ability to act on it's choices."),
    categories = { "HOMULLUS" },
    purifiable = false,
    flags = { "PSYSHIELD_PARTIAL" },
}

ccb.content.define_mutation {
    id = "SENSE_THE_TOOLMAKERS",
    name = ccb.content.text("Sense the Toolmakers"),
    points = 1,
    description = ccb.content.text("Your powers enhance your mundane senses and allow you to detect human beings."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    enchantments = { "INLINE_ENCH_SENSE_THE_TOOLMAKERS_0" },
}

ccb.content.define_mutation {
    id = "SENSE_THE_NIGHT_HUNTERS",
    name = ccb.content.text("Sense the Night Hunters"),
    points = 1,
    description = ccb.content.text("This and other abilities native to Dollkin suggest that if vampires did create cities to concentrate their prey, something evolved afterwards to complicate the hunting grounds."),
    flags = { "ENHANCED_VISION", "WATCH" },
    player_display = true,
    purifiable = false,
    spells_learned = { homullus_sense_vampires = 1 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_SUMMON_FERALS",
    name = ccb.content.text("The Lost and the Damned"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The world crawls with the hungry dead and those who may as well be dead while they still live.  This allows the Homullus to call one of the latter to their side."),
    prerequisites = { "HOMULLUS_CHARM_FERALS" },
    categories = { "HOMULLUS" },
    purifiable = false,
    spells_learned = { homullus_summon_feral_spell = 1 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_SELF_DECEPTION",
    name = ccb.content.text("Everything Will Be Fine"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("A habit of lying is hard to break, even when, or especially when, talking to oneself.  This trait grants the Homullus a spell that allows them to smooth out any negative moods they experience."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "HOMULLUS_BETTER_AT_LYING" },
    spells_learned = { homullus_self_deception_spell = 1 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_INVISIBLE_TO_HUMANS",
    name = ccb.content.text("A Face in the Crowd"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Homullus gains the ability to render themselves invisible to humans."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "HOMULLUS_SKIN_1" },
    secondary_prerequisites = { "HOMULLUS_BACKSTAGE" },
    spells_learned = { homullus_invisible_to_humans_spell = 1 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_REDUCED_VISIBILITY_ALLY",
    name = ccb.content.text("The Average Joe"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Homullus gains the ability to render one of their allies inconspicuous."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "HOMULLUS_INVISIBLE_TO_HUMANS" },
    spells_learned = { homullus_reduced_visibility_ally_spell = 1 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_RESTORE_POWER",
    name = ccb.content.text("Dynamo"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Homullus gains the ability to recharge vehicles or power grids."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "HOMULLUS_PASSIVE_BIONIC_POWER" },
    spells_learned = { homullus_restore_power_spell = 1 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_ADD_LEARNING_FOCUS",
    name = ccb.content.text("The Scholar's Regard"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Homullus gains the ability to focus their mind to increase their learning ability."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "INT_UP_2", "INT_ALPHA" },
    spells_learned = { homullus_add_learning_focus_spell = 1 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_ROAD_TRANSLOCATION",
    name = ccb.content.text("All Roads Lead to Rome"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Homullus gains the ability to travel along a road to any bastion of civilization they have attuned to."),
    categories = { "HOMULLUS" },
    purifiable = false,
    threshold_requirements = { "THRESH_HOMULLUS" },
    prerequisites = { "HOMULLUS_CITY_STRIDER" },
    secondary_prerequisites = { "HOMULLUS_GAIN_BIONIC_POWER_AND_MANA" },
    spells_learned = { homullus_road_translocate_spell = 1, homullus_road_translocate_attune = 1 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Homullus gains the ability to find a goblin fruit when in the remnants of civilization."),
    categories = { "HOMULLUS" },
    purifiable = false,
    spells_learned = { homullus_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "NO_TRACE_YET_I_WISH",
    name = ccb.content.text("No Trace Yet I Wish"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Homullus gains the ability to stop emitting scent at will.  They can use this to control when scent-tracking creatures will be able to find them."),
    categories = { "HOMULLUS" },
    purifiable = false,
    types = { "SCENT" },
    activation_setup_only = true,
    active = true,
    activation_message = ccb.content.text("You stop producing scent"),
    consumes_mana = true,
    cost = 1,
    cooldown = 12,
    active_flags = { "NO_SCENT" },
}
