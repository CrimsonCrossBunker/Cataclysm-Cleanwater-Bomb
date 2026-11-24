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

ccb.content.define_mutation {
    id = "SALAMANDER_DROP_FIRE",
    name = ccb.content.text("Searing Footsteps"),
    points = 6,
    description = ccb.content.text("The Salamander can enhance their inner fire to the point where they leave fiery footprints everywhere they travel.  Activate this trait to leave a trail of fire in your wake at the cost of mana for every footstep."),
    prerequisites = { "SALAMANDER_EMIT_HEAT" },
    secondary_prerequisites = { "SALAMANDER_SKIN_2", "SALAMANDER_SKIN_3" },
    categories = { "SALAMANDER" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    cooldown = "1 s",
    consumes_mana = true,
    cost = 4,
    on_process = "salamander_fire_footsteps",
}

ccb.content.define_mutation {
    id = "SALAMANDER_MONCAMS",
    name = ccb.content.text("Within the Firelight"),
    points = 2,
    description = ccb.content.text("As a distant fire reveals that which is nearby, the Salamander can see what surrounds their kin.  The Salamander may see through the eyes of any creatures they summon."),
    prerequisites = { "SALAMANDER_SUMMON_FIRE_SPIRIT" },
    secondary_prerequisites = { "SALAMANDER_HEAT_EYES", "SALAMANDER_HEAT_EYES2" },
    categories = { "SALAMANDER" },
    purifiable = false,
    monster_cameras = { mon_salamander_tiny = 50, mon_smoke_mephit = 50 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_BIGGER_STOMACH",
    name = ccb.content.text("Adding Wood to the Campfire"),
    points = 2,
    description = ccb.content.text("Fires require fuel, and so does the Salamander.  This trait allows them to eat twice as much at once."),
    prerequisites = { "SALAMANDER_EMIT_HEAT" },
    replacements = { "SALAMANDER_BIGGER_STOMACH2" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_BIGGER_STOMACH_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_BIGGER_STOMACH2",
    name = ccb.content.text("Fueling the Hungry Oven"),
    points = 5,
    description = ccb.content.text("Like a coal furnace, the Salamander devours food to keep functioning.  They may eat three times as much at once and eat food 50% faster."),
    prerequisites = { "SALAMANDER_BIGGER_STOMACH" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_BIGGER_STOMACH2_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_HEALTH_FOR_MANA",
    name = ccb.content.text("Burning New Wood"),
    points = 6,
    description = ccb.content.text("In times of extreme need, the Salamander can fuel their powers with their own body.  Activate this to restore mana at the cost of HP."),
    prerequisites = { "SALAMANDER_BIGGER_STOMACH", "SALAMANDER_BIGGER_STOMACH2" },
    secondary_prerequisites = { "SALAMANDER_SKIN_1", "SALAMANDER_SKIN_2", "SALAMANDER_SKIN_3" },
    categories = { "SALAMANDER" },
    purifiable = false,
    active = true,
    cost = 1000,
    consumes_calories = true,
    on_activate = "salamander_health_for_mana",
}

ccb.content.define_mutation {
    id = "SALAMANDER_SLEEP_LESS",
    name = ccb.content.text("The Campfire Stands Watch"),
    points = 2,
    description = ccb.content.text("The Salamander needs less sleep than a human.  However, they will also need to eat slightly more."),
    replacements = { "SALAMANDER_SLEEP_LESS2" },
    types = { "SLEEP" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_SLEEP_LESS_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SLEEP_LESS2",
    name = ccb.content.text("The Bonfire Blazes Until the Revelers Have Gone"),
    points = 5,
    description = ccb.content.text("The Salamander needs much less sleep than a human.  However, they will also need to eat significantly more."),
    prerequisites = { "SALAMANDER_SLEEP_LESS" },
    replacements = { "SALAMANDER_SLEEP_LESS3" },
    types = { "SLEEP" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_SLEEP_LESS2_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SLEEP_LESS3",
    name = ccb.content.text("The Watchfire Burns Throughout the Night"),
    points = 10,
    description = ccb.content.text("Like a blazing signal fire, a Salamander never stops shining.  They never need to sleep if they do not want to, and when they do, they need much less sleep than normal.  However, they require twice as much food as a human."),
    prerequisites = { "SALAMANDER_SLEEP_LESS2" },
    types = { "SLEEP" },
    active = true,
    activation_setup_only = true,
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    enchantments = { "INLINE_ENCH_SALAMANDER_SLEEP_LESS3_0" },
    cooldown = "6 h",
    on_activate = "salamander_reset_sleep",
    on_process = "salamander_reset_sleep",
}

ccb.content.define_mutation {
    id = "SALAMANDER_NO_WATER",
    name = ccb.content.text("The Inner Fire Cannot Be Quenched"),
    points = 6,
    description = ccb.content.text("Accursed water.  Its touch dampens your flames, and you will no longer have anything to do with it.  You do not need to drink."),
    types = { "THIRST" },
    prerequisites = { "SALAMANDER_SKIN_2", "SALAMANDER_SKIN_3" },
    categories = { "SALAMANDER" },
    flags = { "NO_THIRST" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "SALAMANDER_NO_SMOKE_DAMAGE",
    name = ccb.content.text("Breathing in Cinders"),
    points = 6,
    description = ccb.content.text("Smoke is the breath of fire and a Salamander is born of flames.  You suffer no negative effects from smoke inhalation."),
    prerequisites = { "SALAMANDER_NO_WATER" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_NO_SMOKE_DAMAGE_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_STR_BONUS_1",
    name = ccb.content.text("Strength of the Crackling Fire"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    replacements = { "SALAMANDER_STR_BONUS_2" },
    description = ccb.content.text("Like a fire fueled with fresh wood, you have increased strength.  +1 Strength."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_STR_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_STR_BONUS_2",
    name = ccb.content.text("Strength of the Blazing Bonfire"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_STR_BONUS_1" },
    secondary_prerequisites = { "SALAMANDER_EMIT_HEAT" },
    description = ccb.content.text("Like the bonfire that will burn through the night, you have greatly increased strength.  +3 Strength."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_STR_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_DEX_BONUS_1",
    name = ccb.content.text("Fiery Speed"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    replacements = { "SALAMANDER_DEX_BONUS_2" },
    description = ccb.content.text("Like a fire sparks kindling in flame, you have increased speed.  +2 Dexterity."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_DEX_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_DEX_BONUS_2",
    name = ccb.content.text("Blazing Speed"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_DEX_BONUS_1" },
    secondary_prerequisites = { "SALAMANDER_ECTOTHERM" },
    description = ccb.content.text("Like a forest fire moving faster than a running horse, you have greatly increased speed.  +5 Dexterity."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_DEX_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_REDUCED_MOVE_COST",
    name = ccb.content.text("Outracing the Prairie Fire"),
    points = 7,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_DEX_BONUS_2" },
    description = ccb.content.text("The Salamander can move even faster than a racing prairie fire.  -10% move and attack speed."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "ench_salamander_reduced_move" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_INT_BONUS",
    name = ccb.content.text("Sparking Thoughts"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_MAKE_FIRE" },
    description = ccb.content.text("Your thoughts are as fast as a forest fire.  +2 Intelligence."),
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_INT_BONUS_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_REMOVE_STUN",
    name = ccb.content.text("Effortlessly-Rising Smoke"),
    points = 5,
    description = ccb.content.text("Like smoke rising to the sky, the Salamander cannot be kept down.  This trait may be activated to immediately clear the Stunned, Dazed, or Downed effects."),
    prerequisites = { "SALAMANDER_REDUCED_MOVE_COST" },
    active = true,
    categories = { "SALAMANDER" },
    purifiable = false,
    cost = 75,
    consumes_calories = true,
    on_activate = "salamander_remove_stun",
}

ccb.content.define_mutation {
    id = "SALAMANDER_COOKING_HEAT",
    name = ccb.content.text("Stove's Caress"),
    points = 4,
    description = ccb.content.text("Instead of simply causing a burst of heat, the Salamander can emit heat from their hands at will, allowing them to use it to cook."),
    prerequisites = { "SALAMANDER_MAKE_FIRE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    cost = 1,
    active = true,
    consumes_calories = true,
    activation_setup_only = true,
    cooldown = 60,
    on_activate = "salamander_cooking_heat_toggle",
    on_deactivate = "salamander_cooking_heat_toggle",
}

ccb.content.define_mutation {
    id = "SALAMANDER_FIRE_IMMUNE",
    name = ccb.content.text("Inured to Flame"),
    points = 9,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALAMANDER_SKIN_3" },
    secondary_prerequisites = { "SALAMANDER_NO_SMOKE_DAMAGE" },
    description = ccb.content.text("A creature born and bred of fire, the Salamander is utterly immune to heat and flame of any kind.  However, they will take additional damage from cold."),
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    enchantments = { "INLINE_ENCH_SALAMANDER_FIRE_IMMUNE_0" },
    flags = { "HEAT_IMMUNE" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FLY_IN_FIRE_SPELL",
    name = ccb.content.text("Burning Ascension"),
    points = 6,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to hurl themselves skyward while standing in a fire."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    spells_learned = { salamander_fire_fly = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_MANA_BONUS",
    name = ccb.content.text("Mana Bonfire"),
    points = 8,
    description = ccb.content.text("The Salamander is a font of mana, like a well-fueled bonfire.  25% extra mana."),
    prerequisites = { "SALAMANDER_INT_BONUS" },
    replacements = { "SALAMANDER_FAST_CAST" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    enchantments = { "INLINE_ENCH_SALAMANDER_MANA_BONUS_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FAST_CAST",
    name = ccb.content.text("Crackling Mana Bonfire"),
    points = 10,
    description = ccb.content.text("The Salamander's mana surges within them, ready to burst out at the slightly opportunity.  25% extra mana and -15% spell casting speed."),
    prerequisites = { "SALAMANDER_INT_BONUS" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    enchantments = { "INLINE_ENCH_SALAMANDER_FAST_CAST_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SUMMON_WINGS",
    name = ccb.content.text("On Wings of Flame"),
    points = 7,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("With an act of will, you can extend wings of flame from your back.  These aetherial wings are not hindered by clothing or armor, but also do not have enough substance to allow you to fly.  However, they can break a fall or be used in combat."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    active = true,
    activation_setup_only = true,
    consumes_mana = true,
    cost = 1,
    cooldown = "3 s",
    activation_message = ccb.content.text("Flaming wings extend from your back!"),
    enchantments = { "ench_salamander_wings_flame" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SUMMON_WINGS_ON",
    name = ccb.content.text("On Wings of Flame (active)"),
    points = 7,
    visibility = 10,
    ugliness = 0,
    description = ccb.content.text("You are extending wings of aetherial flame from your back.  You can attack enemies with them and will not take damage from falls."),
    categories = { "SALAMANDER" },
    purifiable = false,
    active = true,
    valid = false,
    enchantments = { "ench_salamander_wings_flame" },
    transform = {
        target = "SALAMANDER_SUMMON_WINGS",
        message = ccb.content.text("The wings on your back gutter and die."),
        active = false,
        moves = 50,
    },
}

ccb.content.define_mutation {
    id = "SALAMANDER_PREVENT_DEATH",
    name = ccb.content.text("In Flames, Reborn Like the Phoenix"),
    points = 12,
    description = ccb.content.text("Like the bird of legend, the Salamander can recreate themselves from the heat and smoke of a fire.  If their body takes fatal damage while standing in a fire, their fae spirit will use those flames to renew themselves.  This can generally occur no more often than once every 14 days, though there is a small chance it can occur more often."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    secondary_prerequisites = { "SALAMANDER_SMOKE_FORM" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_FLAME_IMMUNITY_ALLY",
    name = ccb.content.text("Anointed with Incandescence"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability to make an ally immune to heat and flame."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    spells_learned = { salamander_ally_flame_immune_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_EXPLOSION_AND_HEAL",
    name = ccb.content.text("The Phoenix's Last Cry"),
    points = 9,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Salamander gains the ability create a massive explosion of flames around themselves and draw on its energy to increase their healing rate."),
    prerequisites = { "SALAMANDER_PREVENT_DEATH" },
    secondary_prerequisites = { "SALAMANDER_SUMMON_FIREBIRD" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    spells_learned = { salamander_explosion_and_heal_spell = 1 },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SMOKE_FORM",
    name = ccb.content.text("Form of Billowing Smoke"),
    points = 8,
    description = ccb.content.text("The Salamander may transform into smoke.  They will have only a dim awareness of their surroundings, but can freely move including through the air and will be nearly immune to attack.  They will be unable to attack anyone else themselves, however."),
    prerequisites = { "SALAMANDER_SUMMON_WINGS", "SALAMANDER_SUMMON_WINGS_ON" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    active = true,
    activation_setup_only = true,
    cooldown = 10,
    consumes_calories = true,
    cost = 1,
    on_activate = "salamander_smoke_form_on",
    on_deactivate = "salamander_smoke_form_off",
}

ccb.content.define_mutation {
    id = "SALAMANDER_SMOKE_FORM_APPEARANCE",
    name = ccb.content.text_without_extraction("Form of Billowing Smoke Appearance"),
    points = 1,
    description = ccb.content.text_without_extraction("This mutation carries the sprite override info for Form of Billowing Smoke.  You shouldn't be able to see it in game."),
    valid = false,
    player_display = false,
    appearance = { id = "fd_nuke_gas", tile_category = "field" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    flags = { "CANNOT_CONSUME_DRUGS" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SMOKE_FORM_ASCEND",
    name = ccb.content.text("Smoke Form Ascension"),
    points = 10,
    description = ccb.content.text("While in hot air or a fire, you may ascend upwards"),
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    active = true,
    valid = false,
    on_activate = "salamander_smoke_form_ascend",
}

ccb.content.define_mutation {
    id = "SALAMANDER_RADIATION_IMMUNE",
    name = ccb.content.text("In No Other Fire Shall I Burn"),
    points = 6,
    description = ccb.content.text("The Salamander is completely immune to radiation."),
    prerequisites = { "SALAMANDER_FIRE_IMMUNE" },
    secondary_prerequisites = { "SALAMANDER_MANA_BONUS" },
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    flags = { "NO_RADIATION" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_BERSERK_STANCE",
    name = ccb.content.text("Wildfire Soul"),
    points = 5,
    description = ccb.content.text("As a banked fire can suddenly spring up with a gust of wind, the Salamander can surge into raging activity.  Activating this trait will make the Salamander immune to pain and add +3 Strength and Dexterity for as long as it is active.  However, when it ends, all the previously put-off pain and more returns."),
    prerequisites = { "SALAMANDER_REMOVE_STUN" },
    secondary_prerequisites = { "SALAMANDER_CURE_CONDITIONS" },
    active = true,
    activation_setup_only = true,
    cost = 7,
    consumes_calories = true,
    cooldown = 10,
    categories = { "SALAMANDER" },
    purifiable = false,
    threshold_requirements = { "THRESH_SALAMANDER" },
    on_activate = "salamander_berserk_stance_on",
    on_deactivate = "salamander_berserk_stance_off",
}
