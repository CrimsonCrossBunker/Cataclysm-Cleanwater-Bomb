local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_radiodetonator",
        copy_from = "radiocontrol",
        looks_like = "radiocontrol",
        name = ccb.content.plural_text("radio detonator", "radio detonators"),
        price_cents = 1500,
        description = ccb.content.text("A standard pattern detonator fabricated for military and industrial use.  This is an advanced model capable of controlling explosive drones alongside simpler devices."),
    }
    item:tool()
    content.add(item)
end
