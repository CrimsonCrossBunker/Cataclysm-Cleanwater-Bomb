local ccb = require("ccb")
local content = ccb.content

do
    -- Based on page 6 of https://github.com/user-attachments/files/18196633/UsingimprovedkilnstoproducecharcoalinKenya-Apracticalguide.pdf
    local item = content.Item {
        id = "char_kiln",
        category = "tools",
        name = ccb.content.plural_text("portable charcoal kiln", "portable charcoal kilns"),
        description = ccb.content.text("A somewhat portable drum kiln to produce charcoal via pyrolysis: the incomplete burning of organic materials in the absence of oxygen.  Needs to be deployed before use."),
        mass_milligrams = 21000000,
        volume_ml = 201000,
        price_cents = 16000,
        price_postapoc_cents = 1000,
        replace_pockets = true,
        symbol = ";",
        color = "dark_gray",
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 200000, max_weight_milligrams = 500000000, rigid = true }
    item:clear_use_actions()
    item:deploy_furniture("f_kiln_portable_empty")
    content.add(item)
end
