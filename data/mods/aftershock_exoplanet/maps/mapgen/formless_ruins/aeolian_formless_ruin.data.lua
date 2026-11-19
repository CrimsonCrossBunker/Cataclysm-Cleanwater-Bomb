local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "afs_ruins_dynamic" },
    weight = 3,
    layout = {
        predecessor_mapgen = "glacial_field",
    },
}
