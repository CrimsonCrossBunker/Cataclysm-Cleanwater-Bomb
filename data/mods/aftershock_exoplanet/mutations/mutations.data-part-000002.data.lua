local ccb = require("ccb")

ccb.content.define_mutation {
    id = "THRESH_MASTODON",
    name = ccb.content.text("Killophant"),
    points = 1,
    description = ccb.content.text("Your species was created as the ultimate shock troop.  Inherit the earth, pedigree your ancestors, crush the foe."),
    valid = false,
    profession = true,
    purifiable = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "MIGO_HEAT_RESIST",
    name = ccb.content.text("Mi-go acclimatization"),
    points = 4,
    body_temperature = { -2500, -6500 },
    description = ccb.content.text("Fleshy fronds grown from your scalp function like organic heat sinks.  They allow you to live comfortably within the mi-go atmosphere."),
    player_display = true,
    threshold_requirements = { "THRESH_YUGGOTH" },
    starting_trait = false,
    types = { "METABOLISM" },
    active = true,
    categories = { "MIGO" },
    prerequisites = { "WARM_NATURED" },
}
