local ccb = require("ccb")
local content = ccb.content

do
    -- Based on https://www.amazon.com/dp/B079ZV4V3C
    local item = content.Item {
        id = "stapler",
        category = "tools",
        name = ccb.content.plural_text("stapler", "staplers"),
        description = ccb.content.text("A desk tool for fastening sheets of paper together."),
        mass_milligrams = 148000,
        volume_ml = 320,
        longest_side_mm = 160,
        price_cents = 600,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
    }
    item:material("plastic", 17)
    item:material("aluminum", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "office_holepunch",
        category = "tools",
        name = ccb.content.plural_text("hole puncher", "hole punchers"),
        description = ccb.content.text("A metal tool that can punch a single hole in a piece of paper.  I mean, you could do more if you wanted, but you'd have to do them one at a time.  Or, if you really wanted more holes with one punch, I suppose you could fold the paper….  This is a one-cylinder hole puncher."),
        mass_milligrams = 68000,
        volume_ml = 80,
        price_cents = 400,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "office_letter_opener",
        category = "weapons",
        name = ccb.content.plural_text("letter opener", "letter openers"),
        description = ccb.content.text("A sterling silver letter opener resembling a small dagger, with a sharp point and no cutting edge.  It's used to open mail envelopes neatly and quickly."),
        mass_milligrams = 23000,
        volume_ml = 90,
        longest_side_mm = 180,
        price_cents = 4800,
        price_postapoc_cents = 100,
        symbol = ";",
        techniques = { "PRECISE" },
        weapon_categories = { "SHIVS" },
        melee_to_hit = -1,
        color = "light_gray",
    }
    item:material("silver", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("CONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 9)
    content.add(item)
end
