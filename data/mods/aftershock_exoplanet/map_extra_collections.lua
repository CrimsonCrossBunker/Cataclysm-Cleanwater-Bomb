local ccb = require("ccb")
local content = ccb.content

-- Native map-extra collection definitions
do
local definition = content.MapExtraCollection {
    id = "road_aftershock",
    chance = 75,
}
definition:extra("mx_wraitheon_droneswarm", 10)
content.add(definition)
end
