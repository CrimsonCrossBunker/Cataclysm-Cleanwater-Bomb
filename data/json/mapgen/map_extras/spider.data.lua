local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_spider",
    layout = {
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "spider_nest", x = { 0, 6 }, y = { 0, 6 } },
            { choices = { "spider_nest", "null" }, x = { 0, 6 }, y = { 0, 6 } },
        },
    },
}
