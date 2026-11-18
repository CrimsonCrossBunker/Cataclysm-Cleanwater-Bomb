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

do
    local item = content.Item {
        id = "sword_metal_fencing",
        name = ccb.content.plural_text("metal fencing sword", "metal fencing swords"),
        description = ccb.content.text("Calling this a rapier is a stretch.  It's robust and very pointy, but more akin to a long metal spike with a handguard than the elegant swords of the Renaissance."),
        looks_like = "rapier",
        mass_milligrams = 1200000,
        volume_ml = 1750,
        longest_side_mm = 1000,
        price_postapoc_cents = 500,
        melee_to_hit = 0,
        symbol = "/",
        color = "light_gray",
        techniques = { "RAPID", "WBLOCK_2", "PRECISE", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "FENCING_WEAPONRY" },
        category = "weapons",
    }
    item:material("budget_steel", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -8)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("stab", 22)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "switchblade",
        category = "weapons",
        name = ccb.content.plural_text("switchblade", "switchblades"),
        description = ccb.content.text("A long, thin knife with a spring-loaded blade that rests inside the handle while not in use."),
        mass_milligrams = 100000,
        volume_ml = 50,
        longest_side_mm = 150,
        price_cents = 2000,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
        variant_kind = "generic",
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 14)
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("CONDUCTIVE")
    item:flag("NO_SALVAGE")
    item:variants {
        { id = "switchblade_balisong", name = ccb.content.plural_text("balisong", "balisongs"), description = ccb.content.text("A flashy knife with hinged handles that completely conceal the blade while folded.  Popular among movie gangbangers and people who thought fidget spinners were too safe.") },
        { id = "switchblade_generic", name = ccb.content.plural_text("switchblade", "switchblades"), description = ccb.content.text("A long, thin knife with a spring-loaded blade that rests inside the handle while not in use."), weight = 3 },
    }
    item:clear_melee_damage()
    item:melee_damage("stab", 16)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 2 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_folding",
        name = ccb.content.plural_text("folding knife", "folding knives"),
        description = ccb.content.text("A small folding knife with a locking blade and a pocket clip.  Not as good a weapon as a solid fixed-blade knife, but better than a penknife."),
        mass_milligrams = 80000,
        volume_ml = 40,
        longest_side_mm = 100,
        price_cents = 1500,
        price_postapoc_cents = 50,
        melee_to_hit = -2,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 12)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("CONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("stab", 12)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 2 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "utility_knife_folding",
        name = ccb.content.plural_text("utility folding knife", "utility folding knives"),
        description = ccb.content.text("A 'Hideman' brand folding knife, this model includes extra utility options such as a screwdriver, awl, and small pry bar."),
        looks_like = "knife_folding",
        mass_milligrams = 155000,
        volume_ml = 40,
        longest_side_mm = 100,
        price_cents = 2500,
        price_postapoc_cents = 150,
        melee_to_hit = -2,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 12)
    item:quality("SCREW", 1)
    item:quality("PRYING_NAIL", 1)
    item:quality("LEATHER_AWL", 2)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("CONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("stab", 12)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_KABAR",
        category = "weapons",
        name = ccb.content.plural_text("KA-BAR knife", "KA-BAR knives"),
        description = ccb.content.text("The KA-BAR was developed by the United States Marine Corps in 1942 by modifying hunting knife designs to be more soldier-proof.  The handle is made of stacked leather washers, and the blade is made of easy to sharpen high steel, making for a popular fighting, hunting and utility knife.  The blade is marked 'USMC'."),
        mass_milligrams = 320000,
        volume_ml = 255,
        longest_side_mm = 300,
        price_cents = 7000,
        price_postapoc_cents = 1400,
        melee_to_hit = -1,
        looks_like = "knife_combat",
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
        repair_materials = { "steel" },
    }
    item:material("hc_steel", 1)
    item:material("leather", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 27)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("CONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("stab", 21)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    -- This isn't really supposed to be a very good knife, or a very good saw.  It's more for looking scary.
    local item = content.Item {
        id = "knife_rambo",
        category = "weapons",
        name = ccb.content.plural_text("medium steel survival knife", "medium steel survival knives"),
        description = ccb.content.text("This massive knife features a hollow handle with a compass built into the pommel and a row of fearsome-looking saw teeth along the back of its blade."),
        mass_milligrams = 422000,
        volume_ml = 344,
        longest_side_mm = 360,
        price_cents = 2000,
        price_postapoc_cents = 500,
        melee_to_hit = -1,
        symbol = ";",
        color = "dark_gray",
        techniques = { "WBLOCK_1" },
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
        replace_pockets = true,
        repair_materials = { "mc_steel" },
    }
    item:material("plastic", 1)
    item:material("mc_steel", 48)
    item:quality("CUT", 2)
    item:quality("SAW_W", 1)
    item:quality("SAW_M", 1)
    item:quality("BUTCHER", 7)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("COLLAPSE_CONTENTS")
    item:flag("DURABLE_MELEE")
    item:flag("CONDUCTIVE")
    item:container_pocket {
        max_volume_ml = 50,
        max_weight_milligrams = 100000,
        rigid = true,
        watertight = true,
        moves = 300,
        description = ccb.content.text("A hidden handle compartment.  Unscrew the compass to access."),
    }
    item:clear_melee_damage()
    item:melee_damage("stab", 14)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_rm42",
        category = "weapons",
        name = ccb.content.plural_text("F-S fighting knife", "F-S fighting knives"),
        description = ccb.content.text("Arguably the most famous combat knife in military history, this blackened double-edged knife is made of drop-forged steel and knurled brass.  The balance of the knife is such that it can be tossed from one hand to the other instinctively, and the spear point allows for easy insertion into an unsuspecting foe's heart.  While this knife is great in a fight, it's not very good as a tool.  The ricasso declares this to be a 'Fairbairn-Sykes knife', with a National Stocking Number of '1095-99-963-2037'."),
        mass_milligrams = 173000,
        volume_ml = 80,
        longest_side_mm = 290,
        price_cents = 720000,
        price_postapoc_cents = 5000,
        melee_to_hit = 0,
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
        minimum_skills = { weapon = 2, melee = 1 },
    }
    item:material("qt_steel", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 16)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 19)
    item:throwing_damage { { type = "stab", amount = 22 } }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    -- The swiss army knife is a bit more of a knife than a toolkit.
    local item = content.Item {
        id = "knife_swissarmy",
        name = ccb.content.plural_text("Swiss Army knife", "Swiss Army knives"),
        description = ccb.content.text("An iconic pocket knife imported from Europe.  Its red plastic handle conceals many small tools."),
        mass_milligrams = 120000,
        volume_ml = 60,
        longest_side_mm = 90,
        price_cents = 3000,
        price_postapoc_cents = 200,
        melee_to_hit = -3,
        symbol = ";",
        color = "red",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("SAW_W", 1)
    item:quality("SAW_M", 1)
    item:quality("SCREW", 1)
    item:quality("LEATHER_AWL", 1)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 6)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_knife_trench",
        copy_from = "knife_trench",
        looks_like = "knife_trench",
        name = ccb.content.plural_text("mild steel trench knife", "mild steel trench knives"),
        description = ccb.content.text("This stout combat knife features a steel guard to protect the user's knuckles.  The guard can also be used for striking or blocking.  This one is poorly made of mild steel with barely a proper grip."),
        melee_to_hit = -2,
    }
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { stab = -2 } }
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_knife_trench",
        copy_from = "knife_trench",
        looks_like = "knife_trench",
        name = ccb.content.plural_text("high steel trench knife", "high steel trench knives"),
        description = ccb.content.text("This stout combat knife features a steel guard to protect the user's knuckles.  The guard can also be used for striking or blocking.  This one is made of high steel and is probably as good as a WWI trench knife."),
    }
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { stab = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_knife_trench",
        copy_from = "knife_trench",
        looks_like = "knife_trench",
        name = ccb.content.plural_text("hardened steel trench knife", "hardened steel trench knives"),
        description = ccb.content.text("This stout combat knife features a steel guard to protect the user's knuckles.  The guard can also be used for striking or blocking.  This one is made of hardened steel, an officer's weapon if ever there was one."),
    }
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { stab = 2 } }
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_knife_trench",
        copy_from = "knife_trench",
        looks_like = "knife_trench",
        name = ccb.content.plural_text("tempered steel trench knife", "tempered steel trench knives"),
        description = ccb.content.text("This stout combat knife features a steel guard to protect the user's knuckles.  The guard can also be used for striking or blocking.  This one is made of tempered steel, and you feel you could hold a trench against an army of zombies with it."),
    }
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { stab = 3 } }
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_knife",
        name = ccb.content.plural_text("makeshift knife", "makeshift knives"),
        description = ccb.content.text("A knife consisting of a long, somewhat sharpened spike and a tightly-wrapped rag as a handle.  Not as good as a real knife, but it'll do in a pinch."),
        mass_milligrams = 575000,
        volume_ml = 260,
        longest_side_mm = 70,
        price_cents = 0,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("steel", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 11)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 10)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 3 })
    item:tool()
    content.add(item)
