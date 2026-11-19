local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "microlab_research_notes_computer",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "6",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        computer_glyphs = {
            ["6"] = {
                name = ccb.content.text("Log Console"),
                security = 3,
                menu = {
                    {
                        label = ccb.content.text("View Research Logs"),
                        action = "research",
                        security = 0,
                    },
                },
                failures = { "alarm", "shutdown" },
            },
        },
    },
}
