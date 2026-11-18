local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "adhesive_bandages",
        category = "drugs",
        name = ccb.content.plural_text("adhesive bandage", "adhesive bandages"),
        description = ccb.content.text("A small medical dressing made of a piece of sterile cloth and sticky tape, used for small injuries not serious enough to require a full-size bandage."),
        mass_milligrams = 1000,
        volume_ml = 2,
        price_cents = 5,
        price_postapoc_cents = 2,
        symbol = "!",
        color = "white",
        stackable = true,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 1, bleed = 4, move_cost = 750 }
    content.add(item)
end

do
    local item = content.Item {
        id = "alcohol_wipes",
        category = "drugs",
        name = ccb.content.plural_text("alcohol wipe", "alcohol wipes"),
        description = ccb.content.text("A wet wipe saturated with alcohol and stored in a sterile package.  Used for personal hygiene or disinfecting small wounds."),
        mass_milligrams = 1500,
        volume_ml = 3,
        price_cents = 10,
        price_postapoc_cents = 6,
        symbol = ",",
        color = "white",
        stackable = true,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("IRREPLACEABLE_CONSUMABLE")
    item:clear_use_actions()
    item:heal { disinfectant_power = 2, bite = 0.3, move_cost = 500 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bandages",
        category = "drugs",
        name = ccb.content.plural_text("bandage", "bandages"),
        description = ccb.content.text("A sterile cloth bandage.  Used for stopping blood loss and protecting wounds from aggravation to help them heal faster."),
        mass_milligrams = 70000,
        volume_ml = 27,
        price_cents = 65,
        price_postapoc_cents = 20,
        symbol = "!",
        color = "white",
        stackable = true,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 4, bleed = 15, move_cost = 6000 }
    content.add(item)
end

do
    -- 10 x 60 cm, three out of a sheet
    local item = content.Item {
        id = "bandages_makeshift",
        name = ccb.content.plural_text("makeshift bandage", "makeshift bandages"),
        copy_from = "bandages",
        looks_like = "bandages",
        stackable = false,
        description = ccb.content.text("A reasonably clean piece of cloth wrapped for use as a simple bandage.  Better than nothing."),
        mass_milligrams = 8000,
        volume_ml = 16,
        price_postapoc_cents = 3,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 2, bleed = 10, move_cost = 6000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bandages_makeshift_bleached",
        name = ccb.content.plural_text("bleached makeshift bandage", "bleached makeshift bandages"),
        copy_from = "bandages_makeshift",
        looks_like = "bandages_makeshift",
        description = ccb.content.text("A piece of cloth treated with a bleach solution to sterilize it for use as a bandage."),
        price_postapoc_cents = 15,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 3, bleed = 10, move_cost = 6000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "bandages_makeshift_boiled",
        name = ccb.content.plural_text("boiled makeshift bandage", "boiled makeshift bandages"),
        copy_from = "bandages_makeshift",
        looks_like = "bandages_makeshift",
        description = ccb.content.text("A piece of cloth boiled in water to sterilize it for use as a bandage."),
        price_postapoc_cents = 15,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 3, bleed = 10, move_cost = 6000 }
    content.add(item)
end

do
    local item = content.Item {
        id = "cotton_ball",
        name = ccb.content.plural_text("cotton balls", "cotton balls"),
        description = ccb.content.text("Fluffy balls of clean, white cotton.  They can serve as makeshift bandages in an emergency."),
        category = "spare_parts",
        mass_milligrams = 12000,
        volume_ml = 25,
        price_cents = 50,
        price_postapoc_cents = 5,
        symbol = "*",
        color = "white",
        stackable = true,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 2, bleed = 3, move_cost = 3000 }
    content.add(item)
end

do
    -- Can't copy-from rag, it breaks the stacking for some reason!
    local item = content.Item {
        id = "disinrag",
        category = "drugs",
        name = ccb.content.plural_text("antiseptic soaked rag", "antiseptic soaked rags"),
        description = ccb.content.text("A rag soaked in antiseptic.  Useful for light wounds, probably won't help with deep bites."),
        mass_milligrams = 80000,
        volume_ml = 250,
        price_cents = 250,
        price_postapoc_cents = 50,
        symbol = ",",
        color = "white",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal {
        disinfectant_power = 2,
        bite = 0.5,
        move_cost = 6000,
        used_up_item = { id = "cotton_patchwork", quantity = 1, flags = { "FILTHY" } },
    }
    content.add(item)
end

do
    -- Can't copy-from cotton_ball, breaks volume
    local item = content.Item {
        id = "disincotton_ball",
        category = "drugs",
        name = ccb.content.plural_text("antiseptic soaked cotton balls", "antiseptic soaked cotton balls"),
        description = ccb.content.text("Fluffy balls of clean white cotton.  Now that they've been soaked with antiseptic, they are somewhat useful to disinfect a wound."),
        mass_milligrams = 15000,
        volume_ml = 30,
        price_cents = 250,
        price_postapoc_cents = 50,
        symbol = "*",
        color = "white",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal {
        disinfectant_power = 3,
        bite = 0.66,
        move_cost = 6000,
        used_up_item = { id = "cotton_ball", quantity = 1, charges = 1, flags = { "FILTHY" } },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "medical_gauze",
        category = "drugs",
        name = ccb.content.plural_text("medical gauze", "medical gauzes"),
        description = ccb.content.text("A decent-sized piece of cotton, sterilized and sealed.  It's designed for medical purposes."),
        mass_milligrams = 90000,
        volume_ml = 200,
        price_cents = 350,
        price_postapoc_cents = 200,
        symbol = ",",
        color = "white",
        stackable = true,
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { bandages_power = 4, bleed = 5, move_cost = 6000 }
    content.add(item)
end
