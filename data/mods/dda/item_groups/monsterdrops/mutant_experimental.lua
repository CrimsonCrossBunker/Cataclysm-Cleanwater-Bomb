local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mon_mutant_experimental_death_drops", kind = "collection" }
    group:entry { item = "jumpsuit_pocketless", damage = { 2, 3 }, variant = "orange" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_mutant_evolved_death_drops", kind = "collection" }
    group:entry { item = "cotton_patchwork", count = { 1, 4 }, damage = { 1, 4 } }
    group:entry { item = "pants", damage = { 2, 3 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_mutant_alpha_boss_death_drops", kind = "collection" }
    group:item("id_science_mutagen_green")
    group:entry { item = "coat_lab", damage = { 0, 2 } }
    group:entry {
        collection = {
            {
                item = "leather_journal",
                contents = {
                    { item = "note_mutant_alpha_boss" },
                },
                probability = 80,
            },
            { item = "recipe_alpha", probability = 5 },
            { item = "recipe_animal", probability = 10 },
            { item = "recipe_chimera", probability = 5 },
            { item = "recipe_creepy", probability = 10 },
            { item = "recipe_labchem", probability = 10 },
            { item = "recipe_maiar", probability = 10 },
            { item = "recipe_medicalmut", probability = 5 },
            { item = "recipe_raptor", probability = 5 },
            { group = "lab_files_biology", probability = 5 },
        },
    }
    group:item("jumpsuit_pocketless", 100, "orange")
    content.add(group)
end
