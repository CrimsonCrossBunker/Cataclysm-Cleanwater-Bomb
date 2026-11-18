local content = require("ccb").content

do
    local group = content.ItemGroup { id = "os_items", kind = "distribution" }
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 50 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 40 }
    group:item("gloves_work", 30)
    group:item("gloves_rubber", 60)
    group:item("boots_rubber", 60)
    group:item("hat_hard", 60)
    group:item("shovel", 40)
    group:item("jackhammer", 5)
    group:item("jackhammer_mining", 1)
    group:item("elec_jackhammer", 5)
    group:item("elec_jackhammer_mining", 1)
    group:item("folding_poncho", 40)
    group:item("radio", 40)
    group:item("well_pump", 10)
    group:group("tools_toolbox", 5)
    group:item("wrench", 15)
    group:item("wrench_48", 30)
    group:item("bag_canvas", 40)
    group:item("jumper_cable", 40)
    group:item("jumper_cable_heavy", 20)
    group:item("glasses_safety", 25)
    group:item("goggles_chem", 5)
    group:item("crowbar", 15)
    group:item("mask_filter", 30)
    group:entry { item = "mask_gas_half", charges = { 0, 100 }, probability = 25 }
    group:item("electric_lantern", 30)
    content.add(group)
end
