local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "EUZHVIL",
    description = ccb.content.text("a nightmare materialized beyond our dimension"),
}
content.add(definition)
end
