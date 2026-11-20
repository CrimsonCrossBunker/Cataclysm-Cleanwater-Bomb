local ccb = require("ccb")
local content = ccb.content

-- Native overmap connections
do
local definition = content.OvermapConnection {
    id = "local_road",
}
definition:subtype("road", 0, { "road" }, true, false)
definition:subtype("road", 30, { "stream" }, true, false)
definition:subtype("road", 5, { "field" }, false, false)
definition:subtype("road", 20, { "forest" }, false, false)
definition:subtype("road", 40, { "swamp" }, false, false)
definition:subtype("road", 80, { "highway" }, false, true)
definition:subtype("road_nesw_manhole", 0, {  }, false, false)
definition:subtype("bridge", 120, { "water" }, true, false)
definition:subtype("bridgehead_ground", 120, { "water" }, true, false)
content.add(definition)
end
do
local definition = content.OvermapConnection {
    id = "highway_road_connection",
}
definition:subtype("road", 0, { "road" }, true, false)
definition:subtype("road", 5, { "field" }, false, false)
definition:subtype("road", 20, { "forest" }, false, false)
definition:subtype("road", 40, { "swamp" }, false, false)
definition:subtype("road_nesw_manhole", 0, {  }, false, false)
definition:subtype("bridge", 120, { "water" }, true, false)
definition:subtype("bridgehead_ground", 120, { "water" }, true, false)
content.add(definition)
end
do
local definition = content.OvermapConnection {
    id = "sewer_tunnel",
}
definition:subtype("sewer", 0, { "subterranean" }, true, false)
content.add(definition)
end
do
local definition = content.OvermapConnection {
    id = "subway_tunnel",
}
definition:subtype("subway", 0, { "subterranean_subway" }, true, false)
definition:subtype("lab_subway", 0, { "lab_subway" }, true, false)
content.add(definition)
end
do
local definition = content.OvermapConnection {
    id = "forest_trail",
}
definition:subtype("forest_trail", 0, { "forest_trail" }, true, false)
definition:subtype("forest_trail", 5, { "forest_center" }, false, false)
definition:subtype("forest_trail", 100, { "forest_edge" }, false, false)
definition:subtype("forest_trail", 40, { "swamp" }, false, false)
content.add(definition)
end
