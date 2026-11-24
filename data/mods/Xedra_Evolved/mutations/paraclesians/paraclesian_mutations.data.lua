local ccb = require("ccb")

-- Mutations for this spirit should take it in the direction of, retains water, temperature resistant, slower, tougher, damage resistant, and any spells it receives should alter the earth around it.
ccb.content.define_mutation {
    id = "IERDE",
    name = ccb.content.text("Born of the Earth"),
    mixed_effect = true,
    starting_trait = false,
    valid = false,
    purifiable = false,
    points = 2,
    ignored_by = { "IERDE" },
    cancels = {
        "THIRST", "THIRST2", "THIRST3", "ANTIJUNK", "LACTOSE", "ANTIFRUIT", "MEATARIAN", "ANTIWHEAT",
        "PROJUNK", "CHAOTIC", "CHAOTIC_BAD", "UNSTABLE", "HERBIVORE", "ROBUST", "CARNIVORE",
        "FASTHEALER", "FASTHEALER2", "REGEN", "REGEN_LIZ", "SLOWHEALER", "SLOWHEALER2", "SLOWHEALER3",
        "NOHEAL", "DREAMER", "DREAMSMITH", "EATER", "INVENTOR",
    },
    can_heal_with = { "cthonic_poultice" },
    description = ccb.content.text("A spirit of earth and stone."),
    species_anger = { IERDE = -20, SYLPH = 20 },
    allowed_categories = { "IERDE" },
    vitamin_intervals = { mutagen_human = 1 },
    empathize_with = { "IERDE" },
    no_empathize_with = { "HUMAN" },
    flags = { "HERITAGE", "NO_CBM_INSTALLATION" },
    chargen_allow_npc = false,
    enchantments = {
        "ench_paraclesian_modern_technology_computer_ignorance",
        "ench_paraclesian_modern_technology_electronics_ignorance", "INLINE_ENCH_IERDE_2",
    },
}

-- This spirit should have mutations that involve plants, cold resistant, think what treebeard would be like, and spells that control plants.
ccb.content.define_mutation {
    id = "ARVORE",
    name = ccb.content.text("Root and Branch"),
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    points = 2,
    ignored_by = { "ARVORE" },
    cancels = {
        "THIRST", "THIRST2", "THIRST3", "ANTIJUNK", "LACTOSE", "ANTIFRUIT", "MEATARIAN", "ANTIWHEAT",
        "PROJUNK", "CHAOTIC", "CHAOTIC_BAD", "UNSTABLE", "HERBIVORE", "ROBUST", "CARNIVORE",
        "FASTHEALER", "FASTHEALER2", "REGEN", "REGEN_LIZ", "SLOWHEALER", "SLOWHEALER2", "SLOWHEALER3",
        "NOHEAL", "DREAMER", "DREAMSMITH", "EATER", "INVENTOR",
    },
    can_heal_with = { "verdant_poultice" },
    description = ccb.content.text("A spirit of leaf and bark."),
    species_anger = { ARVORE = -20, HOMULLUS = 20 },
    allowed_categories = { "ARVORE" },
    vitamin_intervals = { mutagen_human = 1 },
    empathize_with = { "ARVORE" },
    no_empathize_with = { "HUMAN" },
    flags = { "TREE_COMMUNION_PLUS", "ARVORE_POLLEN_IMMUNE", "HERITAGE", "NO_CBM_INSTALLATION" },
    chargen_allow_npc = false,
    enchantments = {
        "ench_paraclesian_modern_technology_computer_ignorance",
        "ench_paraclesian_modern_technology_electronics_ignorance", "INLINE_ENCH_ARVORE_2",
        "INLINE_ENCH_ARVORE_3", "INLINE_ENCH_ARVORE_4",
    },
}

