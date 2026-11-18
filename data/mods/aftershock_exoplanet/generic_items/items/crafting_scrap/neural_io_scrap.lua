local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "afs_neural_io_1",
        copy_from = "afs_scrap_1",
        name = ccb.content.plural_text("peripheral electrode", "peripheral electrodes"),
        description = ccb.content.text("A thin strand of wire and a clamp, meant to be spliced into the smaller nerves of the human body."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_neural_io_2",
        copy_from = "afs_scrap_2",
        name = ccb.content.plural_text("neural electrode", "neural electrodes"),
        description = ccb.content.text("A small array of metallic needles allows complex communication between machine and human mind."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_neural_io_3",
        copy_from = "afs_scrap_3",
        name = ccb.content.plural_text("brain implant prod", "brain implant prods"),
        description = ccb.content.text("A complexly etched rod of metal interfaces with the corpus callosum of the patient, granting increased control of bionic functions."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_neural_io_4",
        copy_from = "afs_scrap_4",
        name = ccb.content.plural_text("artificial neural tissue", "artificial neural tissues"),
        description = ccb.content.text("Photonic axons process thought at speeds far surpassing primitive, chemical-driven communication."),
        looks_like = "scrap",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "afs_neural_io_5",
        copy_from = "afs_scrap_5",
        name = ccb.content.plural_text("neurosynaptic interface matrix", "neurosynaptic interface matrices"),
        description = ccb.content.text("A membrane of artificial neurons envelops the cerebral cortex, melding machine and human intellect into a gestalt much greater than its individual parts."),
        looks_like = "scrap",
    }
    content.add(item)
end
