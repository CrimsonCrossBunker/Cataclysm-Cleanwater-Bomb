local ccb = require("ccb")
local content = ccb.content

-- Typed Platform world/content descriptors
do
local definition = content.VehicleSpawn({ id = "default_bridge", spawn_types = { { ["//"] = "Clear section of bridge", vehicle_function = "no_vehicles", weight = 849000 }, { ["//"] = "Unfueled Vehicle on the bridge", vehicle_json = { fuel = 0, number = 1, placement = "highway", status = 1, vehicle = "highway" }, weight = 1000 }, { ["//"] = "Wrecked vehicles", vehicle_json = { fuel = 0, number = { 2, 3 }, placement = "road_wreck_t", status = 1, vehicle = "highway_wr" }, weight = 30000 }, { ["//"] = "Wrecked vehicles", vehicle_json = { fuel = 0, number = { 2, 3 }, placement = "road_wreck_b", status = 1, vehicle = "highway_wr" }, weight = 30000 }, { ["//"] = "Wrecked vehicles", vehicle_json = { fuel = 0, number = { 2, 3 }, placement = "road_wreck_l", status = 1, vehicle = "highway_wr" }, weight = 30000 }, { ["//"] = "Wrecked vehicles", vehicle_json = { fuel = -1, number = { 2, 3 }, placement = "road_wreck_r", status = 1, vehicle = "highway_wr" }, weight = 30000 }, { ["//"] = "Wrecked vehicles", vehicle_json = { fuel = -1, number = { 2, 3 }, placement = "road_wreck_c", status = 1, vehicle = "highway_wr" }, weight = 30000 } } })
content.replace(definition)
end
do
local definition = content.VehicleSpawn({ id = "default_parkinglot", spawn_types = { { ["//"] = "Clear section", vehicle_function = "no_vehicles", weight = 950000 }, { ["//"] = "Parking lot with vehicles", vehicle_function = "parkinglot", weight = 50000 } } })
content.replace(definition)
end
