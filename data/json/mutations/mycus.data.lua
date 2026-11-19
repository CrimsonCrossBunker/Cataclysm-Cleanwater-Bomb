local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_MARLOSS",
    name = ccb.content.text("Marloss Gateway"),
    description = ccb.content.text("You get the feeling that you're on the cusp of becoming something greater than yourself."),
    categories = { "MARLOSS" },
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "mycus" },
}

ccb.content.define_mutation {
    id = "MARLOSS",
    name = ccb.content.text("Marloss Carrier"),
    description = ccb.content.text("Ever since you ate that Marloss berry, you can't get its scent out of your nose, and you have a strong desire to try some seeds and… sap?"),
    categories = { "MARLOSS" },
    points = 4,
    purifiable = false,
    valid = false,
    flags = { "mycus" },
}

ccb.content.define_mutation {
    id = "MARLOSS_BLUE",
    name = ccb.content.text("Marloss Vessel"),
    description = ccb.content.text("Ever since you ate that Marloss seed, you can't get its taste off of your tongue, and you have a strong desire to try some berries and… sap?"),
    categories = { "MARLOSS" },
    points = 4,
    purifiable = false,
    valid = false,
    flags = { "mycus" },
}

ccb.content.define_mutation {
    id = "MARLOSS_YELLOW",
    name = ccb.content.text("Marloss Vector"),
    description = ccb.content.text("Ever since you ate that Marloss jelly, you can't stop thinking of it, and you have a strong desire to eat some seeds and berries."),
    categories = { "MARLOSS" },
    points = 4,
    purifiable = false,
    valid = false,
    flags = { "mycus" },
}

ccb.content.define_mutation {
    id = "MARLOSS_AVOID",
    name = ccb.content.text("Marloss Rejection"),
    description = ccb.content.text("Ever since you had that life-threatening reaction to that Marloss junk, you can't bear the thought of ever eating it again!"),
    points = 0,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "THRESH_MYCUS",
    name = ccb.content.text("Mycus"),
    description = ccb.content.text("We are the Mycus."),
    categories = { "MYCUS" },
    threshold = true,
    points = 1,
    purifiable = false,
    valid = false,
    flags = { "mycus" },
}

ccb.content.define_mutation {
    id = "M_IMMUNE",
    name = ccb.content.text("Mycus Identity"),
    description = ccb.content.text("We have synchronized our local physiology with that of the Mycus.  Any spores we may encounter will not attempt to germinate inside the local system, and we may traverse Mycus biospheres easily, as native bioforms shift shape to accommodate us."),
    categories = { "MYCUS" },
    threshold_requirements = { "THRESH_MYCUS" },
    points = 5,
    purifiable = false,
    flags = { "MYCUS_IMMUNE" },
}

ccb.content.define_mutation {
    id = "M_DEPENDENT",
    name = ccb.content.text("Mycus Feeder"),
    description = ccb.content.text("We have streamlined our nutritional requirements.  We rely on the Mycus for sustenance, as it relies on us.  We may locate sources of sustenance in close proximity to Mycus core towers, and in forested areas that the Mycus has grown into."),
    categories = { "MYCUS" },
    threshold_requirements = { "THRESH_MYCUS" },
    cancels = { "GOURMAND", "BEAK", "BEAK_PECK", "BEAK_HUM" },
    points = -5,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "M_PROVENANCE",
    name = ccb.content.text("Mycus Provenance"),
    description = ccb.content.text("Local spore sacs and blossoms have merged into a single, symbiotic form.  Acting as one, they germinate together to cement rapid growth across a large area according to local guidance.  The Mycus must grow."),
    categories = { "MYCUS" },
    threshold_requirements = { "THRESH_MYCUS" },
    cancels = { "M_FERTILE", "M_BLOOM", "M_SPORES", "M_BLOSSOMS" },
    points = 8,
    purifiable = false,
    active = true,
    cost = 90,
    consumes_calories = true,
    consumes_water = true,
    consumes_rest = true,
    visibility = 10,
    ugliness = -3,
}

