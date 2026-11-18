local content = require("ccb").content

do
    local group = content.ItemGroup { id = "HUB01_DNovak_worn", kind = "collection" }
    group:item("bra")
    group:item("panties")
    group:item("socks")
    group:item("jumpsuit", 100, "robofac")
    group:item("boots_steel")
    group:item("vest")
    group:item("gloves_work")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "HUB01_DNovak_carried", kind = "collection" }
    group:group("wallet_full")
    group:item("flashlight")
    group:item("screwdriver_set")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "HUB01_DNovak_wield", kind = "distribution" }
    content.add(group)
end
