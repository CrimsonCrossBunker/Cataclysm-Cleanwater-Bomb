local content = require("ccb").content

do
    local group = content.ItemGroup { id = "field", kind = "distribution" }
    group:item("rock", 400)
    group:item("rock_flaking")
    group:item("chunk_feldspar", 1)
    group:item("rock_large", 50)
    group:item("sharp_rock", 50)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "forest", kind = "distribution" }
    group:item("rock", 400)
    group:item("rock_flaking", 50)
    group:item("flint", 20)
    group:item("rock_large", 50)
    group:item("chunk_feldspar", 10)
    group:entry { item = "twig", count = { 1, 10 }, probability = 200 }
    group:item("stick", 50)
    group:item("stick_common", 900)
    group:item("stick_long", 10)
    group:entry { item = "leaves", count = { 1, 10 }, probability = 1200 }
    group:item("pine_bough", 200)
    group:item("acorns", 150)
    group:item("pinecone", 50)
    group:item("juniper", 50)
    group:item("hickory_root", 30)
    group:item("hickory_nut", 50)
    content.upsert_item_group(group)
end
