local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_30x200mm_armature",
        copy_from = "afs_25_casing",
        looks_like = "afs_25_casing",
        name = ccb.content.plural_text("30x200mm armature", "30x200mm armatures"),
        description = ccb.content.text("The empty and partially melted remnants of a 30x200mm railgun slug launch armature."),
        mass_milligrams = 200000,
        volume_ml = 1000,
        color = "dark_gray",
    }
    item:material("lc_steel", 1)
    content.add(item)
end
