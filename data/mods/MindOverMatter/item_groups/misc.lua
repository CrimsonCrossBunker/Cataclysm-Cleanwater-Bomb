local content = require("ccb").content

do
    local group = content.ItemGroup { id = "lightning_rifle_ammo_mags", kind = "collection" }
    group:entry { item = "mom_lightning_rifle_mag", charges = { 120, 120 }, ammo = { item = "mom_lightning_rifle_ammo" } }
    group:entry { item = "mom_lightning_rifle_mag", charges = { 120, 120 }, ammo = { item = "mom_lightning_rifle_ammo" } }
    content.add(group)
end
