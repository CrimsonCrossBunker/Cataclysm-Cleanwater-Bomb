local content = require("ccb").content

do
    local group = content.ItemGroup { id = "vending_drink_items", kind = "distribution" }
    group:item("water_clean", 90)
    group:item("water_mineral", 10)
    group:item("oj", 50)
    group:item("pineapple_juice", 50)
    group:item("juice", 50)
    group:item("cranberry_juice", 50)
    group:item("sports_drink", 50)
    group:item("apple_cider", 50)
    group:item("lemonade", 50)
    group:item("energy_drink", 55)
    group:item("energy_drink_atomic", 4)
    group:group("soda_in_small_container", 450)
    group:item("herbal_tea", 30)
    group:item("V8", 15)
    content.add(group)
end
