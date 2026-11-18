local content = require("ccb").content

do
    local group = content.ItemGroup { id = "BONE_SEER_Brigitte_worn", kind = "collection" }
    group:item("boxer_briefs")
    group:item("socks")
    group:item("tshirt")
    group:item("jacket_leather_bone")
    group:item("gloves_liner")
    group:item("helmet_skull")
    group:item("gloves_leather")
    group:item("pants_leather")
    group:item("boots_bone")
    group:item("backpack_leather")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "BONE_SEER_Brigitte_wield", kind = "collection" }
    group:item("2h_flail_steel")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_BONE_SEER_misc", kind = "distribution" }
    group:item("needle_bone", 40)
    group:group("glue_weak_domestic", 20)
    group:item("bone_flute", 10)
    group:item("bone_human", 10)
    group:item("broth_bone", 60)
    group:item("water_clean", 90)
    content.add(group)
end
