local ccb = require("ccb")
local content = ccb.content

-- Native mutation categories
do
local definition = content.MutationCategory {
    id = "COMBAT_BRUTE",
    name = ccb.content.text("Perfect Warrior"),
    mutagen_message = ccb.content.text("You feel like a trillion bucks."),
    threshold_mutation = "THRESH_COMBAT_BRUTE",
    memorial_message = "Was reborn as the perfect warrior.",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "MIGO",
    name = ccb.content.text("YUGGOTH"),
    mutagen_message = ccb.content.text("Strange memories of another world overwhelm you…  they fade, but not before you change your genetic structure to suit them."),
    threshold_mutation = "THRESH_YUGGOTH",
    memorial_message = "Prepared the way into the galaxy.",
    vitamin = "mutagen_migo",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "MASTODON",
    name = ccb.content.text("Mastodon"),
    mutagen_message = ccb.content.text("You feel a desire to trumpet and toot."),
    threshold_mutation = "THRESH_MASTODON",
    memorial_message = "Went extinct.",
    vitamin = "mutagen_mastodon",
}
content.add(definition)
end
