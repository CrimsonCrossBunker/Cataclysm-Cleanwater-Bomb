local ccb = require("ccb")

ccb.content.define_mutation {
    id = "CLOUD_OF_STEAM_SYLPH",
    name = ccb.content.text("Cloud of Steam"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to create a cloud of damaging steam."),
    categories = { "SYLPH" },
    spells_learned = { cloud_of_steam_sylph = 1 },
}

ccb.content.define_mutation {
    id = "CLOUD_OF_STEAM_UNDINE",
    name = ccb.content.text("Cloud of Steam"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine gains the ability to create a cloud of damaging steam."),
    categories = { "UNDINE" },
    spells_learned = { cloud_of_steam_undine = 1 },
}

ccb.content.define_mutation {
    id = "CREATE_LIGHT_SYLPH",
    name = ccb.content.text("Create Light"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to create light."),
    categories = { "SYLPH" },
    spells_learned = { create_light_sylph = 1 },
}

ccb.content.define_mutation {
    id = "CREATE_LIGHT",
    name = ccb.content.text("Create Light"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to create light."),
    categories = { "SALAMANDER" },
    spells_learned = { create_light_salamander = 1 },
}

ccb.content.define_mutation {
    id = "ELEMENTAL_MANA1",
    name = ccb.content.text("Born of the Elements"),
    points = 1,
    purifiable = false,
    description = ccb.content.text("Your connection to this world is deep and rewards you with additional mana."),
    replacements = { "ELEMENTAL_MANA2" },
    types = { "MANA_ADD" },
    categories = { "UNDINE", "SALAMANDER", "ARVORE", "IERDE", "HOMULLUS", "SYLPH" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_ELEMENTAL_MANA1_0" },
}

ccb.content.define_mutation {
    id = "ELEMENTAL_MANA2",
    name = ccb.content.text("Change with the Seasons"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You are able to store more mana in your body than usual."),
    replacements = { "ELEMENTAL_MANA3" },
    types = { "MANA_ADD" },
    categories = { "UNDINE", "SALAMANDER", "ARVORE", "IERDE", "HOMULLUS", "SYLPH" },
    prerequisites = { "ELEMENTAL_MANA1" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_ELEMENTAL_MANA2_0" },
}

ccb.content.define_mutation {
    id = "ELEMENTAL_MANA3",
    name = ccb.content.text("Walking Ley Line"),
    points = 8,
    purifiable = false,
    description = ccb.content.text("You are able to store a lot more mana in your body than usual."),
    types = { "MANA_ADD" },
    categories = { "UNDINE", "SALAMANDER", "ARVORE", "IERDE", "HOMULLUS", "SYLPH" },
    prerequisites = { "ELEMENTAL_MANA2" },
    flags = { "NON_THRESH" },
    enchantments = { "INLINE_ENCH_ELEMENTAL_MANA3_0" },
}

ccb.content.define_mutation {
    id = "WIND_BLOWS_WILLOW_BENDS_ARVORE",
    name = ccb.content.text("The Wind Blows, the Willow Bends"),
    points = 4,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability, you gain the ability to enhance your dodge capabilities."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    additions = { "ARVORE_DEX_BONUS" },
    spells_learned = { paraclesian_spell_dodge_bonus_arvore = 1 },
}

ccb.content.define_mutation {
    id = "WIND_BLOWS_WILLOW_BENDS_SYLPH",
    name = ccb.content.text("The Wind Blows, the Willow Bends"),
    points = 4,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability, you gain the ability to enhance your dodge capabilities."),
    categories = { "SYLPH" },
    spells_learned = { paraclesian_spell_dodge_bonus_sylph = 1 },
}

ccb.content.define_mutation {
    id = "PARACLESIAN_LEARN_GOSSAMER_RECIPES",
    name = ccb.content.text("Gossamer Artisan"),
    points = 4,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like your fae ancestors, you can turn gossamer into clothing and armor.  Activate this trait to learn a gossamer recipe (once per week)."),
    categories = {
        "UNDINE", "SALAMANDER", "ARVORE", "IERDE", "HOMULLUS", "SYLPH", "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
}

ccb.content.define_mutation {
    id = "PARACLESIAN_MAKE_GOSSAMER",
    name = ccb.content.text("Gossamerwright"),
    points = 6,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Your manipulation of gossamer has advanced to the point where you can make it yourself out of mundane cotton and moonlight."),
    prerequisites = { "PARACLESIAN_LEARN_GOSSAMER_RECIPES" },
    categories = {
        "UNDINE", "SALAMANDER", "ARVORE", "IERDE", "HOMULLUS", "SYLPH", "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_UNDINE", "THRESH_SALAMANDER", "THRESH_ARVORE", "THRESH_IERDE", "THRESH_HOMULLUS",
        "THRESH_SYLPH", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE",
        "THRESH_FAIR_FOLK_COMMONER_POOKA", "THRESH_FAIR_FOLK_COMMONER_SELKIE",
        "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { paraclesian_spell_make_gossamer = 1 },
}

ccb.content.define_mutation {
    id = "ANIMALEMPATH",
    copy_from = "ANIMALEMPATH",
    add = {
        categories = {
            "UNDINE", "ARVORE", "IERDE", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE",
            "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
        },
    },
}

ccb.content.define_mutation {
    id = "ANIMALEMPATH2",
    copy_from = "ANIMALEMPATH2",
    add = {
        categories = {
            "UNDINE", "ARVORE", "IERDE", "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE",
            "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
        },
    },
}

ccb.content.define_mutation {
    id = "HOMULLUS_WISHES_TO_CONVERSE",
    name = ccb.content.text("Desire for Conversation"),
    points = 0,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Dollkin casts this spell to force a conversation with anyone, once.  If they've heard the Dollkin out and decided they wish not to speak again it will not work."),
    categories = { "HOMULLUS" },
    active = true,
    starts_active = true,
    spells_learned = { homullus_spell_wish_to_converse = 1 },
}

ccb.content.define_mutation {
    id = "FINAL_DISCUSSION",
    name = ccb.content.text_without_extraction("FINAL DISCUSSION"),
    points = 0,
    player_display = false,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text_without_extraction("This person won't speak with them again if this goes poorly."),
}
