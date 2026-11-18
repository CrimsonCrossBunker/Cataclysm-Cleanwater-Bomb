local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "sword_wood",
        symbol = "!",
        color = "brown",
        name = ccb.content.plural_text("2-by-sword", "2-by-swords"),
        description = ccb.content.text("A plank with a handle and a whittled-down point.  Not much good for slashing, but much better than your bare hands."),
        volume_ml = 2400,
        mass_milligrams = 1000000,
        longest_side_mm = 1000,
        melee_to_hit = 1,
        price_postapoc_cents = 50,
        weapon_categories = { "MEDIUM_SWORDS" },
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("cut", 1)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_wood_large",
        symbol = "!",
        color = "brown",
        name = ccb.content.plural_text("zweitimber", "zweitimbers"),
        description = ccb.content.text("A plank with a handle and a whittled-down point, left large enough to require two hands.  Still not much good for slashing, but far better than the plank on its own."),
        looks_like = "sword_wood",
        volume_ml = 3200,
        mass_milligrams = 1600000,
        longest_side_mm = 1300,
        melee_to_hit = 0,
        price_postapoc_cents = 50,
        weapon_categories = { "GREAT_SWORDS" },
        techniques = { "WBLOCK_1", "SWEEP", "BRUTAL" },
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:melee_damage("cut", 2)
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_nail",
        symbol = "!",
        color = "light_gray",
        name = ccb.content.plural_text("nord", "nords"),
        description = ccb.content.text("A nail sword, or nord for short.  This wooden sword has a dozen nails sticking out at jagged angles from the edge of the blade, making it much better at chopping than slashing."),
        volume_ml = 2600,
        mass_milligrams = 1010000,
        longest_side_mm = 1000,
        melee_to_hit = 1,
        price_postapoc_cents = 100,
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
        weapon_categories = { "MEDIUM_SWORDS" },
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("cut", 4)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_crude",
        symbol = "!",
        color = "light_gray",
        name = ccb.content.plural_text("scrap sword", "scrap swords"),
        description = ccb.content.text("Several bits of thin scrap metal crudely beat into the semblance of an edge over a wooden sword.  The added weight is unbalanced, but the jagged edge offers a good bit of slashing power."),
        volume_ml = 2450,
        mass_milligrams = 1044000,
        longest_side_mm = 1000,
        melee_to_hit = -1,
        price_postapoc_cents = 250,
        weapon_categories = { "MEDIUM_SWORDS" },
        replace_qualities = true,
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
    }
    item:material("wood", 1)
    item:material("budget_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NONCONDUCTIVE")
    item:quality("BUTCHER", -50)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 18)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_crude_large",
        symbol = "!",
        color = "brown",
        name = ccb.content.plural_text("scrap greatsword", "scrap greatswords"),
        description = ccb.content.text("A large wooden sword with scrap metal hammered over it into something pretending to be an edge.  The extra weight almost completely front-loads the balance, and it hurts your wrists just to wield."),
        looks_like = "sword_crude",
        volume_ml = 3300,
        mass_milligrams = 1700000,
        longest_side_mm = 1300,
        melee_to_hit = -2,
        price_postapoc_cents = 250,
        weapon_categories = { "GREAT_SWORDS" },
        replace_qualities = true,
        techniques = { "WBLOCK_1", "SWEEP", "BRUTAL" },
    }
    item:material("wood", 1)
    item:material("budget_steel", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("ALWAYS_TWOHAND")
    item:quality("BUTCHER", -50)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("cut", 20)
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_sheets_welded",
        symbol = "!",
        color = "light_gray",
        name = ccb.content.plural_text("welded sword", "welded swords"),
        description = ccb.content.text("A vicious single-edged sword made out of sheet metal layered twice over itself then welded together.  It's not as robust as a proper forged sword, but the edge is wickedly sharp."),
        variant_kind = "generic",
        looks_like = "machete",
        volume_ml = 2000,
        mass_milligrams = 1300000,
        longest_side_mm = 1000,
        melee_to_hit = 0,
        price_postapoc_cents = 500,
        weapon_categories = { "MEDIUM_SWORDS" },
        replace_qualities = true,
        techniques = { "WBLOCK_2", "MOUNTED_CHARGE" },
    }
    item:variants {
        { id = "sword_sheets_welded", name = ccb.content.plural_text("welded sword", "welded swords"), description = ccb.content.text("A vicious single-edged sword made out of sheet metal layered twice over itself then welded together.  It's not as robust as a proper forged sword, but the edge is wickedly sharp.") },
        { id = "sword_sheets_bolted", name = ccb.content.plural_text("bolted sword", "bolted swords"), description = ccb.content.text("A vicious single-edged sword made out of sheet metal layered twice over itself then bolted together.  It's not quite a katana made from steel folded a thousand times over, but it has a certain industrial charm to it.") },
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:quality("CUT", 1)
    item:quality("BUTCHER", -5)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 22)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_sheets_welded_large",
        symbol = "!",
        color = "light_gray",
        name = ccb.content.plural_text("welded greatsword", "welded greatswords"),
        description = ccb.content.text("A long-handled single-edged sword made out of sheet metal layered thrice over itself then welded together.  The extra length and weight makes it a tad awkward, but gives it a lot of slashing power."),
        variant_kind = "generic",
        looks_like = "nodachi",
        volume_ml = 3250,
        mass_milligrams = 2800000,
        longest_side_mm = 1500,
        melee_to_hit = 0,
        price_postapoc_cents = 500,
        weapon_categories = { "GREAT_SWORDS" },
        replace_qualities = true,
        techniques = { "WBLOCK_1", "RAPID", "WIDE", "BRUTAL" },
    }
    item:variants {
        { id = "sword_sheets_welded_large", name = ccb.content.plural_text("welded greatsword", "welded greatswords"), description = ccb.content.text("A long-handled single-edged sword made out of sheet metal layered thrice over itself then welded together.  The extra length and weight makes it a tad awkward, but gives it a lot of slashing power.") },
        { id = "sword_sheets_bolted_large", name = ccb.content.plural_text("bolted greatsword", "bolted greatswords"), description = ccb.content.text("A long-handled single-edged sword made out of sheet metal layered thrice over itself then bolted together.  It vaguely resembles a Japanese nagamaki if you squint.") },
    }
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:quality("CUT", 1)
    item:quality("BUTCHER", -20)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 32)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 7 })
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_metal",
        symbol = "!",
        color = "light_gray",
        name = ccb.content.plural_text("metal sword", "metal swords"),
        description = ccb.content.text("An imitation of a true sword forged by someone who knows what swords look like, at least.  Made from whatever scrap metal was on hand, it has the general shape of a sword, and it is sharp, but it is a bit heavier than it should be and the balance isn't quite right."),
        looks_like = "broadsword",
        volume_ml = 2000,
        mass_milligrams = 1200000,
        longest_side_mm = 1000,
        melee_to_hit = 1,
        price_postapoc_cents = 500,
        weapon_categories = { "MEDIUM_SWORDS" },
        replace_qualities = true,
        techniques = { "WBLOCK_2", "MOUNTED_CHARGE" },
    }
    item:material("budget_steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:flag("DURABLE_MELEE")
    item:quality("CUT", 1)
    item:quality("BUTCHER", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:melee_damage("cut", 23)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    content.add(item)
end

do
    -- It's not razor-sharp and most of the damage is coming from the heavy weight, hence the high bash-to-cut ratio.
    local item = content.Item {
        id = "sword_metal_large",
        name = ccb.content.plural_text("metal greatsword", "metal greatswords"),
        description = ccb.content.text("A large, crudely-forged blade.  It's too big to be called a sword.  Too massive, too thick, too heavy, and far too rough."),
        looks_like = "zweihander",
        mass_milligrams = 3300000,
        volume_ml = 3250,
        longest_side_mm = 1500,
        price_postapoc_cents = 500,
        melee_to_hit = 0,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1", "SWEEP", "WIDE", "BRUTAL" },
        replace_qualities = true,
        weapon_categories = { "GREAT_SWORDS" },
        category = "weapons",
    }
    item:material("budget_steel", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -30)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    item:melee_damage("cut", 30)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 7 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_knife_rambo",
        copy_from = "knife_rambo",
        looks_like = "knife_rambo",
        name = ccb.content.plural_text("mild steel survival knife", "mild steel survival knives"),
        description = ccb.content.text("This massive knife features a hollow handle with a compass built into the pommel and a row of fearsome-looking saw teeth along the back of its blade.  It's custom-made of mild steel, you could probably find better in a hunting store."),
        melee_to_hit = -2,
    }
    item:clear_flags()
    item:flag("COLLAPSE_CONTENTS")
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_KNIFE")
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { stab = -1 } }
    item:replace_material("mc_steel", "lc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_knife_rambo",
        copy_from = "knife_rambo",
        looks_like = "knife_rambo",
        name = ccb.content.plural_text("high steel survival knife", "high steel survival knives"),
        description = ccb.content.text("This massive knife features a hollow handle with a compass built into the pommel and a row of fearsome-looking saw teeth along the back of its blade.  A competent weapon and tool, if not the best at any of them."),
    }
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { stab = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_knife_rambo",
        copy_from = "knife_rambo",
        looks_like = "knife_rambo",
        name = ccb.content.plural_text("hardened steel survival knife", "hardened steel survival knives"),
        description = ccb.content.text("This massive knife features a hollow handle with a compass built into the pommel and a row of fearsome-looking saw teeth along the back of its blade.  Now this, this is a knife."),
    }
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { stab = 2 } }
    item:replace_material("mc_steel", "ch_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_knife_rambo",
        copy_from = "knife_rambo",
        looks_like = "knife_rambo",
        name = ccb.content.plural_text("tempered steel survival knife", "tempered steel survival knives"),
        description = ccb.content.text("This massive knife features a hollow handle with a compass built into the pommel and a row of fearsome-looking saw teeth along the back of its blade.  Time to go Rambo on this apocalypse."),
    }
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { stab = 3 } }
    item:replace_material("mc_steel", "qt_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "estoc",
        copy_from = "mc_estoc",
        looks_like = "mc_estoc",
        name = ccb.content.plural_text("estoc", "estocs"),
        description = ccb.content.text("A thin thrusting sword, a sort of predecessor to the rapier.  It requires a larger baldric or scabbard compared to smaller swords."),
    }
    item:replace_material("mc_steel", "steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "estoc_inferior",
        copy_from = "mc_estoc",
        looks_like = "mc_estoc",
        name = ccb.content.plural_text("estoc", "estocs"),
        description = ccb.content.text("A thin thrusting sword, a sort of predecessor to the rapier.  It requires a larger baldric or scabbard compared to smaller swords.  It seems a bit too bendy."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 2.6, stab = 0.25 } }
    item:replace_material("mc_steel", "budget_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "zweihander_fake",
        copy_from = "mc_zweihander",
        looks_like = "mc_zweihander",
        name = ccb.content.plural_text("zweihänder", "zweihänders"),
        description = ccb.content.text("A dull, cheaply-made replica of a huge two-handed sword from Germany.  Even blunted, it still packs a wallop."),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.3, cut = 0.169 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    content.add(item)
end

do
    local item = content.Item {
        id = "nodachi_inferior",
        copy_from = "mc_nodachi",
        looks_like = "mc_nodachi",
        name = ccb.content.plural_text("nodachi", "nodachi"),
        description = ccb.content.text("A huge, curved, two-handed sword from Japan.  It is surprisingly light for its size, but also much bendier than a sword should be."),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 4.6, cut = 0.25 } }
    item:replace_material("mc_steel", "budget_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "nodachi_fake",
        copy_from = "mc_nodachi",
        looks_like = "mc_nodachi",
        name = ccb.content.plural_text("nodachi", "nodachi"),
        description = ccb.content.text("A dull, cheaply-made replica of a huge, curved, two-handed sword from Japan.  It is surprisingly light for its size."),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 2.3, cut = 0.068 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_cane",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("sword cane", "sword canes"),
        description = ccb.content.text("A sword with a thin blade designed to be hidden inside a hollow cane."),
        price_cents = 2000,
        price_postapoc_cents = 3000,
        mass_milligrams = 650000,
        volume_ml = 1200,
        longest_side_mm = 800,
        melee_to_hit = 1,
        looks_like = "rapier",
        techniques = { "PRECISE", "RAPID", "WBLOCK_2", "MOUNTED_CHARGE" },
        weapon_categories = { "MEDIUM_SWORDS", "FENCING_WEAPONRY" },
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 25)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end

