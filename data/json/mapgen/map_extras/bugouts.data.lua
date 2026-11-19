local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_bugout",
    layout = {
        nested = {
            {
                choices = { { id = "nested_bugout_bag", weight = 100 } },
                x = { 0, 23 },
                y = { 0, 23 },
            },
        },
    },
}
