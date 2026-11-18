local ccb = require("ccb")
local content = ccb.content

do
    -- 10 charges = 1 welding electrode, 1 charge approximately represents 1cm of the welding seam
    local item = content.Item {
        id = "welding_rod_steel",
        category = "spare_parts",
        name = ccb.content.plural_text("welding rod", "welding rods"),
        description = ccb.content.text("A length of coated welding electrode - a 3 mm thick steel rod coated in a special flux.  During the welding process, the hot metal of the electrode fills the seam, jointing parts together while the flux protects the surface of the seam from atmospheric gases and rapid cooling.  Required for arc welding."),
        ascii_picture = "welding_rod_steel",
        mass_milligrams = 2777,
        volume_ml = 1,
        price_cents = 4,
        price_postapoc_cents = 1,
        symbol = "i",
        color = "light_red",
        longest_side_mm = 350,
        stackable = true,
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end

do
    -- 10 charges = 1 welding electrode, 1 charge approximately represents 1cm of the welding seam
    local item = content.Item {
        id = "welding_rod_alloy",
        category = "spare_parts",
        name = ccb.content.plural_text("aluminum welding rod", "aluminum welding rods"),
        description = ccb.content.text("A length of coated welding electrode - a 3.2 mm thick aluminum rod coated in a special protective flux.  Required for arc welding aluminum alloys."),
        ascii_picture = "welding_rod_alloy",
        mass_milligrams = 1429,
        volume_ml = 1,
        price_cents = 6,
        price_postapoc_cents = 8,
        symbol = "i",
        color = "cyan",
        longest_side_mm = 350,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end

do
    -- 360 charges = 1kg spool of welding wire, 1 charge approximately represents 1cm of thick welding seam
    local item = content.Item {
        id = "welding_wire_steel",
        category = "spare_parts",
        name = ccb.content.plural_text("welding wire", "welding wires"),
        description = ccb.content.text("A length of 0.8 mm steel wire for MAG welding."),
        ascii_picture = "welding_wire_steel",
        mass_milligrams = 2777,
        volume_ml = 1,
        price_cents = 6,
        price_postapoc_cents = 10,
        symbol = "@",
        color = "light_red",
        longest_side_mm = 102,
        stackable = true,
    }
    item:material("iron", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end

do
    -- 360 charges = 0.5kg spool of welding wire, 1 charge approximately represents 1cm of thick welding seam
    local item = content.Item {
        id = "welding_wire_alloy",
        category = "spare_parts",
        name = ccb.content.plural_text("aluminum welding wire", "aluminum welding wires"),
        description = ccb.content.text("A length of 0.9 mm aluminum wire for MIG welding."),
        ascii_picture = "welding_wire_alloy",
        mass_milligrams = 1429,
        volume_ml = 1,
        price_cents = 10,
        price_postapoc_cents = 8,
        symbol = "@",
        color = "cyan",
        longest_side_mm = 102,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end

do
    -- 10 charges = 1 brazing rod, 1 charge approximately represents 1cm of thick brazing seam, since brazing should have lower joining strength - we use more material per 1cm of the seam
    local item = content.Item {
        id = "brazing_rod_bronze",
        category = "spare_parts",
        name = ccb.content.plural_text("brazing rod", "brazing rods"),
        description = ccb.content.text("A length of 3.2 mm flux-coated bronze rod, for brazing steel."),
        ascii_picture = "brazing_rod_bronze",
        mass_milligrams = 3200,
        volume_ml = 2,
        price_cents = 20,
        price_postapoc_cents = 10,
        symbol = "|",
        color = "red",
        longest_side_mm = 460,
        stackable = true,
    }
    item:material("bronze", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end

do
    -- 10 charges = 1 brazing rod, 1 charge approximately represents 1cm of thick brazing seam, since brazing should have lower joining strength - we use more material per 1cm of the seam
    local item = content.Item {
        id = "brazing_rod_alloy",
        category = "spare_parts",
        name = ccb.content.plural_text("aluminum brazing rod", "aluminum brazing rods"),
        description = ccb.content.text("A length of 3.2 mm aluminum rod, for brazing aluminum alloys.  Also suitable for TIG welding."),
        ascii_picture = "brazing_rod_alloy",
        mass_milligrams = 1750,
        volume_ml = 2,
        price_cents = 23,
        price_postapoc_cents = 8,
        symbol = "|",
        color = "cyan",
        longest_side_mm = 460,
        stackable = true,
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end
