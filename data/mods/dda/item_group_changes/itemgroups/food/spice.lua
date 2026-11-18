local content = require("ccb").content

do
    local group = content.ItemGroup {
        id = "pepper_bottle_plastic_small_full",
        kind = "collection",
        container = "bottle_plastic_seasoning_small",
    }
    group:entry { item = "pepper", count = { 50, 50 }, container = "null" }
    content.add(group)
end
