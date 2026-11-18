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

do
    -- 7 lead subst. for 8 bismuth, which doesn't have its own material
    local item = content.Item {
        id = "fishing_rod_2pc_packed",
        name = ccb.content.plural_text("two-piece fishing rod (packed)", "two-piece fishing rods (packed)"),
        description = ccb.content.text("A commercial two-piece fishing rod that has been disassembled for ease of transport and storage."),
        mass_milligrams = 1050000,
        volume_ml = 1300,
        longest_side_mm = 1000,
        price_cents = 22000,
        price_postapoc_cents = 1600,
        melee_to_hit = 0,
        symbol = "/",
        color = "blue",
        looks_like = "PR24-extended",
    }
    item:material("lead", 7)
    item:material("steel", 4)
    item:material("cotton", 4)
    item:material("fiberglass", 4)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fishing_rod_2pc" },
        menu_text = ccb.content.text("Assemble"),
        message = ccb.content.text("You put together your two-piece fishing rod."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fishing_rod_2pc",
        copy_from = "fishing_rod_2pc_packed",
        name = ccb.content.plural_text("two-piece fishing rod", "two-piece fishing rods"),
        description = ccb.content.text("A commercial two-piece fishing rod, assembled and ready for use."),
        volume_ml = 1250,
        longest_side_mm = 1900,
        melee_to_hit = 1,
        replace_qualities = true,
        looks_like = "fishing_rod_professional",
    }
    item:quality("FISHING_ROD", 2)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fishing_rod_2pc_packed" },
        menu_text = ccb.content.text("Disassemble"),
        message = ccb.content.text("You take apart your two-piece fishing rod."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 1)
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:flag("REACH_ATTACK")
    item:tool()
    content.add(item)
end

do
    -- 7 lead subst. for 8 bismuth, which doesn't have its own material
    local item = content.Item {
        id = "fishing_rod_tele_packed",
        name = ccb.content.plural_text("telescoping fishing rod (packed)", "telescoping fishing rods (packed)"),
        description = ccb.content.text("A commercial telescoping fishing rod that has been retracted for ease of transport and storage."),
        mass_milligrams = 1150000,
        volume_ml = 600,
        longest_side_mm = 500,
        price_cents = 25000,
        price_postapoc_cents = 1750,
        melee_to_hit = 0,
        symbol = "/",
        color = "dark_gray",
        looks_like = "PR24-retracted",
    }
    item:material("lead", 7)
    item:material("steel", 5)
    item:material("cotton", 4)
    item:material("fiberglass", 4)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fishing_rod_tele" },
        menu_text = ccb.content.text("Extend"),
        message = ccb.content.text("You extend your telescoping fishing rod."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fishing_rod_tele",
        copy_from = "fishing_rod_tele_packed",
        name = ccb.content.plural_text("telescoping fishing rod", "telescoping fishing rods"),
        description = ccb.content.text("A commercial telescoping fishing rod, extended and ready for use."),
        volume_ml = 1300,
        longest_side_mm = 2100,
        melee_to_hit = 1,
        replace_qualities = true,
        looks_like = "fishing_rod_professional",
    }
    item:quality("FISHING_ROD", 2)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:flag("FRAGILE_MELEE")
    item:flag("REACH_ATTACK")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "fishing_rod_tele_packed" },
        menu_text = ccb.content.text("Retract"),
        message = ccb.content.text("You retract your telescoping fishing rod."),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end
