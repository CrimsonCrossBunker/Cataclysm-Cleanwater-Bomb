local content = require("ccb").content

do
    local group = content.ItemGroup { id = "robofac_basic_trade", kind = "distribution" }
    group:group("bionics_common")
    group:group("bionics_mil", 10)
    content.extend_item_group(group)
end
