local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "mill_vertical",
        name = ccb.content.plural_text("disconnected vertical mill", "disconnected vertical mills"),
        description = ccb.content.text("A vertical milling machine commonly known as a Bridgeport.  Needs to be placed and plugged into a power source."),
        looks_like = "f_heavy_lathe",
        symbol = "M",
        color = "cyan_red",
        longest_side_mm = 1070,
        volume_ml = 275000,
        mass_milligrams = 1134000000,
    }
    item:material("iron", 1)
    content.add(item)
end
