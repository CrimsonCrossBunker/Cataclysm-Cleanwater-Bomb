local content = require("ccb").content

do
    local group = content.ItemGroup { id = "raptor_sample_single", kind = "collection" }
    group:item("raptor_sample")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_small", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 1, 3 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_large", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 3, 6 } }
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "raptor_sample_huge", kind = "collection" }
    group:entry { item = "raptor_sample", count = { 10, 20 } }
    content.replace(group)
end
