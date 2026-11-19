local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_STOMP_GROUND_SMASH",
    name = ccb.content.text("Earthquake Stomp"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to stomp on the ground and cause a minor local earthquake."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_NO_KNOCKBACK" },
    secondary_prerequisites = { "IERDE_SMASHING_PUNCH" },
    spells_learned = { ierde_stomp_ground_smash_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_KNOCKBACK_PUNCH",
    name = ccb.content.text("Mountain-Toppling Punch"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to strike an enemy with a blow that does extra damage and knocks them backwards."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SMASHING_PUNCH" },
    spells_learned = { ierde_knockback_punch_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_REVEAL_EARTH_MAP",
    name = ccb.content.text("Knowing Every Furrow"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to learn the terrain layout in a large area around themselves."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_PER_BONUS" },
    spells_learned = { ierde_reveal_earth_map_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_CREATE_PITS",
    name = ccb.content.text("Earthen Grasp"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to create large pits on diggable ground, dumping their enemies into them."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_RESHAPE_THE_EARTH" },
    spells_learned = { ierde_create_pits_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_SLOW_ENEMIES",
    name = ccb.content.text("Rigidity of Stone"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde may infuse the rigidity of stone into their enemies, slowing their movements."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_RESHAPE_THE_EARTH" },
    spells_learned = { ierde_slow_enemies_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_RESHAPE_THE_EARTH",
    name = ccb.content.text("Reshape the Living Earth"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde may reshape the earth, raising or lowering earth or stone or turning the one into the other."),
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_reshape_the_earth_spell = 1 },
}

-- Eventually add further spells in this area with more powerful elementals.
ccb.content.define_mutation {
    id = "IERDE_SUMMON_EARTH_ELEMENTAL",
    name = ccb.content.text("Calling the Children of the Stones"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Allows the Ierde to summon a minor earth elemental to support them in the world for a short time."),
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_summon_earth_spirit = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_IRON_ARMOR",
    name = ccb.content.text("Invulnerable Iron Skin"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Stone endures but armor is made of metal.  While standing on natural earth or stone, the Ierde can infuse their skin with metal, slowing their movement and encumbering them but rendering them much harder to damage."),
    prerequisites = { "IERDE_SKIN_2", "IERDE_SKIN_3" },
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_iron_armor_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_EARTH_SHIELD",
    name = ccb.content.text("Impenetrable Earthen Shield"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("While standing on natural earth or stone, the Ierde can summon up an earthen shield to protect themselves.  They will be invulnerable until the shield breaks."),
    prerequisites = { "IERDE_IRON_ARMOR" },
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_earthen_shield_spell = 1 },
}

ccb.content.define_mutation {
    id = "IERDE_BUFF_ARMOR_ALLIES",
    name = ccb.content.text("Skin of the Mountains"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("When gaining this ability, the Ierde gains the ability to infuse the resilience of the earth into one of their allies."),
    prerequisites = { "IERDE_IRON_ARMOR" },
    secondary_prerequisites = { "IERDE_STRONG_EQUIPMENT" },
    categories = { "IERDE" },
    purifiable = false,
    spells_learned = { ierde_buff_armor_allies_spell = 1 },
}

-- The name is a reference to Chapter 63 of Bleak House by Charles Dickens
ccb.content.define_mutation {
    id = "IERDE_NO_SCENT_AND_IRON",
    name = ccb.content.text("An Iron Taste and an Iron Smell"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Ierde has taken the essence of iron into themselves.  They no longer smell anything like a human, smelling only like a faint whiff of iron if they have any scent at all, and can produce all their iron their body needs themselves."),
    prerequisites = { "IERDE_IRON_ARMOR" },
    categories = { "IERDE" },
    purifiable = false,
    vitamin_intervals = { iron = -1200 },
    flags = { "NO_SCENT" },
}

ccb.content.define_mutation {
    id = "IERDE_CARDIO",
    name = ccb.content.text("Tireless Strength of the Earth"),
    points = 2,
    description = ccb.content.text("The Ierde can draw on the boundless strength of the earth, increasing their stamina."),
    replacements = { "IERDE_CARDIO2" },
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_1", "IERDE_SKIN_2", "IERDE_SKIN_3" },
    enchantments = { "INLINE_ENCH_IERDE_CARDIO_0" },
}

ccb.content.define_mutation {
    id = "IERDE_CARDIO2",
    name = ccb.content.text("Unceasing Strength of the Earth"),
    points = 5,
    description = ccb.content.text("The Ierde can draw even deeper on the boundless strength of the earth, greatly increasing their stamina."),
    replacements = { "IERDE_CARDIO3" },
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_SKIN_2", "IERDE_SKIN_3" },
    enchantments = { "INLINE_ENCH_IERDE_CARDIO2_0" },
}

ccb.content.define_mutation {
    id = "IERDE_CARDIO3",
    name = ccb.content.text("Inexhaustible Strength of the Earth"),
    points = 8,
    description = ccb.content.text("The Ierde can draw from boundless strength of the very depths of the earth, enormously increasing their stamina."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_SKIN_3" },
    enchantments = { "INLINE_ENCH_IERDE_CARDIO3_0" },
}

ccb.content.define_mutation {
    id = "IERDE_REGAIN_STAMINA_UNDERGROUND",
    name = ccb.content.text("Stone Does Not Grow Weary"),
    points = 5,
    description = ccb.content.text("When underground or on natural earth, the Ierde recovers Stamina 50% faster."),
    categories = { "IERDE" },
    purifiable = false,
    replacements = { "IERDE_HEAL_FASTER_UNDERGROUND" },
    prerequisites = { "IERDE_CARDIO2", "IERDE_CARDIO3" },
    enchantments = { "INLINE_ENCH_IERDE_REGAIN_STAMINA_UNDERGROUND_0" },
}

ccb.content.define_mutation {
    id = "IERDE_HEAL_FASTER_UNDERGROUND",
    name = ccb.content.text("The Stone Endures"),
    points = 7,
    description = ccb.content.text("When underground or on natural earth, the Ierde recovers Stamina 50% faster and heals 33% faster."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_CARDIO2", "IERDE_CARDIO3" },
    secondary_prerequisites = { "IERDE_REGAIN_STAMINA_UNDERGROUND" },
    enchantments = { "INLINE_ENCH_IERDE_HEAL_FASTER_UNDERGROUND_0" },
}

ccb.content.define_mutation {
    id = "IERDE_FEEL_HALF_PAIN",
    name = ccb.content.text("Stone Does Not Cry Out"),
    points = 5,
    description = ccb.content.text("Like the stone, the Ierde suffers little from blows.  All pain is halved."),
    categories = { "IERDE" },
    purifiable = false,
    prerequisites = { "IERDE_REGAIN_STAMINA_UNDERGROUND", "IERDE_HEAL_FASTER_UNDERGROUND" },
    enchantments = { "INLINE_ENCH_IERDE_FEEL_HALF_PAIN_0" },
}
