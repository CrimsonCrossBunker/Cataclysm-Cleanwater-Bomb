local ccb = require("ccb")
local content = ccb.content

-- Native overmap connections
do
local definition = content.OvermapConnection {
    id = "local_road",
}
definition:subtype("road", 0, { "space" }, false, false)
content.replace(definition)
end
