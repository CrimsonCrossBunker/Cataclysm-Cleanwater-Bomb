local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_LUMBERJACK_tools", kind = "distribution" }
    group:entry { item = "ax", damage = { 0, 2 }, probability = 70 }
    group:entry { item = "hatchet", damage = { 0, 2 }, probability = 30 }
    group:entry { item = "saw", damage = { 0, 2 }, probability = 10 }
    group:entry { item = "chainsaw_off", charges = { 250, 500 }, damage = { 0, 2 }, probability = 25 }
    group:entry { item = "elec_chainsaw_off", charges = { 250, 500 }, damage = { 0, 2 }, probability = 25 }
    content.add(group)
end
