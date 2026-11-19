local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_SKIN_1",
    name = ccb.content.text("Salamander Skin"),
    points = 0,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Your skin has turned the color of an autumnal bonfire.  Your skin is now an orange red with dark freckles.  This has no gameplay effects."),
    types = { "skin_tone" },
    additions = { "SALAMANDER_SKIN_2" },
    categories = { "SALAMANDER" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "SALAMANDER_SKIN_2",
    name = ccb.content.text("Burning Coals Skin"),
    points = 2,
    visibility = 4,
    ugliness = 3,
    description = ccb.content.text("Your skin has magickal flames flaring out of it on occasion.  You can operate in warmer climates than normal humans but begin to take damage from getting wet, and you always smell of smoke and ashes."),
    types = { "SKIN" },
    categories = { "SALAMANDER" },
    purifiable = false,
    prerequisites = { "SALAMANDER_SKIN_1" },
    replacements = { "SALAMANDER_SKIN_3" },
    scent_intensity = 800,
    enchantments = { "INLINE_ENCH_SALAMANDER_SKIN_2_0" },
    integrated_armor = { "integrated_coal_skin" },
    flags = { "TOUGH_FEET" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SKIN_3",
    name = ccb.content.text("Flame Skin"),
    points = 3,
    visibility = 10,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your skin exudes magickal flames constantly, you can operate in almost any heat now without danger but rain may be a lethal threat."),
    types = { "SKIN" },
    flags = { "HEAT_IMMUNE", "TOUGH_FEET" },
    prerequisites = { "SALAMANDER_SKIN_2" },
    threshold_requirements = { "THRESH_SALAMANDER" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_SKIN_3_0" },
    integrated_armor = { "integrated_flameskin" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_MAKE_FIRE",
    name = ccb.content.text("Enkindle"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to set something nearby on fire."),
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_make_fire = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_DASH_BOOM",
    name = ccb.content.text("Fiery Charge"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to rush forward and cause an explosion at the place they land."),
    prerequisites = { "SALAMANDER_MAKE_FIRE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_dash_boom_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_EXPLOSION_TRAP",
    name = ccb.content.text("Sigil of Detonation"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to lay a fiery trap which will burst into searing flames when stepped on."),
    prerequisites = { "SALAMANDER_DASH_BOOM" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_explosion_trap_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SMOKE_TELEPORT",
    name = ccb.content.text("In a Puff of Smoke"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to vanish in a burst of smoke and reappear somewhere nearby."),
    prerequisites = { "SALAMANDER_DASH_BOOM" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_smoke_teleport_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FLAME_PUNCH",
    name = ccb.content.text("Blazing Blow"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to punch a target with a fiery fist, causing damage and hurling them back."),
    prerequisites = { "SALAMANDER_MAKE_FIRE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_flame_punch_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SUMMON_FIRE_SPIRIT",
    name = ccb.content.text("Summon Fire Spirit"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to summon a fire spirit."),
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_summon_fire_spirit = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_ASH_BREATH",
    name = ccb.content.text("Exhalation of Ashes"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to breathe out a cloud of thick smoke."),
    prerequisites = { "SALAMANDER_NO_SMOKE_DAMAGE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_ash_breath_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FLAME_BREATH",
    name = ccb.content.text("Breath of the Firedragon"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to breathe a cone of flames."),
    prerequisites = { "SALAMANDER_ASH_BREATH" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_fire_breath = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SUMMON_FIREBIRD",
    name = ccb.content.text("Flame of the Firebird"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to summon a bird made of roaring flames to their aid."),
    prerequisites = { "SALAMANDER_FLAME_BREATH" },
    secondary_prerequisites = { "SALAMANDER_SUMMON_FIRE_SPIRIT" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_summon_firebird_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_INCREASE_SPEED",
    name = ccb.content.text("Fanning the Spark"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to increase their own or an ally's speed."),
    prerequisites = { "SALAMANDER_ECTOTHERM" },
    secondary_prerequisites = { "SALAMANDER_HEAT_HEAL" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_increase_speed_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SUMMON_WHIP",
    name = ccb.content.text("A Hundred Tongues of Flame"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to summon a flaming whip to aid them in battle."),
    prerequisites = { "SALAMANDER_SUMMON_FIRE_SPIRIT" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_flaming_whip_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_EMIT_HEAT",
    name = ccb.content.text("Stoking the Inner Fire"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to emit large quantities of heat."),
    prerequisites = { "SALAMANDER_COOKING_HEAT" },
    secondary_prerequisites = { "SALAMANDER_SLEEP_LESS2", "SALAMANDER_SLEEP_LESS3" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_emit_heat = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_CURE_CONDITIONS",
    name = ccb.content.text("Burning Away Your Impurities"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to cure deleterious conditions at the cost of damage."),
    prerequisites = { "SALAMANDER_HEAT_HEAL" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_cure_conditions = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to pluck a goblin fruit from the flames."),
    prerequisites = { "SALAMANDER_WATER_TO_BOOZE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    spells_learned = { salamander_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_WATER_TO_BOOZE",
    name = ccb.content.text("Burning Water"),
    points = 0,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander learns how to convert water into very strong alcohol."),
    prerequisites = { "SALAMANDER_EYES" },
    categories = { "SALAMANDER" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_WATER_TO_FUEL",
    name = ccb.content.text("Fire From Water"),
    points = 6,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander learn how to convert water directly into fuel.  This is an intensely draining activity."),
    prerequisites = { "SALAMANDER_WATER_TO_BOOZE" },
    categories = { "SALAMANDER" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_EYES",
    name = ccb.content.text("Salamander Eyes"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander's eyes begin reflecting their mood, with warm yellows and deep reds when happy and blazing oranges, blues, and whites when angry.  Glare no longer impacts them and they can always see exactly what temperature it is.  In addition, and they have slightly better daytime vision and much reaction times, though their nighttime vision is reduced."),
    additions = { "SALAMANDER_HEAT_EYES" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_EYES_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_HEAT_EYES",
    name = ccb.content.text("Heat Sight"),
    points = 3,
    description = ccb.content.text("With their new eyes, the Salamander can see heat and pick out others in darkness."),
    prerequisites = { "SALAMANDER_EYES" },
    replacements = { "SALAMANDER_HEAT_EYES2" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_HEAT_EYES2",
    name = ccb.content.text("Reading the Heartfires"),
    points = 5,
    description = ccb.content.text("The Salamander's ability to see heat has sharpened greatly, and they can pick out subtle change in a person's skin caused by blood flow.  This makes persuasion and lying easier."),
    prerequisites = { "SALAMANDER_EYES" },
    categories = { "SALAMANDER" },
    purifiable = false,
    social_modifiers = { persuade = 10, lie = 10 },
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_EARS",
    name = ccb.content.text("Salamander Ears"),
    points = 1,
    purifiable = false,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("The Salamander's ears narrow to a point, like tongues of leaping flame.  While distinctive, this has no gameplay effects."),
    categories = { "SALAMANDER" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_ECTOTHERM",
    name = ccb.content.text("Heat Quickens the Blood"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    types = { "ECTOTHERMIC" },
    description = ccb.content.text("The Salamander gains strength from heat and becomes faster in hot weather.  However, cold weather produces a corresponding slowing effect."),
    prerequisites = { "SALAMANDER_NO_WATER" },
    replacements = { "SALAMANDER_HEAT_HEAL" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_ECTOTHERM_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_HEAT_HEAL",
    name = ccb.content.text("Heat Fuels the Flames"),
    points = 8,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_ECTOTHERM" },
    description = ccb.content.text("The Salamander gains strength from heat and becomes faster and heals much quicker in hot weather.  However, cold weather produces a corresponding slowing effect."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "ench_salamander_heat_healing", "INLINE_ENCH_SALAMANDER_HEAT_HEAL_1" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FAST_CRAFT",
    name = ccb.content.text("Incandescent Artisan's Alacrity"),
    points = 8,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_ECTOTHERM", "SALAMANDER_HEAT_HEAL" },
    description = ccb.content.text("As fae spirits of fire, Salamanders also partake of the heat of the forge and the glow of white-hot iron.  Your crafting speed will increase while standing in fire or hot air."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "ench_salamander_heat_crafting" },
}
