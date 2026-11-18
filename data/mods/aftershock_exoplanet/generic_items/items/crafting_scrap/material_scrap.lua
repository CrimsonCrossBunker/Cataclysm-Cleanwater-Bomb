local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_material_1",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("composite alloy", "composite alloys"),
        description = ccb.content.text("Miscellaneous scrap pieces made from a composite alloy."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_material_2",
        copy_from = "afs_scrap_2",
        name = ccb.content.plural_text("vacuum cast carbide", "vacuum cast carbides"),
        description = ccb.content.text("Malleable carbide cast by forges on high earth orbit."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_material_3",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("nanoprinted alloy", "nanoprinted alloys"),
        description = ccb.content.text("A meta material fabricated by precisely layering different elements at an atomic scale."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_material_4",
        copy_from = "afs_scrap_4",
        name = ccb.content.plural_text("crystal forged neutrite", "crystal forged neutrites"),
        description = ccb.content.text("Great forges within the Earth's core wrought hydrogen into flaming metal and poured it within lattices of super conductive lanthanum.  Locked in magnetic equilibrium, it was left to cool into a dark unbreakable metal."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_material_5",
        copy_from = "afs_scrap_5",
        name = ccb.content.plural_text("shaped tyrium", "shaped tyrium"),
        description = ccb.content.text("A fragment of the continuum lies here, frozen and crystallized into violet metal.  Most likely it will lie here for eternity, forever unchanging."),
        looks_like = "scrap",
    }
    content.add(item)
end
