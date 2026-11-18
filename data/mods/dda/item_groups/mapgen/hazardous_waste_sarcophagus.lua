local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hazardous_waste", kind = "distribution" }
    group:entry { item = "water_sewage", charges = { 26, 126 }, container = "55gal_drum", probability = 40 }
    group:group("meat_tainted_55gal_drum_3_20", 2)
    group:group("toxic_waste_mx_chems", 35)
    group:item("55gal_drum", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nanomaterials", kind = "collection" }
    group:entry { item = "nanomaterial", count = { 25, 75 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "meat_tainted_55gal_drum_3_20", kind = "collection", container = "55gal_drum" }
    group:entry { item = "meat_tainted", count = { 3, 20 } }
    content.add(group)
end
