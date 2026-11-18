local content = require("ccb").content

do
    local group = content.ItemGroup { id = "science", kind = "distribution", with_ammo = 50, with_magazine = 100 }
    group:group("museum_primitive")
    group:item("pointy_stick", 50)
    group:item("throwing_stick", 50)
    group:item("spear_stone", 50)
    content.upsert_item_group(group)
end
