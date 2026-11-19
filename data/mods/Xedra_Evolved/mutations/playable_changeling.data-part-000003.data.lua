local ccb = require("ccb")

ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_RIGHT_OF_PASSAGE_MECHANICS",
    name = ccb.content.text_without_extraction("Right of Passage Mechanics"),
    description = ccb.content.text_without_extraction("The mechanical effects of Right of Passage.  You should never see this."),
    points = 10,
    valid = false,
    player_display = false,
    ignored_by = {
        "PLANT",
        "MIGO",
        "CHANGELING",
        "ARVORE",
        "IERDE",
        "HOMULLUS",
        "SALAMANDER",
        "SYLPH",
        "UNDINE",
    },
    species_anger = { CYBORG = 50 },
}

-- A reference to the A.E. poem 'A Call of the Sidhe'
ccb.content.define_mutation {
    id = "STR_UP_NOBLE",
    name = ccb.content.text("Murmurs the Mighty One"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You are strong enough to defend a crossroads at twilight against all comers.  +3 Strength."),
    categories = { "FAIR_FOLK_NOBLE" },
    enchantments = { "INLINE_ENCH_STR_UP_NOBLE_0" },
}

-- A reference to the Rose Fyleman poem 'Alms in Autumn'
ccb.content.define_mutation {
    id = "DEX_UP_NOBLE",
    name = ccb.content.text("All Dancing with Delight"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You are graceful enough to dance the night away beneath a crystal dome on a floor of mirror-bright silver.  +3 Dexterity."),
    categories = { "FAIR_FOLK_NOBLE" },
    enchantments = { "INLINE_ENCH_DEX_UP_NOBLE_0" },
}

-- A reference to the Lord Dunsany poem 'The Fairy Child'
ccb.content.define_mutation {
    id = "SPEED_UP_NOBLE",
    name = ccb.content.text("At Speed Unthought Of"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Your reactions are inhumanly quick.  +15 Speed."),
    categories = { "FAIR_FOLK_NOBLE" },
    threshold_requirements = { "DEX_UP_NOBLE" },
    secondary_prerequisites = { "PARACLESIAN_STR_DEX_1", "PARACLESIAN_STR_DEX_2" },
    enchantments = { "INLINE_ENCH_SPEED_UP_NOBLE_0" },
}

ccb.content.define_mutation {
    id = "INT_UP_NOBLE",
    name = ccb.content.text("Wisdom from the Well"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Like the legendary salmon who ate the nine acorns, you have gained a plethora of wisdom.  +3 Intelligence."),
    categories = { "FAIR_FOLK_NOBLE" },
    enchantments = { "INLINE_ENCH_INT_UP_NOBLE_0" },
}

-- A reference to the Charlotte Mew poem 'The Changeling'
ccb.content.define_mutation {
    id = "PER_UP_NOBLE",
    name = ccb.content.text("Hear the Whole World Whispering"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You senses are far more attuned to your surroundings than previously.  +3 Perception."),
    categories = { "FAIR_FOLK_NOBLE" },
    enchantments = { "INLINE_ENCH_PER_UP_NOBLE_0" },
}

-- Ideally this would detect even non-allied NPCs nearby instead of just a location where NPCs are likely to be
ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_DREAMWALKER",
    name = ccb.content.text("Dreamwalker"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("From the dreams of mortals, you can spin remnants of fantasy into material substance.  When you sleep near mortals, you have a chance to awaken with some dreamdross nearby."),
    prerequisites = { "PARACLESIAN_FAE_SIGHT_1", "PARACLESIAN_FAE_SIGHT_2" },
    secondary_prerequisites = { "PER_UP_NOBLE" },
    categories = { "FAIR_FOLK_NOBLE" },
}

ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_COMMAND_COMMMONERS",
    name = ccb.content.text("Sovereign's Command"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Invoke your rights as one of noble birth and exert your authority over the commoner fae, forcing them to obey your commands.  The glamour will only last a short time, and the target is under no obligation to look on your favorably afterwards."),
    categories = { "FAIR_FOLK_NOBLE" },
    spells_learned = { changeling_noble_command_commoners_spell = 1 },
}

-- A reference to the Yeats poem 'The Stolen Child'
ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_CHARM_HUMANS",
    name = ccb.content.text("Come Away, O Human Child"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Glamour a human into defending you for a short period of time.  When the glamour ends, all effects end and the human will not be well-disposed toward you afterwards."),
    prerequisites = { "BEAUTIFUL", "BEAUTIFUL2", "BEAUTIFUL3" },
    secondary_prerequisites = { "CHANGELING_NOBLE_COMMAND_COMMMONERS" },
    categories = { "FAIR_FOLK_NOBLE" },
    spells_learned = { changeling_noble_charm_humans_spell = 1 },
}

-- A reference to the Yeats poem 'The Hosting of the Sidhe'
ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_INHUMAN_MINDSET",
    name = ccb.content.text("Empty Your Heart of its Mortal Dream"),
    points = 8,
    purifiable = false,
    description = ccb.content.text("Your mindset is shifting to the alien morality of those from Under the Hill.  You can control this to some extent, though it may also overtake you in times of pain or stress."),
    prerequisites = { "CHANGELING_NOBLE_DREAMWALKER" },
    secondary_prerequisites = { "CHANGELING_NOBLE_CHARM_HUMANS" },
    categories = { "FAIR_FOLK_NOBLE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_NOBLE" },
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("The mortal sentiments in your thoughts fade away."),
    enchantments = {
        "INLINE_ENCH_CHANGELING_NOBLE_INHUMAN_MINDSET_0",
        "INLINE_ENCH_CHANGELING_NOBLE_INHUMAN_MINDSET_1",
        "INLINE_ENCH_CHANGELING_NOBLE_INHUMAN_MINDSET_2",
        "INLINE_ENCH_CHANGELING_NOBLE_INHUMAN_MINDSET_3",
    },
}

-- This and the upgrades below should ideally require you to be unobserved, but having no one nearby will have to suffice for now.
ccb.content.define_mutation {
    id = "BROWNIE_CRAFTING_BONUS",
    name = ccb.content.text("Household Artistry"),
    description = ccb.content.text("The brownies are the unassuming crafters of the Fair Folk, and it's easy for you to build and repair things, as long as no one is nearby to watch you do it."),
    points = 1,
    purifiable = false,
    prerequisites = { "DEX_UP", "DEX_UP_2", "DEX_UP_3" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    replacements = { "BROWNIE_CRAFTING_BONUS2" },
    enchantments = { "INLINE_ENCH_BROWNIE_CRAFTING_BONUS_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_CRAFTING_BONUS2",
    name = ccb.content.text("Adept Household Artistry"),
    description = ccb.content.text("The brownies are the unassuming crafters of the Fair Folk, and it's very easy for you to build and repair things, as long as no one is nearby to watch you do it."),
    points = 1,
    purifiable = false,
    prerequisites = { "BROWNIE_CRAFTING_BONUS" },
    secondary_prerequisites = { "DEX_UP_2", "DEX_UP_3" },
    replacements = { "BROWNIE_CRAFTING_BONUS3" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_CRAFTING_BONUS2_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_CRAFTING_BONUS3",
    name = ccb.content.text("Incomparable Household Artistry"),
    description = ccb.content.text("The brownies are the unassuming crafters of the Fair Folk, and it's almost effortless for you to build and repair things, as long as no one is nearby to watch you do it."),
    points = 1,
    purifiable = false,
    prerequisites = { "BROWNIE_CRAFTING_BONUS2" },
    secondary_prerequisites = { "DEX_UP_3" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_CRAFTING_BONUS3_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_EASY_OVERLOOK",
    name = ccb.content.text("Unobtrusive"),
    description = ccb.content.text("Your appearance hasn't changed, but people don't seem to notice you as much as they used to.  As long as you don't engage in combat, you're easy to overlook."),
    points = 3,
    purifiable = false,
    prerequisites = { "CHANGELING_INVISIBILITY" },
    replacements = { "BROWNIE_EASY_OVERLOOK2" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_EASY_OVERLOOK_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_EASY_OVERLOOK2",
    name = ccb.content.text("Inconspicuous"),
    description = ccb.content.text("Your appearance hasn't changed, but people really don't seem to notice you as much as they used to.  As long as you don't engage in combat, you're very easy to overlook."),
    points = 6,
    purifiable = false,
    prerequisites = { "CHANGELING_INVISIBILITY" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_EASY_OVERLOOK2_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_COLD_TOLERANCE",
    name = ccb.content.text("Cold Tolerance"),
    description = ccb.content.text("The cold doesn't seem to bother you quite as much anymore."),
    points = 2,
    purifiable = false,
    replacements = { "BROWNIE_COLD_TOLERANCE2" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_COLD_TOLERANCE_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_COLD_TOLERANCE2",
    name = ccb.content.text("Cold Endurance"),
    description = ccb.content.text("Even on a winter day, you need only a light jacket now."),
    points = 4,
    purifiable = false,
    prerequisites = { "PARACLESIAN_STR_DEX_1" },
    secondary_prerequisites = { "HIRSUTE_BROWNIE", "BROWNIE_FUR" },
    replacements = { "BROWNIE_COLD_TOLERANCE3" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_COLD_TOLERANCE2_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_COLD_TOLERANCE3",
    name = ccb.content.text("Inured to Cold"),
    description = ccb.content.text("Legends say that brownies went about naked clad only in their almost-furry coat, and while you wouldn't go that far, you could wear a swimsuit in a blizzard without much trouble."),
    points = 8,
    purifiable = false,
    prerequisites = { "PARACLESIAN_STR_DEX_2" },
    secondary_prerequisites = { "BROWNIE_FUR" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_COLD_TOLERANCE3_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_MAKE_CHEESE_AND_BUTTER",
    name = ccb.content.text("Churning As Quick as a Wink"),
    points = 1,
    purifiable = false,
    description = ccb.content.text("Brownies are famous for their ability to do household chores, and you now have an instinctive understanding of making milk and cheese."),
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
}

ccb.content.define_mutation {
    id = "BROWNIE_THRESH_CORN_AND_WHEAT",
    name = ccb.content.text("Threshing through the Night"),
    points = 1,
    purifiable = false,
    description = ccb.content.text("Brownies are famous for their ability to do household chores, and you now have an instinctive understanding of threshing corn and wheat with only their hands."),
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
}

ccb.content.define_mutation {
    id = "HIRSUTE_BROWNIE",
    copy_from = "HIRSUTE",
    purifiable = false,
    replacements = { "BROWNIE_FUR" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
}

ccb.content.define_mutation {
    id = "BROWNIE_FUR",
    name = ccb.content.text("Coat of Fur"),
    description = ccb.content.text("Your hair has thickened to almost the level of fur covering your entire body.  It's very warm and provides some level of protection against attacks."),
    points = 2,
    visibility = 6,
    ugliness = 2,
    purifiable = false,
    prerequisites = { "HIRSUTE_BROWNIE" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    integrated_armor = { "integrated_brownie_fur" },
}

ccb.content.define_mutation {
    id = "PER_UP_BROWNIE",
    name = ccb.content.text("Seneschal's Gaze"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("With a few quick glances you can take in the contents of an entire room.  +3 Perception."),
    prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_PER_UP_BROWNIE_0" },
}

ccb.content.define_mutation {
    id = "INT_UP_BROWNIE",
    name = ccb.content.text("Chatelain's Mind"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("It takes a keen mind to keep a household running smoothly.  +2 Intelligence."),
    prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_INT_UP_BROWNIE_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_HOMEBODY",
    name = ccb.content.text("Homebody"),
    description = ccb.content.text("Brownies know every corner of their homes, all the well-worn grooves in the floor and the quick paths from place to place.  Your speed is increased the longer you spend in the same area."),
    points = 6,
    purifiable = false,
    prerequisites = { "BROWNIE_EASY_OVERLOOK" },
    secondary_prerequisites = { "BROWNIE_CRAFTING_BONUS2", "BROWNIE_CRAFTING_BONUS3" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_HOMEBODY_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_SENSE_INTRUDERS",
    name = ccb.content.text("Sense Intruders"),
    description = ccb.content.text("With the knowledge of one's home comes the knowledge that something is off about it.  You can sense any intruders nearby, as long as you are indoors and have been in the same location for some time."),
    points = 8,
    purifiable = false,
    prerequisites = { "BROWNIE_HOMEBODY" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_BROWNIE_SENSE_INTRUDERS_0" },
}

ccb.content.define_mutation {
    id = "BROWNIE_BLINK_INDOORS",
    name = ccb.content.text("Slip Through the Cracks"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You can tell every nook and cranny of indoor spaces, and know how to quickly get from one place to another."),
    prerequisites = { "BROWNIE_HOMEBODY" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    spells_learned = { changeling_brownie_blink_indoors_spell = 1 },
}

ccb.content.define_mutation {
    id = "BROWNIE_TELEPORT_HOME",
    name = ccb.content.text("Hurry Home"),
    points = 8,
    purifiable = false,
    description = ccb.content.text("You can return home from anywhere, as quick as a wink."),
    prerequisites = { "BROWNIE_BLINK_INDOORS" },
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_BROWNIE" },
    spells_learned = { changeling_teleport_home_spell = 1 },
}

ccb.content.define_mutation {
    id = "POOKA_CHARM_ANIMALS",
    name = ccb.content.text("Friend to Birds and Beasts"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You are close enough to the birds and beasts that you can speak their language and ask them for aid."),
    prerequisites = { "ANIMALEMPATH2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    spells_learned = { changeling_pooka_charm_animals_spell = 1 },
}
