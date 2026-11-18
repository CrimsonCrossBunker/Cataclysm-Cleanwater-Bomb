local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mflask_hip_whiskey",
        name = ccb.content.plural_text("endless flask", "endless flasks"),
        copy_from = "flask_hip",
        looks_like = "flask_hip",
        price_postapoc_cents = 85000,
        category = "clothing",
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "whiskey", container = "mflask_hip_whiskey", charges = 7 },
        message = ccb.content.text("You open the flask and discover it full of sweet, sweet, whiskey!"),
        moves = 50,
        need_empty = true,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "mteapot",
        copy_from = "teapot",
        looks_like = "teapot",
        category = "tools",
        name = ccb.content.plural_text("endless teapot", "endless teapots"),
        description = ccb.content.text("A small metal teapot.  Teatime wouldn't be complete without one."),
        price_postapoc_cents = 250000,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "tea_green", container = "mteapot", charges = 2 },
        message = ccb.content.text("You check the teapot and discover it full of sweet tea!  Sadly, it's cold."),
        moves = 50,
        need_empty = true,
    }
    content.add(item)
end
