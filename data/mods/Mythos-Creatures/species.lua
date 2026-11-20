local ccb = require("ccb")
local content = ccb.content

-- Native monster species
do
local definition = content.Species {
    id = "MYTHOS",
    description = ccb.content.text("a mythos creature"),
}
content.add(definition)
end
