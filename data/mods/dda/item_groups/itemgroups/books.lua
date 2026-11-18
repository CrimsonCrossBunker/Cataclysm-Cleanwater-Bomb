local content = require("ccb").content

do
    -- Magazines about guns
    local group = content.ItemGroup { id = "book_gunmags", kind = "distribution" }
    group:item("mag_guns")
    group:item("mag_launcher", 5)
    group:item("mag_pistol", 50)
    group:item("mag_rifle", 50)
    group:item("mag_shotgun", 30)
    group:item("mag_smg", 10)
    content.add(group)
end

do
    -- Reference books about guns
    local group = content.ItemGroup { id = "book_gunref", kind = "distribution" }
    group:item("manual_launcher", 5)
    group:item("manual_pistol", 50)
    group:item("manual_rifle", 50)
    group:item("manual_shotgun", 30)
    group:item("manual_smg", 10)
    group:item("pocket_firearms")
    group:item("text_gunsmith", 75)
    group:item("recipe_bullets", 80)
    content.add(group)
end

do
    -- for music store
    local group = content.ItemGroup { id = "light_reading", kind = "distribution" }
    group:group("kids_books", 139)
    group:item("novel_pulp", 16)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "boxing_books", kind = "distribution" }
    group:item("mag_unarmed", 40)
    group:item("manual_boxing", 50)
    group:item("mag_melee", 25)
    group:item("mag_bashing", 10)
    group:item("manual_melee", 15)
    group:item("recipe_melee", 10)
    group:item("manual_taekwondo", 10)
    group:item("manual_karate", 10)
    group:item("manual_muay_thai", 2)
    group:item("manual_krav_maga", 10)
    content.add(group)
end

do
    -- Books about martial arts
    local group = content.ItemGroup { id = "book_martial", kind = "distribution" }
    group:group("book_martial_common", 5)
    group:group("book_martial_rare", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "book_martial_common", kind = "distribution" }
    group:item("manual_boxing")
    group:item("manual_karate", 90)
    group:item("manual_aikido", 90)
    group:item("manual_taekwondo", 90)
    group:item("manual_judo", 75)
    group:item("manual_muay_thai", 75)
    group:item("manual_kickboxing", 75)
    group:item("manual_krav_maga", 75)
    group:item("manual_capoeira", 50)
    group:item("manual_pankration", 50)
    group:item("manual_tai_chi", 50)
    group:item("manual_wingchun", 50)
    group:item("manual_tiger", 10)
    group:item("manual_crane", 10)
    group:item("manual_dragon", 10)
    group:item("manual_leopard", 10)
    group:item("manual_snake", 10)
    content.add(group)
end

do
    -- Survival skill books weighted according to level
    local group = content.ItemGroup { id = "book_survival", kind = "distribution" }
    group:item("atomic_survival", 12)
    group:item("plastics_book", 20)
    group:item("fun_survival", 33)
    group:item("mag_dude")
    group:item("mag_survival")
    group:item("manual_survival", 33)
    group:item("pocket_survival", 50)
    group:item("survival_book", 12)
    group:item("textbook_survival", 17)
    group:item("textbook_botany", 5)
    group:item("textbook_arthropod", 5)
    group:group("catalyic_cracking_items", 8)
    content.add(group)
end

do
    -- Books found in school library
    local group = content.ItemGroup { id = "book_school", kind = "collection" }
    group:group("novels", 50)
    group:group("kids_books", 40)
    group:group("manuals_school", 30)
    group:group("literature", 30)
    content.add(group)
end

do
    -- texts and magazines likely to be found in hardware stores and other blue collar places.
    local group = content.ItemGroup { id = "hardware_books", kind = "distribution" }
    group:item("manual_mechanics", 35)
    group:item("mag_mechanics", 35)
    group:item("mag_carpentry", 30)
    group:item("101_carpentry", 20)
    group:item("manual_fabrication", 20)
    group:item("book_nonf_hard_homemk_outkitchn", 20)
    group:item("book_nonf_hard_homemk_plantshome", 20)
    group:item("mag_fabrication", 12)
    group:item("concrete_book", 12)
    group:item("textbook_mechanics", 12)
    group:item("textbook_fabrication", 12)
    group:item("textbook_biodiesel", 10)
    group:group("catalyic_cracking_items", 7)
    group:item("manual_carpentry", 10)
    group:item("book_icef", 8)
    group:item("book_pneumatics", 8)
    group:item("carpentry_book", 5)
    group:item("theater_props", 2)
    group:item("alloy_book", 12)
    group:item("metal_casting_book", 12)
    group:item("bronze_book", 8)
    group:item("bronze_mag", 16)
    content.add(group)
