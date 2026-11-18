local content = require("ccb").content

do
    local group = content.ItemGroup { id = "toxic_waste", kind = "distribution" }
    group:entry { item = "plut_slurry", charges = { 2, 28 }, container = "55gal_drum", probability = 5 }
    group:entry { item = "plut_slurry_dense", charges = { 1, 45 }, container = "55gal_drum", probability = 2 }
    group:entry { item = "water_sewage", charges = { 26, 126 }, container = "55gal_drum", probability = 50 }
    group:group("sewer", 20)
    group:item("55gal_drum", 50)
    group:item("slime_scrap", 10)
    content.add(group)
end
