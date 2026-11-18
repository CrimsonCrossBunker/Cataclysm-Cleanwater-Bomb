local content = require("ccb").content

do
    -- This list tracks the things that Elvira will sell the player.
    -- As a general rule of thumb, Elvira should offer any book or magazine for sale that can be easily replaced. She will never sell a rare or unique work.
    -- Non-book resources should be at a minimum. Another NPC may deal in that in the future.
    -- Elvira offers the following things:
    -- - Books, magazines, manuals, games;
    -- - Tools and resources useful for copying documents like paper and pens.
    local group = content.ItemGroup { id = "GREAT_LIBRARY_Shop", kind = "collection" }
    group:entry { group = "GREAT_LIBRARY_Shop_Supplies", count = { 10, 20 } }
    group:entry { group = "GREAT_LIBRARY_Shop_Books", count = { 40, 50 } }
    group:entry { group = "GREAT_LIBRARY_Shop_Tools", count = { 5, 8 } }
    content.add(group)
end

do
    -- Generic spare parts that can be used to make or repair written materials
    local group = content.ItemGroup { id = "GREAT_LIBRARY_Shop_Supplies", kind = "distribution" }
    group:group("duct_tape_roll_part")
    group:group("glue_weak_professional")
    group:entry { item = "paper", count = { 150, 200 } }
    group:entry { item = "cardboard", count = { 10, 20 } }
    content.add(group)
end

do
    -- Books and games that could reasonably be found in a Community College library.  No unique or rare books for sale
    local group = content.ItemGroup { id = "GREAT_LIBRARY_Shop_Books", kind = "distribution" }
    group:entry { group = "novels", count = { 9, 12 } }
    group:entry { group = "manuals_school", count = { 9, 12 } }
    group:entry { group = "literature", count = { 9, 12 } }
    group:entry { group = "games", count = { 5, 6 } }
    content.add(group)
end

do
    -- Tools needed to copy and repair books.
    local group = content.ItemGroup { id = "GREAT_LIBRARY_Shop_Tools", kind = "collection" }
    group:entry { group = "pens", count = { 9, 12 } }
    group:entry { item = "xacto", count = { 1, 2 } }
    content.add(group)
end
