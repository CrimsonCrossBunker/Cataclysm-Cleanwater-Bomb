local ccb = require("ccb")
local content = ccb.content

do
    -- Weight and pocket data recalculated from foot_locker with the use of the same resources but with the assumption that walls are gauge 16 aluminum.
    local item = content.Item {
        id = "foot_locker_aluminum",
        category = "container",
        name = ccb.content.plural_text("aluminum foot locker", "aluminum foot lockers"),
        description = ccb.content.text("An aluminum storage box, capable of holding any number of things.  The lid has a small lock."),
        looks_like = "f_foot_locker_aluminum",
        symbol = "O",
        color = "white",
        mass_milligrams = 3721000,
        volume_ml = 69000,
        longest_side_mm = 690,
        price_cents = 20000,
        price_postapoc_cents = 75,
        replace_pockets = true,
        melee_to_hit = -3,
    }
    item:material("aluminum", 1)
    item:container_pocket { max_volume_ml = 67669, max_weight_milligrams = 250000000, rigid = true, max_item_length_mm = 680 }
    item:clear_use_actions()
    item:deploy_furniture("f_foot_locker_aluminum")
    item:clear_melee_damage()
    item:melee_damage("bash", 6)
    content.add(item)
end

do
    -- Based on https://www.duluthtrading.com/best-made-footlocker-B1098.html with the weight calculated from surface area with the use of https://www.engineeringtoolbox.com/gauge-sheet-d_915.html.
    local item = content.Item {
        id = "foot_locker",
        name = ccb.content.plural_text("steel foot locker", "steel foot lockers"),
        description = ccb.content.text("A steel storage box, capable of holding any number of things.  The lid has a small lock."),
        copy_from = "foot_locker_aluminum",
        looks_like = "f_foot_locker",
        color = "light_gray",
        mass_milligrams = 6487000,
        replace_pockets = true,
    }
    item:material("steel", 1)
    item:container_pocket { max_volume_ml = 68208, max_weight_milligrams = 250000000, rigid = true, max_item_length_mm = 680 }
    item:clear_use_actions()
    item:deploy_furniture("f_foot_locker")
    content.add(item)
end
