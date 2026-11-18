local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "foldframe",
        name = ccb.content.plural_text("foldable light frame", "foldable light frames"),
        description = ccb.content.text("A light metal framework, designed to fold.  Other vehicle components can be mounted on it.  If all the frames and components of a vehicle are foldable, the vehicle can be folding into a small package and picked up as a normal item."),
        mass_milligrams = 5000000,
        melee_to_hit = -2,
        color = "light_gray",
        symbol = "]",
        techniques = { "DEF_DISARM" },
        volume_ml = 10000,
        category = "veh_parts",
        price_cents = 4000,
        price_postapoc_cents = 100,
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 15)
    content.add(item)
end

do
    local item = content.Item {
        id = "xlframe",
        name = ccb.content.plural_text("extra-light frame", "extra-light frames"),
        description = ccb.content.text("A small, lightweight frame made from pipework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size."),
        mass_milligrams = 1677000,
        copy_from = "foldframe",
        looks_like = "foldframe",
    }
    item:material("aluminum", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "foldxlframe",
        name = ccb.content.plural_text("foldable extra-light frame", "foldable extra-light frames"),
        description = ccb.content.text("A small, lightweight frame made from pipework, designed to fold.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  If all the frames and components of a vehicle are foldable, the vehicle can be folding into a small package and picked up as a normal item."),
        copy_from = "xlframe",
        looks_like = "xlframe",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "frame",
        name = ccb.content.plural_text("steel frame", "steel frames"),
        description = ccb.content.text("A metal framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size."),
        mass_milligrams = 20000000,
        melee_to_hit = -3,
        color = "cyan",
        volume_ml = 15000,
        price_cents = 5500,
        price_postapoc_cents = 100,
        copy_from = "foldframe",
        looks_like = "foldframe",
    }
    item:material("lc_steel", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 20)
    content.add(item)
end

do
    local item = content.Item {
        id = "hdframe",
        name = ccb.content.plural_text("heavy-duty frame", "heavy-duty frames"),
        description = ccb.content.text("A large, reinforced steel frame, used in military vehicle construction.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  Increased mass makes it more resistant to damage in collisions."),
        mass_milligrams = 100000000,
        melee_to_hit = -3,
        color = "green",
        volume_ml = 20000,
        price_cents = 12000,
        price_postapoc_cents = 250,
        replace_qualities = true,
        copy_from = "foldframe",
        looks_like = "foldframe",
    }
    item:material("lc_steel", 1)
    item:quality("ANVIL", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 25)
    content.add(item)
end

do
    local item = content.Item {
        id = "frame_wood",
        name = ccb.content.plural_text("wooden frame", "wooden frames"),
        description = ccb.content.text("A wooden framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  Wood and nail construction means it can be constructed and added to the vehicle without welding tools."),
        mass_milligrams = 8000000,
        melee_to_hit = -3,
        color = "brown",
        volume_ml = 15000,
        price_cents = 3500,
        price_postapoc_cents = 100,
        copy_from = "foldframe",
        looks_like = "foldframe",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 16)
    item:melee_damage("cut", 4)
    content.add(item)
end

do
    local item = content.Item {
        id = "foldwoodframe",
        name = ccb.content.plural_text("foldable wooden frame", "foldable wooden frames"),
        description = ccb.content.text("A light wooden framework, designed to fold.  Other vehicle components can be mounted on it.  If all the frames and components of a vehicle are foldable, the vehicle can be folding into a small package and picked up as a normal item."),
        mass_milligrams = 4000000,
        color = "brown",
        volume_ml = 12500,
        copy_from = "foldframe",
        looks_like = "foldframe",
    }
    item:material("wood", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "frame_wood_light",
        name = ccb.content.plural_text("light wooden frame", "light wooden frames"),
        description = ccb.content.text("A small frame made of a few pieces of wood, held together by rope.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  Wood and rope constructions means it can be constructed and added to the vehicle without welding tools or nails."),
        mass_milligrams = 4000000,
        melee_to_hit = -2,
        color = "brown",
        volume_ml = 8750,
        price_cents = 1000,
        price_postapoc_cents = 50,
        copy_from = "foldframe",
        looks_like = "foldframe",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "frame_wood_deck",
        name = ccb.content.plural_text("skateboard deck", "skateboard decks"),
        description = ccb.content.text("A small skateboard frame made of thin layers of wood glued together.  Other skateboard components can be mounted on it."),
        mass_milligrams = 1500000,
        melee_to_hit = -2,
        color = "brown",
        volume_ml = 8750,
        longest_side_mm = 750,
        price_cents = 1000,
        price_postapoc_cents = 50,
        copy_from = "foldframe",
        looks_like = "foldframe",
    }
    item:material("wood", 1)
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    item:melee_damage("cut", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "frame_concrete_mix",
        name = ccb.content.plural_text("concrete mixer chassis", "concrete mixer chassis"),
        description = ccb.content.text("The chassis of a concrete mixer."),
        mass_milligrams = 9700000,
        volume_ml = 10000,
        color = "light_gray",
        symbol = "]",
        category = "veh_parts",
    }
    content.add(item)
end
