local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "moxie_biopsy",
        copy_from = "cryo_storage_loot",
        color = "red",
        name = ccb.content.plural_text("biopsy", "biopsies"),
        description = ccb.content.text("A sample of diseased looking flesh.  Why it was worth freezing could be anyone's guess.  Maybe a pathologist would care, if you find one of those."),
        price_cents = 5000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cryo_goop",
        copy_from = "cryo_storage_loot",
        color = "red",
        name = ccb.content.plural_text("luminous fluid", "luminous fluid"),
        description = ccb.content.text("Strange, glowing goop?  Someone will pay for this, probably."),
        price_cents = 20000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cryo_egg",
        copy_from = "cryo_storage_loot",
        color = "red",
        name = ccb.content.plural_text("frozen eggs", "frozen eggs"),
        description = ccb.content.text("A clump of frozen eggs.  They look like they could be from some sort of amphibious creature, going by their size and gelatinous appearance."),
        price_cents = 50000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cryo_seedlings",
        copy_from = "cryo_storage_loot",
        color = "red",
        name = ccb.content.plural_text("experimental seedlings", "experimental seedlings"),
        description = ccb.content.text("Violet seedlings frozen mid germination.  Serial numbers have been engraved on their small leaves, but they don't look like any agricultural product you can recognize."),
        price_cents = 150000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cryo_moxie_coral",
        copy_from = "cryo_storage_loot",
        color = "red",
        name = ccb.content.plural_text("diseased coral sample", "diseased coral sample"),
        description = ccb.content.text("A white polyp extracted from a mutant colony.  Appears to have been the result of failed genetic engineering experiments."),
        price_cents = 75000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cryo_migo_brain",
        copy_from = "cryo_storage_loot",
        color = "red",
        name = ccb.content.plural_text("alien tissues", "alien tissues"),
        description = ccb.content.text("Strings of pale tissue frozen in a small container.  They are covered in small folds and ridges, not unlike a human brain, but they don't look like they came from any creature you're familiar with."),
        price_cents = 100000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cryo_terraforming_moss",
        copy_from = "cryo_storage_loot",
        color = "red",
        name = ccb.content.plural_text("Mercurial Mt/2204 samples", "Mercurial Mt/2204 samples"),
        description = ccb.content.text("Neatly cut mats of genetically engineered moss, stored in bright plastic wrappers.  The label indicates they are Mt/2204 samples, a strain designed for nitrogen fixation in snowhouse environments.  Having been stored since the Discontinuity, they retain the original genotype of the product line, and could be of great value to any party with an interest in bioengineering."),
        price_cents = 100000,
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_cryo_chip",
        copy_from = "cryo_storage_loot",
        color = "red",
        name = ccb.content.plural_text("interface organoid", "interface organoids"),
        description = ccb.content.text("You recognize this disgusting clump of flesh and tendrils as one of Mercurial's abortive attempts at creating biomechanical interfaces for human implantation.  Mercurial would likely pay you for its recovery, as would any of its competitors."),
        price_cents = 1500000,
    }
    content.add(item)
end
