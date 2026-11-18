local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nl_exodii_lamp",
        copy_from = "exodii_lamp",
        looks_like = "exodii_lamp",
        name = ccb.content.plural_text("disconnected strange utility light", "disconnected strange utility lights"),
        description = ccb.content.text("Parts of this utility light have a curved appearance, as though the metal were grown in a lab.  Its single, round bulb will emit light if connected to power."),
    }
    content.add(item)
end
