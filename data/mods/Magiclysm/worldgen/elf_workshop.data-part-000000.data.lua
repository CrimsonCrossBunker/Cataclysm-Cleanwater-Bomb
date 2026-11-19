local ccb = require("ccb")

-- Currently does not spawn because seasonal locations are not supported.  A global EoC could be used to spawn it in a particular location.
ccb.content.define_fixed_overmap_special {
    id = "elf_workshop",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "elf_workshop_north" },
        { point = { 0, 0, 1 }, terrain = "elf_workshop_roof_north" },
    },
    locations = { "wilderness" },
    city_distance = { 20, -1 },
    city_sizes = { 0, 13 },
    occurrences = { 0, 0 },
    flags = { "GLOBALLY_UNIQUE", "SHOULD_NOT_SPAWN" },
}
