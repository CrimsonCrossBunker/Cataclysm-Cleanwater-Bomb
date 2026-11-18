local content = require("ccb").content

content.add(content.OvermapLocation {
    id = "desert",
    terrains = { "desert" },
})

content.replace(content.OvermapLocation {
    id = "land",
    terrains = { "forest", "forest_thick", "forest_water", "field", "forest_trail", "desert" },
})

content.replace(content.OvermapLocation {
    id = "wilderness",
    terrains = { "forest", "forest_thick", "field", "forest_trail", "desert" },
})
