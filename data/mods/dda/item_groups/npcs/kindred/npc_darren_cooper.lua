local content = require("ccb").content

do
    local group = content.ItemGroup { id = "KINDRED_COOPER_worn", kind = "collection" }
    group:item("loincloth_leather")
    group:item("socks")
    group:item("kevlar")
    group:item("helmet_liner")
    group:item("gloves_liner")
    group:item("boots_larmor")
    group:group("swat_ballistic_vest")
    group:item("gauntlets_larmor")
    group:item("leather_belt")
    group:item("canteen")
    group:item("armguard_larmor")
    group:item("backpack_leather")
    group:item("knee_pads")
    group:item("knit_scarf")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "KINDRED_COOPER_wield", kind = "collection" }
    group:item("machete")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_KINDRED_COOPER_misc", kind = "distribution" }
    group:item("needle_bone", 40)
    group:group("glue_weak_domestic", 20)
    group:item("bone_flute", 10)
    group:item("bone_human", 10)
    group:item("broth_bone", 60)
    group:item("water_clean", 90)
    content.add(group)
end
