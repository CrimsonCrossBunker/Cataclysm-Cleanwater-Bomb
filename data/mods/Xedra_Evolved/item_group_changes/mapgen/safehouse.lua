local content = require("ccb").content

do
    local group = content.ItemGroup { id = "basement_survival_last_stand_casing", kind = "distribution" }
    group:entry { item = "308_casing", charges = { 1, 1 } }
    group:entry { item = "ammolink308", charges = { 1, 1 } }
    content.replace(group)
end
