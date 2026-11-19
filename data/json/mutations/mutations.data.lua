local ccb = require("ccb")

-- MASOCHIST_MED and NOPAIN don't cancel each other.  By design.  Poor painless folks...
ccb.content.define_mutation {
    id = "MASOCHIST_MED",
    name = ccb.content.text("Pain Junkie"),
    description = ccb.content.text("You've developed a serious appetite for pain, and take pride in your scars."),
    categories = { "MEDICAL" },
    types = { "MASOCHISM" },
    prerequisites = { "MASOCHIST", "PAINRESIST", "ADDICTIVE" },
    secondary_prerequisites = { "PAINREC2", "PAINREC3" },
    replacements = { "CENOBITE" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 4,
    purifiable = false,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 2,
}

-- CENOBITE and NOPAIN also don't cancel each other.  By design.  Poor painless cenobites...
ccb.content.define_mutation {
    id = "CENOBITE",
    name = ccb.content.text("Cenobite"),
    description = ccb.content.text("You positively adore pain, in all its varied forms."),
    categories = { "MEDICAL" },
    types = { "MASOCHISM" },
    prerequisites = { "MASOCHIST_MED" },
    secondary_prerequisites = { "PAINREC3", "ADDICTIVE" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 6,
    purifiable = false,
    vitamin_cost = 210,
    visibility = 4,
    ugliness = 10,
    enchantments = { "INLINE_ENCH_CENOBITE_0" },
}

-- MASOCHIST_MED, CENOBITE, and NOPAIN don't cancel each other.  By design.  Poor painless people...
ccb.content.define_mutation {
    id = "NOPAIN",
    name = ccb.content.text("Deadened"),
    description = ccb.content.text("Nothing hurts anymore.  Those bites tickle and the wounds itch a bit, but that's it."),
    categories = { "MEDICAL" },
    types = { "PAIN" },
    prerequisites = { "MASOCHIST", "PAINRESIST" },
    secondary_prerequisites = { "PAINREC3" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 2,
    vitamin_cost = 160,
    purifiable = false,
    flags = { "PAIN_IMMUNE" },
}

-- Like Resilient, but Medical-flavored, and doesn't need huge/strong
ccb.content.define_mutation {
    id = "TOUGH_MEDICAL",
    name = ccb.content.text("Resilient Physiology"),
    description = ccb.content.text("Your body is well-adapted to resist trauma.  20% bonus to all hit points.  Stacks with Tough, etc."),
    categories = { "MEDICAL" },
    types = { "DURABILITY" },
    replacements = { "TOUGH2_MEDICAL" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_TOUGH_MEDICAL_0" },
}

-- Like Solidly Built, but Medical-flavored, and doesn't need huge/strong
ccb.content.define_mutation {
    id = "TOUGH2_MEDICAL",
    name = ccb.content.text("Solid Physiology"),
    description = ccb.content.text("Your body is extremely well-adapted to resist trauma.  30% bonus to all hit points.  Stacks with Tough, etc."),
    categories = { "MEDICAL" },
    types = { "DURABILITY" },
    prerequisites = { "TOUGH_MEDICAL" },
    threshold_requirements = { "THRESH_MEDICAL" },
    points = 3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_TOUGH2_MEDICAL_0" },
}

ccb.content.define_mutation {
    id = "PARAIMMUNE",
    name = ccb.content.text("Parasite Immune"),
    description = ccb.content.text("Your body is unusually inhospitable to parasitic lifeforms.  You will never become infested with internal parasites."),
    categories = { "CHIMERA", "MEDICAL", "SLIME" },
    prerequisites = { "DISRESISTANT", "DISIMMUNE" },
    secondary_prerequisites = { "INFRESIST", "INFIMMUNE" },
    points = 1,
    vitamin_cost = 60,
    flags = { "PARAIMMUNE" },
}

-- name courtesy of wiktionary's Greek for 'mutate'.  Greek-speakers, feel free to correct the term
ccb.content.define_mutation {
    id = "MUT_JUNKIE",
    name = ccb.content.text("Metallassomaiphile"),
    description = ccb.content.text("Just thinking of mutagen (such a lovely word!  'Mutagen'.  Perfect!) makes you thirsty.  And you so love your new parts.  You simply must have more mutagen!"),
    categories = { "MEDICAL", "CHIMERA" },
    threshold_requirements = { "THRESH_MEDICAL", "THRESH_CHIMERA" },
    points = -1,
    mixed_effect = true,
    purifiable = false,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "TROGLO",
    name = ccb.content.text("Light Sensitive"),
    description = ccb.content.text("Sunlight makes you uncomfortable.  If you are outdoors and the weather is Sunny, you suffer -1 to all stats."),
    categories = {
        "BEAST",
        "INSECT",
        "SLIME",
        "SPIDER",
        "BATRACHIAN",
        "RAT",
        "TROGLOBITE",
        "CHIROPTERAN",
        "INTERSTICE",
    },
    types = { "SUNLIGHT" },
    replacements = { "TROGLO2" },
    cancels = { "SEASONAL_AFFECTIVE" },
    points = -2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "TROGLO2",
    name = ccb.content.text("Very Light Sensitive"),
    description = ccb.content.text("Sunlight makes you very uncomfortable.  If you are outdoors during the day, you suffer -1 to all stats; -2 if the weather is Sunny."),
    categories = { "RAT", "TROGLOBITE", "INTERSTICE" },
    types = { "SUNLIGHT" },
    prerequisites = { "TROGLO" },
    replacements = { "TROGLO3" },
    points = -3,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "TROGLO3",
    name = ccb.content.text("Troglobite"),
    description = ccb.content.text("Sunlight makes you extremely uncomfortable, resulting in large penalties to all stats."),
    categories = { "TROGLOBITE" },
    purifiable = false,
    types = { "SUNLIGHT" },
    prerequisites = { "TROGLO2" },
    points = -5,
    vitamin_cost = 210,
}

ccb.content.define_mutation {
    id = "SUNBURN",
    name = ccb.content.text("Solar Sensitivity"),
    description = ccb.content.text("Your skin simply cannot handle ultraviolet radiation, such as sunlight.  It will seriously burn you."),
    categories = { "TROGLOBITE" },
    types = { "skin_tone" },
    prerequisites = { "ALBINO" },
    secondary_prerequisites = { "TROGLO2", "TROGLO3" },
    points = -3,
    vitamin_cost = 160,
    purifiable = false,
    flags = { "SUNBURN" },
}

ccb.content.define_mutation {
    id = "SUNBURN_INTERSTICE",
    name = ccb.content.text("Daylight Exclusion"),
    description = ccb.content.text("You cannot handle sunlight.  It will seriously burn you."),
    categories = { "INTERSTICE" },
    prerequisites = { "TROGLO2" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    points = -3,
    vitamin_cost = 160,
    purifiable = false,
    flags = { "SUNBURN" },
}

ccb.content.define_mutation {
    id = "NIGHT_RAIDER",
    name = ccb.content.text("Night Raider"),
    description = ccb.content.text("Your body is one with the night.  You make less noise when the moon is up in the sky, even when you cannot see it."),
    categories = { "TROGLOBITE" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_NIGHT_RAIDER_0" },
}

ccb.content.define_mutation {
    id = "ALCMET",
    name = ccb.content.text("Alcohol Metabolism"),
    description = ccb.content.text("So it's fermented?  Whatever, it's still good drinking.  You've developed the ability to metabolize alcohol as a food source."),
    categories = { "TROGLOBITE" },
    prerequisites = { "TOLERANCE" },
    secondary_prerequisites = { "SAPROVORE" },
    points = 2,
    vitamin_cost = 160,
    vitamin_intervals = { BAC = 20 },
}

ccb.content.define_mutation {
    id = "PAINRESIST_TROGLO",
    name = ccb.content.text("Subterranean Fortitude"),
    description = ccb.content.text("The aches and pains of living underground don't bother you as much."),
    categories = { "TROGLOBITE" },
    types = { "PAIN" },
    prerequisites = { "PAINRESIST" },
    secondary_prerequisites = { "STOCKY_TROGLO" },
    threshold_requirements = { "THRESH_TROGLOBITE" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_PAINRESIST_TROGLO_0" },
}

-- Trading X for Y usually means reducing X to gain Y, so I switched the order.
ccb.content.define_mutation {
    id = "STOCKY_TROGLO",
    name = ccb.content.text("Subterranean Build"),
    description = ccb.content.text("Your frame has adapted for life in confined spaces.  You seem a little shorter and bulkier, trading mobility for muscle mass.  (+2 Strength, -2 Dexterity)"),
    categories = { "TROGLOBITE" },
    purifiable = false,
    threshold_requirements = { "THRESH_TROGLOBITE" },
    points = 0,
    vitamin_cost = 60,
    visibility = 3,
    ugliness = 2,
    enchantments = { "INLINE_ENCH_STOCKY_TROGLO_0" },
}

ccb.content.define_mutation {
    id = "TUNNEL_FIGHTER",
    name = ccb.content.text("Tunnel Fighter"),
    description = ccb.content.text("You know how to fight in cramped tunnels at risk of collapse.  You gain bonuses when fighting underground."),
    categories = { "INSECT", "TROGLOBITE", "RAT" },
    additions = { "NIGHT_RAIDER" },
    points = 3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_TUNNEL_FIGHTER_0" },
}

ccb.content.define_mutation {
    id = "INFRARED",
    name = ccb.content.text("Infrared Vision"),
    description = ccb.content.text("Your eyes have mutated to pick up radiation in the infrared spectrum."),
    categories = { "INSECT", "TROGLOBITE", "SPIDER" },
    prerequisites = { "NIGHTVISION3" },
    threshold_requirements = { "THRESH_INSECT", "THRESH_TROGLOBITE", "THRESH_SPIDER" },
    cancels = { "LIZ_IR" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "REGEN",
    name = ccb.content.text("Regeneration"),
    description = ccb.content.text("Your flesh regenerates and your limbs mend incredibly quickly."),
    categories = { "SLIME", "TROGLOBITE" },
    types = { "HEALING" },
    prerequisites = { "FASTHEALER2" },
    threshold_requirements = { "THRESH_SLIME", "THRESH_TROGLOBITE" },
    points = 6,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_REGEN_0" },
}

ccb.content.define_mutation {
    id = "SLIMY",
    name = ccb.content.text("Slimy"),
    description = ccb.content.text("Your body is coated with a fine slime which makes uncovered skin harder to grab and protects from long-term effects of acid, though not short-term ones.  Greatly increases wet benefits."),
    categories = { "FISH", "SLIME", "TROGLOBITE", "CEPHALOPOD", "GASTROPOD", "BATRACHIAN" },
    types = { "SECRETION" },
    additions = { "SLIME_HANDS" },
    replacements = { "VISCOUS" },
    points = 2,
    vitamin_cost = 160,
    visibility = 7,
    ugliness = 6,
    flags = { "IRRITANT_IMMUNE" },
    wet_protection = {
        { part = "head", neutral = 3, good = 4 },
        { part = "leg_l", neutral = 7, good = 14 },
        { part = "leg_r", neutral = 7, good = 14 },
        { part = "foot_l", neutral = 2, good = 4 },
        { part = "foot_r", neutral = 2, good = 4 },
        { part = "arm_l", neutral = 7, good = 12 },
        { part = "arm_r", neutral = 7, good = 12 },
        { part = "hand_l", neutral = 2, good = 3 },
        { part = "hand_r", neutral = 2, good = 3 },
        { part = "torso", neutral = 14, good = 26 },
    },
}

ccb.content.define_mutation {
    id = "VISCOUS",
    name = ccb.content.text("Viscous"),
    description = ccb.content.text("Your body's slime output has become sticky and gel-like, making uncovered skin harder to grab and offering some protection from acid.  Greatly increases wet benefits."),
    categories = { "SLIME", "GASTROPOD" },
    prerequisites = { "SLIMY" },
    additions = { "AMORPHOUS" },
    threshold_requirements = { "THRESH_SLIME", "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    points = 4,
    vitamin_cost = 160,
    visibility = 7,
    ugliness = 8,
    flags = { "IRRITANT_IMMUNE" },
    armor = { { part_types = { "ALL" }, resistances = { acid = 2 } } },
    wet_protection = {
        { part = "head", neutral = 4, good = 5 },
        { part = "leg_l", neutral = 8, good = 15 },
        { part = "leg_r", neutral = 8, good = 15 },
        { part = "foot_l", neutral = 3, good = 5 },
        { part = "foot_r", neutral = 3, good = 5 },
        { part = "arm_l", neutral = 8, good = 14 },
        { part = "arm_r", neutral = 8, good = 14 },
        { part = "hand_l", neutral = 3, good = 4 },
        { part = "hand_r", neutral = 3, good = 4 },
        { part = "torso", neutral = 15, good = 27 },
    },
}

ccb.content.define_mutation {
    id = "PALE",
    name = ccb.content.text("Pale Skin"),
    description = ccb.content.text("Your skin is rather pale."),
    categories = { "LUPINE", "TROGLOBITE", "MOUSE", "RABBIT", "BEAST" },
    types = { "skin_tone" },
    replacements = { "ALBINO" },
    points = 0,
    vitamin_cost = 60,
    visibility = 3,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "SPOTS",
    name = ccb.content.text("Spots"),
    description = ccb.content.text("Your skin is covered in a pattern of red spots."),
    categories = { "BATRACHIAN", "SLIME" },
    replacements = { "SORES" },
    points = 0,
    vitamin_cost = 60,
    visibility = 6,
    ugliness = 2,
}

ccb.content.define_mutation {
    id = "SORES",
    name = ccb.content.text("Sores"),
    description = ccb.content.text("Your extremities are covered in painful sores.  The pain is worse when they are covered in clothing."),
    categories = { "SLIME" },
    prerequisites = { "SPOTS" },
    points = -2,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 6,
}

ccb.content.define_mutation {
    id = "AMORPHOUS",
    name = ccb.content.text("Amorphous Body"),
    description = ccb.content.text("Your flesh is a pleasing gel-like consistency.  Your bodily functions seem to be moving around, and your leg-equivalents flow comfortably - if a little slower than your old meat-legs."),
    categories = { "SLIME" },
    prerequisites = { "VISCOUS" },
    secondary_prerequisites = { "BENDY2", "SLIME_HANDS" },
    additions = { "INT_SLIME", "PER_SLIME" },
    threshold_requirements = { "THRESH_SLIME" },
    points = -2,
    purifiable = false,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 10,
    bionic_exclusions = {
        "torso", "head", "eyes", "mouth", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r",
        "foot_l", "foot_r",
    },
    armor = {
        {
            parts = {
                "torso", "head", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r", "foot_l",
                "foot_r", "mouth", "eyes",
            },
            resistances = { bash = 4 },
        },
    },
    enchantments = { "INLINE_ENCH_AMORPHOUS_0" },
}

ccb.content.define_mutation {
    id = "SLIMESPAWNER",
    name = ccb.content.text("Omnicellular"),
    description = ccb.content.text("Your body is more or less one consistent whole: a single, giant, omni-cell that alters itself as needed."),
    categories = { "SLIME" },
    prerequisites = { "INT_SLIME" },
    secondary_prerequisites = { "PER_SLIME_OK" },
    threshold_requirements = { "THRESH_SLIME" },
    cancels = { "TINYSTOMACH" },
    points = 10,
    purifiable = false,
    active = true,
    cost = 347,
    vitamin_cost = 300,
    consumes_calories = true,
    consumes_water = true,
    visibility = 10,
    ugliness = 10,
    enchantments = { "INLINE_ENCH_SLIMESPAWNER_0", "INLINE_ENCH_SLIMESPAWNER_1" },
    flags = { "DISTRIBUTED_DAMAGE" },
}

ccb.content.define_mutation {
    id = "FEYHEARING",
    name = ccb.content.text("Fey Hearing"),
    description = ccb.content.text("You're not sure the shape of your ears is helping you any; regardless, you have become very sensitive to sounds."),
    categories = { "ELFA" },
    types = { "HEARING" },
    prerequisites = { "GOODHEARING" },
    secondary_prerequisites = { "ELFA_EARS" },
    threshold_requirements = { "THRESH_ELFA" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_FEYHEARING_0" },
}

ccb.content.define_mutation {
    id = "ELFAEYES",
    name = ccb.content.text("Fey Eyes"),
    description = ccb.content.text("Your eyes have turned… green.  It's tough to tell the exact shade, as it seems to shift.  The effect is… pleasant."),
    categories = { "ELFA" },
    types = { "EYES" },
    additions = { "ELFA_NV" },
    points = 1,
    vitamin_cost = 60,
    social_modifiers = { lie = 5, persuade = 5, intimidate = -5 },
}

ccb.content.define_mutation {
    id = "INTERSTICEEYES",
    name = ccb.content.text("Pale Eyes"),
    description = ccb.content.text("Your eyes have turned almost completely white.  The effect is unpleasant and intimidating."),
    categories = { "INTERSTICE" },
    types = { "EYES" },
    additions = { "INTERSTICE_VISION" },
    points = 1,
    vitamin_cost = 60,
    social_modifiers = { persuade = -5, intimidate = 5 },
}

ccb.content.define_mutation {
    id = "INTERSTICEHEARING",
    name = ccb.content.text("Otherworldly Hearing"),
    description = ccb.content.text("You hear so well that you could hear the whisper of a shadow.  And you do.  Everything speaks to you.  You have extremely good hearing, but -1 Intelligence."),
    categories = { "INTERSTICE" },
    types = { "HEARING" },
    prerequisites = { "GOODHEARING" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    mixed_effect = true,
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_INTERSTICEHEARING_0" },
}

ccb.content.define_mutation {
    id = "ELFA_NV",
    name = ccb.content.text("Fey Vision"),
    description = ccb.content.text("Your corneas have taken on the same weird green as your irises, and golden veins shift below the surface in a mesmerizing dance.  The shadows don't seem nearly as dark now."),
    categories = { "ELFA" },
    types = { "VISION" },
    prerequisites = { "ELFAEYES" },
    replacements = { "ELFA_FNV" },
    threshold_requirements = { "THRESH_ELFA" },
    points = 3,
    vitamin_cost = 160,
    cancels = { "NIGHTVISION", "NIGHTVISION2", "NIGHTVISION3" },
    enchantments = { "INLINE_ENCH_ELFA_NV_0" },
}

ccb.content.define_mutation {
    id = "ELFA_FNV",
    name = ccb.content.text("Fey Nightsight"),
    description = ccb.content.text("Your corneas have taken on the same weird green as your irises, and golden veins shift below the surface in a mesmerizing dance.  You have great low-light vision now, but it doesn't allow you to perform fine tasks such as crafting and reading in darkness."),
    categories = { "ELFA" },
    types = { "VISION" },
    prerequisites = { "ELFA_NV" },
    threshold_requirements = { "THRESH_ELFA" },
    points = 5,
    vitamin_cost = 210,
    cancels = { "NIGHTVISION", "NIGHTVISION2", "NIGHTVISION3" },
    enchantments = { "INLINE_ENCH_ELFA_FNV_0" },
}

ccb.content.define_mutation {
    id = "ELFA_EARS",
    name = ccb.content.text("Pointed Ears"),
    description = ccb.content.text("Your upper earlobes have grown noticeably higher.  Fortunately, they don't get in the way of your headgear, much.  Unfortunately, they also don't seem to help your hearing any."),
    categories = { "ELFA" },
    types = { "EARS" },
    points = 0,
    vitamin_cost = 80,
    visibility = 4,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "ANIMALEMPATH",
    name = ccb.content.text("Animal Empathy"),
    description = ccb.content.text("Peaceful animals will not run away from you, and even aggressive animals are less likely to attack.  This only applies to natural animals such as woodland creatures."),
    categories = { "LUPINE", "ELFA" },
    types = { "ANIMAL_EMPATHY" },
    replacements = { "ANIMALEMPATH2" },
    points = 1,
    vitamin_cost = 60,
    flags = { "ANIMALEMPATH" },
}

ccb.content.define_mutation {
    id = "ANIMALEMPATH2",
    name = ccb.content.text("Animal Kinship"),
    description = ccb.content.text("Something about your presence is calming to animals, and they will treat you with innate trust.  This only applies to natural animals such as woodland creatures."),
    categories = { "ELFA" },
    types = { "ANIMAL_EMPATHY" },
    prerequisites = { "ANIMALEMPATH" },
    points = 2,
    vitamin_cost = 160,
    flags = { "ANIMALEMPATH2" },
}

ccb.content.define_mutation {
    id = "ANIMALDISCORD",
    name = ccb.content.text("Animal Discord"),
    description = ccb.content.text("Most animals don't like you, and aggressive animals are more likely to attack you.  This only applies to natural animals such as woodland creatures."),
    categories = { "BEAST", "RAPTOR", "INSECT", "MOUSE", "RABBIT" },
    types = { "ANIMAL_EMPATHY" },
    replacements = { "ANIMALDISCORD2" },
    points = -1,
    vitamin_cost = 60,
    flags = { "ANIMALDISCORD" },
}

ccb.content.define_mutation {
    id = "ANIMALDISCORD2",
    name = ccb.content.text("Prey Animal"),
    description = ccb.content.text("Natural animals like dogs and wolves see you as prey, and are liable to attack you on sight."),
    categories = { "MOUSE", "RABBIT" },
    types = { "ANIMAL_EMPATHY", "PREDATION" },
    prerequisites = { "ANIMALDISCORD" },
    points = -3,
    vitamin_cost = 160,
    flags = { "ANIMALDISCORD2" },
}

ccb.content.define_mutation {
    id = "TERRIFYING",
    name = ccb.content.text("Terrifying"),
    description = ccb.content.text("There's something about you that creatures find frightening, and they are more likely to try to flee."),
    categories = { "BEAST", "INSECT", "CHIMERA", "CRUSTACEAN", "INTERSTICE" },
    types = { "ANIMAL_EMPATHY" },
    points = 1,
    starting_trait = true,
    vitamin_cost = 60,
    social_modifiers = { intimidate = 15 },
}

ccb.content.define_mutation {
    id = "THORNS",
    name = ccb.content.text("Thorns"),
    description = ccb.content.text("Your skin is covered in small, woody thorns.  Whenever an unarmed opponent strikes a part of your body that is not covered by clothing, they will receive minor damage.  Your punches may also deal extra damage."),
    categories = { "PLANT" },
    prerequisites = { "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    points = 2,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 4,
    enchantments = { "INLINE_ENCH_THORNS_0" },
}

ccb.content.define_mutation {
    id = "LEAVES",
    name = ccb.content.text("Leaves"),
    description = ccb.content.text("All the hair on your body has turned to long, grass-like leaves.  Apart from being physically striking, these provide you with a minor amount of nutrients while in sunlight when your head is uncovered.  Slightly reduces wet effects."),
    categories = { "PLANT", "ELFA" },
    types = { "HAIR" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    replacements = { "LEAVES2" },
    points = 3,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 3,
    wet_protection = { { part = "head", ignored = 1 } },
}

ccb.content.define_mutation {
    id = "LEAVES2",
    name = ccb.content.text("Lush Leaves"),
    description = ccb.content.text("Your leaves have grown in size and prominence, with additional leaves sprouting along your arms.  While your arms and head are uncovered, you will photosynthesize nutrients while in sunlight.  Reduces wet effects."),
    categories = { "PLANT" },
    types = { "HAIR" },
    prerequisites = { "LEAVES" },
    secondary_prerequisites = { "TRANSPIRATION" },
    replacements = { "LEAVES3" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 6,
    vitamin_cost = 210,
    visibility = 10,
    ugliness = 5,
    covered_encumbrance = { arm_l = 5, arm_r = 5 },
    wet_protection = {
        { part = "head", ignored = 4 },
        { part = "arm_l", ignored = 5 },
        { part = "arm_r", ignored = 5 },
    },
}

ccb.content.define_mutation {
    id = "LEAVES3",
    name = ccb.content.text("Verdant Leaves"),
    description = ccb.content.text("Your leaves are vibrant, large, and green, and have become a major source of nutrients for your body.  Whenever your arms and head are uncovered you will gain a large amount of nutrients by standing in the sunlight.  Reduces wet effects."),
    categories = { "PLANT" },
    types = { "HAIR" },
    prerequisites = { "LEAVES2" },
    secondary_prerequisites = { "TRANSPIRATION" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 9,
    vitamin_cost = 350,
    visibility = 12,
    ugliness = 6,
    covered_encumbrance = { arm_l = 10, arm_r = 10 },
    wet_protection = {
        { part = "head", ignored = 5 },
        { part = "arm_l", ignored = 8 },
        { part = "arm_r", ignored = 8 },
    },
}

ccb.content.define_mutation {
    id = "FLOWERS",
    name = ccb.content.text("Flowering"),
    description = ccb.content.text("You've started blooming where your scalp used to be.  Your blossoms have a pleasant aroma, are visually striking, and are quite sensitive."),
    categories = { "PLANT", "ELFA" },
    types = { "SCENT" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    secondary_prerequisites = { "HAIRROOTS" },
    replacements = { "ROSEBUDS" },
    threshold_requirements = { "THRESH_PLANT", "THRESH_ELFA" },
    points = 2,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = -4,
    social_modifiers = { lie = 10 },
    enchantments = { "INLINE_ENCH_FLOWERS_0" },
}

ccb.content.define_mutation {
    id = "ROSEBUDS",
    name = ccb.content.text("Rosebuds"),
    description = ccb.content.text("The top of your head is blooming with rosebuds.  They're eye catching, and have a strong fragrance that makes you pleasant to be around."),
    categories = { "PLANT", "ELFA" },
    types = { "SCENT" },
    prerequisites = { "FLOWERS" },
    threshold_requirements = { "THRESH_PLANT", "THRESH_ELFA" },
    cancels = { "SMELLY", "SMELLY2" },
    points = 3,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = -6,
    social_modifiers = { lie = 15, persuade = 10 },
}

ccb.content.define_mutation {
    id = "PONDEROUS1",
    name = ccb.content.text("Ponderous"),
    description = ccb.content.text("Your muscles are generally slow to move.  You move 10% slower."),
    categories = { "URSINE", "CATTLE", "PLANT" },
    types = { "RUNNING" },
    replacements = { "PONDEROUS2" },
    points = -3,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_PONDEROUS1_0" },
}

ccb.content.define_mutation {
    id = "PONDEROUS2",
    name = ccb.content.text("Very Ponderous"),
    description = ccb.content.text("Your muscles are quite slow to move.  You move 20% slower."),
    categories = { "CATTLE", "PLANT" },
    types = { "RUNNING" },
    prerequisites = { "PONDEROUS1" },
    replacements = { "PONDEROUS3" },
    points = -5,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_PONDEROUS2_0" },
}

ccb.content.define_mutation {
    id = "PONDEROUS3",
    name = ccb.content.text("Extremely Ponderous"),
    description = ccb.content.text("Your muscles are very slow to move.  You move 30% slower."),
    categories = { "PLANT" },
    types = { "RUNNING" },
    prerequisites = { "PONDEROUS2" },
    points = -6,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_PONDEROUS3_0" },
}

ccb.content.define_mutation {
    id = "VINES1",
    name = ccb.content.text("Vines"),
    description = ccb.content.text("You have developed several vines sprouting from your shoulder area.  They're bulky, and get in the way."),
    categories = { "PLANT" },
    types = { "WINGS" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    replacements = { "VINES2" },
    points = -2,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 5,
    encumbrance = { torso = 10 },
}

ccb.content.define_mutation {
    id = "VINES2",
    name = ccb.content.text("Vine Limbs"),
    description = ccb.content.text("You've developed the ability to control your vines; they make good lashes.  You can even rappel down sheer drops using them, but disconnecting HURTS."),
    categories = { "PLANT" },
    types = { "WINGS" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    secondary_prerequisites = { "VINES1" },
    replacements = { "VINES3" },
    points = 2,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 5,
    flags = { "VINE_RAPPEL" },
    encumbrance = { torso = 10 },
    enchantments = { "INLINE_ENCH_VINES2_0", "INLINE_ENCH_VINES2_1", "INLINE_ENCH_VINES2_2" },
}

ccb.content.define_mutation {
    id = "VINES3",
    name = ccb.content.text("Vine Sprouter"),
    description = ccb.content.text("You have full control of your vines, and can grow new ones and detach old ones more or less at will."),
    categories = { "PLANT" },
    types = { "WINGS" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    secondary_prerequisites = { "VINES2" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 5,
    active = true,
    cost = 90,
    vitamin_cost = 210,
    consumes_calories = true,
    consumes_water = true,
    visibility = 10,
    ugliness = 6,
    flags = { "VINE_RAPPEL" },
    spawn_item = { item = "vine_30", message = ccb.content.text("You detach a vine from your body.") },
    enchantments = { "INLINE_ENCH_VINES3_0", "INLINE_ENCH_VINES3_1", "INLINE_ENCH_VINES3_2" },
}

ccb.content.define_mutation {
    id = "HAIRROOTS",
    name = ccb.content.text("Hair Roots"),
    description = ccb.content.text("Roots have started growing from your leaf-like hair.  They don't seem to do much."),
    categories = { "PLANT", "ELFA" },
    prerequisites = { "LEAVES" },
    points = 0,
    vitamin_cost = 60,
    visibility = 4,
    ugliness = 2,
}

ccb.content.define_mutation {
    id = "ROOTS1",
    name = ccb.content.text("Toe Roots"),
    description = ccb.content.text("Your toes have grown wriggly, and you can't imagine why you wear that stuff on your feet.  Take it off.  It's in the way."),
    categories = { "PLANT" },
    types = { "FEET" },
    prerequisites = { "PLANTSKIN" },
    replacements = { "ROOTS2" },
    threshold_requirements = { "THRESH_PLANT" },
    cancels = { "LEG_TENTACLES", "HOOVES" },
    points = -2,
    vitamin_cost = 160,
    visibility = 1,
    ugliness = 5,
    covered_encumbrance = { foot_l = 10, foot_r = 10 },
}

-- The idea is that you, for lack of a better term, plant yourself.  Crafting and digging don't count because they presume a certain amount of movement during the task.  The handheld game does count.
ccb.content.define_mutation {
    id = "ROOTS2",
    name = ccb.content.text("Roots"),
    description = ccb.content.text("It's about time you started developing a root system.  When reading, fishing, waiting, or otherwise being stationary for a while on diggable terrain, you'll extract nutrients and water from the soil."),
    categories = { "PLANT" },
    types = { "LEGS", "FEET" },
    prerequisites = { "ROOTS1" },
    replacements = { "ROOTS3" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 2,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = 5,
    flags = { "TOUGH_FEET", "ROOTS2" },
    covered_encumbrance = { foot_l = 10, foot_r = 10 },
}

ccb.content.define_mutation {
    id = "ROOTS3",
    name = ccb.content.text("Rooter"),
    description = ccb.content.text("You find it difficult not to sink roots when able.  You extract nutrients and water whenever on diggable terrain, but move more slowly."),
    categories = { "PLANT" },
    types = { "LEGS", "FEET" },
    prerequisites = { "ROOTS2" },
    secondary_prerequisites = { "SAPROPHAGE" },
    replacements = { "CHLOROMORPH" },
    threshold_requirements = { "THRESH_PLANT" },
    points = 0,
    vitamin_cost = 190,
    visibility = 5,
    ugliness = 5,
    flags = { "TOUGH_FEET", "ROOTS3" },
    covered_encumbrance = { foot_l = 10, foot_r = 10 },
}

ccb.content.define_mutation {
    id = "SUNLIGHT_DEPENDENT",
    name = ccb.content.text("Sunlight Dependent"),
    description = ccb.content.text("You feel very sluggish when not in direct sunlight.  You suffer a 5% drop in speed when in shade, and a 10% drop in speed when in the dark."),
    categories = { "PLANT" },
    types = { "SUNLIGHT" },
    points = -5,
    vitamin_cost = 210,
}

ccb.content.define_mutation {
    id = "CHLOROMORPH",
    name = ccb.content.text("Chloromorphosis"),
    description = ccb.content.text("Every inch of your skin is packed with chlorophyll and you have strong roots.  Sleeping on diggable soil will satisfy any hunger or thirst you might have."),
    categories = { "PLANT" },
    types = { "LEGS", "FEET" },
    prerequisites = { "ROOTS3" },
    secondary_prerequisites = { "SAPROPHAGE" },
    threshold_requirements = { "THRESH_PLANT" },
    cancels = { "SMELLY", "SMELLY2" },
    points = 10,
    purifiable = false,
    vitamin_cost = 300,
    visibility = 7,
    ugliness = 1,
    scent_type = "sc_flower",
    comfort = {
        {
            conditions = { { kind = "vehicle" } },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("It's impossible to sleep in this wheeled pot!"),
                rating = "bad",
            },
        },
        {
            conditions = { { kind = "furniture", id = "f_null", invert = true } },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("The humans' furniture blocks your roots.  You can't get comfortable."),
                rating = "bad",
            },
        },
        {
            conditions = {
                { kind = "terrain", flag = "PLOWABLE", invert = true },
                { kind = "terrain", flag = "PLANTABLE", invert = true },
                { kind = "terrain", id = "t_pit", invert = true },
                { kind = "terrain", id = "t_pit_shallow", invert = true },
            },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("Your roots scrabble ineffectively at the unyielding surface."),
                rating = "bad",
            },
        },
        {
            conditions = {
                { kind = "terrain", flag = "PLANTABLE" },
                { kind = "terrain", id = "t_dirt" },
                { kind = "terrain", id = "t_pit" },
                { kind = "terrain", id = "t_pit_shallow" },
            },
            any_condition = true,
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You relax as your roots embrace the soil."),
                rating = "good",
            },
        },
        {
            conditions = { { kind = "terrain", flag = "PLOWABLE" } },
            comfort = "comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You relax as your roots embrace the soil."),
                rating = "good",
            },
        },
    },
    flags = { "TOUGH_FEET", "ROOTS3" },
    covered_encumbrance = { foot_l = 10, foot_r = 10 },
}

ccb.content.define_mutation {
    id = "TREE_COMMUNION",
    name = ccb.content.text("Mycorrhizal Communion"),
    description = ccb.content.text("You have gained the ability to commune with trees and comprehend their ancient wisdom.  Activate next to a tree to gradually gain overmap vision through connected forests."),
    categories = { "PLANT", "ELFA" },
    prerequisites = { "HAIRROOTS", "ROOTS2", "ROOTS3", "CHLOROMORPH" },
    threshold_requirements = { "THRESH_PLANT", "THRESH_ELFA" },
    points = 2,
    active = true,
    cost = 0,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "TRANSPIRATION",
    name = ccb.content.text("Transpiration"),
    description = ccb.content.text("Your body has begun moving nutrients via the evaporation of water.  This increases your thirst when it's hot, but reduces it when it's cold."),
    categories = { "PLANT" },
    prerequisites = { "PLANTSKIN", "BARK", "BARK2_a", "BARK2_b", "BARK2_c" },
    secondary_prerequisites = { "LEAVES" },
    threshold_requirements = { "THRESH_PLANT" },
    points = -5,
    vitamin_cost = 210,
    visibility = 0,
    ugliness = 0,
}

ccb.content.define_mutation {
    id = "SAPROPHAGE",
    name = ccb.content.text("Saprophage"),
    description = ccb.content.text("You prefer to sustain your nutritional needs using your roots and direct nutrient extraction/synthesis.  Your human parts still need the raw caloric bulk of 'food' to keep them going, though, and you handle it a lot easier if it's had time to… age a little."),
    categories = { "PLANT" },
    types = { "DIET" },
    prerequisites = { "ROOTS2" },
    secondary_prerequisites = { "LEAVES", "LEAVES2", "LEAVES3" },
    additions = { "CHLOROMORPH" },
    threshold_requirements = { "THRESH_PLANT" },
    points = -3,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 9,
    flags = { "IMMUNE_SPOIL" },
}

ccb.content.define_mutation {
    id = "ELDRITCH_IRE",
    name = ccb.content.text("Eldritch Ire"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("As if the apocalypse itself wasn't enough, you are constantly being at the ire of the zombies.  Zombies somehow can sense your presence from very far away and approach your general location."),
}

ccb.content.define_mutation {
    id = "INTERSTICE_PHYSIOLOGY",
    name = ccb.content.text("Unbound Physiology"),
    description = ccb.content.text("Your body is no longer constrained by the rules of this world.  You move deftly and quietly, but this forced existence is exhausting."),
    categories = { "INTERSTICE" },
    prerequisites = { "INTERSTICE_POSTURE_2" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    points = 3,
    mixed_effect = true,
    vitamin_cost = 300,
    enchantments = { "INLINE_ENCH_INTERSTICE_PHYSIOLOGY_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_GROWING",
    name = ccb.content.text("Growing Shadowy Flesh"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("The ends of your appendages are covered in an inky, shadowy substance.  It does not impede you at all, but you can feel it growing."),
}

ccb.content.define_mutation {
    id = "INTERSTICE_SHRINKING",
    name = ccb.content.text("Retreating Shadowy Flesh"),
    points = 0,
    purifiable = false,
    valid = false,
    description = ccb.content.text("The ends of your appendages are covered in an inky, shadowy substance.  It does not impede you at all, and you can feel it slowly shrinking away."),
}

ccb.content.define_mutation {
    id = "RM13_ENVIRONMENTAL",
    name = ccb.content.text_without_extraction("Heatsink"),
    description = ccb.content.text_without_extraction("Your armor makes you immune to many environmental threats."),
    points = 0,
    valid = false,
    starting_trait = false,
    player_display = false,
    flags = { "HEATSINK", "ACID_IMMUNE", "IRRITANT_IMMUNE" },
}
