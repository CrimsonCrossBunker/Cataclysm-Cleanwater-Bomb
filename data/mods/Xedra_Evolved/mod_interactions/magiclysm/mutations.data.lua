local ccb = require("ccb")

ccb.content.define_mutation {
    id = "HOMULLUS_BACKSTAGE_active",
    copy_from = "HOMULLUS_BACKSTAGE_active",
    species_anger = {
        HUMAN = -50,
        FERAL = -50,
        LIZARDFOLK = -50,
        GOBLIN = -50,
        RAVENFOLK = -50,
        ELF = -50,
        DWARF = -50,
    },
}
