local content = require("ccb").content

do
    local group = content.ItemGroup { id = "EXODII_Shop_Guns_Tier2", kind = "collection" }
    group:entry {
        collection = {
            { item = "mom_exodii_stungun_pistol", count = { 1, 2 } },
            { item = "exodii_exodii_stungun_mag", count = { 3, 4 }, charges = { 36, 36 } },
        },
        probability = 15,
    }
    content.extend_item_group(group)
end
