local content = require("ccb").content

do
    local group = content.ItemGroup { id = "wreckage", kind = "distribution" }
    group:item("chain", 5)
    group:item("lc_steel_chunk", 30)
    group:item("spring", 50)
    group:item("lc_steel_lump", 20)
    group:item("frame", 10)
    group:item("hdframe", 10)
    group:item("cu_pipe", 15)
    group:item("scrap_copper", 30)
    group:item("scrap", 30)
    group:item("pipe", 15)
    content.add(group)
end
