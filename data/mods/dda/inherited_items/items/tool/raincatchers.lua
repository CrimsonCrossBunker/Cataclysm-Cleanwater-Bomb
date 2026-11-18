local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "birchbark_funnel",
        name = ccb.content.plural_text("birchbark funnel", "birchbark funnels"),
        description = ccb.content.text("A small birchbark funnel.  Place it above an outdoor container to collect rainwater."),
        mass_milligrams = 30000,
        volume_ml = 250,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "white",
    }
    item:material("wood", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_birchbark_funnel",
        moves = 100,
        practice = 0,
        message = ccb.content.text("You place the funnel, waiting to collect rain."),
        allow_under_player = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "funnel",
        name = ccb.content.plural_text("funnel", "funnels"),
        description = ccb.content.text("A plastic funnel used to collect rainwater.  Use it outside and place a container beneath it to collect water when it rains."),
        mass_milligrams = 150000,
        volume_ml = 500,
        price_cents = 500,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "yellow",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_funnel",
        moves = 100,
        practice = 0,
        message = ccb.content.text("You place the funnel, waiting to collect rain."),
        allow_under_player = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "leather_funnel",
        name = ccb.content.plural_text("leather funnel", "leather funnels"),
        description = ccb.content.text("A small leather funnel used to collect rainwater.  Use it outside and place a container beneath it to collect water when it rains."),
        mass_milligrams = 40000,
        volume_ml = 250,
        price_cents = 0,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "brown",
    }
    item:material("leather", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_leather_funnel",
        moves = 100,
        practice = 0,
        message = ccb.content.text("You place the funnel, waiting to collect rain."),
        allow_under_player = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "makeshift_funnel",
        name = ccb.content.plural_text("makeshift funnel", "makeshift funnels"),
        description = ccb.content.text("A small makeshift funnel used to collect rainwater.  Use it outside and place a container beneath it to collect water when it rains."),
        mass_milligrams = 40000,
        volume_ml = 250,
        price_cents = 0,
        price_postapoc_cents = 10,
        symbol = ";",
        color = "cyan",
    }
    item:material("plastic", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_makeshift_funnel",
        moves = 100,
        practice = 0,
        message = ccb.content.text("You place the funnel, waiting to collect rain."),
        allow_under_player = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "metal_funnel",
        name = ccb.content.plural_text("metal funnel", "metal funnels"),
        description = ccb.content.text("A large metal funnel used to collect rainwater.  Less portable than plastic funnels, but collects more water.  Use it outside and place a container beneath it to collect water when it rains."),
        mass_milligrams = 4017000,
        volume_ml = 4000,
        price_cents = 1500,
        price_postapoc_cents = 250,
        melee_to_hit = -2,
        symbol = ";",
        color = "yellow",
    }
    item:material("steel", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_metal_funnel",
        moves = 100,
        practice = 0,
        message = ccb.content.text("You place the funnel, waiting to collect rain."),
        allow_under_player = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tarp_raincatcher",
        name = ccb.content.plural_text("tarp raincatcher", "tarp raincatchers"),
        description = ccb.content.text("A collection of sticks and string with a tarpaulin to set up as an improvised raincatcher."),
        mass_milligrams = 3980000,
        volume_ml = 4000,
        price_cents = 6000,
        price_postapoc_cents = 100,
        symbol = ";",
        color = "yellow",
    }
    item:material("wood", 1)
    item:material("plastic", 1)
    item:clear_use_actions()
    item:place_trap {
        trap = "tr_raincatcher",
        moves = 100,
        practice = 0,
        message = ccb.content.text("You set up the raincatcher, waiting to collect water."),
        allow_under_player = true,
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:tool()
    content.add(item)
end
