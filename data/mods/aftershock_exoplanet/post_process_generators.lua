local ccb = require("ccb")
local content = ccb.content

-- Native post-process generators
do
local definition = content.PostProcessGenerator { id = "riot_damage" }
definition:stage("bash_damage", { attempts = 250, chance = 10, min_intensity = 6, max_intensity = 60 })
definition:stage("move_items", { attempts = 250, chance = 10, max_intensity = 3 })
content.replace(definition)
end
