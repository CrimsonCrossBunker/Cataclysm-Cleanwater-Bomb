local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SYLPH_SKIN_1",
    name = ccb.content.text("Sylph Skin"),
    points = 0,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Your skin has turned the rolling grey of the clouds.  Your skin is now an ever-shifting color of clouds shifting from stormy to rainy to barely there.  This has no gameplay effects."),
    types = { "skin_tone" },
    additions = { "SYLPH_SKIN_2" },
    categories = { "SYLPH" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "SYLPH_SKIN_2",
    name = ccb.content.text("Cloud Skin"),
    points = 2,
    visibility = 5,
    ugliness = 3,
    description = ccb.content.text("Your skin is clearly separate from the air around you but has become its own weather system.  If someone reaches out and touches you, they will clearly feel you but you look like someone might reach right through you."),
    types = { "SKIN" },
    categories = { "SYLPH" },
    purifiable = false,
    prerequisites = { "SYLPH_SKIN_1" },
    replacements = { "SYLPH_SKIN_3" },
    wet_protection = {
        { part = "head", ignored = 2 },
        { part = "leg_l", ignored = 5 },
        { part = "leg_r", ignored = 5 },
        { part = "foot_l", ignored = 2 },
        { part = "foot_r", ignored = 2 },
        { part = "arm_l", ignored = 4 },
        { part = "arm_r", ignored = 4 },
        { part = "hand_l", ignored = 1 },
        { part = "hand_r", ignored = 1 },
        { part = "torso", ignored = 10 },
    },
    enchantments = { "INLINE_ENCH_SYLPH_SKIN_2_0" },
    integrated_armor = { "integrated_cloud_skin" },
}

ccb.content.define_mutation {
    id = "SYLPH_SKIN_3",
    name = ccb.content.text("Storm Skin"),
    points = 3,
    visibility = 10,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your skin is a roiling storm.  Your flexibility is greatly increased, your ability to ignore temperatures hot and cold have greatly increased but your ability to carry objects has been reduced."),
    types = { "SKIN" },
    prerequisites = { "SYLPH_SKIN_2" },
    threshold_requirements = { "THRESH_SYLPH" },
    categories = { "SYLPH" },
    purifiable = false,
    wet_protection = {
        { part = "head", ignored = 5 },
        { part = "leg_l", ignored = 16 },
        { part = "leg_r", ignored = 16 },
        { part = "foot_l", ignored = 5 },
        { part = "foot_r", ignored = 5 },
        { part = "arm_l", ignored = 14 },
        { part = "arm_r", ignored = 14 },
        { part = "hand_l", ignored = 4 },
        { part = "hand_r", ignored = 4 },
        { part = "torso", ignored = 30 },
    },
    enchantments = { "INLINE_ENCH_SYLPH_SKIN_3_0" },
    integrated_armor = { "integrated_storm_skin" },
}

