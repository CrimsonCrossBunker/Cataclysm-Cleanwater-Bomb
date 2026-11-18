local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of tailoring manuals and references.
    local group = content.ItemGroup { id = "SUS_tailoring_bookcase", kind = "collection" }
    group:entry { item = "mag_tailor", count = { 1, 10 }, probability = 80 }
    group:entry { item = "manual_tailor", count = { 1, 4 }, probability = 80 }
    group:entry { item = "textbook_tailor", count = { 1, 4 }, probability = 80 }
    group:item("tailor_portfolio", 20)
    group:item("tailor_japanese", 10)
    group:item("scots_tailor", 10)
    group:item("recipe_fauxfur", 2)
    group:item("dieselpunk_tailor", 2)
    group:item("tailor_japanese", 2)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of tailoring manuals and references.
    local group = content.ItemGroup { id = "SUS_tailoring_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_tailoring_bookcase", count = { 0, 2 }, probability = 40 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of mechanical engineering textbooks and references.
    local group = content.ItemGroup { id = "SUS_engineering_bookcase", kind = "collection" }
    group:entry { item = "mag_mechanics", count = { 1, 10 }, probability = 80 }
    group:entry { item = "manual_mechanics", count = { 1, 4 }, probability = 70 }
    group:entry { item = "textbook_mechanics", count = { 1, 4 }, probability = 80 }
    group:entry { item = "book_icef", count = { 1, 3 }, probability = 60 }
    group:entry { item = "welding_book", count = { 1, 3 }, probability = 80 }
    group:entry { item = "textbook_carpentry", count = { 1, 2 }, probability = 50 }
    group:entry { item = "concrete_book", count = { 1, 2 }, probability = 40 }
    group:item("book_airship_piloting", 5)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of mechanical engineering textbooks and references.
    local group = content.ItemGroup { id = "SUS_engineering_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_engineering_bookcase", count = { 0, 4 }, probability = 40 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of crafts manuals and references.
    local group = content.ItemGroup { id = "SUS_crafts_bookcase", kind = "collection" }
    group:entry { item = "mag_fabrication", count = { 1, 10 }, probability = 80 }
    group:entry { item = "manual_fabrication", count = { 1, 4 }, probability = 70 }
    group:entry { item = "textbook_fabrication", count = { 1, 2 }, probability = 60 }
    group:entry { item = "bronze_mag", count = { 1, 2 }, probability = 50 }
    group:entry { item = "mag_carpentry", count = { 1, 4 }, probability = 80 }
    group:entry { item = "glassblowing_book", count = { 1, 2 }, probability = 60 }
    group:entry { item = "theater_props", count = { 1, 2 }, probability = 40 }
    group:entry { item = "jewelry_book", count = { 1, 3 }, probability = 80 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of crafts manuals and references.
    local group = content.ItemGroup { id = "SUS_crafts_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_crafts_bookcase", count = { 0, 2 }, probability = 30 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of manuals and references for historical manufacturing techniques.
    local group = content.ItemGroup { id = "SUS_historical_manufacturing_bookcase", kind = "collection" }
    group:entry { item = "jewelry_book", count = { 1, 2 }, probability = 70 }
    group:entry { item = "textbook_armeast", count = { 1, 2 }, probability = 60 }
    group:entry { item = "textbook_armwest", count = { 1, 4 }, probability = 80 }
    group:entry { item = "textbook_armschina", count = { 1, 2 }, probability = 50 }
    group:entry { item = "textbook_weapeast", count = { 1, 2 }, probability = 60 }
    group:entry { item = "textbook_weapwest", count = { 1, 4 }, probability = 80 }
    group:entry { item = "textbook_weparabic", count = { 1, 2 }, probability = 60 }
    group:entry { item = "textbook_mesoam", count = { 1, 2 }, probability = 50 }
    group:entry { item = "recipe_melee", count = { 1, 2 }, probability = 30 }
    group:entry { item = "bronze_book", count = { 1, 3 }, probability = 50 }
    group:entry { item = "bronze_mag", count = { 1, 2 }, probability = 30 }
    group:entry { item = "recipe_arrows", count = { 1, 3 }, probability = 60 }
    group:entry { item = "recipe_bows", count = { 1, 3 }, probability = 80 }
    group:entry { item = "ballista_book", count = { 1, 2 }, probability = 40 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of manuals and references for historical manufacturing techniques.
    local group = content.ItemGroup { id = "SUS_historical_manufacturing_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_historical_manufacturing_bookcase", count = { 0, 1 }, probability = 30 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of electronics textbooks and references.
    local group = content.ItemGroup { id = "SUS_electronics_bookcase", kind = "collection" }
    group:entry { item = "mag_electronics", count = { 1, 10 }, probability = 80 }
    group:entry { item = "manual_electronics", count = { 1, 4 }, probability = 80 }
    group:entry { item = "textbook_electronics", count = { 1, 3 }, probability = 80 }
    group:entry { item = "advanced_electronics", count = { 1, 3 }, probability = 60 }
    group:entry { item = "ic_reference_electronics", count = { 1, 2 }, probability = 60 }
    group:entry { item = "radio_book", count = { 1, 3 }, probability = 70 }
    group:entry {
        collection = {
            { item = "textbook_robots", count = { 1, 2 }, probability = 70 },
            { item = "manual_computer", count = { 1, 3 }, probability = 60 },
            { item = "computer_science", count = { 1, 3 }, probability = 70 },
        },
        probability = 30,
    }
    group:item("repeater_mod_guide", 20)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of electronics textbooks and references.
    local group = content.ItemGroup { id = "SUS_electronics_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_electronics_bookcase", count = { 0, 2 }, probability = 30 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of computer science and programming textbooks and references.
    local group = content.ItemGroup { id = "SUS_computers_bookcase", kind = "collection" }
    group:entry { item = "manual_computer", count = { 1, 4 }, probability = 70 }
    group:entry { item = "hackerman_computer", count = { 1, 4 }, probability = 50 }
    group:entry { item = "webbasics_computer", count = { 1, 4 }, probability = 70 }
    group:entry { item = "textbook_computer", count = { 1, 4 }, probability = 80 }
    group:entry { item = "computer_science", count = { 1, 4 }, probability = 80 }
    group:item("SICP", 70)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of computer science and programming textbooks and references.
    local group = content.ItemGroup { id = "SUS_computers_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_computers_bookcase", count = { 1, 4 }, probability = 30 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of chemistry textbooks and references.
    local group = content.ItemGroup { id = "SUS_chemistry_bookcase", kind = "collection" }
    group:entry { item = "textbook_biodiesel", count = { 1, 2 }, probability = 70 }
    group:entry { item = "textbook_gaswarfare", count = { 1, 2 }, probability = 40 }
    group:entry { item = "textbook_chemistry", count = { 1, 4 }, probability = 90 }
    group:entry { item = "textbook_extraction", count = { 1, 2 }, probability = 60 }
    group:entry { item = "adv_chemistry", count = { 1, 4 }, probability = 70 }
    group:entry { item = "basic_chemistry", count = { 1, 3 }, probability = 70 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of chemistry textbooks and references.
    local group = content.ItemGroup { id = "SUS_chemistry_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_chemistry_bookcase", count = { 0, 2 }, probability = 20 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of cooking manuals and references.
    local group = content.ItemGroup { id = "SUS_cooking_bookcase", kind = "collection" }
    group:entry { item = "cookbook_useless", count = { 1, 10 } }
    group:entry { item = "mag_cooking", count = { 1, 10 }, probability = 40 }
    group:entry { item = "cookbook", count = { 1, 4 }, probability = 40 }
    group:entry { item = "cookbook_daintydishes", count = { 1, 2 }, probability = 35 }
    group:entry { item = "cookbook_foodfashions", count = { 1, 2 }, probability = 35 }
    group:item("cookbook_eatyrway", 33)
    group:item("cookbook_liverforkids", 30)
    group:entry { item = "cookbook_sushi", count = { 1, 2 }, probability = 30 }
    group:entry { item = "cookbook_italian", count = { 1, 2 }, probability = 30 }
    group:entry { item = "cookbook_mexican", count = { 1, 2 }, probability = 30 }
    group:item("family_cookbook", 10)
    group:item("scots_cookbook", 5)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of cooking manuals and references.
    local group = content.ItemGroup { id = "SUS_cooking_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_cooking_bookcase", count = { 0, 3 }, probability = 30 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of medical manuals and references.
    local group = content.ItemGroup { id = "SUS_medicine_bookcase", kind = "collection" }
    group:entry { item = "manual_first_aid", count = { 1, 2 }, probability = 60 }
    group:entry { item = "textbook_firstaid", count = { 1, 3 }, probability = 70 }
    group:entry { item = "emergency_book", count = { 1, 4 }, probability = 70 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of medical manuals and references.
    local group = content.ItemGroup { id = "SUS_medicine_bookcase_vandalized", kind = "collection" }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    group:entry { group = "SUS_medicine_bookcase", count = { 0, 2 }, probability = 30 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of business theory textbooks.
    local group = content.ItemGroup { id = "SUS_business_bookcase", kind = "collection" }
    group:entry { item = "manual_business", count = { 1, 3 }, probability = 80 }
    group:entry { item = "textbook_business", count = { 1, 3 }, probability = 80 }
    group:entry { item = "manual_speech", count = { 1, 3 }, probability = 80 }
    group:entry { item = "textbook_speech", count = { 1, 3 }, probability = 80 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of business theory textbooks.
    local group = content.ItemGroup { id = "SUS_business_bookcase_vandalized", kind = "collection" }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    group:entry { group = "SUS_business_bookcase", count = { 0, 1 }, probability = 20 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of bushcraft and wilderness survival manuals and references.
    local group = content.ItemGroup { id = "SUS_bushcraft_bookcase", kind = "collection" }
    group:entry { item = "mag_survival", count = { 1, 10 }, probability = 80 }
    group:entry { item = "manual_survival", count = { 1, 3 }, probability = 80 }
    group:entry { item = "fun_survival", count = { 1, 3 }, probability = 80 }
    group:entry { item = "atomic_survival", count = { 1, 2 }, probability = 30 }
    group:entry { item = "textbook_survival", count = { 1, 3 }, probability = 80 }
    group:entry { item = "survival_book", count = { 1, 2 }, probability = 60 }
    group:entry { item = "manual_swimming", count = { 1, 2 }, probability = 40 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of bushcraft and wilderness survival manuals and references.
    local group = content.ItemGroup { id = "SUS_bushcraft_bookcase_vandalized", kind = "collection" }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    group:entry { group = "SUS_bushcraft_bookcase", count = { 0, 1 }, probability = 20 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of military field and technical manuals.
    local group = content.ItemGroup { id = "SUS_field_manual_bookcase", kind = "collection" }
    group:entry { item = "manual_stabbing", count = { 1, 3 }, probability = 80 }
    group:entry { item = "manual_rifle", count = { 1, 3 }, probability = 80 }
    group:entry { item = "manual_traps_mil", count = { 1, 3 }, probability = 80 }
    group:entry { item = "manual_traps_mil_basic", count = { 1, 3 }, probability = 80 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of martial arts manuals.
    local group = content.ItemGroup { id = "SUS_martial_bookcase", kind = "collection" }
    group:group("book_martial_rare", 65)
    group:entry { group = "book_martial_common", count = { 1, 2 } }
    group:entry { group = "book_mag_combat", count = { 1, 4 } }
    group:entry { group = "book_manual_combat", count = { 1, 2 }, probability = 50 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of martial arts manuals.
    local group = content.ItemGroup { id = "SUS_martial_bookcase_vandalized", kind = "collection" }
    group:group("SUS_martial_bookcase")
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of novels.
    local group = content.ItemGroup { id = "SUS_fiction_bookcase", kind = "collection" }
    group:entry { group = "SUS_book_fict", count = { 4, 22 } }
    group:entry { item = "novel_war", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_adventure", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_experimental", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_road", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_buddy", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_drama", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_mystery", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_fantasy", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_erotic", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_thriller", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_crime", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_horror", count = { 1, 5 }, probability = 80 }
    group:entry { item = "novel_tragedy", count = { 1, 5 }, probability = 80 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a set of novels.
    local group = content.ItemGroup { id = "SUS_fiction_bookcase_vandalized", kind = "collection" }
    group:entry { group = "SUS_fiction_bookcase", count = { 1, 4 }, probability = 40 }
    group:entry { item = "book_ruined", count = { 0, 12 } }
    group:entry { item = "book_pieces", count = { 0, 26 } }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a single book of any type.
    local group = content.ItemGroup { id = "SUS_book", kind = "distribution" }
    group:group("SUS_book_fict", 1)
    group:group("SUS_book_nonf", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns one book about sports.  It may be hard or soft cover, fiction or nonfiction
    local group = content.ItemGroup { id = "SUS_book_sports", kind = "distribution" }
    group:group("SUS_book_fict_soft_sports", 1)
    group:group("SUS_book_fict_hard_sports", 1)
    group:group("SUS_book_nonf_soft_sports", 1)
    group:group("SUS_book_nonf_hard_sports", 1)
    group:group("SUS_book_nonf_zine_sport", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a single book of any fiction.
    local group = content.ItemGroup { id = "SUS_book_fict", kind = "distribution" }
    group:group("SUS_book_fict_soft", 8)
    group:group("SUS_book_fict_hard", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a single paperback book of any fiction.
    local group = content.ItemGroup { id = "SUS_book_fict_soft", kind = "distribution" }
    group:group("SUS_book_fict_soft_pulp", 1)
    group:group("SUS_book_fict_soft_romc", 1)
    group:group("SUS_book_fict_soft_ya", 1)
    group:group("SUS_book_fict_soft_west", 1)
    group:group("SUS_book_fict_soft_satire", 1)
    group:group("SUS_book_fict_soft_swash", 1)
    group:group("SUS_book_fict_soft_sports", 1)
    group:group("SUS_book_fict_soft_scifi", 1)
    group:group("SUS_book_fict_soft_spy", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a single hardback novel.
    local group = content.ItemGroup { id = "SUS_book_fict_hard", kind = "distribution" }
    group:group("SUS_book_fict_hard_scifi", 4)
    group:group("SUS_book_fict_hard_sports", 4)
    group:group("SUS_book_fict_hard_ya", 4)
    group:item("novel_samurai", 1)
    content.add(group)
end

do
    -- Returns a single pulp fiction genre dimestore novel.
    local group = content.ItemGroup { id = "SUS_book_fict_soft_pulp", kind = "distribution" }
    group:item("book_fict_soft_pulp_venus", 2)
    group:item("book_fict_soft_pulp_wtmrw", 2)
    group:item("book_fict_soft_pulp_nogod", 2)
    group:item("book_fict_soft_pulp_ddive", 2)
    group:item("book_fict_soft_pulp_squids", 2)
    group:item("book_fict_soft_pulp_flashcc", 2)
    group:item("book_fict_soft_pulp_gcapes", 2)
    group:item("book_fict_soft_pulp_yesmurd", 2)
    group:item("book_anthology_sst", 2)
    group:item("book_anthology_bk", 2)
    group:item("book_anthology_cw", 2)
    group:item("novel_pulp", 20)
    group:item("novel_crime_midnight", 1)
    group:item("novel_crime_murdergrape", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a single paperback book of the western genre.
    local group = content.ItemGroup { id = "SUS_book_fict_soft_west", kind = "distribution" }
    group:item("novel_western", 20)
    group:item("book_fict_soft_west_atwixt", 1)
    group:item("book_fict_soft_west_bart", 1)
    group:item("book_fict_soft_west_beans", 1)
    group:item("book_fict_soft_west_calico", 1)
    group:item("book_fict_soft_west_riot", 1)
    group:item("book_fict_soft_west_vaq", 1)
    group:item("book_fict_soft_west_vride", 1)
    group:item("book_fict_soft_west_gore", 1)
    content.add(group)
end

do
    -- This returns a single paperback fictional scifi book.
    -- satire_cats and pulp_ddive are both dual genre scifi
    local group = content.ItemGroup { id = "SUS_book_fict_soft_scifi", kind = "distribution" }
    group:item("novel_scifi", 30)
    group:item("book_fict_soft_scifi_brave", 1)
    group:item("book_fict_soft_scifi_f451", 1)
    group:item("book_fict_soft_scifi_roadp", 1)
    group:item("book_fict_soft_scifi_cybrd", 1)
    group:item("book_fict_soft_scifi_dune", 1)
    group:item("book_fict_soft_scifi_zamwe", 1)
    group:item("book_fict_soft_satire_cats", 1)
    group:item("book_anthology_htloop", 1)
    group:item("book_anthology_an", 1)
    group:item("book_anthology_sunvault", 1)
    group:item("book_anthology_moataatgb", 1)
    group:item("book_fict_soft_pulp_ddive", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This returns a single paperback fictional sports book.
    local group = content.ItemGroup { id = "SUS_book_fict_soft_sports", kind = "distribution" }
    group:item("novel_sports", 30)
    group:item("book_fict_soft_sports_bunt", 1)
    group:item("book_fict_soft_sports_tdsp", 1)
    group:item("book_fict_soft_sports_envy", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This returns a single paperback swashbuckling book.
    local group = content.ItemGroup { id = "SUS_book_fict_soft_swash", kind = "distribution" }
    group:item("novel_swash", 30)
    group:item("book_fict_soft_swash_blkfreight", 1)
    group:item("book_fict_soft_swash_searovers", 1)
    group:item("book_fict_soft_swash_buccaneer", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a single paperback book of the romance genre.
    local group = content.ItemGroup { id = "SUS_book_fict_soft_romc", kind = "distribution" }
    group:item("novel_romance", 30)
    group:item("paperback_romance_circuses", 1)
    group:item("paperback_romance_cloven", 1)
    group:item("paperback_romance_conq", 1)
    group:item("paperback_romance_dd", 1)
    group:item("paperback_romance_diodes", 1)
    group:item("paperback_romance_envyh", 1)
    group:item("paperback_romance_grue", 1)
    group:item("paperback_romance_rider", 1)
    group:item("paperback_romance_rogue", 1)
    group:item("paperback_romance_secret", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group returns a single paperback book for young adults and teens.
    local group = content.ItemGroup { id = "SUS_book_fict_soft_ya", kind = "distribution" }
    group:item("book_fict_soft_ya_adrk", 1)
    group:item("book_fict_soft_ya_bjak", 1)
    group:item("book_fict_soft_ya_burn", 1)
    group:item("book_fict_soft_ya_hilo", 1)
    group:item("book_fict_soft_ya_myeyes", 1)
    group:item("book_fict_soft_ya_pbbr", 1)
    group:item("book_fict_soft_ya_rwya", 1)
    group:item("book_fict_soft_ya_sboy", 1)
    group:item("book_fict_soft_ya_sumv", 1)
    group:item("novel_coa", 30)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns a single paperback satire novel
    local group = content.ItemGroup { id = "SUS_book_fict_soft_satire", kind = "distribution" }
    group:item("novel_satire", 30)
    group:item("book_fict_soft_satire_hgod", 1)
    group:item("book_fict_soft_satire_mandm", 1)
    group:item("book_fict_soft_satire_catch", 1)
    group:item("book_fict_soft_satire_dust", 1)
    group:item("book_fict_soft_satire_cats", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns a single paperback spy novel
    local group = content.ItemGroup { id = "SUS_book_fict_soft_spy", kind = "distribution" }
    group:item("novel_spy", 10)
    group:item("novel_spy_comefly", 1)
    group:item("novel_spy_rocketsci", 1)
    content.add(group)
end

do
    -- This returns a single hardback fictional scifi book.
    local group = content.ItemGroup { id = "SUS_book_fict_hard_scifi", kind = "distribution" }
    group:item("book_fict_hard_scifi_dune", 2)
    group:item("book_fict_hard_scifi_talnt", 2)
    group:item("book_fict_hard_scifi_zamwe", 2)
    group:item("book_fict_hard_scifi_fifth", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This returns a single hardback fictional sports book.
    local group = content.ItemGroup { id = "SUS_book_fict_hard_sports", kind = "distribution" }
    group:item("book_fict_hard_sports_semi", 1)
    group:item("book_fict_hard_sports_omni", 1)
    group:item("book_fict_hard_sports_uni", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group returns a single hardback book for young adults and teens.
    local group = content.ItemGroup { id = "SUS_book_fict_hard_ya", kind = "distribution" }
    group:item("book_fict_hard_ya_dark", 3)
    group:item("book_fict_hard_ya_btwo", 3)
    group:item("novel_coa2", 3)
    group:item("book_fict_hard_sports_uni", 2)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a single nonfiction printed material.
    local group = content.ItemGroup { id = "SUS_book_nonf", kind = "distribution" }
    group:group("SUS_book_nonf_hard", 3)
    group:group("SUS_book_nonf_soft", 3)
    group:group("SUS_book_nonf_zine", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a single nonfiction printed material, excluding magazines.
    local group = content.ItemGroup { id = "SUS_book_nonf_no_zines", kind = "distribution" }
    group:group("SUS_book_nonf_hard", 3)
    group:group("SUS_book_nonf_soft", 3)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns a single nonfiction book that is hard bound.  Note that this may or may not be a skill training book.
    local group = content.ItemGroup { id = "SUS_book_nonf_hard", kind = "distribution" }
    group:group("nonfiction_hardback_fluff", 350)
    group:group("SUS_book_nonf_hard_dodge", 10)
    group:group("SUS_book_nonf_hard_spirit", 10)
    group:group("SUS_book_nonf_hard_homemk", 10)
    group:group("SUS_book_nonf_hard_psych", 10)
    group:group("SUS_book_nonf_hard_phil", 7)
    group:group("SUS_book_nonf_hard_sports", 3)
    group:group("SUS_book_nonf_hard_arch", 10)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- a single magazine, but not comics
    local group = content.ItemGroup { id = "SUS_book_nonf_zine", kind = "distribution" }
    group:group("SUS_book_nonf_zine_news", 6)
    group:group("SUS_book_nonf_zine_spint", 5)
    group:group("SUS_book_nonf_zine_sport", 3)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns a single news magazine.
    local group = content.ItemGroup { id = "SUS_book_nonf_zine_news", kind = "distribution" }
    group:item("mag_news", 1)
    group:item("news_regional", 1)
    group:item("mag_glam", 1)
    group:item("book_nonf_zine_news_anlyst", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns a single special interest magazine.
    local group = content.ItemGroup { id = "SUS_book_nonf_zine_spint", kind = "distribution" }
    group:item("fun_survival", 10)
    group:item("mag_survival", 10)
    group:item("mag_dude", 10)
    group:item("mag_traps", 10)
    group:item("mag_rifle", 10)
    group:item("mag_stabbing", 2)
    group:item("mag_swimming", 10)
    group:item("mag_beauty", 10)
    group:item("mag_tailor", 10)
    group:item("mag_computer", 10)
    group:item("mag_electronics", 10)
    group:item("mag_fabrication", 10)
    group:item("mag_mechanics", 10)
    group:item("mag_tailor", 6)
    group:item("news_regional", 10)
    group:item("mag_cooking", 10)
    group:item("mag_cutting", 6)
    group:item("mag_cars", 10)
    group:item("mag_guns", 10)
    group:item("mag_glam", 10)
    group:item("mag_gaming", 10)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns a single sports or games magazine.
    -- rename this SUS_book_nonf_zine_sports
    local group = content.ItemGroup { id = "SUS_book_nonf_zine_sport", kind = "distribution" }
    group:item("mag_unarmed", 1)
    group:item("mag_throwing", 1)
    group:item("mag_archery", 1)
    group:item("mag_bashing", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns a book about homemaking.
    local group = content.ItemGroup { id = "SUS_book_nonf_hard_homemk", kind = "distribution" }
    group:item("book_nonf_hard_homemk_anythingcan", 10)
    group:item("book_nonf_hard_homemk_grtrms", 10)
    group:item("book_nonf_hard_homemk_handshome", 10)
    group:item("book_nonf_hard_homemk_loverms", 10)
    group:item("book_nonf_hard_homemk_nyparti", 10)
    group:item("book_nonf_hard_homemk_outkitchn", 10)
    group:item("book_nonf_hard_homemk_plantshome", 10)
    group:item("book_nonf_hard_homemk_wmencolor", 10)
    group:item("book_nonf_hard_psych_thergar", 3)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns a book about psychology.
    local group = content.ItemGroup { id = "SUS_book_nonf_hard_psych", kind = "distribution" }
    group:item("book_nonf_hard_psych_forpsych", 1)
    group:item("book_nonf_hard_psych_grconres", 1)
    group:item("book_nonf_hard_psych_moodalm", 1)
    group:item("book_nonf_hard_psych_phonodis", 1)
    group:item("book_nonf_hard_psych_thergar", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Returns one hardback book about philosophy.
    local group = content.ItemGroup { id = "SUS_book_nonf_hard_phil", kind = "distribution" }
    group:item("book_nonf_hard_phil_mdlogic", 1)
    group:item("book_nonf_hard_phil_aesth", 1)
    group:item("book_nonf_hard_sports_ergo", 1)
    group:item("book_nonf_hard_phil_phinfo", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns a single religious book that is hard bound.
    local group = content.ItemGroup { id = "SUS_book_nonf_hard_spirit", kind = "distribution" }
    group:item("holybook_bible1", 2)
    group:item("holybook_bible2", 2)
    group:item("holybook_bible3", 2)
    group:item("holybook_granth", 2)
    group:item("holybook_hadith", 2)
    group:item("holybook_havamal", 2)
    group:item("holybook_kallisti", 1)
    group:item("holybook_kojiki", 2)
    group:item("holybook_mormon", 2)
    group:item("holybook_nag_hammadi", 1)
    group:item("holybook_pastafarian", 1)
    group:item("holybook_quran", 2)
    group:item("holybook_slack", 1)
    group:item("holybook_sutras", 2)
    group:item("holybook_talmud", 2)
    group:item("holybook_tanakh", 2)
    group:item("holybook_tripitaka", 2)
    group:item("holybook_upanishads", 2)
    group:item("holybook_vedas", 2)
    group:item("mycenacean_hymns", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns one nonfiction paperback about sports
    local group = content.ItemGroup { id = "SUS_book_nonf_soft_sports", kind = "distribution" }
    group:item("book_nonf_soft_sports_bdgt", 1)
    group:item("book_nonf_soft_sports_lads", 1)
    group:item("book_nonf_soft_sports_vlly", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns a single hardback book of nonfiction sports
    local group = content.ItemGroup { id = "SUS_book_nonf_hard_sports", kind = "distribution" }
    group:item("book_nonf_hard_sports_hoop", 1)
    group:item("book_nonf_hard_sports_bike", 1)
    group:item("book_nonf_hard_sports_ergo", 1)
    group:item("book_nonf_hard_sports_morg", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- returns an archery skill training book that is hard bound.
    local group = content.ItemGroup { id = "SUS_book_nonf_hard_arch", kind = "distribution" }
    group:item("manual_archery", 1)
    group:item("book_archery", 1)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This group is for a dodge skill training book that is hard bound.
    local group = content.ItemGroup { id = "SUS_book_nonf_hard_dodge", kind = "distribution" }
    group:item("manual_dodge", 1)
    group:item("manual_dodge_kid", 1)
    group:item("book_nonf_hard_dodge_tlwd", 1)
    content.add(group)
end
