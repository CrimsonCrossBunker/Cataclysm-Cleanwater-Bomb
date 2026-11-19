local ccb = require("ccb")

ccb.content.define_mutation {
    id = "INSECT_RESERVOIR",
    name = ccb.content.text("Bulging Reservoir"),
    description = ccb.content.text("You develop a reservoir of fluids that bulges out of your abdomen.  Your body has adapted to containing extra liquids in event of shortfalls."),
    categories = { "INSECT" },
    types = { "THIRST" },
    additions = { "BOMBADIER_BLAST" },
    points = 0,
    vitamin_cost = 60,
    visibility = 4,
    ugliness = 3,
    enchantments = { "INLINE_ENCH_INSECT_RESERVOIR_0" },
}

ccb.content.define_mutation {
    id = "BOMBADIER_BLAST",
    name = ccb.content.text("Bombardier Beetle Blast"),
    description = ccb.content.text("You have an ability to spray boiling water on your enemies at melee distance.  This will drastically increase your thirst.  Without an extra reservoir you would quickly dehydrate yourself."),
    categories = { "INSECT" },
    prerequisites = { "INSECT_RESERVOIR" },
    threshold_requirements = { "THRESH_INSECT" },
    points = 5,
    active = true,
    cost = 95,
    vitamin_cost = 210,
    consumes_water = true,
    visibility = 1,
    ugliness = 2,
    attacks = {
        {
            player_message = ccb.content.text("You spray %s with a boiling chemical mixture!"),
            npc_message = ccb.content.text("%1$s sprays %2$s with a boiling chemical mixture!"),
            body_part = "torso",
            chance = 15,
            base_damage = { type = "heat", amount = 15 },
            strength_damage = { type = "heat", amount = 2 },
        },
    },
}

ccb.content.define_mutation {
    id = "PHEROMONE_INSECT",
    name = ccb.content.text("Insect Pheromones"),
    description = ccb.content.text("Your body produces low-level pheromones, identifying you as a friend to many species of insects.  Insects will attack you much less."),
    categories = { "INSECT" },
    types = { "PHEROMONE" },
    prerequisites = { "SMELLY2" },
    threshold_requirements = { "THRESH_INSECT" },
    points = 2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "COMPOUND_EYES",
    name = ccb.content.text("Compound Eyes"),
    description = ccb.content.text("Your eyes are compound, like those of an insect.  This increases your reaction time, but your fine detailed vision isn't as acute."),
    categories = { "INSECT" },
    types = { "EYES" },
    prerequisites = { "EYEBULGE" },
    points = 2,
    vitamin_cost = 160,
    visibility = 9,
    ugliness = 5,
    restricts_gear = { "eyes" },
    enchantments = { "INLINE_ENCH_COMPOUND_EYES_0" },
}

ccb.content.define_mutation {
    id = "ANTENNAE",
    name = ccb.content.text("Antennae"),
    description = ccb.content.text("You have a pair of antennae.  They allow you to detect the presence of monsters up to a few tiles away, even if you can't see or hear them, but prevent wearing headwear that is not made of fabric."),
    categories = { "INSECT" },
    types = { "HORNS" },
    prerequisites = { "HEADBUMPS" },
    points = 1,
    active = true,
    starts_active = true,
    vitamin_cost = 60,
    visibility = 9,
    ugliness = 4,
    allow_soft_gear = true,
    restricts_gear = { "head_crown" },
    enchantments = { "INLINE_ENCH_ANTENNAE_0" },
}

ccb.content.define_mutation {
    id = "MANDIBLES",
    name = ccb.content.text("Mandibles"),
    description = ccb.content.text("A set of insect-like mandibles have grown around your mouth.  They allow you to eat faster and provide a slicing unarmed attack.  Slightly reduces wet effects."),
    categories = { "INSECT", "SPIDER" },
    types = { "TEETH", "MUZZLE" },
    prerequisites = { "MOUTH_FLAPS" },
    additions = { "PROBOSCIS" },
    replacements = { "FANGS_SPIDER" },
    points = 1,
    mixed_effect = true,
    vitamin_cost = 90,
    visibility = 8,
    ugliness = 6,
    provided_qualities = { BUTCHER = 4 },
    integrated_armor = { "integrated_mandibles" },
    enchantments = { "INLINE_ENCH_MANDIBLES_0" },
    wet_protection = { { part = "mouth", ignored = 1 } },
}

ccb.content.define_mutation {
    id = "PROBOSCIS",
    name = ccb.content.text("Proboscis"),
    description = ccb.content.text("You've gotten rid of that terribly imprecise mouth and now imbibe your food like a proper person.  Chewing was tiresome anyway."),
    categories = { "INSECT" },
    prerequisites = { "MANDIBLES" },
    secondary_prerequisites = { "CHITIN", "CHITIN2", "CHITIN2_MOLTED" },
    points = -4,
    purifiable = false,
    active = true,
    vitamin_cost = 160,
    visibility = 5,
    ugliness = 7,
    restricts_gear = { "mouth" },
    enchantments = { "INLINE_ENCH_PROBOSCIS_0" },
}