end

do
    -- literally 75% of a bone.
    local item = content.Item {
        id = "bone_knife",
        name = ccb.content.plural_text("bone shiv", "bone shivs"),
        description = ccb.content.text("A femur or other bone, about 20 cm long, which has been broken at one end and sharpened into a cutting tool.  Its jagged edge is wicked but fragile."),
        symbol = "/",
        color = "white",
        mass_milligrams = 169000,
        volume_ml = 188,
        longest_side_mm = 200,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -3,
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("bone", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 12)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("FRAGILE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 12)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "knife_baselard",
        name = ccb.content.plural_text("baselard", "baselards"),
        description = ccb.content.text("A medieval dagger forged from rough iron.  It is not the sharpest tool in the shed, but it is certainly one of the largest."),
        category = "weapons",
        mass_milligrams = 380000,
        volume_ml = 187,
        longest_side_mm = 360,
        price_cents = 19590,
        price_postapoc_cents = 1500,
        melee_to_hit = 0,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("iron", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 15)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 17)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 2 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_machete",
        category = "weapons",
        name = ccb.content.plural_text("makeshift machete", "makeshift machetes"),
        description = ccb.content.text("A large blade with one end wrapped in duct tape to make a crude handle, making it easier to wield as a rough machete."),
        mass_milligrams = 581000,
        volume_ml = 2000,
        longest_side_mm = 500,
        price_cents = 1000,
        price_postapoc_cents = 250,
        melee_to_hit = -1,
        symbol = "/",
        color = "light_gray",
        replace_qualities = true,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "SHORT_SWORDS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 2)
    item:quality("GRASS_CUT", 1)
    item:quality("BUTCHER", -27)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("cut", 16)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 4 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "machete_gimmick",
        name = ccb.content.plural_text("machete multitool", "machete multitools"),
        description = ccb.content.text("A thin, wobbly steel blade with sawteeth on one side and a flat chisel tip for digging.  More of a jackass of all trades than a jack of them."),
        longest_side_mm = 330,
        symbol = "/",
        color = "green",
        mass_milligrams = 386000,
        volume_ml = 276,
        price_cents = 2300,
        price_postapoc_cents = 1800,
        melee_to_hit = 0,
        replace_qualities = true,
        weapon_categories = { "SHORT_SWORDS" },
    }
    item:material("budget_steel", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 8)
    item:quality("SAW_W", 1)
    item:quality("DIG", 1)
    item:quality("PRY", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("cut", 11)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "cavalry_sabre",
        copy_from = "mc_cavalry_sabre",
        looks_like = "mc_cavalry_sabre",
        name = ccb.content.plural_text("cavalry saber", "cavalry sabers"),
        description = ccb.content.text("A curved sword associated with cavalry from the Early Modern period onward.  Lightweight, but a deadly slashing weapon."),
    }
    item:replace_material("mc_steel", "steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_cavalry_sabre",
        copy_from = "mc_cavalry_sabre",
        looks_like = "mc_cavalry_sabre",
        name = ccb.content.plural_text("mild steel cavalry saber", "mild steel cavalry sabers"),
        description = ccb.content.text("A curved sword associated with cavalry from the Early Modern period onwards.  Lightweight, but a deadly slashing weapon.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        mass_milligrams = 910000,
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_cavalry_sabre",
        looks_like = "cavalry_sabre",
        name = ccb.content.plural_text("medium steel cavalry saber", "medium steel cavalry sabers"),
        category = "weapons",
        description = ccb.content.text("A curved sword associated with cavalry from the Early Modern period onwards.  Lightweight, but a deadly slashing weapon.\n\nMade with medium steel and with a grip made of leather wrapped in steel wire, this weapon is comfortable in your hand, though the balance isn't perfect and the edge could be sharper."),
        mass_milligrams = 1000000,
        volume_ml = 1250,
        longest_side_mm = 1000,
        price_cents = 97000,
        price_postapoc_cents = 4000,
        melee_to_hit = 2,
        symbol = "/",
        color = "dark_gray",
        techniques = { "WBLOCK_2", "RAPID", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "MEDIUM_SWORDS", "FENCING_WEAPONRY" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 192)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:flag("CONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 27)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_cavalry_sabre",
        copy_from = "mc_cavalry_sabre",
        looks_like = "mc_cavalry_sabre",
        name = ccb.content.plural_text("high steel cavalry saber", "high steel cavalry sabers"),
        description = ccb.content.text("A curved sword associated with cavalry from the Early Modern period onwards.  Lightweight, but a deadly slashing weapon.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_cavalry_sabre",
        copy_from = "mc_cavalry_sabre",
        looks_like = "mc_cavalry_sabre",
        name = ccb.content.plural_text("hardened steel cavalry saber", "hardened steel cavalry sabers"),
        description = ccb.content.text("A curved sword associated with cavalry from the Early Modern period onwards.  Lightweight, but a deadly slashing weapon.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_cavalry_sabre",
        copy_from = "mc_cavalry_sabre",
        looks_like = "mc_cavalry_sabre",
        name = ccb.content.plural_text("tempered steel cavalry saber", "tempered steel cavalry sabers"),
        description = ccb.content.text("A curved sword associated with cavalry from the Early Modern period onwards.  Lightweight, but a deadly slashing weapon.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 4 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "cavalry_sabre_fake",
        copy_from = "mc_cavalry_sabre",
        looks_like = "mc_cavalry_sabre",
        name = ccb.content.plural_text("cavalry saber", "cavalry sabers"),
        description = ccb.content.text("A dull, cheaply-made replica of a curved sword associated with cavalry from the Early Modern period onwards."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.8, cut = 0.077 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    item:tool()
    content.add(item)
end

do
    -- Should be split into a preexisting iron version and a craftable steel version
    local item = content.Item {
        id = "kris",
        category = "weapons",
        name = ccb.content.plural_text("kris", "krises"),
        description = ccb.content.text("This wavy-bladed dagger is from Southeast Asia.  The design of the blade causes it to make broad, painful wounds."),
        mass_milligrams = 558000,
        volume_ml = 750,
        longest_side_mm = 500,
        symbol = "/",
        color = "dark_gray",
        price_cents = 9000,
        price_postapoc_cents = 500,
        melee_to_hit = 0,
        techniques = { "WBLOCK_1" },
        replace_qualities = true,
        weapon_categories = { "SHORT_SWORDS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 12)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("stab", 19)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "kris_fake",
        copy_from = "kris",
        looks_like = "kris",
        name = ccb.content.plural_text("kris", "krises"),
        description = ccb.content.text("A dull, cheap replica of a wavy-bladed dagger from Southeast Asia."),
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { stab = 0.083 } }
    item:replace_material("steel", "aluminum")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_kukri",
        copy_from = "kukri",
        looks_like = "kukri",
        name = ccb.content.plural_text("mild steel kukri", "mild steel kukris"),
        description = ccb.content.text("This versatile implement is a custom-forged version of a traditional weapon that originated in Nepal.  Featuring a heavy blade with an inwardly-curved edge, this one is made of mild steel, and barely has a proper handle.  You'd probably find a better version in a store somewhere."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_KNIFE")
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -1 } }
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_kukri",
        copy_from = "kukri",
        looks_like = "kukri",
        name = ccb.content.plural_text("high steel kukri", "high steel kukris"),
        description = ccb.content.text("This versatile implement is a custom-forged version of a traditional weapon that originated in Nepal.  Featuring a heavy blade with an inwardly-curved edge, this one is made of high steel and is a well-made piece."),
    }
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_kukri",
        copy_from = "kukri",
        looks_like = "kukri",
        name = ccb.content.plural_text("hardened steel kukri", "hardened steel kukris"),
        description = ccb.content.text("This versatile implement is a custom-forged version of a traditional weapon that originated in Nepal.  Featuring a heavy blade with an inwardly-curved edge, this one is made of hardened steel and is a fine tool and weapon."),
    }
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_kukri",
        copy_from = "kukri",
        looks_like = "kukri",
        name = ccb.content.plural_text("tempered steel kukri", "tempered steel kukris"),
        description = ccb.content.text("This versatile implement is a custom-forged version of a traditional weapon that originated in Nepal.  Featuring a heavy blade with an inwardly-curved edge, this one is made of tempered steel and truly a weapon worthy of a post apocalyptic gurkha."),
    }
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "jian",
        copy_from = "mc_jian",
        looks_like = "arming_sword",
        name = ccb.content.plural_text("jian", "jian"),
        description = ccb.content.text("An ancient Chinese doubled-edged straight sword, with an ornate guard and a tassel attached to the pommel.  One of the four major weapons in folklore, alongside the dao saber, qiang spear, and gun staff."),
    }
    item:replace_material("mc_steel", "steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_jian",
        copy_from = "mc_jian",
        looks_like = "jian",
        name = ccb.content.plural_text("mild steel jian", "mild steel jian"),
        description = ccb.content.text("An ancient Chinese doubled-edged straight sword, with an ornate guard and a tassel attached to the pommel.  One of the four major weapons in folklore, alongside the dao saber, qiang spear, and gun staff.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_jian",
        category = "weapons",
        looks_like = "jian",
        name = ccb.content.plural_text("medium steel jian", "medium steel jian"),
        description = ccb.content.text("An ancient Chinese doubled-edged straight sword, with an ornate guard and a tassel attached to the pommel.  One of the four major weapons in folklore, alongside the dao saber, qiang spear, and gun staff.\n\nMade with medium steel and with a grip made of leather wrapped in steel wire, this weapon is comfortable in your hand, though the balance isn't perfect and the edge could be sharper."),
        mass_milligrams = 890000,
        volume_ml = 2000,
        longest_side_mm = 900,
        symbol = "/",
        color = "light_gray",
        price_cents = 100000,
        price_postapoc_cents = 4000,
        techniques = { "WBLOCK_2", "MOUNTED_CHARGE" },
        melee_to_hit = 2,
        replace_qualities = true,
        weapon_categories = { "MEDIUM_SWORDS", "FENCING_WEAPONRY" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 96)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:flag("CONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 29)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_jian",
        looks_like = "jian",
        copy_from = "mc_jian",
        name = ccb.content.plural_text("high steel jian", "high steel jian"),
        description = ccb.content.text("An ancient Chinese doubled-edged straight sword, with an ornate guard and a tassel attached to the pommel.  One of the four major weapons in folklore, alongside the dao saber, qiang spear, and gun staff.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_jian",
        looks_like = "jian",
        copy_from = "mc_jian",
        name = ccb.content.plural_text("hardened steel jian", "hardened steel jian"),
        description = ccb.content.text("An ancient Chinese doubled-edged straight sword, with an ornate guard and a tassel attached to the pommel.  One of the four major weapons in folklore, alongside the dao saber, qiang spear, and gun staff.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_jian",
        looks_like = "jian",
        copy_from = "mc_jian",
        name = ccb.content.plural_text("tempered steel jian", "tempered steel jian"),
        description = ccb.content.text("An ancient Chinese doubled-edged straight sword, with an ornate guard and a tassel attached to the pommel.  One of the four major weapons in folklore, alongside the dao saber, qiang spear, and gun staff.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 5 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "jian_inferior",
        looks_like = "jian",
        copy_from = "mc_jian",
        name = ccb.content.plural_text("jian", "jian"),
        description = ccb.content.text("An ancient Chinese doubled-edged straight sword.  The sword is quite worn, and bent at an odd angle."),
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 3.9, cut = 0.25 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_scimitar",
        copy_from = "mc_scimitar",
        looks_like = "mc_scimitar",
        name = ccb.content.plural_text("mild steel shamshir", "mild steel shamshirs"),
        description = ccb.content.text("A curved sword associated with various Middle Eastern and Central Asian countries.  Designed for slashing, and quite deadly against unarmored targets.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_scimitar",
        copy_from = "mc_scimitar",
        looks_like = "mc_scimitar",
        name = ccb.content.plural_text("high steel shamshir", "high steel shamshirs"),
        description = ccb.content.text("A curved sword associated with various Middle Eastern and Central Asian countries.  Designed for slashing, and quite deadly against unarmored targets.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_scimitar",
        copy_from = "mc_scimitar",
        looks_like = "mc_scimitar",
        name = ccb.content.plural_text("hardened steel shamshir", "hardened steel shamshirs"),
        description = ccb.content.text("A curved sword associated with various Middle Eastern and Central Asian countries.  Designed for slashing, and quite deadly against unarmored targets.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "scimitar_inferior",
        copy_from = "mc_scimitar",
        looks_like = "mc_scimitar",
        name = ccb.content.plural_text("shamshir", "shamshirs"),
        description = ccb.content.text("A curved sword associated with various Middle Eastern and Central Asian countries.  This one seems oddly dull and worn."),
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 3.9, cut = 0.25 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_longsword",
        copy_from = "mc_longsword",
        looks_like = "mc_longsword",
        name = ccb.content.plural_text("mild steel longsword", "mild steel longswords"),
        description = ccb.content.text("A classic medieval sword, in between the lighter arming sword and later two-handed swords in size.  It's well-balanced and surprisingly easy to use due to its two-handed grip, but requires a larger baldric or scabbard, compared to smaller swords.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -5 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_longsword",
        copy_from = "mc_longsword",
        looks_like = "mc_longsword",
        name = ccb.content.plural_text("high steel longsword", "high steel longswords"),
        description = ccb.content.text("A classic medieval sword, in between the lighter arming sword and later two-handed swords in size.  It's well-balanced and surprisingly easy to use due to its two-handed grip, but requires a larger baldric or scabbard, compared to smaller swords.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_longsword",
        copy_from = "mc_longsword",
        looks_like = "mc_longsword",
        name = ccb.content.plural_text("hardened steel longsword", "hardened steel longswords"),
        description = ccb.content.text("A classic medieval sword, in between the lighter arming sword and later two-handed swords in size.  It's well-balanced and surprisingly easy to use due to its two-handed grip, but requires a larger baldric or scabbard, compared to smaller swords.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_longsword",
        copy_from = "mc_longsword",
        looks_like = "mc_longsword",
        name = ccb.content.plural_text("tempered steel longsword", "tempered steel longswords"),
        description = ccb.content.text("A classic medieval sword, in between the lighter arming sword and later two-handed swords in size.  It's well-balanced and surprisingly easy to use due to its two-handed grip, but requires a larger baldric or scabbard, compared to smaller swords.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 5 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "longsword_inferior",
        copy_from = "mc_longsword",
        looks_like = "mc_longsword",
        name = ccb.content.plural_text("longsword", "longswords"),
        description = ccb.content.text("A classic medieval sword, in between the lighter arming sword and later two-handed swords in size.  You feel like the pommel could just snap off if you used it."),
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 2.4, cut = 0.25 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "longsword_fake",
        copy_from = "mc_longsword",
        looks_like = "mc_longsword",
        name = ccb.content.plural_text("longsword", "longswords"),
        description = ccb.content.text("A dull, cheaply-made replica of the classic medieval longsword.  It requires a larger baldric or scabbard compared to smaller swords."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.2, cut = 0.08 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "arming_sword",
        copy_from = "mc_arming_sword",
        looks_like = "mc_arming_sword",
        name = ccb.content.plural_text("arming sword", "arming swords"),
        description = ccb.content.text("A classic medieval sword, just the right size to use one-handed."),
    }
    item:replace_material("mc_steel", "steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_arming_sword",
        copy_from = "mc_arming_sword",
        looks_like = "mc_arming_sword",
        name = ccb.content.plural_text("mild steel arming sword", "mild steel arming swords"),
        description = ccb.content.text("A classic medieval sword, just the right size to use one-handed.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_arming_sword",
        copy_from = "mc_arming_sword",
        looks_like = "mc_arming_sword",
        name = ccb.content.plural_text("high steel arming sword", "high steel arming swords"),
        description = ccb.content.text("A classic medieval sword, just the right size to use one-handed.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_arming_sword",
        copy_from = "mc_arming_sword",
        looks_like = "mc_arming_sword",
        name = ccb.content.plural_text("tempered steel arming sword", "tempered steel arming swords"),
        description = ccb.content.text("A classic medieval sword, just the right size to use one-handed.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 5 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "arming_sword_inferior",
        copy_from = "mc_arming_sword",
        looks_like = "mc_arming_sword",
        name = ccb.content.plural_text("arming sword", "arming swords"),
        description = ccb.content.text("A classic medieval sword, just the right size to use one-handed.  This one doesn't seem to have been made right."),
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 2, cut = 0.86 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "khopesh",
        category = "weapons",
        name = ccb.content.plural_text("bronze khopesh", "bronze khopeshes"),
        description = ccb.content.text("This ancient bronze weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region."),
        mass_milligrams = 750000,
        volume_ml = 1750,
        longest_side_mm = 500,
        price_cents = 12000,
        price_postapoc_cents = 3000,
        melee_to_hit = 1,
        symbol = "/",
        color = "yellow",
        techniques = { "WBLOCK_2", "DEF_DISARM" },
        replace_qualities = true,
        weapon_categories = { "SHORT_SWORDS" },
    }
    item:variants {
        { id = "default", name = ccb.content.plural_text("bronze khopesh", "bronze khopeshes"), description = ccb.content.text("This ancient bronze weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region."), weight = 1 },
        { id = "highlands_holy", name = ccb.content.plural_text("ceremonial tree sword", "ceremonial tree swords"), description = ccb.content.text("A curved and decorated sword fashioned from bronze, which you irreverently extracted from a holy tree.  Its been stained a deep green color from age, but it still looks sharp enough to put to use."), weight = 0 },
    }
    item:material("bronze", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:melee_damage("cut", 27)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "khopesh_inferior",
        looks_like = "khopesh",
        copy_from = "khopesh",
        name = ccb.content.plural_text("bronze khopesh", "bronze khopeshes"),
        description = ccb.content.text("This ancient bronze weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region.  The sword is quite worn, and bent at an odd angle."),
    }
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 1.9, cut = 0.33 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "khopesh_fake",
        looks_like = "khopesh",
        copy_from = "khopesh",
        name = ccb.content.plural_text("bronze khopesh", "bronze khopeshes"),
        description = ccb.content.text("A cheap, yellow-colored replica of an ancient bronze weapon with a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region.  The sword is quite worn, and bent at an odd angle."),
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { cut = 0 } }
    item:replace_material("bronze", "aluminum")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_khopesh",
        category = "weapons",
        name = ccb.content.plural_text("medium steel khopesh", "medium steel khopeshes"),
        description = ccb.content.text("This ancient weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region.\n\nMade with medium steel and with a grip made of leather wrapped in steel wire, this weapon is comfortable in your hand, though the balance isn't perfect and the edge could be sharper."),
        mass_milligrams = 670000,
        volume_ml = 1750,
        longest_side_mm = 500,
        price_cents = 99900,
        price_postapoc_cents = 5000,
        melee_to_hit = 1,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_2", "DEF_DISARM" },
        replace_qualities = true,
        weapon_categories = { "SHORT_SWORDS" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 112)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 9)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:melee_damage("cut", 28)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "iron_khopesh",
        copy_from = "mc_khopesh",
        looks_like = "mc_khopesh",
        name = ccb.content.plural_text("khopesh", "khopeshes"),
        description = ccb.content.text("This ancient weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region."),
    }
    item:replace_material("mc_steel", "steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "iron_khopesh_inferior",
        copy_from = "mc_khopesh",
        looks_like = "mc_khopesh",
        name = ccb.content.plural_text("khopesh", "khopeshes"),
        description = ccb.content.text("This ancient weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region.  The sword is quite worn, and bent at an odd angle."),
    }
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 1.8, cut = 0.36 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "iron_khopesh_fake",
        copy_from = "mc_khopesh",
        looks_like = "mc_khopesh",
        name = ccb.content.plural_text("khopesh", "khopeshes"),
        description = ccb.content.text("A cheap replica of an ancient weapon with a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region..  The sword is quite worn, and bent at an odd angle."),
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 1, cut = 0 } }
    item:replace_material("mc_steel", "aluminum")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_khopesh",
        copy_from = "mc_khopesh",
        looks_like = "mc_khopesh",
        name = ccb.content.plural_text("mild steel khopesh", "mild steel khopeshes"),
        description = ccb.content.text("This ancient weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -1 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_khopesh",
        copy_from = "mc_khopesh",
        looks_like = "mc_khopesh",
        name = ccb.content.plural_text("high steel khopesh", "high steel khopeshes"),
        description = ccb.content.text("This ancient weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_khopesh",
        copy_from = "mc_khopesh",
        looks_like = "mc_khopesh",
        name = ccb.content.plural_text("hardened steel khopesh", "hardened steel khopeshes"),
        description = ccb.content.text("This ancient weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_khopesh",
        copy_from = "mc_khopesh",
        looks_like = "mc_khopesh",
        name = ccb.content.plural_text("tempered steel khopesh", "tempered steel khopeshes"),
        description = ccb.content.text("This ancient weapon features a curved, sickle-like blade sharpened on the outside edge.  Associated with the New Kingdom period of Ancient Egypt, it was designed mainly to hack through the light armor common to the region.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "dao",
        category = "weapons",
        name = ccb.content.plural_text("dao", "dao"),
        description = ccb.content.text("An ancient Chinese sword consisting of a curved blade and a guard with a cupped design.  Existing since the Shang dynasty, this one is made of bronze.  One of the four major weapons in folklore, alongside the jian sword, qiang spear, and gun staff."),
        mass_milligrams = 850000,
        volume_ml = 1750,
        longest_side_mm = 950,
        price_cents = 12500,
        price_postapoc_cents = 3500,
        melee_to_hit = 2,
        symbol = "/",
        color = "yellow",
        techniques = { "WBLOCK_2", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "MEDIUM_SWORDS" },
    }
    item:material("bronze", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 24)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "sword_bronze",
        category = "weapons",
        name = ccb.content.plural_text("bronze sword", "bronze swords"),
        description = ccb.content.text("An imitation of a sword made from bronze.  It is a capable weapon, but it cannot compare to actual swords."),
        mass_milligrams = 800000,
        volume_ml = 2000,
        longest_side_mm = 500,
        price_cents = 11000,
        price_postapoc_cents = 2000,
        melee_to_hit = 1,
        symbol = "!",
        color = "yellow",
        looks_like = "sword_xiphos",
        techniques = { "WBLOCK_2" },
        replace_qualities = true,
        weapon_categories = { "SHORT_SWORDS" },
    }
    item:material("bronze", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 2)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 21)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tanto",
        category = "weapons",
        name = ccb.content.plural_text("tanto", "tanto"),
        description = ccb.content.text("Long Japanese knives like this more-modern remake were the samurai's backup weapon, before the advent of the larger wakizashi.  It's still a deadly blade, even if it's smaller than its more famous relatives."),
        mass_milligrams = 558000,
        volume_ml = 272,
        longest_side_mm = 530,
        symbol = "/",
        color = "dark_gray",
        price_cents = 18000,
        price_postapoc_cents = 1500,
        melee_to_hit = 0,
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
        repair_materials = { "steel" },
    }
    item:material("leather", 1)
    item:material("steel", 48)
    item:quality("CUT", 1)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 18)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("stab", 18)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tanto_inferior",
        copy_from = "tanto",
        looks_like = "tanto",
        name = ccb.content.plural_text("tanto", "tanto"),
        description = ccb.content.text("Long Japanese knives like this more-modern remake were the samurai's backup weapon, before the advent of the larger wakizashi.  This one doesn't feel well-balanced."),
    }
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("SHEATH_KNIFE")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 6.5, stab = 0.15 } }
    item:replace_material("steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tanto_fake",
        copy_from = "tanto",
        looks_like = "tanto",
        name = ccb.content.plural_text("tanto", "tanto"),
        description = ccb.content.text("A dull, cheaply-made replica of a long Japanese knife, typically used as a samurai's backup weapon."),
    }
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_KNIFE")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 3, stab = 0.047 } }
    item:replace_material("leather", "nylon")
    item:replace_material("steel", "aluminum")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_wakizashi",
        copy_from = "mc_wakizashi",
        looks_like = "mc_wakizashi",
        name = ccb.content.plural_text("mild steel wakizashi", "mild steel wakizashi"),
        description = ccb.content.text("A comparatively-common Japanese short sword.  Smaller and lighter than a katana, but still effective in combat.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -2)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -5 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_wakizashi",
        copy_from = "mc_wakizashi",
        looks_like = "mc_wakizashi",
        name = ccb.content.plural_text("high steel wakizashi", "high steel wakizashi"),
        description = ccb.content.text("A comparatively-common Japanese short sword.  Smaller and lighter than a katana, but still effective in combat.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_wakizashi",
        copy_from = "mc_wakizashi",
        looks_like = "mc_wakizashi",
        name = ccb.content.plural_text("hardened steel wakizashi", "hardened steel wakizashi"),
        description = ccb.content.text("A comparatively-common Japanese short sword.  Smaller and lighter than a katana, but still effective in combat.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_wakizashi",
        copy_from = "mc_wakizashi",
        looks_like = "mc_wakizashi",
        name = ccb.content.plural_text("tempered steel wakizashi", "tempered steel wakizashi"),
        description = ccb.content.text("A comparatively-common Japanese short sword.  Smaller and lighter than a katana, but still effective in combat.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 4 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wakizashi_inferior",
        copy_from = "mc_wakizashi",
        looks_like = "mc_wakizashi",
        name = ccb.content.plural_text("wakizashi", "wakizashi"),
        description = ccb.content.text("A comparatively common Japanese short sword.  There's something not quite right about this one."),
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 8.5, cut = 0.23 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wakizashi_fake",
        copy_from = "mc_wakizashi",
        looks_like = "mc_wakizashi",
        name = ccb.content.plural_text("wakizashi", "wakizashi"),
        description = ccb.content.text("A dull, cheap replica of the more common wakizashi.  Smaller and lighter than a katana, but still effective in combat."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 4, cut = 0.066 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_zweihander",
        copy_from = "mc_zweihander",
        looks_like = "mc_zweihander",
        name = ccb.content.plural_text("mild steel zweihänder", "mild steel zweihänders"),
        description = ccb.content.text("A huge two-handed sword from Germany.  It packs a real wallop.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("CONDUCTIVE")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -5 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_zweihander",
        copy_from = "mc_zweihander",
        looks_like = "mc_zweihander",
        name = ccb.content.plural_text("high steel zweihänder", "high steel zweihänders"),
        description = ccb.content.text("A huge two-handed sword from Germany.  It packs a real wallop.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_zweihander",
        copy_from = "mc_zweihander",
        looks_like = "mc_zweihander",
        name = ccb.content.plural_text("hardened steel zweihänder", "hardened steel zweihänders"),
        description = ccb.content.text("A huge two-handed sword from Germany.  It packs a real wallop.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "zweihander_inferior",
        copy_from = "mc_zweihander",
        looks_like = "mc_zweihander",
        name = ccb.content.plural_text("zweihänder", "zweihänders"),
        description = ccb.content.text("A huge two-handed sword from Germany.  You're not quite sure it's supposed to be this bendy."),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("CONDUCTIVE")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 2.35, cut = 0.26 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "karambit",
        name = ccb.content.plural_text("karambit", "karambits"),
        description = ccb.content.text("A traditional Indonesian small knife.  This one is sharp and could be an effective weapon."),
        looks_like = "kirpan",
        mass_milligrams = 142000,
        volume_ml = 95,
        longest_side_mm = 220,
        price_cents = 6400,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
    }
    item:material("steel", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 10)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 3 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "kirpan",
        name = ccb.content.plural_text("kirpan", "kirpans"),
        description = ccb.content.text("A ceremonial dagger carried by Sikh men.  This one is sharp and could be an effective weapon."),
        looks_like = "kukri",
        mass_milligrams = 374000,
        volume_ml = 113,
        longest_side_mm = 200,
        price_cents = 1800,
        price_postapoc_cents = 250,
        melee_to_hit = -1,
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
        repair_materials = { "steel" },
    }
    item:material("leather", 1)
    item:material("steel", 32)
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 16)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 4 })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "kirpan_cheap",
        copy_from = "kirpan",
        looks_like = "kirpan",
        name = ccb.content.plural_text("kirpan", "kirpans"),
        description = ccb.content.text("A ceremonial dagger carried by Sikh men.  This one is not particularly well-made."),
    }
    item:flag("FRAGILE_MELEE")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 8, stab = 0.24 } }
    item:replace_material("steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "nodachi",
        copy_from = "mc_nodachi",
        looks_like = "mc_nodachi",
        name = ccb.content.plural_text("nodachi", "nodachi"),
        description = ccb.content.text("A huge, curved, two-handed sword from Japan.  It is surprisingly light for its size."),
    }
    item:replace_material("mc_steel", "steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_nodachi",
        copy_from = "mc_nodachi",
        looks_like = "mc_nodachi",
        name = ccb.content.plural_text("mild steel nodachi", "mild steel nodachi"),
        description = ccb.content.text("A huge, curved, two-handed sword from Japan.  It is surprisingly light for its size.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -2)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -6 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_nodachi",
        category = "weapons",
        name = ccb.content.plural_text("medium steel nodachi", "medium steel nodachi"),
        description = ccb.content.text("A huge, curved, two-handed sword from Japan.  It is surprisingly light for its size.\n\nMade with medium steel and with a grip made of leather wrapped in steel wire, this weapon is comfortable in your hand, though the balance isn't perfect and the edge could be sharper."),
        mass_milligrams = 3002000,
        volume_ml = 3250,
        longest_side_mm = 1200,
        symbol = "/",
        color = "light_gray",
        looks_like = "nodachi",
        price_cents = 150000,
        price_postapoc_cents = 12000,
        techniques = { "WBLOCK_1", "RAPID", "WIDE", "BRUTAL" },
        melee_to_hit = 2,
        replace_qualities = true,
        weapon_categories = { "GREAT_SWORDS" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 128)
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:flag("CONDUCTIVE")
    item:quality("CUT", 1)
    item:quality("BUTCHER", 11)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 46)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_nodachi",
        copy_from = "mc_nodachi",
        looks_like = "mc_nodachi",
        name = ccb.content.plural_text("high steel nodachi", "high steel nodachi"),
        description = ccb.content.text("A huge, curved, two-handed sword from Japan.  It is surprisingly light for its size.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_nodachi",
        copy_from = "mc_nodachi",
        looks_like = "mc_nodachi",
        name = ccb.content.plural_text("hardened steel nodachi", "hardened steel nodachi"),
        description = ccb.content.text("A huge, curved, two-handed sword from Japan.  It is surprisingly light for its size.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 5 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_nodachi",
        copy_from = "mc_nodachi",
        looks_like = "mc_nodachi",
        name = ccb.content.plural_text("tempered steel nodachi", "tempered steel nodachi"),
        description = ccb.content.text("A huge, curved, two-handed sword from Japan.  It is surprisingly light for its size.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 7 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fencing_foil",
        category = "weapons",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("fencing foil", "fencing foils"),
        description = ccb.content.text("A weapon used for fencing, the most noble of all sports.  Unfortunately, a fencing foil is rather useless as a weapon due to its flexible shaft and dull tip."),
        price_cents = 2000,
        price_postapoc_cents = 10,
        mass_milligrams = 450000,
        volume_ml = 1250,
        longest_side_mm = 1000,
        melee_to_hit = 1,
        techniques = { "PRECISE", "RAPID", "WBLOCK_2" },
        weapon_categories = { "FENCING_WEAPONRY" },
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 2)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end

do
    local item = content.Item {
        id = "fencing_foil_sharpened",
        copy_from = "fencing_foil",
        looks_like = "fencing_foil",
        name = ccb.content.plural_text("sharpened foil", "sharpened foils"),
        description = ccb.content.text("What was once a mostly-harmless fencing foil has had its electrical plunger assembly removed and has been crudely sharpened to a point.  Though it still lacks a cutting edge, it is now somewhat more lethal, yet still familiar to the practiced fencer."),
    }
    item:adjust_measurements { mass_milligrams = { offset = -25000 } }
    item:adjust_melee_damage { bonuses = { stab = 2 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "shock_foil",
        copy_from = "fencing_foil_sharpened",
        looks_like = "fencing_foil_sharpened",
        name = ccb.content.plural_text("electrified foil", "electrified foils"),
        description = ccb.content.text("The modifications made to this fencing foil may not be sporting, but they might give you an edge in this final competition.  Extra effort has been made to insulate the grip and a high voltage stun gun has been attached to the guard, wired through the electronic scoring circuit to the tip.  Thrusting the sharpened tip into a foe and activating the momentary switch will deliver a painful electric shock."),
        price_postapoc_cents = 1250,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:native_use("TAZER")
    item:flag("NONCONDUCTIVE")
    item:flag("WATER_BREAK")
    item:adjust_measurements { volume_ml = { offset = 250 }, mass_milligrams = { offset = 151000 } }
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 2, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "fencing_epee",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("fencing épée", "fencing épées"),
        description = ccb.content.text("A weapon used for fencing, the most noble of all sports.  While not designed for combat the épée is the heaviest and stiffest of the fencing weapons, and therefore perhaps still useful in your situation."),
        price_cents = 2000,
        price_postapoc_cents = 10,
        mass_milligrams = 650000,
        volume_ml = 1250,
        longest_side_mm = 1000,
        melee_to_hit = 1,
        techniques = { "PRECISE", "RAPID", "WBLOCK_2" },
        weapon_categories = { "FENCING_WEAPONRY" },
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("stab", 7)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end

do
    local item = content.Item {
        id = "fencing_epee_sharpened",
        copy_from = "fencing_epee",
        looks_like = "fencing_epee",
        name = ccb.content.plural_text("sharpened épée", "sharpened épées"),
        description = ccb.content.text("What was once a mostly-harmless fencing épée has had its electrical plunger assembly removed and has been crudely sharpened to a point.  Though it still lacks a cutting edge, it is now considerably more lethal, yet still familiar to the practiced fencer."),
    }
    item:adjust_measurements { mass_milligrams = { offset = -35000 } }
    item:adjust_melee_damage { bonuses = { stab = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "shock_epee",
        category = "weapons",
        copy_from = "fencing_epee_sharpened",
        looks_like = "fencing_epee",
        name = ccb.content.plural_text("electrified épée", "electrified épées"),
        description = ccb.content.text("The modifications made to this fencing épée may not be sporting, but they might give you an edge in this final competition.  Extra effort has been made to insulate the grip and a high voltage stun gun has been attached to the guard, wired through the electronic scoring circuit to the tip.  Thrusting the sharpened tip into a foe and activating the momentary switch will deliver a painful electric shock."),
        price_postapoc_cents = 1250,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:native_use("TAZER")
    item:flag("NONCONDUCTIVE")
    item:flag("WATER_BREAK")
    item:adjust_measurements { volume_ml = { offset = 250 }, mass_milligrams = { offset = 151000 } }
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 2, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "fencing_sabre",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("fencing saber", "fencing sabers"),
        description = ccb.content.text("A weapon used for fencing, the most noble of all sports.  Not designed for combat the saber at least bears an edge and so outperforms the foil, though still lacks the weight of the épée."),
        price_cents = 2000,
        price_postapoc_cents = 10,
        mass_milligrams = 400000,
        volume_ml = 1250,
        longest_side_mm = 1000,
        melee_to_hit = 1,
        techniques = { "PRECISE", "RAPID", "WBLOCK_2" },
        weapon_categories = { "FENCING_WEAPONRY" },
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 6)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    content.add(item)
end

do
    local item = content.Item {
        id = "fencing_sabre_sharpened",
        copy_from = "fencing_sabre",
        looks_like = "fencing_sabre",
        name = ccb.content.plural_text("sharpened saber", "sharpened sabers"),
        description = ccb.content.text("What was once a mostly-harmless fencing saber has had its rounded tip snapped off and has been crudely sharpened to a point.  Though it still lacks a cutting edge, it is now considerably more lethal, yet still familiar to the practiced fencer."),
    }
    item:adjust_measurements { mass_milligrams = { offset = -10000 } }
    item:adjust_melee_damage { bonuses = { stab = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "shock_sabre",
        category = "weapons",
        copy_from = "fencing_sabre_sharpened",
        looks_like = "fencing_sabre",
        name = ccb.content.plural_text("electrified saber", "electrified sabers"),
        description = ccb.content.text("The modifications made to this fencing saber may not be sporting, but they might give you an edge in this final competition.  Extra effort has been made to insulate the grip and a high voltage stun gun has been attached to the guard, wired to the tip along the saber's groove.  Thrusting the sharpened tip into a foe and activating the momentary switch will deliver a painful electric shock."),
        price_postapoc_cents = 1250,
        replace_pockets = true,
    }
    item:clear_use_actions()
    item:native_use("TAZER")
    item:flag("NONCONDUCTIVE")
    item:flag("WATER_BREAK")
    item:adjust_measurements { volume_ml = { offset = 250 }, mass_milligrams = { offset = 151000 } }
    item:magazine_well { rigid = true, flags = { "BATTERY_MEDIUM" }, default_magazine = "medium_battery_cell" }
    item:tool { charges_per_use = 2, ammo_types = { "battery" } }
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_broadsword",
        copy_from = "broadsword",
        looks_like = "broadsword",
        name = ccb.content.plural_text("mild steel broadsword", "mild steel broadswords"),
        description = ccb.content.text("An early modern sword that saw use in the 16th, 17th, and 18th centuries.  Called 'broad' to contrast with the slimmer rapiers.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_broadsword",
        copy_from = "broadsword",
        looks_like = "broadsword",
        name = ccb.content.plural_text("high steel broadsword", "high steel broadswords"),
        description = ccb.content.text("An early modern sword that saw use in the 16th, 17th, and 18th centuries.  Called 'broad' to contrast with the slimmer rapiers.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_broadsword",
        copy_from = "broadsword",
        looks_like = "broadsword",
        name = ccb.content.plural_text("hardened steel broadsword", "hardened steel broadswords"),
        description = ccb.content.text("An early modern sword that saw use in the 16th, 17th, and 18th centuries.  Called 'broad' to contrast with the slimmer rapiers.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_broadsword",
        copy_from = "broadsword",
        looks_like = "broadsword",
        name = ccb.content.plural_text("tempered steel broadsword", "tempered steel broadswords"),
        description = ccb.content.text("An early modern sword that saw use in the 16th, 17th, and 18th centuries.  Called 'broad' to contrast with the slimmer rapiers.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 4 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "broadsword_inferior",
        copy_from = "broadsword",
        looks_like = "broadsword",
        name = ccb.content.plural_text("broadsword", "broadswords"),
        description = ccb.content.text("An Early Modern sword that saw use in the 16th, 17th, and 18th centuries.  This sword appears to be made very poorly, but it should still stand up to a few swings."),
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 3.3, cut = 0.3 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "broadsword_fake",
        copy_from = "broadsword",
        looks_like = "broadsword",
        name = ccb.content.plural_text("broadsword", "broadswords"),
        description = ccb.content.text("A dull, cheaply-made replica of an Early Modern sword that saw use in the 16th, 17th, and 18th centuries.  Called 'broad' to contrast with the slimmer rapiers."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.66, cut = 0.11 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_rapier",
        copy_from = "rapier",
        looks_like = "rapier",
        name = ccb.content.plural_text("mild steel rapier", "mild steel rapiers"),
        description = ccb.content.text("A thin sword with an ornate hand guard.  It looks like the preferred weapon of gentlemen and swashbucklers.  Light and quick, it makes any battle a stylish battle.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { stab = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_rapier",
        copy_from = "rapier",
        looks_like = "rapier",
        name = ccb.content.plural_text("high steel rapier", "high steel rapiers"),
        description = ccb.content.text("A thin sword with an ornate hand guard.  It looks like the preferred weapon of gentlemen and swashbucklers.  Light and quick, it makes any battle a stylish battle.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { stab = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_rapier",
        copy_from = "rapier",
        looks_like = "rapier",
        name = ccb.content.plural_text("hardened steel rapier", "hardened steel rapiers"),
        description = ccb.content.text("A thin sword with an ornate hand guard.  It looks like the preferred weapon of gentlemen and swashbucklers.  Light and quick, it makes any battle a stylish battle.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { stab = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_rapier",
        copy_from = "rapier",
        looks_like = "rapier",
        name = ccb.content.plural_text("tempered steel rapier", "tempered steel rapiers"),
        description = ccb.content.text("A thin sword with an ornate hand guard.  It looks like the preferred weapon of gentlemen and swashbucklers.  Light and quick, it makes any battle a stylish battle.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { stab = 5 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rapier_fake",
        copy_from = "rapier",
        looks_like = "rapier",
        name = ccb.content.plural_text("rapier", "rapiers"),
        description = ccb.content.text("A blunted, cheap replica of a thin sword with an ornate handguard.  It looks like the preferred weapon of gentlemen and swashbucklers.  Light and quick, it makes any battle a stylish battle."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 3, stab = 0.071 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_katana",
        copy_from = "mc_katana",
        looks_like = "mc_katana",
        name = ccb.content.plural_text("mild steel katana", "mild steel katana"),
        description = ccb.content.text("A rare sword from Japan.  Deadly against unarmored targets, and still very effective against armor.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -5 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_katana",
        copy_from = "mc_katana",
        looks_like = "mc_katana",
        name = ccb.content.plural_text("high steel katana", "high steel katana"),
        description = ccb.content.text("A rare sword from Japan.  Deadly against unarmored targets, and still very effective against armor.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_katana",
        copy_from = "mc_katana",
        looks_like = "mc_katana",
        name = ccb.content.plural_text("hardened steel katana", "hardened steel katana"),
        description = ccb.content.text("A rare sword from Japan.  Deadly against unarmored targets, and still very effective against armor.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "katana_inferior",
        copy_from = "mc_katana",
        looks_like = "mc_katana",
        name = ccb.content.plural_text("katana", "katana"),
        description = ccb.content.text("A rare sword from Japan.  While it's got the right edge and weight, the pommel feels like it'll just snap off, and the blade seems pretty worn."),
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 3.4, cut = 0.25 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "katana_fake",
        copy_from = "mc_katana",
        looks_like = "mc_katana",
        name = ccb.content.plural_text("katana", "katana"),
        description = ccb.content.text("A dull, cheaply-made replica of a rare sword from Japan."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.8, cut = 0.064 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "butterfly_swords",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("butterfly sword", "butterfly swords"),
        description = ccb.content.text("A Shaolin butterfly sword, about the same size as a machete but with hand guards and wider blades.  Traditionally used in pairs, but just one is more than enough."),
        price_cents = 50000,
        price_postapoc_cents = 6000,
        weapon_categories = { "SHORT_SWORDS" },
        techniques = { "WBLOCK_2" },
        mass_milligrams = 883000,
        volume_ml = 750,
        longest_side_mm = 500,
        melee_to_hit = 1,
        category = "weapons",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SWORD")
    item:quality("CUT", 1)
    item:quality("BUTCHER", 8)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 30)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "cutlass",
        copy_from = "mc_cutlass",
        looks_like = "mc_cutlass",
        name = ccb.content.plural_text("cutlass", "cutlasses"),
        description = ccb.content.text("A broad saber known for its use by sailors and pirates, as its short blade is easy to handle in close quarters."),
    }
    item:replace_material("mc_steel", "steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_cutlass",
        copy_from = "mc_cutlass",
        looks_like = "mc_cutlass",
        name = ccb.content.plural_text("mild steel cutlass", "mild steel cutlasses"),
        description = ccb.content.text("A broad saber known for its use by sailors and pirates, as its short blade is easy to handle in close quarters.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_cutlass",
        category = "weapons",
        name = ccb.content.plural_text("medium steel cutlass", "medium steel cutlasses"),
        description = ccb.content.text("A broad saber known for its use by sailors and pirates, as its short blade is easy to handle in close quarters.\n\nMade with medium steel and with a grip made of leather wrapped in steel wire, this weapon is comfortable in your hand, though the balance isn't perfect and the edge could be sharper."),
        mass_milligrams = 1045000,
        volume_ml = 1250,
        longest_side_mm = 800,
        symbol = "/",
        color = "dark_gray",
        looks_like = "cutlass",
        price_cents = 96000,
        price_postapoc_cents = 3500,
        techniques = { "WBLOCK_2", "MOUNTED_CHARGE" },
        melee_to_hit = 1,
        replace_qualities = true,
        weapon_categories = { "MEDIUM_SWORDS" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 144)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:quality("CUT", 1)
    item:quality("BUTCHER", 9)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 27)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_cutlass",
        copy_from = "mc_cutlass",
        looks_like = "mc_cutlass",
        name = ccb.content.plural_text("high steel cutlass", "high steel cutlasses"),
        description = ccb.content.text("A broad saber known for its use by sailors and pirates, as its short blade is easy to handle in close quarters.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_cutlass",
        copy_from = "mc_cutlass",
        looks_like = "mc_cutlass",
        name = ccb.content.plural_text("hardened steel cutlass", "hardened steel cutlasses"),
        description = ccb.content.text("A broad saber known for its use by sailors and pirates, as its short blade is easy to handle in close quarters.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_cutlass",
        copy_from = "mc_cutlass",
        looks_like = "mc_cutlass",
        name = ccb.content.plural_text("tempered steel cutlass", "tempered steel cutlasses"),
        description = ccb.content.text("A broad saber known for its use by sailors and pirates, as its short blade is easy to handle in close quarters.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 4 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "cutlass_inferior",
        copy_from = "mc_cutlass",
        looks_like = "mc_cutlass",
        name = ccb.content.plural_text("cutlass", "cutlasses"),
        description = ccb.content.text("A broad saber known for its use by sailors and pirates.  This sword appears to be made very poorly, but it should still stand up to a few swings."),
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.1 }, price_postapoc_cents = { factor = 0.1 } }
    item:adjust_melee_damage { factors = { bash = 3.6, cut = 0.27 } }
    item:replace_material("mc_steel", "budget_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "cutlass_fake",
        copy_from = "mc_cutlass",
        looks_like = "mc_cutlass",
        name = ccb.content.plural_text("cutlass", "cutlasses"),
        description = ccb.content.text("A dull, cheaply-made replica of a broad saber known for its use by sailors and pirates."),
        remove_techniques = { "MOUNTED_CHARGE" },
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SWORD")
    item:adjust_measurements { price_cents = { factor = 0.05 }, price_postapoc_cents = { factor = 0.05 } }
    item:adjust_melee_damage { factors = { bash = 1.8, cut = 0.076 } }
    item:replace_material("leather", "nylon")
    item:replace_material("mc_steel", "aluminum")
    item:clear_mounted_charge()
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "kriegsmesser",
        copy_from = "mc_kriegsmesser",
        looks_like = "mc_kriegsmesser",
        name = ccb.content.plural_text("kriegsmesser", "kriegsmessers"),
        description = ccb.content.text("A single-edged two-handed sword of German design, with a long, curved blade.  It became popular across Europe due to its low cost while maintaining strong cutting power in comparison to the more sophisticated longsword."),
    }
    item:replace_material("mc_steel", "steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_kriegsmesser",
        copy_from = "mc_kriegsmesser",
        looks_like = "mc_kriegsmesser",
        name = ccb.content.plural_text("mild steel kriegsmesser", "mild steel kriegsmessers"),
        description = ccb.content.text("A single-edged hand-and-a-half-sword of German design, with a long, curved blade.  It became popular across Europe due to its low cost while maintaining strong cutting power in comparison to the more sophisticated longsword.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -5 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_kriegsmesser",
        category = "weapons",
        name = ccb.content.plural_text("medium steel kriegsmesser", "medium steel kriegsmessers"),
        description = ccb.content.text("A single-edged two-handed sword of German design, with a long, curved blade.  It became popular across Europe due to its low cost while maintaining strong cutting power in comparison to the more sophisticated longsword.\n\nMade with medium steel and with a grip made of leather wrapped in steel wire, this weapon is comfortable in your hand, though the balance isn't perfect and the edge could be sharper."),
        mass_milligrams = 1690000,
        volume_ml = 2750,
        longest_side_mm = 1200,
        symbol = "/",
        color = "light_gray",
        looks_like = "scimitar",
        price_cents = 100000,
        price_postapoc_cents = 4500,
        techniques = { "WBLOCK_2", "BRUTAL" },
        melee_to_hit = 1,
        replace_qualities = true,
        weapon_categories = { "GREAT_SWORDS" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 96)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:flag("ALWAYS_TWOHAND")
    item:quality("CUT", 1)
    item:quality("BUTCHER", -5)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:melee_damage("cut", 35)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_kriegsmesser",
        copy_from = "mc_kriegsmesser",
        looks_like = "mc_kriegsmesser",
        name = ccb.content.plural_text("high steel kriegsmesser", "high steel kriegsmessers"),
        description = ccb.content.text("A single-edged two-handed sword of German design, with a long, curved blade.  It became popular across Europe due to its low cost while maintaining strong cutting power in comparison to the more sophisticated longsword.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_kriegsmesser",
        copy_from = "mc_kriegsmesser",
        looks_like = "mc_kriegsmesser",
        name = ccb.content.plural_text("hardened steel kriegsmesser", "hardened steel kriegsmessers"),
        description = ccb.content.text("A single-edged two-handed sword of German design, with a long, curved blade.  It became popular across Europe due to its low cost while maintaining strong cutting power in comparison to the more sophisticated longsword.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_kriegsmesser",
        copy_from = "mc_kriegsmesser",
        looks_like = "mc_kriegsmesser",
        name = ccb.content.plural_text("tempered steel kriegsmesser", "tempered steel kriegsmessers"),
        description = ccb.content.text("A single-edged two-handed sword of German design, with a long, curved blade.  It became popular across Europe due to its low cost while maintaining strong cutting power in comparison to the more sophisticated longsword.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 5 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "falx",
        copy_from = "mc_falx",
        looks_like = "mc_falx",
        name = ccb.content.plural_text("falx", "falxes"),
        description = ccb.content.text("A distinct Dacian sword that curves forward, allowing you to bypass shields or hook and pull enemies, while delivering decent chopping damage."),
    }
    item:replace_material("leather", "wood")
    item:replace_material("mc_steel", "steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_falx",
        copy_from = "mc_falx",
        looks_like = "mc_falx",
        name = ccb.content.plural_text("mild steel falx", "mild steel falxes"),
        description = ccb.content.text("A distinct Dacian sword that curves forward, allowing you to bypass shields or hook and pull enemies, while delivering decent chopping damage.\n\nMade with mild steel and lacking a proper grip, this is better than the sticks you swung around as a kid, but you know you can do better."),
        melee_to_hit = 0,
    }
    item:clear_flags()
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -3)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -3 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_falx",
        category = "weapons",
        name = ccb.content.plural_text("medium steel falx", "medium steel falxes"),
        description = ccb.content.text("A distinct Dacian sword that curves forward, allowing you to bypass shields or hook and pull enemies, while delivering decent chopping damage.\n\nMade with medium steel and with a grip made of leather wrapped in steel wire, this weapon is comfortable in your hand, though the balance isn't perfect and the edge could be sharper."),
        mass_milligrams = 1540000,
        volume_ml = 2000,
        longest_side_mm = 900,
        symbol = "/",
        color = "light_gray",
        looks_like = "katana",
        price_cents = 100000,
        price_postapoc_cents = 4500,
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        melee_to_hit = 1,
        replace_qualities = true,
        weapon_categories = { "MEDIUM_SWORDS" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 80)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:quality("CUT", 1)
    item:quality("BUTCHER", -14)
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 26)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_falx",
        copy_from = "mc_falx",
        looks_like = "mc_falx",
        name = ccb.content.plural_text("high steel falx", "high steel falxes"),
        description = ccb.content.text("A distinct Dacian sword that curves forward, allowing you to bypass shields or hook and pull enemies, while delivering decent chopping damage.\n\nMade with high steel and featuring a sturdy grip, this feels like a proper weapon.  The balance feels right and the blade is quite sharp."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_falx",
        copy_from = "mc_falx",
        looks_like = "mc_falx",
        name = ccb.content.plural_text("hardened steel falx", "hardened steel falxes"),
        description = ccb.content.text("A distinct Dacian sword that curves forward, allowing you to bypass shields or hook and pull enemies, while delivering decent chopping damage.\n\nMade of hardened steel and with a molded grip that fits your hand perfectly, this weapon looks as good as any you might find in a museum.  The balance is perfect and the edge is as sharp as a razor."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_falx",
        copy_from = "mc_falx",
        looks_like = "mc_falx",
        name = ccb.content.plural_text("tempered steel falx", "tempered steel falxes"),
        description = ccb.content.text("A distinct Dacian sword that curves forward, allowing you to bypass shields or hook and pull enemies, while delivering decent chopping damage.\n\nMade of tempered steel, this is a masterpiece.  The grip, the balance, the blade, all perfect.  This is the peak of the swordsmith's craft."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 4 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_talwar",
        copy_from = "mc_talwar",
        looks_like = "mc_talwar",
        category = "weapons",
        name = ccb.content.plural_text("mild steel talwar", "mild steel talwars"),
        description = ccb.content.text("A curved sword used by the Raj of India in the 16th century, a talwar is usually impeccably decorated and able to take off a limb with a single swipe.\n\nThis one however is made of mild steel and lacks even a proper grip, you can definitely do better."),
        melee_to_hit = -1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -4 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_talwar",
        name = ccb.content.plural_text("medium steel talwar", "medium steel talwars"),
        description = ccb.content.text("A curved sword used by the Raj of India in the 16th century, a talwar is usually impeccably decorated and able to take off a limb with a single swipe.\n\nThis one has a proper grip and is made of medium steel, but doesn't have the distinctive circular pommel yet."),
        mass_milligrams = 1450000,
        volume_ml = 1250,
        longest_side_mm = 600,
        symbol = "/",
        color = "dark_gray",
        looks_like = "scimitar",
        price_cents = 97000,
        price_postapoc_cents = 4000,
        melee_to_hit = 0,
        techniques = { "WBLOCK_2", "RAPID", "BRUTAL", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "MEDIUM_SWORDS", "FENCING_WEAPONRY" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 144)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 7)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 34)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_talwar",
        copy_from = "mc_talwar",
        looks_like = "mc_talwar",
        name = ccb.content.plural_text("high steel talwar", "high steel talwars"),
        description = ccb.content.text("A curved sword used by the Raj of India in the 16th century, a talwar is usually impeccably decorated and able to take off a limb with a single swipe.\n\nThis one has a proper grip and is made of high steel, you've even gotten the circular pommel right!"),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_talwar",
        copy_from = "mc_talwar",
        looks_like = "mc_talwar",
        name = ccb.content.plural_text("hardened steel talwar", "hardened steel talwars"),
        description = ccb.content.text("A curved sword used by the Raj of India in the 16th century, a talwar is usually impeccably decorated and able to take off a limb with a single swipe.\n\nThis one has a proper grip and is made of hardened steel and is otherwise a fine weapon."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_talwar",
        copy_from = "mc_talwar",
        looks_like = "mc_talwar",
        name = ccb.content.plural_text("tempered steel talwar", "tempered steel talwars"),
        description = ccb.content.text("A curved sword used by the Raj of India in the 16th century, a talwar is usually impeccably decorated and able to take off a limb with a single swipe.\n\nThis one has a proper grip and is made of tempered steel, and pre-apocalypse a Raj could have used it."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 4 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_kilij",
        copy_from = "mc_kilij",
        looks_like = "mc_kilij",
        name = ccb.content.plural_text("mild steel kilij", "mild steel kilijes"),
        description = ccb.content.text("A Turkish saber, the kilij is quite a bit heavier than most Middle Eastern sabers and has a distinctive wide tip called a yelman, which gives it vicious cutting power but means it requires a special scabbard.\n\nThis one has been made of mild steel, and doesn't even have a proper grip or truly sharp edge."),
        melee_to_hit = -1,
    }
    item:clear_flags()
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:adjust_quality("BUTCHER", -1)
    item:adjust_measurements { price_cents = { factor = 0.75 }, price_postapoc_cents = { factor = 0.75 } }
    item:adjust_melee_damage { bonuses = { cut = -5 } }
    item:replace_material("leather", "lc_steel")
    item:replace_material("mc_steel", "lc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "mc_kilij",
        category = "weapons",
        name = ccb.content.plural_text("medium steel kilij", "medium steel kilijes"),
        description = ccb.content.text("A Turkish saber, the kilij is quite a bit heavier than most Middle Eastern sabers and has a distinctive wide tip called a yelman, which gives it vicious cutting power but means it requires a special scabbard.\n\nThis one has a proper grip and is made of medium steel."),
        mass_milligrams = 2200000,
        volume_ml = 1250,
        longest_side_mm = 900,
        symbol = "/",
        color = "dark_gray",
        looks_like = "scimitar",
        price_cents = 97000,
        price_postapoc_cents = 4000,
        melee_to_hit = 0,
        techniques = { "WBLOCK_2", "RAPID", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "MEDIUM_SWORDS" },
        repair_materials = { "mc_steel" },
    }
    item:material("leather", 1)
    item:material("mc_steel", 144)
    item:quality("CUT", 2)
    item:quality("BUTCHER", 7)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("CONDUCTIVE")
    item:flag("SHEATH_SWORD")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 41)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:fault_group("bladed_weapon_craft_failures", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_kilij",
        copy_from = "mc_kilij",
        looks_like = "mc_kilij",
        name = ccb.content.plural_text("high steel kilij", "high steel kilijes"),
        description = ccb.content.text("A Turkish saber, the kilij is quite a bit heavier than most Middle Eastern sabers and has a distinctive wide tip called a yelman, which gives it vicious cutting power but means it requires a special scabbard.\n\nThis one has a proper grip and is made of high steel."),
    }
    item:adjust_quality("BUTCHER", 1)
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { cut = 2 } }
    item:replace_material("mc_steel", "hc_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_kilij",
        copy_from = "mc_kilij",
        looks_like = "mc_kilij",
        name = ccb.content.plural_text("hardened steel kilij", "hardened steel kilijes"),
        description = ccb.content.text("A Turkish saber, the kilij is quite a bit heavier than most Middle Eastern sabers and has a distinctive wide tip called a yelman, which gives it vicious cutting power but means it requires a special scabbard.\n\nThis one has a proper grip and is made of hardened steel."),
    }
    item:adjust_quality("BUTCHER", 2)
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { cut = 3 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "ch_steel")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_kilij",
        copy_from = "mc_kilij",
        looks_like = "mc_kilij",
        name = ccb.content.plural_text("tempered steel kilij", "tempered steel kilijes"),
        description = ccb.content.text("A Turkish saber, the kilij is quite a bit heavier than most Middle Eastern sabers and has a distinctive wide tip called a yelman, which gives it vicious cutting power but means it requires a special scabbard.\n\nThis one is made of tempered steel, and has a razor's edge and is impeccably balanced."),
    }
    item:adjust_quality("BUTCHER", 3)
    item:adjust_measurements { price_cents = { factor = 1.15 }, price_postapoc_cents = { factor = 1.15 } }
    item:adjust_melee_damage { bonuses = { cut = 4 } }
    item:replace_material("leather", "kevlar")
    item:replace_material("mc_steel", "qt_steel")
    item:tool()
    content.add(item)
end

do
    -- Highest non-powertool butchering quality.  It's made for skinning and butchering game, which is what you're generally doing.  Based on Buck 103 skinner.
    local item = content.Item {
        id = "knife_hunting",
        category = "weapons",
        name = ccb.content.plural_text("hunting knife", "hunting knives"),
        description = ccb.content.text("Commonly used by hunters, this single-edged sheath knife is designed for cutting and skinning game rather than combat."),
        mass_milligrams = 121000,
        volume_ml = 100,
        longest_side_mm = 200,
        price_cents = 4000,
        price_postapoc_cents = 750,
        melee_to_hit = -1,
        symbol = "/",
        color = "dark_gray",
        replace_qualities = true,
        weapon_categories = { "KNIVES" },
        repair_materials = { "steel" },
    }
    item:material("steel", 1)
    item:material("leather", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 1)
    item:quality("BUTCHER", 30)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("CONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("cut", 12)
    item:fault_group("handle_short", {  })
    item:fault_group("blade_general", { weight_multiplier = 5 })
    item:tool()
    content.add(item)
end
