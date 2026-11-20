local ccb = require("ccb")
local content = ccb.content

-- Native mutation categories
do
local definition = content.MutationCategory {
    id = "DRAGON_BLACK",
    name = ccb.content.text("Black Dragon"),
    mutagen_message = ccb.content.text("Acid boils through your veins.  You feel ancient power swell within you."),
    threshold_mutation = "THRESH_DRAGON_BLACK",
    memorial_message = "Settled to slumber with their hoard.",
    vitamin = "mutagen_black_dragon",
    work_in_progress = true,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SPECIES_DWARF",
    name = ccb.content.text("Dwarf"),
    mutagen_message = ccb.content.text("Your heart beats in time with the rhythm of the Earth."),
    threshold_mutation = "THRESH_SPECIES_DWARF",
    memorial_message = "Entered the halls of the King Under the Mountain.",
    vitamin = "mutagen_species_dwarf",
    base_removal_chance = 0,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SPECIES_ELF",
    name = ccb.content.text("Elf"),
    mutagen_message = ccb.content.text("You hear the songs of nature."),
    threshold_mutation = "THRESH_SPECIES_ELF",
    memorial_message = "Passed into the West.",
    vitamin = "mutagen_species_elf",
    base_removal_chance = 0,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SPECIES_GOBLIN",
    name = ccb.content.text("Goblin"),
    mutagen_message = ccb.content.text("You feel the urge to steal a baby or two."),
    threshold_mutation = "THRESH_SPECIES_GOBLIN",
    memorial_message = "Went full goblin mode.",
    vitamin = "mutagen_species_goblin",
    base_removal_chance = 0,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SPECIES_LIZARDFOLK",
    name = ccb.content.text("Lizardfolk"),
    mutagen_message = ccb.content.text("You remember the warmth of your home swamps."),
    threshold_mutation = "THRESH_SPECIES_LIZARDFOLK",
    memorial_message = "Returned to the World Egg.",
    vitamin = "mutagen_species_lizardfolk",
    base_removal_chance = 0,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SPECIES_RAVENFOLK",
    name = ccb.content.text("Ravenfolk"),
    mutagen_message = ccb.content.text("You feel the call of the sky.  There are treasures out there to collect."),
    threshold_mutation = "THRESH_SPECIES_RAVENFOLK",
    memorial_message = "Fell from your perch on the World Tree.",
    vitamin = "mutagen_species_ravenfolk",
    base_removal_chance = 0,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "MANATOUCHED",
    name = ccb.content.text("Manatouched"),
    mutagen_message = ccb.content.text("Your ley lines surge with mana and power."),
    threshold_mutation = "THRESH_MANA",
    memorial_message = "Ascended to the metaphysical.",
    vitamin = "mutagen_manatouched",
}
content.add(definition)
end
