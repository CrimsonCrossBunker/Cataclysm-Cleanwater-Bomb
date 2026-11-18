local content = require("ccb").content

do
    local group = content.ItemGroup { id = "dive_shop_tanks", kind = "distribution" }
    group:entry { item = "small_scuba_tank", charges = { 5, 20 }, probability = 40 }
    group:entry { item = "scuba_tank", charges = { 10, 60 }, probability = 60 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dive_shop_books", kind = "distribution" }
    group:item("manual_swimming")
    group:item("emergency_book", 50)
    group:item("manual_first_aid", 20)
    group:item("textbook_firstaid", 10)
    content.add(group)
end
