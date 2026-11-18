local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_pants", kind = "distribution" }
    group:item("jeans", 60)
    group:item("pants", 5)
    group:item("motorbike_pants", 10)
    group:item("jeans_mod", 5)
    group:item("pants_leather", 10)
    group:item("pants_cargo", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_shoes", kind = "distribution" }
    group:item("sneakers", 40)
    group:item("boots", 30)
    group:item("motorbike_boots", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_shirt", kind = "distribution" }
    group:item("tshirt", 50)
    group:item("polo_shirt", 20)
    group:item("tank_top", 10)
    group:item("denim_shirt", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_gloves", kind = "distribution" }
    group:item("null", 10)
    group:item("gloves_leather", 10)
    group:item("gloves_work", 40)
    group:item("gloves_fingerless", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_coat", kind = "distribution" }
    group:item("hoodie", 15)
    group:item("jacket_light", 15)
    group:item("jacket_windbreaker", 15)
    group:item("jacket_leather", 15)
    group:item("jacket_leather_mod", 5)
    group:item("touring_suit", 20)
    group:item("jacket_jean", 15)
    group:item("jacket_jean_mod", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_vest", kind = "distribution" }
    group:item("null", 50)
    group:item("kevlar", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_storage", kind = "distribution" }
    group:item("backpack", 50)
    group:item("daypack", 20)
    group:item("backpack_leather", 10)
    group:item("mbag", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_holster", kind = "distribution" }
    group:item("leather_belt", 25)
    group:item("tool_belt", 75)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_hat", kind = "distribution" }
    group:item("null", 10)
    group:item("cowboy_hat", 10)
    group:item("hat_ball", 40)
    group:item("hat_hard", 20)
    group:item("helmet_motor", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_MOTORHEAD_wield", kind = "distribution" }
    group:item("lug_wrench", 25)
    group:item("wrench_large", 25)
    group:item("hd_pipe", 20)
    group:item("staff_pipe", 15)
    group:item("mace_pipe_large", 15)
    content.add(group)
end
