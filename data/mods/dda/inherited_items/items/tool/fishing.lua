local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fishing_rod_basic",
        name = ccb.content.plural_text("basic fishing rod", "basic fishing rods"),
        description = ccb.content.text("'Fishing rod' might be a bit too charitable of a description.  In truth, this is a stick with a piece of string and a hook."),
        mass_milligrams = 1700000,
        volume_ml = 1250,
        longest_side_mm = 900,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = 0,
        symbol = "/",
        color = "brown",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:flag("FRAGILE_MELEE")
    item:flag("FIREWOOD")
    item:quality("FISHING_ROD", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    content.add(item)
end

do
    -- 7 lead subst. for 8 bismuth, which doesn't have its own material
    local item = content.Item {
        id = "fishing_rod_professional",
        name = ccb.content.plural_text("pro fishing rod", "pro fishing rods"),
        description = ccb.content.text("A professional fishing rod with a matching set of weights.  With this, you should be able to catch 'em all."),
        mass_milligrams = 1000000,
        volume_ml = 1250,
        longest_side_mm = 2000,
        price_cents = 20000,
        price_postapoc_cents = 1500,
        melee_to_hit = 1,
        symbol = "/",
        color = "brown",
        replace_qualities = true,
    }
    item:material("lead", 7)
    item:material("steel", 4)
    item:material("cotton", 4)
    item:material("fiberglass", 3)
    item:quality("FISHING_ROD", 2)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:flag("FRAGILE_MELEE")
    item:flag("REACH_ATTACK")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    -- based on the ka-bar kaster
    local item = content.Item {
        id = "plastichoboreel",
        looks_like = "baton",
        name = ccb.content.plural_text("plastic hand fishing reel", "plastic hand fishing reels"),
        description = ccb.content.text("A commercial hand fishing reel.  It is a short rod with a section on one end with fishing line wrapped around it, with a rotating guard around that.  It is not as effective as a normal fishing pole, but is much more compact."),
        mass_milligrams = 400000,
        volume_ml = 400,
        longest_side_mm = 158,
        melee_to_hit = -1,
        price_cents = 1300,
        price_postapoc_cents = 750,
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:material("plastic", 1)
    item:quality("FISHING_ROD", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hoboreel",
        looks_like = "pointy_stick",
        name = ccb.content.plural_text("wooden hand fishing reel", "wooden hand fishing reels"),
        description = ccb.content.text("A short wooden rod with a section on one end with fishing line wrapped around it, with a notch to put the string though to help pull in fish.  It is not as effective as a normal fishing pole, but is much more compact than them."),
        mass_milligrams = 500000,
        volume_ml = 380,
        longest_side_mm = 150,
        melee_to_hit = -1,
        price_cents = 3500,
        price_postapoc_cents = 750,
        symbol = "/",
        color = "brown",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FIREWOOD")
    item:quality("FISHING_ROD", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end
