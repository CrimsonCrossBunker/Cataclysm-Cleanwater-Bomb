local ccb = require("ccb")
local content = ccb.content

-- Native scent types
do
local definition = content.ScentType {
    id = "sc_sugar",
}
definition:receptive_species("MAMMAL")
definition:receptive_species("INSECT")
definition:receptive_species("FUNGUS")
definition:receptive_species("MARSHMALLOW")
definition:receptive_species("GUMMY")
definition:receptive_species("CRACKER")
definition:receptive_species("COOKIE")
definition:receptive_species("CHEWGUM")
content.add(definition)
end
