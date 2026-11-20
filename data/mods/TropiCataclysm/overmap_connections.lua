local ccb = require("ccb")
local content = ccb.content

-- Native overmap connections
do
local definition = content.OvermapConnection {
    id = "local_road",
}
definition:subtype("road", 0, { "field", "road", "desert" }, false, false)
definition:subtype("road", 20, { "forest_without_trail" }, false, false)
definition:subtype("road", 25, { "forest_trail" }, false, false)
definition:subtype("road", 40, { "swamp" }, false, false)
definition:subtype("road_nesw_manhole", 0, {  }, false, false)
definition:subtype("bridge", 120, { "water" }, false, false)
content.replace(definition)
end
