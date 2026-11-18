local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "golf_club",
        name = ccb.content.plural_text("golf club", "golf clubs"),
        copy_from = "golf_club",
        looks_like = "golf_club",
    }
    item:material("aluminum", 1)
    item:material("titanium", 1)
    content.replace(item)
end
