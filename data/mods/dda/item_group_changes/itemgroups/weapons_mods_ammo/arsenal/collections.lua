local content = require("ccb").content

do
    local group = content.ItemGroup { id = "milspec_arsenal_group_only_guns", kind = "distribution" }
    group:group("milspec_arsenal_group_guns")
    group:group("milspec_arsenal_group_heavy", 10)
    content.add(group)
end
