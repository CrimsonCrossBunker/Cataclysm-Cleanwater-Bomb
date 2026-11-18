local content = require("ccb").content

do
    local group = content.ItemGroup { id = "roof_holdout", kind = "distribution" }
    group:item("grenade", 5)
    group:item("binoculars", 5)
    group:entry { group = "any_MRE", count = { 1, 5 } }
    group:entry { item = "ak47", charges = { 0, 30 }, probability = 20 }
    group:entry { item = "akmag30", charges = { 0, 30 }, probability = 20 }
    group:entry { item = "762_m87", charges = { 1, 30 }, probability = 20 }
    group:group("cig_box_cigarette_1_20", 10)
    group:item("joint_roach", 20)
    group:item("cig_butt", 20)
    group:item("joint", 10)
    group:entry { item = "762_51_incendiary", charges = { 1, 20 }, probability = 5 }
    content.add(group)
end
