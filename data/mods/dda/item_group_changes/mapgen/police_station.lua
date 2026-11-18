local content = require("ccb").content

do
    local group = content.ItemGroup { id = "badge_deputy", kind = "distribution" }
    group:item("badge_deputy")
    content.add(group)
end
