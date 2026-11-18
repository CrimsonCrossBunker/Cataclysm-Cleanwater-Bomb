local content = require("ccb").content

do
    -- various types of stored items in boxes or empty boxes for the nested cabin cellar
    -- Two itemgroups are necessary because on_overflow can only be specified on top-level itemgroups
    local group = content.ItemGroup { id = "cabin_nested_cellar_boxed_junk", kind = "distribution" }
    group:group("cabin_nested_cellar_boxed_junk_wood", 1)
    group:group("cabin_nested_cellar_boxed_junk_cardboard", 1)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cabin_nested_cellar_boxed_junk_wood",
        kind = "distribution",
        container = "box_large_wood",
        overflow = "spill",
    }
    group:item("null", 50)
    group:entry { group = "clothing_hunting", count = { 2, 4 }, probability = 10 }
    group:entry { group = "clothing_hunting", count = { 2, 4 }, probability = 10 }
    group:entry { group = "camping", count = { 2, 4 }, probability = 10 }
    group:entry { group = "camping", count = { 2, 4 }, probability = 10 }
    group:entry { group = "hiking", count = { 2, 4 }, probability = 10 }
    group:entry { group = "hiking", count = { 2, 4 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "cabin_nested_cellar_boxed_junk_cardboard",
        kind = "distribution",
        container = "box_large",
        overflow = "spill",
    }
    group:item("null", 50)
    group:entry { group = "clothing_hunting", count = { 2, 4 }, probability = 10 }
    group:entry { group = "clothing_hunting", count = { 2, 4 }, probability = 10 }
    group:entry { group = "camping", count = { 2, 4 }, probability = 10 }
    group:entry { group = "camping", count = { 2, 4 }, probability = 10 }
    group:entry { group = "hiking", count = { 2, 4 }, probability = 10 }
    group:entry { group = "hiking", count = { 2, 4 }, probability = 10 }
    content.add(group)
end
