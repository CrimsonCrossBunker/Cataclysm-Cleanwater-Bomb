local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "flyer",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("flyer", "flyers"),
        snippet_category = "flier",
        description = ccb.content.text("A scrap of paper."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "valentine_card",
        category = "books",
        symbol = ",",
        color = "red",
        name = ccb.content.plural_text("valentine card", "valentine cards"),
        snippet_category = "valentine",
        description = ccb.content.text("A creased holiday card.  It appears to be a Valentine's Day card from before the Cataclysm."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "childnote",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("child's note", "child's notes"),
        snippet_category = "note_child",
        description = ccb.content.text("A piece of paper.  Something's written on it, scrawled in simple, messy handwriting."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 12,
        volume_ml = 1,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_bio",
        name = ccb.content.plural_text("biology protocol", "biology protocols"),
        copy_from = "file",
        looks_like = "file",
        description = ccb.content.text("A sheet of paper adorned with an atom-and-flask symbol, detailing some questionable biological research."),
        snippet_category = "lab_file_bio",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_psych",
        name = ccb.content.plural_text("psychotherapy protocol", "psychotherapy protocols"),
        copy_from = "file",
        looks_like = "file",
        description = ccb.content.text("A sheet of paper bearing an atom-and-cross symbol, pertaining to the mental wellbeing of science staff."),
        snippet_category = "lab_file_psych",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_portal",
        name = ccb.content.plural_text("metatopography protocol", "metatopography protocols"),
        copy_from = "file",
        looks_like = "file",
        description = ccb.content.text("A sheet of paper bearing an atom-and-flask symbol, filled with incoherent ramblings about alien geometries and how to get to them."),
        snippet_category = "lab_file_portal",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_mutagen_guide",
        name = ccb.content.plural_text("production notes", "production notes"),
        description = ccb.content.text("A collection of documents attesting to the purity of this batch, the performance of instrumentation during its production, and a list of materials used during its production and analysis.  It includes a Certificate of Analysis, each line listing a test method, result, and reviewer's signature, all in service of… something.  On one distinctive page a series of checkmarks slowly appear and fade around <color_yellow>\"500 units of catalyst per 500 units of primer\"</color> ratio."),
        copy_from = "file",
        looks_like = "file",
    }
    content.add(item)
end

do
    -- inherit name from item
    local item = content.Item {
        id = "lab_file_mutation_testing",
        name = ccb.content.plural_text("production tests", "production tests"),
        description = ccb.content.text("Accompanying document, that describes tests performed on different subjects."),
        expand_snippets = true,
        copy_from = "file",
        looks_like = "file",
    }
    item:variants {
        { id = "lab_file_mutation_testing_1", description = ccb.content.text("\n\n<mutation_testing>"), append = true, expand_snippets = true },
    }
    content.add(item)
end

do
    -- inherit name from item
    -- inherit name from item
    -- inherit name from item
    -- inherit name from item
    -- inherit name from item
    -- inherit name from item
    local item = content.Item {
        id = "lab_file_serum_testing",
        name = ccb.content.plural_text("production tests", "production tests"),
        description = ccb.content.text("Accompanying document, that describes tests performed on different subjects."),
        expand_snippets = true,
        copy_from = "file",
        looks_like = "file",
    }
    item:variants {
        { id = "lab_file_serum_testing_regen", description = ccb.content.text("\n\n<serum_testing_regen>"), append = true, expand_snippets = true },
        { id = "lab_file_serum_testing_super_soldier", description = ccb.content.text("\n\n<serum_testing_super_soldier>"), append = true, expand_snippets = true },
        { id = "lab_file_serum_testing_resilience", description = ccb.content.text("\n\n<serum_testing_resilience>"), append = true, expand_snippets = true },
        { id = "lab_file_serum_testing_learning", description = ccb.content.text("\n\n<serum_testing_learning>"), append = true, expand_snippets = true },
        { id = "lab_file_serum_testing_speed", description = ccb.content.text("\n\n<serum_testing_speed>"), append = true, expand_snippets = true },
        { id = "lab_file_serum_testing_night_ops", description = ccb.content.text("\n\n<serum_testing_night_ops>"), append = true, expand_snippets = true },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "lab_file_sec",
        name = ccb.content.plural_text("security protocol", "security protocols"),
        copy_from = "file",
        looks_like = "file",
        description = ccb.content.text("A sheet of paper bearing an atom-and-rifle symbol, detailing some very particular security protocols."),
        snippet_category = "lab_file_security",
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "character_sheet",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("character sheet", "character sheets"),
        snippet_category = "charsheet",
        description = ccb.content.text("A Dungeons & Dragons character sheet."),
        looks_like = "survnote",
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 3000,
        volume_ml = 5,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "scorecard",
        category = "other",
        symbol = ",",
        color = "dark_gray",
        name = ccb.content.plural_text("score card", "score cards"),
        snippet_category = "scores",
        description = ccb.content.text("A colorfully-printed score card."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 2,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("CREDIT_CARD_SHAPED")
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "newspaper_memorial",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("newspaper page", "newspaper pages"),
        description = ccb.content.text("A snippet from a newspaper, celebrating the achievements of the one enshrined."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 1000,
        volume_ml = 1,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "death_note",
        category = "books",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("note", "notes"),
        snippet_category = "death_note",
        description = ccb.content.text("A scrap of paper.  Something's written on it, scrawled in bad handwriting."),
        price_cents = 0,
        price_postapoc_cents = 0,
        looks_like = "survnote",
        mass_milligrams = 3000,
        volume_ml = 10,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "evac_pamphlet",
        category = "books",
        name = ccb.content.plural_text("FEMA evacuation pamphlet", "FEMA evacuation pamphlets"),
        description = ccb.content.text("Welcome to your Emergency Survival Shelter.  We hope your stay here will be short and comfortable.  Provided are an emergency blanket, high-visibility jacket, gas mask, and food and water rations for one day, as well as an emergency lighter and flashlight.  There are further supplies in the communal cabinets should the facility be over its intended capacity.  These resources are checked and updated by FEMA on a regular basis, but if you find some items missing, please contact a FEMA supervisor at your earliest convenience.\n\nPlease wait in the shelter until an official evacuation transport arrives to take you to your homes or, in the event of a major disaster, to the nearest evacuation gathering point.\n\nIn the event that you have been evacuated under violent circumstances, FEMA recommends taking cover in the shelter's basement until help arrives.  Remember: if you leave the shelter, we cannot find you to take you to safety."),
        mass_milligrams = 5000,
        volume_ml = 15,
        looks_like = "newest_newspaper",
        color = "white",
        symbol = "?",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "missing_poster_adult",
        category = "books",
        symbol = "`",
        color = "white",
        name = ccb.content.plural_text("missing person poster", "missing person posters"),
        snippet_category = "missing_adult",
        description = ccb.content.text("An official poster notifying the public of a missing person, and requesting that anyone with information contact the listed phone number."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 6000,
        volume_ml = 12,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "missing_poster_child",
        category = "books",
        symbol = "`",
        color = "white",
        name = ccb.content.plural_text("missing child poster", "missing child posters"),
        snippet_category = "missing_child",
        description = ccb.content.text("An official poster notifying the public of a missing child, and requesting that anyone with information contact the listed phone number."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 6000,
        volume_ml = 12,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "missing_poster_dog",
        category = "books",
        symbol = "`",
        color = "white",
        name = ccb.content.plural_text("missing dog poster", "missing dog posters"),
        snippet_category = "missing_dog",
        description = ccb.content.text("A handmade poster notifying passersby about someone's missing dog, and requesting that anyone with information contact the listed phone number."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 6000,
        volume_ml = 12,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    local item = content.Item {
        id = "missing_poster_cat",
        category = "books",
        symbol = "`",
        color = "white",
        name = ccb.content.plural_text("missing cat poster", "missing cat posters"),
        snippet_category = "missing_cat",
        description = ccb.content.text("A handmade poster notifying passersby about someone's missing cat, and requesting that anyone with information contact the listed phone number."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 6000,
        volume_ml = 12,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    content.add(item)
end

do
    -- intentional format
    local item = content.Item {
        id = "movie_poster",
        category = "books",
        symbol = "`",
        name = ccb.content.plural_text("movie poster", "movie posters"),
        description = ccb.content.text("Posters promoting movies that were in theaters when the Cataclysm hit."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 6000,
        volume_ml = 12,
        variant_kind = "generic",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("PAPER_SHAPED")
    item:variants {
        { id = "action", name = ccb.content.plural_text("Last Stand 2: Still Standing movie poster", "Last Stand 2: Still Standing movie posters"), description = ccb.content.text("This a poster for the highly anticipated sequel \"Last Stand 2: Still Standing\".  Ashton Murphy reprises his role as Det. Harvey Baxter, a retired private eye who delivers pain to those who flee from justice."), color = "yellow" },
        { id = "adventure", name = ccb.content.plural_text("The Black Freighter movie poster", "The Black Freighter movie posters"), description = ccb.content.text("A poster promoting the animated movie \"The Black Freighter\", an adaptation of the novel of the same name.  The print is in the same style as the source material."), color = "dark_gray" },
        { id = "comedy", name = ccb.content.plural_text("Simple Guy movie poster", "Simple Guy movie posters"), description = ccb.content.text("A white movie poster displaying a balding man in a stained hoodie waving lackadaisically.  He appears to be the title character."), color = "white" },
        { id = "fantasy", name = ccb.content.plural_text("Fyreguard: A Tale as Old as Time movie poster", "Fyreguard: A Tale as Old as Time movie posters"), description = ccb.content.text("A vibrant poster displaying an astonishing landscape full of magical creatures.  Above the illustration is the title of the movie in a medieval font."), color = "green" },
        { id = "horror", name = ccb.content.plural_text("Hunted III movie poster", "Hunted III movie posters"), description = ccb.content.text("A poster for \"Hunted III\", the third entry of the \"Hunted\" slasher franchise.  Its tagline reads: \"You can't outrun it forever\"."), color = "red" },
        { id = "sci-fi", name = ccb.content.plural_text("Cybercop 3D movie poster", "Cybercop 3D movie posters"), description = ccb.content.text("A poster for \"Cybercop 3D\", a sci-fi movie about a policeman tasked to take down a group of dangerous hackers inside a simulated reality."), color = "light_blue" },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "wallet_photo",
        category = "other",
        symbol = ",",
        color = "white",
        name = ccb.content.plural_text("photograph", "photographs"),
        snippet_category = "wallet_photos",
        description = ccb.content.text("A small picture of something or somebody important to the owner, designed to be safely tucked into a wallet."),
        mass_milligrams = 12,
        volume_ml = 1,
        price_cents = 0,
        price_postapoc_cents = 0,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:flag("BANK_NOTE_SHAPED")
    content.add(item)
end

do
    -- inherit name from item
    -- NO_I18N
    -- inherit name from item
    -- NO_I18N
    local item = content.Item {
        id = "home_picture",
        category = "other",
        symbol = "*",
        color = "white",
        name = ccb.content.plural_text("picture", "pictures"),
        description = ccb.content.text("A medium picture of something that the owner wished to decorate their house with."),
        mass_milligrams = 600000,
        volume_ml = 650,
        price_cents = 0,
        price_postapoc_cents = 0,
    }
    item:material("paper", 1)
    item:material("wood", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:variants {
        { id = "hp_original", description = content.text("<home_pictures>"), expand_snippets = true, weight = 200 },
        { id = "hp_snippet_nested", description = content.text("<hp_nested>"), expand_snippets = true, weight = 40 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "xedra_shack_checklist",
        name = ccb.content.plural_text("incomplete checklist", "incomplete checklists"),
        copy_from = "file",
        looks_like = "file",
        description = ccb.content.text("A sheet of paper with a checklist titled \"TO DO BEFORE JULY RESIGNATION\":\n [X] Acquire activity suit\n [X] Acquire respirator\n [X] Shield gear against THEM\n [ ] Shield walls against THEM\n [X] Install security door\n [ ] 6 months food, water\n [X] Order appliances, panels, radio\n [ ] Install solar panels\n [X] Install radio gear\n [X] Install air purifiers\n [ ] Fix the old boat\n [ ] Buy a gun\n [ ] Finish research statement for faculty apps"),
    }
    content.add(item)
end
