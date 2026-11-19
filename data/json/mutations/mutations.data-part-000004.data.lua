local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SHELL",
    name = ccb.content.text("Shell"),
    description = ccb.content.text("You have grown a thick shell over your torso, providing excellent armor, but you cannot wear anything on your torso.  Somewhat reduces wet effects."),
    categories = { "CEPHALOPOD", "GASTROPOD" },
    types = { "TORSO_ARMOR" },
    prerequisites = { "CHITIN", "THICKSKIN" },
    replacements = { "SHELL2" },
    cancels = { "CHITIN3" },
    points = 0,
    vitamin_cost = 210,
    visibility = 8,
    ugliness = 3,
    integrated_armor = { "integrated_shell" },
    wet_protection = { { part = "torso", ignored = 26 } },
}

ccb.content.define_mutation {
    id = "SHELL2",
    name = ccb.content.text("Roomy Shell"),
    description = ccb.content.text("Your protective shell has grown large enough to accommodate--if need be--your whole body.  Activate to pull your head and limbs into your shell, trading mobility and vision for warmth and shelter."),
    categories = { "CEPHALOPOD", "GASTROPOD" },
    types = { "TORSO_ARMOR" },
    prerequisites = { "SHELL" },
    replacements = { "SHELL3" },
    threshold_requirements = { "THRESH_CEPHALOPOD", "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    points = 0,
    mixed_effect = true,
    active = true,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 3,
    comfort = {
        {
            conditions = { { kind = "trait", id = "SHELL2", active = true } },
            comfort = "sleep_aid",
            add_sleep_aids = true,
        },
    },
    body_temperature = { 500, 750 },
    integrated_armor = { "integrated_shell2" },
    enchantments = { "INLINE_ENCH_SHELL2_0" },
    wet_protection = { { part = "torso", ignored = 26 } },
}

ccb.content.define_mutation {
    id = "SHELL3",
    name = ccb.content.text("Nacreous Shell"),
    description = ccb.content.text("Your protective shell has developed increased strength and hardness and a mother of pearl sheen."),
    categories = { "GASTROPOD" },
    types = { "TORSO_ARMOR" },
    prerequisites = { "SHELL2" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    strict_threshold_requirements = true,
    points = 0,
    mixed_effect = true,
    active = true,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = -2,
    comfort = {
        {
            conditions = { { kind = "trait", id = "SHELL3", active = true } },
            comfort = "sleep_aid",
            add_sleep_aids = true,
        },
    },
    integrated_armor = { "integrated_shell3" },
    wet_protection = { { part = "torso", ignored = 45 } },
}

ccb.content.define_mutation {
    id = "EYEBULGE",
    name = ccb.content.text("Bulging Eyes"),
    description = ccb.content.text("Your eyes bulge out several inches from your skull.  This does not affect your vision in any way."),
    categories = { "BATRACHIAN", "INSECT", "GASTROPOD", "FISH", "CRUSTACEAN" },
    types = { "EYES" },
    additions = { "MEMBRANE" },
    replacements = { "COMPOUND_EYES", "EYESTALKS1", "FROG_EYES" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    visibility = 8,
    ugliness = 4,
    enchantments = { "INLINE_ENCH_EYEBULGE_0" },
}

ccb.content.define_mutation {
    id = "EYESTALKS1",
    name = ccb.content.text("Intermediate Eyestalks"),
    description = ccb.content.text("Your eyes barely protrude from your head on tentacles, preventing the use of any rigid eyewear.  On the plus side, you can have additional awareness, but sometimes your vision goes wonky as your brain tries to process the new angles."),
    categories = { "GASTROPOD", "CRUSTACEAN" },
    types = { "EYES" },
    replacements = { "EYESTALKS2", "EYESTALKS_RIGID" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 5,
    allow_soft_gear = true,
    restricts_gear = { "eyes" },
    enchantments = { "INLINE_ENCH_EYESTALKS1_0" },
}

ccb.content.define_mutation {
    id = "EYESTALKS2",
    name = ccb.content.text("Eyestalks"),
    description = ccb.content.text("Your eyes protrude from your head on flexible tentacles, preventing the use of any eyewear.  On the plus side, you can see in two directions at once, and they automatically retract to reduce damage."),
    categories = { "GASTROPOD" },
    threshold_requirements = { "THRESH_GASTROPOD" },
    types = { "EYES" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 8,
    purifiable = false,
    restricts_gear = { "eyes" },
    armor = { { parts = { "eyes_snail_good" }, resistances = { cut = 3, bash = 1 } } },
    enchantments = { "INLINE_ENCH_EYESTALKS2_0" },
}

ccb.content.define_mutation {
    id = "EYESTALKS_RIGID",
    name = ccb.content.text("Rigid Eyestalks"),
    description = ccb.content.text("You have compound eyes on rigid stalks that can fold back against your head to protect them from danger.  This gives you better all-around vision and allows you to see underwater, but interferes with eyewear.  Your vision and reaction limb scores are also increased."),
    categories = { "CRUSTACEAN" },
    types = { "EYES" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    visibility = 8,
    ugliness = 8,
    allow_soft_gear = true,
    restricts_gear = { "eyes" },
    enchantments = { "INLINE_ENCH_EYESTALKS_RIGID_0" },
}

ccb.content.define_mutation {
    id = "FROG_EYES",
    name = ccb.content.text("Frog Eyes"),
    description = ccb.content.text("Your eyes bulge noticeably out of your face, and you are able to move them much more freely than before.  You can see movement and close objects clearly, but you have trouble picking up distant details in the light.  Instead of eyelids they are covered by a translucent, protective membrane that blocks irritants and water.  It allows you to sleep with your eyes open!  Activate to cause the approach of hostile creatures to wake you up."),
    categories = { "BATRACHIAN" },
    types = { "EYES", "VISION" },
    prerequisites = { "EYEBULGE" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    cancels = { "MEMBRANE", "MYOPIC", "URSINE_EYE", "MESOPIC" },
    points = 0,
    active = true,
    vitamin_cost = 60,
    visibility = 8,
    ugliness = 4,
    armor = { { parts = { "eyes" }, resistances = { cut = 3, bash = 1 } } },
    wet_protection = { { part = "eyes", neutral = 1 } },
    enchantments = { "INLINE_ENCH_FROG_EYES_0" },
}

ccb.content.define_mutation {
    id = "PHEROMONE_AMPHIBIAN",
    name = ccb.content.text("Amphibian Pheromones"),
    description = ccb.content.text("Your body produces low-level pheromones, identifying you as a friend to many species of amphibian.  Amphibians will attack you much less."),
    categories = { "BATRACHIAN" },
    types = { "PHEROMONE" },
    prerequisites = { "SMELLY2" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    points = 2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "WIDE_MOUTH",
    name = ccb.content.text("Wide Mouth"),
    description = ccb.content.text("You have an unsettlingly wide mouth, like a frog.  This looks hideous, but allows you to swallow your food whole."),
    categories = { "BATRACHIAN" },
    types = { "MUZZLE" },
    points = 0,
    mixed_effect = true,
    vitamin_cost = 60,
    visibility = 8,
    ugliness = 8,
    enchantments = { "INLINE_ENCH_WIDE_MOUTH_0" },
    wet_protection = { { part = "mouth", good = 6 } },
}

ccb.content.define_mutation {
    id = "LONG_TONGUE",
    name = ccb.content.text("Lolling Tongue"),
    description = ccb.content.text("Your tongue has lengthened and often extends far beyond your mouth.  This has no effect."),
    categories = { "BATRACHIAN" },
    types = { "TONGUE" },
    replacements = { "LONG_TONGUE2" },
    points = 0,
    visibility = 1,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "LONG_TONGUE2",
    name = ccb.content.text("Whipping Tongue"),
    description = ccb.content.text("You've developed an extremely long and mobile tongue.  You may use it to pull your enemies towards you."),
    categories = { "BATRACHIAN" },
    types = { "TONGUE" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    strict_threshold_requirements = true,
    points = 3,
    active = true,
    vitamin_cost = 160,
    visibility = 1,
}

-- Create an effect on condition that reduces nausea quickly whenever it occurs by one intensity per vomit?
ccb.content.define_mutation {
    id = "VOMITSTOMACH",
    name = ccb.content.text("Stomach Cleanse"),
    description = ccb.content.text("You have gained the ability to invert your stomach outside your body to quickly eliminate toxins, and are more likely to throw up from food poisoning, alcohol, etc.  If you throw up because of this, you won't suffer any residual nausea."),
    categories = { "BATRACHIAN" },
    types = { "CONSTITUTION" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    points = 1,
    starting_trait = false,
    vitamin_cost = 60,
    enchantments = { "INLINE_ENCH_VOMITSTOMACH_0" },
}

ccb.content.define_mutation {
    id = "DIRTSLEEPER",
    name = ccb.content.text("Earth Sleeper"),
    description = ccb.content.text("You always sleep better surrounded by earth."),
    categories = { "BATRACHIAN" },
    threshold_requirements = { "THRESH_BATRACHIAN" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_DIRTSLEEPER_0" },
}

ccb.content.define_mutation {
    id = "STRONGKNEES",
    name = ccb.content.text("Strong Knees"),
    description = ccb.content.text("Your knees are strong and capable of angles that you couldn't imagine previously.  Moving over rough terrain will slow you down less than normal."),
    categories = { "BATRACHIAN" },
    cancels = { "BADKNEES", "REALLYBADKNEES" },
    points = 1,
    enchantments = { "INLINE_ENCH_STRONGKNEES_0" },
}

ccb.content.define_mutation {
    id = "AMPHIBIAN",
    name = ccb.content.text("Amphibious"),
    description = ccb.content.text("You're as comfortable in water as on land, and your body has adapted around that fact.  Your base swimming speed is greatly increased, and weight will hinder you much less while swimming."),
    categories = { "FISH", "BATRACHIAN" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN" },
    strict_threshold_requirements = true,
    points = 5,
    purifiable = false,
    vitamin_cost = 210,
    enchantments = { "INLINE_ENCH_AMPHIBIAN_0" },
}

ccb.content.define_mutation {
    id = "WATERSLEEP",
    name = ccb.content.text("Aqueous Repose"),
    description = ccb.content.text("Falling asleep underwater is easy for you, and you spend less time asleep when you rest there.  You can also eat underwater, though you can't drink."),
    categories = { "FISH", "BATRACHIAN", "CEPHALOPOD" },
    prerequisites = { "SEESLEEP", "FROG_EYES", "GILLS_CEPH" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN", "THRESH_CEPHALOPOD" },
    strict_threshold_requirements = true,
    points = 1,
    vitamin_cost = 60,
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
    id = "WATERSLEEPER",
    name = ccb.content.text("Aquatic Sleeper"),
    description = ccb.content.text("You always sleep better underwater."),
    categories = { "BATRACHIAN", "FISH" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN" },
    points = 2,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_WATERSLEEPER_0" },
}

ccb.content.define_mutation {
    id = "FRESHWATEROSMOSIS",
    name = ccb.content.text("Freshwater Osmosis"),
    description = ccb.content.text("Your gills and skin are highly permeable to moisture, and you can hydrate your body through osmosis.  While submerged in fresh water, any thirst you might have will be slaked."),
    categories = { "FISH", "BATRACHIAN" },
    prerequisites = { "GILLS" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN" },
    strict_threshold_requirements = true,
    points = 4,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "ELECTRORECEPTORS",
    name = ccb.content.text("Electroreceptors"),
    description = ccb.content.text("A network of jelly-filled electroreceptors, like that of a shark, have grown throughout your face and nose.  They are very sensitive to magnetic fields, allowing you to see robots and creatures charged with electricity through walls, but being shocked will seriously mess you up."),
    categories = { "FISH" },
    points = 2,
    mixed_effect = true,
    vitamin_cost = 160,
    enchantments = { "ELECTRIC_VISION", "INLINE_ENCH_ELECTRORECEPTORS_1" },
}

ccb.content.define_mutation {
    id = "MEMBRANE",
    name = ccb.content.text("Nictitating Membrane"),
    description = ccb.content.text("You have a set of clear lenses which lower over your eyes while underwater, allowing you to see as though you were wearing goggles.  Slightly decreases wet penalties."),
    categories = { "LIZARD", "FISH" },
    points = 1,
    vitamin_cost = 60,
    visibility = 1,
    ugliness = 2,
    flags = { "EYE_MEMBRANE" },
    wet_protection = { { part = "eyes", neutral = 1 } },
}

ccb.content.define_mutation {
    id = "SEESLEEP",
    name = ccb.content.text("Lidless Eyes"),
    description = ccb.content.text("Like a true fish, your eyes lack eyelids, and are instead covered by a translucent, protective membrane that blocks irritants and water, and provides minor armor.  It also allows you to sleep with your eyes open!  Activate to cause the approach of hostile creatures to wake you up."),
    categories = { "FISH" },
    threshold_requirements = { "THRESH_FISH" },
    strict_threshold_requirements = true,
    points = 2,
    active = true,
    vitamin_cost = 160,
    visibility = 3,
    ugliness = 4,
    flags = { "EYE_MEMBRANE", "SEESLEEP" },
    armor = { { parts = { "eyes" }, resistances = { cut = 3, bash = 1 } } },
}

ccb.content.define_mutation {
    id = "GILLS",
    name = ccb.content.text("Gills"),
    description = ccb.content.text("You've grown a set of gills in your neck, allowing you to breathe underwater.  Slightly increases wet benefits."),
    categories = { "FISH", "BATRACHIAN", "CRUSTACEAN" },
    types = { "GILLS" },
    threshold_requirements = { "THRESH_FISH", "THRESH_BATRACHIAN", "THRESH_CRUSTACEAN" },
    points = 2,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 3,
    flags = { "GILLS" },
    wet_protection = { { part = "head", good = 1 } },
}

ccb.content.define_mutation {
    id = "SHARKTEETH",
    name = ccb.content.text("Shark Teeth"),
    description = ccb.content.text("Your teeth have grown incredibly sharp, and have calcified even further.  In addition to letting you eat much faster, you can use them as a lethal natural weapon, as long as your anatomy favors it.  They also grow very fast, and you harmlessly shed them more or less at random."),
    categories = { "FISH" },
    types = { "TEETH" },
    prerequisites = { "FANGS" },
    threshold_requirements = { "THRESH_FISH" },
    points = 3,
    purifiable = false,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 8,
    social_modifiers = { intimidate = 5 },
    integrated_armor = { "integrated_shark_teeth" },
    enchantments = { "INLINE_ENCH_SHARKTEETH_0" },
}

ccb.content.define_mutation {
    id = "TOXICFLESH",
    name = ccb.content.text("Toxic Flesh"),
    description = ccb.content.text("Your flesh is highly poisonous, and creatures that bite you will receive a nasty surprise."),
    categories = { "FISH", "GASTROPOD" },
    threshold_requirements = { "THRESH_FISH", "THRESH_GASTROPOD" },
    points = 1,
    purifiable = false,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "CEPH_EYES",
    name = ccb.content.text("Cephalopod Eyes"),
    description = ccb.content.text("Your eyes still bulge, yet your pupils look different somehow.  Water doesn't seem to cause any trouble at all, though."),
    categories = { "CEPHALOPOD" },
    types = { "EYES" },
    additions = { "CEPH_VISION" },
    points = 1,
    vitamin_cost = 60,
    visibility = 8,
    ugliness = 5,
    flags = { "EYE_MEMBRANE" },
}

ccb.content.define_mutation {
    id = "CEPH_VISION",
    name = ccb.content.text("Cephalopod Vision"),
    description = ccb.content.text("Your brain has caught up with your eyes.  You can see much better in the dark, but sunlight seems much brighter now.  Activate to toggle NV-visible areas on or off."),
    categories = { "CEPHALOPOD" },
    types = { "VISION" },
    prerequisites = { "CEPH_EYES" },
    points = 3,
    active = true,
    starts_active = true,
    vitamin_cost = 160,
    enchantments = { "INLINE_ENCH_CEPH_VISION_0" },
    cancels = { "NIGHTVISION", "NIGHTVISION2", "NIGHTVISION3" },
}

ccb.content.define_mutation {
    id = "CEPH_MIND",
    name = ccb.content.text("Cephalopod Mind"),
    description = ccb.content.text("Your mind has been altered in such a way that you now find it very difficult to understand humans.  Your capability to persuade and lie to them suffers slightly, even if it is mitigated by your intelligence.  In addition, while you find it much easier to learn by doing now, the plasticity of your psyche means you forget skills much faster."),
    categories = { "CEPHALOPOD" },
    types = { "HUMAN_EMPATHY" },
    prerequisites = { "INT_UP_4" },
    threshold_requirements = { "THRESH_CEPHALOPOD" },
    strict_threshold_requirements = true,
    cancels = { "TRUTHTELLER", "LIAR", "SLOWLEARNER", "FASTLEARNER" },
    points = 5,
    purifiable = false,
    vitamin_cost = 210,
    social_modifiers = { lie = -5, persuade = -5 },
    enchantments = { "INLINE_ENCH_CEPH_MIND_0" },
}

ccb.content.define_mutation {
    id = "INTERSTICE_MIND",
    name = ccb.content.text("Apathy of the Outer Dark"),
    description = ccb.content.text("Your mind has been altered in such a way that you now find it very difficult to relate to or understand humans, the things they know, and the things they care about.  You are no longer bothered by much, but your ability to persuade, lie, and retain human knowledge is diminished."),
    categories = { "INTERSTICE" },
    types = { "HUMAN_EMPATHY" },
    prerequisites = { "NUMB" },
    threshold_requirements = { "THRESH_INTERSTICE" },
    strict_threshold_requirements = true,
    mixed_effect = true,
    cancels = { "TRUTHTELLER", "LIAR", "SLOWLEARNER", "FASTLEARNER" },
    points = -1,
    purifiable = false,
    vitamin_cost = 210,
    social_modifiers = { lie = -5, persuade = -5 },
    enchantments = { "INLINE_ENCH_INTERSTICE_MIND_0" },
    flags = { "NUMB" },
}

ccb.content.define_mutation {
    id = "GILLS_CEPH",
    name = ccb.content.text("Cephalopod Gills"),
    description = ccb.content.text("You've grown a set of gills, running from your neck up behind your ears.  They allow you to breathe underwater and slightly increase wet benefits."),
    categories = { "CEPHALOPOD" },
    types = { "GILLS" },
    threshold_requirements = { "THRESH_CEPHALOPOD" },
    points = 2,
    vitamin_cost = 160,
    visibility = 4,
    ugliness = 4,
    flags = { "GILLS" },
    wet_protection = { { part = "head", good = 1 } },
}

ccb.content.define_mutation {
    id = "INK_GLANDS",
    name = ccb.content.text("Ink Glands"),
    description = ccb.content.text("Several ink glands have developed in your gill structure.  When active, they will spray defensive ink and blind an attacker in an emergency."),
    categories = { "CEPHALOPOD" },
    prerequisites = { "GILLS_CEPH" },
    threshold_requirements = { "THRESH_CEPHALOPOD" },
    points = 1,
    active = true,
    starts_active = true,
    vitamin_cost = 60,
    visibility = 1,
    ugliness = 1,
    enchantments = { "INLINE_ENCH_INK_GLANDS_0" },
}

ccb.content.define_mutation {
    id = "MOUTH_FLAPS",
    name = ccb.content.text("Mouth Flaps"),
    description = ccb.content.text("Skin tabs and odd flaps of skin surround your mouth.  They don't affect your eating, but are unpleasant to look at."),
    categories = { "CHIMERA", "CEPHALOPOD", "INSECT", "SPIDER" },
    types = { "MUZZLE" },
    replacements = { "MOUTH_TENTACLES", "MANDIBLES" },
    points = -1,
    vitamin_cost = 60,
    visibility = 7,
    ugliness = 6,
}

ccb.content.define_mutation {
    id = "MOUTH_TENTACLES",
    name = ccb.content.text("Mouth Tentacles"),
    description = ccb.content.text("A set of tentacles surrounds your mouth.  They allow you to eat twice as fast.  Slightly decreases wet penalties."),
    categories = { "CEPHALOPOD" },
    types = { "MUZZLE" },
    prerequisites = { "MOUTH_FLAPS" },
    points = 1,
    vitamin_cost = 70,
    visibility = 8,
    ugliness = 5,
    enchantments = { "INLINE_ENCH_MOUTH_TENTACLES_0" },
    wet_protection = { { part = "mouth", neutral = 4 } },
}

-- Increases the lumination the more you hunger (max hunger = 300, max lumination when you hunger = 30, ie 3 tile of light), and the more you happy (1 tile of lumination for each +10 morale, negative morage excluded)
ccb.content.define_mutation {
    id = "BIOLUM0",
    name = ccb.content.text("Reflex Photophore"),
    description = ccb.content.text("A photophore has grown from your head.  You can't consciously control it, and it might start to shine in response to your emotions or your physiological state."),
    categories = { "ELFA", "INSECT", "FISH" },
    types = { "BIOLUM" },
    replacements = { "BIOLUM1" },
    points = -1,
    vitamin_cost = 60,
    covered_encumbrance = { head = 5 },
    enchantments = { "INLINE_ENCH_BIOLUM0_0" },
}

ccb.content.define_mutation {
    id = "BIOLUM1",
    name = ccb.content.text("Weak Photophore"),
    description = ccb.content.text("A photophore has grown from your head; you can make it glow softly.  This will make you very visible in the dark, ideal for attracting a partner during mating season."),
    categories = { "ELFA", "INSECT", "FISH" },
    types = { "BIOLUM" },
    prerequisites = { "BIOLUM0" },
    replacements = { "BIOLUM2" },
    points = 2,
    active = true,
    cooldown = "225 h",
    cost = 9,
    vitamin_cost = 160,
    consumes_calories = true,
    covered_encumbrance = { head = 5 },
    transform = {
        target = "BIOLUM1_active",
        message = ccb.content.text("Your photophore starts glowing."),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "BIOLUM1_active",
    copy_from = "BIOLUM1",
    name = ccb.content.text("Weak Photophore (on)"),
    description = ccb.content.text("Your photophore is glowing softly."),
    valid = false,
    body_light = { head = 8 },
    transform = {
        target = "BIOLUM1",
        message = ccb.content.text("Your photophore stops glowing."),
        active = false,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "BIOLUM2",
    name = ccb.content.text("Photophore"),
    description = ccb.content.text("You can make your photophore glow brightly."),
    categories = { "ELFA", "INSECT", "FISH" },
    types = { "BIOLUM" },
    prerequisites = { "BIOLUM1" },
    additions = { "BIOLUM3" },
    points = 3,
    active = true,
    cooldown = "112 h 30 m",
    cost = 9,
    vitamin_cost = 160,
    consumes_calories = true,
    covered_encumbrance = { head = 5 },
    transform = {
        target = "BIOLUM2_active",
        message = ccb.content.text("Your photophore starts glowing."),
        active = true,
        moves = 10,
    },
}

ccb.content.define_mutation {
    id = "BIOLUM2_active",
    copy_from = "BIOLUM2",
    name = ccb.content.text("Photophore (on)"),
    description = ccb.content.text("You photophore is glowing brightly."),
    valid = false,
    body_light = { head = 20 },
    transform = {
        target = "BIOLUM2",
        message = ccb.content.text("Your photophore stops glowing."),
        active = false,
        moves = 10,
    },
}