ccb.content.define_mutation {
    id = "CF_HAIR",
    name = ccb.content.text("Urticating Hairs"),
    description = ccb.content.text("Significant amounts of your hairs have loosened.  If some creature tries to attack you, your assailant is quite likely to get fine, bristly chitin in an irritating spot; it doesn't carry your venom but it will be distracting."),
    categories = { "SPIDER" },
    prerequisites = { "CHITIN3", "CHITIN3_MOLTED" },
    threshold_requirements = { "THRESH_SPIDER" },
    points = 3,
    vitamin_cost = 160,
    visibility = 1,
    ugliness = 1,
}

ccb.content.define_mutation {
    id = "FANGS_SPIDER",
    name = ccb.content.text("Folding Fangs"),
    description = ccb.content.text("You have developed deadly extensible fangs, allowing you to bite quickly or ensure your venom goes home, as desired."),
    categories = { "SPIDER" },
    types = { "TEETH", "MUZZLE" },
    prerequisites = { "MANDIBLES" },
    secondary_prerequisites = { "POISONOUS", "POISONOUS2" },
    cancels = { "MOUTH_TENTACLES" },
    points = 2,
    vitamin_cost = 120,
    visibility = 6,
    ugliness = 6,
    integrated_armor = { "integrated_fangs_spider" },
    enchantments = { "INLINE_ENCH_FANGS_SPIDER_0" },
    wet_protection = { { part = "mouth", ignored = 1 } },
}

ccb.content.define_mutation {
    id = "POISONOUS",
    name = ccb.content.text("Venomous"),
    description = ccb.content.text("Your body produces a potent venom.  Cutting or stabbing attacks from mutations have a chance to poison your target."),
    categories = { "SLIME", "TROGLOBITE", "SPIDER", "CEPHALOPOD", "GASTROPOD", "CHIMERA", "BATRACHIAN" },
    prerequisites = { "POISRESIST" },
    replacements = { "POISONOUS2" },
    points = 1,
    vitamin_cost = 60,
}

ccb.content.define_mutation {
    id = "POISONOUS2",
    name = ccb.content.text("Strongly Venomous"),
    description = ccb.content.text("Your venom has become particularly strong.  You're confident that your bites or other cutting/stabbing natural attacks will take your target down quickly."),
    categories = { "SPIDER" },
    prerequisites = { "POISONOUS" },
    threshold_requirements = { "THRESH_SPIDER" },
    points = 2,
    vitamin_cost = 160,
}

ccb.content.define_mutation {
    id = "WEB_WALKER",
    name = ccb.content.text("Web Walker"),
    description = ccb.content.text("Your body excretes very fine amounts of a chemical which prevents you from sticking to webs.  Walking through webs does not affect you at all."),
    categories = { "SPIDER" },
    additions = { "WEB_WEAVER" },
    points = 1,
    vitamin_cost = 60,
    comfort = {
        {
            conditions = {
                { kind = "field", id = "fd_web", intensity = 3 },
                { kind = "trait", id = "WEB_SPINNER", invert = true },
                { kind = "trait", id = "WEB_WEAVER", invert = true },
            },
            comfort = "sleep_aid",
            use_better_comfort = true,
            add_sleep_aids = true,
            try_message = {
                text = ccb.content.text_without_extraction("These thick webs support your weight, and are strangely comfortable…"),
                rating = "good",
            },
        },
        {
            conditions = {
                { kind = "field", id = "fd_web" },
                { kind = "trait", id = "WEB_SPINNER", invert = true },
                { kind = "trait", id = "WEB_WEAVER", invert = true },
            },
            add_human_comfort = true,
            add_sleep_aids = true,
            try_message = {
                text = ccb.content.text_without_extraction("You try to sleep, but the webs get in the way.  You brush them aside."),
                rating = "info",
            },
        },
    },
    flags = { "WEBWALK" },
}

ccb.content.define_mutation {
    id = "WEB_SPINNER",
    name = ccb.content.text("Web Spinner"),
    description = ccb.content.text("Your body produces and anchors webbing.  Too bad you can't seem to control the process.  There is a chance that you will leave webs in your wake."),
    categories = { "SPIDER" },
    types = { "SECRETION" },
    prerequisites = { "WEB_WALKER" },
    replacements = { "WEB_WEAVER" },
    threshold_requirements = { "THRESH_SPIDER" },
    strict_threshold_requirements = true,
    points = -3,
    vitamin_cost = 160,
    comfort = {
        {
            conditions = { { kind = "field", id = "fd_web", intensity = 3, invert = true } },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("You try to sleep, but you feel exposed and your spinnerets keep twitching."),
                rating = "bad",
            },
            hint_message = {
                text = ccb.content.text_without_extraction("Maybe a nice thick web would help you sleep."),
                rating = "info",
            },
        },
        {
            conditions = { { kind = "field", id = "fd_web", intensity = 3 } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You relax into your web."),
                rating = "good",
            },
        },
    },
}

