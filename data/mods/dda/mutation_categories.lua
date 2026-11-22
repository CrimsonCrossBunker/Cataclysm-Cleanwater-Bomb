local ccb = require("ccb")
local content = ccb.content

-- Native mutation categories
do
local definition = content.MutationCategory {
    id = "ANY",
    name = ccb.content.text("Any"),
    mutagen_message = ccb.content.text("You feel strange."),
    threshold_mutation = "",
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "HUMAN",
    name = ccb.content.text("Human"),
    mutagen_message = ccb.content.text("You feel the aberrance fade."),
    threshold_mutation = "",
    vitamin = "mutagen_human",
    base_removal_chance = 0,
    skip_consistency_test = true,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "PLANT",
    name = ccb.content.text("Plant"),
    mutagen_message = ccb.content.text("You feel much closer to nature.  Your breath and thoughts slow."),
    threshold_mutation = "THRESH_PLANT",
    memorial_message = "Bloomed forth.",
    vitamin = "mutagen_plant",
    base_removal_chance = 75,
    base_removal_cost_multiplier = 1.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "INSECT",
    name = ccb.content.text("Insect"),
    mutagen_message = ccb.content.text("You hear buzzing, and feel your body harden."),
    threshold_mutation = "THRESH_INSECT",
    memorial_message = "Metamorphosed.",
    vitamin = "mutagen_insect",
    base_removal_chance = 50,
    base_removal_cost_multiplier = 2,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SPIDER",
    name = ccb.content.text("Spider"),
    mutagen_message = ccb.content.text("You feel insidious, and your vision fragments for a moment."),
    threshold_mutation = "THRESH_SPIDER",
    memorial_message = "Found a place in the web of life.",
    vitamin = "mutagen_spider",
    base_removal_chance = 50,
    base_removal_cost_multiplier = 2,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "SLIME",
    name = ccb.content.text("Slime", "mutation_category"),
    mutagen_message = ccb.content.text("Your body loses all rigidity for a moment."),
    threshold_mutation = "THRESH_SLIME",
    memorial_message = "Gave up on rigid human norms.",
    vitamin = "mutagen_slime",
    base_removal_cost_multiplier = 1,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "FISH",
    name = ccb.content.text("Fish"),
    mutagen_message = ccb.content.text("You are overcome by an overwhelming longing for the ocean."),
    threshold_mutation = "THRESH_FISH",
    memorial_message = "Went deep.",
    vitamin = "mutagen_fish",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "GASTROPOD",
    name = ccb.content.text("Gastropod"),
    mutagen_message = ccb.content.text("Your split lower body starts to come back together."),
    threshold_mutation = "THRESH_GASTROPOD",
    memorial_message = "Left a trail.",
    vitamin = "mutagen_gastropod",
    base_removal_chance = 75,
    base_removal_cost_multiplier = 1.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "RAT",
    name = ccb.content.text("Rat"),
    mutagen_message = ccb.content.text("You feel a momentary nausea."),
    threshold_mutation = "THRESH_RAT",
    memorial_message = "Found that survival *is* everything.",
    vitamin = "mutagen_rat",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "BEAST",
    name = ccb.content.text("Beast"),
    mutagen_message = ccb.content.text("Your heart races and you see blood for a moment."),
    threshold_mutation = "THRESH_BEAST",
    memorial_message = "Embraced their bestial nature.",
    vitamin = "mutagen_beast",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "URSINE",
    name = ccb.content.text("Ursine"),
    mutagen_message = ccb.content.text("You feel an urge to… patrol?  The forests?"),
    threshold_mutation = "THRESH_URSINE",
    memorial_message = "Became one with the bears.",
    vitamin = "mutagen_ursine",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "FELINE",
    name = ccb.content.text("Feline"),
    mutagen_message = ccb.content.text("Your back arches and the hair stands up on the back of your neck."),
    threshold_mutation = "THRESH_FELINE",
    memorial_message = "Realized the dream.",
    vitamin = "mutagen_feline",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "LUPINE",
    name = ccb.content.text("Lupine"),
    mutagen_message = ccb.content.text("You feel an urge to mark your territory.  But then it passes."),
    threshold_mutation = "THRESH_LUPINE",
    memorial_message = "Wolfed out.",
    vitamin = "mutagen_lupine",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "CATTLE",
    name = ccb.content.text("Cattle"),
    mutagen_message = ccb.content.text("Your mind and body slow down.  You feel peaceful."),
    threshold_mutation = "THRESH_CATTLE",
    memorial_message = "Stopped worrying and learned to love the cowbell.",
    vitamin = "mutagen_cattle",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "CEPHALOPOD",
    name = ccb.content.text("Cephalopod"),
    mutagen_message = ccb.content.text("Your mind is overcome by images of eldritch horrors… and then they pass."),
    threshold_mutation = "THRESH_CEPHALOPOD",
    memorial_message = "Began living the dreams.",
    vitamin = "mutagen_cephalopod",
    base_removal_chance = 50,
    base_removal_cost_multiplier = 2,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "BIRD",
    name = ccb.content.text("Bird"),
    mutagen_message = ccb.content.text("Your body lightens and you long for the sky."),
    threshold_mutation = "THRESH_BIRD",
    memorial_message = "Broke free of humanity.",
    vitamin = "mutagen_bird",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "LIZARD",
    name = ccb.content.text("Lizard"),
    mutagen_message = ccb.content.text("For a heartbeat, your blood cools down."),
    threshold_mutation = "THRESH_LIZARD",
    memorial_message = "Shed the ugly human skin.",
    vitamin = "mutagen_lizard",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "BATRACHIAN",
    name = ccb.content.text("Batrachian"),
    mutagen_message = ccb.content.text("Like a tadpole you must transform."),
    threshold_mutation = "THRESH_BATRACHIAN",
    memorial_message = "Found a bigger pond.",
    vitamin = "mutagen_batrachian",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "TROGLOBITE",
    name = ccb.content.text("Troglobite"),
    mutagen_message = ccb.content.text("You yearn for a cool, dark place to hide."),
    threshold_mutation = "THRESH_TROGLOBITE",
    memorial_message = "Adapted to underground living.",
    vitamin = "mutagen_troglobite",
    base_removal_chance = 20,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "ALPHA",
    name = ccb.content.text("Alpha"),
    mutagen_message = ccb.content.text("You feel… better.  Somehow."),
    threshold_mutation = "THRESH_ALPHA",
    memorial_message = "Started representing.",
    vitamin = "mutagen_alpha",
    threshold_minimum = 2800,
    base_removal_chance = 20,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "MEDICAL",
    name = ccb.content.text("Medical"),
    mutagen_message = ccb.content.text("You can feel the blood rushing through your veins and a strange, medicated feeling washes over your senses."),
    threshold_mutation = "THRESH_MEDICAL",
    memorial_message = "Resumed clinical trials.",
    vitamin = "mutagen_medical",
    base_removal_chance = 20,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "CHIMERA",
    name = ccb.content.text("Chimera"),
    mutagen_message = ccb.content.text("You need to roar, bask, bite, and flap.  NOW."),
    threshold_mutation = "THRESH_CHIMERA",
    memorial_message = "United disunity.",
    vitamin = "mutagen_chimera",
    base_removal_cost_multiplier = 1,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "ELFA",
    name = ccb.content.text("Elf-A"),
    mutagen_message = ccb.content.text("Everything goes green for a second.  Nature is becoming one with you…"),
    threshold_mutation = "THRESH_ELFA",
    memorial_message = "Accepted a more natural way of life.",
    vitamin = "mutagen_elfa",
    base_removal_chance = 20,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "RAPTOR",
    name = ccb.content.text("Raptor"),
    mutagen_message = ccb.content.text("You're struck by a primordial flashback… and then it passes."),
    threshold_mutation = "THRESH_RAPTOR",
    memorial_message = "Hatched.",
    vitamin = "mutagen_raptor",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "MOUSE",
    name = ccb.content.text("Mouse"),
    mutagen_message = ccb.content.text("You feel a desire to curl up in a nice, warm pile of… shredded paper."),
    threshold_mutation = "THRESH_MOUSE",
    memorial_message = "Found the cheese.",
    vitamin = "mutagen_mouse",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "RABBIT",
    name = ccb.content.text("Rabbit"),
    mutagen_message = ccb.content.text("Walking is overrated.  It's time to start hopping."),
    threshold_mutation = "THRESH_RABBIT",
    memorial_message = "Acquired a taste for carrots.",
    vitamin = "mutagen_rabbit",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "CRUSTACEAN",
    name = ccb.content.text("Crustacean"),
    mutagen_message = ccb.content.text("You suddenly want to burrow under some sand or find some nice rocky alcove to hide behind."),
    threshold_mutation = "THRESH_CRUSTACEAN",
    memorial_message = "Dreamed of walking along the sea floor.",
    vitamin = "mutagen_crustacean",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "CHIROPTERAN",
    name = ccb.content.text("Chiropteran"),
    mutagen_message = ccb.content.text("Your ears ring and you taste iron."),
    threshold_mutation = "THRESH_CHIROPTERAN",
    memorial_message = "Became the night.",
    vitamin = "mutagen_chiropteran",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "MYCUS",
    name = ccb.content.text("Mycus"),
    mutagen_message = "",
    threshold_mutation = "THRESH_MYCUS",
    memorial_message = "Dissolved into the collective.",
    vitamin = "null",
    skip_consistency_test = true,
}
content.add(definition)
end
do
local definition = content.MutationCategory {
    id = "INTERSTICE",
    name = ccb.content.text("Interstice"),
    mutagen_message = ccb.content.text("You get a glimpse of the spaces between reality.  It's maddening."),
    threshold_mutation = "THRESH_INTERSTICE",
    memorial_message = "Went somewhere else.",
    vitamin = "mutagen_interstice",
    base_removal_chance = 33,
    base_removal_cost_multiplier = 2.5,
}
content.add(definition)
end
