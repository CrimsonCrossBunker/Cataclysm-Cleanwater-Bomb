local ccb = require("ccb")
local content = ccb.content

do
    local definition = content.Vitamin {
        id = "mutagen_mastodon",
        name = ccb.content.text("Mastodon Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_mastodon",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_migo",
        name = ccb.content.text("Mi-go Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_migo",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
content.add(content.Vitamin {
    id = "vitamin_afs_maintained_powers",
    name = ccb.content.text("Aftershock Maintained Powers Counter"),
    kind = "counter",
    minimum = 0,
    maximum = 100,
    rate_turns = 0,
})
