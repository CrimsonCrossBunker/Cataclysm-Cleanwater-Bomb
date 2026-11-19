local ccb = require("ccb")

ccb.content.define_mutation {
    id = "RAVEN_BONES",
    copy_from = "HOLLOW_BONES",
    description = ccb.content.text("Your bones are nearly hollow, a remnant of your people's past as creatures of the air.  Your body is very light as a result, enabling you to move and attack 20% faster, but also frail; you can carry 40% less, and bashing attacks injure you more."),
    categories = { "SPECIES_RAVENFOLK" },
}

ccb.content.define_mutation { id = "FLEET", copy_from = "FLEET", add = { categories = { "SPECIES_RAVENFOLK" } } }

-- Name just means 'lover of gold' but at least it fits the format of other negative traits
ccb.content.define_mutation {
    id = "LOVES_SHINY_OBJECTS",
    name = ccb.content.text("Chrysophilia"),
    points = -3,
    description = ccb.content.text("You need to have shiny objects on your person or you just can't concentrate very well.  You suffer a morale penalty unless you're wearing at least six items made of gold or silver."),
    purifiable = false,
    categories = { "SPECIES_RAVENFOLK", "DRAGON_BLACK" },
}

ccb.content.define_mutation { id = "SKIN_ROUGH", copy_from = "SKIN_ROUGH", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation {
    id = "RAVEN_FEATHERS",
    name = ccb.content.text("Feathers"),
    description = ccb.content.text("Dark feathers cover your entire body, providing a marginal protection against attacks and minor protection from cold.  They also provide a natural waterproofing."),
    categories = { "SPECIES_RAVENFOLK" },
    types = { "SKIN" },
    prerequisites = { "SKIN_ROUGH" },
    additions = { "DOWN" },
    points = 2,
    vitamin_cost = 160,
    visibility = 10,
    ugliness = 0,
    body_temperature = { 50, 100 },
    integrated_armor = { "integrated_raven_feathers" },
}

ccb.content.define_mutation { id = "NOMAD", copy_from = "NOMAD", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation { id = "EAGLEEYED", copy_from = "EAGLEEYED", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation {
    id = "DOWN",
    copy_from = "DOWN",
    prerequisites = { "FEATHERS", "RAVEN_FEATHERS" },
    add = {
        categories = { "SPECIES_RAVENFOLK" },
        threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    },
}

ccb.content.define_mutation { id = "PER_UP_2", copy_from = "PER_UP_2", add = { categories = { "SPECIES_RAVENFOLK" } } }

ccb.content.define_mutation {
    id = "PER_UP_3",
    copy_from = "PER_UP_3",
    add = {
        categories = { "SPECIES_RAVENFOLK" },
        threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    },
}

ccb.content.define_mutation {
    id = "PER_UP_4",
    copy_from = "PER_UP_4",
    add = {
        categories = { "SPECIES_RAVENFOLK" },
        threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    },
}

ccb.content.define_mutation {
    id = "BIRD_EYE",
    copy_from = "BIRD_EYE",
    add = {
        categories = { "SPECIES_RAVENFOLK" },
        threshold_requirements = { "THRESH_SPECIES_RAVENFOLK" },
    },
}
