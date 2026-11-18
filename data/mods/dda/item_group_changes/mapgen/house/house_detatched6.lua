local content = require("ccb").content

do
    local group = content.ItemGroup { id = "flags_pride_and_other", kind = "distribution" }
    group:item("american_flag", 20)
    group:item("state_flag", 10)
    content.add(group)
end
