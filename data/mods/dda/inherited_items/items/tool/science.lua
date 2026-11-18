local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "light_detector",
        category = "spare_parts",
        name = ccb.content.plural_text("light detector", "light detectors"),
        description = ccb.content.text("A photodiode on a chip, designed to convert incoming light to electrical energy for quantification."),
        mass_milligrams = 5000,
        volume_ml = 20,
        price_cents = 400,
        price_postapoc_cents = 250,
        looks_like = "e_scrap",
        symbol = "#",
        color = "light_gray",
    }
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:material("plastic", 1)
    item:fault_group("electronic_general", {  })
    content.add(item)
end

do
    -- Volume here is displacement volume of a corked 25mL test tube.
    local item = content.Item {
        id = "glass_tube_small",
        category = "spare_parts",
        name = ccb.content.plural_text("small glass tube", "small glass tubes"),
        description = ccb.content.text("A small glass tube.  Small, tube-shaped, and made of glass."),
        mass_milligrams = 9000,
        volume_ml = 30,
        price_cents = 10,
        price_postapoc_cents = 10,
        symbol = "|",
        color = "white",
        replace_pockets = true,
    }
    item:material("glass", 1)
    item:container_pocket { max_volume_ml = 25, max_weight_milligrams = 100000, rigid = true, watertight = true }
    content.add(item)
end
