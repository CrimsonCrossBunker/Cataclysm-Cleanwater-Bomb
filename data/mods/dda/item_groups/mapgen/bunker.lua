local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bunker_basement_books", kind = "distribution" }
    group:group("book_military", 50)
    group:group("book_survival", 50)
    group:group("magazines", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bunker_basement_drugs", kind = "distribution" }
    group:group("drugs_pharmacy", 70)
    group:group("drugs_soldier", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bunker_basement_food", kind = "distribution" }
    group:group("cannedfood", 80)
    group:group("pasta_ingredients", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bunker_basement_clothing", kind = "distribution" }
    group:group("clothing_soldier_shirt", 20)
    group:item("jacket_army", 20)
    group:item("pants_army", 20)
    group:item("boots_combat", 20)
    group:item("helmet_army", 20)
    group:item("gloves_tactical", 10)
    group:item("elbow_pads", 10)
    group:group("clothing_tactical_leg", 15)
    group:group("clothing_tactical_torso", 15)
    group:group("underwear")
    group:entry {
        distribution = {
            { item = "socks", probability = 95 },
            { item = "socks_wool", probability = 5 },
        },
    }
    group:entry {
        distribution = {
            { group = "clothing_glasses", probability = 60 },
            { item = "glasses_bal", probability = 30 },
            { item = "goggles_nv", probability = 5 },
            { item = "goggles_ir", probability = 5 },
        },
        probability = 20,
    }
    group:group("clothing_watch", 5)
    content.add(group)
end
