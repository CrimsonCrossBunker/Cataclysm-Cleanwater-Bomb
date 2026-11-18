local content = require("ccb").content

content.add(content.OvermapLocation {
    id = "ravine",
    terrains = { "ravine", "ravine_edge" },
})

content.replace(content.OvermapLocation {
    id = "land",
    terrains = {
        "field",
        "afs_aeolian_plain",
        "forest",
        "forest_thick",
        "forest_water",
        "forest_trail",
        "glacial_field",
    },
})

content.replace(content.OvermapLocation {
    id = "field",
    terrains = { "field", "glacial_field" },
})

content.replace(content.OvermapLocation {
    id = "wilderness",
    terrains = { "forest", "forest_thick", "field", "forest_trail", "glacial_field" },
})

content.add(content.OvermapLocation {
    id = "base_land",
    terrains = { "field", "forest", "forest_thick", "forest_water", "glacial_field" },
})

content.add(content.OvermapLocation {
    id = "aeolian_plain",
    terrains = { "afs_aeolian_plain" },
})

content.replace(content.OvermapLocation {
    id = "subterranean_empty",
    terrains = { "deep_rock", "solid_glacier", "empty_rock", "solid_earth" },
})

content.add(content.OvermapLocation {
    id = "ravine_edge",
    terrains = { "ravine_edge" },
})
