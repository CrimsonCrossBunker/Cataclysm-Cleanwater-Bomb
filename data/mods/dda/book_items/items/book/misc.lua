local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "ZSG",
        name = ccb.content.plural_text("Zombie Survival Guide", "copies of Zombie Survival Guide"),
        description = ccb.content.text("While this seems like it would be very useful in this situation, the sheer amount of misinformation present makes it practically useless."),
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
        name = ccb.content.plural_text("black box transcript", "black box transcripts"),
        description = ccb.content.text("A full flight log for a military aircraft.  Nothing of interest stands out."),
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
        name = ccb.content.plural_text("Ranch Prospectus", "Ranch Prospectus"),
        description = ccb.content.text("A short paper of the economic viability of constructing an agricultural outpost."),
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
        name = ccb.content.plural_text("book of essays", "books of essays"),
        description = ccb.content.text("A collection of essays by various authors from around the world, including works by Churchill, Mailer, Eco, and Voltaire."),
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
        name = ccb.content.plural_text("The Hitchhiker's Guide to the Cataclysm", "copies of The Hitchhiker's Guide to the Cataclysm"),
        description = ccb.content.text("Inscribed on the cover in large, friendly letters, is the message \"Don't Panic\"."),
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
        name = ccb.content.plural_text("Computer Gaming", "issues of Computer Gaming"),
        description = ccb.content.text("Reviews of recently released computer games and previews of upcoming titles."),
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
        name = ccb.content.plural_text("The Analyst", "issues of The Analyst"),
        description = ccb.content.text("This news magazine has been described as \"a kind of Reader's Digest for America's corporate elite.\"  These concerns are, of course, behind us now."),
        copy_from = "book_nonf_zine_news_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_porn",
        name = ccb.content.plural_text("Playboy", "issues of Playboy"),
        description = ccb.content.text("You can read it for the articles.  Or not."),
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
        name = ccb.content.plural_text("Rural Digest-Examiner", "issues of Rural Digest-Examiner"),
        description = ccb.content.text("A newsweekly covering regional events.  There is an article on the winter's snowstorms and several letters to the editor concerning the community response."),
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
        name = ccb.content.plural_text("adventure novel", "adventure novels"),
        description = ccb.content.text("The stirring tale of a race against time, in search of a lost city located in the heart of the African continent."),
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
        name = ccb.content.plural_text("buddy novel", "buddy novels"),
        description = ccb.content.text("A gripping tale of two friends struggling to survive on the streets of New York City."),
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
        name = ccb.content.plural_text("Murdered by the Grapevine", "copies of Murdered by the Grapevine"),
        description = ccb.content.text("This cheap paperback tells the story of a mob boss done in by mere suspicion.  She never breaks a confidence, never rats out an accomplice, and never turns her back on a friend.  Nonetheless her grip on the reigns of the underworld is eroded by rumor and paranoia."),
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_drama",
        name = ccb.content.plural_text("drama novel", "drama novels"),
        description = ccb.content.text("A real book for real adults."),
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
        name = ccb.content.plural_text("erotic novel", "erotic novels"),
        description = ccb.content.text("A hackneyed fictional narrative concealing low-grade literary smut."),
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
        name = ccb.content.plural_text("experimental novel", "experimental novels"),
        description = ccb.content.text("A bizarre play about the philosophy of existential absurdity.  Or maybe it's about two guys waiting for their friend to show up.  It's confusing."),
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
        name = ccb.content.plural_text("fantasy novel", "fantasy novels"),
        description = ccb.content.text("Basic sword & sorcery."),
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
        name = ccb.content.plural_text("horror novel", "horror novels"),
        description = ccb.content.text("Maybe not the best reading material considering the situation."),
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
        name = ccb.content.plural_text("mystery novel", "mystery novels"),
        description = ccb.content.text("A detective investigates an unusual murder in a secluded location."),
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
        name = ccb.content.plural_text("road novel", "road novels"),
        description = ccb.content.text("A tale about a group of friends who wander the USA in the 1960s against a backdrop of jazz, poetry and drug use."),
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
        name = ccb.content.plural_text("Gore Longitude", "copies of Gore Longitude"),
        description = ccb.content.text("Award-winning author Cornac McCaffordy weaves a chilling tale of horror and strife, following the compellingly lucrative, seductively dangerous bounty hunting and scalping trade across the western frontier."),
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
        name = ccb.content.plural_text("romance novel", "romance novels"),
        description = ccb.content.text("Drama and mild smut."),
        copy_from = "book_fict_soft_collection_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_dd",
        name = ccb.content.plural_text("Dubliner's Debutante", "copies of Dubliner's Debutante"),
        description = ccb.content.text("His love songs were only for me, but I preferred the banjo over bagpipes.  How could I ever love a kilted yankee of foreign breeding?"),
        copy_from = "paperback_romance_spb",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_envyh",
        name = ccb.content.plural_text("Envying Heaven", "copies of Envying Heaven"),
        description = ccb.content.text("When her fiancee names a star for her Wanda begins to wonder if an astronomer's wife can ever compete with the allure of the cosmos."),
        copy_from = "paperback_romance_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_grue",
        name = ccb.content.plural_text("Tall, Dark, and Gruesome", "copies of Tall, Dark, and Gruesome"),
        description = ccb.content.text("Fatima's obsession with the dead threatens to consume her when she falls in love with a restless ghost.  In this provocative romp celebrated author Kea Dekker gently lifts the thin veil separating cold bodies from warm."),
        copy_from = "paperback_romance_lnl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_rider",
        name = ccb.content.plural_text("Along Came a Rider", "copies of Along Came a Rider"),
        description = ccb.content.text("When Beth's career as a pro steeplechase jockey threatens to divide her from her lover, Beth has to act fast.  Will she ever find a man that can keep up with her racing heart?"),
        copy_from = "paperback_romance_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_rogue",
        name = ccb.content.plural_text("Rogue's Virtue", "copies of Rogue's Virtue"),
        description = ccb.content.text("Can Victoria reform the fugitive from justice who wooed her with false pretenses and true passion?"),
        copy_from = "paperback_romance_vanilla",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_secret",
        name = ccb.content.plural_text("The Death of My Secret Life", "copies of The Death of My Secret Life"),
        description = ccb.content.text("Makeda comes out to her family, but she's still got plenty of skeletons in her closet.  Best selling authoress Kea Dekker breaks all the rules in this macabre story of love and lies."),
        copy_from = "paperback_romance_lnl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_satire_hgod",
        name = ccb.content.plural_text("The House of God", "copies of The House of God"),
        description = ccb.content.text("Set in a lightly disguised Boston hospital of high repute, Samuel Shem's novel dives deep into the agony of absurdity."),
        copy_from = "book_fict_soft_satire_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_satire_dust",
        name = ccb.content.plural_text("A Handful of Dust", "copies of A Handful of Dust"),
        description = ccb.content.text("Laced with cynicism, Evelyn Waugh's \"A Handful of Dust\" satirizes a stratum of characters who have wealth, but lack any other credentials."),
        copy_from = "book_fict_soft_satire_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_spy",
        name = ccb.content.plural_text("spy novel", "spy novels"),
        description = ccb.content.text("A tale of intrigue and espionage among Nazis, no, Commies, no, Iraqis!"),
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
        name = ccb.content.plural_text("Come Fly the Treacherous Skies", "copies of Come Fly the Treacherous Skies"),
        description = ccb.content.text("This tale of intrigue betrays the story of a debonair mechanic driven by a lust for revenge.  As she uncovers a sophisticated network of amateur pilots turned smugglers, the good guys and the bad guys begin to all look the same."),
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_spy_rocketsci",
        name = ccb.content.plural_text("Lies, Damn Lies, and Rocket Science", "copies of Lies, Damn Lies, and Rocket Science"),
        description = ccb.content.text("This spy novel tells the story of a jaded rocket scientist looking for redemption in all the wrong places.  As selling state secrets becomes her career, she learns there isn't much of difference between a double-agent and a triple-agent."),
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_swash",
        name = ccb.content.plural_text("swashbuckling novel", "swashbuckling novels"),
        description = ccb.content.text("An exciting seventeenth century tale of how an enslaved Irish doctor and his comrades-in-chains escape and become heroic pirates of the Robin Hood variety."),
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
        name = ccb.content.plural_text("The Code of the Buccaneer", "copies of The Buccaneer"),
        description = ccb.content.text("The cover of this paperback pirate story shows a shirtless man and a near shirtless woman.  Clearly it is not a dress code."),
        copy_from = "book_fict_soft_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_thriller",
        name = ccb.content.plural_text("thriller novel", "thriller novels"),
        description = ccb.content.text("A suspenseful tale of betrayal and revenge."),
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
        name = ccb.content.plural_text("tragedy novel", "tragedy novels"),
        description = ccb.content.text("The story of two young lovers whose feuding families threaten to keep them apart."),
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
        name = ccb.content.plural_text("western novel", "western novels"),
        description = ccb.content.text("The classic tale of a gunfighting stranger who comes to a small settlement and is hired to help the townsfolk defend themselves from a band of marauding outlaws."),
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
        name = ccb.content.plural_text("Stinky Bart Puts on Starch", "copies of Stinky Bart Puts on Starch"),
        description = ccb.content.text("A local bandit, driven by sadistic impulses, begins offering unlicensed dentistry to brave frontiersmen with few options and fewer teeth."),
        copy_from = "paperback_western_em",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_calico",
        name = ccb.content.plural_text("Irons at Calico Queen Annex", "copies of Irons at Calico Queen Annex"),
        description = ccb.content.text("The establishment of a telegraph line into the recently named town of Calico Queen threatens to bring with it the long arm of the law.  A trio of enterprising gunfighters hatches a plan to keep Calico Queen wild by looting the supply wagons."),
        copy_from = "paperback_western_em",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "phonebook",
        name = ccb.content.plural_text("phone book", "phone books"),
        description = ccb.content.text("This hefty volume contains the telephone numbers of individuals, businesses, and utilities.  Pretty useless during the apocalypse and all."),
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
        name = ccb.content.plural_text("photo album", "photo albums"),
        description = ccb.content.text("A leather album full of photos of somebody's family.  You don't know any of the people in them, but seeing these pictures still makes you think of happier times."),
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
        name = ccb.content.plural_text("book of plays", "books of plays"),
        description = ccb.content.text("A collection of plays by various authors from around the world, including scripts by Wilde, Beckett, Checkov, and Shakespeare."),
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
        name = ccb.content.plural_text("book of poetry", "books of poetry"),
        description = ccb.content.text("A collection of poetry by various authors from around the world, including writings by Dickinson, Goethe, Thoreau, and Yeats."),
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
        name = ccb.content.plural_text("priest's diary", "priests' diaries"),
        description = ccb.content.text("A small book filled with journal entries in Latin.  You can read Latin, right?"),
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
        name = ccb.content.plural_text("corporate accounting ledger", "corporate accounting ledgers"),
        description = ccb.content.text("If you knew what to look for, something might stand out…"),
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
        name = ccb.content.plural_text("patient treatment records", "patient treatment records"),
        description = ccb.content.text("A massive stack of medical records that contain every gory detail."),
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
        name = ccb.content.plural_text("national weather transcripts", "national weather transcripts"),
        description = ccb.content.text("Old weather records that are about as interesting as a rock."),
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
        name = ccb.content.plural_text("big book of short stories", "big books of short stories"),
        description = ccb.content.text("This humongous volume contains a vast collection of short stories by different authors, spanning a wide variety of topics and genres."),
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
        name = ccb.content.plural_text("book of tall tales", "books of tall tales"),
        description = ccb.content.text("An entertaining collection of early American folklore, featuring tales of larger than life individuals and their amazing adventures."),
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
        name = ccb.content.plural_text("Visions in Solitude", "copies of Visions in Solitude"),
        description = ccb.content.text("A small book detailing 'visions' a prisoner had on death row."),
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
        name = ccb.content.plural_text("firearm safety and instruction manual", "firearm safety and instruction manual"),
        description = ccb.content.text("A booklet full of a bunch of information about a firearm, including how one is operated, how to take apart and clean the gun, and myriad of safety precautions."),
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

