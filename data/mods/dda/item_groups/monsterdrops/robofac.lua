local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_robofac_prototype_drops", kind = "collection" }
    group:item("robofac_test_data")
    content.add(group)
end
