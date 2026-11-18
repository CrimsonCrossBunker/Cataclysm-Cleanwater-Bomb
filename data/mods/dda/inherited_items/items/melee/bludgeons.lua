local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "2h_flail_steel",
        category = "weapons",
        name = ccb.content.plural_text("war flail", "war flails"),
        description = ccb.content.text("A stout pole with a large flanged mace head attached to the end with a short chain, a purpose-made combat version of the peasant flail.  It specializes in threshing people in metal armor, rather than grain."),
        mass_milligrams = 3550000,
        longest_side_mm = 1600,
        volume_ml = 2250,
        price_cents = 25000,
        price_postapoc_cents = 3000,
        melee_to_hit = 0,
        symbol = "\\",
        color = "dark_gray",
        techniques = { "WBLOCK_1", "BRUTAL" },
        weapon_categories = { "FLAILS" },
    }
    item:material("wood", 1)
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 50)
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "2h_flail_wood",
        category = "weapons",
        name = ccb.content.plural_text("peasant flail", "peasant flails"),
        description = ccb.content.text("A stout pole with a wooden club attached to the end with a leather cord.  This farming tool was historically used to thresh wheat and occasionally people when the peasants got angry at their feudal lords."),
        mass_milligrams = 1700000,
        longest_side_mm = 1600,
        volume_ml = 2250,
        price_cents = 4000,
        price_postapoc_cents = 1000,
        melee_to_hit = 0,
        symbol = "\\",
        color = "brown",
        techniques = { "WBLOCK_1" },
        weapon_categories = { "FLAILS" },
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 35)
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "2h_club_kanabo_studded",
        name = ccb.content.plural_text("studded kanabō", "studded kanabō"),
        description = ccb.content.text("A two-handed war club used in feudal Japan by samurai against armored opponents.  Made from hardwood with metal stud inlays."),
        mass_milligrams = 1800000,
        longest_side_mm = 1400,
        melee_to_hit = 3,
        color = "brown",
        looks_like = "bat",
        symbol = "/",
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "WIDE", "BRUTAL", "SWEEP" },
        replace_qualities = true,
        volume_ml = 2700,
        price_cents = 50000,
        price_postapoc_cents = 2000,
    }
    item:material("wood", 9)
    item:material("iron", 1)
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 44)
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "2h_club_kanabo_spiked",
        copy_from = "2h_club_kanabo_studded",
        name = ccb.content.plural_text("spiked kanabō", "spiked kanabō"),
        description = ccb.content.text("A two-handed war club used in feudal Japan by samurai against armored opponents.  Made from hardwood with metal spike inlays."),
        looks_like = "nailbat",
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:adjust_melee_damage { bonuses = { bash = -5, stab = 7 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "bat",
        name = ccb.content.plural_text("baseball bat", "baseball bats"),
        description = ccb.content.text("A sturdy wooden bat used to play the great American pastime.  Makes for a great melee weapon too."),
        mass_milligrams = 940000,
        longest_side_mm = 864,
        melee_to_hit = 3,
        price_postapoc_cents = 150,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1", "BRUTAL", "MOUNTED_CHARGE" },
        volume_ml = 1750,
        price_cents = 16000,
        weapon_categories = { "MACES" },
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 22)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "goedendag_bat",
        copy_from = "bat",
        looks_like = "bat",
        name = ccb.content.plural_text("goedendag bat", "goedendag bats"),
        description = ccb.content.text("A weaponized baseball bat with a metal cap and a spike protruding straight up from the top."),
    }
    item:material("wood", 95)
    item:material("iron", 5)
    item:adjust_measurements {
        longest_side_mm = { offset = 200 },
        volume_ml = { offset = 100 },
        mass_milligrams = { offset = 730000 },
    }
    item:adjust_melee_damage { bonuses = { bash = 2, stab = 6 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "bat_metal",
        name = ccb.content.plural_text("aluminum bat", "aluminum bats"),
        description = ccb.content.text("An aluminum baseball bat with a plastic handle, lighter than a wooden bat and a little easier to swing as a result."),
        mass_milligrams = 765000,
        longest_side_mm = 900,
        melee_to_hit = 3,
        color = "light_gray",
        symbol = "/",
        price_postapoc_cents = 1250,
        techniques = { "WBLOCK_1", "BRUTAL", "MOUNTED_CHARGE" },
        replace_qualities = true,
        volume_ml = 1750,
        price_cents = 16000,
        weapon_categories = { "MACES" },
    }
    item:material("aluminum", 1)
    item:quality("HAMMER", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 22)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("aluminum_bat", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "battleaxe_inferior",
        copy_from = "battleaxe",
        looks_like = "battleaxe",
        name = ccb.content.plural_text("battle axe", "battle axes"),
        description = ccb.content.text("A huge axe designed for warfare.  Or it would be, but the axe heads aren't seated properly at all."),
        melee_to_hit = 0,
        price_cents = 40000,
        price_postapoc_cents = 2000,
    }
    item:material("budget_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:adjust_melee_damage { factors = { bash = 2, cut = 0.25 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_battleaxe",
        copy_from = "mc_battleaxe",
        looks_like = "mc_battleaxe",
        name = ccb.content.plural_text("mild steel battle axe", "mild steel battle axes"),
        description = ccb.content.text("A huge axe designed for warfare.  Made of mild steel, it's passable as a weapon, but lacking a proper grip or a razor sharp edge leaves it somewhat lacking."),
    }
    item:material("lc_steel", 1)
    item:material("wood", 1)
    item:adjust_melee_damage { bonuses = { cut = -4 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_battleaxe",
        copy_from = "mc_battleaxe",
        looks_like = "mc_battleaxe",
        name = ccb.content.plural_text("high steel battle axe", "high steel battle axes"),
        description = ccb.content.text("A huge axe designed for warfare.  Made of high steel, this is a solid, dependable weapon."),
    }
    item:material("hc_steel", 1)
    item:material("wood", 1)
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "blackjack",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("blackjack", "blackjacks"),
        description = ccb.content.text("A short, easily concealed bludgeoning weapon consisting of a weight embedded at the end of a short leather shaft.  Formerly used by law enforcement, this weapon is meant to stun or knock out the subject, although head strikes have a high risk of causing a permanent, disabling brain injury or being fatal."),
        price_cents = 17500,
        price_postapoc_cents = 500,
        techniques = { "PRECISE", "RAPID" },
        mass_milligrams = 450000,
        volume_ml = 350,
        longest_side_mm = 200,
        melee_to_hit = 1,
        category = "weapons",
    }
    item:material("leather", 1)
    item:material("lead", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 13)
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "bowling_pin",
        name = ccb.content.plural_text("bowling pin", "bowling pins"),
        description = ccb.content.text("A standard bowling pin.  Makes a decent melee weapon, if somewhat short."),
        mass_milligrams = 1530000,
        price_postapoc_cents = 50,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 2250,
        longest_side_mm = 400,
        melee_to_hit = -1,
        price_cents = 1000,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 11)
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "bwirebat",
        copy_from = "bat",
        looks_like = "bat",
        name = ccb.content.plural_text("barbed wire bat", "barbed wire bats"),
        description = ccb.content.text("A baseball bat wrapped with barbed wire.  A brutal melee weapon."),
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:adjust_measurements {
        price_postapoc_cents = { offset = 500 },
        volume_ml = { offset = 250 },
        mass_milligrams = { offset = 287000 },
    }
    item:adjust_melee_damage { bonuses = { cut = 8 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "nutboltbat",
        copy_from = "bat",
        looks_like = "nailbat",
        name = ccb.content.plural_text("bolt studded bat", "bolt studded bats"),
        description = ccb.content.text("A baseball bat with bolts drilled into it, concentrating the force of an impact onto a smaller point like a real mace."),
    }
    item:adjust_measurements {
        price_postapoc_cents = { offset = 10 },
        volume_ml = { offset = 50 },
        mass_milligrams = { offset = 400000 },
    }
    item:adjust_melee_damage { bonuses = { bash = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_cane",
        copy_from = "cane",
        looks_like = "cane",
        name = ccb.content.plural_text("makeshift walking cane", "makeshift walking canes"),
        description = ccb.content.text("An improvised cane.  It also works as a basic bashing weapon in a pinch."),
        melee_to_hit = 1,
        price_cents = 1600,
        price_postapoc_cents = 10,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("CRUTCHES")
    item:adjust_melee_damage { bonuses = { bash = -3 } }
    content.add(item)
end

do
    -- 30 nails, 5+10+5+10 in each direction, +600 g.  A bit of wood is carved off so make the thing a bit more evenly distributed (-300 g), but spikes negate this for volume almost completely.
    local item = content.Item {
        id = "club_wooden_nails",
        copy_from = "club_wooden",
        looks_like = "club_wooden",
        name = ccb.content.plural_text("wooden club with nails", "wooden clubs with nails"),
        description = ccb.content.text("A wooden club, carved out of a 2x4 plank of wood, with a bunch of nails driven into it.  The additional weight in the end and sharp spikes contribute to the increased damage, but the structural integrity of the wood is degraded, making this weapon live a very short life."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:adjust_measurements { price_postapoc_cents = { offset = 2 }, mass_milligrams = { offset = 400000 } }
    item:adjust_melee_damage { bonuses = { bash = 4, stab = 2 } }
    content.add(item)
end

do
    -- 30 bolts, 5+10+5+10 in each direction, +600 g +50 ml.  A bit of wood is carved off so make the thing a bit more evenly distributed, -300 g -250 ml.
    local item = content.Item {
        id = "club_wooden_bolted",
        copy_from = "club_wooden",
        looks_like = "club_wooden",
        name = ccb.content.plural_text("wooden club with bolts", "wooden clubs with bolts"),
        description = ccb.content.text("A wooden club, carved out of a 2x4 plank of wood, with a bunch of bolts drilled into it, distributing its weight and balance closer to the head, like proper maces do."),
        melee_to_hit = 1,
    }
    item:adjust_measurements {
        price_postapoc_cents = { offset = 10 },
        volume_ml = { offset = -200 },
        mass_milligrams = { offset = 300000 },
    }
    item:adjust_melee_damage { bonuses = { bash = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "club_wooden_large",
        copy_from = "club_wooden",
        name = ccb.content.plural_text("large wooden club", "large wooden clubs"),
        description = ccb.content.text("A long plank of wood with a crude handle whittled into one end.  It's barely an improvement, but at least it is slightly easier to wield than just the plank on its own."),
        mass_milligrams = 2400000,
        looks_like = "2x4",
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "BRUTAL", "SWEEP" },
        volume_ml = 4300,
        longest_side_mm = 1300,
        melee_to_hit = 0,
    }
    item:adjust_melee_damage { bonuses = { bash = 4 } }
    item:clear_mounted_charge()
    content.add(item)
end

do
    -- 30 nails, 5+10+5+10 in each direction, +600 g.  A bit of wood is carved off to make the thing a bit more evenly distributed (-400 g), but spikes negate this for volume almost completely.
    local item = content.Item {
        id = "club_wooden_large_nails",
        copy_from = "club_wooden_large",
        looks_like = "club_wooden_large",
        name = ccb.content.plural_text("large wooden club with nails", "large wooden clubs with nails"),
        description = ccb.content.text("A large wooden club, carved out of a 2x4 plank of wood, with a bunch of nails driven into it.  The additional weight in the end and sharp spikes contribute to the increased damage, but the structural integrity of the wood is degraded, making this weapon live a very short life."),
        melee_to_hit = 2,
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:adjust_measurements { price_postapoc_cents = { offset = 2 }, mass_milligrams = { offset = 200000 } }
    item:adjust_melee_damage { bonuses = { bash = 4, stab = 2 } }
    content.add(item)
end

do
    -- 30 bolts, 5+10+5+10 in each direction, +600 g +50 ml. A bit of wood is carved off to make the thing a bit more evenly distributed, -400 g -250 ml.
    local item = content.Item {
        id = "club_wooden_large_bolted",
        copy_from = "club_wooden_large",
        looks_like = "club_wooden_large",
        name = ccb.content.plural_text("large wooden club with bolts", "large wooden clubs with bolts"),
        description = ccb.content.text("A large wooden club, carved out of a 2x4 plank of wood, with a bunch of bolts drilled into it, concentrating the force of an impact onto a smaller point like a real mace."),
        melee_to_hit = 2,
    }
    item:adjust_measurements {
        price_postapoc_cents = { offset = 5 },
        volume_ml = { offset = -200 },
        mass_milligrams = { offset = 200000 },
    }
    item:adjust_melee_damage { bonuses = { bash = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "crutches",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("crutches (pair)", "crutches (pair)"),
        description = ccb.content.text("A pair of crutches."),
        price_cents = 2500,
        techniques = { "WBLOCK_1", "SWEEP" },
        mass_milligrams = 2200000,
        volume_ml = 1500,
        longest_side_mm = 1500,
        melee_to_hit = 1,
        price_postapoc_cents = 1250,
        category = "weapons",
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("CRUTCHES")
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_crutches",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("makeshift crutches (pair)", "makeshift crutches (pair)"),
        description = ccb.content.text("A pair of wooden makeshift crutches."),
        price_cents = 250,
        techniques = { "WBLOCK_1", "SWEEP" },
        mass_milligrams = 2200000,
        volume_ml = 1500,
        longest_side_mm = 1500,
        melee_to_hit = 0,
        price_postapoc_cents = 125,
        category = "weapons",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("CRUTCHES")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "golf_club",
        symbol = ";",
        color = "light_gray",
        name = ccb.content.plural_text("golf club", "golf clubs"),
        description = ccb.content.text("A long handle with a big metal head, flat on one side, for driving golf balls.  Fore!"),
        price_cents = 13000,
        price_postapoc_cents = 50,
        techniques = { "WBLOCK_1" },
        mass_milligrams = 300000,
        volume_ml = 1000,
        longest_side_mm = 1100,
        melee_to_hit = 3,
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("SHEATH_GOLF")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 11)
    content.add(item)
end

do
    local item = content.Item {
        id = "hockey_stick",
        symbol = ";",
        color = "white",
        name = ccb.content.plural_text("hockey stick", "hockey sticks"),
        description = ccb.content.text("A curved wooden stick with a wide and flat end.  Commonly used by hockey players."),
        price_cents = 11000,
        price_postapoc_cents = 50,
        techniques = { "WBLOCK_1", "SWEEP", "WIDE" },
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
        mass_milligrams = 420000,
        volume_ml = 1750,
        longest_side_mm = 1500,
        melee_to_hit = 2,
    }
    item:material("wood", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:melee_damage("stab", 1)
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "glass_macuahuitl",
        name = ccb.content.plural_text("glass bladed macuahuitl", "glass bladed macuahuitls"),
        description = ccb.content.text("A flat wooden club with sharpened pieces of glass stuck to both sides.  Somewhat accurate to the actual thing."),
        mass_milligrams = 2000000,
        volume_ml = 3800,
        price_cents = 200,
        price_postapoc_cents = 50,
        color = "brown",
        symbol = "/",
        longest_side_mm = 1000,
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "WIDE", "MOUNTED_CHARGE" },
        melee_to_hit = -1,
    }
    item:material("wood", 1)
    item:material("glass", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:melee_damage("cut", 10)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "teeth_macuahuitl",
        name = ccb.content.plural_text("teeth-bladed macuahuitl", "teeth-bladed macuahuitls"),
        description = ccb.content.text("A flat wooden club with impossibly-sharp teeth stuck to both sides.  Fragile yet very sharp."),
        mass_milligrams = 2000000,
        volume_ml = 3800,
        price_cents = 200,
        price_postapoc_cents = 50,
        color = "brown",
        symbol = "/",
        longest_side_mm = 1000,
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "WIDE", "MOUNTED_CHARGE" },
        melee_to_hit = -1,
    }
    item:material("wood", 1)
    item:material("bone", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:melee_damage("cut", 12)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "aztec_sword_stone",
        name = ccb.content.plural_text("stone lined macuahuitl", "stone lined macuahuitls"),
        description = ccb.content.text("An improvised version of the close combat weapon that was mainly used by Aztecs.  It's not very sturdy, but it will break someone's skull open and give them a good cut."),
        mass_milligrams = 2050000,
        volume_ml = 3800,
        price_cents = 200,
        price_postapoc_cents = 50,
        symbol = "/",
        color = "brown",
        longest_side_mm = 1000,
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "WIDE", "MOUNTED_CHARGE" },
        melee_to_hit = -1,
    }
    item:material("wood", 1)
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:melee_damage("cut", 5)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "aztec_sword_scrap",
        name = ccb.content.plural_text("makeshift macuahuitl", "makeshift macuahuitls"),
        description = ccb.content.text("A poor imitation of the close combat weapon affiliated with Aztec warriors, made with a large wooden club and carefully hammered razors.  Although not very sturdy, it delivers some nasty cuts and bruises."),
        mass_milligrams = 2050000,
        volume_ml = 3800,
        price_cents = 200,
        price_postapoc_cents = 50,
        symbol = "/",
        color = "brown",
        longest_side_mm = 1000,
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "WIDE", "MOUNTED_CHARGE" },
        melee_to_hit = -1,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:melee_damage("cut", 12)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_aztec_sword",
        name = ccb.content.plural_text("mild steel bladed macuahuitl", "mild steel bladed macuahuitls"),
        description = ccb.content.text("A modern reimagining of the large close combat weapon affiliated with Aztec warriors, made of a sturdy wooden club and sharp blades forged from mild steel.  Blades are definitely sturdier than obsidian ones.  Not great, not terrible."),
        mass_milligrams = 3600000,
        volume_ml = 4500,
        price_cents = 4000,
        price_postapoc_cents = 1500,
        symbol = "/",
        color = "brown",
        longest_side_mm = 1000,
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_2", "WIDE", "SWEEP" },
        melee_to_hit = 0,
    }
    item:material("wood", 1)
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 24)
    item:melee_damage("cut", 15)
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_steel_staff",
        symbol = "/",
        color = "brown",
        looks_like = "q_staff",
        name = ccb.content.plural_text("mild steelshod quarterstaff", "mild steelshod quarterstaves"),
        description = ccb.content.text("A long wooden staff reinforced with metal bands and caps.  This one has been forged with mild steel rather than the traditional iron, and so hits just that little bit harder."),
        price_cents = 6000,
        price_postapoc_cents = 1500,
        techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "QUARTERSTAVES" },
        mass_milligrams = 1750000,
        volume_ml = 1550,
        longest_side_mm = 1800,
        melee_to_hit = 3,
        category = "weapons",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 28)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_steel_staff",
        symbol = "/",
        color = "brown",
        looks_like = "q_staff",
        name = ccb.content.plural_text("medium steelshod quarterstaff", "medium steelshod quarterstaves"),
        description = ccb.content.text("A long wooden staff reinforced with metal bands and caps.  This one has been forged with medium steel rather than the traditional iron, and so hits just that little bit harder."),
        price_cents = 6000,
        price_postapoc_cents = 1500,
        techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "QUARTERSTAVES" },
        mass_milligrams = 1750000,
        volume_ml = 1550,
        longest_side_mm = 1800,
        melee_to_hit = 3,
        category = "weapons",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 29)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_steel_staff",
        symbol = "/",
        color = "brown",
        looks_like = "q_staff",
        name = ccb.content.plural_text("high steelshod quarterstaff", "high steelshod quarterstaves"),
        description = ccb.content.text("A long wooden staff reinforced with metal bands and caps.  This one has been forged with high steel rather than the traditional iron, and so hits just that little bit harder."),
        price_cents = 6000,
        price_postapoc_cents = 1500,
        techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "QUARTERSTAVES" },
        mass_milligrams = 1750000,
        volume_ml = 1550,
        longest_side_mm = 1800,
        melee_to_hit = 3,
        category = "weapons",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("hc_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_steel_staff",
        symbol = "/",
        color = "brown",
        looks_like = "q_staff",
        name = ccb.content.plural_text("hardened steelshod quarterstaff", "hardened steelshod quarterstaves"),
        description = ccb.content.text("A long wooden staff reinforced with metal bands and caps.  This one has been forged with hardened steel rather than the traditional iron, and so hits just that little bit harder."),
        price_cents = 6000,
        price_postapoc_cents = 1500,
        techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "QUARTERSTAVES" },
        mass_milligrams = 1750000,
        volume_ml = 1550,
        longest_side_mm = 1800,
        melee_to_hit = 3,
        category = "weapons",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("ch_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 31)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_steel_staff",
        symbol = "/",
        color = "brown",
        looks_like = "q_staff",
        name = ccb.content.plural_text("tempered steelshod quarterstaff", "tempered steelshod quarterstaves"),
        description = ccb.content.text("A long wooden staff reinforced with metal bands and caps.  This one has been forged with tempered steel rather than the traditional iron, and so hits just that little bit harder."),
        price_cents = 6000,
        price_postapoc_cents = 1500,
        techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "QUARTERSTAVES" },
        mass_milligrams = 1750000,
        volume_ml = 1550,
        longest_side_mm = 1800,
        melee_to_hit = 3,
        category = "weapons",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("qt_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 32)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "crowbar_warhammer",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("bec de crowbar", "bec de crowbars"),
        description = ccb.content.text("This weapon appears to be a warhammer, but instead of one end of the head being a spike, it's the flats of a crowbar.  While not as good of a weapon as a more traditional warhammer, and not as good as prying as a crowbar, it still does both jobs decently well."),
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS", "GREAT_HAMMERS" },
        price_cents = 50000,
        techniques = { "WBLOCK_1", "WIDE", "SWEEP", "MOUNTED_CHARGE" },
        mass_milligrams = 3200000,
        volume_ml = 3240,
        longest_side_mm = 1800,
        melee_to_hit = 0,
        price_postapoc_cents = 10000,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("wood", 4)
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:quality("PRY", 2)
    item:quality("HAMMER", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 46)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "homemade_polehammer",
        symbol = "/",
        color = "light_gray",
        looks_like = "lucern_hammer",
        name = ccb.content.plural_text("homemade polehammer", "homemade polehammers"),
        description = ccb.content.text("A standard hammerhead solidly mounted at the end of a proper spear shaft.  The long leverage provides surprising balance and impact force.  Simple and effective."),
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
        techniques = { "WBLOCK_1", "BRUTAL", "WIDE", "SWEEP", "MOUNTED_CHARGE" },
        mass_milligrams = 1500000,
        volume_ml = 1250,
        longest_side_mm = 1800,
        melee_to_hit = 0,
        price_cents = 5000,
        price_postapoc_cents = 1000,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_inferior",
        copy_from = "mace",
        looks_like = "mace",
        name = ccb.content.plural_text("mace", "maces"),
        description = ccb.content.text("A medieval weapon consisting of a wood handle with a heavy metal head.  The head feels a bit loose."),
        mass_milligrams = 1000000,
        price_cents = 10000,
        price_postapoc_cents = 1000,
    }
    item:material("budget_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:adjust_melee_damage { factors = { bash = 0.55 } }
    content.add(item)
end

do
    -- Same total damage and slightly higher weight than a morningstar - exchanged.
    local item = content.Item {
        id = "lc_mace",
        looks_like = "mace",
        name = ccb.content.plural_text("mild steel mace", "mild steel maces"),
        description = ccb.content.text("A medieval weapon consisting of a wood handle with a heavy metal head.  It is heavy and slow to swing, but its crushing damage is devastating.  This one is custom-made with mild steel, which technically still works fine but tends to blunt more easily, and the grip is kind of bad."),
        mass_milligrams = 1400000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "MACES" },
        volume_ml = 1250,
        longest_side_mm = 800,
        melee_to_hit = 0,
        price_cents = 100000,
        price_postapoc_cents = 6000,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("lc_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 38)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    -- Same total damage and slightly higher weight than a morningstar - exchanged.
    local item = content.Item {
        id = "hc_mace",
        looks_like = "mace",
        name = ccb.content.plural_text("high steel mace", "high steel maces"),
        description = ccb.content.text("A medieval weapon consisting of a wood handle with a heavy metal head.  It is heavy and slow to swing, but its crushing damage is devastating.  This one is custom-made with high steel and is a solid, dependable weapon."),
        mass_milligrams = 1500000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "MACES" },
        volume_ml = 1250,
        longest_side_mm = 800,
        melee_to_hit = 1,
        price_cents = 100000,
        price_postapoc_cents = 6000,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("hc_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 41)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    -- Same total damage and slightly higher weight than a morningstar - exchanged.
    local item = content.Item {
        id = "ch_mace",
        looks_like = "mace",
        name = ccb.content.plural_text("hardened steel mace", "hardened steel maces"),
        description = ccb.content.text("A medieval weapon consisting of a wood handle with a heavy metal head.  It is heavy and slow to swing, but its crushing damage is devastating.  This one is custom-made with hardened steel and can pulverize bones."),
        mass_milligrams = 1500000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "MACES" },
        volume_ml = 1250,
        longest_side_mm = 800,
        melee_to_hit = 1,
        price_cents = 100000,
        price_postapoc_cents = 6000,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("ch_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 42)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    -- Same total damage and slightly higher weight than a morningstar - exchanged.
    local item = content.Item {
        id = "qt_mace",
        looks_like = "mace",
        name = ccb.content.plural_text("tempered steel mace", "tempered steel maces"),
        description = ccb.content.text("A medieval weapon consisting of a wood handle with a heavy metal head.  It is heavy and slow to swing, but its crushing damage is devastating.  This one is custom-made with tempered steel and will crack skulls like watermelons."),
        mass_milligrams = 1500000,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "MACES" },
        volume_ml = 1250,
        longest_side_mm = 800,
        melee_to_hit = 2,
        price_cents = 100000,
        price_postapoc_cents = 6000,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("qt_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 43)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_trench",
        name = ccb.content.plural_text("trench mace", "trench maces"),
        description = ccb.content.text("A mace made from a circular chunk of steel pinned to the end of a stick.  You can feel your inner Trench Raider come alive when you wield it."),
        mass_milligrams = 1000000,
        color = "dark_gray",
        symbol = "/",
        looks_like = "mace",
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "MACES" },
        volume_ml = 1250,
        longest_side_mm = 600,
        melee_to_hit = 1,
        price_cents = 10000,
        price_postapoc_cents = 400,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 22)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_pipe",
        name = ccb.content.plural_text("pipe mace", "pipe maces"),
        description = ccb.content.text("A pipe with a handful of pipe fittings screwed onto the end to give it a weighty head for bashing."),
        mass_milligrams = 1100000,
        color = "dark_gray",
        symbol = "/",
        looks_like = "pipe",
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "MACES" },
        volume_ml = 1250,
        longest_side_mm = 650,
        melee_to_hit = 0,
        price_cents = 7500,
        price_postapoc_cents = 400,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("steel_pipe_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_pipe_large",
        name = ccb.content.plural_text("great pipe mace", "great pipe maces"),
        description = ccb.content.text("Two pipes fitted end-to-end with more pipe fittings screwed onto the far end.  The result is a large, but awkward bludgeon."),
        mass_milligrams = 2200000,
        color = "dark_gray",
        symbol = "/",
        looks_like = "pipe",
        techniques = { "WBLOCK_1", "SWEEP", "BRUTAL", "MOUNTED_CHARGE" },
        weapon_categories = { "GREAT_HAMMERS" },
        volume_ml = 1750,
        longest_side_mm = 1200,
        melee_to_hit = 0,
        price_cents = 7500,
        price_postapoc_cents = 400,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 28)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("steel_pipe_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "staff_pipe",
        name = ccb.content.plural_text("pipe staff", "pipe staffs"),
        description = ccb.content.text("Three pipes fitted end-to-end in a heavy facsimile of a quarterstaff."),
        mass_milligrams = 1850000,
        color = "dark_gray",
        symbol = "/",
        looks_like = "q_staff",
        techniques = { "WBLOCK_1", "SWEEP", "RAPID", "MOUNTED_CHARGE" },
        weapon_categories = { "QUARTERSTAVES" },
        volume_ml = 2000,
        longest_side_mm = 1900,
        melee_to_hit = 0,
        price_cents = 7500,
        price_postapoc_cents = 400,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 21)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("steel_pipe_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_bronze",
        name = ccb.content.plural_text("bronze mace", "bronze maces"),
        description = ccb.content.text("While nothing more than a bronze sphere on a stick, it is still surprisingly effective."),
        mass_milligrams = 1600000,
        color = "yellow",
        symbol = "/",
        looks_like = "mace",
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "MACES" },
        volume_ml = 1250,
        longest_side_mm = 600,
        melee_to_hit = 1,
        price_cents = 11000,
        price_postapoc_cents = 2000,
        replace_qualities = true,
    }
    item:material("bronze", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "mjolnir",
        name = ccb.content.plural_text("Mjölnir", "Mjölnirs"),
        description = ccb.content.text("A large hammer, forged from the heart of a dying star.  It bears the inscription:\n\nWhosoever holds this hammer,\nIf he be worthy,\nShall possess the power to…\nCRUSH!'"),
        mass_milligrams = 5443000,
        color = "light_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "BRUTAL", "WIDE", "SWEEP" },
        volume_ml = 2500,
        longest_side_mm = 600,
        melee_to_hit = 0,
        price_cents = 12000,
        price_postapoc_cents = 50000,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("UNBREAKABLE_MELEE")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 9999)
    content.add(item)
end

do
    local item = content.Item {
        id = "morningstar_inferior",
        copy_from = "morningstar",
        looks_like = "morningstar",
        name = ccb.content.plural_text("morningstar", "morningstars"),
        description = ccb.content.text("A medieval weapon consisting of a wood handle with a heavy, spiked metal ball on the end.  The weight feels off on this one, and the spikes are blunted."),
        mass_milligrams = 1000000,
        melee_to_hit = 1,
        price_cents = 12000,
        price_postapoc_cents = 1000,
    }
    item:material("budget_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:adjust_melee_damage { factors = { bash = 0.7, stab = 0.1 } }
    content.add(item)
end

do
    -- 20 nails, 5 from each side
    local item = content.Item {
        id = "nailbat",
        copy_from = "bat",
        looks_like = "bat",
        name = ccb.content.plural_text("nail bat", "nail bats"),
        description = ccb.content.text("A baseball bat with several nails driven through it, a popular choice for all sorts of doomsday larpers.  The additional weight in the end and sharp spikes contribute to the increased damage, but the structural integrity of the wood is degraded, making this weapon live a very short life."),
        price_cents = 0,
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:adjust_measurements { volume_ml = { offset = 150 }, mass_milligrams = { offset = 400000 } }
    item:adjust_melee_damage { bonuses = { bash = 1, stab = 2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "nailboard",
        name = ccb.content.plural_text("nailboard", "nailboards"),
        description = ccb.content.text("A plank of wood with several nails through one end; essentially a simple mace.  Makes an acceptable melee weapon."),
        mass_milligrams = 1305000,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
        weapon_categories = { "MACES" },
        volume_ml = 2200,
        longest_side_mm = 650,
        melee_to_hit = -2,
        price_cents = 100,
        price_postapoc_cents = 50,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("stab", 3)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    -- This assumes the pool cue is a cylinder with the length from the Amazon listing and the diameter of 30mm as Google said it is a likely diameter if the pin is 13mm.
    -- Based on https://www.amazon.com/dp/B08183YH7Q
    local item = content.Item {
        id = "pool_cue",
        name = ccb.content.plural_text("pool cue", "pool cues"),
        description = ccb.content.text("A hardwood stick designed for hitting colorful balls around a felt table.  Truly, the coolest of sports."),
        mass_milligrams = 510000,
        volume_ml = 1042,
        longest_side_mm = 1480,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        weapon_categories = { "QUARTERSTAVES" },
        melee_to_hit = 1,
        price_cents = 1500,
        price_postapoc_cents = 50,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "shillelagh",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("shillelagh", "shillelaghs"),
        description = ccb.content.text("A stout, knotty stick with a large knob at the top that has been left to cure in a chimney.  A traditional Irish weapon, the shillelagh was originally used for settling disputes in a gentlemanly manner."),
        price_cents = 25000,
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "BATONS" },
        mass_milligrams = 910000,
        volume_ml = 1500,
        longest_side_mm = 900,
        melee_to_hit = 3,
        price_postapoc_cents = 1250,
        category = "weapons",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 24)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "shillelagh_weighted",
        symbol = "/",
        looks_like = "shillelagh",
        color = "brown",
        name = ccb.content.plural_text("loaded stick", "loaded sticks"),
        description = ccb.content.text("A stout knotty stick with a large knob at the top that has been left to cure in a chimney.  A traditional Irish weapon, the shillelagh was originally used for settling disputes in a gentlemanly manner.  The knob has been hollowed and filled with molten heavy metal to pack more of a punch."),
        price_cents = 30000,
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "BATONS" },
        mass_milligrams = 1135000,
        volume_ml = 1500,
        longest_side_mm = 900,
        melee_to_hit = 3,
        price_postapoc_cents = 1750,
        category = "weapons",
    }
    item:material("lead", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 27)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "shillelagh_fake",
        symbol = "/",
        looks_like = "shillelagh",
        color = "brown",
        name = ccb.content.plural_text("shillelagh", "shillelaghs"),
        description = ccb.content.text("A fake shillelagh massproduced as a souvenir for tourists.  This knotty stick has not been cured in a chimney like a traditional shillelagh, but instead has had fake black soot painted on."),
        price_cents = 2500,
        techniques = { "WBLOCK_1", "SWEEP" },
        weapon_categories = { "BATONS" },
        mass_milligrams = 850000,
        volume_ml = 1500,
        longest_side_mm = 900,
        melee_to_hit = 3,
        price_postapoc_cents = 50,
        category = "weapons",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "tonfa",
        name = ccb.content.plural_text("tonfa", "tonfas"),
        description = ccb.content.text("A hard plastic truncheon commonly employed by police.  Originally an Okinawan weapon, it consists of a stick with a perpendicular handle attached a third of the way down its length."),
        mass_milligrams = 575000,
        longest_side_mm = 500,
        price_postapoc_cents = 750,
        color = "dark_gray",
        symbol = "/",
        techniques = { "WBLOCK_2", "RAPID", "PRECISE" },
        weapon_categories = { "BATONS" },
        volume_ml = 2000,
        melee_to_hit = 2,
        price_cents = 19500,
    }
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:fault_group("tonfas", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "tonfa_wood",
        name = ccb.content.plural_text("wooden tonfa", "wooden tonfas"),
        description = ccb.content.text("A stout wooden truncheon of the sort commonly employed by police.  Originally an Okinawan weapon, it consists of a stick with a perpendicular handle attached a third of the way down its length."),
        mass_milligrams = 921000,
        longest_side_mm = 500,
        price_postapoc_cents = 750,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_2", "RAPID", "PRECISE" },
        weapon_categories = { "BATONS" },
        volume_ml = 2000,
        melee_to_hit = 2,
        price_cents = 19500,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "ax_sheets_welded",
        name = ccb.content.plural_text("welded battle axe", "welded battle axes"),
        description = ccb.content.text("A savage-looking battle axe made out of layered sheet metal welded into two pipes held together with fittings, vaguely forming a upside-down L shape.  This should be structurally stable.  Hopefully."),
        looks_like = "ax",
        mass_milligrams = 2212000,
        volume_ml = 2500,
        longest_side_mm = 1050,
        price_postapoc_cents = 500,
        melee_to_hit = -1,
        symbol = "/",
        color = "light_gray",
        replace_qualities = true,
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "HOOKING_WEAPONRY", "GREAT_AXES" },
    }
    item:material("lc_steel", 1)
    item:quality("AXE", 1)
    item:quality("BUTCHER", -39)
    item:clear_flags()
    item:flag("SHEATH_AXE")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 24)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("ax_sheets", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "warhammer_inferior",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("war hammer", "war hammers"),
        description = ccb.content.text("A medieval hammer with a spike on one end, made for battle.  Its odd shape and balance make it an excellent weapon, but an ineffective tool.  The head is deformed and the spike is dull."),
        melee_to_hit = 1,
        mass_milligrams = 1000000,
        price_cents = 10000,
        price_postapoc_cents = 1000,
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:adjust_melee_damage { factors = { stab = 0.55 } }
    item:replace_material("mc_steel", "budget_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_warhammer",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("mild steel war hammer", "mild steel war hammers"),
        description = ccb.content.text("A medieval hammer with a spike on one end, made for battle.  Its odd shape and balance make it an excellent weapon, but an ineffective tool.  This one is custom-made with mild steel, which technically still works fine but tends to blunt more easily, and the grip is kind of bad."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { bash = -1, stab = -1 } }
    item:replace_material("mc_steel", "lc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_warhammer",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("high steel war hammer", "high steel war hammers"),
        description = ccb.content.text("A medieval hammer with a spike on one end, made for battle.  Its odd shape and balance make it an excellent weapon, but an ineffective tool.  This one is custom-made with high steel and is a solid, dependable weapon."),
    }
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { bash = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_warhammer",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("hardened steel war hammer", "hardened steel war hammers"),
        description = ccb.content.text("A medieval hammer with a spike on one end, made for battle.  Its odd shape and balance make it an excellent weapon, but an ineffective tool.  This one is custom-made with hardened steel and can pulverize bones."),
    }
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { bash = 2 } }
    item:replace_material("mc_steel", "ch_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_warhammer",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("tempered steel war hammer", "tempered steel war hammers"),
        description = ccb.content.text("A medieval hammer with a spike on one end, made for battle.  Its odd shape and balance make it an excellent weapon, but an ineffective tool.  This one is custom-made with tempered steel and will crack skulls like watermelons."),
    }
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { bash = 3 } }
    item:replace_material("mc_steel", "qt_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "hammer_sledge",
        name = ccb.content.plural_text("sledge hammer", "sledge hammers"),
        description = ccb.content.text("A large, heavy hammer.  A very hard-hitting melee weapon, but it's slow to swing and will probably exhaust you quickly."),
        mass_milligrams = 4250000,
        color = "brown",
        symbol = "/",
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "BRUTAL" },
        volume_ml = 1250,
        longest_side_mm = 800,
        melee_to_hit = 1,
        price_cents = 12000,
        price_postapoc_cents = 500,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("mc_steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("ALWAYS_TWOHAND")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 50)
    item:throwing_damage { { type = "bash", amount = 12 } }
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "hammer_sledge_short",
        copy_from = "hammer_sledge",
        name = ccb.content.plural_text("short sledge hammer", "short sledge hammers"),
        description = ccb.content.text("A sledge hammer with a notably shorter handle.  This makes it worse as a melee weapon, but a more portable tool."),
        looks_like = "hammer_sledge",
        melee_to_hit = -2,
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:throwing_damage { { type = "bash", amount = 9 } }
    item:adjust_measurements {
        longest_side_mm = { offset = -200 },
        price_postapoc_cents = { offset = -150 },
        volume_ml = { offset = -350 },
        mass_milligrams = { offset = -250000 },
    }
    item:adjust_melee_damage { bonuses = { bash = -15 } }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "hammer_sledge_engineer",
        copy_from = "hammer_sledge",
        looks_like = "hammer_sledge",
        name = ccb.content.plural_text("engineer's hammer", "engineer's hammers"),
        description = ccb.content.text("A stout and hefty hammer, more akin to a sledge than a typical ball-peen.  Useful for portable demolition work, but very unwieldy as a weapon."),
        techniques = { "WBLOCK_1" },
        melee_to_hit = -2,
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:throwing_damage { { type = "bash", amount = 6 } }
    item:adjust_quality("HAMMER", 1)
    item:adjust_measurements {
        longest_side_mm = { factor = 0.5 },
        price_cents = { factor = 0.5 },
        price_postapoc_cents = { factor = 0.5 },
        volume_ml = { factor = 0.5 },
        mass_milligrams = { factor = 0.5 },
    }
    item:adjust_melee_damage { factors = { bash = 0.5 } }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "hammer_sledge_heavy",
        copy_from = "hammer_sledge",
        looks_like = "hammer_sledge",
        name = ccb.content.plural_text("heavy sledge hammer", "heavy sledge hammers"),
        description = ccb.content.text("A large sledge hammer with a massive, heavy head.  This unwieldy tool is meant to break concrete, rock, brick, anything really."),
        melee_to_hit = 0,
    }
    item:throwing_damage { { type = "bash", amount = 20 } }
    item:adjust_measurements {
        longest_side_mm = { offset = 200 },
        price_cents = { factor = 2 },
        price_postapoc_cents = { factor = 2 },
        volume_ml = { offset = 450 },
        mass_milligrams = { offset = 5250000 },
    }
    item:adjust_melee_damage { bonuses = { bash = 30 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "hammer_sledge_crude",
        name = ccb.content.plural_text("homewrecker", "homewreckers"),
        description = ccb.content.text("Chunks of steel welded together affixed to a wooden handle.  Not the most elegant and ugly as all hell, but still mostly works."),
        mass_milligrams = 4500000,
        color = "brown",
        symbol = "/",
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "BRUTAL" },
        volume_ml = 1450,
        longest_side_mm = 800,
        melee_to_hit = 1,
        price_cents = 500,
        price_postapoc_cents = 200,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("ALWAYS_TWOHAND")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 40)
    item:throwing_damage { { type = "bash", amount = 12 } }
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "battleaxe",
        copy_from = "mc_battleaxe",
        looks_like = "mc_battleaxe",
        name = ccb.content.plural_text("battle axe", "battle axes"),
        description = ccb.content.text("A huge axe designed for warfare.  Though intended for use as a weapon, it can also be pressed into service as a rather clumsy woodcutting tool."),
    }
    item:material("steel", 1)
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "battleaxe_fake",
        copy_from = "battleaxe",
        looks_like = "battleaxe",
        name = ccb.content.plural_text("battle axe", "battle axes"),
        description = ccb.content.text("A dull, cheaply-made replica of a huge axe designed for warfare."),
        mass_milligrams = 2068000,
        melee_to_hit = 1,
        price_cents = 1050,
        price_postapoc_cents = 500,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:material("aluminum", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:adjust_melee_damage { factors = { cut = 0.1 } }
    item:clear_mounted_charge()
    content.add(item)
end

do
    -- Not actually as damaging as a steel katana, by any stretch.  It's a fancy, very well-carved wooden training sword, not a weapon of war.  It's also completely rounded, so any cutting damage wouldn't make sense.  Also, the heaviest bokken I could find were 700g, none were nearly close to a kilogram.
    local item = content.Item {
        id = "bokken",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("bokken", "bokken"),
        description = ccb.content.text("A solid wood 'training' katana, exactingly crafted to mimic the weight and balance of the real thing.  Despite its lack of a sharp metal edge, it's still quite capable of inflicting deadly wounds."),
        price_cents = 55000,
        price_postapoc_cents = 2500,
        ascii_picture = "bokken",
        techniques = { "RAPID", "WBLOCK_2", "MOUNTED_CHARGE" },
        mass_milligrams = 700000,
        volume_ml = 2000,
        longest_side_mm = 1000,
        melee_to_hit = 3,
        category = "weapons",
        weapon_categories = { "LONG_SWORDS" },
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "bokken_fake",
        copy_from = "bokken",
        symbol = "/",
        color = "brown",
        looks_like = "bokken",
        name = ccb.content.plural_text("bokken", "bokken"),
        description = ccb.content.text("A solid wood 'training' katana.  It feels far too light to make an effective weapon."),
        mass_milligrams = 480000,
        melee_to_hit = 2,
        price_cents = 12500,
        price_postapoc_cents = 500,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_melee_damage { factors = { bash = 0.5 } }
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "bokken_inferior",
        copy_from = "bokken",
        symbol = "/",
        color = "brown",
        looks_like = "bokken",
        name = ccb.content.plural_text("bokken", "bokken"),
        description = ccb.content.text("A solid wood 'training' katana.  It looks to be mass-produced, and not quite as effective as the real deal."),
        mass_milligrams = 580000,
        melee_to_hit = 2,
        price_cents = 12500,
        price_postapoc_cents = 750,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:adjust_melee_damage { factors = { bash = 0.75 } }
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "sinister_cane",
        name = ccb.content.plural_text("sinister cane", "sinister canes"),
        description = ccb.content.text("A sinister looking cane made of plastic.  It has a shiny red orb gripped by claws at the handle."),
        copy_from = "cane",
        looks_like = "cane",
        mass_milligrams = 91000,
        color = "red",
        symbol = "/",
        melee_to_hit = 1,
        price_postapoc_cents = 10,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:flag("FRAGILE_MELEE")
    item:flag("COSPLAY_PROPS")
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "lucern_hammer",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("lucerne hammer", "lucerne hammers"),
        description = ccb.content.text("A versatile polearm with a spiked hammer head, a spike, and a hook attached to a beefy wooden pole."),
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
        price_cents = 50000,
        techniques = { "WBLOCK_1", "WIDE", "SWEEP", "MOUNTED_CHARGE" },
        mass_milligrams = 3200000,
        volume_ml = 3750,
        longest_side_mm = 2000,
        melee_to_hit = -1,
        price_postapoc_cents = 10000,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 44)
    item:melee_damage("stab", 39)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "lucern_hammerfake",
        copy_from = "lucern_hammer",
        looks_like = "lucern_hammer",
        name = ccb.content.plural_text("lucerne hammer", "lucerne hammers"),
        description = ccb.content.text("A cheap piece of crap imitation of a versatile polearm with a spiked hammer head, probably meant to be used for LARPing."),
        mass_milligrams = 2700000,
        price_cents = 4000,
        price_postapoc_cents = 500,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:material("wood", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:adjust_melee_damage { factors = { bash = 0.5, stab = 0.1 } }
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "mace_fake",
        copy_from = "mace",
        looks_like = "mace",
        name = ccb.content.plural_text("mace", "maces"),
        description = ccb.content.text("A light, cheaply-made replica of a medieval weapon that would normally consist of a wood handle with a heavy metal head."),
        mass_milligrams = 750000,
        price_cents = 10000,
        price_postapoc_cents = 500,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:material("wood", 1)
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:adjust_melee_damage { factors = { bash = 0.38 } }
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "morningstar",
        name = ccb.content.plural_text("morningstar", "morningstars"),
        description = ccb.content.text("A medieval weapon consisting of a wood handle with a heavy, spiked metal ball on the end.  It deals devastating crushing damage, and the spikes easily puncture soft targets."),
        mass_milligrams = 1400000,
        color = "dark_gray",
        symbol = "/",
        ascii_picture = "morningstar",
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        volume_ml = 1500,
        longest_side_mm = 800,
        melee_to_hit = 1,
        weapon_categories = { "MACES" },
        price_cents = 120000,
        price_postapoc_cents = 8000,
        replace_qualities = true,
        category = "weapons",
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:quality("HAMMER", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 38)
    item:melee_damage("stab", 8)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "morningstar_fake",
        copy_from = "morningstar",
        looks_like = "morningstar",
        name = ccb.content.plural_text("morningstar", "morningstars"),
        description = ccb.content.text("A light, cheaply-made replica of a medieval weapon that would normally consist of a wood handle with a heavy, spiked metal ball on the end."),
        mass_milligrams = 700000,
        melee_to_hit = 1,
        price_cents = 12000,
        price_postapoc_cents = 500,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:material("aluminum", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:adjust_melee_damage { factors = { bash = 0.35, stab = 0.1 } }
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "warhammer_fake",
        copy_from = "warhammer",
        looks_like = "warhammer",
        name = ccb.content.plural_text("war hammer", "war hammers"),
        description = ccb.content.text("A light, cheaply-made replica of a medieval hammer with a spike on one end."),
        melee_to_hit = 1,
        mass_milligrams = 750000,
        price_cents = 10000,
        price_postapoc_cents = 500,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:adjust_melee_damage { factors = { bash = 0.38, stab = 0.38 } }
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_battleaxe",
        name = ccb.content.plural_text("medium steel battle axe", "medium steel battle axes"),
        description = ccb.content.text("A huge axe designed for warfare.  Made of medium steel, this isn't the greatest weapon ever forged but it has a decent edge and a real handle."),
        mass_milligrams = 2202000,
        volume_ml = 2500,
        longest_side_mm = 1000,
        price_cents = 40000,
        price_postapoc_cents = 12000,
        melee_to_hit = 0,
        symbol = "/",
        color = "light_gray",
        looks_like = "battleaxe",
        techniques = { "WBLOCK_1", "WIDE", "BRUTAL", "SWEEP", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "HOOKING_WEAPONRY", "GREAT_AXES" },
        category = "weapons",
    }
    item:material("mc_steel", 1)
    item:material("wood", 1)
    item:quality("AXE", 2)
    item:quality("BUTCHER", -20)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 19)
    item:melee_damage("cut", 38)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_battleaxe",
        copy_from = "mc_battleaxe",
        looks_like = "mc_battleaxe",
        name = ccb.content.plural_text("hardened steel battle axe", "hardened steel battle axes"),
        description = ccb.content.text("A huge axe designed for warfare.  Made of hardened steel, this would be the envy of any Viking raider."),
    }
    item:material("ch_steel", 1)
    item:material("wood", 1)
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_battleaxe",
        copy_from = "mc_battleaxe",
        looks_like = "mc_battleaxe",
        name = ccb.content.plural_text("tempered steel battle axe", "tempered steel battle axes"),
        description = ccb.content.text("A huge axe designed for warfare.  Made of tempered steel, this is a weapon that could fell a jötunn."),
    }
    item:material("qt_steel", 1)
    item:material("wood", 1)
    item:adjust_melee_damage { bonuses = { cut = 4 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "shock_staff",
        category = "weapons",
        name = ccb.content.plural_text("powered quarterstaff", "powered quarterstaves"),
        description = ccb.content.text("An ironshod quarterstaff that has a high-voltage stun gun built into the handle.  The stun guns prongs are extended by a wire and stick out from the tip of the shaft, allowing you to zap a dangerous opponent should beating them senseless with it prove too hazardous."),
        mass_milligrams = 1910000,
        volume_ml = 1800,
        longest_side_mm = 1800,
        price_cents = 8000,
        price_postapoc_cents = 1500,
        melee_to_hit = 1,
        symbol = "/",
        color = "brown",
        replace_qualities = true,
        techniques = { "WBLOCK_2", "RAPID", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "QUARTERSTAVES" },
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:material("iron", 1)
    item:quality("HAMMER", 1)
    item:clear_use_actions()
    item:native_use("TAZER")
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:flag("WATER_BREAK")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_long", {  })
    item:fault_group("electronic_general", {  })
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 2, ammo_types = { "battery" } }
    content.add(item)
end
