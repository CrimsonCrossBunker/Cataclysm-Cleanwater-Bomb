local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "magical_throwing_knife",
        copy_from = "throwing_knife",
        looks_like = "throwing_knife",
        price_cents = 0,
        price_postapoc_cents = 0,
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife made for throwing.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:material("concentrated_mana", 1)
    item:throwing_damage { { type = "stab", amount = 20, armor_penetration = 5 } }
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_fire",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife made for throwing, wrapped in ethereal flames.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "heat", amount = 15 }, { type = "stab", amount = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_cold",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife made for throwing, emanating frigid cold.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "cold", amount = 15 }, { type = "stab", amount = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_cut",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife with wide edge made for throwing, seems unnaturally sharp.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "cut", amount = 15, armor_multiplier = 0.2 }, { type = "stab", amount = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_biological",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A thin and flat knife made for throwing, made of porous substance and covered in dark ooze.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "biological", amount = 15 }, { type = "stab", amount = 5 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "magical_throwing_knife_pure_special",
        copy_from = "magical_throwing_knife",
        looks_like = "magical_throwing_knife",
        name = ccb.content.plural_text("magical throwing knife", "magical throwing knives"),
        description = ccb.content.text("A transparent blade that seems to radiate intent to be thrown.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    }
    item:throwing_damage { { type = "pure", amount = 40 } }
    content.add(item)
end

do
    local item = content.Item {
        id = "item_kelvinist_icy_freezing_container",
        category = "container",
        name = ccb.content.plural_text("freezer field", "freezer fields"),
        looks_like = "art_sphere",
        description = ccb.content.text("A large, hollow sphere of ice.  Food placed inside will not rot."),
        mass_milligrams = 3000000,
        volume_ml = 92000,
        longest_side_mm = 550,
        price_cents = 0,
        price_postapoc_cents = 0,
        melee_to_hit = -1,
        symbol = "o",
        color = "white",
        replace_pockets = true,
        replace_qualities = true,
        phase = "solid",
    }
    item:material("water", 1)
    item:container_pocket {
        max_volume_ml = 70000,
        max_weight_milligrams = 70000000,
        rigid = true,
        watertight = true,
        spoil_multiplier = 0.0,
    }
    item:clear_flags()
    item:flag("UNBREAKABLE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("TRADER_AVOID")
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "druid_dust",
        name = ccb.content.plural_text("faintly glowing dust", "faintly glowing dust"),
        description = ccb.content.text("This handful of fine dust glows with a growing intensity."),
        mass_milligrams = 1000,
        volume_ml = 30,
        price_cents = 0,
        symbol = "!",
        color = "white",
    }
    item:clear_use_actions()
    item:native_use("WATER_PURIFIER")
    item:tool { initial_charges = 15, max_charges = 15 }
    content.add(item)
end

do
    local item = content.Item {
        id = "technomancer_welder",
        name = ccb.content.plural_text("voltaic touch", "voltaic touch"),
        description = ccb.content.text("Your hands can spark with electricity powerful enough to heat metal to searing temperatures and weld it together.  You can also zap the undead with it."),
        mass_milligrams = 0,
        volume_ml = 0,
        price_cents = 1,
        price_postapoc_cents = 1,
        symbol = "$",
        color = "red",
        max_worn = 1,
        replace_qualities = true,
        melee_to_hit = 0,
    }
    item:material("concentrated_mana", 1)
    item:clear_flags()
    item:flag("UNBREAKABLE")
    item:flag("ZERO_WEIGHT")
    item:flag("ALLOWS_NATURAL_ATTACKS")
    item:flag("INTEGRATED")
    item:flag("PADDED")
    item:flag("PERSONAL")
    item:flag("SEMITANGIBLE")
    item:flag("NO_DROP")
    item:quality("WELD", 2)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("electric", 6)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "druid_seed",
        name = ccb.content.plural_text("seed of purification", "seeds of purification"),
        mass_milligrams = 1000,
        color = "white",
        symbol = "!",
        description = ccb.content.text("A magical seed that can be squeezed to release purifying dust, which can then be used to purify up to a gallon of water."),
        volume_ml = 250,
    }
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "druid_dust", charges = 15 },
        message = ccb.content.text("You squeeze the seed in your palm, and it begins to turn to a fine dust."),
        menu_text = ccb.content.text("Squeeze seed"),
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "eshaper_hammer",
        copy_from = "hammer",
        looks_like = "hammer",
        name = ccb.content.plural_text("earthshaper's hammer", "earthshaper's hammers"),
        description = ccb.content.text("Shaped with your own magic, this tool has the same abilities as the common hammer."),
        symbol = ";",
        color = "dark_gray",
    }
    item:material("stone", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "eshaper_pickaxe" },
        need_wielding = true,
        menu_text = ccb.content.text("Transform"),
        message = ccb.content.text("Your hammer transforms into a pickaxe!"),
    }
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "eshaper_pickaxe",
        copy_from = "pickaxe",
        looks_like = "pickaxe",
        name = ccb.content.plural_text("earthshaper's pickaxe", "earthshaper's pickaxes"),
        description = ccb.content.text("Shaped with your own magic, this tool has the same abilities as the common pickaxe."),
        symbol = "/",
        color = "dark_gray",
    }
    item:material("stone", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "eshaper_ax" },
        need_wielding = true,
        menu_text = ccb.content.text("Transform"),
        message = ccb.content.text("Your pickaxe transforms into an ax!"),
    }
    item:native_use("PICKAXE")
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "eshaper_ax",
        copy_from = "ax",
        looks_like = "ax",
        name = ccb.content.plural_text("earthshaper's axe", "earthshaper's axes"),
        description = ccb.content.text("Shaped with your own magic, this tool has the same abilities as the common axe."),
        symbol = "/",
        color = "dark_gray",
    }
    item:material("stone", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "eshaper_knife" },
        need_wielding = true,
        menu_text = ccb.content.text("Transform"),
        message = ccb.content.text("Your ax transforms into a knife!"),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 11)
    item:melee_damage("cut", 7)
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "eshaper_knife",
        copy_from = "knife_hunting",
        looks_like = "knife_hunting",
        category = "weapons",
        name = ccb.content.plural_text("earthshaper's knife", "earthshaper's knives"),
        description = ccb.content.text("Shaped with your own magic, this tool has the same abilities as the common knife."),
        symbol = "/",
        color = "dark_gray",
        repair_materials = {},
    }
    item:material("stone", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "eshaper_shovel" },
        need_wielding = true,
        menu_text = ccb.content.text("Transform"),
        message = ccb.content.text("Your knife transforms into a shovel!"),
    }
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "eshaper_shovel",
        copy_from = "shovel",
        looks_like = "shovel",
        name = ccb.content.plural_text("earthshaper's shovel", "earthshaper's shovels"),
        description = ccb.content.text("Shaped with your own magic, this tool has the same abilities as the common shovel."),
        symbol = "/",
        color = "dark_gray",
    }
    item:material("stone", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "eshaper_hammer" },
        need_wielding = true,
        menu_text = ccb.content.text("Transform"),
        message = ccb.content.text("Your shovel transforms into a hammer!"),
    }
    item:flag("TRADER_AVOID")
    item:flag("NO_REPAIR")
    item:flag("NO_SALVAGE")
    item:flag("MAGIC_FOCUS")
    item:tool()
    content.add(item)