ccb.content.define_mutation {
    id = "WEB_WEAVER",
    name = ccb.content.text("Web Weaver"),
    description = ccb.content.text("You've developed the necessary anatomy and techniques to control your web-generation.  Activate this to start or stop weaving webs."),
    categories = { "SPIDER" },
    types = { "SECRETION" },
    prerequisites = { "WEB_SPINNER" },
    additions = { "WEB_RAPPEL", "WEB_ROPE" },
    threshold_requirements = { "THRESH_SPIDER" },
    strict_threshold_requirements = true,
    points = 2,
    active = true,
    cooldown = "100 s",
    cost = 69,
    vitamin_cost = 160,
    consumes_calories = true,
    consumes_water = true,
    comfort = {
        {
            conditions = { { kind = "field", id = "fd_web", intensity = 3, invert = true } },
            comfort = "impossible",
            try_message = {
                text = ccb.content.text_without_extraction("You try to sleep, but you feel exposed and your spinnerets keep twitching."),
                rating = "bad",
            },
            hint_message = {
                text = ccb.content.text_without_extraction("Maybe a nice thick web would help you sleep."),
                rating = "info",
            },
        },
        {
            conditions = { { kind = "field", id = "fd_web", intensity = 3 } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("You relax into your web."),
                rating = "good",
            },
        },
    },
}

ccb.content.define_mutation {
    id = "WEB_RAPPEL",
    name = ccb.content.text("Web Diver"),
    description = ccb.content.text("Your webbing is strong enough to support your weight.  Activate to rappel down any drop you encounter, at the cost of nutrition."),
    categories = { "SPIDER" },
    prerequisites = { "WEB_WEAVER" },
    threshold_requirements = { "THRESH_SPIDER" },
    strict_threshold_requirements = true,
    points = 2,
    active = true,
    cost = 95,
    vitamin_cost = 160,
    consumes_calories = true,
    active_flags = { "WEB_RAPPEL" },
}

ccb.content.define_mutation {
    id = "WEB_ROPE",
    name = ccb.content.text("Rope Webs"),
    description = ccb.content.text("With spinnerets like THESE, who needs rope?!  Activate to produce rope."),
    categories = { "SPIDER" },
    prerequisites = { "WEB_WEAVER" },
    threshold_requirements = { "THRESH_SPIDER" },
    points = 3,
    active = true,
    cost = 260,
    vitamin_cost = 160,
    consumes_calories = true,
    consumes_water = true,
    spawn_item = { item = "rope_30", message = ccb.content.text("You spin a rope from your silk.") },
}

ccb.content.define_mutation {
    id = "ROT1",
    name = ccb.content.text("Weakening"),
    description = ccb.content.text("You feel as though you are slowly weakening and your body heals slower."),
    categories = { "ELFA", "CHIMERA", "ALPHA" },
    types = { "HEALING" },
    replacements = { "ROT2" },
    points = -2,
    vitamin_cost = 160,
    body_temperature = { -250, -250 },
    enchantments = { "INLINE_ENCH_ROT1_0" },
}

ccb.content.define_mutation {
    id = "ROT2",
    name = ccb.content.text("Deterioration"),
    description = ccb.content.text("Your body is very slowly wasting away."),
    categories = { "CHIMERA", "ALPHA" },
    types = { "HEALING" },
    prerequisites = { "ROT1" },
    replacements = { "ROT3" },
    points = -8,
    vitamin_cost = 250,
    body_temperature = { -750, -750 },
    enchantments = { "INLINE_ENCH_ROT2_0" },
}

ccb.content.define_mutation {
    id = "ROT3",
    name = ccb.content.text("Disintegration"),
    description = ccb.content.text("Your body is slowly wasting away!"),
    categories = { "ALPHA" },
    types = { "HEALING" },
    prerequisites = { "ROT2" },
    secondary_prerequisites = { "STR_ALPHA", "DEX_ALPHA", "PER_ALPHA", "INT_ALPHA" },
    threshold_requirements = { "THRESH_ALPHA" },
    points = -10,
    vitamin_cost = 260,
    body_temperature = { -1500, -1500 },
    enchantments = { "INLINE_ENCH_ROT3_0" },
}

ccb.content.define_mutation {
    id = "VANITY",
    name = ccb.content.text("Highly Vain"),
    description = ccb.content.text("You know you're beautiful, and the world deserves to know it too.  You prefer to show off your stunningly good looks and will be unhappy if you cover up your face."),
    categories = { "ALPHA" },
    prerequisites = { "BEAUTIFUL", "BEAUTIFUL2" },
    points = -1,
    vitamin_cost = 60,
}
