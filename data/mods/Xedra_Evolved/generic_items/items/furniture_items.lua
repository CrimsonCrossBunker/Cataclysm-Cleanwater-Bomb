local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "chair_treesung",
        name = ccb.content.plural_text("treesung wooden chair", "treesung wooden chairs"),
        copy_from = "chair_wood",
        looks_like = "chair_wood",
        description = ccb.content.text("A simple wooden chair with four legs, a seat, and a back.  It's all made of a single, solid piece of wood, with twists and curves like it grew in place rather than being made.  There's even a small branch with a leaf extending from the top."),
        color = "green",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "wardrobe_treesung",
        name = ccb.content.plural_text("treesung wardrobe", "treesung wardrobes"),
        description = ccb.content.text("A very large wooden cabinet for storing clothes, effectively an upright closet.  It's all made of a single, solid piece of wood, with twists and curves like it grew in place rather than being made."),
        color = "green",
        symbol = "F",
        longest_side_mm = 1700,
        insulation = 10,
        volume_ml = 800000,
        mass_milligrams = 55000000,
        replace_pockets = true,
    }
    item:material("wood", 1)
    item:container_pocket { max_volume_ml = 500000, max_weight_milligrams = 400000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "table_treesung",
        copy_from = "w_table",
        looks_like = "w_table",
        name = ccb.content.plural_text("treesung wooden table", "treesung wooden tables"),
        description = ccb.content.text("A treesung wooden table.  It's all made of a single, solid piece of wood, with twists and curves like it grew in place rather than being made."),
        color = "green",
        symbol = "0",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "bedframe_treesung",
        name = ccb.content.plural_text("treesung bed frame", "treesung bed frames"),
        description = ccb.content.text("A sturdy wooden bed frame built to hold most standard mattresses.  It's all made of a single, solid piece of wood, with twists and curves like it grew in place rather than being made."),
        color = "green",
        copy_from = "frame_wood",
        looks_like = "frame_wood",
    }
    content.add(item)
end
