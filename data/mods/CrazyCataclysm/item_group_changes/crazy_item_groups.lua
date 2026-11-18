local content = require("ccb").content

do
    -- Collections of magazines for the gun. Rough estimates of 1:2 for restricted to regular, 1:10 ratio of extended to regular, and 1:100 ratio of drums/very extended to regular.
    local group = content.ItemGroup { id = "magazines_akm", kind = "distribution" }
    group:item("akmag10", 300)
    group:item("akmag20", 400)
    group:item("akmag30", 500)
    group:item("akmag40")
    group:item("akmag90", 500)
    group:item("akdrum75", 50)
    content.replace(group)
end

do
    -- this is a distribution for the gun, reasonable number of backup mags, and some ammo to repack
    local group = content.ItemGroup { id = "nested_mk47", kind = "collection", with_ammo = 100 }
    group:entry { item = "mk47", charges = { 0, 30 } }
    group:item("akmag30")
    group:item("akmag30", 50)
    group:item("akmag90", 20)
    group:group("on_hand_762")
    content.replace(group)
end