ccb.content.define_mutation {
    id = "BREATHE_WO_AIR",
    name = ccb.content.text("Breathe Without Air"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to breathe without oxygen.  This will prevent damage from a lack of oxygen."),
    categories = { "SYLPH" },
    purifiable = false,
    flags = { "GILLS", "INHALED_TOXIN_IMMUNE", "SUFFOCATION_IMMUNE" },
}

ccb.content.define_mutation {
    id = "SYLPH_EYES",
    name = ccb.content.text("Sylph Eyes"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph's eyes begin reflecting their mood with lightning and storms when angry and clear skies when happy.  Glare no longer impacts them, and they have much better daytime vision and much faster reaction times."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_EYES_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_EARS",
    name = ccb.content.text("Sylph Ears"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("The Sylph's ears are longer and pointed, like a wisp of cloud trailing across the sky.  They can hear better and no matter how loud the thunder, their ears will not ring from it."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_EARS_0" },
    flags = { "IMMUNE_HEARING_DAMAGE" },
}

ccb.content.define_mutation {
    id = "SYLPH_LOUDER_SHOUTING",
    name = ccb.content.text("Voice of Thunder"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Sylph can make their voice boom like a peal of thunder, shouting so loudly that they can be heard from hundreds of yards away."),
    prerequisites = { "CLAP_OF_THUNDER" },
    secondary_prerequisites = { "BREATHE_WO_AIR" },
    categories = { "SYLPH" },
    purifiable = false,
    active = true,
    activation_setup_only = false,
    enchantments = { "ench_sylph_louder_shouting" },
}

ccb.content.define_mutation {
    id = "CLAP_OF_THUNDER",
    name = ccb.content.text("Clap of Thunder"),
    points = 1,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to create a loud clap of thunder noise at a distance."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { clap_of_thunder = 1 },
}

ccb.content.define_mutation {
    id = "OMINOUS_WIND",
    name = ccb.content.text("Ominous Wind"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to summon and ominous wind that damages sapient creatures morale."),
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { ominous_wind = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_CHARGE_DASH",
    name = ccb.content.text("Stormwind Stride"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to rush forward in a burst of wind."),
    prerequisites = { "SYLPH_SPEED_INCREASE", "SYLPH_SPEED_INCREASE2" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_charge_dash_spell = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_SPEED_ALLY_BUFF",
    name = ccb.content.text("Favonian Murmuration"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability increase the speed of one of their allies."),
    prerequisites = { "SYLPH_CHARGE_DASH" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_increase_ally_speed_spell = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_REVEAL_OVERMAP",
    name = ccb.content.text("Like a Bird on the Wing"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to see surrounding terrain as though standing on high."),
    prerequisites = { "SYLPH_PER_BONUS_1" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_reveal_overmap_spell = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_BONUS_MELEE_RANGE",
    name = ccb.content.text("Breeze-Cutting Blows"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to strike so precisely that the air will carry their melee attacks a short distance."),
    prerequisites = { "SYLPH_BONUS_RANGE", "SYLPH_DEX_BONUS_2" },
    categories = { "SYLPH" },
    purifiable = false,
    spells_learned = { sylph_bonus_melee_range_spell = 1 },
}

ccb.content.define_mutation {
    id = "SLOWFALL",
    name = ccb.content.text("Slow Fall"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph ceases to fall at speeds that would damage themselves, no matter how high the fall is."),
    replacements = { "SYLPH_GLIDING" },
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SLOWFALL_0" },
    flags = { "FEATHER_FALL" },
}

ccb.content.define_mutation {
    id = "SYLPH_GLIDING",
    name = ccb.content.text("Carried on the Breeze"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph can direct their falls, moving horizontally in a gust of wind if they step off a ledge and landing safely on the ground."),
    prerequisites = { "SLOWFALL" },
    additions = { "SYLPH_JUMP_HIGH" },
    categories = { "SYLPH" },
    purifiable = false,
    flags = { "GLIDE", "FEATHER_FALL" },
}

ccb.content.define_mutation {
    id = "SYLPH_JUMP_HIGH",
    name = ccb.content.text("Updraft Leap"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph can leap straight into the air, riding the wind currents for a few seconds before descending to the earth."),
    prerequisites = { "SYLPH_GLIDING" },
    secondary_prerequisites = { "SYLPH_SKIN_2", "SYLPH_SKIN_3" },
    categories = { "SYLPH" },
    purifiable = false,
    active = true,
    activation_setup_only = false,
    on_activate = "sylph_jump_high",
}

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

ccb.content.define_mutation {
    id = "SYLPH_LIGHTNING_MELEE_ATTACKS",
    name = ccb.content.text("Fulgurating Strikes"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "ELECTRICAL_EMISSIONS" },
    secondary_prerequisites = { "ELECTRICAL_FIELD" },
    description = ccb.content.text("At will, the Sylph may cause their attacks to carry a charge, whose power grows with their mastery of lightning.  Each attack costs mana while this trait is active."),
    categories = { "SYLPH" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    on_activate = "sylph_lightning_melee_on",
    on_process = "sylph_lightning_melee_process",
    on_deactivate = "sylph_lightning_melee_off",
}

ccb.content.define_mutation {
    id = "SYLPH_LIGHTNING_MELEE_ATTACKS_ACTIVE",
    name = ccb.content.text_without_extraction("Fulgurating Strikes Active"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text_without_extraction("The actual trait that grants you fulgurating strikes.  It's a bug if you have it."),
    categories = { "SYLPH" },
    purifiable = false,
    valid = false,
    player_display = false,
    enchantments = { "ench_sylph_fulgurating_strikes_basic", "ench_sylph_fulgurating_strikes_advanced" },
}

ccb.content.define_mutation {
    id = "SYLPH_DEX_BONUS_1",
    name = ccb.content.text("Spring Breeze Stride"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    replacements = { "SYLPH_DEX_BONUS_2" },
    prerequisites = { "SYLPH_SPEED_INCREASE" },
    description = ccb.content.text("The Sylph's moves like the wind.  +2 Dexterity."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_DEX_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_DEX_BONUS_2",
    name = ccb.content.text("Storm-Runner's Speed"),
    points = 5,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SYLPH_DEX_BONUS_1" },
    secondary_prerequisites = { "SYLPH_SPEED_INCREASE2" },
    description = ccb.content.text("The Sylph's moves like a sudden burst of wind.  +5 Dexterity."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_DEX_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_INT_BONUS_1",
    name = ccb.content.text("Ice-Clear Thoughts"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    replacements = { "SYLPH_INT_BONUS_2" },
    prerequisites = { "SYLPH_SKIN_2", "SYLPH_SKIN_3" },
    description = ccb.content.text("The Sylph's mind has the clarity of pure frozen water.  +2 Intelligence."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_INT_BONUS_1_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_INT_BONUS_2",
    name = ccb.content.text("Lightning Mind"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SYLPH_INT_BONUS_1" },
    description = ccb.content.text("The Sylph's thoughts move as quickly as a bolt of lightning.  +4 Intelligence."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_INT_BONUS_2_0" },
}

ccb.content.define_mutation {
    id = "SYLPH_PER_BONUS_1",
    name = ccb.content.text("Eagle's Sight"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SYLPH_EYES" },
    description = ccb.content.text("Like a bird soaring on the wind, the Sylph's keen eyes take in their surroundings.  +3 Perception."),
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SYLPH_PER_BONUS_1_0" },
    flags = { "ENHANCED_VISION" },
}

ccb.content.define_mutation {
    id = "SYLPH_FAST_CAST",
    name = ccb.content.text("Zephyr Chant"),
    points = 7,
    description = ccb.content.text("Like the blowing winds, the Sylph's mana races from of their body at their command.  -20% spell casting speed when outdoors."),
    prerequisites = { "SYLPH_INT_BONUS_2" },
    replacements = { "SYLPH_FAST_CAST2" },
    categories = { "SYLPH" },
    purifiable = false,
    enchantments = { "sylph_fast_cast" },
}

ccb.content.define_mutation {
    id = "SYLPH_FAST_CAST2",
    name = ccb.content.text("Whistling Zephyr Chant"),
    points = 10,
    description = ccb.content.text("The wind finds it way through any crack, and so does the Sylph's mana come to their call regardless of what movements they make.  -20% spell casting speed when outdoors and the Sylph no longer needs to gesture to use their magick."),
    prerequisites = { "SYLPH_FAST_CAST" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    enchantments = { "sylph_fast_cast2", "INLINE_ENCH_SYLPH_FAST_CAST2_1" },
}

-- This should have a mana cost here instead of within the EoC once that's possible.
ccb.content.define_mutation {
    id = "SYLPH_FLY_AT_WILL",
    name = ccb.content.text("Surmounting the Clouds"),
    points = 10,
    description = ccb.content.text("Born of the winds, the Sylph can walk on them as easily as the ground.  While this trait is active, the Sylph will not fall and may walk on the air as they like.  It requires 3 mana per turn to fuel their steps."),
    prerequisites = { "SYLPH_JUMP_HIGH" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    active = true,
    activation_setup_only = true,
    cooldown = "1 s",
    on_activate = "sylph_fly_at_will",
    on_process = "sylph_fly_at_will",
}

ccb.content.define_mutation {
    id = "SYLPH_WIND_TRANSLOCATION",
    name = ccb.content.text("Going Wither the Wind May Lead"),
    points = 10,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to travel along the blowing winds to another location they have previously been to."),
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    prerequisites = { "SYLPH_FLY_AT_WILL" },
    spells_learned = { sylph_wind_translocation_spell = 1, sylph_wind_translocation_attune = 1 },
}

ccb.content.define_mutation {
    id = "SYLPH_CLOUD_FORM",
    name = ccb.content.text("Body of Cloud"),
    points = 11,
    description = ccb.content.text("The Sylph may transform into misty cloud.  They will be insubstantial and unable to interact with the environment, but also able to move incredibly quickly and attacks will simply pass through them.  Each second in the cloud form will cost 10 mana."),
    prerequisites = { "SYLPH_FLY_AT_WILL" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    active = true,
    activation_setup_only = true,
    on_activate = "sylph_enter_cloud_form",
    on_deactivate = "sylph_leave_cloud_form",
    on_process = "sylph_maintain_cloud_form",
}

ccb.content.define_mutation {
    id = "SYLPH_CLOUD_FORM_APPEARANCE",
    name = ccb.content.text_without_extraction("Body of Cloud Appearance"),
    points = 1,
    description = ccb.content.text_without_extraction("This mutation carries the sprite override info for Body of Cloud.  You shouldn't be able to see it in game."),
    valid = false,
    player_display = false,
    appearance = { id = "fd_extinguisher", tile_category = "field" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    flags = { "CANNOT_CONSUME_DRUGS" },
}

ccb.content.define_mutation {
    id = "SYLPH_CANNOT_BE_SLOWED_OR_STOPPED",
    name = ccb.content.text("As Free as the Wind"),
    points = 12,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Like the wind, the Sylph goes where they will with no one to stop them.  They are immune to anything that would restrict their movement, such as grabs, terrain costs, or slippery terrain."),
    prerequisites = { "SYLPH_DEX_BONUS_2" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    enchantments = { "INLINE_ENCH_SYLPH_CANNOT_BE_SLOWED_OR_STOPPED_0" },
    flags = { "STEADY", "SLUDGE_IMMUNE", "WEB_WALKER" },
}

ccb.content.define_mutation {
    id = "SYLPH_PAIN_DOESNT_AFFECT_DEX_SPEED",
    name = ccb.content.text("Winds Always At My Back"),
    points = 6,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The winds surround the Sylph and carry them along regardless of their physical condition.  They suffer no penalties to dexterity or speed due to pain."),
    prerequisites = { "SYLPH_CANNOT_BE_SLOWED_OR_STOPPED" },
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    enchantments = { "INLINE_ENCH_SYLPH_PAIN_DOESNT_AFFECT_DEX_SPEED_0" },
}
