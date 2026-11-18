local content = require("ccb").content

do
    local group = content.ItemGroup { id = "HUB01_JFarrier_worn", kind = "collection" }
    group:item("briefs")
    group:item("socks")
    group:item("jumpsuit", 100, "robofac")
    group:item("bandana")
    group:item("boots_steel")
    group:item("tool_belt")
    group:item("gloves_work")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "HUB01_JFarrier_carried", kind = "collection" }
    group:group("wallet_full")
    group:item("multitool")
    group:item("screwdriver_set")
    group:item("hammer")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "HUB01_JFarrier_wield", kind = "distribution" }
    content.add(group)
end
