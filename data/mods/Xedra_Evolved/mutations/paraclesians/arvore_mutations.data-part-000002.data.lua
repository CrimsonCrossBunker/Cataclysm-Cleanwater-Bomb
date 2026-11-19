local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ARVORE_SUMMON_WOOD_WALL",
    name = ccb.content.text("The Forest Offers Shelter"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Arvore may create structures of living wood on natural terrain."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    prerequisites = { "ARVORE_NURTURING_THE_GREEN" },
    spells_learned = { arvore_growing_wood_walls = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_COMMUNE_WITH_NATURE",
    name = ccb.content.text("Commune with Nature"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to draw on the peace and strength of nature while standing in a wild area."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_commune_with_nature = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_SUMMON_BRIARS",
    name = ccb.content.text("Briarwall"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to summon thick tangles of briars to form walls or entrap their enemies."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_summon_briars = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_FOREST_TELEPORT",
    name = ccb.content.text("Traverse the Wilds"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to transport themselves from tree to nearby tree while within a forest."),
    prerequisites = { "GREENSTRIDE_UPGRADE", "FALSE_ARVORE_HATRED", "FAE_ENMITY" },
    secondary_prerequisites = { "ARVORE_FOREST_STEALTH", "FALSE_ARVORE_HATRED", "FAE_ENMITY" },
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_traverse_the_wilds = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_CAUSE_DECAY",
    name = ccb.content.text("Fallen Trees Decay to Soil"),
    points = 8,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to induce decay and dissolution in the surrounding area."),
    prerequisites = { "ARVORE_VERDANT_INFUSION" },
    secondary_prerequisites = { "ARVORE_TURN_INTO_TREE" },
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    spells_learned = { arvore_cause_decay = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_SUMMON_WOOD_SPIRIT",
    name = ccb.content.text("Call the Children of the Roots"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to summon a wood spirit."),
    categories = { "ARVORE" },
    purifiable = false,
    spells_learned = { arvore_summon_wood_spirit = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_TERRAIN_BASH_SPELL",
    name = ccb.content.text("Roots Crack the Foundation"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_SUMMON_GRASS_FIELD" },
    additions = { "ARVORE_ANTI_PLANT_SPELL" },
    description = ccb.content.text("Upon gaining this ability, the Arvore gains the ability to summon semitangible roots that will shatter walls and furniture."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_roots_crack_the_foundation = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_FOREST_TRANSLOCATION",
    name = ccb.content.text("From Root to Root the Forest Is Joined"),
    points = 9,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_FOREST_TELEPORT" },
    description = ccb.content.text("Upon gaining this ability, the Arvore gains the ability to travel great distances, even dozens of miles, in moments, as long as they start and end their journey within the depths of a forest."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    spells_learned = { arvore_forest_translocate = 1, arvore_forest_translocate_attune = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_TURN_INTO_TREE",
    name = ccb.content.text("Overgrowth"),
    points = 9,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_SUMMON_BRIARS" },
    secondary_prerequisites = { "ARVORE_SUMMON_WOOD_WALL" },
    description = ccb.content.text("Upon gaining this ability, the Arvore gains the ability to cause rapid plant growth in a radius around themselves."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    spells_learned = { arvore_overgrowth_spell = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_PERENNIAL_REBIRTH",
    name = ccb.content.text("Perennial Rebirth"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_SUN_NUTRIENTS_AND_MANA", "ARVORE_SUN_MANA_BONUS", "ARVORE_SUN_POWER_MANA_STATS" },
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to bind their soul to the heart of the forest, rebirthing themselves when on the verge of death."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
    spells_learned = { arvore_perennial_rebirth_spell = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_PERENNIAL_REBIRTH_CASTED",
    name = ccb.content.text("Perennial Rebirth (bound)"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    valid = false,
    description = ccb.content.text("You have bound your soul to the forest, and death will merely be a momentary inconvenience."),
    categories = { "ARVORE" },
    purifiable = false,
    threshold_requirements = { "THRESH_ARVORE" },
}

ccb.content.define_mutation {
    id = "ARVORE_VERDANT_INFUSION",
    name = ccb.content.text("Verdant Infusion"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_COMMUNE_WITH_NATURE" },
    secondary_prerequisites = {
        "ARVORE_SUN_NUTRIENTS", "ARVORE_SUN_NUTRIENTS_AND_MANA", "ARVORE_SUN_MANA_BONUS",
        "ARVORE_SUN_POWER_MANA_STATS",
    },
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to infuse their companions with the vitality of the forest."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_verdant_infusion = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_SUMMON_GRASS_FIELD",
    name = ccb.content.text("Commanding the Grasses"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    additions = { "ARVORE_TERRAIN_BASH_SPELL" },
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to cause grass to rapidly grow on fertile terrain, slowing their enemies."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_summon_grass_field_spell = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_CLIMBING_VINE_SPELL",
    name = ccb.content.text("Creeper Ascends the Wall"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_NURTURING_THE_GREEN" },
    secondary_prerequisites = { "ARVORE_SUMMON_GRASS_FIELD" },
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to summon a thick climbing vine from diggable ground."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_climbing_vine_spell = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_ANTI_PLANT_SPELL",
    name = ccb.content.text("Tending the Garden"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_TERRAIN_BASH_SPELL" },
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to damage plant and fungal entities, including others of their own kind."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    spells_learned = { arvore_anti_plant_spell = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_COMMUNE_WITH_NATURE" },
    description = ccb.content.text("Upon gaining this ability the Arvore gains the ability to grow a goblin fruit when in natural areas away from civilization."),
    categories = { "ARVORE" },
    purifiable = false,
    spells_learned = { arvore_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "ARVORE_FOREST_MAPPING",
    name = ccb.content.text("Commune with the Ancient Oaks"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = {
        "ARVORE_FOREST_DETECT",
        "ARVORE_FOREST_DETECT_AND_OVERMAP",
        "FALSE_ARVORE_HATRED",
        "FAE_ENMITY",
    },
    description = ccb.content.text("The Arvore are closely tied with the forests and may commune with the trees to learn the layout of the land.  Activate this ability to enter the communion."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    active = true,
    cost = 0,
}

ccb.content.define_mutation {
    id = "ARVORE_WOOD_WEAPON_DAMAGE",
    name = ccb.content.text("Bramble's Bite"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ARVORE_NURTURING_THE_GREEN", "ARVORE_SUMMON_BRIARS" },
    secondary_prerequisites = { "JAUNDICE_ARVORE_ALCHEMY", "ARVORE_SKIN_1", "ARVORE_SKIN_2", "ARVORE_SKIN_3" },
    description = ccb.content.text("Drawing out the power inherent in growing wood makes weapons composed of it more deadly in your hands.  You do increased damage when wielding a weapon primarily made of wood."),
    categories = { "ARVORE", "ARVORE_ALCHEMY" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_ARVORE_WOOD_WEAPON_DAMAGE_0" },
}
