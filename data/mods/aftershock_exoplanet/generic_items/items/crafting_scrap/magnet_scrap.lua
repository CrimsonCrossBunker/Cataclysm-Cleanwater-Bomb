local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_magnet_1",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("high quality electromagnet", "high quality electromagnets"),
        description = ccb.content.text("A sturdy, industrially crafted electromagnet."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_magnet_2",
        copy_from = "afs_scrap_2",
        name = ccb.content.plural_text("cryo electromagnet", "cryo electromagnets"),
        description = ccb.content.text("A powerful super conductive electromagnet, that must be kept at very low temperatures to operate."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_magnet_3",
        copy_from = "afs_scrap_3",
        name = ccb.content.plural_text("super conductive electromagnet", "super conductive electromagnets"),
        description = ccb.content.text("A powerful electromagnet made from a room temperature superconductor."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_magnet_4",
        copy_from = "afs_scrap_4",
        name = ccb.content.plural_text("ferrofluid dynamo", "ferrofluid dynamos"),
        description = ccb.content.text("Black metallic fluid, harmonically flowing from one fractal shape to the next."),
        looks_like = "scrap",
    }
    content.add(item)
end
