local content = require("ccb").content

do
    local group = content.ItemGroup { id = "hedge_see_fae_necklace", kind = "distribution" }
    group:entry { item = "item_hedge_see_fae_necklace", charges = { 120, 240 } }
    group:entry { item = "item_hedge_see_fae_necklace", charges = { 240, 360 } }
    content.add(group)
end
