local content = require("ccb").content

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    -- groups together all identical weapons rechambered for the same caliber and converted with different barrel-lengths.
    local group = content.ItemGroup { id = "nested_axmc_retool_300win", kind = "collection", with_ammo = 100 }
    group:entry { group = "axmc_300", charges = { 0, 10 } }
    group:item("ai_338mag_10")
    group:item("ai_338mag_10", 50)
    group:group("on_hand_300")
    content.add(group)
end
