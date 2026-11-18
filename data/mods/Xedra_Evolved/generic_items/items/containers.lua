local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "wrapper_wyld",
        name = ccb.content.plural_text("candy wrapper", "candy wrappers"),
        description = ccb.content.text("\"Wyld Candy, our flavors span the possible\" is emblazoned proudly upon this shiny colorful wrapper."),
        copy_from = "wrapper",
        looks_like = "wrapper",
        replace_pockets = true,
    }
    item:container_pocket { max_volume_ml = 225, max_weight_milligrams = 1000000 }
    content.add(item)
end