do
    local book = content.Item {
        id = "decoy_elfa",
        name = ccb.content.plural_text("standpipe maintenance log", "standpipe maintenance logs"),
        description = ccb.content.text("This binder details the scheduled maintenance for several plumbing systems throughout the facility."),
        mass_milligrams = 400000,
        volume_ml = 750,
        price_cents = 400,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "record_patient",
        color = "light_green",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("plastic", 1)
    book:book {
        required_level = 1,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 2700,
        fun = -2,
        chapters = 0,
        scannable = true,
        skill = "mechanics",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_comic",
        name = ccb.content.plural_text("comic book", "comic books"),
        description = ccb.content.text("A super-hero comic."),
        mass_milligrams = 60000,
        volume_ml = 250,
        price_cents = 300,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "mag_glam",
        color = "light_cyan",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 420,
        fun = 2,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "mag_news",
        name = ccb.content.plural_text("TIME magazine", "TIME magazines"),
        description = ccb.content.text("Current events concerning a bunch of people who're all (un)dead now."),
        copy_from = "book_nonf_zine_news_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_crime",
        name = ccb.content.plural_text("crime novel", "crime novels"),
        description = ccb.content.text("After their diamond heist goes wrong, the surviving criminals begin to suspect that one of them is a police informant."),
        copy_from = "book_fict_soft_collection_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 3,
        chapters = 24,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_crime2",
        name = ccb.content.plural_text("crime novel", "crime novels"),
        description = ccb.content.text("A story about three people in the fictional city of Los Santos: a gangster, an upper-class man, and a psychopath.  They eventually band together to pull off the biggest heist in the city's history."),
        copy_from = "novel_crime",
        looks_like = "novel_crime",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1080,
        fun = 3,
        chapters = 21,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_crime_midnight",
        name = ccb.content.plural_text("Midnight Cop", "copies of Midnight Cop"),
        description = ccb.content.text("In this bare-knuckled potboiler, a ruthless police detective schemes to shut down local crime lords by pitting them against each other.  When long-simmering resentments finally flare the city learns why they call it \"the dead of night.\""),
        copy_from = "book_fict_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 1440,
        fun = 2,
        chapters = 8,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_circuses",
        name = ccb.content.plural_text("Love and Circuses", "copies of Love and Circuses"),
        description = ccb.content.text("The passionate saga of two Boston politicians fiercely battling each other for the mayor's office, and for Lydia's hand in marriage."),
        mass_milligrams = 311000,
        copy_from = "paperback_romance_spb",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 660,
        fun = 2,
        chapters = 10,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_cloven",
        name = ccb.content.plural_text("Cloven Kisses", "copies of Cloven Kisses"),
        description = ccb.content.text("When the devil falls in love with a warlock, his proposal must be infernally wicked.  Will hooves, horns, and the scent of sulfur condemn love's flames to hellfire?"),
        copy_from = "paperback_romance_lnl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 900,
        fun = 2,
        chapters = 14,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_conq",
        name = ccb.content.plural_text("Conquer Me Sweetly", "copies of Conquer Me Sweetly"),
        description = ccb.content.text("Sweet Providence Books is delighted to offer you this romantic tale of delicious dalliances and daring delights."),
        copy_from = "paperback_romance_spb",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 660,
        fun = 2,
        chapters = 7,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "paperback_romance_diodes",
        name = ccb.content.plural_text("Blood Diodes", "copies of Blood Diodes"),
        description = ccb.content.text("He is an automaton, she is a reformed vampire, can love find a way?  In this edgy romance by acclaimed author Kea Dekker, heartbreak is just the beginning."),
        copy_from = "paperback_romance_lnl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 900,
        fun = 2,
        chapters = 17,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9781568364278
    -- 3 (2+1)
    local book = content.Item {
        id = "novel_samurai",
        name = ccb.content.plural_text("samurai novel", "samurai novels"),
        description = ccb.content.text("The classic tale of a wandering swordsman who comes to a small settlement and is hired to help the townsfolk defend themselves from a band of marauding outlaws.  This hardback is quite hefty."),
        mass_milligrams = 1090000,
        volume_ml = 1367,
        longest_side_mm = 220,
        price_cents = 3499,
        copy_from = "book_fict_hard_tpl",
    }
    book:clear_melee_damage()
    book:melee_damage("bash", 3)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 1200,
        fun = 2,
        chapters = 28,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_satire",
        name = ccb.content.plural_text("satire novel", "satire novels"),
        description = ccb.content.text("A political satire of the pre-apocalypse world.  Looking back on it from this side of Armageddon makes it seem all the more ridiculous."),
        mass_milligrams = 520000,
        copy_from = "book_fict_soft_satire_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 2,
        chapters = 23,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_satire_catch",
        name = ccb.content.plural_text("Catch-22", "copies of Catch-22"),
        description = ccb.content.text("There is a short informational forward in this paperback edition of Catch-22.  Apparently the original title for Joseph Heller's excruciatingly brilliant war satire was \"Catch-11.\""),
        mass_milligrams = 480000,
        copy_from = "book_fict_soft_satire_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 2,
        chapters = 42,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9780802130112
    local book = content.Item {
        id = "book_fict_soft_satire_mandm",
        name = ccb.content.plural_text("The Master and Margarita", "copies of Master and Margarita"),
        description = ccb.content.text("Featuring a cast that includes Satan, Pontius Pilate, Jesus Christ, vampires, a talking cat, and the literary elite of Moscow, this novel by Mikhail Bulgakov explores philosophical issues on the nature of good and evil."),
        mass_milligrams = 441000,
        volume_ml = 719,
        longest_side_mm = 210,
        copy_from = "book_fict_soft_satire_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 1200,
        fun = 2,
        chapters = 32,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_satire_cats",
        name = ccb.content.plural_text("Cat's Cradle", "copies of Cat's Cradle"),
        description = ccb.content.text("A paperback edition of Kurt Vonnegut's fourth novel, in which the threat of nuclear destruction isn't much of an influence on human nature."),
        mass_milligrams = 360000,
        copy_from = "book_fict_soft_satire_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 60,
        fun = 1,
        chapters = 127,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_swash_blkfreight",
        name = ccb.content.plural_text("The Black Freighter", "copies of The Black Freighter"),
        description = ccb.content.text("Who watches the watchmen?  Pirate Jenny, that's who!  This swashbuckling adventure novel will make you feel swell."),
        copy_from = "book_fict_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 900,
        fun = 2,
        chapters = 8,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_swash_searovers",
        name = ccb.content.plural_text("Captain Gosnold and the Sea Rovers of Buzzards Bay", "copies of The Sea Rovers"),
        description = ccb.content.text("This lengthy paperback novel describes the ocean exploits of Captain Gosnold.  The British consider him an outlaw, but in America he is a patriot."),
        mass_milligrams = 611000,
        price_cents = 1049,
        copy_from = "book_fict_soft_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 5,
        read_time_turns = 720,
        fun = 2,
        chapters = 24,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_war",
        name = ccb.content.plural_text("war novel", "war novels"),
        description = ccb.content.text("A thrilling narrative of survival in a prisoner of war camp during the Second World War, filled with riveting subplots about rat farming and dysentery."),
        mass_milligrams = 686000,
        price_postapoc_cents = 50,
        copy_from = "book_fict_soft_collection_tpl",
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
        id = "novel_war2",
        name = ccb.content.plural_text("war novel", "war novels"),
        description = ccb.content.text("A story about a Bosnian citizen who goes through many hardships and near death during the breakup of Yugoslavia."),
        copy_from = "novel_war",
        looks_like = "novel_war",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 960,
        fun = 3,
        chapters = 24,
        scannable = true,
        generic = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_atwixt",
        name = ccb.content.plural_text("Atwixt a Brace of Cacti", "copies of Atwixt a Brace of Cacti"),
        description = ccb.content.text("A grizzled clodhopper interviews a mess of rangehands, flummoxing longhorns and tenderfoot alike in a flusteration of jawing."),
        price_cents = 1199,
        copy_from = "paperback_western_em",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 900,
        fun = 2,
        chapters = 16,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_beans",
        name = ccb.content.plural_text("Six Beans in the Wheel", "copies of Six Beans in the Wheel"),
        description = ccb.content.text("The safety is off in this gun slinging tale of revenge and redemption by acclaimed author El Amor."),
        copy_from = "paperback_western_em",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 14,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_riot",
        name = ccb.content.plural_text("Riot on the Range", "copies of Riot on the Range"),
        description = ccb.content.text("Best selling author El Amor paints a visceral study in red with his latest western saga: Riot on the Range."),
        copy_from = "paperback_western_em",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 15,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_vaq",
        name = ccb.content.plural_text("Vaquero Sun", "copies of Vaquero Sun"),
        description = ccb.content.text("Western author El Amor relates the story of a dispossessed young man inspired by a heat stroke delusion to pursue justice against an evil land baron."),
        copy_from = "paperback_western_em",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_west_vride",
        name = ccb.content.plural_text("The Vendetta Riders", "copies of The Vendetta Riders"),
        description = ccb.content.text("A wild young man, fast on the draw, who thinks he has nothing to lose, falls in with a group of gun runners."),
        copy_from = "paperback_western_em",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 900,
        fun = 2,
        chapters = 15,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "classic_literature",
        name = ccb.content.plural_text("book of classic literature", "books of classic literature"),
        description = ccb.content.text("A book of classic literature, timeless and enjoyable but a bit dense to read."),
        mass_milligrams = 350000,
        volume_ml = 750,
        price_cents = 2000,
        price_postapoc_cents = 50,
        looks_like = "tall_tales",
        color = "light_blue",
        symbol = "?",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1680,
        fun = 3,
        chapters = 40,
        scannable = true,
        generic = true,
    }
    book:variants {
        {
            id = "classic1",
            name = ccb.content.plural_text("Bleak House", "copies of Bleak House"),
            description = ccb.content.text("This is a copy of Dickens' \"Bleak House\"."),
        },
        {
            id = "classic2",
            name = ccb.content.plural_text("Great Expectations", "copies of Great Expectations"),
            description = ccb.content.text("This is a copy of \"Great Expectations\" by Charles Dickens."),
        },
        {
            id = "classic3",
            name = ccb.content.plural_text("Under the Beech Trees", "copies of Under the Beech Trees"),
            description = ccb.content.text("This is a copy of William Shinderling's \"Under the Beech Trees\"."),
        },
        {
            id = "classic4",
            name = ccb.content.plural_text("Pride and Prejudice, Sense and Sensibility, and Emma", "copies of Pride and Prejudice, Sense and Sensibility, and Emma"),
            description = ccb.content.text("This is a collection of three Jane Austen novels: \"Pride and Prejudice\", \"Sense and Sensibility\", and \"Emma\"."),
        },
        {
            id = "classic5",
            name = ccb.content.plural_text("Lord of the Flies", "copies of Lord of the Flies"),
            description = ccb.content.text("This is a well-worn paperback copy of \"Lord of the Flies\"."),
        },
        {
            id = "classic6",
            name = ccb.content.plural_text("To Kill a Mockingbird", "copies of To Kill a Mockingbird"),
            description = ccb.content.text("This is a copy of \"To Kill a Mockingbird\" by Harper Lee."),
        },
        {
            id = "classic7",
            name = ccb.content.plural_text("The Great Gatsby", "copies of The Great Gatsby"),
            description = ccb.content.text("This is a copy of F. Scott Fitzgerald's \"The Great Gatsby.\""),
        },
        {
            id = "classic8",
            name = ccb.content.plural_text("He Walks", "copies of He Walks"),
            description = ccb.content.text("This is a copy of Michael Abanaderly's lesser-known work, \"He Walks\"."),
        },
        {
            id = "classic9",
            name = ccb.content.plural_text("Ray Bradbury science fiction stories", "copies of Ray Bradbury science fiction stories"),
            description = ccb.content.text("This is a collection of several vintage science fiction stories by Ray Bradbury."),
        },
        {
            id = "classic10",
            name = ccb.content.plural_text("The Adventures of Tom Sawyer", "copies of The Adventures of Tom Sawyer"),
            description = ccb.content.text("This is a copy of \"The Adventures of Tom Sawyer\" by Mark Twain."),
        },
        {
            id = "classic11",
            name = ccb.content.plural_text("Innocents Abroad", "copies of Innocents Abroad"),
            description = ccb.content.text("This is an illustrated copy of \"Innocents Abroad\" by Mark Twain."),
        },
        {
            id = "classic12",
            name = ccb.content.plural_text("Dracula", "copies of Dracula"),
            description = ccb.content.text("This is a copy of Bram Stoker's \"Dracula\", with scholarly commentary in the margins."),
        },
        {
            id = "classic13",
            name = ccb.content.plural_text("War and Peace", "copies of War and Peace"),
            description = ccb.content.text("This is a large print copy of Tolstoy's \"War and Peace\".  It might make a decent improvised weapon."),
        },
        {
            id = "classic14",
            name = ccb.content.plural_text("Dark Days Ahead", "copies of Dark Days Ahead"),
            description = ccb.content.text("This is a paperback copy of the well-known classic \"Dark Days Ahead\", by M. G. Ranade.  There are scrawled margin notes all over it, apparently the workings of a confused and feverish mind."),
        },
        {
            id = "classic15",
            name = ccb.content.plural_text("Jane Eyre", "copies of Jane Eyre"),
            description = ccb.content.text("This is a copy of \"Jane Eyre\".  The cover art is quite out of place, making it look more like a dime-store romance novel."),
        },
        {
            id = "classic16",
            name = ccb.content.plural_text("The Gunslinger", "copies of The Gunslinger"),
            description = ccb.content.text("This is a perfectly preserved hardcover copy of \"The Gunslinger\" by Stephen King, autographed by the author.  It contains a certificate of authenticity pronouncing it to be a first edition."),
        },
        {
            id = "classic17",
            name = ccb.content.plural_text("Wuthering Heights", "copies of Wuthering Heights"),
            description = ccb.content.text("This paperback copy of \"Wuthering Heights\" has a large coffee stain on the first page."),
        },
        {
            id = "classic18",
            name = ccb.content.plural_text("Lady Chatterly's Lover", "copies of Lady Chatterly's Lover"),
            description = ccb.content.text("This is a hardbound copy of \"Lady Chatterly's Lover\", by D. H. Lawrence.  It has some very explicit illustrations."),
        },
        {
            id = "classic19",
            name = ccb.content.plural_text("The Catcher in the Rye", "copies of The Catcher in the Rye"),
            description = ccb.content.text("This is a hardbound copy of \"The Catcher in the Rye.\".  It has some very nicely done illustrations."),
        },
        {
            id = "classic20",
            name = ccb.content.plural_text("Don Quixote", "copies of Don Quixote"),
            description = ccb.content.text("This is a collection of classic renaissance era stories, headlined by \"Don Quixote\"."),
        },
        {
            id = "classic21",
            name = ccb.content.plural_text("The Fellowship of the Ring", "copies of The Fellowship of the Ring"),
            description = ccb.content.text("This is a paperback copy of \"The Fellowship of the Ring\" by Tolkien."),
        },
        {
            id = "classic22",
            name = ccb.content.plural_text("The Two Towers", "copies of The Two Towers"),
            description = ccb.content.text("This is a paperback copy of \"The Two Towers\" by Tolkien."),
        },
        {
            id = "classic23",
            name = ccb.content.plural_text("The Return of the King", "copies of The Return of the King"),
            description = ccb.content.text("This is a paperback copy of \"The Return of the King\" by Tolkien."),
        },
        {
            id = "classic24",
            name = ccb.content.plural_text("The Works of George Orwell", "copies of The Works of George Orwell"),
            description = ccb.content.text("This is a hardbound collection of George Orwell's works, including \"1984\" and \"Animal Farm\" as well as many of his less infamous titles."),
        },
        {
            id = "classic25",
            name = ccb.content.plural_text("Little Women", "copies of Little Women"),
            description = ccb.content.text("This is a paperback copy of \"Little Women\" by Louisa May Alcott.  It appears to have been read a great many times."),
        },
        {
            id = "classic26",
            name = ccb.content.plural_text("Of Mice and Men", "copies of Of Mice and Men"),
            description = ccb.content.text("This is a paperback copy of \"Of Mice and Men\" by Steinbeck."),
        },
        {
            id = "classic27",
            name = ccb.content.plural_text("Run and Run Again", "copies of Run and Run Again"),
            description = ccb.content.text("This is a hefty hardcover copy of \"Run and Run Again\" by Finn Calpay.  There is a lengthy forward about the controversy around the book's release."),
        },
        {
            id = "classic28",
            name = ccb.content.plural_text("The Gates Have Opened", "copies of The Gates Have Opened"),
            description = ccb.content.text("This is a hardcover copy of \"The Gates Have Opened\" by Arianna Methusalah.  You feel like you've read this before, but can't remember where.  Something about the book fills you with unease."),
        },
        {
            id = "classic29",
            name = ccb.content.plural_text("The Count of Monte Cristo", "copies of The Count of Monte Cristo"),
            description = ccb.content.text("This is a copy of \"The Count of Monte Cristo\" by Alexandre Dumas."),
        },
        {
            id = "classic30",
            name = ccb.content.plural_text("The Secret Garden", "copies of The Secret Garden"),
            description = ccb.content.text("This is a copy of \"The Secret Garden\" by Frances Burnett."),
        },
        {
            id = "classic31",
            name = ccb.content.plural_text("Lieutenant Hornblower", "copies of Lieutenant Hornblower"),
            description = ccb.content.text("This is a copy of \"Lieutenant Hornblower\" by C.S. Forester."),
        },
        {
            id = "classic32",
            name = ccb.content.plural_text("Master and Commander", "copies of Master and Commander"),
            description = ccb.content.text("This is a copy of \"Master and Commander\" by Patrick O'Brian."),
        },
        {
            id = "classic33",
            name = ccb.content.plural_text("The Warden", "copies of The Warden"),
            description = ccb.content.text("This is a copy of \"The Warden\" by Anthony Trollope."),
        },
        {
            id = "classic34",
            name = ccb.content.plural_text("The Far Side of the World", "copies of The Far Side of the World"),
            description = ccb.content.text("This is a copy of \"The Far Side of the World\" by Patrick O'Brian."),
        },
        {
            id = "classic35",
            name = ccb.content.plural_text("HMS Surprise", "copies of HMS Surprise"),
            description = ccb.content.text("This is a copy of \"HMS Surprise\" by Patrick O'Brian."),
        },
        {
            id = "classic36",
            name = ccb.content.plural_text("Barchester Towers", "copies of Barchester Towers"),
            description = ccb.content.text("This is a copy of \"Barchester Towers\" by Anthony Trollope."),
        },
        {
            id = "classic37",
            name = ccb.content.plural_text("The Land Ironclads", "copies of The Land Ironclads"),
            description = ccb.content.text("This is a copy of \"The Land Ironclads\" by H.G. Wells."),
        },
        {
            id = "classic38",
            name = ccb.content.plural_text("The Great Boer War", "copies of The Great Boer War"),
            description = ccb.content.text("This is a copy of \"The Great Boer War\" by Arthur Conan Doyle."),
        },
        {
            id = "classic39",
            name = ccb.content.plural_text("The Crime of the Congo", "copies of The Crime of the Congo"),
            description = ccb.content.text("This is a copy of \"The Crime of the Congo\" by Arthur Conan Doyle."),
        },
        {
            id = "classic40",
            name = ccb.content.plural_text("The Parasite", "copies of The Parasite"),
            description = ccb.content.text("This is a copy of \"The Parasite\" by Arthur Conan Doyle."),
        },
        {
            id = "classic41",
            name = ccb.content.plural_text("By Stroke of Sword", "copies of By Stroke of Sword"),
            description = ccb.content.text("This is a copy of \"By Stroke of Sword\" by Andrew Balfour."),
        },
        {
            id = "classic42",
            name = ccb.content.plural_text("The Secret Agent", "copies of The Secret Agent"),
            description = ccb.content.text("This is a copy of \"The Secret Agent\" by Joseph Conrad."),
        },
        {
            id = "classic43",
            name = ccb.content.plural_text("Lord Jim", "copies of Lord Jim"),
            description = ccb.content.text("This is a copy of \"Lord Jim\" by Joseph Conrad."),
        },
        {
            id = "classic44",
            name = ccb.content.plural_text("Vanity Fair", "copies of Vanity Fair"),
            description = ccb.content.text("This is a copy of \"Vanity Fair\" by William Makepeace Thackeray."),
        },
        {
            id = "classic45",
            name = ccb.content.plural_text("The Luck of Barry Lyndon", "copies of The Luck of Barry Lyndon"),
            description = ccb.content.text("This is a copy of \"The Luck of Barry Lyndon\" by William Makepeace Thackeray."),
        },
        {
            id = "classic46",
            name = ccb.content.plural_text("North and South", "copies of North and South"),
            description = ccb.content.text("This is a copy of \"North and South\" by Elizabeth Gaskell."),
        },
        {
            id = "classic47",
            name = ccb.content.plural_text("The Mayor of Casterbridge", "copies of The Mayor of Casterbridge"),
            description = ccb.content.text("This is a copy of \"The Mayor of Casterbridge\" by Thomas Hardy."),
        },
        {
            id = "classic48",
            name = ccb.content.plural_text("Wessex Tales", "copies of Wessex Tales"),
            description = ccb.content.text("This is a copy of \"Wessex Tales\" by Thomas Hardy."),
        },
        {
            id = "classic49",
            name = ccb.content.plural_text("Far from the Madding Crowd", "copies of Far from the Madding Crowd"),
            description = ccb.content.text("This is a copy of \"Far from the Madding Crowd\" by Thomas Hardy."),
        },
        {
            id = "classic50",
            name = ccb.content.plural_text("Captains Courageous", "copies of Captains Courageous"),
            description = ccb.content.text("This is a copy of \"Captains Courageous\" by Rudyard Kipling."),
        },
        {
            id = "classic51",
            name = ccb.content.plural_text("The Canterbury Tales", "copies of The Canterbury Tales"),
            description = ccb.content.text("This is a copy of \"The Canterbury Tales\" by Geoffrey Chaucer."),
        },
        {
            id = "classic52",
            name = ccb.content.plural_text("Harold, the Last of the Saxons", "copies of Harold, the Last of the Saxons"),
            description = ccb.content.text("This is a copy of \"Harold, the Last of the Saxons\" by Edward Bulwer-Lytton."),
        },
        {
            id = "classic53",
            name = ccb.content.plural_text("Mr Midshipman Easy", "copies of Mr Midshipman Easy"),
            description = ccb.content.text("This is a copy of \"Mr Midshipman Easy\" by Frederick Marryat."),
        },
        {
            id = "classic54",
            name = ccb.content.plural_text("Peter Simple", "copies of Peter Simple"),
            description = ccb.content.text("This is a copy of \"Peter Simple\" by Frederick Marryat."),
        },
        {
            id = "classic55",
            name = ccb.content.plural_text("The Three Musketeers", "copies of The Three Musketeers"),
            description = ccb.content.text("A paperback copy of \"The Three Musketeers\" by Alexandre Dumas, the gravitas somewhat spoiled by being the glossy movie tie-in version."),
        },
        {
            id = "classic56",
            name = ccb.content.plural_text("The Life and Opinions of Tristram Shandy, Gentleman", "copies of The Life and Opinions of Tristram Shandy, Gentleman"),
            description = ccb.content.text("This is a copy of \"The Life and Opinions of Tristram Shandy, Gentleman\" by Laurence Sterne."),
        },
        {
            id = "classic57",
            name = ccb.content.plural_text("The Time Machine", "copies of The Time Machine"),
            description = ccb.content.text("This is a copy of \"The Time Machine\" by H.G. Wells."),
        },
        {
            id = "classic58",
            name = ccb.content.plural_text("The Fall of the House of Usher", "copies of The Fall of the House of Usher"),
            description = ccb.content.text("This is a copy of several works by Edgar Allan Poe.  \"The Fall of the House of Usher\" heads the list."),
        },
        {
            id = "classic59",
            name = ccb.content.plural_text("The Silmarillion", "copies of The Silmarillion"),
            description = ccb.content.text("This is a copy of \"The Silmarillion\" by Tolkien.  Maybe you could bludgeon someone with it if it came to that."),
        },
        {
            id = "classic60",
            name = ccb.content.plural_text("The Turn of the Screw", "copies of The Turn of the Screw"),
            description = ccb.content.text("This is a copy of \"The Turn of the Screw\" by Henry James."),
        },
        {
            id = "classic61",
            name = ccb.content.plural_text("The Call of the Wild", "copies of The Call of the Wild"),
            description = ccb.content.text("This is a copy of \"The Call of the Wild\" by Jack London."),
        },
        {
            id = "classic62",
            name = ccb.content.plural_text("Frankenstein", "copies of Frankenstein"),
            description = ccb.content.text("This is a copy of \"Frankenstein\" by Mary Shelley."),
        },
        {
            id = "classic63",
            name = ccb.content.plural_text("Tevye the Dairyman", "copies of Tevye the Dairyman"),
            description = ccb.content.text("This is a copy of \"Tevye the Dairyman\" by Sholem Aleichem, translated into English."),
        },
        {
            id = "classic64",
            name = ccb.content.plural_text("Another Country", "copies of Another Country"),
            description = ccb.content.text("This is a copy of \"Another Country \" by James Baldwin."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "collector_book",
        name = ccb.content.plural_text("collector's edition book", "collector's edition books"),
        description = ccb.content.text("A unique, valuable book that has been kept as a collector's item."),
        mass_milligrams = 400000,
        volume_ml = 750,
        price_cents = 4550,
        price_postapoc_cents = 50,
        looks_like = "tall_tales",
        color = "light_blue",
        symbol = "?",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 1680,
        fun = 4,
        chapters = 40,
        scannable = true,
        generic = true,
    }
    book:variants {
        {
            id = "fancy1",
            name = ccb.content.plural_text("collector's edition of A Tale of Two Cities", "copies of collector's edition of A Tale of Two Cities"),
            description = ccb.content.text("This is a high-quality leather bound copy of Charles Dickens' \"A Tale of Two Cities\"."),
        },
        {
            id = "fancy2",
            name = ccb.content.plural_text("collector's edition of Oliver Twist", "copies of collector's edition of Oliver Twist"),
            description = ccb.content.text("This is a very old but well-preserved copy of Charles Dickens' \"Oliver Twist\"."),
        },
        {
            id = "fancy3",
            name = ccb.content.plural_text("collector's edition of Pride and Prejudice", "copies of collector's edition of Pride and Prejudice"),
            description = ccb.content.text("This high-quality copy of Jane Austen's \"Pride and Prejudice\" is dog-eared and looks to have been read many times."),
        },
        {
            id = "fancy4",
            name = ccb.content.plural_text("collector's edition of Vanity before Justice", "copies of collector's edition of Vanity before Justice"),
            description = ccb.content.text("This is a hefty, hardcover print of William Shinderling's \"Vanity before Justice\" with beautiful illustrations."),
        },
        {
            id = "fancy5",
            name = ccb.content.plural_text("collector's edition of Sense and Sensibility", "copies of collector's edition of Sense and Sensibility"),
            description = ccb.content.text("This copy of Jane Austen's \"Sense and Sensibility\" has a certificate of authenticity declaring it to be an early edition.  It would have been worth an enormous amount of money, not long ago."),
        },
        {
            id = "fancy6",
            name = ccb.content.plural_text("collector's edition of To Kill a Mockingbird", "copies of collector's edition of To Kill a Mockingbird"),
            description = ccb.content.text("This is an excellent quality copy of \"To Kill a Mockingbird\" by Harper Lee."),
        },
        {
            id = "fancy7",
            name = ccb.content.plural_text("collector's edition of The Great Gatsby", "copies of collector's edition of The Great Gatsby"),
            description = ccb.content.text("This is a high-quality leather bound copy of F. Scott Fitzgerald's \"The Great Gatsby.\""),
        },
        {
            id = "fancy8",
            name = ccb.content.plural_text("collector's edition of Lady Wanderlust", "copies of collector's edition of Lady Wanderlust"),
            description = ccb.content.text("This is a hefty, hardcover print of Michael Abanaderly's opus, \"Lady Wanderlust\".  It is over a hundred years old, but doesn't look it."),
        },
        {
            id = "fancy9",
            name = ccb.content.plural_text("collector's edition of Fahrenheit 451", "copies of collector's edition of Fahrenheit 451"),
            description = ccb.content.text("This copy of Ray Bradbury's \"Fahrenheit 451\" has a certificate of authenticity declaring it to be an early edition.  It would have been worth an enormous amount of money, not long ago."),
        },
        {
            id = "fancy10",
            name = ccb.content.plural_text("collector's edition of Pride and Prejudice and Zombies", "copies of collector's edition of Pride and Prejudice and Zombies"),
            description = ccb.content.text("This high-quality copy of \"Pride and Prejudice and Zombies\" has been autographed by the author."),
        },
        {
            id = "fancy11",
            name = ccb.content.plural_text("collector's edition of The Adventures of Huckleberry Finn", "copies of collector's edition of The Adventures of Huckleberry Finn"),
            description = ccb.content.text("This is a high-quality leather bound copy of \"The Adventures of Huckleberry Finn\" by Mark Twain.  It contains some margin notes which themselves are quite old, and look to have been done by a scholar of some sort."),
        },
        {
            id = "fancy12",
            name = ccb.content.plural_text("collector's edition of Dracula", "copies of collector's edition of Dracula"),
            description = ccb.content.text("This is a very nice print of Bram Stoker's \"Dracula\".  It has a certificate of authenticity with it that declares it a genuine early edition."),
        },
        {
            id = "fancy13",
            name = ccb.content.plural_text("collector's edition of The Hitchhiker's Guide to the Galaxy", "copies of collector's edition of The Hitchhiker's Guide to the Galaxy"),
            description = ccb.content.text("This copy of Douglas Adams' \"The Hitchhiker's Guide to the Galaxy\" has a certificate of authenticity declaring it to be a first edition, and is autographed by the author himself."),
        },
        {
            id = "fancy14",
            name = ccb.content.plural_text("collector's edition of Dark Days Ahead", "copies of collector's edition of Dark Days Ahead"),
            description = ccb.content.text("This is a high-quality leather bound copy of the well-known classic \"Dark Days Ahead\", by M. G. Ranade."),
        },
        {
            id = "fancy15",
            name = ccb.content.plural_text("collector's edition of Oryx and Crake", "copies of collector's edition of Oryx and Crake"),
            description = ccb.content.text("This is a well-kept leather bound copy of \"Oryx and Crake\" by Margaret Atwood.  Inscribed in the inner cover is a faded note wishing the owner a happy birthday."),
        },
        {
            id = "fancy16",
            name = ccb.content.plural_text("collector's edition of The Gunslinger", "copies of collector's edition of The Gunslinger"),
            description = ccb.content.text("This is a perfectly preserved hardcover copy of \"The Gunslinger\" by Stephen King, autographed by the author.  It contains a certificate of authenticity pronouncing it to be a first edition."),
        },
        {
            id = "fancy17",
            name = ccb.content.plural_text("collector's edition of 1984", "copies of collector's edition of 1984"),
            description = ccb.content.text("This bright orange hardcover copy of \"1984\" by George Orwell has been carefully preserved, and appears to be a first or second edition judging from the publisher's information."),
        },
        {
            id = "fancy18",
            name = ccb.content.plural_text("collector's edition of Lady Chatterly's Lover", "copies of collector's edition of Lady Chatterly's Lover"),
            description = ccb.content.text("This is a very nice copy of \"Lady Chatterly's Lover\", probably quite expensive in the days before the apocalypse."),
        },
        {
            id = "fancy19",
            name = ccb.content.plural_text("collector's edition of The Handmaid's Tale", "copies of collector's edition of The Handmaid's Tale"),
            description = ccb.content.text("This is a high quality early edition hardcover copy of \"The Handmaid's Tale\" by Margaret Atwood, signed by the author."),
        },
        {
            id = "fancy20",
            name = ccb.content.plural_text("collector's edition of Don Quixote", "copies of collector's edition of Don Quixote"),
            description = ccb.content.text("This ancient and worn book looks to be an 18th or early 19th century handwritten copy of \"Don Quixote\".  In the days of book traders it would have been worth an absolute fortune.  Now it's either a priceless piece of history, some light reading before bed, or excellent kindling."),
        },
        {
            id = "fancy21",
            name = ccb.content.plural_text("collector's edition of The Colour of Magic", "copies of collector's edition of The Colour of Magic"),
            description = ccb.content.text("This is a first edition copy of Terry Pratchett's \"The Colour of Magic\".  In the inner cover is a handwritten note that reads \"To Chris, thanks for believing I could do it.  Best regards, Terry.\""),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "occult_economicon",
        name = ccb.content.plural_text("The Economicon of Dobbs", "copies of The Economicon"),
        description = ccb.content.text("These are the prescriptures Pile 18 Disk sg30 File 14.  \"Look, small brain of pink earth inside my null-grasping, and she/he receives Logos; and it lay with the Wor.\""),
        mass_milligrams = 120000,
        volume_ml = 300,
        price_cents = 2699,
        copy_from = "paperback_occult",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 600,
        fun = 1,
        chapters = 4,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "occult_bobliographon",
        name = ccb.content.plural_text("The Bobliographon", "copies of The Bobliographon"),
        description = ccb.content.text("The back cover of this cheaply published paperback reads: \"These newly-released SubGenius revelations will SHOCK those who think they know Bob!  Unpredictables are not alone and possess amazing hidden powers of their own!  In a world without slack, a yeti lust revival saunters about.  WARNING: Do not fail to pay full price for this book; JHVH-1's wrath knows some bounds.\""),
        copy_from = "paperback_occult",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 720,
        fun = 1,
        chapters = 30,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "occult_glimpses",
        name = ccb.content.plural_text("Glimpses of Solomon in Yellow", "copies of Solomon in Yellow"),
        description = ccb.content.text("This paperback is titled \"Glimpses of Solomon in Yellow; The Initiation Rites of the Starry Wisdom Covenant, by Dr. Enoch Craven.\"  It describes not just the investiture of new adherents, but the history and beliefs of the Church of Starry Wisdom.  Someone has defaced the sparse citations section by scrawling \"PUPPETS OF ROME!\" over its few pages.  The book does not provide any biography for Dr. Craven, let alone academic credentials."),
        mass_milligrams = 557000,
        price_cents = 3200,
        copy_from = "paperback_occult",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 2100,
        fun = 1,
        chapters = 40,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "necronomicon",
        name = ccb.content.plural_text("grimoire", "grimoires"),
        description = ccb.content.text("A hefty book with a thick leather cover and metal clasps.  Both covers are completely empty, though on the first page there is an author's name written in English: \"Abdul Alhazred\"; below it the book title is written in Arabian: \"العزيف\", and below it in Greek: \"Νεκρονομικόν\".  The book looks very old and sinister."),
        mass_milligrams = 1887000,
        volume_ml = 1250,
        price_cents = 4550,
        price_postapoc_cents = 50,
        symbol = "?",
        color = "light_gray",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:material("leather", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 600,
        fun = 0,
        chapters = 24,
        scannable = true,
    }
    content.upsert_item(book)
end

do
    local book = content.Item {
        id = "book_judaica_siddur",
        name = ccb.content.plural_text("Siddur", "Siddurs"),
        description = ccb.content.text("A Siddur, or prayerbook, contains the set order of prayers for Jewish religious services.  This one is comprehensive, divided into morning, afternoon, and evening prayers for both weekdays and Shabbat, along with separate sections for minor and major holidays."),
        mass_milligrams = 750000,
        volume_ml = 1000,
        longest_side_mm = 200,
        copy_from = "book_nonf_hard_phil_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 2700,
        fun = 1,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_judaica_hardcover",
        name = ccb.content.plural_text("Judaica hardcover", "Judaica hardcovers"),
        description = ccb.content.text("This is a book of Judaica.  You're a real mensch if you managed to find this one."),
        mass_milligrams = 420000,
        volume_ml = 773,
        longest_side_mm = 180,
        copy_from = "book_nonf_hard_phil_tpl",
        variant_kind = "generic",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 2700,
        fun = 1,
        chapters = 18,
        scannable = true,
    }
    book:variants {
        {
            id = "book_judaica_hardcover_2",
            name = ccb.content.plural_text("Hell in Jewish Literature", "copies of Hell in Jewish Literature"),
            description = ccb.content.text("A analysis of rabbinic discussions of Gehinnom, the Jewish afterlife for the cleansing of sins, including how big it is, how hot it is, who goes there, how long they stay there, whether there is any relief from their punishments in the meantime, and exactly what shape Gehinnom is."),
        },
        {
            id = "book_judaica_hardcover_3",
            name = ccb.content.plural_text("Mimekor Yisrael, Book One: The National Tales", "copies of Mimekor Yisrael, Book One: The National Tales"),
            description = ccb.content.text("A collection of Jewish folktales, from Ashmedai king of demons to golem-making rabbis, from the Torah scholar who showed Aristotle the futility of philosophy to how Satan refused to bow to Adam because Adam was created from the dust of the earth, from martyrs murdered by Christian persecutors to General Joab single-handedly killing two thousand Amalekites so that when the blood ran out like a river through the city gates his troops knew to stop besieging the city and assault it, and dozens more besides."),
        },
        {
            id = "book_judaica_hardcover_4",
            name = ccb.content.plural_text("On the Doorposts of Your House", "copies of On the Doorposts of Your House"),
            description = ccb.content.text("A list of prayers, meditations, and rituals for use at home, from lighting the Shabbat candles to welcoming a new child into the household."),
        },
        {
            id = "book_judaica_hardcover_5",
            name = ccb.content.plural_text("The Observant Life: The Wisdom of Contemporary Judaism for Contemporary Jews", "copies of The Observant Life: The Wisdom of Contemporary Judaism for Contemporary Jews"),
            description = ccb.content.text("A long discussion of the ways in which Judaism's ancient rituals, traditions, and ethical practices are still relevant and meaningful in the modern world.  Unfortunately, there's no discussion of post-apocalyptic Judaism."),
        },
        {
            id = "book_judaica_hardcover_6",
            name = ccb.content.plural_text("Siddur Tisha b'Av", "copies of Siddur Tisha b'Av"),
            description = ccb.content.text("A prayerbook for Tisha b'Av, the most solemn day in the Jewish year.  This one also contains the full text of the book of Lamentations and selected commentaries."),
        },
        {
            id = "book_judaica_hardcover_7",
            name = ccb.content.plural_text("Coming to Terms with America: Essays on Jewish History, Religion, and Culture", "copies of Coming to Terms with America: Essays on Jewish History, Religion, and Culture"),
            description = ccb.content.text("A series of fifteen essays by Jonathan Sarna on Jews' attempt to be both distinctively Jewish but also definitely American, covering the American Revolution through to contemporary times."),
        },
        {
            id = "book_judaica_hardcover_8",
            name = ccb.content.plural_text("In This Hour", "copies of In This Hour"),
            description = ccb.content.text("An English translation of works written by Rabbi Abraham Joshua Heschel during the Nazi rule of Germany and Rabbi Heschel's exile in England, concerning historic and current persecution and his vision for Jewish education."),
        },
        {
            id = "book_judaica_hardcover_9",
            name = ccb.content.plural_text("Jewish Literacy: The Most Important Things to Know About the Jewish Religion, Its People and Its History", "copies of Jewish Literacy: The Most Important Things to Know About the Jewish Religion, Its People and Its History"),
            description = ccb.content.text("Rabbi Joseph Telushkin's encyclopedic tome of Jewish life, running to hundreds of chapters and answering questions about the Hebrew bible, the Talmud, the holidays and rituals, the Holocaust, Israel and the diaspora, and everything in between."),
        },
        {
            id = "book_judaica_hardcover_10",
            name = ccb.content.plural_text("Biblical Literacy: The Most Important People, Events and Ideas of the Hebrew Bible", "copies of Biblical Literacy: The Most Important People, Events and Ideas of the Hebrew Bible"),
            description = ccb.content.text("Rabbi Joseph Telushkin's exploration and analysis of the Hebrew Bible, containing a myriad of commentary and analysis, including on famous stories like the Binding of Isaac or the Exodus, a discussion of the weekly Torah readings that form part of the Jewish liturgical calendar, and a list of all 613 mitzvot."),
        },
        {
            id = "book_judaica_hardcover_11",
            name = ccb.content.plural_text("This Is Real and You Are Completely Unprepared", "copies of This Is Real and You Are Completely Unprepared"),
            description = ccb.content.text("An in-depth discussion of the High Holy Days, starting with the Three Weeks and Nine Days before Tisha b'Av and continuing all the way through Sukkot, as a single period of rising and falling emotion, wherein each individual prepares themselves to stand before God.  A very well-known book that some people read every year and others mean to get around to finally reading this year."),
        },
        {
            id = "book_judaica_hardcover_12",
            name = ccb.content.plural_text("OU Manual for Checking Fruits and Vegetables", "copies of the OU Manual for Checking Fruits and Vegetables"),
            description = ccb.content.text("A comprehensive guide to checking produce for insect infestation and how to prepare produce according to Jewish dietary law."),
        },
        {
            id = "book_judaica_hardcover_13",
            name = ccb.content.plural_text("Shalom Rav, Volume 1", "copies of Shalom Rav, Volume 1"),
            description = ccb.content.text("Rabbi Shalom Rosner's commentary on the weekly Torah portion, covering the books of Genesis and Exodus."),
        },
        {
            id = "book_judaica_hardcover_14",
            name = ccb.content.plural_text("Shalom Rav, Volume 2", "copies of Shalom Rav, Volume 2"),
            description = ccb.content.text("Rabbi Shalom Rosner's commentary on the weekly Torah portion, covering the books of Leviticus, Numbers, and Deuteronomy."),
        },
        {
            id = "book_judaica_hardcover_15",
            name = ccb.content.plural_text("The Origins of Judaism: An Archaeological-Historical Reappraisal", "copies of The Origins of Judaism: An Archaeological-Historical Reappraisal"),
            description = ccb.content.text("An examination of the archaeological evidence behind the beginning of many Jewish traditions, including eschewing pork, adopting tefillin and placing mezuzot on doorposts, and circumcision."),
        },
        {
            id = "book_judaica_hardcover_16",
            name = ccb.content.plural_text("The Guide for the Perplexed", "copies of the Guide for the Perplexed"),
            description = ccb.content.text("An English translation of the great sage Rabbi Moses ben Maimon's work finding common points between natural philosophy and Talmudic scholarship.  Contains the famous Thirteen Principles of Faith, accepted by many Jews as a summary of the fundamental beliefs of Judaism."),
        },
        {
            id = "book_judaica_hardcover_17",
            name = ccb.content.plural_text("Jewish Publication Society Torah Commentary: Genesis", "copies of the Jewish Publication Society Torah Commentary: Genesis"),
            description = ccb.content.text("A series of Torah commentaries written by scholars and academics, containing the traditional Hebrew text, a translation, and various notes.  This volume is for the book of Genesis."),
        },
        {
            id = "book_judaica_hardcover_18",
            name = ccb.content.plural_text("Jewish Publication Society Torah Commentary: Exodus", "copies of the Jewish Publication Society Torah Commentary: Exodus"),
            description = ccb.content.text("A series of Torah commentaries written by scholars and academics, containing the traditional Hebrew text, a translation, and various notes.  This volume is for the book of Exodus."),
        },
        {
            id = "book_judaica_hardcover_19",
            name = ccb.content.plural_text("Jewish Publication Society Torah Commentary: Leviticus", "copies of the Jewish Publication Society Torah Commentary: Leviticus"),
            description = ccb.content.text("A series of Torah commentaries written by scholars and academics, containing the traditional Hebrew text, a translation, and various notes.  This volume is for the book of Leviticus."),
        },
        {
            id = "book_judaica_hardcover_20",
            name = ccb.content.plural_text("Jewish Publication Society Torah Commentary: Numbers", "copies of the Jewish Publication Society Torah Commentary: Numbers"),
            description = ccb.content.text("A series of Torah commentaries written by scholars and academics, containing the traditional Hebrew text, a translation, and various notes.  This volume is for the book of Numbers."),
        },
        {
            id = "book_judaica_hardcover_21",
            name = ccb.content.plural_text("Jewish Publication Society Torah Commentary: Deuteronomy", "copies of the Jewish Publication Society Torah Commentary: Deuteronomy"),
            description = ccb.content.text("A series of Torah commentaries written by scholars and academics, containing the traditional Hebrew text, a translation, and various notes.  This volume is for the book of Deuteronomy."),
        },
        {
            id = "book_judaica_hardcover_22",
            name = ccb.content.plural_text("Shulchan Arukh", "copies of the Shulchan Arukh"),
            description = ccb.content.text("Compiled by Rabbi Yosef Karo in the 16th century, the Shuchan Arukh is the most widely-consulted and authoritative compilation of Jewish law lasting into the present day.  If you need to convene a post-Cataclysmic Beit Din, keep this with you and you'll be set."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_judaica_softcover",
        name = ccb.content.plural_text("Judaica softcover", "Judaica softcovers"),
        description = ccb.content.text("This is a book of Judaica.  You're a real mensch if you managed to find this one."),
        mass_milligrams = 227000,
        volume_ml = 421,
        copy_from = "book_nonf_soft_phil_tpl",
        variant_kind = "generic",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 2700,
        fun = 1,
        chapters = 18,
        scannable = true,
    }
    book:variants {
        {
            id = "book_judaica_softcover_1",
            name = ccb.content.plural_text("A Short History of the Jewish People: From Legendary Times to Modern Statehood", "copies of A Short History of the Jewish People: From Legendary Times to Modern Statehood"),
            description = ccb.content.text("A survey-level study of Jewish history, from Biblical times through to the 1990s.  At only 250 pages long, it is by necessity very brief on any individual topic."),
        },
        {
            id = "book_judaica_softcover_2",
            name = ccb.content.plural_text("I and Thou", "copies of I and Thou"),
            description = ccb.content.text("An English translation of Martin Buber's philosophical work on the relationships of human beings to each other and to God."),
        },
        {
            id = "book_judaica_softcover_3",
            name = ccb.content.plural_text("Living a Jewish Life", "copies of Living a Jewish Life"),
            description = ccb.content.text("Anita Diamant's survey-level discussion of the daily practices and rituals of Jewish life.  Originally mostly superseded by the free availability of information on the internet, it's much more useful now for everyone who feels bad that they didn't attend their synagogue often enough before it was overrun."),
        },
        {
            id = "book_judaica_softcover_4",
            name = ccb.content.plural_text("What Is a Jew", "copies of What Is a Jew"),
            description = ccb.content.text("Rabbi Morris Kertzer's introductory text about Judaism and Jewish beliefs, written as a series of questions and then answers, primarily from a Reform viewpoint but with explicit mention of where Conservative or Orthodox Jews would disagree."),
        },
        {
            id = "book_judaica_softcover_5",
            name = ccb.content.plural_text("The Way of Humanity: According to Chasidic Teachings", "copies of The Way of Humanity: According to Chasidic Teachings"),
            description = ccb.content.text("An English translation of lectures given by Martin Buber on six traditional Chasidic stories from the 18th and 19th centuries."),
        },
        {
            id = "book_judaica_softcover_6",
            name = ccb.content.plural_text("Megillat Esther: The Book of Esther", "copies of Megillat Esther: The Book of Esther"),
            description = ccb.content.text("A comprehensive work for celebrating Purim, this book contains the complete Book of Esther in Hebrew, multiple English translations, commentary on each of its chapters, and commentary on certain verses by a group of Conservative rabbis.  Cursed be Haman (booo)!"),
        },
        {
            id = "book_judaica_softcover_7",
            name = ccb.content.plural_text("Halakhic Man", "copies of Halakhic Man"),
            description = ccb.content.text("Rabbi Joseph Soloveitchik's argument on the proper path to moral virtue through Torah scholarship and observance to the law, through the intellect and not through mystical experience or surrender to God."),
        },
        {
            id = "book_judaica_softcover_8",
            name = ccb.content.plural_text("Maxwell House Haggadah", "copies of the Maxwell House Haggadah"),
            description = ccb.content.text("Just like bubbe used to have at the Seder.  A true classic of the Jewish people despite its origin as a marketing tactic to sell coffee, the Maxwell House Haggadah has sold millions of copies and graced the Passover tables of millions of families."),
        },
        {
            id = "book_judaica_softcover_9",
            name = ccb.content.plural_text("Reviving Synagogue Communities Using Smart Tech", "copies of Reviving Synagogue Communities Using Smart Tech"),
            description = ccb.content.text("A discussion of ways to use modern technology to alleviate the administrative burden on clergy and synagogue staff but without losing the human touch that leads to a proper religious community."),
        },
        {
            id = "book_judaica_softcover_10",
            name = ccb.content.plural_text("On Repentance And Repair: Making Amends in an Unapologetic World", "copies of On Repentance And Repair: Making Amends in an Unapologetic World"),
            description = ccb.content.text("Rabbi Danya Ruttenberg's commentary on the great Jewish philosopher Maimonides ideas about \"Tikkun Olam\", often translated as \"Repairing the World,\" and how while popular ideas of forgiveness often involve moving on after the apology, the Hebrew word \"teshuvah\" means something closer to \"return.\"  True repentance, then, involves making restitution for error and harm and attempting to return the world to the way it was before the damage was done."),
        },
        {
            id = "book_judaica_softcover_11",
            name = ccb.content.plural_text("Beyond Breaking the Glass: A Spiritual Guide to Your Jewish Wedding, Revised Edition", "copies of Beyond Breaking the Glass: A Spiritual Guide to Your Jewish Wedding, Revised Edition"),
            description = ccb.content.text("A practical guide to throwing a Jewish wedding, including checklists, a timeline, and ways to make traditional rituals resonate with modern wedding guests."),
        },
        {
            id = "book_judaica_softcover_12",
            name = ccb.content.plural_text("People Love Dead Jews: Reports from a Haunted Present", "copies of People Love Dead Jews: Reports from a Haunted Present "),
            description = ccb.content.text("Dara Horn's exploration of the modern rise of antisemitism, why there is so much interest in Jewish tragedy and comparatively little interest in Jewish culture, and why non-Jews feature so often and so prominently in popular stories of the Holocaust.  It would probably have been riveting and insightful before the Cataclysm made such concerns mostly irrelevant."),
        },
        {
            id = "book_judaica_softcover_13",
            name = ccb.content.plural_text("God in Search of Man : A Philosophy of Judaism", "copies of God in Search of Man : A Philosophy of Judaism "),
            description = ccb.content.text("Rabbi Abraham Joshua Heschel's philosophical work on religious thought, on revelation and the problem of evil, and on the nature of a God who seeks a partner in humanity."),
        },
        {
            id = "book_judaica_softcover_14",
            name = ccb.content.plural_text("Not in God's Name: Confronting Religious Violence", "copies of Not in God's Name: Confronting Religious Violence "),
            description = ccb.content.text("Rabbi Abraham Joshua Heschel's answer to the claim that religion is fundamentally divisive and encourages conflict.  His main argument is that religiously-motivated violence stems from misreadings of sacred texts."),
        },
        {
            id = "book_judaica_softcover_15",
            name = ccb.content.plural_text("When Bad Things Happen to Good People", "copies of When Bad Things Happen to Good People"),
            description = ccb.content.text("A meditation on meaningless tragedy and why the disaster and sorrow in the world is unevenly distributed.  Written decades before the Cataclysm, but the author was obviously on to something."),
        },
        {
            id = "book_judaica_softcover_16",
            name = ccb.content.plural_text("The Jewish War: Revised Edition", "copies of The Jewish War: Revised Edition"),
            description = ccb.content.text("An account of the Roman conquest of Judea and the destruction of the Temple written by Josephus, the first century Judean rebel turned Roman negotiator."),
        },
        {
            id = "book_judaica_softcover_17",
            name = ccb.content.plural_text("Standing Again at Sinai: Judaism from a Feminist Perspective", "copies of Standing Again at Sinai: Judaism from a Feminist Perspective"),
            description = ccb.content.text("A critique of Jewish practice by a Jewish feminist theologian."),
        },
        {
            id = "book_judaica_softcover_18",
            name = ccb.content.plural_text("Zohar: The Book of Splendor: Basic Readings from the Kabbalah", "copies of Zohar: The Book of Splendor: Basic Readings from the Kabbalah"),
            description = ccb.content.text("A book of Jewish mysticism often attributed to the great rabbi Shimon bar Yochai, the Zohar is the central work of Kabbalah.  This is an abridged version containing selected passages from the full text."),
        },
        {
            id = "book_judaica_softcover_19",
            name = ccb.content.plural_text("Miriam's Tambourine: Jewish Folktales from Around the World", "copies of Miriam's Tambourine: Jewish Folktales from Around the World"),
            description = ccb.content.text("A collection of over fifty Jewish folktales, from classics like the story of Miriam's well or Rabbi Loew and the golem or the life of the Baal Shem Tov, to Jewish versions of modern cultural classics like Snow White or Sinbad."),
        },
        {
            id = "book_judaica_softcover_20",
            name = ccb.content.plural_text("From the Maccabees to the Mishnah", "copies of From the Maccabees to the Mishnah"),
            description = ccb.content.text("A history of the development of Rabbinic Judaism, from the Jewish Revolt in the first century to the writing of the Mishnah, and how Judaism and Christianity fully separated."),
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "european_comic",
        name = ccb.content.plural_text("european comic", "european comics"),
        description = ccb.content.text("A comic book in the franco-belgian format, large, fully colored with a hard cover."),
        mass_milligrams = 330000,
        volume_ml = 280,
        longest_side_mm = 320,
        copy_from = "mag_comic",
        looks_like = "mag_comic",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 0,
        read_time_turns = 1800,
        fun = 2,
        chapters = 0,
        scannable = true,
    }
    book:variants {
        {
            id = "generic",
            weight = 2,
        },
        {
            id = "tintin",
            name = ccb.content.plural_text("the adventures of tintin", "the adventures of tintin comics"),
            description = ccb.content.text("This album is part of the Adventures of Tintin series, which is about a young reporter called Tintin, his dog Snowy and his friends, particularly Captain Haddock, as they travel across the world solving mysteries, uncovering conspiracies, and foiling criminals."),
            append = true,
            weight = 5,
        },
        {
            id = "asterix",
            name = ccb.content.plural_text("asterix", "asterix comics"),
            description = ccb.content.text("This album is part of the Asterix series, which is about the eponymous gaulish warrior, his friend Obelix and his dog Idefix, holding out against the roman invaders thanks to a magic potion giving them supernatural strength."),
            append = true,
            weight = 4,
        },
        {
            id = "lucky_luke",
            name = ccb.content.plural_text("lucky luke", "lucky luke comics"),
            description = ccb.content.text("This album is part of the Lucky Luke series, which is about a cowboy named Lucky Luke, \"the man who shoots faster than his shadow,\" and his horse Jolly Jumper bringing justice across the far west."),
            append = true,
            weight = 3,
        },
        {
            id = "smurfs",
            name = ccb.content.plural_text("the smurfs", "the smurfs comics"),
            description = ccb.content.text("This album is part of the Smurfs series, which is about a community of tiny blue creatures called Smurfs who live in a hidden village deep in the forest led by Papa Smurf"),
            append = true,
            weight = 3,
        },
        {
            id = "dungeon",
            name = ccb.content.plural_text("dungeon", "dungeon comics"),
            description = ccb.content.text("This album is part of the Dungeon series, which is mainly about the adventures of Herbert the duck and Marvin the dragon working for the \"dungeon\", a business establishment where heroes come in search of adventure and treasure and invariably die."),
            append = true,
            weight = 1,
        },
        {
            id = "metabarons",
            name = ccb.content.plural_text("the saga of the meta-barons", "the saga of the meta-barons comics"),
            description = ccb.content.text("This album is part of the saga of the meta-barons series, which is about a dynasty of space warriors called the meta-barons, the narration is made by a duo of quirky robots, Tonto and Lothar, as they chronicle the life of each of them."),
            append = true,
            weight = 1,
        },
    }
    content.add(book)
end
