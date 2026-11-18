local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "caotel_cell_spent",
        copy_from = "caotel_cell_spent",
        looks_like = "caotel_cell_spent",
        name = ccb.content.plural_text("spent plasma cell", "spent plasma cells"),
        description = ccb.content.text("A plasma cell that has been depleted of energy.  It cannot be recharged."),
    }
    content.replace(item)
end
