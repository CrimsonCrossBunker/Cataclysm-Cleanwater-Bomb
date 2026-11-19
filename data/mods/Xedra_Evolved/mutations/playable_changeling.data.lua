local ccb = require("ccb")

ccb.content.define_mutation {
    id = "POOKA_UNARMED_ATTACK_BONUSES",
    name = ccb.content.text("Instinctive Attacks"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("You're getting used to moving and reacting like an animal.  When without weapons or armor and using your gifts of shapeshifting, your natural attacks do more damage."),
    prerequisites = { "POOKA_ANTLERS", "POOKA_HORNS", "POOKA_FANGS", "POOKA_SABER_TEETH" },
    secondary_prerequisites = { "POOKA_CLAWS", "POOKA_STAINLESS_CLAWS", "POOKA_TAIL_STING" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_POOKA_UNARMED_ATTACK_BONUSES_0" },
}

ccb.content.define_mutation {
    id = "POOKA_UNARMED_DODGE_BONUSES",
    name = ccb.content.text("Animalistic Defense"),
    points = 5,
    purifiable = false,
    description = ccb.content.text("The best defense is not getting hit, especially if you're a wild animal.  When using your shapeshifting and not wearing armor or using a weapon, you gain a bonus to your dodging."),
    prerequisites = { "POOKA_UNARMED_ATTACK_BONUSES" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_POOKA_UNARMED_DODGE_BONUSES_0" },
}

ccb.content.define_mutation {
    id = "POOKA_SPEED_BONUSES",
    name = ccb.content.text("Primal Alacrity"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Like the animals you mimic, you're quicker than you seem.  You gain a speed bonus while shapeshifted as long as you're unarmed and unarmored."),
    prerequisites = { "POOKA_UNARMED_ATTACK_BONUSES" },
    secondary_prerequisites = { "WINGS_BIRD", "POOKA_LEAPING_LEGS", "POOKA_QUADRUPED", "TAIL_FLUFFY", "TAIL_LONG" },
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    enchantments = { "INLINE_ENCH_POOKA_SPEED_BONUSES_0" },
}

ccb.content.define_mutation {
    id = "DEX_UP_SELKIE",
    name = ccb.content.text("Bending Like the River"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Your movements are graceful whether on land or in the water.  +3 Dexterity."),
    prerequisites = { "PARACLESIAN_STR_DEX_1", "PARACLESIAN_STR_DEX_2" },
    secondary_prerequisites = { "SELKIE_WATERMOVE" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    enchantments = { "INLINE_ENCH_DEX_UP_SELKIE_0" },
}

ccb.content.define_mutation {
    id = "PER_UP_SELKIE",
    name = ccb.content.text("Eyes On the Waterline"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Your sight is keen whether in or out of the water.  +2 Perception."),
    prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    enchantments = { "INLINE_ENCH_PER_UP_SELKIE_0" },
}

ccb.content.define_mutation {
    id = "INT_UP_SELKIE",
    name = ccb.content.text("Thoughts like Clear Water"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Your mind flows easily from topic to topic while remembering the important details.  +2 Intelligence."),
    prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    enchantments = { "INLINE_ENCH_INT_UP_SELKIE_0" },
}

ccb.content.define_mutation {
    id = "SELKIE_BEGUILMENT",
    name = ccb.content.text("Beguilement"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Glamour a human into defending you for a short period of time.  When the glamour ends, all effects end and the human will not be well-disposed toward you afterwards."),
    prerequisites = { "BEAUTIFUL", "BEAUTIFUL2", "BEAUTIFUL3" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_beguilement_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_FOG_CLOAK",
    name = ccb.content.text("Cloak of Fog"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Surround yourself with a thick fog, obscuring your position."),
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_fog_cloak_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_DENSE_FOG",
    name = ccb.content.text("Chant of Concealing Mists"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Call up a thick mist, shrouding the nearby landscape."),
    prerequisites = { "SELKIE_FOG_CLOAK" },
    secondary_prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_change_weather_dense_fog_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_RAIN",
    name = ccb.content.text("Aria of the Droplets"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Call a rain shower, letting the rains water the earth."),
    prerequisites = { "SELKIE_CHANGE_WEATHER_DENSE_FOG" },
    secondary_prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_change_weather_rains_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_RAINSTORM",
    name = ccb.content.text("Canticle of Rainstorms"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Call a heavy rainstorm, soaking everything."),
    prerequisites = { "SELKIE_CHANGE_WEATHER_RAIN" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_change_weather_rainstorm_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_LIGHTNINGSTORM",
    name = ccb.content.text("Symphony of Levin"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Call a lightning storm, ."),
    prerequisites = { "SELKIE_CHANGE_WEATHER_RAINSTORM" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_change_weather_lightningstorm_spell = 1 },
}

ccb.content.define_mutation {
    id = "SELKIE_BREATHING_WATER",
    name = ccb.content.text("Breathing Water"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You can breathe water just as easily as you can breathe air, and have no trouble switching between them."),
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    replacements = { "SELKIE_BREATHING_WATER2" },
    types = { "GILLS" },
    flags = { "GILLS" },
}

ccb.content.define_mutation {
    id = "SELKIE_BREATHING_WATER2",
    name = ccb.content.text("At Home in the Water"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You can breathe water just as easily as you can breathe air, and have no trouble switching between them.  In addition, being wet is pleasant in a way it never was before."),
    prerequisites = { "SELKIE_BREATHING_WATER" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    types = { "GILLS" },
    flags = { "GILLS" },
    wet_protection = {
        { part = "torso", good = 10 },
        { part = "head", good = 10 },
        { part = "leg_l", good = 10 },
        { part = "leg_r", good = 10 },
        { part = "arm_l", good = 10 },
        { part = "arm_r", good = 10 },
        { part = "mouth", good = 10 },
        { part = "hand_l", good = 10 },
        { part = "hand_r", good = 10 },
        { part = "foot_l", good = 10 },
        { part = "foot_r", good = 10 },
    },
}

ccb.content.define_mutation {
    id = "SELKIE_WATERSLEEP",
    name = ccb.content.text("The Waves my Bed"),
    points = 1,
    purifiable = false,
    description = ccb.content.text("Falling asleep underwater is easy for you, and you spend less time asleep when you rest there."),
    secondary_prerequisites = { "DEX_UP_SELKIE" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
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
    enchantments = { "INLINE_ENCH_SELKIE_WATERSLEEP_0" },
}

ccb.content.define_mutation {
    id = "SELKIE_WATERMOVE",
    name = ccb.content.text("Cutting Through the Waves"),
    points = 1,
    purifiable = false,
    description = ccb.content.text("Your hands and feet haven't changed at all, but they seem to be much better at swimming than before.  You gain a speed bonus when in water, increased when not wearing shoes."),
    prerequisites = { "SELKIE_BREATHING_WATER", "SELKIE_BREATHING_WATER2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    flags = { "WEBBED_HANDS", "WEBBED_FEET" },
}

ccb.content.define_mutation {
    id = "SELKIE_CHANGE_WEATHER_MASTER",
    name = ccb.content.text("Conductor of Storms"),
    points = 6,
    purifiable = false,
    description = ccb.content.text("You are a master of meteorological enchantments, and your weather manipulations will last much longer."),
    prerequisites = { "SELKIE_CHANGE_WEATHER_RAINSTORM" },
    secondary_prerequisites = { "PARACLESIAN_INT_PER_1", "PARACLESIAN_INT_PER_2" },
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_SELKIE" },
}

ccb.content.define_mutation {
    id = "TROW_MAKE_NOISE",
    name = ccb.content.text("The One Who Knocks"),
    points = 3,
    purifiable = false,
    description = ccb.content.text("Create a loud knocking sound within the glamour's range, to distract or lure your enemies away."),
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    spells_learned = { trow_make_noise_spell = 1 },
}

ccb.content.define_mutation {
    id = "TROW_STONE_FISTS",
    name = ccb.content.text("Fists of Stone"),
    points = 4,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Your tough skin and thick nails allow you to use your hands to replace some simple tools.  Your punches hit harder as well."),
    types = { "CLAWS" },
    prerequisites = { "IERDE_SKIN_2" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    integrated_armor = { "integrated_trow_fists" },
}

ccb.content.define_mutation {
    id = "TROW_LESS_METABOLISM_UNDERGROUND",
    name = ccb.content.text("Stone-Eater"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    purifiable = false,
    description = ccb.content.text("The trow don't literally eat stones, but merely being underground fills you with strength and vigor.  You need half as much food and water while you're underground, and cold underground does not affect you."),
    types = { "METABOLISM" },
    prerequisites = { "PAINRESIST_TROW", "PAINRESIST_TROW2" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_TROW_LESS_METABOLISM_UNDERGROUND_0" },
}

ccb.content.define_mutation {
    id = "TROW_WHILE_MINING_NO_EATING_OR_SLEEP",
    name = ccb.content.text("Deep-Delver"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    purifiable = false,
    description = ccb.content.text("Once you begin mining, you can do it for hours without rest or sleep.  You need neither food nor drink nor rest for as long as you continue mining."),
    prerequisites = { "TROW_LESS_METABOLISM_UNDERGROUND" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
}

ccb.content.define_mutation {
    id = "TROW_STEALTH_UNDERGROUND_ON_ROCK",
    name = ccb.content.text("Amongst the Stones"),
    points = 4,
    visibility = 0,
    ugliness = 0,
    purifiable = false,
    description = ccb.content.text("While on rock or underground, you seem to subtly blend into your surroundings.  You are harder to spot on rocks or underground."),
    prerequisites = { "IERDE_SKIN_2" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_TROW_STEALTH_UNDERGROUND_ON_ROCK_0" },
}

ccb.content.define_mutation {
    id = "PAINRESIST",
    copy_from = "PAINRESIST",
    add = { categories = { "FAIR_FOLK_COMMONER_TROW" } },
}

ccb.content.define_mutation {
    id = "PAINRESIST_TROW",
    name = ccb.content.text("Resilience of the Stones"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You are as hardy as the rock.  When underground, you suffer much less pain."),
    types = { "PAIN" },
    prerequisites = { "PAINRESIST" },
    secondary_prerequisites = { "STR_UP_2", "STR_UP_3", "STR_UP_4" },
    replacements = { "PAINRESIST_TROW2" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_PAINRESIST_TROW_0" },
}

ccb.content.define_mutation {
    id = "TROW_MOONS_TEARS_FORGING",
    name = ccb.content.text("Shaping the Tears"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("You have learned the secrets of forging moon's tears.  Sometimes in your dreams, a new recipe might be revealed to you."),
    secondary_prerequisites = { "STR_UP_2", "STR_UP_3", "STR_UP_4" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
}

ccb.content.define_mutation {
    id = "PAINRESIST_TROW2",
    name = ccb.content.text("Unwavering Resilience of the Stones"),
    points = 6,
    purifiable = false,
    description = ccb.content.text("You are as hardy as the rock.  When underground you suffer much less pain, and your strength is not reduced by the pain you suffer."),
    prerequisites = { "PAINRESIST_TROW" },
    secondary_prerequisites = { "STR_UP_3", "STR_UP_4" },
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_PAINRESIST_TROW2_0", "INLINE_ENCH_PAINRESIST_TROW2_1" },
}

ccb.content.define_mutation {
    id = "FAE_NIGHTVISION",
    name = ccb.content.text("Unveiling the Night"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Your sharp eyes can pierce the darkness."),
    replacements = { "FAE_NIGHTVISION2" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    enchantments = { "INLINE_ENCH_FAE_NIGHTVISION_0" },
}

ccb.content.define_mutation {
    id = "FAE_NIGHTVISION2",
    name = ccb.content.text("Pierce the Shadows"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Whether woods under trees or the cavern depths, you can see through the murk."),
    prerequisites = { "FAE_NIGHTVISION" },
    categories = { "FAIR_FOLK_COMMONER_POOKA", "FAIR_FOLK_COMMONER_TROW" },
    threshold_requirements = { "THRESH_FAIR_FOLK_COMMONER_POOKA", "THRESH_FAIR_FOLK_COMMONER_TROW" },
    enchantments = { "INLINE_ENCH_FAE_NIGHTVISION2_0" },
}

ccb.content.define_mutation {
    id = "CHANGELING_DISGUISE_AS_NATURE",
    name = ccb.content.text("None Here but the Stones"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("The Fair Folk can remain hidden among rocks or trees or whispers of wind, and now you can too."),
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { changeling_disguise_as_nature_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_INVISIBILITY",
    name = ccb.content.text("Hidden from Mortal Eyes"),
    points = 6,
    purifiable = false,
    description = ccb.content.text("Like the Fair Folk of legend, you can remain unseen when you wish."),
    prerequisites = { "CHANGELING_DISGUISE_AS_NATURE" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE", "THRESH_FAIR_FOLK_COMMONER_POOKA",
        "THRESH_FAIR_FOLK_COMMONER_SELKIE", "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { changeling_invisibility_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_STOP_NETHER_CONDITIONS",
    name = ccb.content.text("Dancers in the Endless Dark"),
    points = 8,
    purifiable = false,
    description = ccb.content.text("The Fair Folk dance across realities, avoiding the notice of the vast and timeless forces that overshadow existence.  This glamour will protect you from a variety of deleterious otherworldly afflictions.  It must be applied before exposure."),
    prerequisites = { "CHANGELING_INVISIBILITY" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE", "THRESH_FAIR_FOLK_COMMONER_POOKA",
        "THRESH_FAIR_FOLK_COMMONER_SELKIE", "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { changeling_stop_nether_conditions_spell = 1 },
}

ccb.content.define_mutation {
    id = "CHANGELING_SUMMON_WILL_O_THE_WISPS",
    name = ccb.content.text("Call Will o' the Wisp"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("You can conjure up bobbing lights in the distance that will lead your enemies astray."),
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    spells_learned = { changeling_summon_will_o_the_wisps_spell = 1 },
}

-- For now life extenders such as this one grant MEND_ALL.  When the new wound system will be implemented, their function will be to always allow you to fully heal from your wounds (no scars, etc).
ccb.content.define_mutation {
    id = "FAE_IMMORTALITY",
    name = ccb.content.text("Faerie Eternity"),
    points = 8,
    purifiable = false,
    description = ccb.content.text("You seem to have stopped aging.  That would have been an amazing gift before the Cataclysm, but now at least you might live long enough to find some way back to your birthplace Under the Hill."),
    prerequisites = { "DISIMMUNE" },
    secondary_prerequisites = { "PARACLESIAN_STR_DEX_2", "PARACLESIAN_INT_PER_2" },
    categories = {
        "FAIR_FOLK_NOBLE", "FAIR_FOLK_COMMONER_BROWNIE", "FAIR_FOLK_COMMONER_POOKA",
        "FAIR_FOLK_COMMONER_SELKIE", "FAIR_FOLK_COMMONER_TROW",
    },
    threshold_requirements = {
        "THRESH_FAIR_FOLK_NOBLE", "THRESH_FAIR_FOLK_COMMONER_BROWNIE", "THRESH_FAIR_FOLK_COMMONER_POOKA",
        "THRESH_FAIR_FOLK_COMMONER_SELKIE", "THRESH_FAIR_FOLK_COMMONER_TROW",
    },
    flags = { "MEND_ALL" },
}

ccb.content.define_mutation {
    id = "SELKIE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Selkie gains the ability to grow a goblin fruit when near water or under the rain."),
    categories = { "FAIR_FOLK_COMMONER_SELKIE" },
    spells_learned = { selkie_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "BROWNIE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Brownie gains the ability to grow a goblin fruit when indoors and unobserved."),
    categories = { "FAIR_FOLK_COMMONER_BROWNIE" },
    spells_learned = { brownie_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "POOKA_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Pooka gains the ability to grow a goblin fruit when near animals."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    spells_learned = { pooka_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "TROW_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Trow gains the ability to grow a goblin fruit when underground or at night."),
    categories = { "FAIR_FOLK_COMMONER_TROW" },
    spells_learned = { trow_cultivate_goblin_fruit = 1 },
}

ccb.content.define_mutation {
    id = "NOBLE_CULTIVATE_GOBLIN_FRUIT",
    name = ccb.content.text("Cultivate Goblin Fruit"),
    points = 3,
    purifiable = false,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Noble gains the ability to grow a goblin fruit when near humans or Fae."),
    categories = { "FAIR_FOLK_NOBLE" },
    spells_learned = { noble_cultivate_goblin_fruit = 1 },
}
