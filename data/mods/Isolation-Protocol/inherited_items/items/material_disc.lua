local ccb = require("ccb")
local content = ccb.content

do
    -- NO_I18N
    local item = content.Item {
        id = "iso_material_disc_abstract",
        symbol = "H",
        color = "black",
        mass_milligrams = 10000,
        volume_ml = 4,
        name = ccb.content.plural_text("abstract material disc", "abstract material discs"),
        description = content.text("Abstract material disc."),
    }
    item:material("aluminum", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("GENE_TECH")
    content.add(item)
end

do
    local item = content.Item {
        id = "iso_material_disc_ammo",
        copy_from = "iso_material_disc_abstract",
        looks_like = "iso_material_disc_abstract",
        color = "yellow",
        mass_milligrams = 50000,
        name = ccb.content.plural_text("material disc - munition", "material disc - munition"),
        description = ccb.content.text("A palm-sized, dense block of brass, copper, smokeless powder, RDX, or similar materials.\n\nThis could be used to manufacture <color_green>ammunition</color> at the Ouroboros."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "iso_material_disc_basic",
        copy_from = "iso_material_disc_abstract",
        looks_like = "iso_material_disc_abstract",
        color = "light_gray",
        mass_milligrams = 500000,
        name = ccb.content.plural_text("material disc - basic", "material disc - basic"),
        description = ccb.content.text("A palm-sized, dense block of steel, aluminum, various alloys, or similar materials.\n\nThis could be used to manufacture <color_green>weapons and tools</color> at the Ouroboros."),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "iso_material_disc_quality",
        copy_from = "iso_material_disc_abstract",
        looks_like = "iso_material_disc_abstract",
        color = "dark_gray",
        mass_milligrams = 500000,
        name = ccb.content.plural_text("material disc - quality", "material disc - quality"),
        description = ccb.content.text("A palm-sized, very dense block of titanium, high-grade steel, or similar advanced materials.\n\nThis could be used to manufacture <color_green>potent weapons and specialized equipment</color> at the Ouroboros."),
    }
    content.add(item)
end
