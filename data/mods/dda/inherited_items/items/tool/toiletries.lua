local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "brush",
        name = ccb.content.plural_text("scrub brush", "scrub brushes"),
        description = ccb.content.text("A simple scrub brush for cleaning hard objects."),
        mass_milligrams = 70000,
        volume_ml = 350,
        longest_side_mm = 140,
        price_cents = 200,
        price_postapoc_cents = 10,
        melee_to_hit = 0,
        symbol = "/",
        color = "light_gray",
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_use_actions()
    item:native_use("WASH_HARD_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:dish_towel" }
    snippets:entry {
        id = "dtowel1",
        text = ccb.content.text("An elegant, monogrammed dish towel.  Unfortunately, they aren't your initials."),
    }
    snippets:entry {
        id = "dtowel2",
        text = ccb.content.text("An elegant, monogrammed dish towel.  It even has your initials!"),
    }
    snippets:entry { id = "dtowel3", text = ccb.content.text("A well-used dish towel, judging by the stains.") }
    snippets:entry {
        id = "dtowel4",
        text = ccb.content.text("A novelty dish towel featuring a popular children's cartoon character."),
    }
    snippets:entry {
        id = "dtowel5",
        text = ccb.content.text("A novelty dish towel which reads \"IT'S WINE O CLOCK\"."),
    }
    snippets:entry { id = "dtowel6", text = ccb.content.text("A dish towel with a floral pattern.") }
    snippets:entry { id = "dtowel7", text = ccb.content.text("A dish towel with a gingham pattern.") }
    snippets:entry { id = "dtowel8", text = ccb.content.text("A dish towel with a cat pattern.") }
    content.add(snippets)
end

do
    -- Calculated from cotton density because if I took exact product dimensions you'd have <2ml of volume BUT no way in hell is the player folding the towel so neatly.
    -- Based on https://www.amazon.com/dp/B01IG8X9E6
    local item = content.Item {
        id = "dish_towel",
        category = "other",
        name = ccb.content.plural_text("dish towel", "dish towels"),
        description = ccb.content.text("A dish towel, useful for cleaning hard surfaces."),
        mass_milligrams = 21000,
        volume_ml = 43,
        price_cents = 127,
        price_postapoc_cents = 20,
        symbol = ",",
        color = "white",
        snippet_category = "auto:dish_towel",
    }
    item:material("cotton", 1)
    item:clear_use_actions()
    item:native_use("WASH_HARD_ITEMS")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mop",
        name = ccb.content.plural_text("mop", "mops"),
        description = ccb.content.text("An unwieldy mop.  Good for cleaning up spills.  Use to mop up any 'mess' you may have made."),
        mass_milligrams = 780000,
        volume_ml = 1470,
        longest_side_mm = 1300,
        price_cents = 1000,
        price_postapoc_cents = 10,
        melee_to_hit = -1,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1" },
        weapon_categories = { "QUARTERSTAVES" },
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:native_use("MOP")
    item:quality("MOP", 1)
    item:clear_flags()
    item:flag("MOP")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mop_folded",
        name = ccb.content.plural_text("collapsible mop", "collapsible mops"),
        description = ccb.content.text("A long, unwieldy mop with a collapsible handle for convenient transportation.  You may use it to clean up any 'mess' you have made."),
        mass_milligrams = 730000,
        volume_ml = 760,
        longest_side_mm = 630,
        price_cents = 1500,
        price_postapoc_cents = 15,
        symbol = "/",
        color = "light_gray",
        looks_like = "mop",
        weapon_categories = { "QUARTERSTAVES" },
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("MOP")
    item:quality("MOP", 1)
    item:clear_use_actions()
    item:native_use("MOP")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "emery_board",
        name = ccb.content.plural_text("emery board", "emery boards"),
        description = ccb.content.text("A slim cardboard stick coated with abrasive grit, meant for shaping fingernails."),
        mass_milligrams = 4000,
        volume_ml = 12,
        longest_side_mm = 180,
        price_cents = 50,
        price_postapoc_cents = 10,
        symbol = "`",
        color = "brown",
        replace_qualities = true,
    }
    item:material("cardboard", 1)
    item:quality("FILE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "razor_blade",
        symbol = ",",
        color = "light_cyan",
        name = ccb.content.plural_text("razor blade", "razor blades"),
        description = ccb.content.text("A double-edged razor blade."),
        price_cents = 600,
        price_postapoc_cents = 100,
        mass_milligrams = 1000,
        volume_ml = 1,
        longest_side_mm = 38,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local snippets = content.SnippetCategory { id = "auto:sponge" }
    snippets:entry { id = "spng1", text = ccb.content.text("A round smiley-face sponge.") }
    snippets:entry { id = "spng2", text = ccb.content.text("A rectangular sponge with a green abrasive back.") }
    snippets:entry { id = "spng4", text = ccb.content.text("A dolphin-shaped sponge.  It looks at home in the water.") }
    snippets:entry { id = "spng5", text = ccb.content.text("A rectangular sponge.") }
    snippets:entry {
        id = "spng6",
        text = ccb.content.text("A sponge cake-shaped sponge, the abrasive pad looks like frosting."),
    }
    snippets:entry {
        id = "spng7",
        text = ccb.content.text("A sponge in the shape of a beloved character from a children's cartoon."),
    }
    snippets:entry { id = "spng8", text = ccb.content.text("A cat-shaped sponge.") }
    content.add(snippets)
end

do
    -- Based on https://www.amazon.com/dp/B08RFC3VH7
    local item = content.Item {
        id = "sponge",
        name = ccb.content.plural_text("sponge", "sponges"),
        description = ccb.content.text("A cleaning aid made of soft, porous material.  Typically used for cleaning hard objects."),
        mass_milligrams = 17000,
        volume_ml = 156,
        price_cents = 66,
        price_postapoc_cents = 10,
        symbol = "s",
        color = "yellow",
        snippet_category = "auto:sponge",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WASH_HARD_ITEMS")
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wash_kit",
        name = ccb.content.plural_text("washing kit", "washing kits"),
        description = ccb.content.text("A combination of a washboard and a scrubbing tool.  Everything you need to clean items after the apocalypse."),
        mass_milligrams = 866000,
        volume_ml = 2246,
        longest_side_mm = 400,
        price_cents = 0,
        price_postapoc_cents = 50,
        symbol = "%",
        color = "yellow",
    }
    item:material("wood", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:native_use("WASH_ALL_ITEMS")
    item:clear_flags()
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end
