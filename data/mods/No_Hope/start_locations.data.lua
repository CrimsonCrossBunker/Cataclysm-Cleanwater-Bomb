local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_shelter_safe",
    name = ccb.content.text("Evacuation Shelter"),
    targets = { { overmap_terrain = "shelter", parameters = { shelter_palette = "shelter_used" } } },
}
