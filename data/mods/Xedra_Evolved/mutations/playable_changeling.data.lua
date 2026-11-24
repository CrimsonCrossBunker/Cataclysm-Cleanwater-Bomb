local ccb = require("ccb")

-- Whenever you add more traits, make sure to update the trait Jmath
ccb.content.define_profession {
    subtype = "hobby",
    id = "hobby_species_changeling_noble",
    name = "Unknowing Changeling, Noble (Species)",
    description = "You grew up thinking you were human, just another person among billions, but you were born Under the Hill and swapped for a human baby shortly after birth.  Your parents were the nobility of the Fair Folk, the great lords and ladies who traveled in spider-silk carriages on roads built of moonbeams and danced the unending nights away before leading fantastic armies in battle the next morning.  When the Cataclysm hit, your parents' slumbering power asserted itself, giving you access to a portion of their fae magick.  Hopefully it will help you survive.",
    points = 4,
    traits = { "CHANGELING_EARS", "CHANGELING_MAGIC", "UNKNOWING_CHANGELING_NOBLE" },
    allow_npc = false,
}

ccb.content.define_profession {
    subtype = "hobby",
    id = "hobby_species_changeling_commoner",
    name = "Unknowing Changeling, Commoner (Species)",
    description = "You grew up thinking you were human, just another person among billions, but you were born Under the Hill and swapped for a human baby shortly after birth.  Your parents come from the common masses of the Fair Folk, the pooka, redcaps, hobgoblins, trow, pixies, knockers, selkies, or any of the myriad of others.  When the Cataclysm hit, your parents' slumbering power asserted itself, revealing your heritage and giving you access to a portion of their fae magick.  Hopefully it will help you survive.",
    points = 4,
    traits = { "FAIR_FOLK_COMMONER_SELECTOR", "CHANGELING_MAGIC", "CHANGELING_EARS" },
    allow_npc = false,
}

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

ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_RIGHT_OF_PASSAGE",
    name = ccb.content.text("Right of Passage"),
    points = 8,
    description = ccb.content.text("The Fair Folk have dealt with many mortal civilizations over the aeons, and have come to mutually beneficial arrangements with some of them.  Activate this trait to make your fae nature obvious, invoking those ancient agreements.  This <color_yellow>may anger</color> some who have especially bad relationships with the fae."),
    prerequisites = { "PRETTY", "BEAUTIFUL", "BEAUTIFUL2", "BEAUTIFUL3" },
    secondary_prerequisites = { "CHANGELING_NOBLE_COMMAND_COMMMONERS" },
    categories = { "FAIR_FOLK_NOBLE" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    on_activate = "changeling_right_of_passage_on",
    on_deactivate = "changeling_right_of_passage_off",
}

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

