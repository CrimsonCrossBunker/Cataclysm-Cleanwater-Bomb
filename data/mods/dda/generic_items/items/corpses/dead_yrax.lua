local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "broken_yrax_trifacet",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("trifacet remains", "trifacet remains"),
        category = "other",
        description = ccb.content.text("A split-open facet reveals an interior full of closely-fit geometric primitives among chipped strips of milk-white quartz.  The composition of parts lends you no clues as to how this machine ever functioned."),
        price_cents = 1000,
        volume_ml = 119000,
        mass_milligrams = 221000000,
    }
    item:material("steel", 1)
    item:material("yrax_quartz", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_yrax_triakis",
        symbol = ",",
        color = "light_gray",
        name = ccb.content.plural_text("triakis remains", "triakis remains"),
        category = "other",
        description = ccb.content.text("Its broken shell reveals an interior made from a single piece of quartz, intricately carved into a series of nested tetrahedra."),
        price_cents = 1000,
        volume_ml = 119000,
        mass_milligrams = 221000000,
    }
    item:material("steel", 1)
    item:material("yrax_quartz", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    -- A lot of gold in this bad boy.
    local item = content.Item {
        id = "broken_golden_monolith",
        symbol = "I",
        name = ccb.content.plural_text("golden monolith", "golden monoliths"),
        description = ccb.content.text("A large golden monolith.  Carefully carved asymmetric edges betray its artificial origin."),
        volume_ml = 930000,
        mass_milligrams = 8282000000,
        price_cents = 5000,
        price_postapoc_cents = 5000,
        color = "yellow",
    }
    item:material("yrax_quartz", 1)
    item:material("gold", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    local item = content.Item {
        id = "broken_yrax_delta",
        symbol = ",",
        name = ccb.content.plural_text("inert delta", "inert deltas"),
        description = ccb.content.text("A small piece of inscrutable alloy shaped like an arrow's broadhead.  It doesn't look like much of a robot once dead."),
        mass_milligrams = 374000,
        volume_ml = 500,
        longest_side_mm = 200,
        price_cents = 5000,
        price_postapoc_cents = 5000,
        melee_to_hit = -3,
        weapon_categories = { "SHIVS" },
        color = "yellow",
        techniques = { "RAPID" },
        replace_qualities = true,
    }
    item:clear_melee_damage()
    item:melee_damage("stab", 23)
    item:material("yrax_quartz", 1)
    item:material("gold", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("SHEATH_KNIFE")
    content.add(item)
end

do
    -- A lot of gold in this bad boy.
    local item = content.Item {
        id = "broken_yrax_quadraphract_leg",
        symbol = "s",
        name = ccb.content.plural_text("inert quadraphract leg", "inert quadraphract legs"),
        description = ccb.content.text("A great sickle-shaped leg, slumped and lifeless.  The metal is cold to the touch, and its near invisible joints are locked in place."),
        volume_ml = 930000,
        mass_milligrams = 8282000000,
        longest_side_mm = 4000,
        price_cents = 5000,
        price_postapoc_cents = 5000,
        color = "yellow",
    }
    item:material("yrax_quartz", 1)
    item:material("gold", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end

do
    -- A lot of gold in this bad boy.
    local item = content.Item {
        id = "broken_yrax_quadraphract",
        symbol = "X",
        name = ccb.content.plural_text("inert quadraphract", "inert quadraphracts"),
        description = ccb.content.text("A great carved piece of gold and crystal, slumped in the form of an unearthly arachnid."),
        volume_ml = 930000,
        mass_milligrams = 8282000000,
        longest_side_mm = 4000,
        price_cents = 5000,
        price_postapoc_cents = 5000,
        color = "yellow",
    }
    item:material("yrax_quartz", 1)
    item:material("gold", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    content.add(item)
end
