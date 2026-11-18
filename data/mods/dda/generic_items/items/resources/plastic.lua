local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "10l_plastic",
        category = "spare_parts",
        name = ccb.content.plural_text("10 L plastic block", "10 L plastic blocks"),
        description = ccb.content.text("A ten-liter block of solid plastic."),
        mass_milligrams = 10000000,
        volume_ml = 10000,
        price_cents = 23150,
        price_postapoc_cents = 230,
        symbol = "=",
        color = "light_blue",
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "5l_plastic",
        category = "spare_parts",
        name = ccb.content.plural_text("5 L plastic block", "5 L plastic blocks"),
        description = ccb.content.text("A five-liter block of solid plastic."),
        mass_milligrams = 5000000,
        volume_ml = 5000,
        price_cents = 11575,
        price_postapoc_cents = 116,
        symbol = "=",
        color = "light_blue",
        stackable = true,
    }
    item:material("plastic", 1)
    content.add(item)
end

do
    -- Roughly 1.6 square meters of 1 mil (0.0254 mm) thick HDPE plastic, density 0.94 g/cm3, like a strong garbage bag is made of.
    local item = content.Item {
        id = "plastic_sheet",
        category = "spare_parts",
        name = ccb.content.plural_text("large plastic sheet", "large plastic sheets"),
        description = ccb.content.text("A large sheet of flexible plastic, the sort that might have been used for commercial wrapping or for weather-sealing a home."),
        mass_milligrams = 40000,
        volume_ml = 42,
        price_cents = 0,
        price_postapoc_cents = 25,
        replace_qualities = true,
        symbol = ")",
        color = "light_blue",
        stackable = true,
    }
    item:material("plastic", 1)
    item:quality("SURFACE", 3)
    item:clear_use_actions()
    item:deploy_furniture("f_plastic_groundsheet")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_sheet_small",
        category = "spare_parts",
        name = ccb.content.plural_text("plastic sheet", "plastic sheets"),
        description = ccb.content.text("A small sheet of flexible plastic, like a cut-up garbage bag.  It might be useful for waterproofing clothes."),
        mass_milligrams = 5000,
        volume_ml = 5,
        price_cents = 0,
        price_postapoc_cents = 2,
        symbol = ",",
        stackable = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    local item = content.Item {
        id = "rigid_plastic_sheet",
        category = "spare_parts",
        name = ccb.content.plural_text("rigid plastic sheet", "rigid plastic sheets"),
        description = ccb.content.text("A large, rigid sheet of transparent polycarbonate, useful for all manner of things; from construction to art, or even amateur snowboarding."),
        mass_milligrams = 14875000,
        volume_ml = 12500,
        longest_side_mm = 1220,
        price_cents = 0,
        price_postapoc_cents = 25,
        symbol = ")",
        color = "light_blue",
        stackable = true,
    }
    item:material("hard_plastic_transp", 1)
    content.add(item)
end

do
    -- Assuming a 17x6x0.2 cm polycarbonate sheet with a density of 1200 kg/m.
    local item = content.Item {
        id = "panoramic_eyepiece",
        category = "spare_parts",
        name = ccb.content.plural_text("panoramic lens", "panoramic lenses"),
        description = ccb.content.text("A relatively broad strip of chemical and impact-resistant polycarbonate plastic, most commonly used for the construction of wide-view visors and single-element eye pieces that offer maximal vision."),
        mass_milligrams = 24000,
        volume_ml = 20,
        longest_side_mm = 170,
        price_cents = 0,
        price_postapoc_cents = 5,
        symbol = ",",
        color = "light_blue",
        stackable = true,
    }
    item:material("hard_plastic_transp", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    -- Stats are completely provisional and formulated on a scientific, "it feels about right" basis. I couldn't find any hard numbers on the internet and wasn't particularly in the mood to butcher a gas mask, weigh the component, and find out. If you are, however, feel free to update these values accordingly.
    local item = content.Item {
        id = "inhalation_valve",
        category = "spare_parts",
        name = ccb.content.plural_text("inhalation valve", "inhalation valves"),
        description = ccb.content.text("An essential component of any gas mask, this is a small one-way valve that allows purified air to pass from a gas respirator's filter element to the mask's interior, delivering safe, breathable air to one's lungs."),
        mass_milligrams = 10000,
        volume_ml = 10,
        price_cents = 0,
        price_postapoc_cents = 5,
        symbol = ",",
        color = "light_blue",
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("rubber", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end

do
    -- Numbers sourced from measuring the filter housing of a size 1 PMK 2 gas mask and assuming a polycarbonate density of 1200 kg/m for a 4.5x3.5 cm cylinder.
    local item = content.Item {
        id = "filter_port_40mm",
        category = "spare_parts",
        name = ccb.content.plural_text("40mm filter port", "40mm filter ports"),
        description = ccb.content.text("A compact plastic and metal housing with a threaded exterior, designed to retain a screwed-on 40-mm canister filter and allow the airtight passage of air from the filter media to a gas mask's inhalation valve."),
        mass_milligrams = 51000,
        volume_ml = 43,
        longest_side_mm = 45,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_blue",
        stackable = true,
    }
    item:material("hard_plastic_transp", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    content.add(item)
end