ccb.content.define_mutation {
    id = "M_SKIN",
    name = ccb.content.text("Mycus Flesh"),
    description = ccb.content.text("We have begun adapting local physiology to Mycus physical structure, greatly reducing wet effects."),
    categories = { "MYCUS" },
    prerequisites = { "M_IMMUNE" },
    additions = { "M_DEFENDER" },
    replacements = { "M_SKIN2" },
    threshold_requirements = { "THRESH_MYCUS" },
    points = 2,
    purifiable = false,
    visibility = 10,
    ugliness = 8,
    flags = { "IRRITANT_IMMUNE" },
    armor = { { part_types = { "ALL" }, resistances = { cut = 1, bash = 2 } } },
    wet_protection = {
        { part = "head", ignored = 6 },
        { part = "leg_l", ignored = 20 },
        { part = "leg_r", ignored = 20 },
        { part = "foot_l", ignored = 6 },
        { part = "foot_r", ignored = 6 },
        { part = "arm_l", ignored = 18 },
        { part = "arm_r", ignored = 18 },
        { part = "hand_l", ignored = 4 },
        { part = "hand_r", ignored = 4 },
        { part = "torso", ignored = 40 },
    },
}

ccb.content.define_mutation {
    id = "M_SKIN2",
    name = ccb.content.text("Mycus Fireproofing"),
    description = ccb.content.text("We have spliced the dense, amphibole fibers from Mycus core towers with the resilient, adaptive flesh of local physiology.  This reduces our speed by a moderate amount, but provides powerful armor across our body, nullifies wet effects, and provides complete protection from fire."),
    categories = { "MYCUS" },
    prerequisites = { "M_SKIN" },
    secondary_prerequisites = { "M_DEFENDER" },
    replacements = { "M_SKIN3" },
    threshold_requirements = { "THRESH_MYCUS" },
    points = 5,
    purifiable = false,
    visibility = 10,
    ugliness = 8,
    flags = { "HEAT_IMMUNE", "IRRITANT_IMMUNE" },
    armor = { { part_types = { "ALL" }, resistances = { cut = 2, bash = 3 } } },
    enchantments = { "INLINE_ENCH_M_SKIN2_0" },
    wet_protection = {
        { part = "head", ignored = 9 },
        { part = "leg_l", ignored = 30 },
        { part = "leg_r", ignored = 30 },
        { part = "foot_l", ignored = 9 },
        { part = "foot_r", ignored = 9 },
        { part = "arm_l", ignored = 24 },
        { part = "arm_r", ignored = 24 },
        { part = "hand_l", ignored = 6 },
        { part = "hand_r", ignored = 6 },
        { part = "torso", ignored = 60 },
    },
}

ccb.content.define_mutation {
    id = "M_SKIN3",
    name = ccb.content.text("Mycogenesis"),
    description = ccb.content.text("Local physiology has been fully incorporated with that of Mycus silicate fibers.  In addition to benefits conferred by previous developments, we may join with Mycus fibers beneath us - sleeping on top of fungal areas places us into a dormant state, which spreads spores around us as we sleep and revitalizes our body much more quickly than regular sleep."),
    categories = { "MYCUS" },
    prerequisites = { "M_SKIN2" },
    threshold_requirements = { "THRESH_MYCUS" },
    points = 7,
    purifiable = false,
    visibility = 10,
    ugliness = 10,
    comfort = {
        {
            conditions = { { kind = "terrain", flag = "FUNGUS" } },
            comfort = "very_comfortable",
            try_message = {
                text = ccb.content.text_without_extraction("Our fibers meld with the ground beneath us.  The gills on our neck begin to seed the air with spores as our awareness fades."),
                rating = "good",
            },
        },
    },
    flags = { "HEAT_IMMUNE", "IRRITANT_IMMUNE" },
    armor = { { part_types = { "ALL" }, resistances = { cut = 3, bash = 5 } } },
    enchantments = { "INLINE_ENCH_M_SKIN3_0" },
    wet_protection = {
        { part = "head", ignored = 9 },
        { part = "leg_l", ignored = 30 },
        { part = "leg_r", ignored = 30 },
        { part = "foot_l", ignored = 9 },
        { part = "foot_r", ignored = 9 },
        { part = "arm_l", ignored = 24 },
        { part = "arm_r", ignored = 24 },
        { part = "hand_l", ignored = 6 },
        { part = "hand_r", ignored = 6 },
        { part = "torso", ignored = 60 },
    },
}

