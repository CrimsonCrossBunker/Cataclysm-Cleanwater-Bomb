local ccb = require("ccb")

ccb.content.define_mutation {
    id = "UNDINE_RIVER_MAPPING",
    name = ccb.content.text("All Rivers Flow to the Sea"),
    description = ccb.content.text("Water falls as rain, flows into streams, and then into rivers to the sea, and rises as clouds to fall as rain once again.  While submerged in a river, lake, or the ocean, the Undine can exploit this connection to locate other sources of water."),
    points = 3,
    visibility = 0,
    ugliness = 0,
    categories = { "UNDINE" },
    purifiable = false,
    prerequisites = { "UNDINE_EYES" },
    secondary_prerequisites = { "BREATH_UNDERWATER" },
    active = true,
    on_activate = "undine_river_mapping",
}
