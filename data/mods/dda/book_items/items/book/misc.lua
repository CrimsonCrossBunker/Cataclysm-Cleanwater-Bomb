local content = require("ccb").content

do
    local book = content.Item {
        id = "ZSG",
        name = content.plural_text("Zombie Survival Guide", "copies of Zombie Survival Guide"),
        description = content.text("While this seems like it would be very useful in this situation, the sheer amount of misinformation present makes it practically useless."),
        mass_milligrams = 227000,
        volume_ml = 1000,
        price_cents = 1290,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "green",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1080,
        fun = 2,
        chapters = 28,
        scannable = true,
    }
    content.add(book)
end

do
    -- ooh, military records, probably Classified!
    local book = content.Item {
        id = "black_box_transcript",
        name = content.plural_text("black box transcript", "black box transcripts"),
        description = content.text("A full flight log for a military aircraft.  Nothing of interest stands out."),
        mass_milligrams = 566000,
        volume_ml = 1250,
        price_cents = 5000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "record_patient",
        color = "light_green",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "commune_prospectus",
        name = content.plural_text("Ranch Prospectus", "Ranch Prospectus"),
        description = content.text("A short paper of the economic viability of constructing an agricultural outpost."),
        mass_milligrams = 1000,
        volume_ml = 250,
        price_cents = 3000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "light_cyan",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "essay_book",
        name = content.plural_text("book of essays", "books of essays"),
        description = content.text("A collection of essays by various authors from around the world, including works by Churchill, Mailer, Eco, and Voltaire."),
        mass_milligrams = 700000,
        volume_ml = 750,
        price_cents = 1250,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 10,
        read_time_turns = 1560,
        fun = 3,
        chapters = 40,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "guidebook",
        name = content.plural_text("The Hitchhiker's Guide to the Cataclysm", "copies of The Hitchhiker's Guide to the Cataclysm"),
        description = content.text("Inscribed on the cover in large, friendly letters, is the message \"Don't Panic\"."),
        mass_milligrams = 1178000,
        volume_ml = 1000,
        price_cents = 88200,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "green",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 2)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 3,
        read_time_turns = 60,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_gaming",
        name = content.plural_text("Computer Gaming", "issues of Computer Gaming"),
        description = content.text("Reviews of recently released computer games and previews of upcoming titles."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 300,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 480,
        fun = 2,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    -- ie The Economist
    local book = content.Item {
        id = "book_nonf_zine_news_anlyst",
        name = content.plural_text("The Analyst", "issues of The Analyst"),
        description = content.text("This news magazine has been described as \"a kind of Reader's Digest for America's corporate elite.\"  These concerns are, of course, behind us now."),
        copy_from = "book_nonf_zine_news_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_porn",
        name = content.plural_text("Playboy", "issues of Playboy"),
        description = content.text("You can read it for the articles.  Or not."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 400,
        price_postapoc_cents = 250,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 600,
        fun = 1,
        chapters = 4,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "news_regional",
        name = content.plural_text("Rural Digest-Examiner", "issues of Rural Digest-Examiner"),
        description = content.text("A newsweekly covering regional events.  There is an article on the winter's snowstorms and several letters to the editor concerning the community response."),
        mass_milligrams = 80000,
        volume_ml = 250,
        price_cents = 350,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "pink",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 300,
        fun = 1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_adventure",
        name = content.plural_text("adventure novel", "adventure novels"),
        description = content.text("The stirring tale of a race against time, in search of a lost city located in the heart of the African continent."),
        copy_from = "book_fict_soft_collection_tpl",
        price_cents = 850,
        price_postapoc_cents = 50,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 3,
        chapters = 16,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_buddy",
        name = content.plural_text("buddy novel", "buddy novels"),
        description = content.text("A gripping tale of two friends struggling to survive on the streets of New York City."),
        copy_from = "book_fict_soft_collection_tpl",
        mass_milligrams = 244000,
        volume_ml = 500,
        price_cents = 650,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 2,
        chapters = 16,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_crime_murdergrape",
        name = content.plural_text("Murdered by the Grapevine", "copies of Murdered by the Grapevine"),
        description = content.text("This cheap paperback tells the story of a mob boss done in by mere suspicion.  She never breaks a confidence, never rats out an accomplice, and never turns her back on a friend.  Nonetheless her grip on the reigns of the underworld is eroded by rumor and paranoia."),
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_drama",
        name = content.plural_text("drama novel", "drama novels"),
        description = content.text("A real book for real adults."),
        copy_from = "book_fict_soft_collection_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1500,
        fun = 3,
        chapters = 28,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_erotic",
        name = content.plural_text("erotic novel", "erotic novels"),
        description = content.text("A hackneyed fictional narrative concealing low-grade literary smut."),
        copy_from = "book_fict_soft_collection_tpl",
        mass_milligrams = 200000,
        volume_ml = 500,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1080,
        fun = 2,
        chapters = 28,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_experimental",
        name = content.plural_text("experimental novel", "experimental novels"),
        description = content.text("A bizarre play about the philosophy of existential absurdity.  Or maybe it's about two guys waiting for their friend to show up.  It's confusing."),
        copy_from = "book_fict_soft_collection_tpl",
        mass_milligrams = 142000,
        volume_ml = 500,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 2,
        chapters = 20,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_fantasy",
        name = content.plural_text("fantasy novel", "fantasy novels"),
        description = content.text("Basic sword & sorcery."),
        copy_from = "book_fict_soft_collection_tpl",
        mass_milligrams = 227000,
        volume_ml = 1000,
        looks_like = "dnd_handbook",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 3,
        chapters = 28,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_horror",
        name = content.plural_text("horror novel", "horror novels"),
        description = content.text("Maybe not the best reading material considering the situation."),
        copy_from = "book_fict_soft_collection_tpl",
        mass_milligrams = 227000,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1080,
        fun = 1,
        chapters = 28,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_mystery",
        name = content.plural_text("mystery novel", "mystery novels"),
        description = content.text("A detective investigates an unusual murder in a secluded location."),
        copy_from = "book_fict_soft_collection_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1080,
        fun = 3,
        chapters = 28,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_road",
        name = content.plural_text("road novel", "road novels"),
        description = content.text("A tale about a group of friends who wander the USA in the 1960s against a backdrop of jazz, poetry and drug use."),
        copy_from = "book_fict_soft_collection_tpl",
        mass_milligrams = 244000,
        volume_ml = 500,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 3,
        chapters = 16,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_gore",
        name = content.plural_text("Gore Longitude", "copies of Gore Longitude"),
        description = content.text("Award-winning author Cornac McCaffordy weaves a chilling tale of horror and strife, following the compellingly lucrative, seductively dangerous bounty hunting and scalping trade across the western frontier."),
        copy_from = "book_fict_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1500,
        fun = 3,
        chapters = 24,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_romance",
        name = content.plural_text("romance novel", "romance novels"),
        description = content.text("Drama and mild smut."),
        copy_from = "book_fict_soft_collection_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_dd",
        name = content.plural_text("Dubliner's Debutante", "copies of Dubliner's Debutante"),
        description = content.text("His love songs were only for me, but I preferred the banjo over bagpipes.  How could I ever love a kilted yankee of foreign breeding?"),
        copy_from = "paperback_romance_spb",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_envyh",
        name = content.plural_text("Envying Heaven", "copies of Envying Heaven"),
        description = content.text("When her fiancee names a star for her Wanda begins to wonder if an astronomer's wife can ever compete with the allure of the cosmos."),
        copy_from = "paperback_romance_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_grue",
        name = content.plural_text("Tall, Dark, and Gruesome", "copies of Tall, Dark, and Gruesome"),
        description = content.text("Fatima's obsession with the dead threatens to consume her when she falls in love with a restless ghost.  In this provocative romp celebrated author Kea Dekker gently lifts the thin veil separating cold bodies from warm."),
        copy_from = "paperback_romance_lnl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_rider",
        name = content.plural_text("Along Came a Rider", "copies of Along Came a Rider"),
        description = content.text("When Beth's career as a pro steeplechase jockey threatens to divide her from her lover, Beth has to act fast.  Will she ever find a man that can keep up with her racing heart?"),
        copy_from = "paperback_romance_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_rogue",
        name = content.plural_text("Rogue's Virtue", "copies of Rogue's Virtue"),
        description = content.text("Can Victoria reform the fugitive from justice who wooed her with false pretenses and true passion?"),
        copy_from = "paperback_romance_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_secret",
        name = content.plural_text("The Death of My Secret Life", "copies of The Death of My Secret Life"),
        description = content.text("Makeda comes out to her family, but she's still got plenty of skeletons in her closet.  Best selling authoress Kea Dekker breaks all the rules in this macabre story of love and lies."),
        copy_from = "paperback_romance_lnl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_satire_hgod",
        name = content.plural_text("The House of God", "copies of The House of God"),
        description = content.text("Set in a lightly disguised Boston hospital of high repute, Samuel Shem's novel dives deep into the agony of absurdity."),
        copy_from = "book_fict_soft_satire_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_satire_dust",
        name = content.plural_text("A Handful of Dust", "copies of A Handful of Dust"),
        description = content.text("Laced with cynicism, Evelyn Waugh's \"A Handful of Dust\" satirizes a stratum of characters who have wealth, but lack any other credentials."),
        copy_from = "book_fict_soft_satire_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_spy",
        name = content.plural_text("spy novel", "spy novels"),
        description = content.text("A tale of intrigue and espionage among Nazis, no, Commies, no, Iraqis!"),
        copy_from = "book_fict_soft_collection_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1080,
        fun = 3,
        chapters = 20,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_spy_comefly",
        name = content.plural_text("Come Fly the Treacherous Skies", "copies of Come Fly the Treacherous Skies"),
        description = content.text("This tale of intrigue betrays the story of a debonair mechanic driven by a lust for revenge.  As she uncovers a sophisticated network of amateur pilots turned smugglers, the good guys and the bad guys begin to all look the same."),
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_spy_rocketsci",
        name = content.plural_text("Lies, Damn Lies, and Rocket Science", "copies of Lies, Damn Lies, and Rocket Science"),
        description = content.text("This spy novel tells the story of a jaded rocket scientist looking for redemption in all the wrong places.  As selling state secrets becomes her career, she learns there isn't much of difference between a double-agent and a triple-agent."),
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_swash",
        name = content.plural_text("swashbuckling novel", "swashbuckling novels"),
        description = content.text("An exciting seventeenth century tale of how an enslaved Irish doctor and his comrades-in-chains escape and become heroic pirates of the Robin Hood variety."),
        mass_milligrams = 582000,
        volume_ml = 750,
        copy_from = "book_fict_soft_collection_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1200,
        fun = 4,
        chapters = 28,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_swash_buccaneer",
        name = content.plural_text("The Code of the Buccaneer", "copies of The Buccaneer"),
        description = content.text("The cover of this paperback pirate story shows a shirtless man and a near shirtless woman.  Clearly it is not a dress code."),
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_thriller",
        name = content.plural_text("thriller novel", "thriller novels"),
        description = content.text("A suspenseful tale of betrayal and revenge."),
        copy_from = "book_fict_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1080,
        fun = 3,
        chapters = 20,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_tragedy",
        name = content.plural_text("tragedy novel", "tragedy novels"),
        description = content.text("The story of two young lovers whose feuding families threaten to keep them apart."),
        copy_from = "book_fict_soft_tpl",
        mass_milligrams = 263000,
        volume_ml = 1000,
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1080,
        fun = 2,
        chapters = 28,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_western",
        name = content.plural_text("western novel", "western novels"),
        description = content.text("The classic tale of a gunfighting stranger who comes to a small settlement and is hired to help the townsfolk defend themselves from a band of marauding outlaws."),
        copy_from = "book_fict_soft_collection_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1200,
        fun = 4,
        chapters = 28,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_bart",
        name = content.plural_text("Stinky Bart Puts on Starch", "copies of Stinky Bart Puts on Starch"),
        description = content.text("A local bandit, driven by sadistic impulses, begins offering unlicensed dentistry to brave frontiersmen with few options and fewer teeth."),
        copy_from = "paperback_western_em",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_calico",
        name = content.plural_text("Irons at Calico Queen Annex", "copies of Irons at Calico Queen Annex"),
        description = content.text("The establishment of a telegraph line into the recently named town of Calico Queen threatens to bring with it the long arm of the law.  A trio of enterprising gunfighters hatches a plan to keep Calico Queen wild by looting the supply wagons."),
        copy_from = "paperback_western_em",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "phonebook",
        name = content.plural_text("phone book", "phone books"),
        description = content.text("This hefty volume contains the telephone numbers of individuals, businesses, and utilities.  Pretty useless during the apocalypse and all."),
        mass_milligrams = 854000,
        volume_ml = 2500,
        price_cents = 800,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "textbook_firstaid",
        color = "yellow",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 2)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 60,
        fun = -5,
        chapters = 200,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "photo_album",
        name = content.plural_text("photo album", "photo albums"),
        description = content.text("A leather album full of photos of somebody's family.  You don't know any of the people in them, but seeing these pictures still makes you think of happier times."),
        mass_milligrams = 180000,
        volume_ml = 250,
        price_cents = 3000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "record_patient",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:flag("INSPIRATIONAL")
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 600,
        fun = 1,
        chapters = 4,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "plays_book",
        name = content.plural_text("book of plays", "books of plays"),
        description = content.text("A collection of plays by various authors from around the world, including scripts by Wilde, Beckett, Checkov, and Shakespeare."),
        mass_milligrams = 700000,
        volume_ml = 750,
        price_cents = 1150,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 1080,
        fun = 2,
        chapters = 36,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "poetry_book",
        name = content.plural_text("book of poetry", "books of poetry"),
        description = content.text("A collection of poetry by various authors from around the world, including writings by Dickinson, Goethe, Thoreau, and Yeats."),
        mass_milligrams = 400000,
        volume_ml = 500,
        price_cents = 1050,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 1080,
        fun = 2,
        chapters = 36,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "priest_diary",
        name = content.plural_text("priest's diary", "priests' diaries"),
        description = content.text("A small book filled with journal entries in Latin.  You can read Latin, right?"),
        mass_milligrams = 340000,
        volume_ml = 750,
        price_cents = 1500,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "pocket_firstaid",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:flag("INSPIRATIONAL")
    book:melee_damage("bash", 3)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 15,
        read_time_turns = 1800,
        fun = 1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "record_accounting",
        name = content.plural_text("corporate accounting ledger", "corporate accounting ledgers"),
        description = content.text("If you knew what to look for, something might stand out…"),
        mass_milligrams = 566000,
        volume_ml = 1250,
        price_cents = 2000,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "record_patient",
        color = "light_green",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:melee_damage("bash", 5)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 10,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "record_patient",
        name = content.plural_text("patient treatment records", "patient treatment records"),
        description = content.text("A massive stack of medical records that contain every gory detail."),
        mass_milligrams = 680000,
        volume_ml = 1500,
        price_cents = 500,
        price_postapoc_cents = 50,
        symbol = "?",
        color = "light_green",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 6)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "record_weather",
        name = content.plural_text("national weather transcripts", "national weather transcripts"),
        description = content.text("Old weather records that are about as interesting as a rock."),
        mass_milligrams = 454000,
        volume_ml = 1750,
        price_cents = 500,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "record_patient",
        color = "light_green",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 7)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 1800,
        fun = -1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "story_book",
        name = content.plural_text("big book of short stories", "big books of short stories"),
        description = content.text("This humongous volume contains a vast collection of short stories by different authors, spanning a wide variety of topics and genres."),
        mass_milligrams = 1200000,
        volume_ml = 1000,
        price_cents = 1400,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "radio_book",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 2880,
        fun = 5,
        chapters = 28,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "tall_tales",
        name = content.plural_text("book of tall tales", "books of tall tales"),
        description = content.text("An entertaining collection of early American folklore, featuring tales of larger than life individuals and their amazing adventures."),
        mass_milligrams = 360000,
        volume_ml = 750,
        price_cents = 1050,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "light_blue",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1080,
        fun = 3,
        chapters = 24,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "visions_solitude",
        name = content.plural_text("Visions in Solitude", "copies of Visions in Solitude"),
        description = content.text("A small book detailing 'visions' a prisoner had on death row."),
        mass_milligrams = 227000,
        volume_ml = 750,
        price_cents = 2900,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "light_cyan",
    }
    book:material("paper", 1)
    book:flag("INSPIRATIONAL")
    book:melee_damage("bash", 3)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1800,
        fun = 2,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "gun_manual",
        name = content.plural_text("firearm safety and instruction manual", "firearm safety and instruction manual"),
        description = content.text("A booklet full of a bunch of information about a firearm, including how one is operated, how to take apart and clean the gun, and myriad of safety precautions."),
        mass_milligrams = 72000,
        volume_ml = 60,
        price_cents = 0,
        price_postapoc_cents = 100,
        symbol = "?",
        looks_like = "mag_guns",
        color = "light_gray",
    }
    book:material("paper", 1)
    book:melee_damage("bash", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 600,
        fun = 0,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end
