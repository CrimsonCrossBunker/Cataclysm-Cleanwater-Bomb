local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_heat_1",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("conductive thermoplastic", "conductive thermoplastics"),
        description = ccb.content.text("An excellent heat conductor and electrical insulator.  Conductive thermoplastics were introduced to the civilian market nearly two centuries ago, and have tightly integrated themselves into the modern society since then."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_heat_3",
        copy_from = "afs_scrap_3",
        name = ccb.content.plural_text("carbon-lattice heatsink", "carbon-lattice heatsinks"),
        description = ccb.content.text("Sections of dark, translucent, monocrystalline carbon fins, functionally identical to diamond.  Microscopic etches on the inside allows the flow of high-pressure coolant.  Crystalline carbon lattices exhibit far superior thermal conductivity and deformation resistance than any other conventional metals."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_heat_4",
        copy_from = "afs_scrap_4",
        name = ccb.content.plural_text("fermionic nanoribbon", "fermionic nanoribbons"),
        description = ccb.content.text("This delicate bundle of silvery, iridescent cables is capable of transporting heat energy between its connections instantly without ever heating up by itself.  Even the slightest damage to the casing will annihilate the ground-state quantum uniformity of the fermionic superfluid matrix - Handle with care!"),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_heat_5",
        copy_from = "afs_scrap_5",
        name = ccb.content.plural_text("Maxwellian entropic chirality generator", "Maxwellian entropic chirality generators"),
        description = ccb.content.text("A nondescript square piece of metal about the size of a computer chip.  One side is cold to the touch, while the other is uncomfortably hot.  Hermetically sealed and devoid of any identifying feature, this peculiar device gives off an unexplainable, sinister aura."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    -- This item drops from disassembly instead of afs_heat_2 because that is a liquid. Intended as a QOL detail in case player forgot/didn't know to bring watertight containers when disassembling a relevant object. DO NOT use in crafting recipes, use afs_heat_2 instead.
    local item = content.Item {
        id = "afs_heat_2_salvage",
        copy_from = "afs_scrap_2",
        name = ccb.content.plural_text("salvaged coolant system", "salvaged coolant systems"),
        description = ccb.content.text("Rusty fluid reservoirs and decomposing high-pressure tubing containing still usable supercritical coolant.  You could disassemble it to separate the liquid coolant from the rest of the scrap."),
        looks_like = "scrap",
        price_cents = 1,
        price_postapoc_cents = 1,
        mass_milligrams = 4500000,
        volume_ml = 3200,
    }
    content.add(item)
end
