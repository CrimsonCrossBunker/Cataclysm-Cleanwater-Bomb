local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_living_area",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters", x = 10, y = 9 } },
    },
}
