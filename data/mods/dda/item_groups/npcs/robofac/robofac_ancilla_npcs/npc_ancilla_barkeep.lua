local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ANCILLA_BARKEEP_worn", kind = "collection" }
    group:item("jeans")
    group:group("NC_BOUNTY_HUNTER_coat")
    group:item("boots_combat")
    group:item("boxer_briefs")
    group:item("tshirt")
    group:item("apron_leather")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_BARKEEP_carry", kind = "collection" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_BARKEEP_wield", kind = "collection" }
    group:item("sheet_cotton")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_BARKEEP_stock", kind = "collection" }
    group:entry { item = "water_clean", count = { 4, 8 } }
    group:entry { group = "beer_in_container", count = { 4, 12 } }
    group:entry { group = "mixed_alcoholic_drinks", count = { 2, 4 } }
    group:entry { group = "soda_in_small_container", count = { 2, 4 } }
    group:entry { group = "alcohol", count = { 2, 10 } }
    group:entry { group = "salty_snacks", count = { 2, 10 } }
    group:entry { group = "cannedfood", count = { 4, 15 } }
    content.add(group)
end
