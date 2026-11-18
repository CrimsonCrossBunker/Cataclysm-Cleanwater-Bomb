local content = require("ccb").content

do
    local group = content.ItemGroup { id = "any_wild_egg", kind = "distribution" }
    group:item("egg_crow", 20)
    group:item("egg_sparrow", 20)
    group:item("egg_bluejay", 10)
    group:item("egg_cardinal", 5)
    group:item("egg_raven", 5)
    group:item("egg_robin", 5)
    group:item("egg_duck", 2)
    group:item("egg_goose_canadian", 1)
    group:item("egg_coot", 1)
    group:item("egg_grebe", 1)
    group:item("egg_hummingbird", 1)
    group:item("egg_turkey", 1)
    group:item("egg_grouse", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "eggs_in_carton", kind = "distribution" }
    group:entry { item = "egg_bird_unfert", count = { 1, 12 }, wrapper = "carton_egg" }
    group:entry { item = "egg_bird_unfert", count = { 1, 6 }, wrapper = "carton_egg_6" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "eggs_in_carton_full", kind = "distribution" }
    group:entry { item = "egg_bird_unfert", count = { 12, 12 }, wrapper = "carton_egg" }
    group:entry { item = "egg_bird_unfert", count = { 6, 6 }, wrapper = "carton_egg_6" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "eggs_in_carton_empty", kind = "distribution" }
    group:entry { item = "egg_bird_unfert", count = { 1, 2 }, wrapper = "carton_egg" }
    group:entry { item = "egg_bird_unfert", count = { 1, 2 }, wrapper = "carton_egg_6" }
    content.add(group)
end
