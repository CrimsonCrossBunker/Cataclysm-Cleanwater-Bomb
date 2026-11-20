local ccb = require("ccb")
local content = ccb.content

-- Native vehicle-part locations
do
local definition = content.VehiclePartLocation {
    id = "structure",
    name = "Structure",
    description = "",
    z_order = 5,
    list_order = 1,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "armor",
    name = "Armor",
    description = "",
    z_order = -2,
    list_order = 2,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "damping",
    name = "Damping",
    description = "",
    z_order = -2,
    list_order = 2,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_roof",
    name = "On Roof",
    description = "",
    z_order = 9,
    list_order = 3,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "roof",
    name = "Roof",
    description = "",
    z_order = -1,
    list_order = 4,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_cargo",
    name = "On Cargo",
    description = "Attached to a cargo space",
    z_order = 8,
    list_order = 6,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "center",
    name = "Center",
    description = "Above the frame and below the roof",
    z_order = 7,
    list_order = 7,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_door",
    name = "On Door",
    description = "",
    z_order = -1,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "engine_block",
    name = "Engine Block",
    description = "",
    z_order = 4,
    list_order = 8,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "fuel_source",
    name = "Fuel Source",
    description = "",
    z_order = 3,
    list_order = 9,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "under",
    name = "Under",
    description = "Below the frame",
    z_order = 6,
    list_order = 10,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_battery_mount",
    name = "Battery Mount",
    description = "",
    z_order = 3,
    list_order = 11,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_frame",
    name = "On Frame",
    description = "",
    z_order = -1,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "axle",
    name = "Axle",
    description = "",
    z_order = -1,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_ceiling",
    name = "On Ceiling",
    description = "",
    z_order = -1,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_controls",
    name = "On Controls",
    description = "",
    z_order = -1,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_lockable_cargo",
    name = "On Lockable Cargo",
    description = "",
    z_order = -1,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_seat",
    name = "On Seat",
    description = "",
    z_order = -1,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "on_windshield",
    name = "On Window",
    description = "",
    z_order = -1,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "structural",
    name = "Structural",
    description = "An overhead structural element such as an external balloon",
    z_order = 9,
    list_order = 5,
}
content.add(definition)
end
do
local definition = content.VehiclePartLocation {
    id = "anywhere",
    name = "Anywhere",
    description = "Can be installed in any location",
    z_order = 9,
    list_order = 12,
}
content.add(definition)
end
