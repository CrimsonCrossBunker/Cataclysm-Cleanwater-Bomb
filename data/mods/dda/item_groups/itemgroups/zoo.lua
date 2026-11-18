local content = require("ccb").content

do
    local group = content.ItemGroup { id = "shelves_zoo", kind = "distribution" }
    group:group("SUS_janitors_closet", 15)
    group:group("gift_shop", 25)
    group:group("tools_general", 10)
    content.add(group)
end
