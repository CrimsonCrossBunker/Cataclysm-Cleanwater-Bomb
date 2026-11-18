local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_energy_storage_1",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("nanowire battery", "nanowire batteries"),
        description = ccb.content.text("A small battery component with a very high energy density."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_energy_storage_2",
        copy_from = "afs_scrap_2",
        name = ccb.content.plural_text("ultracapacitor", "ultracapacitors"),
        description = ccb.content.text("A capacitor made from exotic compounds, capable of storing a high amount of electric charge."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_energy_storage_3",
        copy_from = "afs_scrap_3",
        name = ccb.content.plural_text("ultracapacitor array", "ultracapacitor arrays"),
        description = ccb.content.text("Ultracapacitors assembled into a finely tuned energy storage array."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_energy_storage_4",
        copy_from = "afs_scrap_4",
        name = ccb.content.plural_text("superconductive coil", "superconductive coils"),
        description = ccb.content.text("Superconductive wire warped upon itself manipulates the electromagnetic spectrum to store vast amounts of power."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_energy_storage_5",
        copy_from = "afs_scrap_5",
        name = ccb.content.plural_text("zero-point energy extractor", "zero-point energy extractors"),
        description = ccb.content.text("Symmetry is broken in the finest structures of existence, and the imbalance births constant electric charge.  The power thus extracted must still be repaid, but not in any timeframe relevant to human life."),
        looks_like = "scrap",
    }
    content.add(item)
end
