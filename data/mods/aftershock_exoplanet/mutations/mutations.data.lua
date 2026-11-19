local ccb = require("ccb")

ccb.content.define_mutation {
    id = "FACIAL_TENTACLES",
    name = ccb.content.text("Facial Tentacles"),
    points = 1,
    visibility = 8,
    ugliness = 5,
    enchantments = { "INLINE_ENCH_FACIAL_TENTACLES_0" },
    description = ccb.content.text("A set of tentacles surrounds your mouth.  They allow you to eat twice as fast.  Slightly decreases wet penalties."),
    types = { "MUZZLE" },
    prerequisites = { "MOUTH_TENDRILS" },
    cancels = { "MANDIBLES" },
    categories = { "MIGO" },
    wet_protection = { { part = "mouth", ignored = 1 } },
}

ccb.content.define_mutation {
    id = "MOUTH_TENDRILS",
    name = ccb.content.text("Mouth Tendrils"),
    points = -1,
    visibility = 7,
    ugliness = 6,
    description = ccb.content.text("Skin tabs and odd flaps of skin surround your mouth.  They don't affect your eating, but are unpleasant to look at."),
    types = { "MUZZLE" },
    categories = { "MIGO" },
    additions = { "FACIAL_TENTACLES" },
}

ccb.content.define_mutation {
    id = "FUNGAL_IMMUNITY",
    name = ccb.content.text("fungivoral immune system"),
    points = 5,
    description = ccb.content.text("The immune system of these beings transcends anything seen in humanity and appear to be able to target even directed infections such as fungal infestations."),
    purifiable = false,
    threshold_requirements = { "THRESH_YUGGOTH" },
    categories = { "MIGO" },
    flags = { "MYCUS_IMMUNE" },
}

ccb.content.define_mutation {
    id = "WARM_NATURED",
    name = ccb.content.text("Warm Natured"),
    points = 2,
    description = ccb.content.text("Your body becomes much more efficient at distributing heat from itself."),
    types = { "METABOLISM" },
    categories = { "MIGO" },
    additions = { "MIGO_HEAT_RESIST" },
    body_temperature = { -500, -1250 },
}

ccb.content.define_mutation { id = "THICKSKIN", copy_from = "THICKSKIN", add = { categories = { "MIGO", "MASTODON" } } }

ccb.content.define_mutation {
    id = "THICK_HIDE",
    name = ccb.content.text("Thick Hide"),
    points = 2,
    visibility = 10,
    ugliness = 2,
    description = ccb.content.text("Your skin has thickened and toughened further, acting as natural armor.  Somewhat reduces wet effects."),
    types = { "SKIN" },
    categories = { "MIGO" },
    prerequisites = { "THICKSKIN" },
    replacements = { "RHOMBOIDAL_DENTICLES" },
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
    integrated_armor = { "integrated_hide" },
}

ccb.content.define_mutation {
    id = "RHOMBOIDAL_DENTICLES",
    name = ccb.content.text("Rhomboidal Denticles"),
    points = 3,
    visibility = 10,
    ugliness = 4,
    mixed_effect = true,
    description = ccb.content.text("Your skin has thick diamond shaped enamel scutes that both armor your body and allow you to move more smoothly in water.  While difficult to penetrate, it also limits your flexibility.  Greatly reduces wet effects."),
    types = { "SKIN" },
    prerequisites = { "THICK_HIDE" },
    threshold_requirements = { "THRESH_YUGGOTH" },
    categories = { "MIGO" },
    wet_protection = {
        { part = "head", ignored = 15 },
        { part = "leg_l", ignored = 26 },
        { part = "leg_r", ignored = 26 },
        { part = "foot_l", ignored = 15 },
        { part = "foot_r", ignored = 15 },
        { part = "arm_l", ignored = 24 },
        { part = "arm_r", ignored = 24 },
        { part = "hand_l", ignored = 14 },
        { part = "hand_r", ignored = 14 },
        { part = "torso", ignored = 50 },
    },
    integrated_armor = { "integrated_rhomboidal_denticles" },
}

