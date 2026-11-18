local content = require("ccb").content

do
    local group = content.ItemGroup { id = "REFUGEE_Garry_worn", kind = "collection" }
    group:item("boxer_shorts")
    group:item("socks")
    group:item("longshirt")
    group:item("long_knit_scarf_loose")
    group:item("pants")
    group:item("jacket_windbreaker")
    group:item("hat_ball")
    group:item("glasses_eye")
    group:item("sneakers")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Garry_carried", kind = "collection" }
    group:group("duct_tape_roll_part")
    group:group("glue_strong_domestic")
    group:group("glue_weak_domestic")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "REFUGEE_Garry_wield", kind = "collection" }
    group:item("hatchet")
    content.add(group)
end
