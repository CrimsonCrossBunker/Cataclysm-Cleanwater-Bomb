local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_beehive_natural",
    layout = {
        nested = {
            {
                choices = { { id = "nested_beehive_natural", weight = 100 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
        },
    },
}
