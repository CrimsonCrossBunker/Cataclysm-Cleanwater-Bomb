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

ccb.content.define_mutation {
    id = "HOMULLUS_BACKSTAGE",
    name = ccb.content.text("Backstage"),
    points = 1,
    visibility = -1,
    ugliness = 0,
    description = ccb.content.text("At will, you can recede from the foreground of people's perceptions.  They will still notice you if you make yourself known.  Conversation with actual humans will be harder while this trait is active."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "NO_TRACE_YET_I_WISH" },
    activation_setup_only = true,
    active = true,
    on_activate = "toggle_trait_form",
    on_deactivate = "toggle_trait_form",
}

ccb.content.define_mutation {
    id = "HOMULLUS_BACKSTAGE_active",
    name = ccb.content.text_without_extraction("Backstage (on)"),
    description = ccb.content.text_without_extraction("You have faded into the background."),
    copy_from = "HOMULLUS_BACKSTAGE",
    active = false,
    valid = false,
    player_display = false,
    species_anger = { HUMAN = -50, FERAL = -50 },
    enchantments = { "INLINE_ENCH_HOMULLUS_BACKSTAGE_active_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CAN_USE_ELECTRONICS",
    name = ccb.content.text("Veins Like Circuits"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("For almost all of recorded history, even tool-using history, humanity had not harnessed lightning, and most of the Fair Folk still have little understanding of electrical devices.  This ability gives you an almost-instinctive understanding of circuits, however, allowing you to develop the electronics skill normally and providing a bonus to its use."),
    prerequisites = { "PER_UP", "PER_UP_2", "PER_ALPHA" },
    secondary_prerequisites = { "HOMULLUS_SKIN_2", "HOMULLUS_SKIN_3" },
    categories = { "HOMULLUS" },
    purifiable = false,
    craft_skill_bonuses = { electronics = 2 },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CAN_USE_COMPUTERS",
    name = ccb.content.text("Man-Machine Mind"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You have developed an intuitive understanding of computers.  You can develop the computer skill normally and gain a bonus to its use."),
    prerequisites = { "INT_UP", "INT_UP_2", "INT_ALPHA" },
    secondary_prerequisites = { "HOMULLUS_EYES" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_CAN_USE_COMPUTERS_0", "INLINE_ENCH_HOMULLUS_CAN_USE_COMPUTERS_1" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CBM_INSTALL",
    name = ccb.content.text("Cybernetic Integration"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Your flesh and bones can instinctively shift to allow manually installing cybernetics.  You no longer need external aid to install CBMs."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "HOMULLUS_CAN_USE_ELECTRONICS" },
    secondary_prerequisites = { "HOMULLUS_CAN_USE_COMPUTERS" },
    flags = { "MANUAL_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CBM_MANA_1",
    name = ccb.content.text("Cybernetic Adaptation"),
    points = 4,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Your leylines have begun adapting to electronic interference.  Halves the mana penalty caused by stored bionic power."),
    enchantments = { "INLINE_ENCH_HOMULLUS_CBM_MANA_1_0" },
    prerequisites = { "HOMULLUS_CBM_INSTALL" },
    replacements = { "HOMULLUS_CBM_MANA_2" },
    categories = { "HOMULLUS" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CBM_MANA_2",
    name = ccb.content.text("Complete Cybernetic Adaptation"),
    points = 8,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Your leylines have fully adapted to electronic interference.  You no longer suffer any mana penalty for stored bionic power."),
    enchantments = { "INLINE_ENCH_HOMULLUS_CBM_MANA_2_0" },
    prerequisites = { "HOMULLUS_CBM_MANA_1" },
    threshold_requirements = { "THRESH_HOMULLUS" },
    categories = { "HOMULLUS" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_PASSIVE_BIONIC_POWER",
    name = ccb.content.text("Internalized Charge"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You are capable of storing bionic power directly in your flesh.  You gain 50 kJ of bionic power storage per Homullus trait you have."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "HOMULLUS_CBM_MANA_1", "HOMULLUS_CBM_MANA_2" },
    enchantments = { "INLINE_ENCH_HOMULLUS_PASSIVE_BIONIC_POWER_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_ARMOR_MULT_1",
    name = ccb.content.text("Reinforced Armor"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Humans are flimsy creatures compared to even natural animals, yet by crafting armor they obtain durability that unthinking creatures will never reach.  You draw on this legacy, increasing the strength of armor you wear by 20%"),
    replacements = { "HOMULLUS_ARMOR_MULT_2" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_ARMOR_MULT_1_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_ARMOR_MULT_2",
    name = ccb.content.text("Fortified Armor"),
    points = 8,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You embody the tales of ancient knights, increasing the strength of armor you wear by 40%."),
    prerequisites = { "HOMULLUS_ARMOR_MULT_1" },
    threshold_requirements = { "THRESH_HOMULLUS" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_ARMOR_MULT_2_0", "INLINE_ENCH_HOMULLUS_ARMOR_MULT_2_1" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_DURABILITY_MULT_1",
    name = ccb.content.text("Equipment Hardening"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You conceptually harden your tools and armor, reducing the chance that they are damaged."),
    replacements = { "HOMULLUS_DURABILITY_MULT_2" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_DURABILITY_MULT_1_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_DURABILITY_MULT_2",
    name = ccb.content.text("Extreme Equipment Hardening"),
    points = 8,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You conceptually harden your tools and armor, immensely reducing the chance that they are damaged."),
    prerequisites = { "HOMULLUS_DURABILITY_MULT_1" },
    threshold_requirements = { "THRESH_HOMULLUS" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_DURABILITY_MULT_2_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_GAIN_BIONIC_POWER",
    name = ccb.content.text("Echoes of the Streets"),
    points = 5,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Though much of humanity has died, their echoes remain in the places they once called home.  The Homullus can draw on those echoes to restore their bionic power."),
    replacements = { "HOMULLUS_GAIN_BIONIC_POWER_AND_MANA" },
    prerequisites = { "HOMULLUS_CBM_MANA_1", "HOMULLUS_CBM_MANA_2" },
    secondary_prerequisites = { "HOMULLUS_PASSIVE_BIONIC_POWER" },
    categories = { "HOMULLUS" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_GAIN_BIONIC_POWER_AND_MANA",
    name = ccb.content.text("The Pulse of the Invisible"),
    points = 8,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Though much of humanity has died, their echoes remain in the places they once called home.  The Homullus can draw on those echoes to restore their bionic power and mana."),
    prerequisites = { "HOMULLUS_GAIN_BIONIC_POWER" },
    categories = { "HOMULLUS" },
    purifiable = false,
    threshold_requirements = { "THRESH_HOMULLUS" },
    enchantments = { "INLINE_ENCH_HOMULLUS_GAIN_BIONIC_POWER_AND_MANA_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CITY_STRIDER",
    name = ccb.content.text("City Strider"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You are at home in the artificial environments constructed by humanity.  You move slightly faster within."),
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_CITY_STRIDER_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_THE_HUNTER",
    name = ccb.content.text("Endurance Hunter"),
    points = 2,
    description = ccb.content.text("Early humans chased prey for miles before it dropped dead from exhaustion, and the Homullus is heir to that legacy.  You have 33% more stamina."),
    types = { "CARDIO" },
    replacements = { "HOMULLUS_THE_HUNTER2" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_THE_HUNTER_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_REGEN_STAMINA",
    name = ccb.content.text("Take the Line"),
    points = 2,
    description = ccb.content.text("By standing together, humanity was able to overcome all threats, and it was only when they turned on each other that the Cataclysm grew out of control.  The Homullus regains Stamina 5% faster per ally within 30 meters (10% faster per ally if they have the Homullus trait)."),
    prerequisites = { "HOMULLUS_THE_HUNTER", "HOMULLUS_THE_HUNTER2" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_REGEN_STAMINA_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_EAT_DEMIHUMANS",
    name = ccb.content.text("The Top of the Food Chain"),
    points = 5,
    description = ccb.content.text("Humanity are omnivores in the most literal sense.  You can eat anything not human without any moral qualms.  However, the food that pre-Cataclysm humanity would slowly poison themselves with is anathema to you, and you will eat only good-tasting food unless you are starving."),
    types = { "DIET" },
    prerequisites = { "HOMULLUS_THE_HUNTER", "HOMULLUS_THE_HUNTER2" },
    categories = { "HOMULLUS" },
    purifiable = false,
    flags = { "STRICT_HUMANITARIAN" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_TEMPERATURE_TOLERANCE",
    name = ccb.content.text("At Home in any Clime"),
    points = 6,
    description = ccb.content.text("Before the Cataclysm there were cities all across the world.  From above the Arctic Circle to directly on the equator, humanity built their dwellings.  You are more comfortable with temperature extremes."),
    types = { "ACCLIMATIZATION" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_TEMPERATURE_TOLERANCE_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CRAFTING_BONUS_1",
    name = ccb.content.text("The Tool-Maker"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Though they had no claws or fangs or armored skin, humanity mastered the world through their tools.  When near civilization, your crafting speed is increased."),
    prerequisites = { "HOMULLUS_CAN_USE_COMPUTERS", "HOMULLUS_CAN_USE_ELECTRONICS" },
    replacements = { "HOMULLUS_CRAFTING_BONUS_2" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_CRAFTING_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_CRAFTING_BONUS_2",
    name = ccb.content.text("The Innovator"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Though they had no claws or fangs or armored skin, humanity mastered the world through their tools.  When near civilization, your crafting speed and ability are increased."),
    prerequisites = { "HOMULLUS_CRAFTING_BONUS_1" },
    replacements = { "HOMULLUS_CRAFTING_BONUS_3" },
    categories = { "HOMULLUS" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_HOMULLUS_CRAFTING_BONUS_2_0" },
}

-- This should also reduce Construction times once there's some way to do so.
ccb.content.define_mutation {
    id = "HOMULLUS_CRAFTING_BONUS_3",
    name = ccb.content.text("The Builder of Cities"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Though they had no claws or fangs or armored skin, humanity mastered the world through their tools.  When near civilization, your crafting speed and ability are greatly increased."),
    prerequisites = { "HOMULLUS_CRAFTING_BONUS_2" },
    categories = { "HOMULLUS" },
    purifiable = false,
    threshold_requirements = { "THRESH_HOMULLUS" },
    enchantments = { "INLINE_ENCH_HOMULLUS_CRAFTING_BONUS_3_0" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_GAIN_INTEGRATED_TOOLS",
    name = ccb.content.text("Essence of the Makers"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("With their tools, humanity built weapons, grew food, made homes, and tamed the wilderness.  The Homullus has internalized that essence into themselves, allowing them to use their bare hands to accomplish many tasks that would otherwise require tools."),
    additions = { "HOMULLUS_GAIN_INTEGRATED_HACKER" },
    prerequisites = { "HOMULLUS_CRAFTING_BONUS_1", "HOMULLUS_CRAFTING_BONUS_2", "HOMULLUS_CRAFTING_BONUS_3" },
    categories = { "HOMULLUS" },
    purifiable = false,
    integrated_armor = { "integrated_homullus_tools" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_GAIN_INTEGRATED_HACKER",
    name = ccb.content.text("Net Spider's Touch"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("While some other animals use simple tools, complex machinery is humanity's legacy alone.  The Homullus can log into a computer or hack electronics with but a touch."),
    categories = { "HOMULLUS" },
    purifiable = false,
    prerequisites = { "HOMULLUS_GAIN_INTEGRATED_TOOLS" },
    secondary_prerequisites = { "HOMULLUS_CAN_USE_COMPUTERS" },
    integrated_armor = { "integrated_homullus_electrohack" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_EXPANDED_MUTATIONS",
    name = ccb.content.text("Mimicry of Biology"),
    points = 10,
    visibility = 0,
    ugliness = 0,
    purifiable = false,
    description = ccb.content.text("As a spirit of humanity, you lack the natural biology required for mutagens to function.  However, your powers have grown far enough to allow you to use even the most abstract of human tools, allowing you to consume mutagens to change your body.  Unlike humans, however, there are thresholds you will never be able to reach, and should you choose this route, further development of your native spirit powers will be closed off to you."),
    threshold_requirements = { "THRESH_HOMULLUS" },
    prerequisites = { "HOMULLUS_MINIMIZED_MUTATIONS" },
    categories = { "HOMULLUS" },
}

-- Stand in mutation to restrict beginning homullus's to homullus only mutations. Intended to be removed when HOMULLUS_EXPANDED_MUTATIONS is obtained.
-- true
ccb.content.define_mutation {
    id = "HOMULLUS_MINIMIZED_MUTATIONS",
    name = ccb.content.text("Homullus Biology"),
    valid = false,
    player_display = false,
    purifiable = false,
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = "",
    allowed_categories = { "HOMULLUS" },
    replacements = { "HOMULLUS_EXPANDED_MUTATIONS" },
    categories = { "HOMULLUS" },
}

-- For Homullus who choose to consume mutagen, prevent them from mutating any more homullus traits.
ccb.content.define_mutation {
    id = "HOMULLUS_NO_DOLL_MUTATIONS",
    name = ccb.content.text_without_extraction("Homullus No Doll Mutations"),
    valid = false,
    player_display = false,
    purifiable = false,
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text_without_extraction("You have chosen the path of human mutation and further Homullus mutation is closed off to you.  You should not see this in-game."),
    vitamin_intervals = { mutagen_dollkin = 1 },
    allowed_categories = {
        "ALPHA", "BATRACHIAN", "BEAST", "BIRD", "CATTLE", "CEPHALOPOD", "CHIMERA", "CHIROPTERAN",
        "CRUSTACEAN", "ELFA", "FELINE", "FISH", "GASTROPOD", "INSECT", "LIZARD", "LUPINE", "MEDICAL",
        "MOUSE", "PLANT", "RABBIT", "RAPTOR", "RAT", "SLIME", "SPIDER", "TROGLOBITE", "URSINE",
    },
}

ccb.content.define_mutation {
    id = "HOMULLUS_THE_HUNTER2",
    name = ccb.content.text("Running to Marathon"),
    points = 2,
    description = ccb.content.text("Early humans chased prey for miles before it dropped dead from exhaustion, and the Homullus is heir to that legacy.  You have 33% more stamina and you can run for much longer before tiring."),
    types = { "CARDIO", "RUNNING" },
    prerequisites = { "HOMULLUS_THE_HUNTER" },
    categories = { "HOMULLUS" },
    purifiable = false,
    threshold_requirements = { "THRESH_HOMULLUS" },
    enchantments = { "INLINE_ENCH_HOMULLUS_THE_HUNTER2_0" },
}

-- An ability that allows the Homullus to be reborn instantly upon death in a nearby feral monster or npc.  If one is not nearby the power will fail.
ccb.content.define_mutation {
    id = "DEATH_IS_BUT_A_DOOR",
    name = ccb.content.text("Death Is But A Door"),
    points = 7,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("One person may die, but their compatriots will carry their torch.  You too will have your legacy maintained if you die, but in a way far less metaphorical.  When you die, you will reincarnate within any nearby human, immediately shifting their form to match your own.  You will not be able to do this more than once per month."),
    categories = { "HOMULLUS" },
    purifiable = false,
    threshold_requirements = { "THRESH_HOMULLUS" },
}

ccb.content.define_mutation {
    id = "HOMULLUS_DOLL_FORM",
    name = ccb.content.text("Mien of the Mannequin"),
    points = 8,
    description = ccb.content.text("You may transform yourself into a doll in truth, ignoring the needs of the flesh and making most monsters less likely to attack you.  However, your stiff limbs will inhibit your movement."),
    prerequisites = { "BEAUTIFUL2", "BEAUTIFUL3" },
    secondary_prerequisites = { "HOMULLUS_SKIN_3" },
    categories = { "HOMULLUS" },
    purifiable = false,
    threshold_requirements = { "THRESH_HOMULLUS" },
    active = true,
    activation_setup_only = true,
    on_activate = "homullus_doll_form_toggle",
    on_process = "homullus_doll_form_process",
    on_deactivate = "homullus_doll_form_toggle",
}

ccb.content.define_mutation {
    id = "HOMULLUS_DOLL_FORM_TRAITS",
    name = ccb.content.text("Mannequin Form"),
    description = ccb.content.text("You are a doll in truth.  You do not need to eat or drink, and monsters will mostly ignore you, but you do not heal at all and crafting, as well as movement over any ground not almost-perfectly flat, is very difficult due to your stiff limbs."),
    points = 10,
    valid = false,
    appearance = { id = "mon_hallu_mannequin", tile_category = "monster" },
    enchantments = { "INLINE_ENCH_HOMULLUS_DOLL_FORM_TRAITS_0", "INLINE_ENCH_HOMULLUS_DOLL_FORM_TRAITS_1" },
    vitamin_intervals = { vitC = -900, iron = -900, calcium = -900 },
    flags = { "BLEED_IMMUNE", "CANNOT_CONSUME_DRUGS" },
}

-- -91 should be enough that even monsters with 100 aggression won't immediately attack, but they'll be on a hair trigger.
ccb.content.define_mutation {
    id = "HOMULLUS_DOLL_FORM_ANGER_RELATIONS",
    name = ccb.content.text_without_extraction("Mannequin Form Anger Relations"),
    description = ccb.content.text_without_extraction("Anger relations are here in a separate mutation so that they're removed on attacking a target or moving too quickly."),
    points = 2,
    valid = false,
    player_display = false,
    species_anger = {
        HUMAN = -91,
        BIRD = -91,
        MAMMAL = -91,
        ZOMBIE = -91,
        AMPHIBIAN = -91,
        REPTILE = -91,
        FISH = -91,
        KRAKEN = -91,
        MUTANT = -91,
        NETHER = -91,
        SLIME = -91,
        FUNGUS = -91,
        LEECH_PLANT = -91,
        MIGO = -91,
        INSECT = -91,
        CENTIPEDE = -91,
        INSECT_FLYING = -91,
        SPIDER = -91,
        PLANT = -91,
        MOLLUSK = -91,
        WORM = -91,
        FERAL = -91,
        ROBOT = -91,
        HORROR = -91,
        ABERRATION = -91,
        VAMPIRE = -91,
    },
}

ccb.content.define_mutation {
    id = "HOMULLUS_DOLL_FORM_ANGER_RELATIONS_ATTACKER",
    name = ccb.content.text_without_extraction("Mannequin Form Anger Relations Attacker"),
    description = ccb.content.text_without_extraction("This blocks you from gaining the anger relations mutation so you can't just turn Mien of the Mannequin on and off between attacks."),
    points = 2,
    valid = false,
    player_display = false,
}

ccb.content.define_mutation { id = "SOCIAL1", copy_from = "SOCIAL1", add = { categories = { "HOMULLUS" } } }

ccb.content.define_mutation { id = "SOCIAL2", copy_from = "SOCIAL2", add = { categories = { "HOMULLUS" } } }

ccb.content.define_mutation {
    id = "PRETTY",
    copy_from = "PRETTY",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_SELKIE", "LILIN" } },
}

ccb.content.define_mutation {
    id = "BEAUTIFUL",
    copy_from = "BEAUTIFUL",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_SELKIE", "LILIN" } },
}

ccb.content.define_mutation {
    id = "BEAUTIFUL2",
    copy_from = "BEAUTIFUL2",
    add = {
        categories = { "HOMULLUS", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_SELKIE" },
        threshold_requirements = { "THRESH_HOMULLUS", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
    },
}

ccb.content.define_mutation {
    id = "BEAUTIFUL3",
    copy_from = "BEAUTIFUL3",
    add = {
        categories = { "HOMULLUS", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_SELKIE" },
        threshold_requirements = { "THRESH_HOMULLUS", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
    },
}

ccb.content.define_mutation {
    id = "STR_UP",
    copy_from = "STR_UP",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_TROW" } },
}

ccb.content.define_mutation {
    id = "STR_UP_2",
    copy_from = "STR_UP_2",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_TROW" } },
}

ccb.content.define_mutation {
    id = "STR_ALPHA",
    copy_from = "STR_ALPHA",
    add = { categories = { "HOMULLUS" }, threshold_requirements = { "THRESH_HOMULLUS" } },
}

ccb.content.define_mutation {
    id = "DEX_UP",
    copy_from = "DEX_UP",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_BROWNIE" } },
}

ccb.content.define_mutation {
    id = "DEX_UP_2",
    copy_from = "DEX_UP_2",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_BROWNIE" } },
}

ccb.content.define_mutation {
    id = "DEX_ALPHA",
    copy_from = "DEX_ALPHA",
    add = { categories = { "HOMULLUS" }, threshold_requirements = { "THRESH_HOMULLUS" } },
}

ccb.content.define_mutation { id = "INT_UP", copy_from = "INT_UP", add = { categories = { "HOMULLUS" } } }

ccb.content.define_mutation { id = "INT_UP_2", copy_from = "INT_UP_2", add = { categories = { "HOMULLUS" } } }

ccb.content.define_mutation {
    id = "INT_ALPHA",
    copy_from = "INT_ALPHA",
    add = { categories = { "HOMULLUS" }, threshold_requirements = { "THRESH_HOMULLUS" } },
}

ccb.content.define_mutation {
    id = "PER_UP",
    copy_from = "PER_UP",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_POOKA" } },
}

ccb.content.define_mutation {
    id = "PER_UP_2",
    copy_from = "PER_UP_2",
    add = { categories = { "HOMULLUS", "FAIR_FOLK_COMMONER_POOKA" } },
}

ccb.content.define_mutation {
    id = "PER_ALPHA",
    copy_from = "PER_ALPHA",
    add = { categories = { "HOMULLUS" }, threshold_requirements = { "THRESH_HOMULLUS" } },
}
