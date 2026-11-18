local content = require("ccb").content

do
    local group = content.ItemGroup { id = "iso_remediator_cache", kind = "collection" }
    group:entry { item = "iso_lewis_mag", charges = { 47, 47 }, ammo = { item = "3006" } }
    group:entry { item = "smokebomb", count = { 2, 2 } }
    group:entry { item = "xedra_rubber_mantle", count = { 2, 2 }, probability = 15 }
    group:entry { item = "grenade", count = { 2, 2 }, probability = 50 }
    content.add(group)
end
