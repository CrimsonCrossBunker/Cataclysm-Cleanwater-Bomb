local content = require("ccb").content

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mk47", kind = "collection", with_ammo = 100 }
    group:entry { item = "mk47", charges = { 0, 30 } }
    group:item("akmag30")
    group:item("akmag30", 50)
    group:group("on_hand_762")
    content.add(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_p226_9mm", kind = "collection", with_ammo = 100 }
    group:entry { item = "p226_9mm", charges = { 0, 15 } }
    group:item("p226mag_15rd_9x19mm")
    group:item("p226mag_15rd_9x19mm", 50)
    group:group("on_hand_9mm")
    content.add(group)
end