-- This spirit should become immune to heat and fire, take double cold damage, slow in the cold, produce heat, regen quickly in warm temperatures, take damage from water and casts fire/heat spells.
ccb.content.define_mutation {
    id = "SALAMANDER",
    name = ccb.content.text("Touched by Fire"),
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    points = 2,
    ignored_by = { "SALAMANDER" },
    cancels = {
        "THIRST", "THIRST2", "THIRST3", "ANTIJUNK", "LACTOSE", "ANTIFRUIT", "MEATARIAN", "ANTIWHEAT",
        "PROJUNK", "CHAOTIC", "CHAOTIC_BAD", "UNSTABLE", "HERBIVORE", "ROBUST", "CARNIVORE",
        "FASTHEALER", "FASTHEALER2", "REGEN", "REGEN_LIZ", "SLOWHEALER", "SLOWHEALER2", "SLOWHEALER3",
        "NOHEAL", "DREAMER", "DREAMSMITH", "EATER", "INVENTOR",
    },
    can_heal_with = { "charred_sacrifice" },
    description = ccb.content.text("A spirit of fire."),
    species_anger = { SALAMANDER = -20, UNDINE = 20 },
    allowed_categories = { "SALAMANDER" },
    vitamin_intervals = { mutagen_human = 1 },
    empathize_with = { "SALAMANDER" },
    no_empathize_with = { "HUMAN" },
    flags = { "HERITAGE", "NO_CBM_INSTALLATION" },
    chargen_allow_npc = false,
    enchantments = {
        "ench_paraclesian_modern_technology_computer_ignorance",
        "ench_paraclesian_modern_technology_electronics_ignorance", "INLINE_ENCH_SALAMANDER_2",
    },
}

-- Spirits of water should slowly gain extreme resistance to cutting, lesser resistance to bash, weak against cold and electricity, see if I can make extra regen in water or regen from wet, extra perspiration and thirst, spells should be water based.
ccb.content.define_mutation {
    id = "UNDINE",
    name = ccb.content.text("Rain and Wave"),
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    points = 2,
    enchantments = {
        "ench_paraclesian_modern_technology_computer_ignorance",
        "ench_paraclesian_modern_technology_electronics_ignorance", "INLINE_ENCH_UNDINE_2",
        "INLINE_ENCH_UNDINE_3",
    },
    ignored_by = { "UNDINE" },
    scent_type = "sc_fae",
    cancels = {
        "THIRST", "THIRST2", "THIRST3", "ANTIJUNK", "LACTOSE", "ANTIFRUIT", "MEATARIAN", "ANTIWHEAT",
        "PROJUNK", "CHAOTIC", "CHAOTIC_BAD", "UNSTABLE", "HERBIVORE", "ROBUST", "CARNIVORE",
        "FASTHEALER", "FASTHEALER2", "REGEN", "REGEN_LIZ", "SLOWHEALER", "SLOWHEALER2", "SLOWHEALER3",
        "NOHEAL", "DREAMER", "DREAMSMITH", "EATER", "INVENTOR",
    },
    can_heal_with = { "cerulean_poultice" },
    description = ccb.content.text("You are born of the deep waters."),
    species_anger = { UNDINE = -20, SALAMANDER = 20 },
    allowed_categories = { "UNDINE" },
    vitamin_intervals = { mutagen_human = 1 },
    empathize_with = { "UNDINE" },
    no_empathize_with = { "HUMAN" },
    flags = { "HERITAGE", "NO_CBM_INSTALLATION" },
    chargen_allow_npc = false,
}

-- Spirits of the image of man should be the most humanlike, can have CBMs, have bonuses to interactions with humans, should eventually be able to hide from ferals and vampires/human predators, should slowly become weirdly neohuman, spells should manipulate living humanesque creatures.
ccb.content.define_mutation {
    id = "HOMULLUS",
    name = ccb.content.text("Child of Dolls"),
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    points = 2,
    ignored_by = { "HOMULLUS" },
    cancels = {
        "THIRST", "THIRST2", "THIRST3", "ANTIJUNK", "LACTOSE", "ANTIFRUIT", "MEATARIAN", "ANTIWHEAT",
        "PROJUNK", "CHAOTIC", "CHAOTIC_BAD", "UNSTABLE", "HERBIVORE", "ROBUST", "CARNIVORE",
        "FASTHEALER", "FASTHEALER2", "REGEN", "REGEN_LIZ", "SLOWHEALER", "SLOWHEALER2", "SLOWHEALER3",
        "NOHEAL", "DREAMER", "DREAMSMITH", "EATER", "INVENTOR",
    },
    can_heal_with = { "doll_repair_paste" },
    vitamin_intervals = { mutagen_human = 1 },
    description = ccb.content.text("A spirit of the image of humans given life."),
    empathize_with = { "HOMULLUS" },
    species_anger = { HOMULLUS = -20, ARVORE = 20 },
    flags = { "HERITAGE" },
    chargen_allow_npc = false,
    enchantments = {
        "ench_paraclesian_homullus_modern_technology_computer_ignorance",
        "ench_paraclesian_homullus_modern_technology_electronics_ignorance", "INLINE_ENCH_HOMULLUS_2",
    },
}

