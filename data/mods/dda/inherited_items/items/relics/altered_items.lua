local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "altered_scissors",
        copy_from = "scissors",
        looks_like = "scissors",
        name = ccb.content.plural_text("antique scissors", "antique scissors"),
        description = ccb.content.text("A pair of ornately decorated steel scissors.  The handle is decorated with vicious-looking birds."),
    }
    item:tool()
    content.add(item)
end
