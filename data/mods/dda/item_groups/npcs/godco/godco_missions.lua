local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "fertility_supplements",
        kind = "collection",
        container = "bottle_plastic_pill_supplement",
    }
    group:entry { item = "fert_supplement", count = { 25, 25 }, container = "null" }
    content.add(group)
end
