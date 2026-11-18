local content = require("ccb").content

do
    local group = content.ItemGroup { id = "new_laptops", kind = "distribution" }
    group:entry { item = "laptop", charges = { 200, 200 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "used_laptops", kind = "distribution" }
    group:entry { item = "laptop", charges = { 0, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "civilian_laptops", kind = "distribution" }
    group:entry {
        item = "laptop",
        charges = { 0, -1 },
        contents = {
            { group = "civilian_laptop_efiles" },
        },
    }
    content.add(group)
end
