local ccb = require("ccb")
local content = ccb.content

do
    -- With the assumption that it's a cylinder of 18in length and 1.5in diameter. Listing says 0.5in width BUT the crowbar itself is curved a little and package dimensions said 1.57in so I rounded it down slightly.
    -- Based on https://www.amazon.com/dp/B07B4JDQB4
    local item = content.Item {
        id = "crowbar",
        name = ccb.content.plural_text("crowbar", "crowbars"),
        description = ccb.content.text("A hefty prying tool.  Use it to open locked doors without destroying them, or to lift manhole covers.  You could also wield it to bash some heads in."),
        mass_milligrams = 1456000,
        volume_ml = 520,
        longest_side_mm = 460,
        price_cents = 2600,
        price_postapoc_cents = 500,
        melee_to_hit = 0,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "BATONS" },
    }
    item:material("steel", 1)
    item:quality("PRY", 3)
    item:quality("HAMMER", 1)
    item:quality("PRYING_NAIL", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 19)
    item:melee_damage("cut", 1)
    item:fault_group("steel_pipe_short", { weight_multiplier = 0.2 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "emergency_lockpick",
        name = ccb.content.plural_text("rudimentary lockpick", "rudimentary lockpicks"),
        description = ccb.content.text("A pair of thin pieces of metal, one bent in an 'L' shape to push tumblers and the other acting as a torsion wrench.  These tools are almost totally inadequate for picking locks, but when you've got nothing else, it might work."),
        ascii_picture = "crude_picklock",
        mass_milligrams = 25000,
        volume_ml = 5,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("LOCKPICK", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "crude_picklock",
        name = ccb.content.plural_text("improvised lockpick", "improvised lockpicks"),
        description = ccb.content.text("An improvised pick and torsion wrench made from scrap metal.  You'll need MacGyver-like skills to open locks with these as they are brittle, but they lower the chances of alarms being set off."),
        ascii_picture = "crude_picklock",
        mass_milligrams = 23000,
        volume_ml = 5,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("LOCKPICK", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "iceaxe",
        name = ccb.content.plural_text("ice axe", "ice axes"),
        description = ccb.content.text("An ice axe with a hammer on the other end, a multi-purpose hiking and climbing tool used by mountaineers.  It is sturdy enough to lift manhole covers."),
        mass_milligrams = 300000,
        volume_ml = 140,
        longest_side_mm = 500,
        price_cents = 5000,
        price_postapoc_cents = 500,
        melee_to_hit = -1,
        symbol = ";",
        color = "dark_gray",
        techniques = { "WBLOCK_1" },
        replace_qualities = true,
        weapon_categories = { "HAND_AXES" },
    }
    item:material("steel", 1)
    item:material("aluminum", 1)
    item:quality("HAMMER", 2)
    item:quality("HAMMER_FINE", 1)
    item:quality("PRY", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("stab", 15)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_crowbar",
        name = ccb.content.plural_text("makeshift crowbar", "makeshift crowbars"),
        description = ccb.content.text("A pipe with both ends bent and hammered flat to resemble a crowbar.  Use it to open locked crates without destroying them, or to lift manhole covers.  It's not strong enough to pry doors or windows, though.  You could also wield it to fight with, in a pinch."),
        copy_from = "pipe",
        looks_like = "pipe",
        category = "tools",
        longest_side_mm = 450,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = 0,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
        techniques = { "WBLOCK_2", "RAPID", "PRECISE" },
        weapon_categories = { "BATONS" },
    }
    item:material("steel", 1)
    item:quality("PRY", 1)
    item:quality("HAMMER", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR_WEAK")
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 1)
    item:clear_mounted_charge()
    item:fault_group("steel_pipe_short", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "picklocks",
        name = ccb.content.plural_text("locksmith kit", "locksmith kits"),
        description = ccb.content.text("A locksmith's set of sturdy steel lockpicks and torsion wrenches.  It is essential for silently and quickly opening locks, provided you have some lockpicking and mechanical skills."),
        ascii_picture = "picklocks",
        mass_milligrams = 544000,
        volume_ml = 100,
        price_cents = 20000,
        price_postapoc_cents = 1000,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("LOCKPICK", 5)
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    local item = content.Item {
        id = "pseudo_bio_picklock",
        name = ccb.content.plural_text("bio lockpick", "bio lockpicks"),
        description = content.text("this a pseudo item"),
        volume_ml = 0,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:quality("LOCKPICK", 40)
    item:clear_flags()
    item:flag("PSEUDO")
    item:flag("PERFECT_LOCKPICK")
    item:tool()
    content.add(item)
end

do
    -- With the assumption that it's a cylinder of 60in length and 1.5in diameter. Assuming 2.5in in diameter left it at 4l+ - item dimensions on the listing are yet again package dimensions that would inflate the volume.
    -- Based on https://www.amazon.com/dp/B007DHX596
    local item = content.Item {
        id = "heavy_crowbar",
        name = ccb.content.plural_text("heavy crowbar", "heavy crowbars"),
        looks_like = "crowbar",
        description = ccb.content.text("A 60-inch-long construction prybar.  Essentially a long, solid steel rod with a hardened chisel tip."),
        mass_milligrams = 6201000,
        volume_ml = 1740,
        longest_side_mm = 1520,
        melee_to_hit = 0,
        price_postapoc_cents = 4000,
        color = "red",
        symbol = "/",
        techniques = { "WBLOCK_1", "SWEEP", "BRUTAL" },
        price_cents = 9000,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("ALWAYS_TWOHAND")
    item:flag("SHEATH_SPEAR")
    item:quality("HAMMER", 1)
    item:quality("PRY", 3)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 45)
    item:fault_group("steel_pipe_long", { weight_multiplier = 0.1 })
    item:tool()
    content.add(item)
end
