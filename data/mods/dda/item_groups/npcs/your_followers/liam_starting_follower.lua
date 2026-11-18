local content = require("ccb").content

do
    local group = content.ItemGroup { id = "Liam_worn", kind = "collection" }
    group:item("socks")
    group:item("boxer_shorts")
    group:item("longshirt")
    group:item("hoodie")
    group:item("jeans")
    group:item("backpack")
    group:item("boots")
    group:item("gloves_light")
    group:item("jacket_light")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "Liam_carry", kind = "collection" }
    group:group("candy_chocolate")
    group:group("foodintincan")
    group:item("multitool")
    group:entry { item = "lighter", charges = { 100, 100 } }
    group:group("bottle_otc_painkiller_20")
    group:entry { item = "bandages", count = { 3, 3 } }
    group:entry { item = "water_clean", container = "canteen" }
    content.add(group)
end
