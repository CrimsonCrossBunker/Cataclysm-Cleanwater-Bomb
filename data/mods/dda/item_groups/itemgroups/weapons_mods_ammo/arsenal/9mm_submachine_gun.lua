local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_9mm_sub_gun&ammo", kind = "collection" }
    group:group("milspec_arsenal_9mm_sub_gun&mags")
    group:group("ammo_can_9mm_any_full", 30)
    group:entry { group = "ammo_can_9mm_any_part", count = { 1, 2 }, probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_9mm_sub_gun&mags", kind = "collection" }
    group:entry { group = "milspec_arsenal_9mm_sub", count = { 1, 2 } }
    group:entry { group = "milspec_arsenal_9mm_sub", count = { 1, 2 }, probability = 40 }
    group:entry { group = "milspec_arsenal_9mm_sub", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "milspec_arsenal_9mm_sub", kind = "distribution" }
    group:group("nested_bt_apc9k_no_ammo", 70)
    group:group("nested_hk_mp5_no_ammo", 40)
    group:group("nested_hk_mp5k_no_ammo", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_bt_apc9k_no_ammo", kind = "collection" }
    group:item("bt_apc9k")
    group:entry { group = "bt_apc9k_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bt_apc9k_mags", kind = "distribution" }
    group:item("btmp9mag_9x19mm_15", 50)
    group:item("btmp9mag_9x19mm_10rd")
    group:item("btmp9mag_9x19mm_20", 200)
    group:item("btmp9mag_9x19mm_25", 300)
    group:item("btmp9mag_9x19mm_30", 400)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_hk_mp5_no_ammo", kind = "collection" }
    group:item("hk_mp5")
    group:entry { group = "hk_mp5_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nested_hk_mp5k_no_ammo", kind = "collection" }
    group:item("hk_mp5k")
    group:entry { group = "hk_mp5_mags", count = { 1, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hk_mp5_mags", kind = "distribution" }
    group:item("mp5mag_10rd")
    group:item("mp5mag_15rd", 200)
    group:item("mp5mag_20rd", 300)
    group:item("mp5mag", 500)
    group:item("mp5mag_38rd", 50)
    content.add(group)
end
