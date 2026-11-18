local content = require("ccb").content

do
    local group = content.ItemGroup { id = "altered_item", kind = "distribution" }
    group:item("altered_comb", 10)
    group:item("altered_phone", 10)
    group:item("altered_keyring", 10)
    group:item("altered_rubicks_cube", 10)
    group:item("altered_teapot", 10)
    group:item("altered_shirt", 10)
    group:item("altered_badge", 10)
    group:item("altered_sunglasses", 10)
    group:item("altered_scissors", 10)
    group:item("altered_jacket", 10)
    group:item("altered_necklace", 10)
    group:item("altered_apron", 10)
    content.add(group)
end
