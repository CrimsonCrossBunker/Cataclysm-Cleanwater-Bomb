local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "laptop_boris",
        copy_from = "laptop",
        looks_like = "laptop",
        name = ccb.content.plural_text("Ash's laptop computer", "Ash's laptop computers"),
        description = ccb.content.text("A small, somewhat worn-out laptop computer.  The flip-top is decorated with various stickers."),
    }
    item:tool()
    content.add(item)
end