-- Mutations for this spirit should take it in the direction of, freedom of movement, faster, weaker, dodges, and any spells it receives should alter the air around it.
ccb.content.define_mutation {
    id = "SYLPH",
    name = ccb.content.text("Born of the Air"),
    mixed_effect = true,
    valid = false,
    starting_trait = false,
    purifiable = false,
    points = 2,
    ignored_by = { "SYLPH" },
    cancels = {
        "THIRST", "THIRST2", "THIRST3", "ANTIJUNK", "LACTOSE", "ANTIFRUIT", "MEATARIAN", "ANTIWHEAT",
        "PROJUNK", "CHAOTIC", "CHAOTIC_BAD", "UNSTABLE", "HERBIVORE", "ROBUST", "CARNIVORE",
        "FASTHEALER", "FASTHEALER2", "REGEN", "REGEN_LIZ", "SLOWHEALER", "SLOWHEALER2", "SLOWHEALER3",
        "NOHEAL", "DREAMER", "DREAMSMITH", "EATER", "INVENTOR",
    },
    can_heal_with = { "ethereal_draught" },
    description = ccb.content.text("A spirit of air and wind."),
    species_anger = { SYLPH = -20, IERDE = 20 },
    allowed_categories = { "SYLPH" },
    vitamin_intervals = { mutagen_human = 1 },
    empathize_with = { "SYLPH" },
    no_empathize_with = { "HUMAN" },
    flags = { "HERITAGE", "NO_CBM_INSTALLATION" },
    chargen_allow_npc = false,
    enchantments = {
        "ench_paraclesian_modern_technology_computer_ignorance",
        "ench_paraclesian_modern_technology_electronics_ignorance", "INLINE_ENCH_SYLPH_2",
    },
}

