local content = require("ccb").content

do
    local group = content.ItemGroup { id = "museum_misc", kind = "distribution" }
    group:item("ki_strike_scroll", 3)
    content.extend_item_group(group)
end

do
    -- This group may be a bit overpopulated by MMA, but it seemed the most appropriate place for all of these
    local group = content.ItemGroup { id = "book_martial_rare", kind = "distribution" }
    group:item("manual_centipede", 50)
    group:item("manual_lizard", 50)
    group:item("manual_scorpion", 50)
    group:item("manual_toad", 50)
    group:item("manual_venom_snake", 50)
    group:item("manual_mma_desert_wind", 50)
    group:item("manual_mma_diamond_mind", 50)
    group:item("manual_mma_iron_heart", 50)
    group:item("manual_mma_setting_sun", 50)
    group:item("manual_mma_stone_dragon", 50)
    group:item("manual_mma_tiger_claw", 50)
    group:item("manual_mma_shii_cho", 50)
    group:item("manual_mma_pokken", 50)
    group:item("manual_mma_hylian", 50)
    content.extend_item_group(group)
end

do
    local group = content.ItemGroup { id = "book_military", kind = "distribution" }
    group:item("manual_mma_panzer", 10)
    content.extend_item_group(group)
end

do
    -- It seemed like something kids may have, despite technically being a martial art.
    local group = content.ItemGroup { id = "kids_books", kind = "distribution" }
    group:item("manual_mma_pokken", 1)
    content.extend_item_group(group)
end

do
    -- Sublime Way seem to be like books that rich people would be more likely to collect than the others, although still very rare
    local group = content.ItemGroup { id = "mansion_books", kind = "distribution" }
    group:item("manual_mma_desert_wind", 2)
    group:item("manual_mma_diamond_mind", 2)
    group:item("manual_mma_iron_heart", 2)
    group:item("manual_mma_setting_sun", 2)
    group:item("manual_mma_stone_dragon", 2)
    group:item("manual_mma_tiger_claw", 2)
    group:item("manual_mma_shii_cho", 1)
    group:item("manual_mma_pokken", 1)
    group:item("manual_mma_hylian", 1)
    content.extend_item_group(group)
end
