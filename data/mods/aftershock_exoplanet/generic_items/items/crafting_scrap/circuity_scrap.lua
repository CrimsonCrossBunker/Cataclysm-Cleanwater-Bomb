local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_circuitry_1",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("scrap photonics", "scrap photonics"),
        description = ccb.content.text("Small circuits blue and gold, transmitting signals through light."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_circuitry_2",
        copy_from = "afs_scrap_2",
        name = ccb.content.plural_text("photonic circuitry", "photonic circuitries"),
        description = ccb.content.text("A resplendent golden grid inlaid on dark blue substrate."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_circuitry_3",
        copy_from = "afs_scrap_3",
        name = ccb.content.plural_text("photonic computation core", "photonic computation cores"),
        description = ccb.content.text("A monolithic circuit shaped as a glowing cube of crystal."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_circuitry_4",
        copy_from = "afs_scrap_4",
        name = ccb.content.plural_text("hypergeometric photonics", "hypergeometric photonics"),
        description = ccb.content.text("In your hands lies a self-contained digital universe.  Its programs glowing like stars fixed on computational shells infinitely layered."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_circuitry_5",
        copy_from = "afs_scrap_5",
        name = ccb.content.plural_text("acausal permutator", "acausal permutators"),
        description = ccb.content.text("Time is drowned within its complex depths, and whatever wisdom surfaces is beyond the comprehension of the unaided mind.  If it ever had fruitful applications, such eras are long past."),
        looks_like = "scrap",
    }
    content.add(item)
end
