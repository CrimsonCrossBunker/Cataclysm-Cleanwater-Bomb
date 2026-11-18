local content = require("ccb").content

do
    local group = content.ItemGroup { id = "TACOMA_Dana_carried", kind = "collection" }
    group:entry { item = "bandages", count = { 3, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "TACOMA_Dana_worn", kind = "collection" }
    group:item("bra")
    group:item("panties")
    group:item("socks")
    group:item("longshirt")
    group:item("jeans")
    group:item("leather_belt")
    group:item("jacket_leather")
    group:item("apron_leather")
    group:item("boots")
    group:item("purse")
    group:entry { item = "glock_17", charges = { 17, 17 }, container = "holster", ammo = { item = "9mm" } }
    group:entry { item = "machete", container = "scabbard" }
    content.add(group)
end
