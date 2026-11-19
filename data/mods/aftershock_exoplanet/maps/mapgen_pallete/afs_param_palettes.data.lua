local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "afs_light_param_palette",
    layout = {
        parameters = {
            lightstatus = {
                value_type = "nested_mapgen",
                default = {
                    weighted = { { id = "afs_map_lights_on", weight = 20 }, { id = "null", weight = 80 } },
                },
            },
        },
    },
}
