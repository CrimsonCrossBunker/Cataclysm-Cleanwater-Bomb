local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "elf_workshop", "elf_workshop_roof" },
    name = ccb.content.text("elf workshop"),
    symbol = "W",
    color = "red",
    see_cost = "high",
    flags = { "RISK_HIGH", "SHOULD_NOT_SPAWN" },
}
