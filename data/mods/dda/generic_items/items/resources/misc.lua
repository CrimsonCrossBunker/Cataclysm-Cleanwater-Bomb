local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "bee_sting",
        name = ccb.content.plural_text("bee stinger", "bee stingers"),
        description = ccb.content.text("A six-inch stinger from a giant bee.  Makes a poor melee weapon."),
        mass_milligrams = 540000,
        melee_to_hit = -5,
        color = "white",
        symbol = ",",
        volume_ml = 250,
        weapon_categories = { "SHIVS" },
        price_cents = 3000,
        price_postapoc_cents = 0,
        stackable = true,
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "broom",
        name = ccb.content.plural_text("broom", "brooms"),
        description = ccb.content.text("A long-handled broom.  Makes a terrible weapon unless you're chasing cats."),
        mass_milligrams = 929000,
        longest_side_mm = 1400,
        melee_to_hit = 1,
        color = "yellow",
        symbol = "/",
        techniques = { "WBLOCK_1" },
        weapon_categories = { "QUARTERSTAVES" },
        volume_ml = 1250,
        price_cents = 2400,
        price_postapoc_cents = 0,
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:clear_use_actions()
    item:native_use("MOP")
    content.add(item)
end

do
    local item = content.Item {
        id = "ceramic_shard",
        symbol = "*",
        color = "white",
        name = ccb.content.plural_text("ceramic shard", "ceramic shards"),
        description = ccb.content.text("A broken ceramic shard.  It is relatively heavy for its size and has a somewhat sharp edge, but it's too irregular to cut properly."),
        mass_milligrams = 150000,
        volume_ml = 50,
        longest_side_mm = 80,
        melee_to_hit = -6,
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("ceramic", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("PUNCTURE_VEHICLE_WHEELS")
    item:quality("BUTCHER", -66)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:melee_damage("cut", 2)
    content.add(item)
end

do
    -- The 500 ml volume is for 200 portions, matching the original ammunition count.
    local item = content.Item {
        id = "incendiary",
        stackable = true,
        stack_size = 200,
        category = "chems",
        name = ccb.content.plural_text("incendiary", "incendiary"),
        description = ccb.content.text("Material from an incendiary round, useful in constructing incendiary ammunition."),
        mass_milligrams = 2000,
        volume_ml = 500,
        price_cents = 10000,
        price_postapoc_cents = 100,
        default_container = "bag_plastic",
        symbol = "=",
        color = "dark_gray",
    }
    item:material("powder", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "fuse",
        category = "spare_parts",
        name = ccb.content.plural_text("fuse", "fuse"),
        description = ccb.content.text("A piece of fuse, long enough to give you enough time to get away from most explosions."),
        mass_milligrams = 6000,
        volume_ml = 80,
        price_cents = 500,
        price_postapoc_cents = 500,
        default_container = "bag_plastic",
        symbol = ",",
        color = "dark_gray",
        stackable = true,
    }
    item:material("cotton", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "sharp_rock",
        symbol = "*",
        color = "light_gray",
        name = ccb.content.plural_text("sharp rock", "sharp rocks"),
        description = ccb.content.text("A baseball-sized rock with a somewhat sharp edge that also chips in a semi-predictable way if struck.  With the right skills, you could give it a better edge."),
        mass_milligrams = 500000,
        volume_ml = 250,
        longest_side_mm = 80,
        melee_to_hit = -3,
        replace_qualities = true,
        weapon_categories = { "SHIVS" },
    }
    item:material("stone", 1)
    item:quality("CUT", 1)
    item:quality("BUTCHER", -50)
    item:clear_flags()
    item:flag("ALLOWS_BODY_BLOCK")
    item:flag("SLING_PROJECTILE")
    item:clear_melee_damage()
    item:melee_damage("bash", 5)
    item:melee_damage("cut", 3)
    content.add(item)
end

do
    local item = content.Item {
        id = "sole_rubber",
        category = "spare_parts",
        name = ccb.content.plural_text("rubber sole", "rubber soles"),
        description = ccb.content.text("A sole made from rubber, usually found on the bottoms of boots.  Can be used for making actual boots."),
        mass_milligrams = 140000,
        volume_ml = 500,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("rubber", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "rubber_tire_chunk",
        category = "spare_parts",
        name = ccb.content.plural_text("thick rubber chunk", "thick rubber chunks"),
        description = ccb.content.text("A chunk of thick, semi-rigid rubber, similar to what tires are made from."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        longest_side_mm = 250,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("rubber", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "rubber_tire_strip",
        category = "spare_parts",
        name = ccb.content.plural_text("rubber tire strip", "rubber tire strips"),
        description = ccb.content.text("A long, curled strip of thick, semi-rigid rubber cut from a tire."),
        mass_milligrams = 3000000,
        volume_ml = 5000,
        longest_side_mm = 400,
        price_cents = 500,
        price_postapoc_cents = 50,
        symbol = "=",
        color = "dark_gray",
        stackable = true,
    }
    item:material("rubber", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "ugl_buttstock",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("grenade launcher buttstock", "grenade launcher buttstocks"),
        category = "spare_parts",
        description = ccb.content.text("A collapsible buttstock designed for the M320 grenade launcher.  When combined with this stock, the M320 can be used as a standalone weapon."),
        price_cents = 10000,
        price_postapoc_cents = 250,
        mass_milligrams = 600000,
        volume_ml = 250,
        stackable = true,
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "wasp_sting",
        name = ccb.content.plural_text("wasp stinger", "wasp stingers"),
        description = ccb.content.text("A six-inch stinger from a giant wasp.  Makes a poor melee weapon."),
        mass_milligrams = 540000,
        melee_to_hit = -5,
        color = "dark_gray",
        symbol = ",",
        volume_ml = 250,
        weapon_categories = { "SHIVS" },
        price_cents = 1000,
        price_postapoc_cents = 0,
    }
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("SHEATH_KNIFE")
    item:flag("ALLOWS_BODY_BLOCK")
    item:clear_melee_damage()
    item:melee_damage("stab", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "cannonball_4lb",
        symbol = "o",
        color = "dark_gray",
        name = ccb.content.plural_text("cannonball", "cannonballs"),
        description = ccb.content.text("A four-pound cannonball.  With some gunpowder, wadding, and a fuse, it could be prepared to load into a cannon."),
        mass_milligrams = 1814000,
        volume_ml = 200,
        melee_to_hit = -5,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_melee_damage()
    item:melee_damage("bash", 15)
    content.add(item)
end

do
    local item = content.Item {
        id = "radio_car_wheel",
        category = "spare_parts",
        name = ccb.content.plural_text("RC car wheel set", "RC car wheel sets"),
        description = ccb.content.text("A small set of wheels for a radio-controlled car.  Could be improvised with caster wheels if given rubber treads for grip."),
        mass_milligrams = 260000,
        volume_ml = 480,
        price_cents = 100,
        price_postapoc_cents = 10,
        symbol = "o",
        color = "dark_gray",
        stackable = true,
    }
    item:material("rubber", 1)
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "armor_star_samurai_helmet_destroyed",
        category = "spare_parts",
        name = ccb.content.plural_text("destroyed ryūsei kabuto", "destroyed ryūsei kabuto"),
        description = ccb.content.text("A conical shaped massive slab of inscrutable rock now in two pieces, strange metallic tubes visibly on display.  Something seems to have cracked it from the inside out."),
        mass_milligrams = 150000000,
        volume_ml = 4000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "dark_gray",
        stackable = true,
    }
    item:material("monolith_heavy", 19)
    item:material("superalloy", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "wax_paraffin",
        name = ccb.content.plural_text("chunk of paraffin wax", "chunks of paraffin wax"),
        category = "spare_parts",
        mass_milligrams = 215000,
        color = "white",
        symbol = "%",
        description = ccb.content.text("A large chunk of paraffin wax."),
        price_cents = 500,
        price_postapoc_cents = 10,
        volume_ml = 250,
        stackable = true,
    }
    item:material("paraffin_wax", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end

do
    local item = content.Item {
        id = "discharged_storage_battery",
        name = ccb.content.plural_text("discharged lithium-ion battery", "discharged lithium-ion batteries"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A lithium-ion battery that has been shorted and discharged using saltwater.  At least, you hope it is."),
        mass_milligrams = 1350000,
        volume_ml = 500,
        category = "other",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    content.add(item)
end
