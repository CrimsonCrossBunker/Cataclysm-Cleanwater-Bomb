local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "oven_stovetop",
        symbol = "_",
        color = "dark_gray",
        name = ccb.content.plural_text("dismantled stovetop", "dismantled stovetops"),
        category = "spare_parts",
        description = ccb.content.text("The dismantled stovetop of an electric oven.  Some electric components are still attached, but the heating elements have been pulled off."),
        price_cents = 100,
        price_postapoc_cents = 5,
        mass_milligrams = 5000000,
        volume_ml = 20000,
        longest_side_mm = 600,
        stackable = true,
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "oven_cabinet",
        symbol = "x",
        color = "dark_gray_white",
        name = ccb.content.plural_text("stripped oven cabinet", "stripped oven cabinets"),
        category = "spare_parts",
        description = ccb.content.text("A large, hefty steel box that was once the main body of an electric oven.  Most of the parts have been stripped.  It could be further disassembled into base materials."),
        price_cents = 200,
        price_postapoc_cents = 10,
        mass_milligrams = 25000000,
        volume_ml = 250000,
        longest_side_mm = 690,
        stackable = true,
    }
    item:material("budget_steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "oven_controls",
        symbol = "#",
        color = "light_cyan",
        name = ccb.content.plural_text("oven control panel", "oven control panels"),
        category = "spare_parts",
        description = ccb.content.text("The control panel and LCD from a dismantled electric oven."),
        price_cents = 100,
        price_postapoc_cents = 5,
        mass_milligrams = 1000000,
        volume_ml = 2000,
        longest_side_mm = 650,
        stackable = true,
    }
    item:material("budget_steel", 1)
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "oven_door",
        symbol = "#",
        color = "light_cyan",
        name = ccb.content.plural_text("oven door", "oven doors"),
        category = "spare_parts",
        description = ccb.content.text("The removed glass and steel door of an electric oven."),
        price_cents = 100,
        price_postapoc_cents = 5,
        mass_milligrams = 10000000,
        volume_ml = 20000,
        longest_side_mm = 690,
        stackable = true,
    }
    item:material("budget_steel", 1)
    item:material("glass", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "oven_broiler_pan",
        symbol = "_",
        color = "dark_gray_white",
        name = ccb.content.plural_text("broiler pan", "broiler pans"),
        category = "spare_parts",
        description = ccb.content.text("A simple sheet metal drawer that goes in the bottom of an electric oven."),
        price_cents = 50,
        price_postapoc_cents = 1,
        mass_milligrams = 5000000,
        volume_ml = 20000,
        longest_side_mm = 690,
        stackable = true,
    }
    item:material("budget_steel", 1)
    content.add(item)
end
