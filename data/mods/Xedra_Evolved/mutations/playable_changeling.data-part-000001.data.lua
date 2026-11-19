local ccb = require("ccb")

ccb.content.define_mutation {
    id = "CHANGELING_EARS",
    name = ccb.content.text("Pointed Ears"),
    description = ccb.content.text("Your upper earlobes have grown noticeably higher.  Fortunately, they don't get in the way of your headgear, much.  Unfortunately, they also don't seem to help your hearing any."),
    types = { "EARS" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    points = 0,
    vitamin_cost = 80,
    visibility = 4,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "THRESH_FAIR_FOLK_NOBLE",
    name = ccb.content.text("Noble"),
    points = 0,
    description = ccb.content.text("You have awakened your long-slumbering heritage as one of the nobility of the Fair Folk."),
    valid = false,
    purifiable = false,
    threshold = true,
    enchantments = { "INLINE_ENCH_THRESH_FAIR_FOLK_NOBLE_0", "INLINE_ENCH_THRESH_FAIR_FOLK_NOBLE_1" },
}

ccb.content.define_mutation {
    id = "FAIR_FOLK_COMMONER_SELECTOR",
    name = ccb.content.text_without_extraction("Commoner Changeling"),
    points = 1,
    description = ccb.content.text_without_extraction("This tracks your heritage, used to pick a subcategory.  You shouldn't see it."),
    valid = false,
    purifiable = false,
    types = { "HERITAGE" },
    player_display = false,
    chargen_allow_npc = false,
    flags = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "CHANGELING_COURT_SUMMER",
    name = ccb.content.text("Summer Court"),
    points = 1,
    description = ccb.content.text("You are a member of the Summer Court, sometimes called the Seelie Court, the faeries recognized as benevolent by mortals.  Or, at least, the faeries who are slightly less likely to levy generational curses on those who wrong them."),
    valid = false,
    purifiable = false,
    profession = true,
    cancels = { "CHANGELING_COURT_WINTER" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "CHANGELING_COURT_WINTER",
    name = ccb.content.text("Winter Court"),
    points = 1,
    description = ccb.content.text("You are a member of the Winter Court, sometimes called the Unseelie Court, the faeries most feared by mortals.  Too bad there's so few of them around nowadays."),
    valid = false,
    purifiable = false,
    profession = true,
    cancels = { "CHANGELING_COURT_SUMMER" },
    chargen_allow_npc = false,
}

-- true
ccb.content.define_mutation {
    id = "CHANGELING_MAGIC",
    name = ccb.content.text("Glamour"),
    points = 1,
    description = ccb.content.text("The fey ability to spin whimsy into reality."),
    valid = false,
    purifiable = false,
    player_display = false,
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "CHANGELING_SEASONAL_MAGIC_SPRING",
    name = ccb.content.text_without_extraction("Spring"),
    points = 1,
    description = ccb.content.text_without_extraction("This provides the school trait for Spring seasonal magic.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
    enchantments = { "INLINE_ENCH_CHANGELING_SEASONAL_MAGIC_SPRING_0" },
}

ccb.content.define_mutation {
    id = "CHANGELING_SEASONAL_MAGIC_SUMMER",
    name = ccb.content.text_without_extraction("Summer"),
    points = 1,
    description = ccb.content.text_without_extraction("This provides the school trait for Summer seasonal magic.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
    enchantments = { "INLINE_ENCH_CHANGELING_SEASONAL_MAGIC_SUMMER_0" },
}

ccb.content.define_mutation {
    id = "CHANGELING_SEASONAL_MAGIC_AUTUMN",
    name = ccb.content.text_without_extraction("Autumn"),
    points = 1,
    description = ccb.content.text_without_extraction("This provides the school trait for Autumn seasonal magic.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
    enchantments = { "INLINE_ENCH_CHANGELING_SEASONAL_MAGIC_AUTUMN_0" },
}

ccb.content.define_mutation {
    id = "CHANGELING_SEASONAL_MAGIC_WINTER",
    name = ccb.content.text_without_extraction("Winter"),
    points = 1,
    description = ccb.content.text_without_extraction("This provides the school trait for Winter seasonal magic.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    cancels = { "DREAMER", "DREAMSMITH", "EATER", "INVENTOR" },
    enchantments = { "INLINE_ENCH_CHANGELING_SEASONAL_MAGIC_WINTER_0" },
}

ccb.content.define_mutation {
    id = "CHANGELING_DREAMSPARK_STORAGE_10",
    name = ccb.content.text_without_extraction("Dreamspark Storage 10"),
    points = 1,
    description = ccb.content.text_without_extraction("This is dreamspark storage.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    integrated_armor = { "integrated_dreamspark_storage_10" },
}

ccb.content.define_mutation {
    id = "CHANGELING_DREAMSPARK_STORAGE_20",
    name = ccb.content.text_without_extraction("Dreamspark Storage 20"),
    points = 1,
    description = ccb.content.text_without_extraction("This is dreamspark storage.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    integrated_armor = { "integrated_dreamspark_storage_20" },
}

ccb.content.define_mutation {
    id = "CHANGELING_DREAMSPARK_STORAGE_30",
    name = ccb.content.text_without_extraction("Dreamspark Storage 30"),
    points = 1,
    description = ccb.content.text_without_extraction("This is dreamspark storage.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    integrated_armor = { "integrated_dreamspark_storage_30" },
}

ccb.content.define_mutation {
    id = "CHANGELING_DREAMSPARK_STORAGE_40",
    name = ccb.content.text_without_extraction("Dreamspark Storage 40"),
    points = 1,
    description = ccb.content.text_without_extraction("This is dreamspark storage.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    integrated_armor = { "integrated_dreamspark_storage_40" },
}

ccb.content.define_mutation {
    id = "CHANGELING_DREAMSPARK_STORAGE_50",
    name = ccb.content.text_without_extraction("Dreamspark Storage 50"),
    points = 1,
    description = ccb.content.text_without_extraction("This is dreamspark storage.  It should not be visible."),
    valid = false,
    purifiable = false,
    player_display = false,
    integrated_armor = { "integrated_dreamspark_storage_50" },
}

ccb.content.define_mutation {
    id = "UNKNOWING_CHANGELING_NOBLE",
    name = ccb.content.text("Changeling"),
    description = ccb.content.text("You grew up thinking you were human, just another person among billions, but you were born Under the Hill and swapped for a human baby shortly after birth.  While you find it uncomfortable ever since your heritage asserted itself, your time in the mortal realm has inured you to the presence of iron.  However, it has not done so enough to allow you to install any CBMs."),
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    points = 0,
    allowed_categories = { "FAIR_FOLK_NOBLE" },
    categories = { "FAIR_FOLK_NOBLE" },
    types = { "HERITAGE" },
    enchantments = { "INLINE_ENCH_UNKNOWING_CHANGELING_NOBLE_0" },
    flags = { "HERITAGE", "NO_CBM_INSTALLATION" },
    cancels = { "CHAOTIC", "CHAOTIC_BAD" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "UNKNOWING_CHANGELING_COMMONER_BROWNIE",
    copy_from = "UNKNOWING_CHANGELING_NOBLE",
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    allowed_categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    enchantments = { "INLINE_ENCH_UNKNOWING_CHANGELING_COMMONER_BROWNIE_0" },
    cancels = { "CHAOTIC", "CHAOTIC_BAD" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "THRESH_FAIR_FOLK_COMMONER_BROWNIE",
    name = ccb.content.text("Brownie"),
    points = 0,
    description = ccb.content.text("You have awakened your long-slumbering heritage as a brownie, hard-working and mostly unseen."),
    valid = false,
    purifiable = false,
    threshold = true,
    enchantments = {
        "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_BROWNIE_0",
        "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_BROWNIE_1",
    },
}

ccb.content.define_mutation {
    id = "UNKNOWING_CHANGELING_COMMONER_POOKA",
    copy_from = "UNKNOWING_CHANGELING_NOBLE",
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    allowed_categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_UNKNOWING_CHANGELING_COMMONER_POOKA_0" },
    cancels = { "CHAOTIC", "CHAOTIC_BAD" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "THRESH_FAIR_FOLK_COMMONER_POOKA",
    name = ccb.content.text("Pooka"),
    points = 0,
    description = ccb.content.text("You have awakened your long-slumbering heritage as a pooka, a shapeshifter close to nature."),
    valid = false,
    purifiable = false,
    threshold = true,
    enchantments = {
        "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_POOKA_0",
        "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_POOKA_1",
    },
}

ccb.content.define_mutation {
    id = "UNKNOWING_CHANGELING_COMMONER_SELKIE",
    copy_from = "UNKNOWING_CHANGELING_NOBLE",
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    allowed_categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    enchantments = { "INLINE_ENCH_UNKNOWING_CHANGELING_COMMONER_SELKIE_0" },
    cancels = { "CHAOTIC", "CHAOTIC_BAD" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "THRESH_FAIR_FOLK_COMMONER_SELKIE",
    name = ccb.content.text("Selkie"),
    points = 0,
    description = ccb.content.text("You have awakened your long-slumbering heritage as a selkie, with one foot on the land and one in the sea."),
    valid = false,
    purifiable = false,
    threshold = true,
    enchantments = {
        "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_SELKIE_0",
        "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_SELKIE_1",
    },
}

ccb.content.define_mutation {
    id = "UNKNOWING_CHANGELING_COMMONER_TROW",
    copy_from = "UNKNOWING_CHANGELING_NOBLE",
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    allowed_categories = { "FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_UNKNOWING_CHANGELING_COMMONER_TROW_0" },
    cancels = { "CHAOTIC", "CHAOTIC_BAD" },
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "THRESH_FAIR_FOLK_COMMONER_TROW",
    name = ccb.content.text("Trow"),
    points = 0,
    description = ccb.content.text("You have awakened your long-slumbering heritage as a trow, strong and enduring as the mountains."),
    valid = false,
    purifiable = false,
    threshold = true,
    enchantments = {
        "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_TROW_0",
        "INLINE_ENCH_THRESH_FAIR_FOLK_COMMONER_TROW_1",
    },
}

ccb.content.define_mutation {
    id = "STR_UP_3",
    copy_from = "STR_UP_3",
    add = {
        categories = { "FAIR_FOLK_COMMONER_TROW" },
        threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_TROW" },
    },
}

ccb.content.define_mutation {
    id = "STR_UP_4",
    copy_from = "STR_UP_4",
    add = {
        categories = { "FAIR_FOLK_COMMONER_TROW" },
        threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_TROW" },
    },
}

ccb.content.define_mutation {
    id = "DEX_UP_3",
    copy_from = "DEX_UP_3",
    add = {
        categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
        threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_BROWNIE" },
    },
}

ccb.content.define_mutation {
    id = "DEX_UP_4",
    copy_from = "DEX_UP_4",
    add = {
        categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
        threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_BROWNIE" },
    },
}

ccb.content.define_mutation {
    id = "PER_UP_3",
    copy_from = "PER_UP_3",
    add = {
        categories = { "FAIR_FOLK_COMMONER_POOKA" },
        threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_POOKA" },
    },
}

ccb.content.define_mutation {
    id = "PER_UP_4",
    copy_from = "PER_UP_4",
    add = {
        categories = { "FAIR_FOLK_COMMONER_POOKA" },
        threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_POOKA" },
    },
}

ccb.content.define_mutation {
    id = "DISRESISTANT",
    copy_from = "DISRESISTANT",
    add = {
        categories = {
            "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
            "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW", "LILIN",
        },
    },
}

ccb.content.define_mutation {
    id = "DISIMMUNE",
    copy_from = "DISIMMUNE",
    add = {
        categories = {
            "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
            "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW", "LILIN",
        },
    },
}

ccb.content.define_mutation {
    id = "CHANGELING_GAIN_DREAMDROSS_FROM_MORTAL_DREAMS",
    name = ccb.content.text("Banquet of Dreams"),
    points = 2,
    description = ccb.content.text("The Fair Folk rely on mortal dreams for power, and this glamour is one of the ways they harvest them.  When woven over a sleeping mortal, some of the power of their dreams coalesces as a shimmering metallic substance called dreamdross.  Activate to increase the intensity, drawing out far more dreamdross but causing permanent damage to the target's dreams."),
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    activation_message = ccb.content.text("You get ready to rip as much power from mortal dreams as you can."),
    spells_learned = { changeling_gain_dreamdross_from_dreams = 1 },
    enchantments = { "INLINE_ENCH_CHANGELING_GAIN_DREAMDROSS_FROM_MORTAL_DREAMS_0" },
}

ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_CURE_BAD_CONDITIONS",
    name = ccb.content.text("Lights of Imbolc"),
    points = 2,
    description = ccb.content.text("The end of winter brings hope for the coming of spring, and in the light of the candles lit at Imbolc the dust and gloom of the long nights end."),
    prerequisites = { "DISRESISTANT" },
    categories = { "FAIR_FOLK_NOBLE" },
    purifiable = false,
    spells_learned = { changeling_noble_cure_bad_conditions_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_BURNING_WEAPON",
    name = ccb.content.text("Fires of Bealtaine"),
    points = 3,
    description = ccb.content.text("The bonfires of Bealtaine drive away evil and purify both man and beast."),
    prerequisites = { "PARACLESIAN_FAE_SIGHT_1", "PARACLESIAN_FAE_SIGHT_2" },
    categories = { "FAIR_FOLK_NOBLE" },
    purifiable = false,
    spells_learned = { changeling_noble_burning_weapon_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_MOVEMENT_BUFFS",
    name = ccb.content.text("Deeds of Lughnasadh"),
    points = 4,
    description = ccb.content.text("Lughnasadh is a time for bringing in the harvest and for contests of skill and stamina."),
    prerequisites = { "PARACLESIAN_STR_DEX_1", "PARACLESIAN_STR_DEX_2" },
    categories = { "FAIR_FOLK_NOBLE" },
    purifiable = false,
    spells_learned = { changeling_noble_movement_buffs_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_SUMMON_GHOSTS",
    name = ccb.content.text("Hosts of Samhain"),
    points = 8,
    description = ccb.content.text("As the year dies and winter's winds begin to blow, the dead return for a short time to visit the living."),
    prerequisites = { "CHANGELING_SUMMON_WILL_O_THE_WISPS", "CHANGELING_NOBLE_RIGHT_OF_PASSAGE" },
    categories = { "FAIR_FOLK_NOBLE" },
    purifiable = false,
    spells_learned = { changeling_noble_summon_ghosts_spell = 1 },
}
