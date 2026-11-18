local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "scythe_toy",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("grim reaper's scythe", "grim reaper's scythes"),
        description = ccb.content.text("A long, crooked tool used to reap souls, with a skull engraved in its blade.  Let the harvest begin."),
        mass_milligrams = 586000,
        volume_ml = 3550,
        longest_side_mm = 1500,
        price_cents = 3000,
        price_postapoc_cents = 5,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("COSPLAY_PROPS")
    content.add(item)
end
