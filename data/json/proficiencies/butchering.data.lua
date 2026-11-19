local ccb = require("ccb")

ccb.content.define_proficiency {
    id = "prof_butchering_basic",
    category = "prof_butchering",
    name = ccb.content.text("Principles of Butchering"),
    description = ccb.content.text("You know how to pick up most of the meat from the animal body."),
    can_learn = true,
    time_to_learn = "2 h",
}

ccb.content.define_proficiency {
    id = "prof_butchering_adv",
    category = "prof_butchering",
    name = ccb.content.text("Butchering Expert"),
    description = ccb.content.text("There is very little meat left after your skillful knife movements."),
    can_learn = true,
    time_to_learn = "25 h",
    requires = { "prof_butchering_basic" },
}

ccb.content.define_proficiency {
    id = "prof_skinning_basic",
    category = "prof_butchering",
    name = ccb.content.text("Principles of Skinning"),
    description = ccb.content.text("You stopped making holes in the skin of animals you butcher."),
    can_learn = true,
    time_to_learn = "2 h",
}

ccb.content.define_proficiency {
    id = "prof_skinning_adv",
    category = "prof_butchering",
    name = ccb.content.text("Skinning Expert"),
    description = ccb.content.text("You really know how to skin the animal."),
    can_learn = true,
    time_to_learn = "25 h",
    requires = { "prof_skinning_basic" },
}
