local ccb = require("ccb")
local content = ccb.content

-- Typed Platform world/content descriptors
do
local definition = content.VehiclePlacement({ id = "road_wreck_t", locations = { { facing = { 90, 270 }, x = { 8, 11 }, y = { 10, 14 } } } })
content.add(definition)
end
do
local definition = content.VehiclePlacement({ id = "road_wreck_b", locations = { { facing = { 90, 270 }, x = { 8, 11 }, y = { 5, 8 } } } })
content.add(definition)
end
do
local definition = content.VehiclePlacement({ id = "road_wreck_l", locations = { { facing = { 90, 270 }, x = { 5, 8 }, y = { 8, 11 } } } })
content.add(definition)
end
do
local definition = content.VehiclePlacement({ id = "road_wreck_r", locations = { { facing = { 90, 270 }, x = { 10, 14 }, y = { 8, 11 } } } })
content.add(definition)
end
do
local definition = content.VehiclePlacement({ id = "road_wreck_c", locations = { { facing = { 90, 270 }, x = { 8, 11 }, y = { 8, 11 } } } })
content.add(definition)
end
