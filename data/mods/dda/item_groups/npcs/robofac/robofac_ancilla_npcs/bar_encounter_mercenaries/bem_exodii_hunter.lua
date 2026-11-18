local content = require("ccb").content

do
    local group = content.ItemGroup { id = "BEM_EXODII_HUNTER_worn", kind = "collection" }
    group:item("helmet_sallet_raised")
    group:item("survivor_goggles")
    group:item("torso_bandolier_shotgun")
    group:item("briefs")
    group:item("pants_tactical", 100, "tactical_pants_desert")
    group:item("turtleneck_shirt_rolled")
    group:item("coat_fur", 100, "coat_tiger_fur")
    group:item("socks_wool")
    group:item("knee_high_boots", 100, "chelsea_boots")
    group:item("duffelbag_xl_nylon")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "BEM_EXODII_HUNTER_wield", kind = "collection" }
    group:item("pamd71z")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "BEM_EXODII_HUNTER_STOCK", kind = "collection" }
    group:entry { group = "EXODII_CBM_Store_Tier1", count = { 1, 2 } }
    group:entry { group = "EXODII_CBM_Store_Tier2", count = { 1, 1 }, probability = 80 }
    group:entry { group = "EXODII_CBM_Store_Tier3", count = { 1, 1 }, probability = 40 }
    group:entry { group = "EXODII_CBM_Store_Tier4", count = { 1, 1 }, probability = 20 }
    content.add(group)
end
