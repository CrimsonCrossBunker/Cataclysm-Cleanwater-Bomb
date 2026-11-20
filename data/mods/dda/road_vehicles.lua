local ccb = require("ccb")
local content = ccb.content

-- Typed Platform world/content descriptors
do
local definition = content.VehiclePlacement({ id = "highway", locations = { { facing = { 90, 270 }, x = { 10, 12 }, y = { 10, 12 } } } })
content.add(definition)
end
do
local definition = content.VehiclePlacement({ id = "subway_deadend", locations = { { facing = 270, x = 16, y = { 3, 13 } }, { facing = 90, x = 7, y = { 7, 17 } } } })
content.add(definition)
end
do
local definition = content.VehicleSpawn({ id = "default_bridge", spawn_types = { { ["//"] = "Clear section of bridge", vehicle_function = "no_vehicles", weight = 50 }, { ["//"] = "Unfueled Vehicle on the bridge", vehicle_json = { fuel = 0, number = 1, placement = "highway", status = -1, vehicle = "highway" }, weight = 30 }, { ["//"] = "Vehicle on the bridge", vehicle_json = { fuel = -1, number = 1, placement = "highway", status = -1, vehicle = "highway" }, weight = 20 } } })
content.add(definition)
end
do
local definition = content.VehicleSpawn({ id = "default_parkinglot", spawn_types = { { ["//"] = "Parking lot with vehicles", vehicle_function = "parkinglot", weight = 100 } } })
content.add(definition)
end
do
local definition = content.VehicleSpawn({ id = "default_subway_deadend", spawn_types = { { ["//"] = "Clear section of subway", vehicle_function = "no_vehicles", weight = 100 }, { ["//"] = "Vehicle on the subway", vehicle_json = { fuel = -1, number = { 1, 2 }, placement = "subway_deadend", status = -1, vehicle = "trains_draisine" }, weight = 100 } } })
content.add(definition)
end
