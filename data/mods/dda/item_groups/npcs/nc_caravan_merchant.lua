local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_CARAVAN_MERCHANT_storage", kind = "distribution" }
    group:item("duffelbag", 80)
    group:item("rucksack", 50)
    content.add(group)
end
