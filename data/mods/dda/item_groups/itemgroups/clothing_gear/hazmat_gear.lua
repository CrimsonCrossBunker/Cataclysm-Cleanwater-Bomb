local content = require("ccb").content

do
    -- Various types of hazmat suits, without masks
    local group = content.ItemGroup { id = "hazmat_suits", kind = "distribution" }
    group:entry {
        collection = {
            { item = "cleansuit" },
            { item = "gloves_rubber" },
            { item = "boots_rubber" },
        },
        probability = 40,
    }
    group:item("hazmat_suit", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hazmat_torso", kind = "distribution" }
    group:item("cleansuit", 40)
    group:item("technician_coveralls", 60)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hazmat_boots", kind = "distribution" }
    group:item("boots_rubber", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hazmat_gloves", kind = "distribution" }
    group:item("gloves_medical", 60)
    group:item("gloves_rubber", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hazmat_full", kind = "distribution" }
    group:item("hazmat_suit")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "hazmat_eyes", kind = "distribution" }
    group:item("glasses_safety", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "decontamination_room", kind = "collection" }
    group:item("hazmat_suit", 60)
    group:group("papr_kit", 80)
    group:entry { item = "rad_monitor", charges = { 0, 100 }, probability = 33 }
    group:group("iodine_bottle_plastic_pill_supplement_1_10", 33)
    group:group("full_1st_aid", 15)
    group:entry { item = "geiger_off", charges = { 0, 100 }, probability = 15 }
    content.add(group)
end
