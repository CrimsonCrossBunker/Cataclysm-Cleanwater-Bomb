local ccb = require("ccb")
local content = ccb.content

do
    -- Based on https://www.amazon.com/dp/B001M0GB6Y
    local item = content.Item {
        id = "scissors",
        name = ccb.content.plural_text("office scissors", "office scissors"),
        description = ccb.content.text("A long pair of heavy-duty scissors.  You can use them to cut things such as fabric or plastic apart."),
        ascii_picture = "scissors",
        mass_milligrams = 48000,
        volume_ml = 93,
        longest_side_mm = 180,
        price_cents = 1400,
        price_postapoc_cents = 25,
        melee_to_hit = -3,
        symbol = ",",
        color = "light_red",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 3)
    item:quality("FABRIC_CUT", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("stab", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "scissors_child",
        name = ccb.content.plural_text("kiddie scissors", "kiddie scissors"),
        description = ccb.content.text("A pair of short scissors designed with kids in mind.  You can use them to cut things such as fabric or plastic apart, although they are probably subpar compared to other alternatives."),
        ascii_picture = "scissors",
        mass_milligrams = 50000,
        volume_ml = 80,
        longest_side_mm = 130,
        price_cents = 400,
        price_postapoc_cents = 15,
        melee_to_hit = -4,
        symbol = ",",
        color = "light_red",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("SHEATH_KNIFE")
    item:clear_melee_damage()
    item:melee_damage("stab", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "scissors_wavy",
        name = ccb.content.plural_text("wavy scissors", "wavy scissors"),
        description = ccb.content.text("A pair of wavy artistic scissors.  You can theoretically use them to cut things but you should probably not get your hopes too high."),
        ascii_picture = "scissors",
        mass_milligrams = 65000,
        volume_ml = 110,
        longest_side_mm = 160,
        price_cents = 1500,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "light_red",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -3)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("SHEATH_KNIFE")
    item:tool()
    content.add(item)
end
