local content = require("ccb").content

do
    local group = content.ItemGroup { id = "HUB01_SNarayana_worn", kind = "collection" }
    group:item("boxer_briefs")
    group:item("socks")
    group:item("jumpsuit", 100, "robofac")
    group:item("boots")
    group:item("hat_ball")
    group:item("gloves_work")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "HUB01_SNarayana_carried", kind = "collection" }
    group:group("wallet_full")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "HUB01_SNarayana_wield", kind = "distribution" }
    content.add(group)
end
