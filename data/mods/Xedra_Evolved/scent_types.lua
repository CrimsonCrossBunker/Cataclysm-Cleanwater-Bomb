local ccb = require("ccb")
local content = ccb.content

-- Native scent types
do
local definition = content.ScentType {
    id = "sc_fae",
}
definition:receptive_species("MAMMAL")
definition:receptive_species("BIRD")
definition:receptive_species("AMPHIBIAN")
definition:receptive_species("REPTILE")
definition:receptive_species("FISH")
definition:receptive_species("MUTANT")
definition:receptive_species("NETHER")
definition:receptive_species("SLIME")
definition:receptive_species("FUNGUS")
definition:receptive_species("INSECT")
definition:receptive_species("CENTIPEDE")
definition:receptive_species("SPIDER")
definition:receptive_species("MOLLUSK")
definition:receptive_species("WORM")
definition:receptive_species("HORROR")
definition:receptive_species("ABERRATION")
definition:receptive_species("HALLUCINATION")
definition:receptive_species("UNKNOWN")
definition:receptive_species("ZOMBIE")
content.add(definition)
end
do
local definition = content.ScentType {
    id = "sc_vampire",
}
definition:receptive_species("NETHER")
definition:receptive_species("HORROR")
definition:receptive_species("ABERRATION")
definition:receptive_species("HALLUCINATION")
definition:receptive_species("UNKNOWN")
content.add(definition)
end
