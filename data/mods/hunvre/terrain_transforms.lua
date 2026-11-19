local ccb = require("ccb")
local content = ccb.content

content.add(content.TerrainTransform { id = "furn_to_bed" }
    :furniture {
        inputs = { "f_null", "f_shower_retractable", "f_bed_retractable" },
        results = { "f_bed_retractable" },
    })

content.add(content.TerrainTransform { id = "furn_to_shower" }
    :furniture {
        inputs = { "f_null", "f_shower_retractable", "f_bed_retractable" },
        results = { "f_shower_retractable" },
    })

content.add(content.TerrainTransform { id = "furn_to_null" }
    :furniture {
        inputs = { "f_null", "f_shower_retractable", "f_bed_retractable" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "airlock_to_path" }
    :furniture {
        inputs = { "f_null", "f_shower_retractable", "f_bed_retractable" },
        results = { "f_shower_retractable" },
    })

content.add(content.TerrainTransform { id = "path_to_airlock" }
    :furniture {
        inputs = { "f_null", "f_shower_retractable", "f_bed_retractable" },
        results = { "f_null" },
    })

content.add(content.TerrainTransform { id = "closed_elevator_to_open" }
    :terrain {
        inputs = { "t_central_elevator_closed" },
        results = { "t_central_elevator" },
    })
