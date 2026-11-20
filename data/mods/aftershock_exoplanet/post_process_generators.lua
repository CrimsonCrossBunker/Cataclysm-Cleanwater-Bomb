local ccb = require("ccb")
local content = ccb.content

-- Typed Platform world/content descriptors
do
local definition = content.PostProcessGenerator({ id = "riot_damage", sub_generators = { { attempts = 250, chance = 10, max_intensity = 60, min_intensity = 6, type = "bash_damage" }, { attempts = 250, chance = 10, max_intensity = 3, type = "move_items" } } })
content.replace(definition)
end
