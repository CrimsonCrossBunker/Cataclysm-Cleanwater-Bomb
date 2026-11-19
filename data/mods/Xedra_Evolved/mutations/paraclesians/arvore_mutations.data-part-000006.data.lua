local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_WOOD_CLAWS_active",
    name = ccb.content.text_without_extraction("Jagged Wooden Claws Extended"),
    points = 2,
    visibility = 3,
    ugliness = 2,
    description = ccb.content.text_without_extraction("Your hands are transformed into jagged wooden claws.  You can use them to attack, but performing mundane tasks will be harder."),
    categories = { "ARVORE" },
    purifiable = false,
    cost = 0,
    player_display = false,
    valid = false,
    integrated_armor = { "integrated_arvore_claws" },
    enchantments = { "INLINE_ENCH_ARVORE_WOOD_CLAWS_active_0" },
}

ccb.content.define_mutation {
    id = "ARVORE_RESIST_CHILL",
    name = ccb.content.text("Resist Winter's Chill"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    replacements = { "ARVORE_IGNORE_WINTER_CHILL" },
    description = ccb.content.text("Plants lose their leaves in winter, but that does not kill them, they simply sleep until the spring comes.  The cold bothers you less now."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    types = { "ACCLIMATIZATION" },
    enchantments = { "arvore_resist_chill" },
}

ccb.content.define_mutation {
    id = "ARVORE_IGNORE_WINTER_CHILL",
    name = ccb.content.text("Ignore Winter's Chill"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_RESIST_CHILL" },
    description = ccb.content.text("Pine trees keep their leaves even in the coldest winter.  The cold bothers you now not at all."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    types = { "ACCLIMATIZATION" },
    enchantments = { "arvore_ignore_chill" },
}

ccb.content.define_mutation {
    id = "ARVORE_KNOW_TIME",
    name = ccb.content.text("Sensing the Sun"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("By the places of the sun and the moon, you can always tell exactly what time it is, as long as you're not underground."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    enchantments = { "ench_arvore_sense_sun" },
}

ccb.content.define_mutation {
    id = "ARVORE_SURVIVAL_BONUS",
    name = ccb.content.text("Among the Wilds"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "GREENSTRIDE", "GREENSTRIDE_UPGRADE" },
    secondary_prerequisites = {
        "ARVORE_SUN_NUTRIENTS", "ARVORE_SUN_NUTRIENTS_AND_MANA", "ARVORE_SUN_MANA_BONUS",
        "ARVORE_SUN_POWER_MANA_STATS",
    },
    description = ccb.content.text("The wilderness welcomes you as one of its own, and you have an easier time surviving there and making things from its bounty.  +1.5 Survival skill."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    craft_skill_bonuses = { survival = 6 },
}

ccb.content.define_mutation {
    id = "ARVORE_DEX_BONUS",
    name = ccb.content.text("Supple As a Reed"),
    points = 2,
    visibility = 3,
    ugliness = 1,
    prerequisites = { "GREENSTRIDE" },
    secondary_prerequisites = { "WIND_BLOWS_WILLOW_BENDS_ARVORE" },
    description = ccb.content.text("Like green wood, you can bend your limbs easily.  You gain a +4 bonus to Dexterity."),
    categories = { "ARVORE" },
    purifiable = false,
    types = { "DEX" },
    enchantments = { "INLINE_ENCH_ARVORE_DEX_BONUS_0" },
}

ccb.content.define_mutation {
    id = "ARVORE_STR_BONUS_1",
    name = ccb.content.text("Might of the Seedling"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    replacements = { "ARVORE_STR_BONUS_2" },
    description = ccb.content.text("Like the seedling poking through the soil, you have great strength hidden within you.  +1 Strength."),
    categories = { "ARVORE" },
    purifiable = false,
    types = { "STR" },
    enchantments = { "INLINE_ENCH_ARVORE_STR_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "ARVORE_STR_BONUS_2",
    name = ccb.content.text("Might of the Sapling"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_STR_BONUS_1" },
    secondary_prerequisites = { "ARVORE_SKIN_1", "ARVORE_SKIN_2", "ARVORE_SKIN_3" },
    replacements = { "ARVORE_STR_BONUS_3" },
    description = ccb.content.text("Like the young tree reaching for the sun, your limbs are filled with power.  +3 Strength."),
    categories = { "ARVORE" },
    purifiable = false,
    types = { "STR" },
    enchantments = { "INLINE_ENCH_ARVORE_STR_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "ARVORE_STR_BONUS_3",
    name = ccb.content.text("Might of the Ancient Tree"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_STR_BONUS_2" },
    secondary_prerequisites = { "ARVORE_SKIN_2", "ARVORE_SKIN_3" },
    description = ccb.content.text("Like forest giants that have stood for a hundred years, you are unshakeable.  +5 Strength."),
    categories = { "ARVORE" },
    purifiable = false,
    types = { "STR" },
    enchantments = { "INLINE_ENCH_ARVORE_STR_BONUS_3_0", "INLINE_ENCH_ARVORE_STR_BONUS_3_1" },
}

ccb.content.define_mutation {
    id = "ARVORE_PER_BONUS",
    name = ccb.content.text("Insight of the Grove"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("When one tree in a grove is attacked by insects, soon all trees will produce the deterrent.  +3 Perception."),
    prerequisites = { "ARVORE_COMMUNE_WITH_NATURE" },
    secondary_prerequisites = { "ARVORE_FOREST_DETECT", "ARVORE_FOREST_DETECT_AND_OVERMAP" },
    categories = { "ARVORE" },
    purifiable = false,
    types = { "PER" },
    enchantments = { "INLINE_ENCH_ARVORE_PER_BONUS_0" },
}

-- Ideally there'd be some way to detect what sort of terrain was nearby and you'd need a critical mass of foliage, but the below will work for now.
ccb.content.define_mutation {
    id = "ARVORE_FOREST_STEALTH",
    name = ccb.content.text("Shadow of the Trees"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The forest recognizes your kinship and will hide you beneath its boughs.  When in a forest or in thick foliage, enemies will have a harder time spotting you."),
    categories = { "ARVORE" },
    purifiable = false,
    enchantments = { "ench_arvore_forest_stealth" },
}

ccb.content.define_mutation {
    id = "ARVORE_EYES",
    name = ccb.content.text("Arvore Eyes"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Arvore's eyes begin reflecting the seasons: a bright yellow-green in spring; verdant green in summer; red, yellow, or orange in autumn, and dark brown in winter.  Glare no longer impacts them, and they have slightly better daytime vision and reaction times."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    types = { "EYES" },
    enchantments = { "INLINE_ENCH_ARVORE_EYES_0" },
}

ccb.content.define_mutation {
    id = "ARVORE_EARS",
    name = ccb.content.text("Arvore Ears"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("The Arvore's ears are longer and pointed, more \"leaf-shaped.\"  While they cannot hear any better, like the trees in the deep forest, they are unphased by loud sounds."),
    categories = { "ARVORE" },
    purifiable = false,
    types = { "EARS" },
    flags = { "IMMUNE_HEARING_DAMAGE" },
}

-- Visibility here because the Arvore's skin flushes a different color when the blood isn't red.
ccb.content.define_mutation {
    id = "ARVORE_BLOOD",
    name = ccb.content.text("Vegetal Blood"),
    points = 1,
    visibility = 1,
    ugliness = 0,
    description = ccb.content.text("The Arvore's blood is now composed of sap and vegetable matter.  This does not benefit or harm them in any ways, but humans will be discomfited by it."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    flags = { "PLANTBLOOD" },
}

ccb.content.define_mutation {
    id = "ARVORE_BLOOD_2",
    name = ccb.content.text("Sap Seals the Wound"),
    points = 7,
    visibility = 2,
    ugliness = 1,
    description = ccb.content.text("The Arvore's blood is a sticky sap that oozes rather than gushes from their wounds.  They will bleed more slowly than normal."),
    prerequisites = { "ARVORE_BLOOD" },
    replacements = { "ARVORE_BLOOD_3" },
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    types = { "BLOOD" },
    enchantments = { "INLINE_ENCH_ARVORE_BLOOD_2_0" },
}

ccb.content.define_mutation {
    id = "ARVORE_BLOOD_3",
    name = ccb.content.text("Sap Defends the Trunk"),
    points = 10,
    visibility = 2,
    ugliness = 1,
    description = ccb.content.text("The Arvore's blood is a sticky sap that oozes rather than gushes from their wounds and has potent defensive properties.  They will bleed more slowly than normal and are immune to parasites and infection."),
    prerequisites = { "ARVORE_BLOOD_2" },
    replacements = { "ARVORE_BLOOD_4" },
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    types = { "BLOOD" },
    enchantments = { "INLINE_ENCH_ARVORE_BLOOD_3_0" },
    flags = { "PARAIMMUNE", "INFECTION_IMMUNE" },
}

ccb.content.define_mutation {
    id = "ARVORE_BLOOD_4",
    name = ccb.content.text("Sap Maintains the Heartwood"),
    points = 13,
    visibility = 2,
    ugliness = 1,
    description = ccb.content.text("The Arvore's blood is a sticky sap that oozes rather than gushes from their wounds and aggressively fights back against invading organisms.  They will bleed much more slowly than normal, are immune to parasites and infection, and cannot be transformed by the Mycus."),
    prerequisites = { "ARVORE_BLOOD_3" },
    secondary_prerequisites = { "ARVORE_ANTI_PLANT_SPELL" },
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    types = { "BLOOD" },
    enchantments = { "INLINE_ENCH_ARVORE_BLOOD_4_0" },
    flags = { "PARAIMMUNE", "INFECTION_IMMUNE", "MYCUS_IMMUNE" },
}
