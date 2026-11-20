local ccb = require("ccb")
local content = ccb.content

-- Native vehicle-part migrations
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "atomic_lamp",
    to = "fcl_atomic_lamp",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "vehicle_part",
    from = "atomic_light",
    to = "fcl_atomic_light",
}
content.add(definition)
end
end
