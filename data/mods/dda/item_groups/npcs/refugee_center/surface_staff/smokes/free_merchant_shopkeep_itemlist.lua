local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_FREE_MERCHANTS_MERCHANT_worn", kind = "collection" }
    group:item("boxer_shorts")
    group:item("socks")
    group:item("pants_cargo")
    group:item("tshirt")
    group:item("trenchcoat")
    group:item("boots_steel")
    group:item("firehelmet")
    group:item("duffelbag")
    group:item("bead_bracelet")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_FREE_MERCHANTS_MERCHANT_carried", kind = "collection" }
    group:item("halligan")
    content.add(group)
end
