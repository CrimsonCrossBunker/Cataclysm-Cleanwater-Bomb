local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "advanced_ecig",
        name = ccb.content.plural_text("advanced electronic cigarette", "advanced electronic cigarettes"),
        description = ccb.content.text("An advanced, rechargeable electronic cigarette.  A less harmful way to get your nicotine fix than regular cigarettes, but still addictive.  It needs batteries and nicotine liquid to function."),
        category = "drugs",
        mass_milligrams = 100000,
        volume_ml = 100,
        price_cents = 5000,
        price_postapoc_cents = 100,
        symbol = "!",
        color = "white",
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:clear_flags()
    item:flag("WATER_BREAK")
    item:flag("ELECTRONIC")
    item:clear_use_actions()
    item:native_use("ECIG")
    item:fault_group("electronic_general", {  })
    item:magazine_well {
        rigid = true,
        flags = { "BATTERY_LIGHT", "BATTERY_ULTRA_LIGHT" },
        default_magazine = "light_battery_cell",
    }
    item:tool { charges_per_use = 1, ammo_types = { "battery" }, power_milliwatts = 7500 }
    content.add(item)
end

do
    local item = content.Item {
        id = "crackpipe",
        name = ccb.content.plural_text("crack pipe", "crack pipes"),
        description = ccb.content.text("A fine glass tube with a bulb with a bowl on one end.  It's used to partake of certain illicit substances."),
        mass_milligrams = 242000,
        volume_ml = 80,
        price_cents = 0,
        price_postapoc_cents = 10,
        melee_to_hit = -2,
        symbol = ",",
        color = "cyan",
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:quality("SMOKE_PIPE", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 2)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pipe_glass",
        name = ccb.content.plural_text("glass pipe", "glass pipes"),
        description = ccb.content.text("A hand-blown glass pipe.  It's commonly used to smoke recreational substances."),
        mass_milligrams = 163000,
        volume_ml = 80,
        price_cents = 2000,
        price_postapoc_cents = 100,
        melee_to_hit = -2,
        symbol = ",",
        color = "cyan",
        replace_qualities = true,
    }
    item:material("glass", 1)
    item:quality("SMOKE_PIPE", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pipe_water",
        name = ccb.content.plural_text("water pipe", "water pipes"),
        looks_like = "bottle_plastic",
        description = ccb.content.text("A mass-manufactured water pipe, otherwise known as a 'bong'.  Head shops often insist these are used solely for tobacco, despite their iconic status as cannabis paraphernalia."),
        mass_milligrams = 750000,
        volume_ml = 900,
        longest_side_mm = 300,
        price_cents = 4000,
        price_postapoc_cents = 50,
        replace_pockets = true,
        melee_to_hit = -5,
        symbol = ",",
        color = "cyan",
        replace_qualities = true,
        variant_kind = "generic",
    }
    item:clear_flags()
    item:flag("FRAGILE_MELEE")
    item:flag("NONCONDUCTIVE")
    item:container_pocket {
        max_volume_ml = 500,
        max_weight_milligrams = 1000000,
        watertight = true,
        rigid = true,
        max_item_volume_ml = 500,
        moves = 400,
    }
    item:material("glass", 1)
    item:quality("SMOKE_PIPE", 1)
    item:quality("BOIL", 2)
    item:quality("CONTAIN", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:variants {
        { id = "pipe_water_normal", name = ccb.content.plural_text("bong", "bongs"), description = ccb.content.text("A mass-manufactured water pipe, otherwise known as a 'bong'.  This one is made of plain, clear, glass."), color = "light_gray" },
        { id = "pipe_water_cartoon", name = ccb.content.plural_text("cartoon bong", "cartoon bongs"), description = ccb.content.text("A mass-manufactured water pipe, otherwise known as a 'bong'.  It is covered in copyrighted cartoon characters, all smoking marijuana."), color = "green" },
        { id = "pipe_water_rasta", name = ccb.content.plural_text("rasta bong", "rasta bongs"), description = ccb.content.text("A mass-manufactured water pipe, otherwise known as a 'bong'.  It is colored with the 'rasta' pattern of red, yellow, and green."), color = "red" },
        { id = "pipe_water_handblown", name = ccb.content.plural_text("handblown bong", "handblown bongs"), description = ccb.content.text("A handblown water pipe, also known as a 'bong'.  Lovingly crafted by an artisan, a true fusion of aesthetic sensibilities and stoner functionalities."), color = "green" },
        { id = "pipe_water_psychedelic", name = ccb.content.plural_text("psychedelic bong", "psychedelic bongs"), description = ccb.content.text("A mass-manufactured water pipe, also known as a 'bong'.  It is covered in stickers depicting 'psychedelic' art."), color = "blue" },
        { id = "pipe_water_frosted", name = ccb.content.plural_text("frosted bong", "frosted bongs"), description = ccb.content.text("A mass-manufactured water pipe, also known as a 'bong'.  It is made out of frosted glass."), color = "white" },
        { id = "pipe_water_fakegold", name = ccb.content.plural_text("gold bong", "gold bongs"), description = ccb.content.text("A mass-manufactured water pipe, also known as a 'bong'.  Though it looks like it's made out of gold it is, in fact, just metallic paint."), color = "yellow" },
    }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "pipe_tobacco",
        name = ccb.content.plural_text("tobacco pipe", "tobacco pipes"),
        description = ccb.content.text("A hand-carved wooden smoking pipe.  It's designed to facilitate the consumption of fire-cured tobacco leaves."),
        mass_milligrams = 100000,
        volume_ml = 150,
        longest_side_mm = 150,
        price_cents = 3000,
        price_postapoc_cents = 100,
        symbol = ",",
        color = "brown",
        replace_qualities = true,
    }
    item:material("wood", 1)
    item:quality("SMOKE_PIPE", 1)
    item:tool()
    content.add(item)
end
