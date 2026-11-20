local ccb = require("ccb")

ccb.content.define_scenario {
    id = "ddotd_cabin",
    name = "Cabin in the Woods",
    points = 0,
    description = "You have survived the initial wave of panic, and have achieved (relative) safety in an isolated cabin away from the overrun cities.",
    locations = { "sloc_cabin" },
    start_name = "Isolated Cabin",
    flags = { "CITY_START" },
}
