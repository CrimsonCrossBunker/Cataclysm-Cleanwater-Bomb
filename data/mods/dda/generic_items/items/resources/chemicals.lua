local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "chem_potassium_alum",
        category = "chems",
        name = ccb.content.plural_text("potassium alum", "potassium alum"),
        description = ccb.content.text("A handful of small, water-soluble white crystals with a watery metallic odor, historically used for many different purposes.  Also known as potash alum and potassium aluminum sulfate; often called simply alum, as it's the most important member of the generic class of compounds called alums."),
        default_container = "bottle_plastic_small",
        mass_milligrams = 1725,
        volume_ml = 1,
        price_cents = 10,
        price_postapoc_cents = 100,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("dense_powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "dye_powder",
        category = "chems",
        name = ccb.content.plural_text("cloth dye powder", "cloth dye powder"),
        description = ccb.content.text("A handful of powdered colorful cloth dye, which can be used to dye many fabrics if combined with water and some mordant."),
        default_container = "bottle_plastic_small",
        mass_milligrams = 1540,
        volume_ml = 1,
        price_cents = 10,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("dense_powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_calcium_chloride",
        category = "chems",
        price_cents = 12,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("calcium chloride", "calcium chloride"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of white, odorless, strongly hygroscopic powder with an extremely salty taste.  Often used as a de-icing agent or as desiccant."),
        default_container = "bag_canvas",
        volume_ml = 1,
        mass_milligrams = 2150,
        stackable = true,
    }
    item:material("dense_powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_washing_soda",
        category = "chems",
        price_cents = 12,
        price_postapoc_cents = 1,
        name = ccb.content.plural_text("washing soda", "washing soda"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of white, odorless, hygroscopic powder.  Often used as a cleansing agent and for glass manufacturing, among other things.  Also known as sodium carbonate or soda ash."),
        default_container = "box_small",
        volume_ml = 1,
        mass_milligrams = 2540,
        stackable = true,
    }
    item:material("dense_powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "chem_baking_soda",
        stackable = true,
        category = "chems",
        price_cents = 12,
        price_postapoc_cents = 2,
        name = ccb.content.plural_text("baking soda", "baking soda"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of white, odorless powder with a slightly salty alkaline taste.  Often used in baking as a leavening agent, and has many other niche uses.  Also known as sodium bicarbonate."),
        default_container = "box_small",
        volume_ml = 1,
        mass_milligrams = 2200,
    }
    item:material("dense_powder_nonflam", 1)
    content.add(item)
end

do
    -- density: 4.42 g/cm3
    local item = content.Item {
        id = "chem_mercury_fulminate",
        category = "chems",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("mercury fulminate", "mercury fulminate"),
        symbol = "=",
        color = "light_gray",
        description = ccb.content.text("A handful of gray powder that is highly sensitive to friction, heat, and shock.  Often used as a primary explosive, and historically in percussion caps and primers for self-contained firearm ammunition."),
        volume_ml = 1,
        mass_milligrams = 442,
    }
    item:material("powder", 1)
    content.add(item)
end

do
    -- density: 4.71 g/cm3
    local item = content.Item {
        id = "chem_lead_azide",
        category = "chems",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("lead azide", "lead azide"),
        symbol = "=",
        color = "white",
        description = ccb.content.text("A handful of white powder that is used in detonators to detonate secondary explosives.  It replaced mercury fulminate in modern ammunition primers."),
        volume_ml = 1,
        mass_milligrams = 471,
    }
    item:material("powder", 1)
    content.add(item)
end