end

do
    -- A list of all cookbooks
    local group = content.ItemGroup { id = "cookbooks", kind = "distribution" }
    group:item("cookbook_useless", 360)
    group:item("baking_book", 80)
    group:item("winemaking_beginner", 60)
    group:item("dairy_book", 20)
    group:item("cookbook_sushi", 15)
    group:item("cookbook_daintydishes", 15)
    group:item("cookbook_liverforkids", 15)
    group:item("cookbook_eatyrway", 15)
    group:item("cookbook_mexican", 10)
    group:item("cookbook_foodfashions", 10)
    group:item("cookbook_indian", 10)
    group:item("cookbook_curry", 10)
    group:item("scots_cookbook", 8)
    group:item("fermenting_book", 8)
    group:item("cookbook_native", 5)
    group:item("cookbook_turkish", 5)
    group:item("vacuum_sealing", 5)
    group:item("vinegar_maker", 4)
    group:item("distilling_cookbook", 3)
    group:item("offalcooking", 2)
    group:item("cookbook_bloodforgood", 2)
    group:item("cookbook_human", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "literature", kind = "distribution" }
    group:group("SUS_book_nonf_hard_phil", 1)
    group:item("classic_literature", 10)
    group:item("poetry_book", 10)
    group:item("philosophy_book", 1)
    group:item("essay_book", 6)
    group:item("plays_book", 8)
    content.add(group)
end

