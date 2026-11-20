local ccb = require("ccb")
local content = ccb.content

-- Native road vehicle placements and spawns
do
local definition = content.VehiclePlacement { id = "highway" }
definition:location({ x = { 10, 12 }, y = { 10, 12 }, facings = { 90, 270 } })
content.add(definition)
end
do
local definition = content.VehiclePlacement { id = "subway_deadend" }
definition:location({ x = 16, y = { 3, 13 }, facings = 270 })
definition:location({ x = 7, y = { 7, 17 }, facings = 90 })
content.add(definition)
end
do
local definition = content.VehicleSpawn { id = "default_bridge" }
definition:builtin("no_vehicles", 50)
definition:vehicle("highway", 30, { placement = "highway", number = 1, fuel = 0, status = -1 })
definition:vehicle("highway", 20, { placement = "highway", number = 1, fuel = -1, status = -1 })
content.add(definition)
end
do
local definition = content.VehicleSpawn { id = "default_parkinglot" }
definition:builtin("parkinglot", 100)
content.add(definition)
end
do
local definition = content.VehicleSpawn { id = "default_subway_deadend" }
definition:builtin("no_vehicles", 100)
definition:vehicle("trains_draisine", 100, { placement = "subway_deadend", number = { 1, 2 }, fuel = -1, status = -1 })
content.add(definition)
end
