local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "matrix_crystal_biokin_dust",
        name = ccb.content.plural_text("crystalline dust, pink", "crystalline dust, pink"),
        description = ccb.content.text("A bit of crystalline dust with a faint pink shimmer."),
        color = "pink",
        symbol = "=",
        volume_ml = 1,
        mass_milligrams = 15000,
        looks_like = "material_quicklime",
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_biokin_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, pink", "refined matrix crystal powder, pink"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters pink even in complete darkness."),
        color = "pink",
        symbol = "=",
        volume_ml = 1,
        mass_milligrams = 5000,
        looks_like = "material_quicklime",
    }
    item:material("powder_nonflam", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_clair_dust",
        name = ccb.content.plural_text("crystalline dust, gray", "crystalline dust, gray"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust with a faint gray shimmer."),
        color = "dark_gray",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_clair_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, gray", "refined matrix crystal powder, gray"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters gray even in complete darkness."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "dark_gray",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_electrokin_dust",
        name = ccb.content.plural_text("crystalline dust, cyan", "crystalline dust, cyan"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust with a faint cyan shimmer."),
        color = "cyan",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_electrokin_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, cyan", "refined matrix crystal powder, cyan"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters cyan even in complete darkness."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "cyan",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_photokin_dust",
        name = ccb.content.plural_text("crystalline dust, golden", "crystalline dust, golden"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust with a faint golden shimmer."),
        color = "yellow",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_photokin_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, golden", "refined matrix crystal powder, golden"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters gold even in complete darkness."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "yellow",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_pyrokin_dust",
        name = ccb.content.plural_text("crystalline dust, red", "crystalline dust, red"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust with a faint red shimmer."),
        color = "red",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_pyrokin_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, red", "refined matrix crystal powder, red"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters red even in complete darkness."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "red",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_telekin_dust",
        name = ccb.content.plural_text("crystalline dust, yellow", "crystalline dust, yellow"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust with a faint yellow shimmer."),
        color = "yellow",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_telekin_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, yellow", "refined matrix crystal powder, yellow"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters yellow even in complete darkness."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "yellow",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_telepath_dust",
        name = ccb.content.plural_text("crystalline dust, white", "crystalline dust, white"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust with a faint white shimmer."),
        color = "white",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_telepath_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, white", "refined matrix crystal powder, white"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters white even in complete darkness."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "white",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_teleport_dust",
        name = ccb.content.plural_text("crystalline dust, blue", "crystalline dust, blue"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust with a faint blue shimmer."),
        color = "blue",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_teleport_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, blue", "refined matrix crystal powder, blue"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters blue even in complete darkness."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "blue",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_vitakin_dust",
        name = ccb.content.plural_text("crystalline dust, green", "crystalline dust, green"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust with a faint green shimmer."),
        color = "green",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_vitakin_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, green", "refined matrix crystal powder, green"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It glitters green even in complete darkness."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "green",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_drained_dust",
        name = ccb.content.plural_text("crystalline dust, black", "crystalline dust, black"),
        copy_from = "matrix_crystal_biokin_dust",
        looks_like = "matrix_crystal_biokin_dust",
        description = ccb.content.text("A bit of crystalline dust that seems to absorb light."),
        color = "dark_gray",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "matrix_crystal_drained_dust_refined",
        name = ccb.content.plural_text("refined matrix crystal powder, black", "refined matrix crystal powder, black"),
        description = ccb.content.text("Concentrated matrix crystal dust.  It seems to completely absorb any light that falls on it."),
        copy_from = "matrix_crystal_biokin_dust_refined",
        looks_like = "matrix_crystal_biokin_dust_refined",
        color = "dark_gray",
    }
    content.add(item)
end
