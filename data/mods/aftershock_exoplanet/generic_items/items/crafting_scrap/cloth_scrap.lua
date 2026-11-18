local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_cloth_4",
        copy_from = "afs_scrap_4",
        name = ccb.content.plural_text("woven metamaterial sheet", "woven metamaterial sheets"),
        description = ccb.content.text("An intricately spun and carefully engineered sheet of iridescent fibers."),
        looks_like = "cotton_patchwork",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cloth_5",
        copy_from = "afs_scrap_5",
        name = ccb.content.plural_text("tyrium ribbon", "tyrium ribbons"),
        description = ccb.content.text("A ribbon of reality lies where it yielded to the economic necessity of lifting freight into the stars."),
        looks_like = "cotton_patchwork",
    }
    content.add(item)
end
