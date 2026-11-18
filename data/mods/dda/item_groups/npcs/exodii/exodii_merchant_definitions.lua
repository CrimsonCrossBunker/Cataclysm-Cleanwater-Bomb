local content = require("ccb").content

do
    -- Weapon for Rubik.
    local group = content.ItemGroup { id = "NC_EXODII_TYPE_1_carried", kind = "distribution" }
    group:entry { item = "pamd68rubik", charges = { 60, 60 }, ammo = { item = "123ln" } }
    content.add(group)
end
