local content = require("ccb").content

do
    local group = content.ItemGroup { id = "EXODII_CBM_unlocks_weapons_heavy", kind = "distribution" }
    group:item("fcl_bio_railgun", 5)
    content.extend_item_group(group)
end
