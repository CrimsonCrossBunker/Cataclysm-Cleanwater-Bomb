local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "decorative_wreath",
        name = ccb.content.plural_text("yule wreath", "yule wreaths"),
        description = ccb.content.text("A decorative wreath that can be deployed as furniture to celebrate the winter holidays."),
        mass_milligrams = 1814000,
        volume_ml = 4000,
        price_cents = 100,
        price_postapoc_cents = 0,
        symbol = "0",
        color = "green",
        looks_like = "steel_plate",
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:deploy_furniture("f_winter_wreath")
    item:tool()
    content.add(item)
end
