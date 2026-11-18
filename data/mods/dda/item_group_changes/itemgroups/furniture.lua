local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bed", kind = "distribution" }
    group:item("blanket", 2500)
    group:item("down_blanket", 1300)
    group:item("blanket_weighted", 650)
    group:item("pillow", 3000)
    group:item("down_pillow", 1500)
    group:item("electric_blanket", 400)
    group:item("quilt", 1000)
    group:item("quilt_patchwork", 800)
    group:item("teddy_bear", 190, "toy_plush_teddy")
    group:item("teddy_bear", 10)
    group:item("shark_plushie", 5)
    group:item("bodypillow", 2)
    content.upsert_item_group(group)
end
