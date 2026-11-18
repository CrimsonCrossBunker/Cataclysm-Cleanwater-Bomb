local content = require("ccb").content

do
    local group = content.ItemGroup { id = "gathering_faction_camp_firewood", kind = "distribution" }
    group:item("stick", 200)
    group:item("withered", 10)
    group:item("straw_pile", 10)
    group:item("splinter", 400)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "foraging_faction_camp_winter", kind = "distribution" }
    group:entry { item = "cattail_rhizome", count = { 1, 4 }, probability = 25 }
    group:group("forage_winter", 75)
    content.add(group)
end

do
    -- Miscellaneous stuff that faction camps need.  Should appear in and around areas that are faction-related camps.
    local group = content.ItemGroup { id = "faction_camp_misc", kind = "distribution" }
    group:entry { item = "nail", count = { 75, 100 }, probability = 80 }
    group:entry { item = "wood_sheet", count = { 3, 5 }, probability = 80 }
    group:entry { item = "wood_panel", count = { 2, 7 }, probability = 80 }
    content.add(group)
end

do
    -- Tools that faction camps need.  Should appear in and around areas that are faction-related camps.
    local group = content.ItemGroup { id = "faction_camp_tools", kind = "distribution" }
    group:item("shovel", 80)
    group:item("ax", 80)
    group:item("saw", 80)
    group:item("bow_saw", 80)
    group:item("hammer", 80)
    group:item("hacksaw", 50)
    content.add(group)
end
