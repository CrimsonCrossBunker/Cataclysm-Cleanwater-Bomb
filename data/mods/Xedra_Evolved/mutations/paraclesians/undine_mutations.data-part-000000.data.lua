local ccb = require("ccb")

ccb.content.define_mutation {
    id = "UNDINE_SKIN_1",
    name = ccb.content.text("Undine Skin"),
    points = 0,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Your skin has turned the color of the Mediterranean Sea.  Your skin is now a brilliant turquoise color.  This has no gameplay effects."),
    types = { "skin_tone" },
    additions = { "UNDINE_SKIN_2" },
    categories = { "UNDINE" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "UNDINE_SKIN_2",
    name = ccb.content.text("Liquid Skin"),
    points = 2,
    visibility = 10,
    ugliness = 3,
    description = ccb.content.text("Your skin has become vaguely gelatinous.  Provides some extra bash defense and immunity to wet effects."),
    types = { "SKIN" },
    categories = { "UNDINE" },
    purifiable = false,
    prerequisites = { "UNDINE_SKIN_1" },
    replacements = { "UNDINE_SKIN_3" },
    wet_protection = {
        { part = "head", good = 7 },
        { part = "leg_l", good = 21 },
        { part = "leg_r", good = 21 },
        { part = "foot_l", good = 6 },
        { part = "foot_r", good = 6 },
        { part = "arm_l", good = 19 },
        { part = "arm_r", good = 19 },
        { part = "hand_l", good = 5 },
        { part = "hand_r", good = 5 },
        { part = "torso", good = 40 },
    },
    integrated_armor = { "integrated_gelatinous_skin" },
}

ccb.content.define_mutation {
    id = "UNDINE_SKIN_3",
    name = ccb.content.text("Wave Skin"),
    points = 3,
    visibility = 10,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your skin is completely replaced by magickal water.  You have become immune to acid effects."),
    types = { "SKIN" },
    flags = { "ACID_IMMUNE" },
    prerequisites = { "UNDINE_SKIN_2" },
    threshold_requirements = { "THRESH_UNDINE" },
    categories = { "UNDINE" },
    purifiable = false,
    wet_protection = {
        { part = "head", good = 7 },
        { part = "leg_l", good = 21 },
        { part = "leg_r", good = 21 },
        { part = "foot_l", good = 6 },
        { part = "foot_r", good = 6 },
        { part = "arm_l", good = 19 },
        { part = "arm_r", good = 19 },
        { part = "hand_l", good = 5 },
        { part = "hand_r", good = 5 },
        { part = "torso", good = 40 },
    },
    integrated_armor = { "integrated_wave_skin" },
}

ccb.content.define_mutation {
    id = "CREATE_FOG",
    name = ccb.content.text("Create Fog"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine gains the ability to create a cloud of fog."),
    categories = { "UNDINE" },
    purifiable = false,
    spells_learned = { create_fog = 1 },
}

ccb.content.define_mutation {
    id = "GRANT_BUOYANCY",
    name = ccb.content.text("Grant Buoyancy"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine gains the ability to grant one person the ability to float and swim."),
    categories = { "UNDINE" },
    purifiable = false,
    spells_learned = { grant_buoyancy = 1 },
}

ccb.content.define_mutation {
    id = "ACIDIC_MIST",
    name = ccb.content.text("Acidic Mist"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine gains the ability to create an acidic mist that damages any creatures inside it."),
    categories = { "UNDINE" },
    purifiable = false,
    spells_learned = { acidic_mist = 1 },
}

ccb.content.define_mutation {
    id = "UNDINE_ACID_RESIST_ALLY",
    name = ccb.content.text("Caustic Cloak"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine gains the ability to weave an enchantment on an ally which will protect them from acid and causes anything who attacks that ally to be splashed with acid themselves."),
    prerequisites = { "ACIDIC_MIST" },
    secondary_prerequisites = { "RESIST_ACID" },
    categories = { "UNDINE" },
    purifiable = false,
    spells_learned = { undine_acid_resist_ally_spell = 1 },
}

ccb.content.define_mutation {
    id = "UNDINE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    visibility = 0,
    ugliness = 0,
    prerequisites = { "SALTWATER_TO_FRESHWATER" },
    description = ccb.content.text("Upon gaining this ability the Undine gains the ability to grow a goblin fruit from a natural water source."),
    categories = { "UNDINE" },
    purifiable = false,
    spells_learned = { undine_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "SALTWATER_TO_FRESHWATER",
    name = ccb.content.text("One Foot in the River and One in the Sea"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine learns how to convert salt water into freshwater and vice versa.  The undine may also manipulate liquids, no longer needing pots to boil or hold them while crafting."),
    categories = { "UNDINE" },
    provided_qualities = { BOIL = 2, CONTAIN = 1, CHEM = 1 },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "BREATH_UNDERWATER",
    name = ccb.content.text("Breathe Underwater"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The Undine has gained the ability to breathe underwater."),
    categories = { "UNDINE" },
    purifiable = false,
    flags = { "GILLS" },
}

ccb.content.define_mutation {
    id = "FOUL_WATER",
    name = ccb.content.text("Cleansing the Poison Well"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine learns how to foul water, making it murky and possibly infested.  Conversely, the Undine can also cleanse water that is not already clean."),
    categories = { "UNDINE" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "LIQUID_TO_WATER",
    name = ccb.content.text("Return to Primordial Waters"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine learns how to convert various liquids into freshwater."),
    categories = { "UNDINE" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "RESIST_FIRE",
    name = ccb.content.text("Resist Fire"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You've gained a resistance to fire."),
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "undine_resist_fire" },
}

ccb.content.define_mutation {
    id = "RESIST_ACID",
    name = ccb.content.text("Resist Acid"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("You've gained a resistance to acid."),
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "undine_resist_acid" },
}

ccb.content.define_mutation {
    id = "WAVE_RIDER",
    name = ccb.content.text("The Sea Bears Me Up"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("The waves themselves answer your call and support you, allowing you to walk on the surface of the water.  Activate to walk on water."),
    categories = { "UNDINE" },
    purifiable = false,
    prerequisites = { "WATER_SEALED" },
    secondary_prerequisites = { "UNDINE_DEX_UP_1" },
    active = true,
    activation_setup_only = true,
    active_flags = { "WATERWALKING" },
}

ccb.content.define_mutation {
    id = "WATER_SEALED",
    name = ccb.content.text("Let the Waves Wash Over Me"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("As the Undine is one with the waters, so too is anything they carry.  Their gear is immune to being dissolved or broken by water."),
    categories = { "UNDINE" },
    purifiable = false,
    flags = { "ITEM_WATERPROOFING" },
}

-- Make spell. Requires C++
ccb.content.define_mutation {
    id = "SUMMON_RAIN",
    name = ccb.content.text("Summon Rain"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    valid = false,
    description = ccb.content.text("Allows the Undine to change the weather to rain.  (Currently not working)"),
    categories = { "UNDINE" },
    purifiable = false,
}

ccb.content.define_mutation {
    id = "SUMMON_FISH",
    name = ccb.content.text("Summon Fish"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Allows the Undine to summon fish and eventually charm them.  Practice this enough and you will be able to befriend sea monsters."),
    categories = { "UNDINE" },
    purifiable = false,
    spells_learned = { summon_fish = 1 },
}

ccb.content.define_mutation {
    id = "UNDINE_BASH_AND_SLOW",
    name = ccb.content.text("Crushing Pressure"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Allows the Undine to slow and damage a single target, as though they were caught in the depths of the ocean."),
    categories = { "UNDINE" },
    purifiable = false,
    prerequisites = { "WATER_SEALED" },
    spells_learned = { undine_bash_and_slow_spell = 1 },
}

ccb.content.define_mutation {
    id = "UNDINE_DRAG_INWARD",
    name = ccb.content.text("Whirlpool Catches the Shoal"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Allows the Undine to force an entire group inward toward a central point, as though caught in a whirlpool."),
    categories = { "UNDINE" },
    purifiable = false,
    prerequisites = { "UNDINE_BASH_AND_SLOW" },
    spells_learned = { undine_drag_inward_spell = 1 },
}

ccb.content.define_mutation {
    id = "UNDINE_TIDAL_WAVE",
    name = ccb.content.text("Tidal Wave"),
    points = 2,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Allows the Undine to force an entire group inward toward a central point, as though caught in a whirlpool."),
    categories = { "UNDINE" },
    purifiable = false,
    threshold_requirements = { "THRESH_UNDINE" },
    prerequisites = { "UNDINE_DRAG_INWARD" },
    spells_learned = { undine_tidal_wave_spell = 1 },
}

ccb.content.define_mutation {
    id = "UNDINE_EYES",
    name = ccb.content.text("Undine Eyes"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Undine's eyes begin reflecting their mood with colors of the deep waters, pitch black when angry or sad and green-blue when pleased.  Glare no longer impacts them, and neither do light levels when trying to sleep.  They can also see without problem underwater and have better night vision in general."),
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_EYES_0" },
}

ccb.content.define_mutation {
    id = "UNDINE_EARS",
    name = ccb.content.text("Undine Ears"),
    points = 1,
    visibility = 2,
    ugliness = 0,
    description = ccb.content.text("The Undine's ears are longer and pointed, like a stream of water poured into a glass from on high.  This is purely cosmetic."),
    categories = { "UNDINE" },
    purifiable = false,
}

-- Eventually add further spells in this area with more powerful elementals.
ccb.content.define_mutation {
    id = "SUMMON_WATER_ELEMENTAL",
    name = ccb.content.text("Calling the Children of the Waves"),
    points = 0,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Allows the Undine to summon a minor water elemental to support them in the world for a short time."),
    categories = { "UNDINE" },
    purifiable = false,
    spells_learned = { summon_water_sprite = 1 },
}

ccb.content.define_mutation {
    id = "UNDINE_SLEEP_WATER",
    name = ccb.content.text("Embrace of the Waters"),
    points = 1,
    description = ccb.content.text("Surrounded by the waters, Undines find it easy to rest.  Falling asleep underwater is easy for you, and you spend less time asleep when you rest there.  You can also eat underwater, though you can't drink."),
    prerequisites = { "UNDINE_SKIN_2", "UNDINE_SKIN_3" },
    secondary_prerequisites = { "BREATH_UNDERWATER" },
    categories = { "UNDINE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_UNDINE_SLEEP_WATER_0" },
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
}

ccb.content.define_mutation {
    id = "UNDINE_ABSORB_WATER",
    name = ccb.content.text("The Sea Sustains Me"),
    points = 4,
    description = ccb.content.text("Undines are born of the flowing waters and the waters provide for their children.  While submerged in fresh water, any thirst you have will be slaked."),
    prerequisites = { "UNDINE_SLEEP_WATER" },
    categories = { "UNDINE" },
    purifiable = false,
}
