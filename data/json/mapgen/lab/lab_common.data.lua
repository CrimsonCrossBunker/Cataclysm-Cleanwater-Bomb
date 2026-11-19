local ccb = require("ccb")

-- Shock vent which spews electricity every ~10th turn.
ccb.content.define_mapgen {
    kind = "nested",
    id = "sub_fd_shock_vent",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_shock_vent", x = 0, y = 0 } },
    },
}
