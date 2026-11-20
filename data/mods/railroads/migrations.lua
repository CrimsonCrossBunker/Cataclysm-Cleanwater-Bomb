local ccb = require("ccb")
local content = ccb.content

-- Native overmap-special migrations
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "railroad_city",
    to = "railroad_station_city",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "overmap_special",
    from = "Railroad Station",
    to = "Railway Station",
}
content.add(definition)
end
end
