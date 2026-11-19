local ccb = require("ccb")

-- Goes to 9x9 arcology stores
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_2x2_gate",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "//",
            "/ ",
        },
        terrain = {
            ["/"] = {
                { id = "t_retractable_gate_l" },
                { id = "t_retractable_gate_l" },
                { id = "t_retractable_gate_l" },
                { id = "t_retractable_gate_c" },
            },
        },
    },
}
