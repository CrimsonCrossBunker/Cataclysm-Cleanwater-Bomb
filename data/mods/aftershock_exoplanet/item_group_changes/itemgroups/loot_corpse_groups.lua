local content = require("ccb").content

do
    local group = content.ItemGroup { id = "copbot", kind = "distribution" }
    group:item("baton", 8)
    group:item("tazer", 3)
    group:item("ceramic_armor", 15)
    group:item("tonfa", 10)
    group:item("shocktonfa_off", 5)
    group:entry { item = "alloy_sheet", count = { 1, 10 }, probability = 10 }
    content.upsert_item_group(group)
end
