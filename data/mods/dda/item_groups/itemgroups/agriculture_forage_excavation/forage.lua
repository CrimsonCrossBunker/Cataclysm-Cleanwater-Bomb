local content = require("ccb").content

do
    local group = content.ItemGroup { id = "forage_winter", kind = "distribution" }
    group:entry { item = "wintergreen_berry", count = { 1, 3 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "forage_mushroom", kind = "distribution" }
    group:entry { item = "mushroom", count = { 1, 3 }, probability = 4 }
    group:entry { item = "mushroom_morel", count = { 1, 4 }, probability = 2 }
    content.add(group)
end
