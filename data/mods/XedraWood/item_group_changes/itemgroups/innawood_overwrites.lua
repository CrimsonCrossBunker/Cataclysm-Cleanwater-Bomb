local content = require("ccb").content

do
    local group = content.ItemGroup { id = "shirts", kind = "distribution" }
    group:item("shirt_straw", 80)
    group:item("vest_leather", 10)
    group:item("poncho", 10)
    content.replace(group)
end

do
    local group = content.ItemGroup { id = "preserved_food", kind = "distribution" }
    group:group("dry_meat_preserved_in_sack", 10)
    group:group("dry_fish_preserved_in_sack", 10)
    group:entry { group = "dry_veggy_preserved_in_sack", count = { 2, 2 }, probability = 10 }
    group:group("dry_corn_preserved_in_sack", 1)
    group:group("dry_fruit_preserved_in_sack", 10)
    content.replace(group)
end
