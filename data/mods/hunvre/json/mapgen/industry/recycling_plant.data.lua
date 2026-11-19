local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "recycling_plant_x0_y0_z0", "recycling_plant_x1_y0_z0", "recycling_plant_x2_y0_z0",
        "recycling_plant_x0_y1_z0", "recycling_plant_x1_y1_z0", "recycling_plant_x2_y1_z0",
        "recycling_plant_x0_y0_z-1", "recycling_plant_x1_y0_z-1", "recycling_plant_x2_y0_z-1",
        "recycling_plant_x0_y1_z-1", "recycling_plant_x1_y1_z-1", "recycling_plant_x2_y1_z-1",
        "recycling_plant_x0_y0_z-2", "recycling_plant_x1_y0_z-2", "recycling_plant_x2_y0_z-2",
        "recycling_plant_x0_y1_z-2", "recycling_plant_x1_y1_z-2", "recycling_plant_x2_y1_z-2",
    },
    name = ccb.content.text("polymer recycling plant"),
    symbol = "+",
    color = "red",
    vision_levels = "city_building",
    travel_cost = "structure",
    see_cost = "high",
    flags = { "RISK_HIGH", "GENERIC_LOOT", "SIDEWALK" },
}
