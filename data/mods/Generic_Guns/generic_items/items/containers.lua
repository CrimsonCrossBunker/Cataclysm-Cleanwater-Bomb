local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "pistol_ammo_box_20",
        name = ccb.content.plural_text("pistol ammo box", "pistol ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of pistol ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 7000,
        volume_ml = 80,
        replace_pockets = true,
        symbol = ")",
    }
    item:container_pocket { max_volume_ml = 53, max_weight_milligrams = 300000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "pistol_ammo_box_100",
        name = ccb.content.plural_text("pistol ammo box", "pistol ammo boxes"),
        description = ccb.content.text("This box holds 100 rounds of pistol ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 17000,
        volume_ml = 345,
        replace_pockets = true,
        symbol = ")",
    }
    item:container_pocket { max_volume_ml = 265, max_weight_milligrams = 6000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "pistol_tiny_ammo_box_50",
        name = ccb.content.plural_text("tiny pistol ammo box", "tiny pistol ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of tiny pistol ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 9000,
        volume_ml = 440,
        replace_pockets = true,
        symbol = ")",
    }
    item:container_pocket { max_volume_ml = 73, max_weight_milligrams = 400000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "pistol_tiny_ammo_box_250",
        name = ccb.content.plural_text("tiny pistol ammo box", "tiny pistol ammo boxes"),
        description = ccb.content.text("This box holds 250 rounds of tiny pistol ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 46000,
        volume_ml = 475,
        replace_pockets = true,
        symbol = ")",
    }
    item:container_pocket { max_volume_ml = 365, max_weight_milligrams = 2000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "magnum_ammo_box_20",
        name = ccb.content.plural_text("magnum ammo box", "magnum ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of magnum ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 11000,
        volume_ml = 130,
        replace_pockets = true,
        symbol = ")",
    }
    item:container_pocket { max_volume_ml = 90, max_weight_milligrams = 500000, max_item_length_mm = 100, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "rifle_ammo_box_20",
        name = ccb.content.plural_text("rifle ammo box", "rifle ammo boxes"),
        description = ccb.content.text("This box holds 20 rounds of rifle ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 20000,
        volume_ml = 230,
        replace_pockets = true,
        symbol = ")",
    }
    item:container_pocket { max_volume_ml = 158, max_weight_milligrams = 400000, max_item_length_mm = 140, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "rifle_ammo_box_50",
        name = ccb.content.plural_text("rifle ammo box", "rifle ammo boxes"),
        description = ccb.content.text("This box holds 50 rounds of rifle ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 50000,
        volume_ml = 475,
        replace_pockets = true,
        symbol = ")",
    }
    item:container_pocket { max_volume_ml = 395, max_weight_milligrams = 1000000, rigid = true }
    content.add(item)
end

do
    local item = content.Item {
        id = "shot_ammo_box_10",
        name = ccb.content.plural_text("shotshell ammo box", "shotshell ammo boxes"),
        description = ccb.content.text("This box holds 10 rounds of shotshell ammo.  It's made of a thin cardboard plastered with text about the ammo, and the manufacturer's logo."),
        mass_milligrams = 28000,
        volume_ml = 307,
        replace_pockets = true,
        symbol = ")",
    }
    item:container_pocket { max_volume_ml = 190, max_weight_milligrams = 470000, max_item_length_mm = 100, rigid = true }
    content.add(item)
end
