local content = require("ccb").content

do
    local group = content.ItemGroup { id = "test_npc_belt", kind = "distribution" }
    group:item("leather_belt", 50)
    group:item("tool_belt", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "test_npc_eyes", kind = "distribution" }
    group:item("glasses_safety", 20)
    group:item("sunglasses", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "test_npc_hat", kind = "distribution" }
    group:item("hat_ball", 20)
    group:item("hat_hard", 5)
    group:item("hat_boonie", 5)
    group:item("hat_cotton", 20)
    group:item("hat_fur", 5)
    group:item("hat_knit", 20)
    group:item("hat_newsboy", 10)
    group:item("cowboy_hat", 10)
    group:item("hat_sombrero", 5)
    group:item("10gal_hat", 5)
    group:item("straw_hat", 5)
    group:item("hat_hunting", 10)
    group:item("hat_hard_hooded", 5)
    group:item("helmet_bike", 10)
    group:item("helmet_riot", 5)
    group:item("helmet_motor", 5)
    group:item("helmet_skid", 5)
    group:item("helmet_ball", 5)
    group:item("helmet_football", 5)
    group:item("pot_helmet", 10)
    group:item("firehelmet", 5)
    group:item("helmet_army", 5)
    content.add(group)
end
