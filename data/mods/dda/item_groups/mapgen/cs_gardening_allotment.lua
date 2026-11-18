local content = require("ccb").content

do
    local group = content.ItemGroup { id = "ga_items_1", kind = "distribution" }
    group:item("seed_celery", 10)
    group:item("seed_tomato", 10)
    group:item("seed_zucchini", 10)
    group:item("seed_lettuce", 10)
    group:item("seed_cucumber", 10)
    group:item("seed_carrot", 10)
    group:item("seed_pumpkin", 10)
    group:item("seed_bottle_gourd", 2)
    group:item("seed_broccoli", 10)
    group:item("seed_spurge", 10)
    group:item("gloves_work", 10)
    content.add(group)
end
