local ccb = require("ccb")

ccb.content.define_mutation {
    id = "FELINE_FLEXIBILITY",
    name = ccb.content.text("Feline Flexibility"),
    description = ccb.content.text("Your muscles, joints, and the movement center of your brain have changed internally somewhat, allowing you to traverse obstacles with ease."),
    categories = { "FELINE" },
    threshold_requirements = { "THRESH_FELINE" },
    points = 4,
    purifiable = false,
    vitamin_cost = 190,
    enchantments = { "INLINE_ENCH_FELINE_FLEXIBILITY_0" },
}

ccb.content.define_mutation {
    id = "HATES_WATER",
    name = ccb.content.text("Hates Water"),
    description = ccb.content.text("You really hate getting your fur all wet.  This increases morale penalties for being wet, and you will get them even when wearing appropriate clothing."),
    categories = { "FELINE" },
    prerequisites = { "FELINE_FUR" },
    cancels = { "OUTDOORSMAN" },
    points = -2,
    vitamin_cost = 160,
    wet_protection = {
        { part = "head", good = -12 },
        { part = "leg_l", good = -16 },
        { part = "leg_r", good = -16 },
        { part = "foot_l", good = -4 },
        { part = "foot_r", good = -4 },
        { part = "arm_l", good = -16 },
        { part = "arm_r", good = -16 },
        { part = "hand_l", good = -16 },
        { part = "hand_r", good = -16 },
        { part = "torso", good = -30 },
    },
}

ccb.content.define_mutation {
    id = "RABBIT_EARS",
    name = ccb.content.text("Rabbit Ears"),
    description = ccb.content.text("Your ears have grown into tall and flexible rabbit ears.  They're are slender and enhance your hearing beyond the normal range."),
    categories = { "RABBIT" },
    types = { "EARS" },
    points = 1,
    vitamin_cost = 60,
    visibility = 9,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_RABBIT_EARS_0" },
}

