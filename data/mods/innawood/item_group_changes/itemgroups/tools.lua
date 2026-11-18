local content = require("ccb").content

do
    -- Common household tools that are small enough to fit in a bag
    local group = content.ItemGroup { id = "tools_common_small", kind = "distribution" }
    group:item("primitive_hammer", 80)
    group:item("stone_chopper", 60)
    group:item("stone_polishing", 30)
    group:item("drill_rock_primitive", 50)
    group:item("sieve_primitive", 20)
    content.replace(group)
end
