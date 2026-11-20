local ccb = require("ccb")
local content = ccb.content

-- Native post-process generators
do
local definition = content.PostProcessGenerator { id = "riot_damage" }
content.replace(definition)
end
do
local definition = content.PostProcessGenerator { id = "riot_damage_road" }
content.replace(definition)
end
