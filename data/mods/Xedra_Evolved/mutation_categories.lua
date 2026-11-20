local ccb = require("ccb")
local content = ccb.content

-- Native mutation categories
do
local definition = content.MutationCategory {
    id = "IERDE",
    name = ccb.content.text("Ierde"),
    mutagen_message = ccb.content.text("Soil and stone."),
    threshold_mutation = "THRESH_IERDE",
    memorial_message = "Returned to the earth.",
    vitamin = "mutagen_earthkin",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SYLPH",
    name = ccb.content.text("Sylph"),
    mutagen_message = ccb.content.text("Wind and weather."),
    threshold_mutation = "THRESH_SYLPH",
    memorial_message = "Dissipated into the atmosphere.",
    vitamin = "mutagen_airkin",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "UNDINE",
    name = ccb.content.text("Undine"),
    mutagen_message = ccb.content.text("Rain and wave."),
    threshold_mutation = "THRESH_UNDINE",
    memorial_message = "Dissolved into the sea.",
    vitamin = "mutagen_waterkin",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "ARVORE",
    name = ccb.content.text("Arvore"),
    mutagen_message = ccb.content.text("Growth in adversity."),
    threshold_mutation = "THRESH_ARVORE",
    memorial_message = "Fell with a great sound.",
    vitamin = "mutagen_plantkin",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "ARVORE_ALCHEMY",
    name = ccb.content.text("Arvorian Canker"),
    mutagen_message = ccb.content.text("Gorged with verdant power."),
    threshold_mutation = "THRESH_ARVORE",
    memorial_message = "Withered and rotted away.",
    vitamin = "mutagen_alchemical_plantkin",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SALAMANDER",
    name = ccb.content.text("Salamander"),
    mutagen_message = ccb.content.text("Touched by fire."),
    threshold_mutation = "THRESH_SALAMANDER",
    memorial_message = "Snuffed out.",
    vitamin = "mutagen_flamekin",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "HOMULLUS",
    name = ccb.content.text("Homullus"),
    mutagen_message = ccb.content.text("Wish upon a star."),
    threshold_mutation = "THRESH_HOMULLUS",
    memorial_message = "Real enough for you?",
    vitamin = "mutagen_dollkin",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "FAIR_FOLK_NOBLE",
    name = ccb.content.text("Fair Folk Noble"),
    mutagen_message = ccb.content.text(""),
    threshold_mutation = "THRESH_FAIR_FOLK_NOBLE",
    memorial_message = "Empty your heart of its mortal dream.",
    vitamin = "mutagen_fair_folk_noble",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "FAIR_FOLK_COMMONER_BROWNIE",
    name = ccb.content.text("Fair Folk Commoner, Brownie"),
    mutagen_message = ccb.content.text(""),
    threshold_mutation = "THRESH_FAIR_FOLK_COMMONER_BROWNIE",
    memorial_message = "Empty your heart of its mortal dream.",
    vitamin = "mutagen_fair_folk_commoner_brownie",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "FAIR_FOLK_COMMONER_POOKA",
    name = ccb.content.text("Fair Folk Commoner, Pooka"),
    mutagen_message = ccb.content.text(""),
    threshold_mutation = "THRESH_FAIR_FOLK_COMMONER_POOKA",
    memorial_message = "Empty your heart of its mortal dream.",
    vitamin = "mutagen_fair_folk_commoner_pooka",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "FAIR_FOLK_COMMONER_SELKIE",
    name = ccb.content.text("Fair Folk Commoner, Selkie"),
    mutagen_message = ccb.content.text(""),
    threshold_mutation = "THRESH_FAIR_FOLK_COMMONER_SELKIE",
    memorial_message = "Empty your heart of its mortal dream.",
    vitamin = "mutagen_fair_folk_commoner_selkie",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "FAIR_FOLK_COMMONER_TROW",
    name = ccb.content.text("Fair Folk Commoner, Trow"),
    mutagen_message = ccb.content.text(""),
    threshold_mutation = "THRESH_FAIR_FOLK_COMMONER_TROW",
    memorial_message = "Empty your heart of its mortal dream.",
    vitamin = "mutagen_fair_folk_commoner_trow",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "LILIN",
    name = ccb.content.text("Lilin"),
    mutagen_message = ccb.content.text(""),
    threshold_mutation = "THRESH_LILIN",
    memorial_message = "The dawn breaks, and the owl lays down for its final rest.",
    vitamin = "mutagen_lilin",
}
content.add(definition)
end
