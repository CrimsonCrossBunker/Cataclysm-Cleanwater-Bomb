local content = require("ccb").content

do
    local group = content.ItemGroup { id = "xedra_mags_troll", kind = "collection" }
    group:entry { item = "8x40_25_mag", charges = { 25, 25 }, ammo = { item = "8mm_hvp" } }
    group:entry { item = "8x40_25_mag", charges = { 25, 25 }, ammo = { item = "8mm_hvp" } }
    content.add(group)
end
