local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "pitchfork",
        name = ccb.content.plural_text("pitchfork", "pitchforks"),
        category = "tools",
        description = ccb.content.text("An agricultural tool with a long wooden shaft and four spikes.  Normally used to lift hay."),
        mass_milligrams = 1000000,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1", "DEF_DISARM", "MOUNTED_CHARGE" },
        volume_ml = 1750,
        longest_side_mm = 1400,
        melee_to_hit = -1,
        replace_qualities = true,
        weapon_categories = { "SPEARS" },
        price_cents = 2000,
        price_postapoc_cents = 500,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 18)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 2 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "pointy_stick",
        symbol = "/",
        color = "brown",
        name = ccb.content.plural_text("pointy stick", "pointy sticks"),
        description = ccb.content.text("A simple wooden pole with one end sharpened to a point."),
        volume_ml = 1250,
        longest_side_mm = 800,
        mass_milligrams = 900000,
        melee_to_hit = -2,
        price_postapoc_cents = 10,
        techniques = { "WBLOCK_1" },
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 9)
    item:fault_group("staff_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "pointy_stick_long",
        name = ccb.content.plural_text("long pointy stick", "long pointy sticks"),
        description = ccb.content.text("A stout pole with one end sharpened to a point."),
        mass_milligrams = 1551000,
        price_postapoc_cents = 10,
        color = "brown",
        looks_like = "spear_wood",
        symbol = "/",
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
        volume_ml = 2500,
        longest_side_mm = 2050,
        melee_to_hit = -1,
        weapon_categories = { "SPEARS" },
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NPC_THROWN")
    item:flag("SHEATH_SPEAR")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 9)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_wood_simple",
        copy_from = "spear_wood",
        looks_like = "spear_wood",
        name = ccb.content.plural_text("wooden spear", "wooden spears"),
        description = ccb.content.text("A stout wooden pole with a whittled point."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_shaft_sharpened",
        name = ccb.content.plural_text("sharpened spear shaft", "sharpened spear shafts"),
        description = ccb.content.text("You've gone through the effort of making a proper spear shaft, but instead of attaching something sharp to the end you just whittled a point into the wood.  The peak of pointy stick technology."),
        mass_milligrams = 1000000,
        price_postapoc_cents = 50,
        color = "brown",
        symbol = "/",
        looks_like = "spear_wood",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        volume_ml = 1250,
        longest_side_mm = 1800,
        melee_to_hit = 1,
        weapon_categories = { "SPEARS" },
        price_cents = 4000,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NPC_THROWN")
    item:flag("SHEATH_SPEAR")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("stab", 18)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    -- Name changed to simple makeshift glaive, but changing the id would break e.g.  tilesets.
    local item = content.Item {
        id = "makeshift_halberd",
        name = ccb.content.plural_text("simple makeshift glaive", "simple makeshift glaives"),
        ascii_picture = "makeshift_glaive",
        description = ccb.content.text("A large blade attached to a stout section of tree branch.  It could do a considerable amount of damage, but the blade isn't secured very well and could easily break off."),
        mass_milligrams = 1800000,
        volume_ml = 3000,
        longest_side_mm = 1800,
        price_cents = 5000,
        price_postapoc_cents = 250,
        melee_to_hit = -1,
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -42)
    item:clear_flags()
    item:flag("REACH_ATTACK")
    item:flag("POLEARM")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 13)
    item:melee_damage("cut", 31)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 2 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_glaive",
        ascii_picture = "makeshift_glaive",
        copy_from = "makeshift_halberd",
        looks_like = "makeshift_halberd",
        name = ccb.content.plural_text("makeshift glaive", "makeshift glaives"),
        description = ccb.content.text("A stout tree branch that has been carefully split and reinforced.  At the split point, a sharp blade has been bolted into place and reinforced with layers of sturdy wrapped bindings."),
        price_postapoc_cents = 400,
        replace_qualities = true,
    }
    item:quality("CUT", 1)
    item:quality("BUTCHER", -28)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_knife_proper",
        name = ccb.content.plural_text("knife spear", "knife spears"),
        description = ccb.content.text("A stout wooden pole with the blade of a knife bolted into place at the end.  The shape of a knife blade isn't ideal for a spear, but it's still very sharp and effective."),
        mass_milligrams = 1500000,
        price_postapoc_cents = 3000,
        color = "light_gray",
        symbol = "/",
        looks_like = "spear_steel",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        volume_ml = 1350,
        longest_side_mm = 1800,
        melee_to_hit = 1,
        weapon_categories = { "SPEARS" },
        price_cents = 16000,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:quality("CUT", 1)
    item:quality("COOK", 1)
    item:quality("BUTCHER", -28)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("stab", 26)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 2 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_steel_crude",
        name = ccb.content.plural_text("crude steel spear", "crude steel spears"),
        description = ccb.content.text("A stout wooden pole with a misshapen metal spike seated into the end and bolted into place."),
        mass_milligrams = 1500000,
        price_postapoc_cents = 2000,
        color = "light_gray",
        symbol = "/",
        looks_like = "spear_steel",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        volume_ml = 1350,
        longest_side_mm = 1800,
        melee_to_hit = 1,
        weapon_categories = { "SPEARS" },
        price_cents = 16000,
        replace_qualities = true,
    }
    item:material("wood", 95)
    item:material("mc_steel", 5)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("stab", 24)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 2 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "crude_goedendag",
        copy_from = "spear_steel_crude",
        looks_like = "spear_steel_crude",
        techniques = { "WBLOCK_1", "BRUTAL", "MOUNTED_CHARGE" },
        name = ccb.content.plural_text("crude goedendag", "crude goedendags"),
        description = ccb.content.text("A stout wooden pole, slightly thicker at the end, with a metal cap and a spike protruding straight up from the top."),
        weapon_categories = { "GREAT_HAMMERS", "SPEARS" },
    }
    item:adjust_measurements { longest_side_mm = { offset = -300 } }
    item:adjust_melee_damage { bonuses = { bash = 18, stab = -14 } }
    item:fault_group("handle_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_copper",
        name = ccb.content.plural_text("copper spear", "copper spears"),
        description = ccb.content.text("A stout wooden pole with a spearhead worked from copper."),
        mass_milligrams = 1500000,
        price_postapoc_cents = 3000,
        color = "light_red",
        symbol = "/",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        volume_ml = 1350,
        longest_side_mm = 1800,
        melee_to_hit = 1,
        weapon_categories = { "SPEARS" },
        price_cents = 1400,
        replace_qualities = true,
    }
    item:material("copper", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("stab", 28)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 3 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_spear_steel",
        copy_from = "spear_steel",
        looks_like = "spear_steel",
        name = ccb.content.plural_text("mild steel spear", "mild steel spears"),
        description = ccb.content.text("A stout wooden pole with a mild steel spearhead.  Although made of low quality steel, it is still reasonably effective, if not very durable."),
    }
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:adjust_measurements { price_cents = { factor = 0.8 }, price_postapoc_cents = { factor = 0.8 } }
    item:adjust_melee_damage { bonuses = { stab = -2 } }
    item:replace_material("mc_steel", "lc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_spear_steel",
        copy_from = "spear_steel",
        looks_like = "spear_steel",
        name = ccb.content.plural_text("high steel spear", "high steel spears"),
        description = ccb.content.text("A stout wooden pole with a hand-forged high steel spearhead.  The high steel offers superior sharpness and penetrating power."),
    }
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { stab = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_spear_steel",
        copy_from = "spear_steel",
        looks_like = "spear_steel",
        name = ccb.content.plural_text("hardened steel spear", "hardened steel spears"),
        description = ccb.content.text("A stout wooden pole tipped with a hand-forged hardened steel spearhead.  The case-hardened and carefully slack quenched tip offers superior killing power, making this a spear fit for a medieval lord."),
    }
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { stab = 3 } }
    item:replace_material("mc_steel", "ch_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "sharpened_pipe",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("sharpened pipe", "sharpened pipes"),
        description = ccb.content.text("A pipe with one end cut off at an angle."),
        volume_ml = 365,
        longest_side_mm = 600,
        mass_milligrams = 585000,
        melee_to_hit = -2,
        price_cents = 200,
        price_postapoc_cents = 10,
        techniques = { "WBLOCK_1" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("stab", 13)
    item:fault_group("steel_pipe_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "simple_spear_pipe",
        name = ccb.content.plural_text("basic pipe spear", "basic pipe spears"),
        description = ccb.content.text("Three pipes tightly fit together with one end cut down to a point."),
        mass_milligrams = 1800000,
        price_postapoc_cents = 150,
        color = "light_gray",
        looks_like = "spear_pipe",
        symbol = "/",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        volume_ml = 1130,
        longest_side_mm = 1800,
        melee_to_hit = -1,
        weapon_categories = { "SPEARS" },
        price_cents = 8000,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("stab", 18)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("spearhead", {  })
    item:fault_group("steel_pipe_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_pipe",
        name = ccb.content.plural_text("pipe spear", "pipe spears"),
        description = ccb.content.text("Three pipes tightly fit together with some wrappings for a handle around one end and a sharp tip on the other."),
        mass_milligrams = 2122000,
        price_postapoc_cents = 250,
        color = "light_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        volume_ml = 1135,
        longest_side_mm = 1800,
        melee_to_hit = -1,
        weapon_categories = { "SPEARS" },
        price_cents = 8000,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:melee_damage("stab", 24)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("spearhead", {  })
    item:fault_group("steel_pipe_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "simple_pike_pipe",
        name = ccb.content.plural_text("basic pipe pike", "basic pipe pikes"),
        description = ccb.content.text("Five pipes threaded together to form a very crude pike.  Heavy, slow, and all around cumbersome to carry and fight with."),
        mass_milligrams = 5000000,
        price_postapoc_cents = 100,
        color = "light_gray",
        looks_like = "spear_pipe",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        volume_ml = 4000,
        longest_side_mm = 3000,
        melee_to_hit = -3,
        weapon_categories = { "SPEARS" },
        price_cents = 12000,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("POLEARM")
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("stab", 17)
    item:fault_group("spearhead", {  })
    item:fault_group("steel_pipe_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "pointed_rebar",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("pointed rebar", "pointed rebars"),
        description = ccb.content.text("A rod of rebar that's been crudely hammered into a point."),
        price_cents = 500,
        price_postapoc_cents = 50,
        mass_milligrams = 1233000,
        volume_ml = 157,
        longest_side_mm = 800,
        melee_to_hit = -1,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "SPEARS" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:quality("COOK", 1)
    item:quality("HAMMER", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:melee_damage("stab", 4)
    item:fault_group("steel_pipe_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "sharp_rebar",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("sharpened rebar", "sharpened rebars"),
        description = ccb.content.text("A rod of rebar that's been cut and sharpened to a point."),
        price_cents = 500,
        price_postapoc_cents = 50,
        mass_milligrams = 1100000,
        volume_ml = 150,
        longest_side_mm = 800,
        melee_to_hit = -1,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "SPEARS" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("FRAGILE_MELEE")
    item:quality("COOK", 1)
    item:quality("HAMMER", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("stab", 13)
    item:fault_group("steel_pipe_short", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_rebar",
        symbol = "/",
        color = "dark_gray",
        name = ccb.content.plural_text("rebar spear", "rebar spears"),
        description = ccb.content.text("Two rods of rebar welded together with a pointed tip."),
        price_cents = 1000,
        price_postapoc_cents = 100,
        mass_milligrams = 2600000,
        volume_ml = 450,
        longest_side_mm = 1650,
        melee_to_hit = -1,
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
        weapon_categories = { "SPEARS" },
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("FRAGILE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:quality("COOK", 1)
    item:quality("HAMMER", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 16)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("steel_pipe_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "qiang",
        name = ccb.content.plural_text("qiang", "qiang"),
        description = ccb.content.text("An ancient Chinese spear, typically with a tassel just below the spearhead and larger than most European spears.  One of the four major weapons in folklore, alongside the dao saber, jian sword, and gun staff."),
        mass_milligrams = 2200000,
        price_postapoc_cents = 5500,
        color = "light_gray",
        symbol = "/",
        looks_like = "spear_steel",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        volume_ml = 3000,
        longest_side_mm = 2500,
        melee_to_hit = 0,
        weapon_categories = { "SPEARS" },
        price_cents = 80000,
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("POLEARM")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("stab", 43)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    -- Average weight of wood axe head (2.5lb) and fireaxe head (6lb) + 1kg spear shaft
    local item = content.Item {
        id = "halberd_crude",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("crude halberd", "crude halberds"),
        description = ccb.content.text("A homemade halberd, made by attaching an axe head to a spear shaft.  Not as good as the real thing, but a whole heck of a lot cheaper and easier."),
        price_cents = 4000,
        ascii_picture = "halberd",
        weapon_categories = { "POLEARMS" },
        techniques = { "WBLOCK_1", "WIDE", "SWEEP", "MOUNTED_CHARGE" },
        mass_milligrams = 2930000,
        volume_ml = 2000,
        longest_side_mm = 1800,
        melee_to_hit = -1,
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
    item:quality("BUTCHER", -70)
    item:quality("AXE", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:melee_damage("cut", 26)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "bill_hook",
        category = "weapons",
        name = ccb.content.plural_text("bill-hook", "bill-hooks"),
        description = ccb.content.text("A nasty set of hooks and spikes set upon a shaft, with a metal endcap.  This ain't no gardening tool, and it'll hook someone very easily."),
        mass_milligrams = 2100000,
        volume_ml = 2300,
        longest_side_mm = 1600,
        price_cents = 5500,
        price_postapoc_cents = 4000,
        melee_to_hit = 0,
        symbol = "/",
        color = "brown",
        looks_like = "glaive",
        replace_qualities = true,
        techniques = { "WBLOCK_1", "BRUTAL", "WIDE", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "POLEARMS", "HOOKING_WEAPONRY" },
    }
    item:material("wood", 1)
    item:material("mc_steel", 1)
    item:quality("AXE", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -70)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 35)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "naginata_inferior",
        copy_from = "naginata",
        looks_like = "naginata",
        name = ccb.content.plural_text("naginata", "naginata"),
        description = ccb.content.text("A sturdy polearm with a curved blade, made in the same manner as the katana and other Japanese blades.  This one has a bit of wiggle to its blade and feels a bit shoddily made."),
        price_cents = 8000,
        price_postapoc_cents = 1500,
    }
    item:material("budget_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:adjust_melee_damage { factors = { bash = 4.14, cut = 0.25 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "naginata_machete",
        name = ccb.content.plural_text("machete naginata", "machete naginata"),
        description = ccb.content.text("This crude facsimile of a naginata was made by attaching a machete to the end of a spear."),
        mass_milligrams = 1840000,
        color = "light_gray",
        symbol = "/",
        techniques = { "WIDE", "WBLOCK_1", "MOUNTED_CHARGE" },
        volume_ml = 2040,
        longest_side_mm = 2000,
        melee_to_hit = 1,
        replace_qualities = true,
        weapon_categories = { "POLEARMS" },
        price_cents = 4000,
        price_postapoc_cents = 2500,
        category = "weapons",
    }
    item:material("wood", 25)
    item:material("mc_steel", 21)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -24)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("cut", 30)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "pike_copper",
        category = "weapons",
        name = ccb.content.plural_text("copper pike", "copper pikes", "weapon"),
        description = ccb.content.text("A medieval weapon consisting of a very long wooden shaft tipped with a copper spearhead."),
        mass_milligrams = 2500000,
        volume_ml = 3500,
        longest_side_mm = 3000,
        price_cents = 15000,
        price_postapoc_cents = 1000,
        melee_to_hit = -1,
        symbol = "/",
        color = "brown",
        looks_like = "pike",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "SPEARS" },
    }
    item:material("copper", 1)
    item:material("wood", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("POLEARM")
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("NONCONDUCTIVE")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:melee_damage("stab", 23)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "pike_bronze",
        name = ccb.content.plural_text("bronze pike", "bronze pikes", "weapon"),
        description = ccb.content.text("A medieval weapon consisting of a very long wooden shaft tipped with a bronze spearhead."),
        mass_milligrams = 2500000,
        volume_ml = 3500,
        longest_side_mm = 3000,
        price_cents = 40000,
        price_postapoc_cents = 4000,
        melee_to_hit = 0,
        symbol = "/",
        color = "brown",
        looks_like = "pike_copper",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "SPEARS" },
        category = "weapons",
    }
    item:material("bronze", 1)
    item:material("wood", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("POLEARM")
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("REACH3")
    item:flag("NONCONDUCTIVE")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:melee_damage("stab", 28)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_pike",
        copy_from = "pike",
        looks_like = "pike",
        name = ccb.content.plural_text("mild steel pike", "mild steel pikes"),
        description = ccb.content.text("A very long wooden shaft with a mild steel pike head.  Although made of low quality steel, it remains a formidable reach weapon, if somewhat less durable."),
    }
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH3")
    item:flag("REACH_ATTACK")
    item:flag("SPEAR")
    item:adjust_measurements { price_cents = { factor = 0.8 }, price_postapoc_cents = { factor = 0.8 } }
    item:adjust_melee_damage { bonuses = { stab = -2 } }
    item:replace_material("mc_steel", "lc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "hc_pike",
        copy_from = "pike",
        looks_like = "pike",
        name = ccb.content.plural_text("high steel pike", "high steel pikes"),
        description = ccb.content.text("A very long wooden shaft with a hand-forged high steel pike head.  The improved steel offers better sharpness and penetration."),
    }
    item:adjust_measurements { price_cents = { factor = 1.05 }, price_postapoc_cents = { factor = 1.05 } }
    item:adjust_melee_damage { bonuses = { stab = 1 } }
    item:replace_material("mc_steel", "hc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "ch_pike",
        copy_from = "pike",
        looks_like = "pike",
        name = ccb.content.plural_text("hardened steel pike", "hardened steel pikes"),
        description = ccb.content.text("A very long wooden shaft tipped with a case-hardened steel pike head.  Its refined edge and hardened tip make it deadly in combat."),
    }
    item:adjust_measurements { price_cents = { factor = 1.1 }, price_postapoc_cents = { factor = 1.1 } }
    item:adjust_melee_damage { bonuses = { stab = 3 } }
    item:replace_material("mc_steel", "hc_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "qt_pike",
        copy_from = "pike",
        looks_like = "pike",
        name = ccb.content.plural_text("tempered steel pike", "tempered steel pikes"),
        description = ccb.content.text("A very long wooden shaft tipped with a masterfully tempered steel pike head.  The blade is razor-sharp and perfectly tapered.  The pinnacle of polearm craftsmanship."),
    }
    item:adjust_measurements { price_cents = { factor = 1.2 }, price_postapoc_cents = { factor = 1.2 } }
    item:adjust_melee_damage { bonuses = { stab = 5 } }
    item:replace_material("mc_steel", "qt_steel")
    content.add(item)
end

do
    local item = content.Item {
        id = "pike_inferior",
        copy_from = "pike",
        looks_like = "pike",
        name = ccb.content.plural_text("pike", "pikes", "weapon"),
        description = ccb.content.text("A medieval weapon consisting of a very long wooden shaft tipped with an iron spearhead.  The head seems to be pretty dull, and the whole thing feels poorly made."),
        price_cents = 40000,
        price_postapoc_cents = 1250,
    }
    item:material("budget_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("REACH3")
    item:flag("REACH_ATTACK")
    item:flag("SPEAR")
    item:adjust_melee_damage { factors = { bash = 2.7, stab = 0.25 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "scythe_war",
        name = ccb.content.plural_text("war scythe", "war scythes"),
        description = ccb.content.text("A pole weapon with a curving single-edged blade.  Its blade bears some superficial resemblance to that of an agricultural scythe from which it likely evolved."),
        mass_milligrams = 3013000,
        volume_ml = 3250,
        longest_side_mm = 1500,
        price_cents = 16000,
        price_postapoc_cents = 2500,
        melee_to_hit = 1,
        symbol = "/",
        color = "light_gray",
        techniques = { "WIDE", "BRUTAL", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -22)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 17)
    item:melee_damage("cut", 42)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_dory",
        name = ccb.content.plural_text("dory", "dories"),
        description = ccb.content.text("A well-made spear with a bronze head, Greek in origin.  Despite its large size, it was frequently used one-handed."),
        mass_milligrams = 2200000,
        volume_ml = 3000,
        longest_side_mm = 2500,
        price_cents = 10000,
        price_postapoc_cents = 3500,
        melee_to_hit = 0,
        symbol = "/",
        color = "yellow",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "SPEARS" },
    }
    item:material("bronze", 1)
    item:material("wood", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:flag("NONCONDUCTIVE")
    item:flag("POLEARM")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("stab", 39)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    -- An other-earth interpretation of a hewing short spear, combining the hooking head of the Italian partisan spear with the short Zulu ixwa.  On par or worse than other qt_steel weapons, and uncraftable, being alien.
    local item = content.Item {
        id = "string_dimension_partigiana_ixwa",
        name = ccb.content.plural_text("partigiana-ixwa", "partigiana-ixwas"),
        description = ccb.content.text("A steel shortspear from an alien world, made of a single, continuous piece of tempered steel.  The head is a broad cutting-stabbing implement with small hooks on either side."),
        mass_milligrams = 3200000,
        volume_ml = 400,
        longest_side_mm = 910,
        price_cents = 10000,
        price_postapoc_cents = 3500,
        melee_to_hit = 1,
        symbol = "/",
        color = "white",
        techniques = { "WBLOCK_1", "PENETRATE", "DEF_DISARM" },
        replace_qualities = true,
        weapon_categories = { "SPEARS", "HOOKING_WEAPONRY" },
    }
    item:material("qt_steel", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("CONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("cut", 12)
    item:melee_damage("stab", 35)
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "poleaxe",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("poleaxe", "poleaxes"),
        description = ccb.content.text("A polearm with an axe head, a small hammer on the back, and a short dagger-like spike on top.  It's less heavy than most polearms and has a smaller head, making it slightly quicker."),
        price_cents = 40000,
        ascii_picture = "halberd",
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
        techniques = { "WBLOCK_1", "WIDE", "BRUTAL", "MOUNTED_CHARGE" },
        mass_milligrams = 2200000,
        volume_ml = 3000,
        longest_side_mm = 1600,
        melee_to_hit = 1,
        price_postapoc_cents = 5000,
        replace_qualities = true,
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
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 28)
    item:melee_damage("cut", 31)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    -- Couldn't find a good way to pluralize the transliteration.
    local item = content.Item {
        id = "ji",
        name = ccb.content.plural_text("ji", "ji"),
        description = ccb.content.text("A bronze polearm that originated in the Shang dynasty of China, if not earlier.  It combines a spear head with the perpendicular blade of the earlier ge or dagger-axe."),
        mass_milligrams = 3175000,
        volume_ml = 3750,
        longest_side_mm = 1800,
        price_cents = 50000,
        price_postapoc_cents = 3500,
        melee_to_hit = 1,
        symbol = "/",
        color = "yellow",
        techniques = { "WBLOCK_1", "DEF_DISARM", "MOUNTED_CHARGE" },
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
    }
    item:material("wood", 1)
    item:material("bronze", 1)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("POLEARM")
    item:flag("REACH_ATTACK")
    item:flag("ALWAYS_TWOHAND")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:melee_damage("cut", 53)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_stone",
        name = ccb.content.plural_text("stone spear", "stone spears"),
        description = ccb.content.text("A stout wooden pole with a sharp stone spearhead."),
        mass_milligrams = 1500000,
        volume_ml = 1350,
        longest_side_mm = 1800,
        price_cents = 1300,
        price_postapoc_cents = 50,
        melee_to_hit = 1,
        ascii_picture = "spear_stone",
        symbol = "/",
        color = "light_gray",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "SPEARS" },
    }
    item:material("wood", 1)
    item:material("stone", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("stab", 20)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "spear_stone_simple",
        name = ccb.content.plural_text("simple stone spear", "simple stone spears"),
        description = ccb.content.text("A long stick with a sharp stone spearhead."),
        mass_milligrams = 1600000,
        volume_ml = 1750,
        longest_side_mm = 1800,
        price_cents = 1300,
        price_postapoc_cents = 50,
        melee_to_hit = -1,
        ascii_picture = "spear_stone",
        symbol = "/",
        color = "light_gray",
        looks_like = "spear_stone",
        techniques = { "WBLOCK_1", "PENETRATE", "MOUNTED_CHARGE" },
        replace_qualities = true,
        weapon_categories = { "SPEARS" },
    }
    item:material("wood", 1)
    item:material("stone", 1)
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_flags()
    item:flag("SPEAR")
    item:flag("REACH_ATTACK")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("stab", 20)
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("spearhead", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "aztec_spear_scrap",
        name = ccb.content.plural_text("makeshift tepoztopili", "makeshift tepoztopilis"),
        description = ccb.content.text("This is a long polearm with an oar-like oval head covered with razors.  Its shape make it suitable for both thrusting and slashing.  It resembles the Mesoamerican Tepoztopili, though the shaft is not very sturdy."),
        mass_milligrams = 1900000,
        volume_ml = 3000,
        price_cents = 200,
        price_postapoc_cents = 50,
        symbol = "/",
        color = "brown",
        longest_side_mm = 1800,
        weapon_categories = { "POLEARMS" },
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        melee_to_hit = -1,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 10)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "aztec_spear_glass",
        name = ccb.content.plural_text("glass bladed tepoztopili", "glass bladed tepoztopilis"),
        description = ccb.content.text("This is a long polearm with an oar-like oval head covered with glass.  Its shape make it suitable for both thrusting and slashing.  It resembles the Mesoamerican Tepoztopili, though the shaft is not very sturdy."),
        mass_milligrams = 1850000,
        volume_ml = 3000,
        price_cents = 200,
        price_postapoc_cents = 50,
        symbol = "/",
        color = "brown",
        longest_side_mm = 1800,
        weapon_categories = { "POLEARMS" },
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        melee_to_hit = -1,
    }
    item:material("wood", 1)
    item:material("glass", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 8)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "aztec_spear_stone",
        name = ccb.content.plural_text("stone bladed tepoztopili", "stone bladed tepoztopilis"),
        description = ccb.content.text("This is a long polearm with an oar-like oval head covered with stones.  Its shape make it suitable for both thrusting and slashing.  It resembles the Mesoamerican Tepoztopili, though the shaft is not very sturdy."),
        mass_milligrams = 2000000,
        volume_ml = 3000,
        price_cents = 200,
        price_postapoc_cents = 50,
        symbol = "/",
        color = "brown",
        longest_side_mm = 1800,
        weapon_categories = { "POLEARMS" },
        techniques = { "WBLOCK_1", "SWEEP", "MOUNTED_CHARGE" },
        melee_to_hit = -1,
    }
    item:material("wood", 1)
    item:material("stone", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:melee_damage("cut", 4)
    item:mounted_charge { max_steps = 15, damage_type = "bash", multiplier_per_step = 0.06, max_multiplier = 1.25 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "lc_aztec_spear",
        name = ccb.content.plural_text("mild steel bladed tepoztopili", "mild steel bladed tepoztopilis"),
        description = ccb.content.text("This is a redesigned version of the Mesoamerican tepoztopili.  It's an elliptical piece of carved wood lined with sharp mild steel blades, firmly attached to a stout spear shaft."),
        mass_milligrams = 2950000,
        volume_ml = 3000,
        price_cents = 4000,
        price_postapoc_cents = 1500,
        symbol = "/",
        color = "brown",
        longest_side_mm = 2100,
        weapon_categories = { "POLEARMS" },
        techniques = { "WBLOCK_1", "SWEEP", "WIDE", "MOUNTED_CHARGE" },
        melee_to_hit = 1,
    }
    item:material("wood", 1)
    item:material("lc_steel", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("POLEARM")
    item:flag("SHEATH_SPEAR")
    item:flag("SPEAR")
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    item:melee_damage("cut", 12)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "javelin",
        name = ccb.content.plural_text("wooden javelin", "wooden javelins"),
        description = ccb.content.text("A fire-hardened wooden spear honed to a sharper point."),
        mass_milligrams = 600000,
        color = "brown",
        symbol = "/",
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
        volume_ml = 1000,
        longest_side_mm = 1400,
        melee_to_hit = -1,
        weapon_categories = { "SPEARS" },
        price_cents = 4000,
        price_postapoc_cents = 250,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("SHEATH_SPEAR")
    item:flag("JAVELIN")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("stab", 11)
    item:throwing_damage { { type = "bash", amount = 5 }, { type = "stab", amount = 11 } }
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("staff_long", {  })
    content.add(item)
end

do
    local item = content.Item {
        id = "javelin_iron",
        name = ccb.content.plural_text("iron javelin", "iron javelins"),
        description = ccb.content.text("An iron-tipped wooden throwing spear."),
        mass_milligrams = 960000,
        color = "light_gray",
        symbol = "/",
        techniques = { "WBLOCK_1", "MOUNTED_CHARGE" },
        volume_ml = 1000,
        longest_side_mm = 1400,
        melee_to_hit = -1,
        weapon_categories = { "SPEARS" },
        price_cents = 9000,
        price_postapoc_cents = 500,
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("iron", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("JAVELIN")
    item:quality("COOK", 1)
    item:clear_use_actions()
    item:native_use("HEAT_SOLID_ITEMS")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("stab", 19)
    item:throwing_damage { { type = "bash", amount = 5 }, { type = "stab", amount = 17 } }
    item:mounted_charge { max_steps = 15, damage_type = "stab", multiplier_per_step = 0.1, max_multiplier = 1.5 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("spearhead", {  })
    content.add(item)
end
