local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SYLPH_WIND_TRANSLOCATION",
    name = ccb.content.text("Going Wither the Wind May Lead"),
    points = 10,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Sylph gains the ability to travel along the blowing winds to another location they have previously been to."),
    categories = { "SYLPH" },
    purifiable = false,
    threshold_requirements = { "THRESH_SYLPH" },
    prerequisites = { "SYLPH_FLY_AT_WILL" },
    spells_learned = { sylph_wind_translocation_spell = 1, sylph_wind_translocation_attune = 1 },
}
