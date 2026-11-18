local content = require("ccb").content

do
    -- Itemgroups copied over--due to the way they're implemented, it's difficult to add through copy-from
    local group = content.ItemGroup { id = "mutagenic_field_kit", kind = "collection", container = "box_small_plastic" }
    group:entry {
        distribution = {
            { item = "iv_mutagen_elfa", probability = 2 },
            { item = "iv_mutagen_alpha", probability = 2 },
            { item = "iv_mutagen_raptor", probability = 2 },
            { item = "iv_mutagen_medical", probability = 2 },
            { item = "iv_mutagen_chimera", probability = 2 },
            { item = "iv_mutagen_plant", probability = 2 },
            { item = "iv_mutagen_insect", probability = 2 },
            { item = "iv_mutagen_spider", probability = 2 },
            { item = "iv_mutagen_snail", probability = 2 },
            { item = "iv_mutagen_batrachian", probability = 2 },
            { item = "iv_mutagen_fish", probability = 2 },
            { item = "iv_mutagen_slime", probability = 2 },
            { item = "iv_mutagen_rat", probability = 2 },
            { item = "iv_mutagen_chiropteran", probability = 2 },
            { item = "iv_mutagen_beast", probability = 2 },
            { item = "iv_mutagen_cattle", probability = 2 },
            { item = "iv_mutagen_cephalopod", probability = 2 },
            { item = "iv_mutagen_bird", probability = 2 },
            { item = "iv_mutagen_lizard", probability = 2 },
            { item = "iv_mutagen_troglobite", probability = 2 },
            { item = "iv_mutagen_ursine", probability = 2 },
            { item = "iv_mutagen_feline", probability = 2 },
            { item = "iv_mutagen_lupine", probability = 2 },
            { item = "iv_mutagen_mouse", probability = 2 },
            { item = "iv_mutagen_rabbit", probability = 2 },
            { item = "iv_mutagen_crustacean", probability = 2 },
            { item = "manatouched_serum", probability = 1 },
            { item = "iv_purifier", probability = 2 },
        },
    }
    group:entry { item = "iv_mutagen", count = { 1, 1 } }
    group:entry { item = "syringe", count = { 2, 2 } }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "mutagen_catalyst_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "iv_mutagen", count = { 5, 5 } }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "mutagen_primer_kit", kind = "collection", container = "box_small_plastic" }
    group:entry {
        distribution = {
            { item = "iv_mutagen_elfa", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_alpha", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_raptor", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_medical", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_chimera", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_plant", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_insect", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_spider", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_snail", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_batrachian", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_fish", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_slime", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_rat", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_chiropteran", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_beast", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_cattle", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_cephalopod", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_bird", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_lizard", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_troglobite", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_ursine", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_feline", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_lupine", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_mouse", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_rabbit", count = { 4, 5 }, probability = 2 },
            { item = "iv_mutagen_crustacean", count = { 4, 5 }, probability = 2 },
            { item = "manatouched_serum", count = { 4, 5 }, probability = 1 },
            { item = "iv_purifier", count = { 4, 5 }, probability = 2 },
        },
    }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "mutagen_kit", kind = "collection", container = "box_small_plastic" }
    group:entry {
        distribution = {
            { item = "mutagen_elfa", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_alpha", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_raptor", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_medical", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_chimera", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_plant", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_insect", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_spider", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_snail", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_batrachian", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_fish", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_slime", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_rat", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_chiropteran", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_beast", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_cattle", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_cephalopod", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_bird", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_lizard", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_troglobite", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_ursine", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_feline", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_lupine", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_rabbit", count = { 7, 11 }, probability = 2 },
            { item = "mutagen_crustacean", count = { 7, 11 }, probability = 2 },
            { item = "manatouched_serum", count = { 7, 11 }, probability = 1 },
        },
    }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.replace(group)
end
