local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "milbot_base_chassis",
        name = ccb.content.plural_text("military robot chassis", "military robot chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  It's the skeleton and armor of the military robot."),
        symbol = "c",
        mass_milligrams = 40000000,
        volume_ml = 70000,
        price_cents = 200000,
        category = "spare_parts",
        color = "red_green",
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "milbot_humaniform_chassis",
        name = ccb.content.plural_text("military humaniform chassis", "military humaniform chassis"),
        description = ccb.content.text("What's left when you remove all moving parts and electronics.  You still feel deep down that its hollow eyes are studying you."),
        symbol = "c",
        mass_milligrams = 40000000,
        volume_ml = 70000,
        price_cents = 200000,
        category = "spare_parts",
        color = "red_green",
    }
    item:material("steel", 1)
    content.add(item)
end