ccb.content.define_mutation {
    id = "PARACLESIAN_STR_DEX_1",
    name = ccb.content.text("Fae Prowess"),
    points = 1,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    replacements = { "PARACLESIAN_STR_DEX_2" },
    prerequisites = {
        "ARVORE_SKIN_1", "IERDE_SKIN_1", "HOMULLUS_SKIN_1", "SALAMANDER_SKIN_1", "SYLPH_SKIN_1",
        "UNDINE_SKIN_1", "UNKNOWING_CHANGELING_NOBLE", "UNKNOWING_CHANGELING_COMMONER_BROWNIE",
        "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE",
        "UNKNOWING_CHANGELING_COMMONER_TROW",
    },
    description = ccb.content.text("You have gained a portion of the might of your fae ancestors.  +1 Strength and Dexterity."),
    categories = {
        "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
    enchantments = { "INLINE_ENCH_PARACLESIAN_STR_DEX_1_0" },
}

ccb.content.define_mutation {
    id = "PARACLESIAN_STR_DEX_2",
    name = ccb.content.text("Fae Puissance"),
    points = 1,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "PARACLESIAN_STR_DEX_1" },
    secondary_prerequisites = {
        "ARVORE_SKIN_3", "IERDE_SKIN_3", "HOMULLUS_SKIN_3", "SALAMANDER_SKIN_3", "SYLPH_SKIN_3",
        "UNDINE_SKIN_3", "UNKNOWING_CHANGELING_NOBLE", "UNKNOWING_CHANGELING_COMMONER_BROWNIE",
        "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE",
        "UNKNOWING_CHANGELING_COMMONER_TROW",
    },
    description = ccb.content.text("You have gained the might of your fae ancestors.  +2 Strength and Dexterity."),
    categories = {
        "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_ARVORE", "THRESH_IERDE", "THRESH_HOMULLUS", "THRESH_SALAMANDER", "THRESH_SYLPH",
        "THRESH_UNDINE", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE",
        "THRESH_FAIR_FOLK_COMMONER_POOKA", "THRESH_FAIR_FOLK_COMMONER_SELKIE",
        "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    enchantments = { "INLINE_ENCH_PARACLESIAN_STR_DEX_2_0" },
}

ccb.content.define_mutation {
    id = "PARACLESIAN_INT_PER_1",
    name = ccb.content.text("Fae Discernment"),
    points = 1,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    replacements = { "PARACLESIAN_INT_PER_2" },
    prerequisites = {
        "ARVORE_SKIN_1", "IERDE_SKIN_1", "HOMULLUS_SKIN_1", "SALAMANDER_SKIN_1", "SYLPH_SKIN_1",
        "UNDINE_SKIN_1", "UNKNOWING_CHANGELING_NOBLE", "UNKNOWING_CHANGELING_COMMONER_BROWNIE",
        "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE",
        "UNKNOWING_CHANGELING_COMMONER_TROW",
    },
    description = ccb.content.text("You have gained a portion of the wits of your fae ancestors.  +1 Intelligence and Perception."),
    categories = {
        "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
    enchantments = { "INLINE_ENCH_PARACLESIAN_INT_PER_1_0" },
}

ccb.content.define_mutation {
    id = "PARACLESIAN_INT_PER_2",
    name = ccb.content.text("Fae Acumen"),
    points = 1,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "PARACLESIAN_INT_PER_1" },
    secondary_prerequisites = {
        "ARVORE_SKIN_3", "IERDE_SKIN_3", "HOMULLUS_SKIN_3", "SALAMANDER_SKIN_3", "SYLPH_SKIN_3",
        "UNDINE_SKIN_3", "UNKNOWING_CHANGELING_NOBLE", "UNKNOWING_CHANGELING_COMMONER_BROWNIE",
        "UNKNOWING_CHANGELING_COMMONER_POOKA", "UNKNOWING_CHANGELING_COMMONER_SELKIE",
        "UNKNOWING_CHANGELING_COMMONER_TROW",
    },
    description = ccb.content.text("You have gained the wits of your fae ancestors.  +2 Intelligence and Perception."),
    categories = {
        "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_ARVORE", "THRESH_IERDE", "THRESH_HOMULLUS", "THRESH_SALAMANDER", "THRESH_SYLPH",
        "THRESH_UNDINE", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE",
        "THRESH_FAIR_FOLK_COMMONER_POOKA", "THRESH_FAIR_FOLK_COMMONER_SELKIE",
        "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    enchantments = { "INLINE_ENCH_PARACLESIAN_INT_PER_2_0" },
}

ccb.content.define_mutation {
    id = "PARACLESIAN_FAE_SIGHT_1",
    name = ccb.content.text("Fae Sight"),
    points = 1,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    replacements = { "PARACLESIAN_FAE_SIGHT_2" },
    prerequisites = {
        "ARVORE_EYES",
        "HOMULLUS_EYES",
        "IERDE_EYES",
        "SALAMANDER_EYES",
        "SYLPH_EYES",
        "UNDINE_EYES",
        "UNKNOWING_CHANGELING_NOBLE",
        "UNKNOWING_CHANGELING_COMMONER_BROWNIE",
        "UNKNOWING_CHANGELING_COMMONER_POOKA",
        "UNKNOWING_CHANGELING_COMMONER_SELKIE",
        "UNKNOWING_CHANGELING_COMMONER_TROW",
    },
    description = ccb.content.text("You can sense other nearby creatures from the Bright Lands.  Activate to enable your fae senses.  It has a small chance to cost some of your mana each turn it is in use."),
    categories = {
        "ARVORE",
        "ARVORE_ALCHEMY",
        "IERDE",
        "HOMULLUS",
        "SALAMANDER",
        "SYLPH",
        "UNDINE",
        "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE",
        "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
    activation_setup_only = true,
    active = true,
    on_activate = "paraclesian_fae_sight_on",
    on_process = "paraclesian_fae_sight_process",
    on_deactivate = "paraclesian_fae_sight_off",
}

ccb.content.define_mutation {
    id = "PARACLESIAN_FAE_SIGHT_2",
    name = ccb.content.text("Wyrd Sight"),
    points = 1,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "PARACLESIAN_FAE_SIGHT_1" },
    description = ccb.content.text("You can sense other nearby creatures from the Bright Lands.  Activate to enable your fae senses."),
    categories = {
        "ARVORE", "IERDE", "HOMULLUS", "SALAMANDER", "SYLPH", "UNDINE", "FAIR_FOLK_NOBLE",
        "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_SELKIE",
        "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_ARVORE", "THRESH_IERDE", "THRESH_HOMULLUS", "THRESH_SALAMANDER", "THRESH_SYLPH",
        "THRESH_UNDINE", "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE",
        "THRESH_FAIR_FOLK_COMMONER_POOKA", "THRESH_FAIR_FOLK_COMMONER_SELKIE",
        "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    activation_setup_only = true,
    active = true,
    on_activate = "enable_form_effect",
    on_deactivate = "disable_form_effect",
}

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