ccb.content.define_mutation {
    id = "NEURAL_IMPROVEMENT",
    name = ccb.content.text("Neural Improvement"),
    points = 1,
    description = ccb.content.text("You see the world a little differently today.  Intelligence + 1"),
    replacements = { "EXPANDED_CONSCIOUSNESS" },
    types = { "INT" },
    categories = { "MIGO" },
    enchantments = { "INLINE_ENCH_NEURAL_IMPROVEMENT_0" },
}

ccb.content.define_mutation {
    id = "EXPANDED_CONSCIOUSNESS",
    name = ccb.content.text("Expanded Consciousness"),
    points = 2,
    description = ccb.content.text("You are beginning to see a way off this planet.  Intelligence + 2"),
    types = { "INT" },
    prerequisites = { "NEURAL_IMPROVEMENT" },
    replacements = { "UPLIFTED_CONSCIOUSNESS" },
    categories = { "MIGO" },
    enchantments = { "INLINE_ENCH_EXPANDED_CONSCIOUSNESS_0" },
}

ccb.content.define_mutation {
    id = "UPLIFTED_CONSCIOUSNESS",
    name = ccb.content.text("Uplifted Consciousness"),
    points = 3,
    visibility = 1,
    ugliness = 1,
    description = ccb.content.text("As humans uplifted our pets in the final years this process is lifting you to a new level of intelligence.  Intelligence + 4"),
    prerequisites = { "EXPANDED_CONSCIOUSNESS" },
    types = { "INT" },
    replacements = { "ALIEN_INT" },
    categories = { "MIGO" },
    enchantments = { "INLINE_ENCH_UPLIFTED_CONSCIOUSNESS_0" },
}

ccb.content.define_mutation {
    id = "ALIEN_INT",
    name = ccb.content.text("Alien Intelligence"),
    points = 3,
    visibility = 3,
    ugliness = 6,
    description = ccb.content.text("You can see the connections from A to B to C to D.  You look at fellow survivors like you are imagining taking them apart.  Intelligence + 5"),
    prerequisites = { "UPLIFTED_CONSCIOUSNESS" },
    types = { "INT" },
    categories = { "MIGO" },
    threshold_requirements = { "THRESH_YUGGOTH" },
    starting_trait = false,
    enchantments = { "INLINE_ENCH_ALIEN_INT_0" },
}

ccb.content.define_mutation {
    id = "ENHANCED_REACTIONS",
    name = ccb.content.text("Enhanced Reactions"),
    points = 1,
    description = ccb.content.text("Today is the day to start juggling.  Dexterity + 1"),
    types = { "DEX" },
    replacements = { "QUICKENING" },
    categories = { "MIGO" },
    enchantments = { "INLINE_ENCH_ENHANCED_REACTIONS_0" },
}

ccb.content.define_mutation {
    id = "QUICKENING",
    name = ccb.content.text("Quickening"),
    points = 2,
    description = ccb.content.text("You are starting to move like they do.  Dexterity + 2"),
    types = { "DEX" },
    prerequisites = { "ENHANCED_REACTIONS" },
    replacements = { "OTHERWORLDLY_GRACE" },
    categories = { "MIGO" },
    enchantments = { "INLINE_ENCH_QUICKENING_0" },
}

ccb.content.define_mutation {
    id = "OTHERWORLDLY_GRACE",
    name = ccb.content.text("Otherworldly Grace"),
    points = 3,
    description = ccb.content.text("You no longer move like a human, others find it disconcerting.  Dexterity + 4"),
    types = { "DEX" },
    prerequisites = { "ENHANCED_REACTIONS" },
    threshold_requirements = { "THRESH_YUGGOTH" },
    social_modifiers = { persuade = -10, lie = -6 },
    categories = { "MIGO" },
    enchantments = { "INLINE_ENCH_OTHERWORLDLY_GRACE_0" },
}

ccb.content.define_mutation {
    id = "NEW_MUSCLES",
    name = ccb.content.text("New Muscles"),
    points = 1,
    description = ccb.content.text("You see some new muscles that you aren't sure you've seen on humans before.  Strength + 1"),
    replacements = { "MUSCLE_FIBER" },
    categories = { "MIGO" },
    types = { "STR" },
    social_modifiers = { persuade = -3, intimidate = 2 },
    enchantments = { "INLINE_ENCH_NEW_MUSCLES_0" },
}

