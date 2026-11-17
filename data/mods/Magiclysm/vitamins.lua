local ccb = require("ccb")
local content = ccb.content

do
    local definition = content.Vitamin {
        id = "mutagen_black_dragon",
        name = ccb.content.text("Black Dragon Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_black_dragon",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_manatouched",
        name = ccb.content.text("Concentrated Mana Mutagen"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_manatouched",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "vitamin_elven_wilderness",
        name = ccb.content.text("The Longing"),
        kind = "counter",
        minimum = -336,
        maximum = 96,
        rate_turns = 0,
        deficiency = "effect_vitamin_elven_wilderness",
        excess = "effect_vitamin_elven_wilderness_bonus",
    }
    definition:deficiency_range(-24, -84)
    definition:deficiency_range(-85, -168)
    definition:deficiency_range(-169, -252)
    definition:deficiency_range(-253, -336)
    definition:excess_range(96, 96)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_species_dwarf",
        name = ccb.content.text("Dwarven Purifier"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_species_dwarf",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_species_elf",
        name = ccb.content.text("Elven Purifier"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_species_elf",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_species_goblin",
        name = ccb.content.text("Goblin Purifier"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_species_goblin",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_species_lizardfolk",
        name = ccb.content.text("Lizardfolk Purifier"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_species_lizardfolk",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "mutagen_species_ravenfolk",
        name = ccb.content.text("Ravenfolk Purifier"),
        kind = "counter",
        minimum = 0,
        maximum = 2500,
        rate_turns = 3600,
        excess = "mutagen_species_ravenfolk",
    }
    definition:excess_range(100, 500)
    definition:excess_range(501, 2199)
    definition:excess_range(2200, 2500)
    content.add(definition)
end
