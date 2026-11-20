local ccb = require("ccb")
local content = ccb.content

-- Native road vehicle placements
do
local definition = content.VehiclePlacement { id = "road_wreck_t" }
definition:location({ x = { 8, 11 }, y = { 10, 14 }, facings = { 90, 270 } })
content.add(definition)
end
do
local definition = content.VehiclePlacement { id = "road_wreck_b" }
definition:location({ x = { 8, 11 }, y = { 5, 8 }, facings = { 90, 270 } })
content.add(definition)
end
do
local definition = content.VehiclePlacement { id = "road_wreck_l" }
definition:location({ x = { 5, 8 }, y = { 8, 11 }, facings = { 90, 270 } })
content.add(definition)
end
do
local definition = content.VehiclePlacement { id = "road_wreck_r" }
definition:location({ x = { 10, 14 }, y = { 8, 11 }, facings = { 90, 270 } })
content.add(definition)
end
do
local definition = content.VehiclePlacement { id = "road_wreck_c" }
definition:location({ x = { 8, 11 }, y = { 8, 11 }, facings = { 90, 270 } })
content.add(definition)
end
