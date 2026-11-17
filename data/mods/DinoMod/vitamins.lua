local ccb = require("ccb")
local content = ccb.content

do
    local definition = content.Vitamin {
        id = "mutagen_stego",
        name = ccb.content.text("Stego Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_stego",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_horns",
        name = ccb.content.text("Horns Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_horns",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_tyrant",
        name = ccb.content.text("Tyrant Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_tyrant",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
