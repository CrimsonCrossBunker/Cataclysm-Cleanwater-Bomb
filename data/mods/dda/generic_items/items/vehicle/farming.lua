local ccb = require("ccb")
local content = ccb.content

do
    -- Reapers and seed drills are made mostly out of mild steel.
    local item = content.Item {
        id = "v_scoop_item",
        name = ccb.content.plural_text("vehicle scoop", "vehicle scoops"),
        symbol = "u",
        color = "light_gray",
        description = ccb.content.text("An assembly of motors and sheet metal that allows a vehicle to clean the road surface by removing debris and contaminants."),
        mass_milligrams = 22666000,
        category = "veh_parts",
        price_cents = 3500,
        price_postapoc_cents = 500,
        volume_ml = 7000,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "v_planter_item",
        symbol = "8",
        name = ccb.content.plural_text("seed drill", "seed drills"),
        description = ccb.content.text("An assembly of tubes, spikes, and wheels that, when dragged along the ground, allows a vehicle to plant seeds automatically in suitably tilled land."),
        copy_from = "v_scoop_item",
        looks_like = "v_scoop_item",
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "v_reaper_item",
        symbol = "/",
        name = ccb.content.plural_text("reaper", "reapers"),
        description = ccb.content.text("An assembly of a blade, wheels, and a small lever for engaging/disengaging, used to cut down crops prior to picking them up."),
        copy_from = "v_scoop_item",
        looks_like = "v_scoop_item",
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "v_reaper_item_advanced",
        symbol = "/",
        name = ccb.content.plural_text("advanced reaper", "advanced reapers"),
        description = ccb.content.text("An advanced electronic device used to cut down, collect, and store crops."),
        mass_milligrams = 25000000,
        price_cents = 50000,
        price_postapoc_cents = 1500,
        volume_ml = 9000,
        copy_from = "v_scoop_item",
        looks_like = "v_scoop_item",
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "v_planter_item_advanced",
        symbol = "8",
        name = ccb.content.plural_text("advanced seed drill", "advanced seed drills"),
        color = "dark_gray",
        description = ccb.content.text("An assembly of tubes, spikes, and wheels that, when dragged along the ground, allows a vehicle to plant seeds automatically in suitably tilled land.  This one is equipped with an electronic control system and will avoid damaging itself when used on untilled land."),
        mass_milligrams = 32666000,
        price_cents = 50000,
        price_postapoc_cents = 1750,
        volume_ml = 7250,
        copy_from = "v_scoop_item",
        looks_like = "v_scoop_item",
    }
    item:material("lc_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end

do
    -- Made out of 1044 'plow steel' which is a medium steel: https://amsresources.com/1044-m1044-plow-steel-medium-carbon-steel/
    local item = content.Item {
        id = "v_plow_item",
        symbol = "&",
        name = ccb.content.plural_text("plow", "plows"),
        color = "dark_gray",
        description = ccb.content.text("A heavy assembly of wheels and steel blades that turn up the ground."),
        mass_milligrams = 32666000,
        volume_ml = 7250,
        copy_from = "v_scoop_item",
        looks_like = "v_scoop_item",
    }
    item:material("mc_steel", 1)
    item:material("plastic", 1)
    content.add(item)
end
