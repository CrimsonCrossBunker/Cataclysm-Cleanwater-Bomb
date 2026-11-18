local content = require("ccb").content

do
    local group = content.ItemGroup { id = "HUB01_ADzvonko_worn", kind = "collection" }
    group:item("bra")
    group:item("panties")
    group:item("socks")
    group:item("jumpsuit", 100, "robofac")
    group:item("sneakers")
    group:item("sweater")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "HUB01_ADzvonko_carried", kind = "collection" }
    group:group("wallets_science")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "HUB01_ADzvonko_wield", kind = "distribution" }
    content.add(group)
end
