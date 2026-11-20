local ccb = require("ccb")
local content = ccb.content

-- Typed Platform world/content descriptors
do
local definition = content.PostProcessGenerator({ id = "riot_damage", sub_generators = { { attempts = 250, chance = 10, max_intensity = 60, min_intensity = 6, type = "bash_damage" }, { attempts = 250, chance = 10, max_intensity = 3, type = "move_items" }, { attempts = 2, max_intensity = 3, min_intensity = 1, scaling_days_end = 14, type = "add_fire" }, { attempts = 1, max_intensity = 28, min_intensity = 6, scaling_days_end = 14, scaling_days_start = 3, scope = "overmap_special", type = "pre_burn" }, { attempts = 576, chance = 15, type = "place_blood" } } })
content.add(definition)
end
do
local definition = content.PostProcessGenerator({ id = "riot_damage_road", sub_generators = { { attempts = 250, chance = 10, max_intensity = 60, min_intensity = 6, type = "bash_damage" }, { attempts = 250, chance = 10, max_intensity = 3, type = "move_items" }, { attempts = 2, max_intensity = 3, min_intensity = 1, scaling_days_end = 14, type = "add_fire" }, { attempts = 576, chance = 15, type = "place_blood" } } })
content.add(definition)
end
do
local definition = content.PostProcessGenerator({ id = "aftershock_ruin", sub_generators = { { type = "aftershock_ruin" } } })
content.add(definition)
end
