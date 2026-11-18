local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_OG_OFFICER_misc", kind = "collection" }
    group:item("two_way_radio")
    group:item("p320mag_17rd_9x19mm", 45)
    group:entry { item = "pencil", count = { 2, 2 } }
    group:item("pen")
    group:item("cotton_patchwork")
    group:item("red_pen")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_OG_OFFICER_worn", kind = "collection" }
    group:item("socks", 30)
    group:item("briefs")
    group:item("pants_army")
    group:item("jacket_army")
    group:item("dress_shoes")
    group:item("gloves_leather", 80)
    group:item("webbing_belt", 80)
    group:entry { item = "m18", charges = { 16, 16 }, container = "holster", ammo = { item = "9mmP2" } }
    group:entry {
        distribution = {
            { item = "gold_watch", probability = 30 },
            { item = "sf_watch", probability = 70 },
        },
    }
    group:item("collarpin")
    group:item("diamond_silver_cufflinks")
    content.add(group)
end
