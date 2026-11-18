local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_laserturret",
        symbol = ",",
        color = "green",
        name = ccb.content.plural_text("broken laser turret", "broken laser turrets"),
        mass_milligrams = 110000000,
        copy_from = "broken_turret",
        looks_like = "broken_turret",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lobotomizer_weapon",
        category = "weapons",
        name = ccb.content.plural_text("lobotomizer", "lobotomizers"),
        description = ccb.content.text("A hand-forged collapsible tool with two axe heads and a sharp shovel-like tip on one end.  It can be used as a shovel, or you could chop some zombies with it instead."),
        mass_milligrams = 2722000,
        volume_ml = 1750,
        price_cents = 25000,
        price_postapoc_cents = 1250,
        melee_to_hit = -1,
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP" },
        weapon_categories = { "HOOKING_WEAPONRY" },
    }
    item:material("steel", 1)
    item:quality("DIG", 2)
    item:quality("AXE", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -11)
    item:quality("COOK", 1)
    item:clear_flags()
    item:flag("NEEDS_UNFOLD")
    item:flag("BELT_CLIP")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 37)
    content.add(item)
end

do
    local item = content.Item {
        id = "necropolis_leaflet",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("vault leaflet", "vault leaflets"),
        snippet_category = "necropolis_intro",
        description = ccb.content.text("A folded glossy handout that appears to be an introduction to living in a massive underground complex."),
        looks_like = "flyer",
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 1,
    }
    item:material("paper", 1)
    content.add(item)
end
