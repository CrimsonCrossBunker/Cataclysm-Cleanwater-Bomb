local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "landough_calrisean",
        copy_from = "sourdough_starter_uncovered",
        looks_like = "jar_glass_sealed",
        name = ccb.content.plural_text("Dana's family sourdough starter", "Dana's family sourdough starter"),
        description = ccb.content.text("This crusty old jar has a glow-in-the-dark Millennium Falcon decal on the side, and a label that reads, \"Landough Calrisean.  Dana's.  Do not touch on pain of death\".  It's been abandoned for some time and doesn't look like it could be readily salvaged as a sourdough culture, but maybe an experienced sourdough baker could manage it."),
        mass_milligrams = 450000,
        volume_ml = 680,
        longest_side_mm = 132,
    }
    item:clear_melee_damage()
    item:melee_damage("bash", 8)
    content.add(item)
end
