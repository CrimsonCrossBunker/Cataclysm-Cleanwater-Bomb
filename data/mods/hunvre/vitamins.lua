local ccb = require("ccb")
local content = ccb.content

do
    local definition = content.Vitamin {
        id = "oneirosis_vitamin",
        name = ccb.content.text("oneirosis vitamin"),
        kind = "counter",
        minimum = 0,
        maximum = 100,
        rate_turns = 0,
        excess = "oneirosis_effect",
    }
    definition:excess_range(20, 50)
    definition:excess_range(50, 80)
    definition:excess_range(80, 100)
    content.add(definition)
end
