local ccb = require("ccb")

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
