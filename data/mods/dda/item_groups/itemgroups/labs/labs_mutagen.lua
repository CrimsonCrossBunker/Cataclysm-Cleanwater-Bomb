local content = require("ccb").content

do
    -- common mutation recipe books.
    local group = content.ItemGroup { id = "common_mutation_books", kind = "distribution" }
    group:item("recipe_maiar", 50)
    group:item("recipe_creepy", 30)
    group:item("recipe_animal", 200)
    group:item("recipe_labchem")
    content.add(group)
end

do
    -- rare mutation recipe books.
    local group = content.ItemGroup { id = "rare_mutation_books", kind = "distribution" }
    group:item("recipe_labchem")
    group:item("recipe_medicalmut", 50)
    group:item("recipe_alpha", 50)
    group:item("recipe_elfa", 25)
    group:item("recipe_chimera", 200)
    group:item("recipe_raptor", 200)
    content.add(group)
end

do
    -- Tools for mutation recipes.
    local group = content.ItemGroup { id = "tools_mutation", kind = "distribution" }
    group:item("hotplate", 200)
    group:item("esbit_stove", 50)
    group:item("chemistry_set", 300)
    group:item("still_lab")
    group:item("microcentrifuge")
    group:item("rotovap")
    group:item("funnel_separation", 200)
    group:item("analytical_set_basic", 200)
    content.add(group)
end

do
    -- Lower security tier badges for mutagen lab.
    local group = content.ItemGroup { id = "low_level_badges_mutagen", kind = "distribution" }
    group:item("id_science_visitor_1", 200)
    group:item("id_science_maintenance_green", 150)
    group:item("id_science_transport_1", 200)
    group:item("id_science_security_yellow", 25)
    group:item("id_science_medical_red", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lanyard_YS_badge", kind = "collection", container = "lanyard" }
    group:item("id_science_security_yellow")
    content.add(group)
end
