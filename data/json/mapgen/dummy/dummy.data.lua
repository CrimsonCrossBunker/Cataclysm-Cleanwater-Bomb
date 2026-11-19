local ccb = require("ccb")

-- This mapgen exist only for suppressing 'No mapgen terrain exists for %s' type of errors on game start and shouldn't spawn ingame
-- This mapgen is used for replacing obsoleted overmap terrain, normally it shouldn't spawn
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "unexplored", "omt_obsolete" },
    layout = {
        fill_terrain = "t_nether_glass_floor",
    },
}
