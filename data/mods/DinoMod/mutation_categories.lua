local ccb = require("ccb")
local content = ccb.content

-- Native mutation categories
do
local definition = content.MutationCategory {
    id = "TYRANT",
    name = ccb.content.text("Tyrant"),
    mutagen_message = ccb.content.text("You feel additional teeth working their way into your mouth."),
    threshold_mutation = "THRESH_TYRANT",
    memorial_message = "Struck by a rogue asteroid.",
    vitamin = "mutagen_tyrant",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "STEGO",
    name = ccb.content.text("Stego"),
    mutagen_message = ccb.content.text("You feel your skin toughen.  You are the armor."),
    threshold_mutation = "THRESH_STEGO",
    memorial_message = "The end of an era.",
    vitamin = "mutagen_stego",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "HORNS",
    name = ccb.content.text("Horns"),
    mutagen_message = ccb.content.text("You feel your face, scalp, and neck stretch and change into something greater."),
    threshold_mutation = "THRESH_HORNS",
    memorial_message = "Got the horns.",
    vitamin = "mutagen_horns",
}
content.add(definition)
end