do
    -- Do these even exist? Answer: yeah they did, at least there are two instances from ancient Egypt( although this one was more for ceremonies ) and by Shaolin(see Monk's spade')
    local item = content.Item {
        id = "lajatang",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("lajatang", "lajatangs"),
        description = ccb.content.text("An impractical exotic weapon comprised of a long pole of wood with curved blades on each end."),
        price_cents = 12000,
        price_postapoc_cents = 1250,
        ascii_picture = "lajatang",
        techniques = { "WBLOCK_1", "SPIN", "MOUNTED_CHARGE" },
        weapon_categories = { "POLEARMS" },
        mass_milligrams = 2500000,
        volume_ml = 6500,
        longest_side_mm = 1800,
        melee_to_hit = 0,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("iron", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("ALWAYS_TWOHAND")
    item:quality("CUT", 1)
    item:quality("BUTCHER", -18)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 26)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end

do
    local item = content.Item {
        id = "punch_dagger",
        name = ccb.content.plural_text("punch dagger", "punch daggers"),
        description = ccb.content.text("A short, sharp double-edged dagger made to be gripped in the palm, with the blade protruding between the fingers."),
        mass_milligrams = 224000,
        price_cents = 9000,
        price_postapoc_cents = 50,
        color = "dark_gray",
        symbol = "{",
        volume_ml = 51,
        longest_side_mm = 170,
        melee_to_hit = -1,
        weapon_categories = { "SHIVS" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:quality("CUT", 2)
    item:quality("BUTCHER", 14)
    item:clear_melee_damage()
    item:melee_damage("stab", 14)
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "knuckle_katar",
        symbol = "!",
        color = "dark_gray",
        name = ccb.content.plural_text("razorbar katar", "razorbar katars"),
        description = ccb.content.text("Five pieces of rebar sharpened to cruel points and strapped to a brace fastened at the wrist and forearm on both arms.  The next bub better watch out."),
        volume_ml = 500,
        mass_milligrams = 1150000,
        melee_to_hit = 0,
        price_postapoc_cents = 500,
        replace_qualities = true,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("stab", 14)
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "bagh_nakha",
        name = ccb.content.plural_text("tiger claws", "tiger claws"),
        description = ccb.content.text("Also called bagh nakha or iron paw, this small claw-like bladed weapon from India is designed to be concealed under and against the palm."),
        mass_milligrams = 92000,
        volume_ml = 11,
        color = "dark_gray",
        symbol = "{",
        melee_to_hit = 0,
        weapon_categories = { "CLAWS" },
        price_cents = 20000,
        price_postapoc_cents = 250,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:quality("CUT", 1)
    item:quality("BUTCHER", 14)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("cut", 15)
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_estoc",
        copy_from = "mc_estoc",
        looks_like = "mc_estoc",
        name = ccb.content.plural_text("mild steel estoc", "mild steel estocs"),
        description = ccb.content.text("A thin thrusting sword, a sort of predecessor to the rapier.  It requires a larger baldric or scabbard, compared to smaller swords.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { stab = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_estoc",
        copy_from = "mc_estoc",
        looks_like = "mc_estoc",
        name = ccb.content.plural_text("high steel estoc", "high steel estocs"),
        description = ccb.content.text("A thin thrusting sword, a sort of predecessor to the rapier.  It requires a larger baldric or scabbard, compared to smaller swords.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { stab = 4 } }
    item:replace_material("mc_steel", "hc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_estoc",
        copy_from = "mc_estoc",
        looks_like = "mc_estoc",
        name = ccb.content.plural_text("tempered steel estoc", "tempered steel estocs"),
        description = ccb.content.text("A thin thrusting sword, a sort of predecessor to the rapier.  It requires a larger baldric or scabbard, compared to smaller swords.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { stab = 8 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "jian_fake",
        looks_like = "jian",
        copy_from = "mc_jian",
        name = ccb.content.plural_text("jian", "jian"),
        description = ccb.content.text("A dull, cheaply-made replica of an ancient Chinese doubled-edged straight sword, with an ornate guard."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.9, cut = 0.07 } }
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "scimitar_fake",
        copy_from = "mc_scimitar",
        looks_like = "mc_scimitar",
        name = ccb.content.plural_text("shamshir", "shamshirs"),
        description = ccb.content.text("A dull, cheaply-made replica of a curved sword associated with various Middle Eastern and Central Asian countries."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.9, cut = 0.07 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "estoc_fake",
        copy_from = "mc_estoc",
        looks_like = "mc_estoc",
        name = ccb.content.plural_text("estoc", "estocs"),
        description = ccb.content.text("A dull, cheaply-made replica of a thin thrusting sword predating the rapier.  It requires a larger baldric or scabbard compared to smaller swords."),
        melee_to_hit = 1,
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.2, stab = 0.08 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    content.add(item)
end

do
    local item = content.Item {
        id = "arming_sword_fake",
        copy_from = "mc_arming_sword",
        looks_like = "mc_arming_sword",
        name = ccb.content.plural_text("arming sword", "arming swords"),
        description = ccb.content.text("A dull, cheaply-made replica of a classic medieval sword, just the right size to use one-handed."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 2.3, cut = 0.07 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    content.add(item)
end
