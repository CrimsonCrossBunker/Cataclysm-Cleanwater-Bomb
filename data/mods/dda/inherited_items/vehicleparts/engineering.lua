local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "crane_pseudo_item",
        copy_from = "fake_butcher_rack",
        looks_like = "fake_butcher_rack",
        name = ccb.content.plural_text("suspending for butchering", "suspending for butchering"),
    }
    item:tool()
    content.add(item)
end
