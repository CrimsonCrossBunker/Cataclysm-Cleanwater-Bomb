local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "body_astral_projection",
        copy_from = "corpse",
        name = ccb.content.plural_text("your body", "your body"),
        description = ccb.content.text("Your body, lying on the ground while your spirit walks free.  Hopefully nothing happens to it while you're gone."),
        looks_like = "corpse_generic_human",
    }
    item:material("hflesh", 1)
    content.upsert_item(item)
end
