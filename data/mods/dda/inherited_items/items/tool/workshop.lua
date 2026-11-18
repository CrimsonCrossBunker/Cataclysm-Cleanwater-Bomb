local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "elec_jackhammer_mining",
        copy_from = "elec_jackhammer",
        looks_like = "elec_jackhammer",
        name = ccb.content.plural_text("electric mining jackhammer", "electric mining jackhammers"),
        description = ccb.content.text("A construction or mining tool for drilling through hard rock or other surfaces.  This model has a cord compatible with a UPS."),
    }
    item:clear_flags()
    item:flag("DIG_TOOL")
    item:flag("ELECTRONIC")
    item:flag("MULTI_DRILL")
    item:flag("NO_RELOAD")
    item:flag("NO_UNLOAD")
    item:flag("POWERED")
    item:flag("USE_UPS")
    item:flag("WATER_BREAK")
    item:adjust_measurements { volume_ml = { factor = 0.4 }, mass_milligrams = { factor = 0.6 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "jackhammer_mining",
        copy_from = "jackhammer",
        looks_like = "jackhammer",
        name = ccb.content.plural_text("mining jackhammer", "mining jackhammers"),
        description = ccb.content.text("A construction or mining tool for drilling through hard rock or other surfaces.  This model runs on gasoline."),
    }
    item:clear_flags()
    item:flag("DIG_TOOL")
    item:flag("MULTI_DRILL")
    item:flag("POWERED")
    item:adjust_measurements { volume_ml = { factor = 0.4 }, mass_milligrams = { factor = 0.6 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "adobe_pallet_full_active",
        name = ccb.content.plural_text("pallet of wet adobe bricks", "pallets of wet adobe bricks"),
        description = ccb.content.text("A pallet full of heavy mud bricks which need to dry slowly to be usable, so it will transform after a week."),
        mass_milligrams = 220000000,
        volume_ml = 220000,
        longest_side_mm = 1800,
        price_cents = 100,
        price_postapoc_cents = 0,
        symbol = "#",
        color = "brown",
        looks_like = "frame_wood_light",
        countdown_turns = 604800,
    }
    item:material("soil", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("ALLOWS_REMOTE_USE")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "adobe_pallet_done" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "adobe_pallet_done",
        category = "tools",
        name = ccb.content.plural_text("pallet of dry adobe bricks", "pallets of dry adobe bricks"),
        description = ccb.content.text("A pallet of humble mud bricks that have dried for a week while you were out risking your life.  Disassemble it to retrieve your frame and building supplies."),
        mass_milligrams = 220000000,
        volume_ml = 220000,
        longest_side_mm = 1800,
        price_cents = 40000,
        price_postapoc_cents = 250,
        symbol = "#",
        color = "brown_yellow",
        looks_like = "frame_wood_light",
    }
    item:material("ceramic", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "acetylene_machine",
        name = ccb.content.plural_text("acetylene-gas machine", "acetylene-gas machines"),
        symbol = "&",
        color = "light_gray",
        description = ccb.content.text("A bulky device that turns water and calcium carbide into unpressurized acetylene."),
        mass_milligrams = 8000000,
        volume_ml = 3000,
        price_cents = 3200,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "chipper",
        name = ccb.content.plural_text("paint chipper", "paint chippers"),
        description = ccb.content.text("A tool similar to a chisel, designed to remove paint."),
        mass_milligrams = 60000,
        volume_ml = 300,
        longest_side_mm = 50,
        price_cents = 7000,
        price_postapoc_cents = 15,
        melee_to_hit = -2,
        symbol = ";",
        color = "brown",
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "clamp",
        name = ccb.content.plural_text("clamp", "clamps"),
        description = ccb.content.text("A metal clamp, useful for holding things in place, especially if you have several of them."),
        mass_milligrams = 320000,
        volume_ml = 300,
        price_cents = 500,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:quality("VISE", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    -- With the assumption that it's a cylinder of 9.2in length and 2in diameter. Listing says 10in length but that's a lie - comparison images attached show it's 9.2in length. 2 inches diameter due to larger curvature than a normal crowbar.
    -- Based on https://www.amazon.com/dp/B000A24RCA
    local item = content.Item {
        id = "claw_bar",
        name = ccb.content.plural_text("claw bar", "claw bars"),
        description = ccb.content.text("A small prying tool with a clawed bend at one end for pulling spikes.  Use it to open locked doors without destroying them or to lift manhole covers.  You could also wield it to bash some heads in."),
        mass_milligrams = 318000,
        volume_ml = 470,
        longest_side_mm = 240,
        price_cents = 1900,
        price_postapoc_cents = 250,
        melee_to_hit = -1,
        symbol = ";",
        color = "dark_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("PRY", 2)
    item:quality("HAMMER", 1)
    item:quality("PRYING_NAIL", 1)
    item:clear_use_actions()
    item:native_use("CROWBAR")
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 13)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hacksaw",
        name = ccb.content.plural_text("hacksaw", "hacksaws"),
        description = ccb.content.text("A sturdy saw, useful for cutting through metal objects."),
        mass_milligrams = 952000,
        volume_ml = 1000,
        longest_side_mm = 300,
        price_cents = 2500,
        price_postapoc_cents = 100,
        melee_to_hit = -1,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("SAW_M", 2)
    item:quality("SAW_W", 1)
    item:quality("SAW_M_FINE", 1)
    item:quality("BUTCHER", -90)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("cut", 2)
    item:tool()
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B00009OYFY
    local item = content.Item {
        id = "tin_snips",
        name = ccb.content.plural_text("tin snips", "tin snips"),
        description = ccb.content.text("A pair of tin snips, resembling a sturdy pair of scissors with beefy blades designed to cut through thin sheets of soft metal.  These cannot cut through thick metals like a hacksaw can, but are better suited to precision work and leave a cleaner edge."),
        mass_milligrams = 400000,
        volume_ml = 500,
        longest_side_mm = 250,
        price_cents = 1600,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 17)
    item:material("plastic", 3)
    item:quality("SAW_M", 1)
    item:quality("SAW_M_FINE", 2)
    item:clear_use_actions()
    item:native_use("BOLTCUTTERS")
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "nail_puller_bronze",
        name = ccb.content.plural_text("bronze nail puller", "bronze nail pullers"),
        description = ccb.content.text("A crude nail puller made of bronze.  Not really as good as its steel alternative but it gets job of pulling out nails good enough."),
        symbol = "N",
        mass_milligrams = 650000,
        volume_ml = 340,
        longest_side_mm = 250,
        price_cents = 100,
        price_postapoc_cents = 50,
        replace_qualities = true,
        melee_to_hit = -1,
    }
    item:material("bronze", 1)
    item:quality("PRYING_NAIL", 1)
    item:quality("HAMMER", 1)
    item:quality("PRY", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "saw_bronze",
        name = ccb.content.plural_text("bronze wood saw", "bronze wood saws"),
        description = ccb.content.text("A simple wood saw made of bronze.  Not as great as its steel equivalent, but it's good enough."),
        symbol = "W",
        mass_milligrams = 450000,
        volume_ml = 1000,
        longest_side_mm = 500,
        price_cents = 100,
        price_postapoc_cents = 50,
        replace_qualities = true,
        melee_to_hit = -1,
    }
    item:material("bronze", 1)
    item:quality("AXE", 1)
    item:quality("SAW_W", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("cut", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hand_drill",
        name = ccb.content.plural_text("hand drill", "hand drills"),
        description = ccb.content.text("A primitive manual drill with a single drill bit.  It is slow to use, and will exhaust you quickly."),
        mass_milligrams = 907000,
        volume_ml = 250,
        longest_side_mm = 250,
        price_cents = 500,
        price_postapoc_cents = 100,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:quality("DRILL", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "hose",
        name = ccb.content.plural_text("rubber hose", "rubber hoses"),
        description = ccb.content.text("A flexible rubber hose.  It could be used for crafting or siphoning fuel from a vehicle."),
        mass_milligrams = 544000,
        volume_ml = 500,
        longest_side_mm = 240,
        price_cents = 200,
        price_postapoc_cents = 100,
        symbol = ",",
        color = "green",
        replace_qualities = true,
    }
    item:material("rubber", 1)
    item:quality("HOSE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "jack",
        name = ccb.content.plural_text("bottle jack", "bottle jacks"),
        description = ccb.content.text("A portable hydraulic bottle jack used for lifting vehicles."),
        symbol = ";",
        color = "light_gray",
        mass_milligrams = 5000000,
        volume_ml = 1500,
        longest_side_mm = 250,
        price_cents = 18000,
        price_postapoc_cents = 500,
        replace_qualities = true,
        melee_to_hit = -5,
    }
    item:material("steel", 1)
    item:quality("JACK", 16)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "jack_makeshift",
        name = ccb.content.plural_text("makeshift jack", "makeshift jacks"),
        description = ccb.content.text("A poorly-constructed improvised scissor jack used for lifting vehicles if you're brave enough to use it."),
        symbol = ";",
        color = "light_gray",
        mass_milligrams = 1800000,
        volume_ml = 1000,
        longest_side_mm = 180,
        price_cents = 800,
        price_postapoc_cents = 100,
        replace_qualities = true,
        melee_to_hit = -5,
    }
    item:material("steel", 1)
    item:quality("JACK", 3)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "jack_small",
        name = ccb.content.plural_text("scissor jack", "scissor jacks"),
        description = ccb.content.text("A compact scissor jack used for lifting vehicles."),
        symbol = ";",
        color = "light_gray",
        mass_milligrams = 3000000,
        volume_ml = 750,
        longest_side_mm = 140,
        price_cents = 5000,
        price_postapoc_cents = 750,
        replace_qualities = true,
        melee_to_hit = -5,
    }
    item:material("steel", 1)
    item:quality("JACK", 4)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_hammer",
        name = ccb.content.plural_text("makeshift hammer", "makeshift hammers"),
        description = ccb.content.text("A crude hammer made from a piece of metal affixed to a stick.  It functions adequately, but really can't compare to a proper hammer."),
        mass_milligrams = 1020000,
        volume_ml = 320,
        longest_side_mm = 300,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -1,
        symbol = ";",
        color = "brown",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("wood", 1)
    item:quality("HAMMER", 2)
    item:clear_flags()
    item:flag("NONCONDUCTIVE")
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 9)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_file",
        name = ccb.content.plural_text("bronze fileset", "bronze filesets"),
        copy_from = "metal_file",
        looks_like = "metal_file",
    }
    item:material("bronze", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "metal_file",
        name = ccb.content.plural_text("metal fileset", "metal filesets"),
        description = ccb.content.text("A set of tools commonly used to remove small amounts of material from the surface of metal objects."),
        mass_milligrams = 76000,
        volume_ml = 250,
        longest_side_mm = 130,
        price_cents = 300,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("FILE", 2)
    item:quality("GRIND", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "metal_smoother",
        name = ccb.content.plural_text("metallic smoother", "metallic smoothers"),
        description = ccb.content.text("A tool that is most often used to smooth concrete or mortar in construction projects."),
        mass_milligrams = 362000,
        volume_ml = 400,
        longest_side_mm = 150,
        price_cents = 1000,
        price_postapoc_cents = 50,
        symbol = ",",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -2,
    }
    item:material("iron", 1)
    item:quality("SMOOTH", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    -- The multitool is a bit more of a toolkit than a knife.
    local item = content.Item {
        id = "multitool",
        name = ccb.content.plural_text("multitool", "multitools"),
        description = ccb.content.text("A cleverly designed all-in-one tool which combines several smaller tools into the handles of a pair of pliers."),
        mass_milligrams = 250000,
        volume_ml = 70,
        longest_side_mm = 120,
        price_cents = 3000,
        price_postapoc_cents = 300,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:quality("CUT", 2)
    item:quality("SAW_W", 1)
    item:quality("SAW_M", 1)
    item:quality("WRENCH", 1)
    item:quality("SCREW", 1)
    item:quality("BUTCHER", 7)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "paint_brush",
        name = ccb.content.plural_text("paint brush", "paint brushes"),
        description = ccb.content.text("A wide brush, suitable for painting walls."),
        mass_milligrams = 60000,
        volume_ml = 350,
        longest_side_mm = 210,
        price_cents = 7000,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "brown",
    }
    item:material("wood", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "bronze_pickaxe",
        name = ccb.content.plural_text("bronze pickaxe", "bronze pickaxes"),
        description = ccb.content.text("A heavy-headed cast and worked tool with a pointed wedge on one side for breaking stone and a flat wedge on the other for prying it out.  You could mine with this."),
        mass_milligrams = 6000000,
        volume_ml = 3000,
        longest_side_mm = 910,
        price_cents = 16000,
        price_postapoc_cents = 1250,
        melee_to_hit = -3,
        symbol = "/",
        color = "yellow",
        techniques = { "WBLOCK_1" },
        weapon_categories = { "HOOKING_WEAPONRY" },
    }
    item:material("wood", 1)
    item:material("bronze", 1)
    item:clear_use_actions()
    item:native_use("PICKAXE")
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("DIG_TOOL")
    item:flag("SHEATH_AXE")
    item:clear_melee_damage()
    item:melee_damage("bash", 30)
    item:melee_damage("stab", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pin_reamer",
        name = ccb.content.plural_text("pin reamer", "pin reamers"),
        description = ccb.content.text("Handheld pin reamers of this kind are used to enlarge existing holes, or remove any burs and such from them."),
        mass_milligrams = 76000,
        volume_ml = 20,
        longest_side_mm = 130,
        price_cents = 300,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -3,
    }
    item:material("steel", 1)
    item:quality("REAM", 2)
    item:clear_melee_damage()
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pliers",
        name = ccb.content.plural_text("pliers", "pliers"),
        description = ccb.content.text("A basic pair of slip-joint pliers, able to handle basic mechanical work.  Anything more complex will require a wrench."),
        ascii_picture = "pliers",
        mass_milligrams = 225000,
        volume_ml = 107,
        longest_side_mm = 170,
        price_cents = 800,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -1,
    }
    item:material("steel", 1)
    item:quality("WRENCH", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "big_pliers",
        name = ccb.content.plural_text("tongue-and-groove pliers", "tongue-and-groove pliers"),
        description = ccb.content.text("A large pair of slip-joint pliers bent at the elbow, able to handle basic mechanical work.  Anything more complex will require a wrench."),
        ascii_picture = "pliers",
        mass_milligrams = 800000,
        volume_ml = 280,
        longest_side_mm = 300,
        price_cents = 800,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -1,
    }
    item:material("steel", 1)
    item:quality("WRENCH", 2)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pliers_locking",
        name = ccb.content.plural_text("locking pliers", "locking pliers"),
        description = ccb.content.text("A pair of pliers with extra-hefty jaws and an adjustable mechanism to clamp them in a locked grip on whatever unfortunate object is trapped between them.  They could grip and turn a fairly large bolt head, or clamp two parts together temporarily."),
        looks_like = "pliers",
        mass_milligrams = 320000,
        volume_ml = 222,
        longest_side_mm = 180,
        price_cents = 1200,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -1,
    }
    item:material("steel", 1)
    item:quality("WRENCH", 2)
    item:quality("VISE", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "primitive_hammer",
        name = ccb.content.plural_text("stone hammer", "stone hammers"),
        description = ccb.content.text("A rock affixed to a stick in the crude facsimile of a hammer.  It functions adequately, but really can't compare to a proper hammer, and can't pull out nails either."),
        mass_milligrams = 1020000,
        volume_ml = 400,
        longest_side_mm = 300,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -1,
        symbol = ";",
        color = "brown",
        replace_qualities = true,
    }
    item:material("stone", 1)
    item:material("wood", 1)
    item:quality("HAMMER", 2)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "robofac_gun_kit",
        name = ccb.content.plural_text("Hub 01 HWP maintenance kit", "Hub 01 HWP maintenance kits"),
        description = ccb.content.text("A heavy-duty bag marked with the Hub 01 logo.  It contains space for barrels, adapters, and proprietary tools.  Embossed on the inside is a sketch of the Hybrid Weapons Platform."),
        mass_milligrams = 500000,
        volume_ml = 250,
        longest_side_mm = 600,
        price_cents = 1500,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        replace_pockets = true,
    }
    item:material("nylon", 1)
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("WRENCH_FINE", 1)
    item:quality("WRENCH", 2)
    item:quality("SCREW_FINE", 1)
    item:quality("SCREW", 1)
    item:container_pocket {
        max_volume_ml = 1500,
        max_weight_milligrams = 3000000,
        rigid = false,
        max_item_length_mm = 600,
        allowed_items = {
            "robofac_gun_ar",
            "robofac_gun_smg",
            "robofac_gun_57",
            "robofac_gun_dmr",
            "robofac_gun_shotgun",
            "robofac_gun_shotgun_breach",
            "robofac_gun_exodii",
        },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "screwdriver",
        name = ccb.content.plural_text("screwdriver", "screwdrivers"),
        description = ccb.content.text("A Philips-head screwdriver.  It is important for almost all electronics crafting, most mechanics crafting, and has many more uses."),
        ascii_picture = "screwdriver",
        mass_milligrams = 170000,
        volume_ml = 40,
        longest_side_mm = 120,
        price_cents = 450,
        price_postapoc_cents = 50,
        melee_to_hit = -3,
        symbol = ";",
        color = "yellow",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("SCREW", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "screwdriver_set",
        name = ccb.content.plural_text("screwdriver set", "screwdriver sets"),
        description = ccb.content.text("A set of screwdrivers in several sizes and blade types.  Guaranteed to have the right tools for more precise work."),
        ascii_picture = "screwdriver_set",
        mass_milligrams = 340000,
        volume_ml = 500,
        longest_side_mm = 280,
        price_cents = 2000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ";",
        color = "yellow",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("SCREW", 1)
    item:quality("SCREW_FINE", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "socket_screwdriver_set",
        name = ccb.content.plural_text("socket screwdriver set", "socket screwdriver sets"),
        description = ccb.content.text("A ratcheting screwdriver with a collection of hex sockets for turning small bolts or nuts, including a couple standard screwdriver bits."),
        looks_like = "screwdriver_set",
        mass_milligrams = 340000,
        volume_ml = 500,
        longest_side_mm = 280,
        price_cents = 2000,
        price_postapoc_cents = 250,
        melee_to_hit = -3,
        symbol = ";",
        color = "yellow",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("SCREW", 1)
    item:quality("WRENCH", 1)
    item:quality("WRENCH_FINE", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:melee_damage("stab", 6)
    item:tool()
    content.add(item)
end

do
    -- Modeled after 40-piece Walmart set, 2.85 lb, case 9.75 x 1.5 x 5 inches
    local item = content.Item {
        id = "socket_wrench_set",
        name = ccb.content.plural_text("socket wrench set", "socket wrench sets"),
        description = ccb.content.text("A thick-handled ratchet wrench with an assortment of interchangeable sockets in common hex bolt sizes.  You could loosen or tighten fairly large bolts with this, and the ratchet makes a satisfying clicking sound."),
        looks_like = "screwdriver_set",
        mass_milligrams = 1300000,
        volume_ml = 1200,
        longest_side_mm = 250,
        price_cents = 2000,
        price_postapoc_cents = 250,
        melee_to_hit = -1,
        symbol = ";",
        color = "yellow",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("WRENCH", 2)
    item:quality("WRENCH_FINE", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:flag("NO_SALVAGE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    -- Based on https://www.amazon.com/dp/B06XPWS3HJ
    local item = content.Item {
        id = "lug_wrench",
        name = ccb.content.plural_text("lug wrench", "lug wrenches"),
        description = ccb.content.text("A steel rod bent 90 degrees with a socket on the shorter end, made to hold the lug nuts of a car's wheels to either fasten or loosen for convenient removal and replacement.  Makes for a decent melee weapon in a pinch."),
        mass_milligrams = 1565000,
        longest_side_mm = 460,
        volume_ml = 460,
        price_cents = 2300,
        price_postapoc_cents = 300,
        melee_to_hit = -2,
        symbol = "L",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("steel", 1)
    item:quality("WHEEL_FAST", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 11)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "wood_smoother",
        name = ccb.content.plural_text("wooden smoother", "wooden smoothers"),
        description = ccb.content.text("A large makeshift tool used in smoothing concrete or mortar in construction projects.  You could also use it as an improvised head-basher."),
        mass_milligrams = 2000000,
        volume_ml = 3500,
        longest_side_mm = 610,
        price_cents = 2000,
        price_postapoc_cents = 50,
        melee_to_hit = 0,
        symbol = "/",
        color = "brown",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("SMOOTH", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "xacto",
        name = ccb.content.plural_text("X-Acto knife", "X-Acto knives"),
        description = ccb.content.text("A small, sharp knife, designed for making precise cuts for textiles or crafts.  It could cause decent damage, but is difficult to land a solid hit with.  Its small, sharp blade allows for precision strikes in the hands of the skilled."),
        mass_milligrams = 23000,
        volume_ml = 20,
        longest_side_mm = 100,
        price_cents = 400,
        price_postapoc_cents = 100,
        melee_to_hit = -3,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("steel", 1)
    item:material("plastic", 1)
    item:quality("CUT", 2)
    item:quality("CUT_FINE", 2)
    item:quality("BUTCHER", 7)
    item:quality("FABRIC_CUT", 1)
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("cut", 6)
    item:tool()
    content.add(item)
end

do
    -- Measured weight of 6-inch Craftsman wrench with 150mm jaws, assume 8g/ml steel density plus some margin for mechanism and empty space.
    local item = content.Item {
        id = "wrench_small",
        name = ccb.content.plural_text("small adjustable wrench", "small adjustable wrenches"),
        description = ccb.content.text("A compact adjustable crescent wrench, with a short handle that fits in the palm of your hand.  It could be used for turning small hex-head nuts or bolts."),
        looks_like = "wrench",
        mass_milligrams = 110000,
        volume_ml = 20,
        longest_side_mm = 150,
        price_cents = 500,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = -1,
    }
    item:material("steel", 1)
    item:quality("WRENCH", 1)
    item:quality("WRENCH_FINE", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    -- Based on: https://www.amazon.com/Crescent-AC210VS-Tools-Wrenches-Adjustable/dp/B00002N5L1/ref=sr_1_5?crid=2979KVN9DXDUH&keywords=10+inch+crescent+wrench+adjustable&qid=1680859779&sprefix=10+inch+crescent+wrench+adjustable%2Caps%2C555&sr=8-5
    local item = content.Item {
        id = "wrench",
        name = ccb.content.plural_text("adjustable wrench", "adjustable wrenches"),
        description = ccb.content.text("An adjustable crescent wrench.  It is used in many mechanics crafting recipes."),
        mass_milligrams = 417000,
        volume_ml = 75,
        longest_side_mm = 250,
        price_cents = 1800,
        price_postapoc_cents = 100,
        melee_to_hit = -1,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        weapon_categories = { "BATONS" },
    }
    item:material("steel", 1)
    item:quality("WRENCH", 2)
    item:quality("WRENCH_FINE", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 7)
    item:tool()
    content.add(item)
end

do
    -- WESTWARD 31D018 from Walmart, 18-inch length, 2-3/8-inch jaws, 4.23 lb, assume 8g/ml steel density with some margin for mechanism and other empty space.
    local item = content.Item {
        id = "wrench_large",
        name = ccb.content.plural_text("large adjustable wrench", "large adjustable wrenches"),
        description = ccb.content.text("An unusually large adjustable crescent wrench, with a long handle and jaws that widen over two inches.  This could easily turn most bolts, and should even work on wheel lug nuts."),
        looks_like = "wrench",
        mass_milligrams = 1900000,
        volume_ml = 250,
        longest_side_mm = 460,
        price_cents = 1200,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
        melee_to_hit = 0,
    }
    item:material("steel", 1)
    item:quality("WRENCH", 2)
    item:quality("WHEEL_FAST", 1)
    item:clear_flags()
    item:flag("BELT_CLIP")
    item:clear_melee_damage()
    item:melee_damage("bash", 12)
    item:tool()
    content.add(item)
end

do
    -- Based on 48in 'Rigid' brand pipe wrench, assumed 7.2/ml iron density with some margin for mechanism and other empty space.
    local item = content.Item {
        id = "wrench_48",
        name = ccb.content.plural_text("heavy-duty pipe wrench", "heavy-duty pipe wrenches"),
        description = ccb.content.text("A 48in pipe wrench, normally used in oil fields and in the maintenance of public utilities.  It's much larger and heavier than you have any practical use for."),
        looks_like = "wrench",
        melee_to_hit = 1,
        weapon_categories = { "GREAT_HAMMERS" },
        techniques = { "WBLOCK_1", "BRUTAL" },
        mass_milligrams = 14000000,
        volume_ml = 1945,
        longest_side_mm = 1200,
        price_cents = 50700,
        price_postapoc_cents = 200,
        symbol = ";",
        color = "light_gray",
    }
    item:clear_flags()
    item:flag("DURABLE_MELEE")
    item:flag("ALWAYS_TWOHAND")
    item:material("iron", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 50)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_hose",
        name = ccb.content.plural_text("leather hose", "leather hoses"),
        description = ccb.content.text("A hose made of leather.  Watertight and flexible, it can be used to siphon fuel from a vehicle tank.  However, it's not as elastic as a rubber hose."),
        mass_milligrams = 600000,
        volume_ml = 500,
        longest_side_mm = 240,
        price_cents = 100,
        price_postapoc_cents = 50,
        symbol = ",",
        color = "green",
        replace_qualities = true,
    }
    item:material("leather", 1)
    item:quality("HOSE", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_hand_drill",
        name = ccb.content.plural_text("makeshift hand drill", "makeshift hand drills"),
        description = ccb.content.text("A makeshift manual drill made with a pipe and an improvised drill bit.  Using it is very slow, and will exhaust you quickly."),
        mass_milligrams = 1354000,
        volume_ml = 1000,
        longest_side_mm = 420,
        price_cents = 100,
        price_postapoc_cents = 50,
        melee_to_hit = -4,
        symbol = ";",
        color = "light_gray",
        looks_like = "hand_drill",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:material("steel", 1)
    item:quality("DRILL", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:melee_damage("cut", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "block_and_tackle",
        category = "spare_parts",
        name = ccb.content.plural_text("block and tackle", "blocks and tackles"),
        description = ccb.content.text("A sturdy metal housing with a number of pulleys that can be used with a thick rope or a chain to gain mechanical advantage on a lift."),
        mass_milligrams = 500000,
        volume_ml = 400,
        price_cents = 500,
        price_postapoc_cents = 50,
        symbol = "&",
        color = "light_gray",
        melee_to_hit = -2,
    }
    item:material("steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 3)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "block_and_tackle_wood",
        category = "spare_parts",
        name = ccb.content.plural_text("wooden block and tackle", "wooden blocks and tackles"),
        description = ccb.content.text("A wooden housing with a pair of pulleys that can be used with a thick rope or a chain to gain mechanical advantage on a lift.  Not as durable as a metal set."),
        mass_milligrams = 230000,
        volume_ml = 400,
        price_cents = 500,
        price_postapoc_cents = 50,
        symbol = "&",
        color = "brown",
    }
    item:material("wood", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "welding_blanket",
        name = ccb.content.plural_text("welding blanket", "welding blankets"),
        description = ccb.content.text("A non-flammable mat used to protect surfaces from welding splatter, or to insulate a weld when repairing tempered metal.  This one is made with asbestos."),
        mass_milligrams = 6000000,
        volume_ml = 11500,
        price_cents = 30000,
        price_postapoc_cents = 500,
        symbol = "#",
        color = "light_gray",
    }
    item:material("asbestos", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_welding_blanket",
        name = ccb.content.plural_text("makeshift welding blanket", "makeshift welding blankets"),
        description = ccb.content.text("A makeshift mostly-non-flammable mat used to protect surfaces from welding splatter or to insulate a weld when repairing tempered metal.  This one is stitched together from oven insulation batts."),
        mass_milligrams = 3000000,
        volume_ml = 11500,
        price_cents = 3000,
        price_postapoc_cents = 200,
        symbol = "#",
        color = "light_gray",
    }
    item:material("epoxy", 1)
    item:material("kevlar", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "thread_cutting_set",
        name = ccb.content.plural_text("thread cutting set", "thread cutting sets"),
        description = ccb.content.text("This is a set of a external thread cutting die inserted into a manual grip and an internal thread cutting die used as a drill bit."),
        mass_milligrams = 1500000,
        volume_ml = 750,
        longest_side_mm = 400,
        price_cents = 2000,
        price_postapoc_cents = 250,
        replace_qualities = true,
        symbol = "p",
        color = "light_gray",
    }
    item:material("steel", 1)
    item:quality("THREAD_TAP", 2)
    item:quality("THREAD_CUT", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "fanning_mill",
        name = ccb.content.plural_text("fanning mill", "fanning mills"),
        description = ccb.content.text("A machine for separating seed from chaff.  It mechanized the winnowing process, in which the grain was separated from the lighter chaff and straw by blowing a leather bellows."),
        mass_milligrams = 15000000,
        volume_ml = 75000,
        price_cents = 25000,
        price_postapoc_cents = 1000,
        melee_to_hit = -3,
        symbol = ";",
        color = "brown",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("WINNOW", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    item:tool()
    content.add(item)
end

do
    -- Based on https://www.homedepot.ca/product/wen-3-in-heavy-duty-cast-iron-bench-vise-with-swivel-base/1001661026
    local item = content.Item {
        id = "bench_vise",
        name = ccb.content.plural_text("bench vise", "bench vises"),
        description = ccb.content.text("A heavy, metal vise bolted down to a work surface.  With its jaws and screw, it can tightly hold items, useful for a wide array of handiwork such as soldering, woodworking, welding, anything that can be aided by a firm grip.  Also has a small, flat metal surface, useful for light metalworking if needed."),
        mass_milligrams = 5443000,
        volume_ml = 746,
        price_cents = 5000,
        price_postapoc_cents = 500,
        melee_to_hit = -3,
        longest_side_mm = 427,
        symbol = ";",
        color = "light_gray",
        replace_qualities = true,
    }
    item:material("iron", 1)
    item:quality("VISE", 3)
    item:quality("ANVIL", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 14)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "monkey_tool",
        name = ccb.content.plural_text("monkey tool", "monkey tools"),
        description = ccb.content.text("A small cylindrical chunk of steel with a hole in the middle, made to fit into the hand.  It's used to make rivets by inserting a small rod of steel inside then hammering the end sticking out until it forms the characteristic mushroom shape of the rivet head."),
        longest_side_mm = 120,
        mass_milligrams = 1000000,
        volume_ml = 125,
        price_cents = 2000,
        price_postapoc_cents = 300,
        symbol = "-",
        color = "light_gray",
    }
    item:material("lc_steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "nail_header",
        name = ccb.content.plural_text("nail header", "nail headers"),
        description = ccb.content.text("A square hole punched through the flat end of a metal handle.  Used to form the flat end of a nail by feeding it through the header then hammering the material sticking out of it."),
        longest_side_mm = 200,
        mass_milligrams = 500000,
        volume_ml = 64,
        price_cents = 2000,
        price_postapoc_cents = 300,
        symbol = "i",
        color = "light_gray",
    }
    item:material("mc_steel", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "nail_header_bronze",
        copy_from = "nail_header",
        looks_like = "nail_header",
        name = ccb.content.plural_text("bronze nail header", "bronze nail headers"),
        description = ccb.content.text("A square hole punched through the flat end of a metal handle.  Used to form the flat end of a nail by feeding it through the header then hammering the material sticking out of it.  This one is made of bronze."),
        color = "yellow",
    }
    item:material("bronze", 1)
    item:adjust_measurements { mass_milligrams = { factor = 1.1 } }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "razor_blade_taped",
        copy_from = "razor_blade",
        looks_like = "razor_blade",
        name = ccb.content.plural_text("taped razorblade", "taped razorblades"),
        description = ccb.content.text("A double-edged razor blade with one side taped to allow its use as a basic tool."),
        replace_qualities = true,
    }
    item:quality("CUT", 1)
    item:quality("BUTCHER", 4)
    item:quality("FABRIC_CUT", 1)
    item:tool()
    content.add(item)
end
