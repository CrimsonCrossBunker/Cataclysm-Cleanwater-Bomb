local ccb = require("ccb")
local content = ccb.content

-- Hardcoded category to display vehicle parts regardless of category.
content.add(content.VehiclePartCategory {
    id = "_all",
    name = ccb.content.text("All", "vp_category"),
    short_name = "*",
    priority = 0,
})

-- Hardcoded category used for vehicle part user filter.
content.add(content.VehiclePartCategory {
    id = "_filter",
    name = ccb.content.text("Filter", "vp_category"),
    short_name = "/",
    priority = 255,
})

-- Vehicle part category for engines, motors, battery/fuel storage, wheels.
content.add(content.VehiclePartCategory {
    id = "movement",
    name = ccb.content.text("Movement", "vp_category"),
    short_name = ccb.content.text("M", "vp_category"),
    priority = 10,
})

-- Vehicle part category for manual engines (which are usually controls), controls of all kinds, seats and saddles.
content.add(content.VehiclePartCategory {
    id = "operations",
    name = ccb.content.text("Operations", "vp_category"),
    short_name = ccb.content.text("O", "vp_category"),
    priority = 20,
})

-- Vehicle part category for solar panels, reactors, dashboards and ECUs, batteries, alternators.
content.add(content.VehiclePartCategory {
    id = "energy",
    name = ccb.content.text("Electric Generation", "vp_category"),
    short_name = ccb.content.text("G", "vp_category"),
    priority = 30,
})

-- Vehicle part category for frames, armor, rams, doors, roofs, hulls and structural bits of all kinds.
content.add(content.VehiclePartCategory {
    id = "hull",
    name = ccb.content.text("Hull", "vp_category"),
    short_name = ccb.content.text("H", "vp_category"),
    priority = 40,
})

-- Vehicle part category for turrets, weapons, armor and rams.
content.add(content.VehiclePartCategory {
    id = "warfare",
    name = ccb.content.text("Warfare", "vp_category"),
    short_name = ccb.content.text("W", "vp_category"),
    priority = 50,
})

-- Vehicle part category for aisles, seats, beds, animal carriers, livestock stalls etc
content.add(content.VehiclePartCategory {
    id = "passengers",
    name = ccb.content.text("Passengers", "vp_category"),
    short_name = ccb.content.text("P", "vp_category"),
    priority = 60,
})

-- Vehicle part category for trunks, boxes, cargo spaces, livestock stalls, bike racks etc.
content.add(content.VehiclePartCategory {
    id = "cargo",
    name = ccb.content.text("Cargo", "vp_category"),
    short_name = ccb.content.text("C", "vp_category"),
    priority = 70,
})

-- Vehicle part category for internal and external lighting.
content.add(content.VehiclePartCategory {
    id = "lighting",
    name = ccb.content.text("Lighting", "vp_category"),
    short_name = ccb.content.text("L", "vp_category"),
    priority = 80,
})

-- Vehicle part category for crafting stations, water purifiers, washers, autoclaves, cranes/cantilevers etc.
content.add(content.VehiclePartCategory {
    id = "utility",
    name = ccb.content.text("Utility", "vp_category"),
    short_name = ccb.content.text("U", "vp_category"),
    priority = 90,
})

-- Vehicle part category for anything not included in other categories
content.add(content.VehiclePartCategory {
    id = "other",
    name = ccb.content.text("Other", "vp_category"),
    short_name = "~",
    priority = 100,
})
