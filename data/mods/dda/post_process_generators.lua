local ccb = require("ccb")
local content = ccb.content

-- Native post-process generators
do
local definition = content.PostProcessGenerator { id = "riot_damage" }
definition:stage("bash_damage", { attempts = 250, chance = 10, min_intensity = 6, max_intensity = 60 })
definition:stage("move_items", { attempts = 250, chance = 10, max_intensity = 3 })
definition:stage("add_fire", { attempts = 2, min_intensity = 1, max_intensity = 3, scaling_days_end = 14 })
definition:stage("pre_burn", { attempts = 1, min_intensity = 6, max_intensity = 28, scaling_days_start = 3, scaling_days_end = 14, scope = "overmap_special" })
definition:stage("place_blood", { attempts = 576, chance = 15 })
content.add(definition)
end
do
local definition = content.PostProcessGenerator { id = "riot_damage_road" }
definition:stage("bash_damage", { attempts = 250, chance = 10, min_intensity = 6, max_intensity = 60 })
definition:stage("move_items", { attempts = 250, chance = 10, max_intensity = 3 })
definition:stage("add_fire", { attempts = 2, min_intensity = 1, max_intensity = 3, scaling_days_end = 14 })
definition:stage("place_blood", { attempts = 576, chance = 15 })
content.add(definition)
end
do
local definition = content.PostProcessGenerator { id = "aftershock_ruin" }
definition:stage("aftershock_ruin")
content.add(definition)
end
