local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "dimensional_perambulator",
        category = "veh_parts",
        name = ccb.content.plural_text("dimensional perambulator", "dimensional perambulators"),
        description = ccb.content.text("A perambulator, for perambulating through dimensions"),
        mass_milligrams = 1000000,
        volume_ml = 5000,
        symbol = "#",
        color = "dark_gray",
    }
    item:material("lc_steel", 1)
    content.add(item)
end