ccb.content.define_mutation {
    id = "M_DEFENDER",
    name = ccb.content.text("Mycus Defender"),
    description = ccb.content.text("From time to time the Mycus requires protection from non-Mycus that, for whatever reason, wish it ill.  We have adapted to better carry out this task - our fibers will grow strong and resilient when such threats present themselves to us."),
    categories = { "MYCUS" },
    prerequisites = { "M_SKIN" },
    secondary_prerequisites = { "M_DEPENDENT" },
    threshold_requirements = { "THRESH_MYCUS" },
    cancels = { "ADRENALINE" },
    points = 4,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "M_SPORES",
    name = ccb.content.text("Mycus Spores"),
    description = ccb.content.text("We have developed local spore sacs.  The Mycus must grow."),
    categories = { "MYCUS" },
    prerequisites = { "M_DEPENDENT" },
    replacements = { "M_FERTILE" },
    threshold_requirements = { "THRESH_MYCUS" },
    cancels = { "M_BLOSSOMS", "M_BLOOM" },
    points = 4,
    visibility = 10,
    ugliness = 4,
}

ccb.content.define_mutation {
    id = "M_FERTILE",
    name = ccb.content.text("Mycus Sporogenesis"),
    description = ccb.content.text("Local organisms seem to regard overt spore dispersal as a danger, and attack the Mycus.  Accordingly, our local spore sacs remain quiescent, until local guidance determines that it is safe to germinate.  Rapid development taxes local nutrient reserves but ensures swift and effective growth."),
    categories = { "MYCUS" },
    prerequisites = { "M_SPORES" },
    replacements = { "M_PROVENANCE" },
    threshold_requirements = { "THRESH_MYCUS" },
    cancels = { "M_BLOSSOMS", "M_BLOOM" },
    points = 6,
    active = true,
    cost = 69,
    consumes_calories = true,
    consumes_water = true,
    visibility = 5,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "M_BLOSSOMS",
    name = ccb.content.text("Mycus Blossoms"),
    description = ccb.content.text("We have developed local blossoms.  The Mycus must grow."),
    categories = { "MYCUS" },
    prerequisites = { "M_DEPENDENT" },
    secondary_prerequisites = { "M_IMMUNE" },
    replacements = { "M_BLOOM" },
    threshold_requirements = { "THRESH_MYCUS" },
    cancels = { "M_SPORES", "M_FERTILE" },
    points = 4,
    visibility = 10,
    ugliness = 3,
}

ccb.content.define_mutation {
    id = "M_BLOOM",
    name = ccb.content.text("Mycus Bloom"),
    description = ccb.content.text("Local organisms seem to regard overt spore dispersal as a danger, and attack the Mycus.  Accordingly, our local blossoms remain quiescent, until local guidance determines that it is safe to germinate.  Rapid development taxes local nutrient reserves but ensures swift and effective growth."),
    categories = { "MYCUS" },
    prerequisites = { "M_BLOSSOMS" },
    replacements = { "M_PROVENANCE" },
    threshold_requirements = { "THRESH_MYCUS" },
    cancels = { "M_SPORES", "M_FERTILE" },
    points = 6,
    active = true,
    cost = 90,
    consumes_calories = true,
    consumes_water = true,
    consumes_rest = true,
    visibility = 10,
    ugliness = 1,
}
