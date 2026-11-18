local content = require("ccb").content

do
    local group = content.ItemGroup { id = "Zomborg_CBM_harvest_ranged_weapons", kind = "distribution" }
    group:item("fcl_bio_railgun", 5)
    content.extend_item_group(group)
end
