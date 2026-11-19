local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "debug_itemgroup_test",
    tiles = { { point = { 0, 0, 0 }, terrain = "debug_itemgroup_test", locations = { "land" } } },
    occurrences = { 0, 0 },
    flags = { "SHOULD_NOT_SPAWN" },
}
