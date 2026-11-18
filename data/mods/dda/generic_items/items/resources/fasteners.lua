local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "buckle_steel",
        category = "spare_parts",
        name = ccb.content.plural_text("steel buckle", "steel buckles"),
        description = ccb.content.text("A steel buckle, like the kind usually found on belts."),
        mass_milligrams = 24000,
        volume_ml = 10,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "button_plastic",
        stackable = true,
        stack_size = 20,
        category = "spare_parts",
        name = ccb.content.plural_text("button", "buttons"),
        description = ccb.content.text("A button, usually found on clothing."),
        mass_milligrams = 1000,
        volume_ml = 20,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "dark_gray",
    }
    item:variants {
        { id = "generic" },
        { id = "bone", name = ccb.content.plural_text("bone button", "bone buttons"), weight = 0 },
        { id = "steel", name = ccb.content.plural_text("steel button", "steel buttons"), weight = 0 },
        { id = "bronze", name = ccb.content.plural_text("bronze button", "bronze buttons"), weight = 0 },
        { id = "wood", name = ccb.content.plural_text("wooden button", "wooden buttons"), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "snapfastener_steel",
        copy_from = "button_plastic",
        looks_like = "button_plastic",
        name = ccb.content.plural_text("steel snap fastener", "steel snap fasteners"),
        description = ccb.content.text("A steel snap fastener, usually found on clothing."),
    }
    item:variants {}
    content.add(item)
end

do
    local item = content.Item {
        id = "touch_fastener",
        category = "spare_parts",
        name = ccb.content.plural_text("touch fastener", "touch fasteners"),
        description = ccb.content.text("A pair of cloth strips, one of which has tiny hooks and another with tiny loops.  Useful as a fastener for clothing and footwear."),
        mass_milligrams = 1000,
        volume_ml = 2,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("cotton", 1)
    content.add(item)
end