end

do
    -- NO_I18N
    -- NO_I18N
    local item = content.Item {
        id = "item_druid_disinfectant",
        name = content.plural_text("druid antiseptic", "druid antiseptic"),
        description = content.text("A magical disinfectant.  You should never actually see this."),
        mass_milligrams = 0,
        volume_ml = 0,
        symbol = "~",
        color = "green",
        max_worn = 1,
        phase = "solid",
    }
    item:clear_flags()
    item:flag("NO_INGEST")
    item:flag("EDIBLE_FROZEN")
    item:flag("ZERO_WEIGHT")
    item:flag("TRADER_AVOID")
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:heal { disinfectant_power = 3, bite = 0.9, move_cost = 1 }
    content.add(item)
end

do
    local item = content.Item {
        id = "technomancer_summoned_radio",
        name = ccb.content.plural_text("aetherspeaker (speaking)", "aetherspeakers (speaking)"),
        description = ccb.content.text("A magically-summoned aetherspeaker, capable of communicating long-distance with other aetherspeakers or conventional radios.  With a command word, it may instead scan for radio signals."),
        mass_milligrams = 295000,
        volume_ml = 125,
        melee_to_hit = -1,
        symbol = ";",
        color = "cyan",
        max_worn = 1,
    }
    item:material("concentrated_mana", 1)
    item:clear_flags()
    item:flag("TWO_WAY_RADIO")
    item:flag("TRADER_AVOID")
    item:flag("NO_DROP")
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "technomancer_summoned_radio_on" },
        menu_text = ccb.content.text("Turn to scanning mode"),
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "technomancer_summoned_radio_on",
        copy_from = "technomancer_summoned_radio",
        looks_like = "technomancer_summoned_radio",
        name = ccb.content.plural_text("aetherspeaker (scanning)", "aetherspeakers (scanning)"),
        description = ccb.content.text("An aetherspeaker tuned to listen for radio signals from the surrounding area.  With a command word, it may change frequency or switch to communicating with other aetherspeakers or radios."),
        max_worn = 1,
    }
    item:clear_use_actions()
    item:native_use("RADIO_ON")
    item:transform_on_use {
        result = { target = "technomancer_summoned_radio" },
        menu_text = ccb.content.text("Turn to speaking mode"),
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("NO_DROP")
    item:tool()
    item:clear_tick_actions()
    item:native_on_tick("RADIO_TICK")
    content.add(item)
end