ccb.content.define_mutation {
    id = "MUSCLE_FIBER",
    name = ccb.content.text("Muscle Fiber"),
    points = 2,
    description = ccb.content.text("Fibrous tissue seems to be spreading through your body.  Strength + 2"),
    types = { "STR" },
    prerequisites = { "NEW_MUSCLES" },
    categories = { "MIGO" },
    social_modifiers = { persuade = -3, intimidate = 2 },
    ugliness = 2,
    enchantments = { "INLINE_ENCH_MUSCLE_FIBER_0" },
}

ccb.content.define_mutation {
    id = "MIGO_EARS",
    name = ccb.content.text("Mi-go Ears"),
    points = 1,
    visibility = 4,
    description = ccb.content.text("Your ears have split into a series of tuberous projections.  They waggle towards far away sounds."),
    types = { "EARS" },
    categories = { "MIGO" },
    ugliness = 4,
    enchantments = { "INLINE_ENCH_MIGO_EARS_0" },
}

ccb.content.define_mutation {
    id = "DETACHMENT",
    name = ccb.content.text("Detachment"),
    points = 2,
    flags = { "PRED1" },
    description = ccb.content.text("When were you ever like these creatures, helpless before the changes ravaging this world."),
    purifiable = false,
    replacements = { "ELDRITCH" },
    threshold_requirements = { "THRESH_YUGGOTH" },
    cancels = { "PACIFIST" },
    categories = { "MIGO" },
}

ccb.content.define_mutation {
    id = "ELDRITCH",
    name = ccb.content.text("Eldritch"),
    points = 3,
    description = ccb.content.text("You have a sinister aspect to your demeanor, no longer part of this world.  You feel no sorrow at the deaths of humans and your brain now processes combat skills more efficiently as you mentally dissect your opponents."),
    social_modifiers = { intimidate = 3, persuade = -10, lie = -12 },
    purifiable = false,
    flags = { "PRED3" },
    prerequisites = { "DETACHMENT" },
    threshold_requirements = { "THRESH_YUGGOTH" },
    cancels = { "PACIFIST" },
    categories = { "MIGO" },
}

ccb.content.define_mutation {
    id = "THRESH_YUGGOTH",
    name = ccb.content.text("YUGGOTH"),
    points = 1,
    description = ccb.content.text("The death throes of this world are the birthing pangs of yours."),
    valid = false,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "MIGO_SCENT",
    name = ccb.content.text("Fetid scent"),
    points = 6,
    description = ccb.content.text("Your sweat now smells otherworldly, and not in a good way.  The mi-go still hate you but at least they aren't offended by your smell."),
    valid = false,
    purifiable = false,
    types = { "SCENT" },
    prerequisites = { "SMELLY2" },
    threshold_requirements = { "THRESH_YUGGOTH" },
    categories = { "MIGO" },
    ugliness = 1,
    scent_type = "sc_fetid",
}

ccb.content.define_mutation {
    id = "EERIE",
    name = ccb.content.text("Eerie"),
    points = 1,
    description = ccb.content.text("You are off-putting to others.  Your mannerisms have changed as if human interaction is becoming foreign."),
    categories = { "MIGO" },
    types = { "ATTRACTIVENESS" },
    social_modifiers = { persuade = -15, lie = -10 },
    ugliness = 2,
}

ccb.content.define_mutation {
    id = "WINGS_migo",
    name = ccb.content.text("Mi-go Wings"),
    points = 1,
    visibility = 4,
    ugliness = 8,
    description = ccb.content.text("You have a pair of large, veiny wings.  They don't appear to be made for this atmosphere but they grant a powerful buffeting attack."),
    types = { "WINGS" },
    prerequisites = { "WINGS_STUB" },
    flags = { "WINGS_1" },
    categories = { "MIGO" },
    attacks = {
        {
            player_message = ccb.content.text("You buffet %s with your wings"),
            npc_message = ccb.content.text("%1$s buffets %2$s with their wings"),
            chance = 20,
            base_damage = { type = "bash", amount = 26 },
        },
    },
}

