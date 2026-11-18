local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "boat_board",
        symbol = "o",
        color = "brown",
        name = ccb.content.plural_text("wooden boat hull", "wooden boat hulls"),
        description = ccb.content.text("A wooden board that keeps the boat afloat.  Add boat hulls to a vehicle until it floats, then attach oars or a motor to get the boat to move."),
        price_cents = 8000,
        price_postapoc_cents = 100,
        mass_milligrams = 3000000,
        volume_ml = 12500,
        melee_to_hit = -1,
        category = "veh_parts",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "raft_board",
        symbol = "o",
        color = "brown",
        name = ccb.content.plural_text("raft boat hull", "raft boat hulls"),
        description = ccb.content.text("Logs tied together to make a vehicle float.  Add boat hulls to a vehicle until it floats, then attach oars or a motor to get the boat to move."),
        price_cents = 100,
        price_postapoc_cents = 10,
        mass_milligrams = 6000000,
        volume_ml = 12500,
        melee_to_hit = -3,
        category = "veh_parts",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "plastic_boat_hull",
        symbol = "o",
        color = "brown",
        name = ccb.content.plural_text("plastic boat hull", "plastic boat hulls"),
        description = ccb.content.text("A rigid plastic sheet that keeps the boat afloat.  Add boat hulls to a vehicle until it floats, then attach oars or a motor to get the boat to move."),
        price_cents = 16000,
        price_postapoc_cents = 250,
        mass_milligrams = 1500000,
        volume_ml = 12500,
        melee_to_hit = -1,
        category = "veh_parts",
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "carbonfiber_boat_hull",
        symbol = "o",
        color = "brown",
        name = ccb.content.plural_text("carbon fiber boat hull", "carbon fiber boat hulls"),
        description = ccb.content.text("A rigid carbon fiber sheet that keeps the boat afloat.  Add boat hulls to a vehicle until it floats, then attach oars or a motor to get the boat to move."),
        price_cents = 40000,
        price_postapoc_cents = 500,
        mass_milligrams = 500000,
        volume_ml = 12500,
        melee_to_hit = -1,
        category = "veh_parts",
    }
    item:material("kevlar_rigid", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "hand_paddles",
        name = ccb.content.plural_text("oars", "oars"),
        description = ccb.content.text("A pair of oars for a boat."),
        mass_milligrams = 8000000,
        color = "light_gray",
        symbol = ":",
        volume_ml = 16000,
        category = "veh_parts",
        price_cents = 9000,
        price_postapoc_cents = 100,
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 18)
    content.add(item)
end

do
    local item = content.Item {
        id = "sail",
        name = ccb.content.plural_text("sail", "sails"),
        description = ccb.content.text("A sail for a boat."),
        mass_milligrams = 4000000,
        melee_to_hit = -1,
        color = "light_gray",
        symbol = ":",
        volume_ml = 7500,
        category = "veh_parts",
        price_cents = 9000,
        price_postapoc_cents = 1250,
    }
    item:material("wood", 1)
    item:material("cotton", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "inflatable_section",
        symbol = "o",
        color = "green",
        name = ccb.content.plural_text("inflatable section", "inflatable section"),
        description = ccb.content.text("An inflatable boat section."),
        price_cents = 8000,
        price_postapoc_cents = 100,
        mass_milligrams = 3000000,
        volume_ml = 12500,
        melee_to_hit = -2,
        category = "veh_parts",
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "inflatable_airbag",
        symbol = "o",
        color = "dark_gray",
        name = ccb.content.plural_text("inflatable airbag", "inflatable airbag"),
        description = ccb.content.text("An inflatable airbag."),
        price_cents = 8000,
        price_postapoc_cents = 250,
        mass_milligrams = 3000000,
        volume_ml = 12500,
        melee_to_hit = -2,
        category = "veh_parts",
    }
    item:material("plastic", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end

do
    local item = content.Item {
        id = "aluminum_boat_hull",
        symbol = "o",
        color = "light_gray",
        name = ccb.content.plural_text("aluminum boat hull", "aluminum boat hulls"),
        description = ccb.content.text("An aluminum hull that keeps the boat afloat.  Add boat hulls to a vehicle until it floats, then attach oars or a motor to get the boat to move."),
        price_cents = 16000,
        price_postapoc_cents = 250,
        mass_milligrams = 2250000,
        volume_ml = 12500,
        melee_to_hit = -1,
        category = "veh_parts",
    }
    item:material("aluminum", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end
