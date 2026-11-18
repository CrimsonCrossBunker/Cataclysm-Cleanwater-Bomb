local ccb = require("ccb")
local content = ccb.content

do
    -- Based on a small 400-point breadboard
    local item = content.Item {
        id = "breadboard",
        category = "spare_parts",
        name = ccb.content.plural_text("breadboard", "breadboards"),
        description = ccb.content.text("Commonly used in electronics prototyping, this solderless breadboard is a small brick of plastic filled with hundreds of holes connected by internal electrical busses.  With a few components and scraps of wire, you could quickly build a circuit on this, if you know what you're doing."),
        mass_milligrams = 100000,
        volume_ml = 80,
        longest_side_mm = 82,
        price_cents = 1000,
        price_postapoc_cents = 10,
        looks_like = "box_small",
        symbol = "#",
        color = "white",
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("copper", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "magnetron",
        category = "spare_parts",
        name = ccb.content.plural_text("magnetron", "magnetrons"),
        description = ccb.content.text("An electrical component designed to produce microwaves, for use in a microwave oven."),
        mass_milligrams = 954000,
        volume_ml = 4000,
        price_cents = 4000,
        price_postapoc_cents = 10,
        looks_like = "motor_small",
        symbol = ":",
        color = "light_gray",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "melchior_platter",
        name = ccb.content.plural_text("supercomputer platter", "supercomputer platters"),
        description = ccb.content.text("A hefty and expensive-looking golden dish engraved with concentric circuitry.  You felt the urge to rip it from a supercomputer."),
        symbol = "o",
        color = "yellow",
        mass_milligrams = 12000000,
        volume_ml = 1000,
        price_cents = 2000,
        category = "spare_parts",
        stackable = true,
    }
    item:material("steel", 1)
    item:material("gold", 1)
    content.add(item)
end
