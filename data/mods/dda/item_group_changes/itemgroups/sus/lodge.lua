local content = require("ccb").content

do
    -- items found in an archery space
    local group = content.ItemGroup { id = "SUS_hunting_archery", kind = "collection" }
    group:item("compbow", 40)
    group:item("compbow_high", 20)
    group:item("compbow_low", 30)
    group:item("compcrossbow", 25)
    group:item("recurbow", 25)
    group:item("takedown_recurbow", 3)
    group:item("quiver_takedown_bow", 1)
    group:item("reflexrecurvebow", 10)
    group:item("bow_sling", 10)
    content.add(group)
end
