local content = require("ccb").content

do
    -- These are not really clothing, but spawn with all of the clothing in certain locations
    local group = content.ItemGroup { id = "costume_misc_items", kind = "distribution" }
    group:item("pom_poms", 40)
    group:item("sinister_cane", 40)
    group:entry { item = "wizard_cane_cheap", charges = { 0, 100 }, probability = 40 }
    group:entry { item = "wizard_cane", charges = { 0, 100 }, probability = 5 }
    group:item("scythe_fake", 5)
    group:item("scythe_toy", 5)
    group:item("bokken_fake", 1)
    group:item("katana_fake", 1)
    group:item("longsword_fake", 1)
    group:item("clownshoes", 15)
    group:group("esoteric_books", 2)
    group:group("costume_weapons", 5)
    content.add(group)
end

do
    -- cloaks for costumes, cosplay and costume parties
    local group = content.ItemGroup { id = "costume_cloacks", kind = "distribution" }
    group:item("cloak_vampire", 25)
    group:item("cloak_vampire_red", 5)
    group:item("cloak_black", 40)
    group:item("jedi_cloak", 30)
    group:item("cloak", 15)
    group:item("cloak_leather", 20)
    group:item("cloak_wool", 10)
    group:item("national_flag", 1)
    group:item("state_flag", 1)
    content.add(group)
end
