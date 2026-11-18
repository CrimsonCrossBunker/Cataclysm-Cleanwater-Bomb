local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "digging_stick",
        name = ccb.content.plural_text("digging stick", "digging sticks"),
        category = "tools",
        description = ccb.content.text("A large stick with the end carved into a broad blade for digging.  It could be used to dig shallow pits, but not deep ones."),
        mass_milligrams = 1133000,
        volume_ml = 1500,
        longest_side_mm = 900,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = 0,
        symbol = "/",
        color = "brown",
        techniques = { "WBLOCK_1" },
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("DIG", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "scythe_fake",
        copy_from = "scythe",
        looks_like = "scythe",
        symbol = "/",
        color = "light_gray",
        name = ccb.content.plural_text("scythe", "scythes"),
        description = ccb.content.text("A dull, cheaply-made replica of an old-fashioned farming tool used to cut tall grass."),
        mass_milligrams = 1840000,
        price_cents = 4000,
        price_postapoc_cents = 40,
    }
    item:material("aluminum", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:adjust_melee_damage { factors = { bash = 1.8, cut = 0.064 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "hoe",
        name = ccb.content.plural_text("hoe", "hoes"),
        description = ccb.content.text("A farming implement.  You can use it to turn tillable land into a slow-to-cross pile of dirt, or dig a shallow pit."),
        mass_milligrams = 1088000,
        volume_ml = 3500,
        longest_side_mm = 1400,
        price_cents = 2000,
        price_postapoc_cents = 250,
        melee_to_hit = -1,
        symbol = "/",
        color = "brown",
        replace_qualities = true,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "HOOKING_WEAPONRY" },
    }
    item:material("mc_steel", 1)
    item:material("wood", 1)
    item:quality("DIG", 1)
    item:quality("SAW_W", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("NO_SALVAGE")
    item:clear_use_actions()
    item:native_use("MAKEMOUND")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_hoe",
        name = ccb.content.plural_text("bronze hoe", "bronze hoes"),
        description = ccb.content.text("A farming implement made from bronze.  The added heft and durability should let you till soil for farming more easily as well."),
        mass_milligrams = 3100000,
        volume_ml = 3500,
        longest_side_mm = 1400,
        price_cents = 2000,
        price_postapoc_cents = 250,
        melee_to_hit = -1,
        symbol = "/",
        color = "yellow",
        looks_like = "hoe",
        replace_qualities = true,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "HOOKING_WEAPONRY" },
    }
    item:material("bronze", 1)
    item:material("wood", 1)
    item:quality("DIG", 1)
    item:quality("SAW_W", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:clear_use_actions()
    item:native_use("MAKEMOUND")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "primitive_shovel",
        name = ccb.content.plural_text("wooden shovel", "wooden shovels"),
        description = ccb.content.text("A crude shovel with a shovelhead made from wood, historically used as an alternative to metal shovels when metal was too expensive.  It works passably well, but really can't compare to a metal shovel."),
        mass_milligrams = 1581000,
        volume_ml = 4000,
        longest_side_mm = 1200,
        price_cents = 100,
        symbol = "/",
        color = "brown",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("DIG", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 15)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rake",
        name = ccb.content.plural_text("metal rake", "metal rakes"),
        description = ccb.content.text("A sturdy metal rake, a must-have during autumn."),
        mass_milligrams = 1500000,
        volume_ml = 3500,
        longest_side_mm = 1500,
        price_cents = 1000,
        price_postapoc_cents = 150,
        symbol = "/",
        color = "brown",
    }
    item:material("lc_steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:melee_damage("cut", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "rake_plastic",
        name = ccb.content.plural_text("plastic rake", "plastic rakes"),
        description = ccb.content.text("A cheap plastic rake.  Will break quite quickly if used for anything other than raking leaves."),
        mass_milligrams = 1000000,
        volume_ml = 3500,
        longest_side_mm = 1500,
        price_cents = 750,
        price_postapoc_cents = 100,
        symbol = "/",
        color = "brown",
    }
    item:material("plastic", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 10)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "scythe",
        name = ccb.content.plural_text("scythe", "scythes"),
        description = ccb.content.text("An old-fashioned farming tool used to cut tall grass.  Despite being a giant blade on the end of a stick, it is incredibly awkward to use for anything but its intended purpose."),
        mass_milligrams = 2140000,
        volume_ml = 3250,
        longest_side_mm = 1400,
        price_cents = 8000,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = "/",
        color = "light_gray",
        techniques = { "WIDE", "BRUTAL" },
        replace_qualities = true,
        weapon_categories = { "HOOKING_WEAPONRY", "POLEARMS" },
    }
    item:material("ch_steel", 1)
    item:material("wood", 1)
    item:quality("CUT", 1)
    item:quality("GRASS_CUT", 2)
    item:quality("BUTCHER", -22)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 14)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "shovel_snow_plastic",
        looks_like = "shovel",
        name = ccb.content.plural_text("plastic snow shovel", "plastic snow shovels"),
        description = ccb.content.text("A cheap plastic shovel used for picking up snow and moving it somewhere else.  It was useful before the Cataclysm, but now it's useless."),
        mass_milligrams = 1500000,
        volume_ml = 3500,
        longest_side_mm = 1500,
        price_cents = 1000,
        price_postapoc_cents = 100,
        symbol = "/",
        color = "brown",
        techniques = { "WBLOCK_1" },
    }
    item:material("plastic", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "sickle_stone",
        name = ccb.content.plural_text("stone sickle", "stone sickles"),
        description = ccb.content.text("A primitive tool for cutting grass.  The sharp, crescent-shaped stone at the end of the handle is barely good enough for the job."),
        mass_milligrams = 470000,
        volume_ml = 800,
        longest_side_mm = 350,
        price_cents = 1000,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        symbol = "/",
        color = "light_gray",
        replace_qualities = true,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "SHORT_SWORDS" },
    }
    item:material("stone", 1)
    item:material("wood", 1)
    item:quality("CUT", 1)
    item:quality("GRASS_CUT", 1)
    item:quality("BUTCHER", 2)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("FRAGILE_MELEE")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("cut", 10)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_sickle",
        name = ccb.content.plural_text("bronze sickle", "bronze sickles"),
        description = ccb.content.text("A handheld grass-cutting tool with a cast bronze blade, fastened to a wood handle wrapped with leather."),
        mass_milligrams = 1000000,
        volume_ml = 1250,
        longest_side_mm = 500,
        price_cents = 1800,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = "L",
        color = "yellow",
        looks_like = "sickle",
        replace_qualities = true,
        techniques = { "WBLOCK_1" },
        weapon_categories = { "SHORT_SWORDS" },
    }
    item:material("bronze", 1)
    item:material("wood", 1)
    item:quality("CUT", 1)
    item:quality("GRASS_CUT", 2)
    item:quality("BUTCHER", 7)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("cut", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "brush_handaxe",
        name = ccb.content.plural_text("bill", "bills"),
        description = ccb.content.text("A slightly curved steel blade with a nice wooden handle, not too dissimilar to a machete."),
        weapon_categories = { "MEDIUM_SWORDS", "HAND_AXES" },
        looks_like = "machete",
        copy_from = "machete",
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "brush_axe",
        name = ccb.content.plural_text("bill axe", "bill axes"),
        description = ccb.content.text("The steel curved blade of a bill placed stoutly on top an axe handle.  It still isn't long enough to use as a spear, but it'll still cleave your enemies."),
        looks_like = "ax",
        mass_milligrams = 2100000,
        volume_ml = 1900,
        longest_side_mm = 800,
        price_cents = 2500,
        price_postapoc_cents = 1250,
        symbol = "P",
        color = "brown",
        replace_qualities = true,
        melee_to_hit = 0,
        techniques = { "WBLOCK_1", "BRUTAL", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "GREAT_AXES" },
    }
    item:material("wood", 1)
    item:material("mc_steel", 1)
    item:quality("AXE", 2)
    item:quality("GRASS_CUT", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -70)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:melee_damage("cut", 26)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "brush_pole",
        name = ccb.content.plural_text("bill pole", "bill poles"),
        description = ccb.content.text("A long, slightly curved steel blade on the end of a sturdy shaft.  Could be used to thoroughly ruin something's day, or cut branches and small trees."),
        mass_milligrams = 2400000,
        volume_ml = 2500,
        longest_side_mm = 1500,
        price_cents = 3000,
        price_postapoc_cents = 2400,
        melee_to_hit = -1,
        symbol = "/",
        color = "brown",
        looks_like = "glaive",
        replace_qualities = true,
        techniques = { "WBLOCK_1", "BRUTAL", "WIDE", "SWEEP", "MOUNTED_CHARGE" },
        weapon_categories = { "SPEARS" },
    }
    item:material("wood", 1)
    item:material("mc_steel", 1)
    item:quality("AXE", 1)
    item:quality("GRASS_CUT", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -70)
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("REACH_ATTACK")
    item:flag("NONCONDUCTIVE")
    item:flag("SHEATH_SPEAR")
    item:flag("ALWAYS_TWOHAND")
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:melee_damage("cut", 28)
    item:mounted_charge { max_steps = 15, damage_type = "cut", multiplier_per_step = 0.08, max_multiplier = 1.3 }
    item:fault_group("handle_long", { weight_multiplier = 4 })
    item:fault_group("blade_general", {  })
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_brush_handaxe",
        name = ccb.content.plural_text("bronze bill", "bronze bills"),
        description = ccb.content.text("The bronze curved blade of a bill placed stoutly atop an axe handle.  It still isn't long enough to use as a spear, but it'll still cleave your enemies."),
        looks_like = "brush_handaxe",
        copy_from = "brush_handaxe",
        color = "yellow",
    }
    item:material("wood", 1)
    item:material("bronze", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:melee_damage("cut", 18)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_brush_axe",
        name = ccb.content.plural_text("bronze bill axe", "bronze bill axes"),
        description = ccb.content.text("A slightly curved bronze blade with a nice wooden handle, not too dissimilar to a machete."),
        looks_like = "brush_axe",
        copy_from = "brush_axe",
        color = "yellow",
    }
    item:material("wood", 1)
    item:material("bronze", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:melee_damage("cut", 20)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_brush_pole",
        name = ccb.content.plural_text("bronze bill pole", "bronze bill poles"),
        description = ccb.content.text("A long, slightly curved and hooked bronze blade on the end of a sturdy shaft.  Could be used to thoroughly ruin something's day, or cut branches and small trees."),
        mass_milligrams = 3000000,
        price_cents = 2500,
        price_postapoc_cents = 1000,
        color = "yellow",
        looks_like = "brush_axe",
        copy_from = "brush_pole",
    }
    item:material("wood", 1)
    item:material("bronze", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:melee_damage("cut", 22)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "trimmer_on",
        copy_from = "trimmer_off",
        looks_like = "trimmer_off",
        name = ccb.content.plural_text("hedge trimmer (on)", "hedge trimmers (on)"),
        description = ccb.content.text("A cordless, double-sided, gasoline-powered hedge trimmer.  It is currently on, ready to do some zombie topiary; use this item to turn it off."),
        replace_qualities = true,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "trimmer_off" },
        message = ccb.content.text("Your %s goes quiet."),
        menu_text = ccb.content.text("Turn off"),
    }
    item:quality("CUT", 1)
    item:quality("BUTCHER", -60)
    item:clear_flags()
    item:flag("MESSY")
    item:flag("TRADER_AVOID")
    item:flag("NONCONDUCTIVE")
    item:flag("SPAWN_ACTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 8)
    item:transform_into { target = "trimmer_off" }
    item:tool { charges_per_use = 0, power_milliwatts = 500000 }
    item:clear_tick_actions()
    item:on_tick("tick_trimmer_on")
    content.add(item)
end

do
    local item = content.Item {
        id = "trimmer_off",
        name = ccb.content.plural_text("hedge trimmer (off)", "hedge trimmers (off)"),
        description = ccb.content.text("A cordless, double-sided, gasoline-powered hedge trimmer.  A long line of sharp-edged teeth extends from the engine; turning the trimmer on will make them rapidly vibrate.  The poor man's chainsaw as far as the zombies are concerned."),
        mass_milligrams = 4500000,
        volume_ml = 2500,
        longest_side_mm = 1000,
        price_cents = 4000,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = "/",
        color = "green",
        replace_pockets = true,
    }
    item:material("ch_steel", 1)
    item:material("plastic", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 5)
    item:tool { charges_per_use = 5, ammo_types = { "gasoline" } }
    item:magazine_pocket { ammo_capacities = { gasoline = 600 }, rigid = true, watertight = true }
    item:clear_use_actions()
    item:on_use("start_trimmer_off", ccb.content.text("Turn on"), nil, { id = "activate_power" })
    content.add(item)
end