ccb.content.define_mutation {
    id = "POOKA_ANTLERS",
    name = ccb.content.text("Antlers (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow an impressive rack of antlers, allowing you to make a headbutt attack but preventing you from wearing a helmet."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_HORNS",
    name = ccb.content.text("Curled Horns (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a set of spiraling curled horns, allowing you to make a headbutt attack but preventing you from wearing a helmet."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_FANGS",
    name = ccb.content.text("Fangs (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a set of sharp fangs, allowing you to make a bite attack."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    replacements = { "POOKA_SABER_TEETH" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_SABER_TEETH",
    name = ccb.content.text("Vicious Fangs (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a set of long, saber-like fangs, preventing you from wearing mouth gear but allowing you to make rending bite attacks."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    prerequisites = { "POOKA_FANGS" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_WOLF_EARS",
    name = ccb.content.text("Wolf Ears (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Change your ears into the ears of a wolf, granting you increased hearing."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_FELINE_EARS",
    name = ccb.content.text("Feline Ears (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Change your ears into the ears of a great cat, granting you increased hearing."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_CLAWS",
    name = ccb.content.text("Claws (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a set of claws, improving your unarmed damage if you aren't wearing gloves."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    replacements = { "POOKA_STAINLESS_CLAWS" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_STAINLESS_CLAWS",
    name = ccb.content.text("Vicious Claws (Shapeshift)"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("Grow a powerful set of claws, nearly as hard as steel, greatly improving your unarmed damage if you aren't wearing gloves."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    prerequisites = { "POOKA_CLAWS" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_BIRD_WINGS",
    name = ccb.content.text("Bird Wings (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Transform your arms into bird wings, allow you to slow your fall when jumping from a high place and glide short distances."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_URSINE_FUR",
    name = ccb.content.text("Thick Fur (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a coat of thick fur, keeping you warm in the winter and protecting you from attacks."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_CHITIN",
    name = ccb.content.text("Chitin Carapace (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow an armored suit of chitin, protecting you and making your punches hit harder."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_QUADRUPED",
    name = ccb.content.text("Quadruped (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow paws and animal-like legs, allowing you to run much faster on all fours, but preventing you from wearing shoes or gloves."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_LEAPING_LEGS",
    name = ccb.content.text("Leaping Legs (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow strong frog- or cat-like legs, allowing you to leap great distances."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_SKUNK_TAIL",
    name = ccb.content.text("Skunk Tail (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow the tail of a skunk, making it harder to wear pants but giving you the ability to stun creatures that have acute sense of smell."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "TAIL_SKUNK",
    name = ccb.content.text("Skunk Tail"),
    points = 1,
    vitamin_cost = 130,
    visibility = 7,
    description = ccb.content.text("You have a long, black and white striped, fluffy-furred tail.  When attacked you will reflexively spray a defensive stink chemical.  Prevents wearing non-fabric pants."),
    types = { "TAIL" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    valid = false,
    restricts_gear = { "leg_hip_l", "leg_hip_r" },
    allowed_item_flags = { "ALLOWS_TAIL" },
    allow_soft_gear = true,
    integrated_armor = { "integrated_skunk_tail" },
    active = true,
    starts_active = true,
}

ccb.content.define_mutation {
    id = "POOKA_WOLF_TAIL",
    name = ccb.content.text("Wolf Tail (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow the tail of a wolf, making it harder to wear pants but improving your balance."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_TAIL_LONG",
    name = ccb.content.text("Cat Tail (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow the tail of a cat, making it harder to wear pants but improving your balance."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_TAIL_STING",
    name = ccb.content.text("Spiked Tail (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow the tail of a scorpion, making it harder to wear pants but allowing you to attack with the stinger."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "STR_UP_POOKA",
    name = ccb.content.text("Bestial Strength"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Even when not shapeshifted you can bring part of a wild animal's strength to bear.  +2 Strength."),
    prerequisites = { "PARACLESIAN_STR_DEX_1", "PARACLESIAN_STR_DEX_2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_STR_UP_POOKA_0" },
}

ccb.content.define_mutation {
    id = "DEX_UP_POOKA",
    name = ccb.content.text("Untamed Agility"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You have the quick reactions of a wild animal.  +3 Dexterity."),
    prerequisites = { "PARACLESIAN_STR_DEX_1", "PARACLESIAN_STR_DEX_2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_DEX_UP_POOKA_0" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_GOOD",
    name = ccb.content.text("Initiate of Forms"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You are getting better at shapeshifting and are able to maintain one more simultaneous shapeshift without drawing on your mana."),
    replacements = { "POOKA_SHAPESHIFT_GOOD2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_GOOD2",
    name = ccb.content.text("Adept of Forms"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You are getting much better at shapeshifting and are able to maintain two more simultaneous shapeshifts without drawing on your mana."),
    prerequisites = { "POOKA_SHAPESHIFT_GOOD" },
    replacements = { "POOKA_SHAPESHIFT_GOOD3" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_GOOD3",
    name = ccb.content.text("Master of Forms"),
    points = 6,
    purifiable = false,
    description = ccb.content.text("You are a master of shapeshifting and are able to maintain four more simultaneous shapeshifts without drawing on your mana."),
    prerequisites = { "POOKA_SHAPESHIFT_GOOD2" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_POOKA" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_SELECTOR",
    name = ccb.content.text_without_extraction("Pinnacle of Forms"),
    points = 6,
    purifiable = false,
    description = ccb.content.text_without_extraction("This gives you access to the full shapeshift traits.  You should never seen it."),
    prerequisites = { "POOKA_SHAPESHIFT_GOOD2", "POOKA_SHAPESHIFT_GOOD3" },
    player_display = false,
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_POOKA" },
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_BAT",
    name = ccb.content.text("Spirit of the Bat"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a bat."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_RAVEN",
    name = ccb.content.text("Spirit of the Raven"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a raven."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_BEAR",
    name = ccb.content.text("Spirit of the Bear"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a bear."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_DEER",
    name = ccb.content.text("Spirit of the Deer"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a deer."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_WOLF",
    name = ccb.content.text("Spirit of the Wolf"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a wolf."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_SHAPESHIFT_FULL_COUGAR",
    name = ccb.content.text("Spirit of the Cougar"),
    points = 10,
    description = ccb.content.text("You can transform yourself into a cougar."),
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_full_form",
    on_process = "pooka_maintain_full_form",
    on_deactivate = "pooka_end_full_form",
}

ccb.content.define_mutation {
    id = "POOKA_UNARMED_ATTACK_BONUSES",
    name = ccb.content.text("Instinctive Attacks"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You're getting used to moving and reacting like an animal.  When without weapons or armor and using your gifts of shapeshifting, your natural attacks do more damage."),
    prerequisites = { "POOKA_ANTLERS", "POOKA_HORNS", "POOKA_FANGS", "POOKA_SABER_TEETH" },
    secondary_prerequisites = { "POOKA_CLAWS", "POOKA_STAINLESS_CLAWS", "POOKA_TAIL_STING" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_POOKA_UNARMED_ATTACK_BONUSES_0" },
}

ccb.content.define_mutation {
    id = "POOKA_UNARMED_DODGE_BONUSES",
    name = ccb.content.text("Animalistic Defense"),
    points = 5,
    purifiable = false,
    description = ccb.content.text("The best defense is not getting hit, especially if you're a wild animal.  When using your shapeshifting and not wearing armor or using a weapon, you gain a bonus to your dodging."),
    prerequisites = { "POOKA_UNARMED_ATTACK_BONUSES" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_POOKA_UNARMED_DODGE_BONUSES_0" },
}

ccb.content.define_mutation {
    id = "POOKA_SPEED_BONUSES",
    name = ccb.content.text("Primal Alacrity"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Like the animals you mimic, you're quicker than you seem.  You gain a speed bonus while shapeshifted as long as you're unarmed and unarmored."),
    prerequisites = { "POOKA_UNARMED_ATTACK_BONUSES" },
    secondary_prerequisites = { "WINGS_BIRD", "POOKA_LEAPING_LEGS", "POOKA_QUADRUPED", "TAIL_FLUFFY", "TAIL_LONG" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_POOKA_SPEED_BONUSES_0" },
}

ccb.content.define_mutation {
    id = "DEX_UP_SELKIE",
    name = ccb.content.text("Bending Like the River"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Your movements are graceful whether on land or in the water.  +3 Dexterity."),
    prerequisites = { "PARACLESIAN_STR_DEX_1", "PARACLESIAN_STR_DEX_2" },
    secondary_prerequisites = { "SELKIE_WATERMOVE" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    enchantments = { "INLINE_ENCH_DEX_UP_SELKIE_0" },
}

ccb.content.define_mutation {
    id = "PER_UP_SELKIE",
    name = ccb.content.text("Eyes On the Waterline"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Your sight is keen whether in or out of the water.  +2 Perception."),
    prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    enchantments = { "INLINE_ENCH_PER_UP_SELKIE_0" },
}

ccb.content.define_mutation {
    id = "INT_UP_SELKIE",
    name = ccb.content.text("Thoughts like Clear Water"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Your mind flows easily from topic to topic while remembering the important details.  +2 Intelligence."),
    prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    enchantments = { "INLINE_ENCH_INT_UP_SELKIE_0" },
}

ccb.content.define_mutation {
    id = "SELKIE_BEGUILMENT",
    name = ccb.content.text("Beguilement"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Glamour a human into defending you for a short period of time.  When the glamour ends, all effects end and the human will not be well-disposed toward you afterwards."),
    prerequisites = { "BEAUTIFUL", "BEAUTIFUL2", "BEAUTIFUL3" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_beguilement_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_FOG_CLOAK",
    name = ccb.content.text("Cloak of Fog"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Surround yourself with a thick fog, obscuring your position."),
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_fog_cloak_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_DENSE_FOG",
    name = ccb.content.text("Chant of Concealing Mists"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Call up a thick mist, shrouding the nearby landscape."),
    prerequisites = { "SELKIE_FOG_CLOAK" },
    secondary_prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_change_weather_dense_fog_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_RAIN",
    name = ccb.content.text("Aria of the Droplets"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Call a rain shower, letting the rains water the earth."),
    prerequisites = { "SELKIE_CHANGE_WEATHER_DENSE_FOG" },
    secondary_prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_change_weather_rains_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_RAINSTORM",
    name = ccb.content.text("Canticle of Rainstorms"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Call a heavy rainstorm, soaking everything."),
    prerequisites = { "SELKIE_CHANGE_WEATHER_RAIN" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_change_weather_rainstorm_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_LIGHTNINGSTORM",
    name = ccb.content.text("Symphony of Levin"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Call a lightning storm, ."),
    prerequisites = { "SELKIE_CHANGE_WEATHER_RAINSTORM" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_change_weather_lightningstorm_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_BREATHING_WATER",
    name = ccb.content.text("Breathing Water"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You can breathe water just as easily as you can breathe air, and have no trouble switching between them."),
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    replacements = { "SELKIE_BREATHING_WATER2" },
    types = { "GILLS" },
    flags = { "GILLS" },
}

ccb.content.define_mutation {
    id = "SELKIE_BREATHING_WATER2",
    name = ccb.content.text("At Home in the Water"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You can breathe water just as easily as you can breathe air, and have no trouble switching between them.  In addition, being wet is pleasant in a way it never was before."),
    prerequisites = { "SELKIE_BREATHING_WATER" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    types = { "GILLS" },
    flags = { "GILLS" },
    wet_protection = {
        { part = "torso", good = 10 },
        { part = "head", good = 10 },
        { part = "leg_l", good = 10 },
        { part = "leg_r", good = 10 },
        { part = "arm_l", good = 10 },
        { part = "arm_r", good = 10 },
        { part = "mouth", good = 10 },
        { part = "hand_l", good = 10 },
        { part = "hand_r", good = 10 },
        { part = "foot_l", good = 10 },
        { part = "foot_r", good = 10 },
    },
}

ccb.content.define_mutation {
    id = "SELKIE_WATERSLEEP",
    name = ccb.content.text("The Waves my Bed"),
    points = 1,
    purifiable = false,
    description = ccb.content.text("Falling asleep underwater is easy for you, and you spend less time asleep when you rest there."),
    secondary_prerequisites = { "DEX_UP_SELKIE" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    comfort = {
        {
            conditions = { { kind = "terrain", flag = "DEEP_WATER" } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You lay beneath the waves' embrace, gazing up through the water's surface…"),
                rating = "good",
            },
        },
        {
            conditions = { { kind = "terrain", flag = "SWIMMABLE" } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You settle into the water and begin to drowse…"),
                rating = "good",
            },
        },
    },
    enchantments = { "INLINE_ENCH_SELKIE_WATERSLEEP_0" },
}

ccb.content.define_mutation {
    id = "SELKIE_WATERMOVE",
    name = ccb.content.text("Cutting Through the Waves"),
    points = 1,
    purifiable = false,
    description = ccb.content.text("Your hands and feet haven't changed at all, but they seem to be much better at swimming than before.  You gain a speed bonus when in water, increased when not wearing shoes."),
    prerequisites = { "SELKIE_BREATHING_WATER", "SELKIE_BREATHING_WATER2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    flags = { "WEBBED_HANDS", "WEBBED_FEET" },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_MASTER",
    name = ccb.content.text("Conductor of Storms"),
    points = 6,
    purifiable = false,
    description = ccb.content.text("You are a master of meteorological enchantments, and your weather manipulations will last much longer."),
    prerequisites = { "SELKIE_CHANGE_WEATHER_RAINSTORM" },
    secondary_prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
}

ccb.content.define_mutation {
    id = "TROW_MAKE_NOISE",
    name = ccb.content.text("The One Who Knocks"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Create a loud knocking sound within the glamour's range, to distract or lure your enemies away."),
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    spells_learned = { trow_make_noise_spell = 1 },
}

ccb.content.define_mutation {
    id = "TROW_STONE_FISTS",
    name = ccb.content.text("Fists of Stone"),
    points = 4,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Your tough skin and thick nails allow you to use your hands to replace some simple tools.  Your punches hit harder as well."),
    types = { "CLAWS" },
    prerequisites = { "IERDE_SKIN_2" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    integrated_armor = { "integrated_trow_fists" },
}

ccb.content.define_mutation {
    id = "TROW_LESS_METABOLISM_UNDERGROUND",
    name = ccb.content.text("Stone-Eater"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    purifiable = false,
    description = ccb.content.text("The trow don't literally eat stones, but merely being underground fills you with strength and vigor.  You need half as much food and water while you're underground, and cold underground does not affect you."),
    types = { "METABOLISM" },
    prerequisites = { "PAINRESIST_TROW", "PAINRESIST_TROW2" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_TROW_LESS_METABOLISM_UNDERGROUND_0" },
}

ccb.content.define_mutation {
    id = "TROW_WHILE_MINING_NO_EATING_OR_SLEEP",
    name = ccb.content.text("Deep-Delver"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    purifiable = false,
    description = ccb.content.text("Once you begin mining, you can do it for hours without rest or sleep.  You need neither food nor drink nor rest for as long as you continue mining."),
    prerequisites = { "TROW_LESS_METABOLISM_UNDERGROUND" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
}

ccb.content.define_mutation {
    id = "TROW_STEALTH_UNDERGROUND_ON_ROCK",
    name = ccb.content.text("Amongst the Stones"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    purifiable = false,
    description = ccb.content.text("While on rock or underground, you seem to subtly blend into your surroundings.  You are harder to spot on rocks or underground."),
    prerequisites = { "IERDE_SKIN_2" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_TROW_STEALTH_UNDERGROUND_ON_ROCK_0" },
}

ccb.content.define_mutation {
    id = "PAINRESIST",
    copy_from = "PAINRESIST",
    add = { categories = { "FAIR_FOLK_COMMONER_TROW" } },
}

ccb.content.define_mutation {
    id = "PAINRESIST_TROW",
    name = ccb.content.text("Resilience of the Stones"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You are as hardy as the rock.  When underground, you suffer much less pain."),
    types = { "PAIN" },
    prerequisites = { "PAINRESIST" },
    secondary_prerequisites = { "STR_UP_2", "STR_UP_3", "STR_UP_4" },
    replacements = { "PAINRESIST_TROW2" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_PAINRESIST_TROW_0" },
}

ccb.content.define_mutation {
    id = "TROW_MOONS_TEARS_FORGING",
    name = ccb.content.text("Shaping the Tears"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You have learned the secrets of forging moon's tears.  Sometimes in your dreams, a new recipe might be revealed to you."),
    secondary_prerequisites = { "STR_UP_2", "STR_UP_3", "STR_UP_4" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
}

ccb.content.define_mutation {
    id = "PAINRESIST_TROW2",
    name = ccb.content.text("Unwavering Resilience of the Stones"),
    points = 6,
    purifiable = false,
    description = ccb.content.text("You are as hardy as the rock.  When underground you suffer much less pain, and your strength is not reduced by the pain you suffer."),
    prerequisites = { "PAINRESIST_TROW" },
    secondary_prerequisites = { "STR_UP_3", "STR_UP_4" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_PAINRESIST_TROW2_0", "INLINE_ENCH_PAINRESIST_TROW2_1" },
}

ccb.content.define_mutation {
    id = "FAE_NIGHTVISION",
    name = ccb.content.text("Unveiling the Night"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Your sharp eyes can pierce the darkness."),
    replacements = { "FAE_NIGHTVISION2" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    enchantments = { "INLINE_ENCH_FAE_NIGHTVISION_0" },
}

ccb.content.define_mutation {
    id = "FAE_NIGHTVISION2",
    name = ccb.content.text("Pierce the Shadows"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Whether woods under trees or the cavern depths, you can see through the murk."),
    prerequisites = { "FAE_NIGHTVISION" },
    categories = { "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_TROW" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_POOKA", "THRESH_FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_FAE_NIGHTVISION2_0" },
}

ccb.content.define_mutation {
    id = "CHANGELING_DISGUISE_AS_NATURE",
    name = ccb.content.text("None Here but the Stones"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("The Fair Folk can remain hidden among rocks or trees or whispers of wind, and now you can too."),
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { changeling_disguise_as_nature_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_INVISIBILITY",
    name = ccb.content.text("Hidden from Mortal Eyes"),
    points = 6,
    purifiable = false,
    description = ccb.content.text("Like the Fair Folk of legend, you can remain unseen when you wish."),
    prerequisites = { "CHANGELING_DISGUISE_AS_NATURE" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE", "THRESH_FAIR_FOLK_COMMONER_POOKA",
        "THRESH_FAIR_FOLK_COMMONER_SELKIE", "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { changeling_invisibility_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_STOP_NETHER_CONDITIONS",
    name = ccb.content.text("Dancers in the Endless Dark"),
    points = 8,
    purifiable = false,
    description = ccb.content.text("The Fair Folk dance across realities, avoiding the notice of the vast and timeless forces that overshadow existence.  This glamour will protect you from a variety of deleterious otherworldly afflictions.  It must be applied before exposure."),
    prerequisites = { "CHANGELING_INVISIBILITY" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE", "THRESH_FAIR_FOLK_COMMONER_POOKA",
        "THRESH_FAIR_FOLK_COMMONER_SELKIE", "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { changeling_stop_nether_conditions_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_SUMMON_WILL_O_THE_WISPS",
    name = ccb.content.text("Call Will o' the Wisp"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You can conjure up bobbing lights in the distance that will lead your enemies astray."),
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { changeling_summon_will_o_the_wisps_spell = 1 },
}

-- For now life extenders such as this one grant MEND_ALL.  When the new wound system will be implemented, their function will be to always allow you to fully heal from your wounds (no scars, etc).
ccb.content.define_mutation {
    id = "FAE_IMMORTALITY",
    name = ccb.content.text("Faerie Eternity"),
    points = 8,
    purifiable = false,
    description = ccb.content.text("You seem to have stopped aging.  That would have been an amazing gift before the Cataclysm, but now at least you might live long enough to find some way back to your birthplace Under the Hill."),
    prerequisites = { "DISIMMUNE" },
    secondary_prerequisites = { "PARACLESIAN_STR_DEX_2", "PARACLESIAN_INT_PER_2" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE", "THRESH_FAIR_FOLK_COMMONER_POOKA",
        "THRESH_FAIR_FOLK_COMMONER_SELKIE", "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    flags = { "MEND_ALL" },
}

ccb.content.define_mutation {
    id = "SELKIE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Selkie gains the ability to grow a goblin fruit when near water or under the rain."),
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "BROWNIE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Brownie gains the ability to grow a goblin fruit when indoors and unobserved."),
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    spells_learned = { brownie_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "POOKA_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Pooka gains the ability to grow a goblin fruit when near animals."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    spells_learned = { pooka_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "TROW_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Trow gains the ability to grow a goblin fruit when underground or at night."),
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    spells_learned = { trow_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "NOBLE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Noble gains the ability to grow a goblin fruit when near humans or Fae."),
    categories = { "FAIR_FOLK_NOBLE" },
    spells_learned = { noble_cultivate_goblin_fruit = 1 },
}