do
    -- This represents nonfiction hardback books that are not immediately useful to the survivor.
    local group = content.ItemGroup { id = "nonfiction_hardback_fluff", kind = "distribution" }
    group:item("book_nonf_hard_biography_living", 10)
    group:item("book_nonf_hard_biography_dead", 8)
    group:item("book_nonf_hard_autobiography", 6)
    group:item("book_nonf_hard_history_ancient", 5)
    group:item("book_nonf_hard_history_modern", 10)
    group:item("book_nonf_hard_photography_book", 5)
    group:item("book_nonf_hard_self_help", 8)
    group:item("book_nonf_hard_true_crime", 10)
    group:item("book_nonf_hard_popular_science", 5)
    group:item("book_nonf_hard_business_strategy", 5)
    group:item("book_nonf_hard_language_learning", 2)
    group:item("book_nonf_hard_religion", 3)
    group:item("book_nonf_hard_travelogue", 4)
    group:item("book_nonf_hard_parenting", 4)
    group:item("book_nonf_hard_humor", 3)
    group:item("essay_book", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "ranch_homebooks", kind = "distribution" }
    group:item("reference_firstaid2", 2)
    group:group("homebooks", 98)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dojo_manuals", kind = "distribution" }
    group:group("book_martial_common", 87)
    group:group("book_martial_rare", 28)
    group:item("mag_melee", 20)
    group:item("manual_melee", 10)
    group:item("mag_unarmed", 20)
    group:item("manual_brawl", 10)
    group:item("mag_cutting", 5)
    group:item("recipe_melee", 1)
    group:item("textbook_weapeast", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "doctors_books", kind = "distribution" }
    group:group("SUS_book_nonf_hard_psych", 160)
    group:item("mag_firstaid", 50)
    group:item("textbook_firstaid", 200)
    group:item("manual_swimming", 50)
    group:item("manual_first_aid", 200)
    group:item("pocket_firstaid")
    group:item("textbook_chemistry", 200)
    group:item("adv_chemistry", 200)
    group:item("emergency_book", 200)
    group:item("record_patient")
    group:item("recipe_medicalmut", 10)
    group:item("recipe_serum", 10)
    group:item("recipe_labchem")
    group:item("recipe_augs")
    group:item("reference_firstaid1", 15)
    group:item("textbook_toxicology", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fireman_doc", kind = "distribution" }
    group:item("textbook_fireman")
    group:item("emergency_book")
    group:item("manual_first_aid", 50)
    group:item("manual_swimming", 50)
    group:item("textbook_firstaid", 10)
    group:item("book_pneumatics", 5)
    group:item("mag_computer", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "record_weather", kind = "distribution" }
    group:item("record_weather")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "tailorbooks", kind = "distribution" }
    group:item("tailor_portfolio", 30)
    group:item("mag_tailor", 50)
    group:item("manual_tailor", 30)
    group:item("dieselpunk_tailor", 20)
    group:item("textbook_tailor", 30)
    group:item("book_horse_tack", 12)
    group:item("scots_tailor", 10)
    group:item("recipe_fauxfur", 10)
    group:item("tailor_portfolio", 2)
    group:item("tailor_japanese", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "fabricationbooks", kind = "distribution" }
    group:item("mag_fabrication", 50)
    group:item("manual_fabrication", 35)
    group:item("textbook_fabrication", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "carpentrybooks", kind = "distribution" }
    group:item("mag_carpentry", 35)
    group:item("101_carpentry", 30)
    group:item("textbook_carpentry", 20)
    group:item("carpentry_book", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "electronicbooks", kind = "distribution" }
    group:item("tailor_portfolio", 30)
    group:item("mag_electronics", 50)
    group:item("manual_electronics", 20)
    group:item("radio_book", 15)
    group:item("textbook_electronics", 10)
    group:item("advanced_electronics", 5)
    group:item("ic_reference_electronics", 5)
    group:item("repeater_mod_guide", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "book_mag_tech", kind = "distribution" }
    group:item("mag_fabrication", 30)
    group:item("mag_computer", 35)
    group:item("mag_electronics", 35)
    group:item("mag_mechanics", 35)
    group:item("mag_gaming", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "book_mag_combat", kind = "distribution" }
    group:item("mag_bashing", 10)
    group:item("mag_cutting", 10)
    group:item("mag_stabbing", 10)
    group:item("mag_melee", 10)
    group:item("mag_unarmed", 20)
    group:item("mag_dodge", 20)
    group:item("mag_throwing", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "book_manual_combat", kind = "distribution" }
    group:item("manual_brawl", 10)
    group:item("manual_melee", 10)
    group:item("manual_bashing", 10)
    group:item("manual_stabbing", 5)
    group:item("manual_knives", 5)
    group:item("manual_cutting", 5)
    group:item("manual_swords", 5)
    group:item("manual_dodge", 4)
    group:item("manual_dodge_kid", 4)
    group:item("book_nonf_hard_dodge_tlwd", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "book_mag_surv", kind = "distribution" }
    group:item("mag_survival", 40)
    group:item("mag_traps", 20)
    group:item("fun_survival", 10)
    group:item("mag_archery", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "book_judaica", kind = "distribution" }
    group:item("book_judaica_hardcover", 5)
    group:item("book_judaica_softcover", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "book_manga", kind = "distribution" }
    group:item("book_fic_manga")
    group:item("book_fic_manga_one_piece", 3)
    group:item("book_fic_manga_dragon_ball", 2)
    group:item("book_fic_manga_naruto", 2)
    group:item("book_fic_manga_hunter_x_hunter", 2)
    group:item("book_fic_manga_demon_slayer", 2)
    group:item("book_fic_manga_jujutsu_kaisen", 2)
    group:item("book_fic_manga_bleach", 2)
    group:item("book_fic_manga_jojo", 2)
    group:item("book_fic_manga_captain_tsubasa", 1)
    group:item("book_fic_manga_gintama", 1)
    group:item("book_fic_manga_berserk", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "newspaper_recent", kind = "distribution" }
    group:item("months_old_newspaper", 10)
    group:item("weeks_old_newspaper", 15)
    group:item("newest_newspaper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "newspaper_old", kind = "distribution" }
    group:item("many_years_old_newspaper", 5)
    group:item("years_old_newspaper", 10)
    group:item("one_year_old_newspaper", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "missing_poster_human", kind = "distribution" }
    group:item("missing_poster_adult", 3)
    group:item("missing_poster_child", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "missing_poster_animal", kind = "distribution" }
    group:item("missing_poster_dog", 1)
    group:item("missing_poster_cat", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "missing_poster_all", kind = "distribution" }
    group:group("missing_poster_animal", 4)
    group:group("missing_poster_human", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stand_flyer_maps", kind = "distribution" }
    group:item("satellitemap", 1)
    group:item("touristmap", 2)
    group:item("trailmap", 2)
    group:group("roadmap_stock", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pamphlets", kind = "distribution" }
    group:item("buylocalpamphlet", 2)
    group:item("getactivepamphlet", 1)
    group:item("petpamphlet", 1)
    group:item("nightlifepamphlet", 2)
    group:item("gunnutpamphlet", 1)
    group:item("petpamphlet", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "brochures", kind = "distribution" }
    group:item("restaurantbrochure", 2)
    group:item("grocerybrochure", 1)
    group:item("historybrochure", 1)
    group:item("mallbrochure", 2)
    group:item("furniturebrochure", 1)
    group:item("technologybrochure", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stand_flyer_bad", kind = "collection" }
    group:entry {
        distribution = {
            { item = "flyer", count = { 3, 3 }, probability = 6 },
            { group = "pamphlets", count = { 3, 3 }, probability = 1 },
            { group = "brochures", count = { 3, 3 }, probability = 1 },
        },
    }
    group:entry {
        distribution = {
            { item = "flyer", count = { 3, 3 }, probability = 6 },
            { group = "pamphlets", count = { 3, 3 }, probability = 1 },
            { group = "brochures", count = { 3, 3 }, probability = 1 },
        },
    }
    group:entry {
        distribution = {
            { item = "flyer", count = { 3, 3 }, probability = 6 },
            { group = "pamphlets", count = { 3, 3 }, probability = 1 },
            { group = "brochures", count = { 3, 3 }, probability = 1 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stand_flyer_good", kind = "collection" }
    group:entry {
        distribution = {
            { item = "flyer", count = { 3, 3 }, probability = 1 },
            { group = "stand_flyer_maps", count = { 3, 3 }, probability = 1 },
        },
    }
    group:entry {
        distribution = {
            { item = "flyer", count = { 3, 3 }, probability = 1 },
            { group = "stand_flyer_maps", count = { 3, 3 }, probability = 1 },
        },
    }
    group:entry {
        distribution = {
            { item = "flyer", count = { 3, 3 }, probability = 1 },
            { group = "stand_flyer_maps", count = { 3, 3 }, probability = 1 },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "stand_flyer", kind = "distribution", container = "stand_flyer" }
    group:group("stand_flyer_good", 1)
    group:group("stand_flyer_bad", 3)
    content.add(group)
end

do
    -- Public messages posted on bulletin boards in public spaces to advertise items wanted or for sale, announce events, or provide information.
    -- TO DO: local adverts, event announcements, job application posters, etc.
    local group = content.ItemGroup { id = "bulletin_public", kind = "collection" }
    group:group("missing_poster_all", 30)
    group:entry { item = "flyer", count = { 1, 2 }, probability = 70 }
    group:entry { item = "flyer_evac", count = { 1, 2 }, probability = 70 }
    group:item("buylocalpamphlet", 15)
    content.add(group)
end

do
    -- Public messages posted on bulletin boards in police stations to provide information.
    -- TO DO: crime bulletins, wanted criminals/suspects/fugitives, community notifications, etc.
    local group = content.ItemGroup { id = "bulletin_police", kind = "collection" }
    group:group("missing_poster_human")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "european_comics_collection", kind = "distribution" }
    group:entry { item = "european_comic", count = { 1, 16 }, variant = "generic", probability = 2 }
    group:entry { item = "european_comic", count = { 1, 24 }, variant = "tintin", probability = 5 }
    group:entry { item = "european_comic", count = { 1, 24 }, variant = "asterix", probability = 4 }
    group:entry { item = "european_comic", count = { 1, 48 }, variant = "lucky_luke", probability = 3 }
    group:entry { item = "european_comic", count = { 1, 16 }, variant = "smurfs", probability = 3 }
    group:entry { item = "european_comic", count = { 1, 16 }, variant = "dungeon", probability = 1 }
    group:entry { item = "european_comic", count = { 1, 8 }, variant = "metabarons", probability = 1 }
    content.add(group)
end