ccb.content.define_mutation {
    id = "MIGO_BREATHE",
    name = ccb.content.text("Mi-go breathe"),
    points = 4,
    description = ccb.content.text("You can now breathe the gasses the mi-go thrive in."),
    starting_trait = false,
    categories = { "MIGO" },
    flags = { "MIGO_IMMUNE" },
}

ccb.content.define_mutation { id = "SHOUT1", copy_from = "SHOUT1", add = { categories = { "MIGO" } } }

ccb.content.define_mutation {
    id = "UPLIFTED",
    name = ccb.content.text("Uplifted"),
    points = 2,
    description = ccb.content.text("You come from uplifted animal stock.  This decreases morale penalties for being wet."),
    valid = false,
    wet_protection = {
        { part = "head", neutral = 9 },
        { part = "leg_l", neutral = 11 },
        { part = "leg_r", neutral = 11 },
        { part = "foot_l", neutral = 5 },
        { part = "foot_r", neutral = 5 },
        { part = "arm_l", neutral = 11 },
        { part = "arm_r", neutral = 11 },
        { part = "hand_l", neutral = 16 },
        { part = "hand_r", neutral = 16 },
        { part = "torso", neutral = 14 },
    },
}

ccb.content.define_mutation { id = "TOUGH_FEET", copy_from = "TOUGH_FEET", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation {
    id = "HAULER",
    name = ccb.content.text("Hauler"),
    points = 2,
    description = ccb.content.text("You are capable of carrying far more than someone with similar strength could.  Your maximum weight carried is increased by 60%."),
    categories = { "MASTODON" },
    cancels = { "BADBACK" },
    enchantments = { "INLINE_ENCH_HAULER_0" },
}

ccb.content.define_mutation { id = "BADKNEES", copy_from = "BADKNEES", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "VEGETARIAN", copy_from = "VEGETARIAN", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "SMELLY", copy_from = "SMELLY", add = { categories = { "MASTODON", "MIGO" } } }

ccb.content.define_mutation { id = "CLUMSY", copy_from = "CLUMSY", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "SLOWRUNNER", copy_from = "SLOWRUNNER", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation {
    id = "PATCHFUR",
    name = ccb.content.text("Patched Fur"),
    points = 0,
    visibility = 2,
    ugliness = 1,
    description = ccb.content.text("Your skin has patches of light fur.  This has no impact on your life except marking you as not fully human."),
    types = { "SKIN", "BODY_ARMOR", "BODY_ARMOR_MOD", "ARMOR" },
    replacements = { "LIGHTFUR" },
    categories = {
        "MASTODON", "SPIDER", "MOUSE", "BEAST", "CATTLE", "RAT", "FELINE", "LUPINE", "RABBIT", "INSECT",
        "URSINE", "CHIROPTERAN",
    },
}

ccb.content.define_mutation { id = "HIRSUTE", copy_from = "HIRSUTE", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation {
    id = "LIGHTFUR",
    copy_from = "LIGHTFUR",
    prerequisites = { "HIRSUTE" },
    add = { categories = { "MASTODON" } },
}

ccb.content.define_mutation { id = "FUR", copy_from = "FUR", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation {
    id = "MASTODON_FUR",
    name = ccb.content.text("Wooly Fur"),
    points = 4,
    visibility = 10,
    ugliness = 3,
    enchantments = { "INLINE_ENCH_MASTODON_FUR_0" },
    description = ccb.content.text("Your fur has grown out and thickened, providing great protection from attacks as well as considerable insulation."),
    types = { "SKIN" },
    prerequisites = { "FUR" },
    threshold_requirements = { "THRESH_MASTODON" },
    categories = { "MASTODON" },
    integrated_armor = { "integrated_mastodon_fur" },
}

ccb.content.define_mutation {
    id = "CRUSHINGFEET",
    name = ccb.content.text("Crushing Feet"),
    points = 0,
    visibility = 2,
    ugliness = 2,
    mixed_effect = true,
    description = ccb.content.text("Your feet have grown massive and ready to support huge weight.  This allows kicking attacks to do much more damage, provides natural armor, and removes the need to wear shoes; however, you cannot wear normal size shoes.  Reduces wet effects."),
    types = { "LEGS" },
    categories = { "MASTODON" },
    wet_protection = { { part = "foot_l", neutral = 10 }, { part = "foot_r", neutral = 10 } },
    destroys_gear = true,
    armor = { { parts = { "foot_l", "foot_r" }, resistances = { bash = 2, cut = 2 } } },
    attacks = {
        {
            player_message = ccb.content.text("You kick %s with your massive feet"),
            npc_message = ccb.content.text("%1$s kicks %2$s with their massive feet"),
            chance = 20,
            strength_damage = { type = "bash", amount = 5 },
        },
    },
}

ccb.content.define_mutation { id = "RUMINANT", copy_from = "RUMINANT", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "GRAZER", copy_from = "GRAZER", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation {
    id = "FACEBUMPS",
    name = ccb.content.text("Face Bumps"),
    points = 0,
    visibility = 3,
    ugliness = 3,
    description = ccb.content.text("You have a pair of bumps on your face above your mouth and beside your nose."),
    types = { "TUSKS" },
    categories = { "MASTODON" },
    replacements = { "TUSKS" },
}

ccb.content.define_mutation {
    id = "TUSKS",
    name = ccb.content.text("Tusks"),
    points = 1,
    visibility = 3,
    ugliness = 1,
    description = ccb.content.text("You have a pair of small tusks on your face.  They allow you to make a weak piercing goring attack."),
    types = { "TUSKS" },
    prerequisites = { "FACEBUMPS" },
    replacements = { "TUSKS_POINTED" },
    categories = { "MASTODON" },
    attacks = {
        {
            player_message = ccb.content.text("You gore %s with your tusks!"),
            npc_message = ccb.content.text("%1$s gores %2$s with their tusks!"),
            chance = 20,
            base_damage = { { type = "stab", amount = 3 }, { type = "bash", amount = 3 } },
        },
    },
}

ccb.content.define_mutation {
    id = "TUSKS_POINTED",
    name = ccb.content.text("Pointed Tusks"),
    points = 1,
    visibility = 8,
    ugliness = 2,
    mixed_effect = true,
    description = ccb.content.text("You have a pair of long, pointed tusks, like someone weaponized an elephant.  They allow you to make a strong piercing headbutt attack, but prevent wearing mouthgear that is not made of fabric."),
    types = { "TUSKS" },
    prerequisites = { "TUSKS" },
    restricts_gear = { "mouth" },
    allow_soft_gear = true,
    categories = { "MASTODON" },
    threshold_requirements = { "THRESH_MASTODON" },
    attacks = {
        {
            player_message = ccb.content.text("You stab %s with your pointed tusks!"),
            npc_message = ccb.content.text("%1$s stabs %2$s with their pointed tusks!"),
            chance = 22,
            base_damage = { type = "stab", amount = 24 },
        },
    },
}

ccb.content.define_mutation { id = "DENSE_BONES", copy_from = "DENSE_BONES", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "MUT_TOUGH", copy_from = "MUT_TOUGH", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "MUT_TOUGH2", copy_from = "MUT_TOUGH2", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "MUT_TOUGH3", copy_from = "MUT_TOUGH3", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "VERY_TALL", copy_from = "VERY_TALL", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "LARGE", copy_from = "LARGE", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "LARGE_OK", copy_from = "LARGE_OK", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "HUGE", copy_from = "HUGE", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation {
    id = "HUGE_OK",
    copy_from = "HUGE_OK",
    add = { categories = { "MASTODON" }, threshold_requirements = { "THRESH_MASTODON" } },
    profession = true,
}

ccb.content.define_mutation { id = "SMELLY2", copy_from = "SMELLY2", add = { categories = { "MASTODON", "MIGO" } } }

ccb.content.define_mutation {
    id = "SNOUT",
    copy_from = "SNOUT",
    add = { categories = { "MASTODON" }, replacements = { "TRUNK" } },
}

ccb.content.define_mutation {
    id = "TRUNK",
    name = ccb.content.text("Elephant Trunk"),
    points = 0,
    visibility = 5,
    ugliness = 6,
    mixed_effect = true,
    description = ccb.content.text("Your face resembles that of an elephant, with a significant trunk.  It looks fierce but prevents wearing mouthgear.  Prehensile and able to perform some fine detail work."),
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    categories = { "MASTODON" },
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 10 },
    craft_skill_bonuses = { electronics = 1, tailor = 1, mechanics = 1, cooking = 1 },
}

ccb.content.define_mutation { id = "HUNGER", copy_from = "HUNGER", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "MET_RAT", copy_from = "MET_RAT", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "SLEEPY", copy_from = "SLEEPY", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "THIRST", copy_from = "THIRST", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "THIRST2", copy_from = "THIRST2", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation {
    id = "TRIPAWS",
    name = ccb.content.text("Three Fingered"),
    points = 0,
    visibility = 3,
    ugliness = 2,
    mixed_effect = true,
    description = ccb.content.text("Your hands have fused into three-fingered paws.  Fine manipulation is a challenge: permanent hand encumbrance of 10, difficulty with delicate craftwork, and your gloves don't fit.  But they handle water better."),
    encumbrance = { hand_l = 10, hand_r = 10 },
    restricts_gear = { "hand_l", "hand_r" },
    craft_skill_bonuses = { electronics = -2, tailor = -2, mechanics = -2 },
    types = { "HANDS" },
    cancels = { "TALONS" },
    categories = { "MASTODON" },
}

ccb.content.define_mutation { id = "HERBIVORE", copy_from = "HERBIVORE", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "PONDEROUS1", copy_from = "PONDEROUS1", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "PONDEROUS2", copy_from = "PONDEROUS2", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation {
    id = "TRUMPET",
    name = ccb.content.text("Trumpeting Voice"),
    points = 0,
    mixed_effect = true,
    description = ccb.content.text("You have a trumpeting, elephantine voice.  Threatening NPCs will be easier, but lying will be very hard."),
    categories = { "MASTODON" },
    social_modifiers = { lie = -30, intimidate = 10 },
}

ccb.content.define_mutation {
    id = "AFS_CRYOADAPTATION",
    name = ccb.content.text("Cryoadaptation"),
    description = ccb.content.text("An experimental cryosleep procedure has permanently altered your body, allowing you to better tolerate cold temperatures."),
    body_temperature = { -850, 850 },
    points = 0,
    valid = false,
    purifiable = false,
    profession = true,
}

ccb.content.define_mutation {
    id = "AFS_LEADERSHIP",
    name = ccb.content.text("Empathic Leadership"),
    description = ccb.content.text("You have a natural talent for leadership and can easily see yourself in others.  Quite literally.  In fact, you can swap control to any other character that follows you."),
    points = 5,
    valid = false,
    purifiable = false,
    profession = true,
}

ccb.content.define_mutation { id = "LEG_TENTACLES", copy_from = "LEG_TENTACLES", allow_soft_gear = true }

ccb.content.define_mutation { id = "CHEMIMBALANCE", copy_from = "CHEMIMBALANCE", add = { categories = { "MIGO" } } }

ccb.content.define_mutation { id = "POISRESIST", copy_from = "POISRESIST", add = { categories = { "MIGO" } } }

ccb.content.define_mutation { id = "NIGHTVISION", copy_from = "NIGHTVISION", add = { categories = { "MIGO" } } }

ccb.content.define_mutation { id = "PARAIMMUNE", copy_from = "PARAIMMUNE", add = { categories = { "MIGO" } } }

ccb.content.define_mutation { id = "SCHIZOPHRENIC", copy_from = "SCHIZOPHRENIC", add = { categories = { "MIGO" } } }

ccb.content.define_mutation { id = "STR_UP", copy_from = "STR_UP", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "STR_UP_2", copy_from = "STR_UP_2", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "STR_UP_3", copy_from = "STR_UP_3", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "STR_UP_4", copy_from = "STR_UP_4", add = { categories = { "MASTODON" } } }

ccb.content.define_mutation { id = "WINGS_STUB", copy_from = "WINGS_STUB", add = { categories = { "MIGO" } } }

ccb.content.define_mutation {
    id = "SKULLGUN_STUPID",
    name = ccb.content.text("Skullgun Stupidity"),
    points = -1,
    description = ccb.content.text("You took the bionic skullgun out of your noggin, but that didn't replace the brain cells you lost when you installed it."),
    valid = false,
    purifiable = false,
    enchantments = { "INLINE_ENCH_SKULLGUN_STUPID_0" },
}
