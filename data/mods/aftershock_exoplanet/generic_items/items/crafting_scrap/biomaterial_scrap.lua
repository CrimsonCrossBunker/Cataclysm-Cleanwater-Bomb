local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_biomaterial_1",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("monomeric slurry", "monomeric slurry"),
        description = ccb.content.text("A collection of the building blocks of polymers.  With this and a whole lot of know-how, you can create proteins and other building blocks of life."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_biomaterial_2",
        copy_from = "afs_scrap_2",
        name = ccb.content.plural_text("micellular growth medium", "micellular growth mediums"),
        description = ccb.content.text("For the mixing of biomaterials that might otherwise be antithetical to one another."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_biomaterial_3",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("artificial muscle fibers", "artificial muscle fibers"),
        description = ccb.content.text("Lab-grown or bioprinted muscle fibers; much denser and with higher performance ratios than baseline human muscles."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_biomaterial_4",
        copy_from = "afs_scrap_4",
        name = ccb.content.plural_text("self healing polymers", "self healing polymers"),
        description = ccb.content.text("Materials capable of taking environmental chemicals and utilizing them for self-repair; be careful you don't make gray goo."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_biomaterial_5",
        copy_from = "afs_scrap_5",
        name = ccb.content.plural_text("autologous totipotent tissue culture", "autologous totipotent tissue cultures"),
        description = ccb.content.text("Uncontaminated pure cellular matter that, with the right instructions, can become just about anything."),
        looks_like = "scrap",
    }
    content.add(item)
end
