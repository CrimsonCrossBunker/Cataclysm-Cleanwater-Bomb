local ccb = require("ccb")

-- Pseudo terrain used for Tacoma companion raids
ccb.content.define_mapgen {
    kind = "overmap",
    id = {
        "looted_house",
        "looted_house_roof",
        "looted_house_basement",
        "looted_hospital",
        "looted_hospital_roof",
    },
    layout = {
        fill_terrain = "t_floor",
    },
}
