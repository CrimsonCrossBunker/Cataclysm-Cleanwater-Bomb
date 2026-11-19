local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_TUNNEL_TRANSLOCATION",
    name = ccb.content.text("Traveling the Veins of the Earth"),
    points = 10,
    visibility = 0,
    ugliness = 0,
    description = ccb.content.text("Upon gaining this ability the Ierde gains the ability to travel through stone to another underground location they have previously been to."),
    categories = { "IERDE" },
    purifiable = false,
    threshold_requirements = { "THRESH_IERDE" },
    prerequisites = { "IERDE_SINK_INTO_EARTH" },
    secondary_prerequisites = { "IERDE_STOP_BLEEDING" },
    spells_learned = { ierde_tunnel_translocation_spell = 1, ierde_tunnel_translocation_attune = 1 },
}
