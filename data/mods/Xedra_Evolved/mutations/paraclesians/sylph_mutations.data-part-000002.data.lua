local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SLYPH_RESIST_COLD",
    name = ccb.content.text("Resist Cold"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Sylph gains a resistance to cold and cold based damage."),
    replacements = { "SLYPH_RESIST_COLD2" },
    enchantments = { "INLINE_ENCH_SLYPH_RESIST_COLD_0" },
    categories = { "SYLPH" },
}

ccb.content.define_mutation {
    id = "SLYPH_RESIST_COLD2",
    name = ccb.content.text("Born of a Gale"),
    points = 6,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Sylph gains a resistance to cold and cold based damage."),
    replacements = { "SLYPH_RESIST_COLD3" },
    enchantments = { "INLINE_ENCH_SLYPH_RESIST_COLD2_0" },
    categories = { "SYLPH" },
}

ccb.content.define_mutation {
    id = "SLYPH_RESIST_COLD3",
    name = ccb.content.text("Dancing On Winter Winds"),
    points = 9,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SLYPH_RESIST_COLD2" },
    description = ccb.content.text("The sylph is nearly immune to mundane cold and heavily resistant to cold-based damage."),
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    enchantments = { "INLINE_ENCH_SLYPH_RESIST_COLD3_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_BONUS_RANGE",
    name = ccb.content.text("Wind-Carried Weapons"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The winds surge around the Sylph as they attack, guiding their projectiles to the target.  The range of the Sylph's weapons is increased."),
    prerequisites = { "SYLPH_SPEED_INCREASE", "SYLPH_SPEED_INCREASE2" },
    enchantments = { "sylph_wind_weapons" },
    categories = { "SYLPH" },
}

ccb.content.define_mutation {
    id = "SYLPH_SPEED_INCREASE",
    name = ccb.content.text("Winds Guide Me"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("When outdoors, the Sylph moves 10% faster."),
    replacements = { "SYLPH_SPEED_INCREASE2" },
    prerequisites = { "PUSHING_WIND" },
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_SPEED_INCREASE_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_SPEED_INCREASE2",
    name = ccb.content.text("Outrunning the Gale"),
    points = 8,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("When outdoors, the Sylph moves 10% faster and has +10% increased speed."),
    prerequisites = { "SYLPH_SPEED_INCREASE" },
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_SPEED_INCREASE2_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_EXTRA_DODGE_INCREASE",
    name = ccb.content.text("Gusting Evasion"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Sylph slips away from attacks as easily as the wind finds its way through cracks in a wall.  They gain +1 bonus dodge attempt per turn (+2 if they have the Sylph trait)."),
    prerequisites = { "SYLPH_SPEED_INCREASE", "SYLPH_SPEED_INCREASE2" },
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "sylph_extra_dodges" },
}

ccb.content.define_mutation {
    id = "SYLPH_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "PUSHING_WIND" },
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to grow a goblin fruit when outdoors and the wind is blowing strongly."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "PUSHING_WIND",
    name = ccb.content.text("Pushing Wind"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Sylph learns how to use the wind to push their opponents."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { pushing_wind = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_HINDERING_WINDS",
    name = ccb.content.text("Hindering Winds"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Sylph learns how to surround a single target with buffeting winds, slowing their movements and knocking them off-balance."),
    prerequisites = { "PUSHING_WIND" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_hindering_wind_spell = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_CLEAR_THE_AIR",
    name = ccb.content.text("Purifying the Air"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Sylph can remove contaminants from the air such as smoke or pollen and leave only pure air behind."),
    prerequisites = { "SYLPH_PER_BONUS_1" },
    secondary_prerequisites = { "PUSHING_WIND" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_clear_the_air = 1 },
}

ccb.content.define_mutation {
    id = "ELECTRICAL_EMISSIONS",
    name = ccb.content.text("Electrical Emissions"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Sylphs often develop electrical emissions that can culminate in lightning bolts."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { zap_electrical_emission = 1 },
}

ccb.content.define_mutation {
    id = "ELECTRICAL_FIELD",
    name = ccb.content.text("Electrical Field"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to summon electrical fields."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { electrical_field = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_MASSIVE_LIGHTNING_BLAST",
    name = ccb.content.text("Fist of Heaven's Fury"),
    points = 9,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to call down the thunderstorm's judgement on a location while outdoors."),
    prerequisites = { "SYLPH_LIGHTNING_MELEE_ATTACKS" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    spells_learned = { sylph_massive_lightning_bolt_spell = 1 },
}

ccb.content.define_mutation {
    id = "air_sprite",
    name = ccb.content.text("Call the Children of the Winds"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to summon an air sprite."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { summon_air_sprite = 1 },
}
