local ccb = require("ccb")
local content = ccb.content

-- Native road vehicle spawns
do
local definition = content.VehicleSpawn { id = "default_bridge" }
definition:builtin("no_vehicles", 849000)
definition:vehicle("highway", 1000, { placement = "highway", number = 1, fuel = 0, status = 1 })
definition:vehicle("highway_wr", 30000, { placement = "road_wreck_t", number = { 2, 3 }, fuel = 0, status = 1 })
definition:vehicle("highway_wr", 30000, { placement = "road_wreck_b", number = { 2, 3 }, fuel = 0, status = 1 })
definition:vehicle("highway_wr", 30000, { placement = "road_wreck_l", number = { 2, 3 }, fuel = 0, status = 1 })
definition:vehicle("highway_wr", 30000, { placement = "road_wreck_r", number = { 2, 3 }, fuel = -1, status = 1 })
definition:vehicle("highway_wr", 30000, { placement = "road_wreck_c", number = { 2, 3 }, fuel = -1, status = 1 })
content.replace(definition)
end
do
local definition = content.VehicleSpawn { id = "default_parkinglot" }
definition:builtin("no_vehicles", 950000)
definition:builtin("parkinglot", 50000)
content.replace(definition)
end