ccb.content.define_mutation {
    id = "RABBIT_NOSE",
    name = ccb.content.text("Rabbit Nose"),
    description = ccb.content.text("Your nose has morphed into a cute bunny nose, along with the snout.  It's extremely twitchy too."),
    categories = { "RABBIT" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    points = -1,
    vitamin_cost = 90,
    visibility = 6,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_RABBIT_NOSE_0" },
}

ccb.content.define_mutation {
    id = "INCISORS",
    name = ccb.content.text("Incisors"),
    description = ccb.content.text("Your big teeth have grown in.  Folks had best show some more respect."),
    categories = { "RAT", "RABBIT" },
    types = { "TEETH" },
    prerequisites = { "MUZZLE_RAT", "RABBIT_NOSE" },
    threshold_requirements = { "THRESH_RAT", "THRESH_RABBIT" },
    points = 2,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "MUZZLE_RAT",
    name = ccb.content.text("Rodent Muzzle"),
    description = ccb.content.text("Your face and jaw have extended, giving you an alert and attentive appearance."),
    categories = { "RAT", "MOUSE" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    points = -2,
    vitamin_cost = 160,
    visibility = 6,
    ugliness = 4,
    restricts_gear = { "mouth" },
    enchantments = { "INLINE_ENCH_MUZZLE_RAT_0" },
}

ccb.content.define_mutation {
    id = "MOUSE_EARS",
    name = ccb.content.text("Rodent Ears"),
    description = ccb.content.text("Your ears are huge, round, and gray!  They're rather fascinating, and help you hear from a much greater distance."),
    categories = { "MOUSE", "RAT" },
    types = { "EARS" },
    threshold_requirements = { "THRESH_MOUSE", "THRESH_RAT" },
    points = 1,
    vitamin_cost = 80,
    visibility = 8,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_MOUSE_EARS_0" },
}

ccb.content.define_mutation {
    id = "SMALL",
    name = ccb.content.text("Little"),
    description = ccb.content.text("You've noticeably shrunk in size.  You're able to move with increased litheness, but your smaller stature prevents you from carrying as much."),
    categories = { "MOUSE", "RABBIT" },
    types = { "SIZE" },
    replacements = { "SMALL2" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 210,
    visibility = 5,
    flags = { "SMALL" },
    enchantments = { "INLINE_ENCH_SMALL_0" },
}

ccb.content.define_mutation {
    id = "SMALL2",
    name = ccb.content.text("Tiny"),
    description = ccb.content.text("You're only half as tall as you used to be!  The weight of things you once found easy to carry is now unbearable, clothes are now twice as encumbering for you unless you refit them (since you're half their size), and your hit points are heavily reduced.  However, your movement is silent, and your dodge skill is a little higher."),
    categories = { "MOUSE" },
    types = { "SIZE" },
    prerequisites = { "SMALL" },
    replacements = { "SMALL_OK" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 210,
    visibility = 8,
    flags = { "TINY" },
    enchantments = { "INLINE_ENCH_SMALL2_0" },
}

ccb.content.define_mutation {
    id = "SMALL_OK",
    name = ccb.content.text("Unassuming"),
    description = ccb.content.text("You've mastered your tiny form!  Item encumbrance and carry weight penalties are reduced, and you've learned to use your increased nimbleness to offset your reduced capacity to absorb damage."),
    categories = { "MOUSE" },
    types = { "SIZE" },
    prerequisites = { "SMALL2" },
    additions = { "CRAFTY" },
    threshold_requirements = { "THRESH_MOUSE" },
    strict_threshold_requirements = true,
    points = 3,
    mixed_effect = true,
    purifiable = false,
    vitamin_cost = 300,
    flags = { "TINY" },
    enchantments = { "INLINE_ENCH_SMALL_OK_0" },
}

ccb.content.define_mutation {
    id = "WHISKERS_RAT",
    name = ccb.content.text("Wiry Whiskers"),
    description = ccb.content.text("You have a set of prominent rodent-like whiskers around your mouth.  These make you more aware of vibrations in the air, and improve your ability to dodge slightly."),
    categories = { "RAT", "MOUSE" },
    types = { "WHISKERS" },
    prerequisites = { "MUZZLE_RAT" },
    points = 2,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "CRAFTY",
    name = ccb.content.text("Crafty"),
    description = ccb.content.text("By making the most of your small stature, you can avoid the notice of all but the most perceptive creatures, and your speed is greatly increased."),
    categories = { "MOUSE" },
    prerequisites = { "SMALL_OK" },
    threshold_requirements = { "THRESH_MOUSE" },
    strict_threshold_requirements = true,
    points = 4,
    purifiable = false,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_CRAFTY_0" },
}

ccb.content.define_mutation {
    id = "NO_THIRST",
    name = ccb.content.text("Metabolic Rehydration"),
    description = ccb.content.text("Your body gets everything it needs from the food that you eat!  You no longer need hydration from fluids."),
    categories = { "MOUSE" },
    types = { "THIRST" },
    threshold_requirements = { "THRESH_MOUSE" },
    strict_threshold_requirements = true,
    points = 6,
    purifiable = false,
    vitamin_cost = 210,
    flags = { "NO_THIRST" },
}

ccb.content.define_mutation {
    id = "BURROW",
    name = ccb.content.text("Burrowing"),
    description = ccb.content.text("Your dextrous paws and long teeth allow you to dig through dirt and rubble with ease."),
    categories = { "RAT", "RABBIT" },
    prerequisites = { "CLAWS_ST", "PAWS", "PAWS_LITTLE" },
    secondary_prerequisites = { "INCISORS" },
    threshold_requirements = { "THRESH_RAT", "THRESH_RABBIT" },
    points = 10,
    purifiable = false,
    active = true,
    vitamin_cost = 300,
}

-- Since bears and wolves cannot get incisiors, but still burrow.
ccb.content.define_mutation {
    id = "BURROWLARGE",
    name = ccb.content.text("Burrowing"),
    description = ccb.content.text("Your tough paws allow you to dig through dirt and rubble with ease."),
    categories = { "LUPINE", "URSINE" },
    prerequisites = { "PAWS", "PAWS_LARGE" },
    threshold_requirements = { "THRESH_LUPINE", "THRESH_URSINE" },
    points = 10,
    purifiable = false,
    active = true,
    vitamin_cost = 300,
}

ccb.content.define_mutation {
    id = "MET_RAT",
    name = ccb.content.text("Rapid Metabolism"),
    description = ccb.content.text("You require more resources than most, but heal more rapidly as well.  Provides weak regeneration even when not asleep."),
    categories = { "RAT", "MOUSE", "RABBIT" },
    types = { "HEALING", "SLEEP", "METABOLISM" },
    prerequisites = { "HUNGER" },
    secondary_prerequisites = { "SLEEPY" },
    points = 0,
    vitamin_cost = 250,
    enchantments = { "INLINE_ENCH_MET_RAT_0" },
}

ccb.content.define_mutation {
    id = "MUZZLE_LONG",
    name = ccb.content.text("Reptilian Muzzle"),
    description = ccb.content.text("Your face and jaws are a shorter version of those found on alligators.  They look NASTY--as do the bite wounds they can inflict--but prevent wearing mouthgear."),
    categories = { "LIZARD" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    secondary_prerequisites = { "FANGS" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 8,
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 20 },
    enchantments = { "INLINE_ENCH_MUZZLE_LONG_0" },
}

ccb.content.define_mutation {
    id = "MUZZLE_RAPTOR",
    name = ccb.content.text("Dromeosaur Muzzle"),
    description = ccb.content.text("Your face has drastically mutated, with the bones of your jaws having extended forth into a long, tapered snout.  The palate of your mouth is considerably vaulted, with curved, serrated teeth lining your saurian maw and reptilian scales covering your muzzle's exterior.  While paleobiology has evidently not evolved with mouth gear in mind (making such items unwearable), the bite wounds you can now inflict promise the ferocity of long-dead beasts."),
    categories = { "RAPTOR" },
    types = { "MUZZLE" },
    prerequisites = { "SNOUT" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 8,
    restricts_gear = { "mouth" },
    social_modifiers = { intimidate = 20 },
    enchantments = { "INLINE_ENCH_MUZZLE_RAPTOR_0" },
}

ccb.content.define_mutation {
    id = "FORKED_TONGUE",
    name = ccb.content.text("Forked Tongue"),
    description = ccb.content.text("Your tongue is forked, like that of a reptile.  This has no effect."),
    categories = { "LIZARD", "RAPTOR" },
    types = { "TONGUE" },
    points = 0,
    visibility = 1,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "LIZ_EYE",
    name = ccb.content.text("Reptilian Eyes"),
    description = ccb.content.text("Your eyes have mutated, with a brilliant iris and slitted pupil similar to that of a lizard.  This is visually striking, but doesn't seem to affect your vision."),
    categories = { "LIZARD", "RAPTOR" },
    types = { "EYES" },
    additions = { "LIZ_IR" },
    points = 0,
    vitamin_cost = 60,
    visibility = 2,
    ugliness = 1,
    social_modifiers = { persuade = -1, intimidate = 1 },
}

ccb.content.define_mutation {
    id = "LIZ_IR",
    name = ccb.content.text("Reptilian IR"),
    description = ccb.content.text("Your optic nerves and brain have mutated to catch up with your eyes, allowing you to see in the infrared spectrum."),
    categories = { "LIZARD", "RAPTOR" },
    types = { "VISION" },
    prerequisites = { "LIZ_EYE" },
    points = 5,
    vitamin_cost = 210,
    enchantments = { "THERMAL_VISION_GOOD_PASSIVE" },
}

ccb.content.define_mutation {
    id = "REGEN_LIZ",
    name = ccb.content.text("Reptilian Healing"),
    description = ccb.content.text("Your broken limbs mend themselves without significant difficulty in addition to your already-quick healing.  You do not require splints for broken limbs."),
    categories = { "LIZARD" },
    prerequisites = { "FASTHEALER" },
    threshold_requirements = { "THRESH_LIZARD" },
    cancels = { "ROT1", "ROT2", "ROT3" },
    points = 5,
    purifiable = false,
    vitamin_cost = 210,
    flags = { "MEND_ALL" },
    enchantments = { "INLINE_ENCH_REGEN_LIZ_0" },
}

ccb.content.define_mutation {
    id = "BLOODLETTER",
    name = ccb.content.text("Bloodletter"),
    description = ccb.content.text("Your saliva contains powerful anticoagulants.  If you have a bite attack, it will prolong the bleeding of most animals, including humans and the undead.  It may be less effective against insects and stranger creatures."),
    categories = { "CHIROPTERAN" },
    prerequisites = { "HEMOVORE", "BLOODFEEDER" },
    points = 2,
    vitamin_cost = 160,
    flags = { "DRACULIN_VENOM" },
}

ccb.content.define_mutation {
    id = "BLOODFEEDER",
    name = ccb.content.text("Bloodfeeder"),
    description = ccb.content.text("Your craving for blood borders on obsession.  You need the stuff too much to care about whether it came from a human, and your body can filter out most of the toxins in mutant blood."),
    categories = { "CHIROPTERAN" },
    types = { "DIET" },
    prerequisites = { "HEMOVORE" },
    threshold_requirements = { "THRESH_CHIROPTERAN" },
    strict_threshold_requirements = true,
    cancels = { "VEGAN" },
    points = -2,
    mixed_effect = true,
    vitamin_cost = 160,
    flags = { "BLOODFEEDER" },
    vitamin_intervals = { iron = 800, vitC = -600 },
    vitamin_absorption = { blood = { mutant_toxin = 0.25 }, flesh = { mutant_toxin = 0.75 } },
}

ccb.content.define_mutation {
    id = "ECHOLOCATION",
    name = ccb.content.text("Echolocation"),
    description = ccb.content.text("You've learned how to hunt without sight.  Activate this mutation to make a quiet chirp that can reveal obstacles and enemies by its echo."),
    categories = { "CHIROPTERAN" },
    prerequisites = { "BATEARS" },
    threshold_requirements = { "THRESH_CHIROPTERAN" },
    points = 3,
    purifiable = false,
    active = true,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "SLIT_NOSTRILS",
    name = ccb.content.text("Slit Nostrils"),
    description = ccb.content.text("You have a flattened nose and thin slits for nostrils, giving you a lizard-like appearance.  This makes breathing slightly difficult and increases mouth encumbrance by 10."),
    categories = { "LIZARD", "CEPHALOPOD", "RAPTOR", "CHIROPTERAN" },
    replacements = { "LEAFNOSE" },
    points = -2,
    vitamin_cost = 160,
    visibility = 7,
    ugliness = 4,
    enchantments = { "INLINE_ENCH_SLIT_NOSTRILS_0" },
}

ccb.content.define_mutation {
    id = "LEAFNOSE",
    name = ccb.content.text("Leaf Nose"),
    description = ccb.content.text("Your nose is upturned, ridged and flared out into a leaf shape that humans will likely find unsightly.  On the plus side, thermoreceptors in your nostrils allow you to smell heat as long as you can breathe."),
    categories = { "CHIROPTERAN" },
    prerequisites = { "SLIT_NOSTRILS", "BLOODFEEDER" },
    points = 2,
    vitamin_cost = 160,
    ugliness = 3,
    enchantments = { "THERMAL_VISION_LEAFNOSE" },
}

-- A bat mutant is a bit better at hearing overall than someone with GOODHEARING and a CBM.
ccb.content.define_mutation {
    id = "BATEARS",
    name = ccb.content.text("Bat Ears"),
    description = ccb.content.text("Your broad, pointed ears are like radar dishes.  You can hear even the slightest sounds at great distance, and are less likely to be deafened by loud noises."),
    categories = { "CHIROPTERAN" },
    types = { "HEARING", "EARS" },
    prerequisites = { "GOODHEARING" },
    points = 5,
    vitamin_cost = 210,
    visibility = 8,
    ugliness = 2,
    flags = { "HEARING_PROTECTION", "SAFECRACK_NO_TOOL" },
    enchantments = { "INLINE_ENCH_BATEARS_0" },
}

ccb.content.define_mutation {
    id = "FANGS",
    name = ccb.content.text("Fangs"),
    description = ccb.content.text("Your teeth have grown into long, sharp fangs.  If your mouth is uncovered, you'll sometimes bite your enemies."),
    categories = { "LIZARD", "FISH", "LUPINE", "FELINE", "CHIMERA", "CHIROPTERAN", "URSINE", "BEAST" },
    types = { "TEETH" },
    replacements = { "SABER_TEETH", "SHARKTEETH", "FANGS_VAMPIRE" },
    points = 2,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 2,
    integrated_armor = { "integrated_fangs" },
}

ccb.content.define_mutation {
    id = "FANGS_VAMPIRE",
    name = ccb.content.text("Vampire Fangs"),
    description = ccb.content.text("Your teeth are so sharp, you can use them to shave the fur from your victims before you feed.  What's more, anticoagulants in your saliva will keep their blood flowing long after it should have clotted."),
    categories = { "CHIROPTERAN" },
    types = { "TEETH" },
    prerequisites = { "FANGS" },
    threshold_requirements = { "THRESH_CHIROPTERAN" },
    strict_threshold_requirements = true,
    points = 2,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 3,
    integrated_armor = { "integrated_vampire_fangs" },
}

ccb.content.define_mutation {
    id = "ARM_FEATHERS",
    name = ccb.content.text("Feathered Arms"),
    description = ccb.content.text("Your forearms are covered by long, stiff feathers.  While they are impressive to look at and resistant to water and other contaminants, they always get in the way and you hate it when they get filthy."),
    categories = { "RAPTOR", "BIRD" },
    types = { "ARMS" },
    replacements = { "WINGS_BIRD" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 2,
    covered_encumbrance = { arm_feathers_l = 4, arm_feathers_r = 4 },
    enchantments = { "INLINE_ENCH_ARM_FEATHERS_0", "INLINE_ENCH_ARM_FEATHERS_1" },
}

ccb.content.define_mutation {
    id = "LIGHT_BONES",
    name = ccb.content.text("Light Bones"),
    description = ccb.content.text("Your bones are very light.  This enables you to move and attack 10% faster, but also reduces your carrying weight by 20% and makes bashing attacks hurt a little more."),
    categories = { "MOUSE", "RABBIT", "BIRD", "SLIME", "ELFA", "SPIDER", "CHIROPTERAN" },
    types = { "BONES" },
    replacements = { "HOLLOW_BONES" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_LIGHT_BONES_0" },
}

ccb.content.define_mutation {
    id = "HOLLOW_BONES",
    name = ccb.content.text("Hollow Bones"),
    description = ccb.content.text("You have Avian Bone Syndrome--your bones are nearly hollow.  Your body is very light as a result, enabling you to move and attack 20% faster, but also frail; you can carry 40% less, and bashing attacks injure you more."),
    categories = { "BIRD", "SLIME", "ELFA" },
    types = { "BONES" },
    prerequisites = { "LIGHT_BONES" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_HOLLOW_BONES_0" },
}

ccb.content.define_mutation {
    id = "BIRD_EYE",
    name = ccb.content.text("Avian Eyes"),
    description = ccb.content.text("Your vision has become particularly acute: you suspect you could pick out zombies much farther away.  Perception +2, as well as increased vision and reaction limb scores."),
    categories = { "BIRD" },
    types = { "EYES" },
    prerequisites = { "PER_UP_4" },
    threshold_requirements = { "THRESH_BIRD" },
    points = 5,
    vitamin_cost = 210,
    visibility = 1,
    enchantments = { "INLINE_ENCH_BIRD_EYE_0", "INLINE_ENCH_BIRD_EYE_1" },
}

ccb.content.define_mutation {
    id = "GIZZARD",
    name = ccb.content.text("Gizzard"),
    description = ccb.content.text("You seem to get full faster now, and food goes through you more rapidly as well."),
    categories = { "BIRD" },
    prerequisites = { "BEAK", "BEAK_PECK", "BEAK_HUM" },
    secondary_prerequisites = { "LIGHTEATER" },
    threshold_requirements = { "THRESH_BIRD" },
    cancels = { "GOURMAND" },
    points = -5,
    purifiable = false,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_GIZZARD_0" },
}

ccb.content.define_mutation {
    id = "BEAK",
    name = ccb.content.text("Beak"),
    description = ccb.content.text("You have a beak for a mouth.  You can use it to peck at your enemies, but it is impossible for you to wear mouth gear.  Slightly reduces wet effects."),
    categories = { "BIRD", "CEPHALOPOD" },
    types = { "TEETH" },
    replacements = { "BEAK_HUM", "BEAK_PECK" },
    cancels = { "MUZZLE", "MUZZLE_RAT", "MUZZLE_BEAR" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 4,
    destroys_gear = true,
    restricts_gear = { "mouth" },
    wet_protection = { { part = "mouth", ignored = 1 } },
    enchantments = { "INLINE_ENCH_BEAK_0" },
}

ccb.content.define_mutation {
    id = "BEAK_PECK",
    name = ccb.content.text("Woodpecker Beak"),
    description = ccb.content.text("Pecking at prey is part of your daily routine now.  Slightly reduces wet effects."),
    categories = { "BIRD" },
    types = { "TEETH" },
    prerequisites = { "BEAK" },
    threshold_requirements = { "THRESH_BIRD" },
    cancels = { "MOUTH_TENTACLES", "MUZZLE", "MUZZLE_RAT", "MUZZLE_LONG", "MUZZLE_RAPTOR", "MUZZLE_BEAR" },
    points = 0,
    purifiable = false,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 5,
    destroys_gear = true,
    restricts_gear = { "mouth" },
    wet_protection = { { part = "mouth", ignored = 2 } },
    enchantments = { "INLINE_ENCH_BEAK_PECK_0" },
    armor = { { parts = { "head", "beak" }, resistances = { bash = 3 } } },
}

ccb.content.define_mutation {
    id = "BEAK_HUM",
    name = ccb.content.text("Hummingbird Beak"),
    description = ccb.content.text("Though your beak's not suitable for pecking, those flowers out there are a good source of energy.  Examine them to feed."),
    categories = { "BIRD" },
    types = { "TEETH" },
    prerequisites = { "BEAK" },
    threshold_requirements = { "THRESH_BIRD" },
    strict_threshold_requirements = true,
    cancels = { "MOUTH_TENTACLES" },
    points = 0,
    purifiable = false,
    active = true,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 5,
    destroys_gear = true,
    restricts_gear = { "mouth" },
    enchantments = { "INLINE_ENCH_BEAK_HUM_0" },
    wet_protection = { { part = "mouth", ignored = 2 } },
}

ccb.content.define_mutation {
    id = "GASTROPOD_EXTREMITY1",
    name = ccb.content.text("Muscle Consolidation"),
    description = ccb.content.text("Your extremities have gained strength but lost fine motor skills.  -1 Dexterity +2 Strength."),
    categories = { "GASTROPOD" },
    replacements = { "GASTROPOD_EXTREMITY2" },
    points = 1,
    vitamin_cost = 60,
    visibility = 1,
    enchantments = { "INLINE_ENCH_GASTROPOD_EXTREMITY1_0" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_EXTREMITY2",
    name = ccb.content.text("Rasping Tongue"),
    description = ccb.content.text("You've developed an extremely long and mobile tongue capped with teeth.  You may use it to attack your enemies and pull them towards you."),
    categories = { "GASTROPOD" },
    types = { "TONGUE" },
    replacements = { "GASTROPOD_EXTREMITY3" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    cancels = { "FANGS", "MANDIBLES" },
    points = 6,
    active = true,
    vitamin_cost = 210,
    visibility = 1,
    enchantments = { "INLINE_ENCH_GASTROPOD_EXTREMITY2_0" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_EXTREMITY3",
    name = ccb.content.text("Harpoon Tongue"),
    description = ccb.content.text("Your tongue has increased its length and mobility.  You may use it to pull your enemies towards you."),
    categories = { "GASTROPOD" },
    types = { "TONGUE" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    points = 8,
    active = true,
    vitamin_cost = 300,
    visibility = 5,
    ugliness = 5,
    enchantments = { "INLINE_ENCH_GASTROPOD_EXTREMITY3_0" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_FOOT",
    name = ccb.content.text("Gastropod Foot"),
    description = ccb.content.text("Your legs have consolidated into a single muscular 'foot' that goes up into your belly.  You move about a fourth of your previous speed and can no longer wear pants or shoes, on the other hand you make significantly less noise.  In addition to being harder to knock down, you can move through sludge-covered surfaces easily."),
    categories = { "GASTROPOD" },
    types = { "RUNNING", "LEGS", "FEET" },
    prerequisites = { "SLIMY" },
    additions = { "GASTROPOD_BALANCE" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 210,
    visibility = 8,
    ugliness = 9,
    flags = { "SLUDGE_IMMUNE", "TOUGH_FEET" },
    destroys_gear = true,
    restricts_gear = { "leg_l", "leg_r", "foot_l", "foot_r" },
    allowed_item_flags = { "ALLOWS_GASTROPOD_FOOT" },
    enchantments = { "INLINE_ENCH_GASTROPOD_FOOT_0", "INLINE_ENCH_GASTROPOD_FOOT_1" },
}

ccb.content.define_mutation {
    id = "GASTROPOD_BALANCE",
    name = ccb.content.text("Gastropod Balance"),
    description = ccb.content.text("By pushing your whole 'foot' against the ground you are able to move across rough terrain without losing your 'footing'.  You're also able to cling to the ground underwater, allowing you to move along the bottom more easily."),
    categories = { "GASTROPOD" },
    prerequisites = { "GASTROPOD_FOOT" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    points = 1,
    vitamin_cost = 60,
    flags = { "WALK_UNDERWATER" },
}

ccb.content.define_mutation {
    id = "MUCUS_SECRETION",
    name = ccb.content.text("Mucus Secretion"),
    description = ccb.content.text("You once had a significant other call you slimy, now you exemplify that.  It covers everything you come into contact with but now you can move through slime you didn't create with ease."),
    categories = { "GASTROPOD" },
    prerequisites = { "GASTROPOD_FOOT" },
    additions = { "MUCUS_SECRETION2" },
    replacements = { "SNAIL_TRAIL" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    points = 1,
    vitamin_cost = 80,
    visibility = 2,
    ugliness = 2,
    flags = { "IRRITANT_IMMUNE" },
}

ccb.content.define_mutation {
    id = "MUCUS_SECRETION2",
    name = ccb.content.text("Acidic Secretion"),
    description = ccb.content.text("Your mucus has developed an acidic component that seems to soften your prey up.  When attacking unarmed, sometimes your slime will hit your target as well."),
    categories = { "GASTROPOD" },
    prerequisites = { "MUCUS_SECRETION" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    points = 3,
    vitamin_cost = 160,
    visibility = 2,
    ugliness = 2,
    flags = { "IRRITANT_IMMUNE" },
    enchantments = { "INLINE_ENCH_MUCUS_SECRETION2_0" },
}

ccb.content.define_mutation {
    id = "SNAIL_TRAIL",
    name = ccb.content.text("Snail Trail"),
    description = ccb.content.text("You've developed some ability to control your slime emissions.  As a result of this you can leave trails of slime anywhere you walk."),
    categories = { "GASTROPOD" },
    prerequisites = { "MUCUS_SECRETION" },
    points = 3,
    active = true,
    cooldown = "100 s",
    cost = 174,
    vitamin_cost = 160,
    consumes_calories = true,
    consumes_water = true,
    visibility = 4,
    ugliness = 4,
    flags = { "IRRITANT_IMMUNE" },
}
