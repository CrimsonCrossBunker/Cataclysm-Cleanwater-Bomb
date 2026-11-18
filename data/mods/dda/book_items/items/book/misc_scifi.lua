local content = require("ccb").content

do
    -- this variant of the book Dune is intentional
    local book = content.Item {
        id = "book_fict_soft_scifi_dune",
        name = content.plural_text("Dune", "copies of Dune"),
        description = content.text("This is a dog-eared copy of \"Dune\" by Frank Herbert.  It has sand between some of its pages.  Weird."),
        price_cents = 1744,
        copy_from = "book_fict_soft_scifi_tpl",
    }
    content.add(book)
end

do
    -- this variant of the book Dune is intentional
    local book = content.Item {
        id = "book_fict_hard_scifi_dune",
        name = content.plural_text("Dune", "copies of Dune"),
        description = content.text("This is a sturdy copy of \"Dune\" by Frank Herbert.  It is a fairly new reprint with the words \"SOON TO BE A MAJOR MOTION PICTURE\" splashed across its dust jacket."),
        price_cents = 3299,
        copy_from = "book_fict_hard_scifi_tpl",
    }
    content.add(book)
end

do
    -- if we make a rare or collectors' item library group, this should go there too
    local book = content.Item {
        id = "book_fict_hard_scifi_fifth",
        name = content.plural_text("The Fifth Season", "signed copies of Fifth Season"),
        description = content.text("This is a signed hardcover copy of the Hugo award winning \"The Fifth Season\" by N. K. Jemisin.  It smells faintly of dirt."),
        price_cents = 19999,
        copy_from = "book_fict_hard_scifi_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_scifi_cybrd",
        name = content.plural_text("The Cyberiad", "copies of The Cyberiad"),
        description = content.text("This 350 page paperback presents the exploits and robotic rivalries of Trurl and Klapaucius.  Originally written in Polish by Stanisław Lem, it has been masterfully translated into English by Michael Kandel."),
        price_cents = 1069,
        copy_from = "book_fict_soft_scifi_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_scifi_roadp",
        name = content.plural_text("Roadside Picnic", "copies of Roadside Picnic"),
        description = content.text("This is a paperback copy of \"Roadside Picnic\" by Arkady and Boris Strugatsky.  It has been translated into over 20 languages, occasionally under the name \"Stalker.\"  This copy, fortunately for you, just happens to be in your native tongue."),
        copy_from = "book_fict_soft_scifi_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "novel_scifi",
        name = content.plural_text("scifi novel", "scifi novels"),
        description = content.text("Aliens, ray guns, and space ships."),
        copy_from = "book_fict_soft_scifi_tpl",
        snippet_category = "auto:novel_scifi",
    }

    local snippets = content.SnippetCategory { id = "auto:novel_scifi" }
    snippets:entry {
        id = "scifi1_1",
        text = content.text("This is a copy of Gibson's \"Neuromancer\".  Written in the eighties, it was surprisingly accurate in predicting much of modern society… until recently."),
    }
    snippets:entry {
        id = "scifi1_2",
        text = content.text("This is a copy of \"The Stars My Destination\" by Alfred Bester.\n\nTyger, Tyger, Burning bright,\nIn the forests of the night:\nWhat immortal hand or eye,\nDare frame thy fearful symmetry?"),
    }
    snippets:entry {
        id = "scifi1_3",
        text = content.text("This is a copy of \"The Lathe of Heaven\" by Ursula Le Guin.  Dirty finger-stains have smudged the occasional word."),
    }
    snippets:entry {
        id = "scifi1_4",
        text = content.text("This is a copy of \"The Dispossessed\" by Ursula Le Guin."),
    }
    snippets:entry {
        id = "scifi1_6",
        text = content.text("This is a copy of \"Hyperion\" by Dan Simmons."),
    }
    snippets:entry {
        id = "scifi1_7",
        text = content.text("This is a copy of \"Endymion\" by Dan Simmons.  It opens with a poem by D.H. Lawrence:\n\nGive us gods.  Oh give them us!\nGive us gods.\nWe are so tired of men\nAnd motor-power."),
    }
    snippets:entry {
        id = "scifi1_8",
        text = content.text("This is a copy of Philip K. Dick's \"Do Androids Dream of Electric Sheep?\"."),
    }
    snippets:entry {
        id = "scifi1_9",
        text = content.text("This is a dog-eared copy of \"Nova Express\" by William Burroughs."),
    }
    snippets:entry {
        id = "scifi1_10",
        text = content.text("This is a copy of \"Foundation\" by Isaac Asimov.  The back cover has been ripped off."),
    }
    snippets:entry {
        id = "scifi1_12",
        text = content.text("This is a copy of \"The Trial\" by Franz Kafka.  This book is rather worn."),
    }
    snippets:entry {
        id = "scifi1_13",
        text = content.text("This is a copy of \"The Handmaid's Tale\" by Margaret Atwood."),
    }
    snippets:entry {
        id = "scifi1_14",
        text = content.text("This is a copy of \"The Windup Girl\" by Paolo Bacigalupi.  The blurb makes you wonder how Thailand fared the end of the world."),
    }
    snippets:entry {
        id = "scifi1_15",
        text = content.text("This is a copy of \"Islands in the Net\" by Bruce Sterling."),
    }
    snippets:entry {
        id = "scifi1_16",
        text = content.text("This is a copy of \"Foundation and Empire\" by Isaac Asimov.  The back page contains a hand-written grocery list."),
    }
    snippets:entry {
        id = "scifi1_17",
        text = content.text("This is an almost new copy of  \"A Scanner Darkly\" by Philip K. Dick.  It still has the smell of new books within its pages."),
    }
    snippets:entry {
        id = "scifi1_18",
        text = content.text("This is a copy of \"Mirrorshades: A Cyberpunk Anthology\" compiled by Bruce Sterling.  The cover has rings of coffee stains over it."),
    }
    snippets:entry {
        id = "scifi1_19",
        text = content.text("This is a copy of \"The World of Null-A\" by A. E. van Vogt.  This copy looks to have been used to press flowers."),
    }
    snippets:entry {
        id = "scifi1_20",
        text = content.text("This is a copy of \"Altered Carbon\" by Richard Morgan."),
    }
    snippets:entry {
        id = "scifi1_21",
        text = content.text("This is a copy of Mary Shelley's \"Frankenstein\".  Wasn't that the name of the monster?"),
    }
    snippets:entry {
        id = "scifi1_22",
        text = content.text("This is a copy of \"Wasp\" by Eric Frank Russel.  The futuristic terrorist's handbook."),
    }
    snippets:entry {
        id = "scifi1_23",
        text = content.text("This is a copy of \"I Am Legend\" by Richard Matheson.  The sleeve is covered in dried blood."),
    }
    snippets:entry {
        id = "scifi1_25",
        text = content.text("This is a copy of \"The Forever War\" by Joe Haldeman.  This copy looks as if it's been slightly chewed by a dog or other large animal."),
    }
    snippets:entry {
        id = "scifi1_26",
        text = content.text("This is a copy of \"The Moon Is a Harsh Mistress\" by Robert A. Heinlein."),
    }
    snippets:entry {
        id = "scifi1_28",
        text = content.text("This is a copy of Samuel R. Delany's \"Nova\".  The cover reads \"Review Copy.  Not for re-sale.\""),
    }
    snippets:entry {
        id = "scifi1_29",
        text = content.text("This is a copy of Vonnegut's \"The Sirens of Titan\"."),
    }
    snippets:entry {
        id = "scifi1_30",
        text = content.text("This is a copy of \"Grass\" by Sheri S. Tepper.  A child has scribbled over the first pages in crayon."),
    }
    snippets:entry {
        id = "scifi1_31",
        text = content.text("This is a copy of William Gibson's \"Count Zero\".  The spine is stamped with 'Library Copy'.  And a sticker reading 'Science Fiction'."),
    }
    snippets:entry {
        id = "scifi1_33",
        text = content.text("This is a copy of \"The Weapon Makers\" by A. E. van Vogt."),
    }
    snippets:entry {
        id = "scifi1_34",
        text = content.text("This is a copy of \"Record of a Spaceborn Few\" by Becky Chambers.  It looks almost brand new."),
    }
    snippets:entry {
        id = "scifi1_35",
        text = content.text("This is a copy of \"Use of Weapons\" by Iain M. Banks.  The spine is cracked and worn, some pages appear to be loose."),
    }
    snippets:entry {
        id = "scifi1_36",
        text = content.text("This is a copy of Jean-Baptiste Cousin de Grainville's \"Le Dernier Homme\"."),
    }
    snippets:entry {
        id = "scifi1_37",
        text = content.text("This is a copy of Orwell's \"Nineteen Eighty-Four\".  The pages are loose and thin.  You should probably be careful with this copy."),
    }
    snippets:entry {
        id = "scifi1_38",
        text = content.text("This is a copy of Heinlein's \"Stranger in a Strange Land\".  The cover is dog-eared and worn."),
    }
    snippets:entry {
        id = "scifi1_39",
        text = content.text("This is a copy of Orson Scott Card's \"Ender's Game\"."),
    }
    snippets:entry {
        id = "scifi1_41",
        text = content.text("This is a copy of \"The Lost World\" by Arthur Conan Doyle."),
    }
    snippets:entry {
        id = "scifi1_42",
        text = content.text("This is a copy of \"Islands in the Sky\" by Arthur C. Clarke."),
    }
    snippets:entry {
        id = "scifi1_43",
        text = content.text("This is a copy of H. G. Wells' \"The Island of Doctor Moreau\"."),
    }
    snippets:entry {
        id = "scifi1_44",
        text = content.text("This is a copy of Stanisław Lem's \"His Masters Voice\"."),
    }
    snippets:entry {
        id = "scifi1_45",
        text = content.text("This is a copy of Fred Hoyle's \"The Black Cloud\"."),
    }
    snippets:entry {
        id = "scifi1_46",
        text = content.text("This is a copy of \"Last and First Men\" by Olaf Stapeldon."),
    }
    snippets:entry {
        id = "scifi1_47",
        text = content.text("This is a copy of Stanisław Lem's \"Solaris\"."),
    }
    snippets:entry {
        id = "scifi1_48",
        text = content.text("This is a copy of Theodore Sturgeon's \"More Than Human\"."),
    }
    snippets:entry {
        id = "scifi1_49",
        text = content.text("This is a copy of \"Vurt\" by Jeff Noon."),
    }
    snippets:entry {
        id = "scifi1_50",
        text = content.text("This is a copy of \"A Canticle for Leibowitz\" by Walter M. Miller Jr."),
    }
    snippets:entry {
        id = "scifi1_51",
        text = content.text("This is a copy of \"The War of The Worlds\" by H. G. Wells."),
    }
    snippets:entry {
        id = "scifi1_52",
        text = content.text("This is a copy of \"Iron Sunrise\" by Charles Stross."),
    }
    snippets:entry {
        id = "scifi1_53",
        text = content.text("This is a copy of \"The Hunger Games\" by Suzanne Collins.  Reading the blurb reminds you of a Japanese movie you think you once caught on the television late at night."),
    }
    snippets:entry {
        id = "scifi1_54",
        text = content.text("This is a copy of \"The Day of the Triffids\" by John Wyndham."),
    }
    snippets:entry {
        id = "scifi1_55",
        text = content.text("This is a copy of \"A Clockwork Orange\" by Anthony Burges."),
    }
    snippets:entry {
        id = "scifi1_56",
        text = content.text("This is a copy of \"The Man Who Fell to Earth\" by Walter Tevis."),
    }
    snippets:entry {
        id = "scifi1_57",
        text = content.text("This is a copy of \"Simulacron-3\" by Daniel F. Galouye."),
    }
    snippets:entry {
        id = "scifi1_58",
        text = content.text("This is a copy of \"The Glass Bees\" by Ernst Jünger."),
    }
    snippets:entry {
        id = "scifi1_59",
        text = content.text("This is a copy of \"Journey to The Center of the Earth\" by Jules Verne."),
    }
    snippets:entry {
        id = "scifi1_60",
        text = content.text("This is a copy of Larry Niven's \"Ringworld\".  There are a couple of pages missing from the end of the book.  Luckily only mail-order advertisements."),
    }
    snippets:entry {
        id = "scifi1_61",
        text = content.text("This is a well-worn copy of \"The Hitchhikers Guide to the Galaxy\" by Douglas Adams."),
    }
    content.add(snippets)
    content.add(book)
end

do
    -- isbn13: 9780613914314
    local book = content.Item {
        id = "book_fict_hard_scifi_talnt",
        name = content.plural_text("Parable of the Talents", "copies of Parable of the Talents"),
        description = content.text("This is a sturdy copy of \"Parable of the Talents.\".  It is Octavia Butler's sequel to her book \"Parable of the Sower.\""),
        price_cents = 2575,
        mass_milligrams = 517000,
        volume_ml = 963,
        longest_side_mm = 210,
        copy_from = "book_fict_hard_scifi_tpl",
    }
    book:clear_melee_damage()
    book:melee_damage("bash", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 900,
        fun = 2,
        chapters = 25,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9781611461787
    -- this variant is intentional
    local book = content.Item {
        id = "book_fict_hard_scifi_zamwe",
        name = content.plural_text("We", "copies of We"),
        description = content.text("This hardback book is titled \"The Annotated We: A New Translation of Yevgeny Zamyatin's Novel.\"\n\nIt is Vladimir Wozniuk's 2015 translation of \"We,\" originally published in 1924 and generally seen as the first modern dystopian novel.  The commentary examines the profusive allusions and highlights the poetic nature of Zamyatin's language."),
        price_cents = 8799,
        mass_milligrams = 458000,
        volume_ml = 756,
        longest_side_mm = 230,
        copy_from = "book_fict_hard_scifi_tpl",
    }
    book:clear_melee_damage()
    book:melee_damage("bash", 1)
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 360,
        fun = 2,
        chapters = 40,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9780140185850
    -- this variant is intentional
    local book = content.Item {
        id = "book_fict_soft_scifi_zamwe",
        name = content.plural_text("We", "copies of We"),
        description = content.text("A seminal work of dystopian fiction, Yevgeny Zamyatin's \"We\" was first published in 1924 but suppressed by the Soviet Union until 1988.\n\nThis mass-market 1993 edition you've found was translated from the Russian by Clarence Brown and includes a short introduction.  The slightly worn cover features a surrealist photo of a person gazing backward suspiciously."),
        price_cents = 1399,
        mass_milligrams = 182000,
        volume_ml = 289,
        longest_side_mm = 200,
        copy_from = "book_fict_soft_scifi_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 360,
        fun = 2,
        chapters = 40,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_scifi_brave",
        name = content.plural_text("Brave New World", "copies of Brave New World"),
        description = content.text("This is weather worn copy of \"Brave New World\" by Aldous Huxley looks like it has been left out in rain.  The novel begins in a bleak building where fetuses are grown in bottles on an assembly line."),
        copy_from = "book_fict_soft_scifi_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 6,
        read_time_turns = 900,
        fun = 2,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_scifi_f451",
        name = content.plural_text("Fahrenheit 451", "copies of Fahrenheit 451"),
        description = content.text("This is a copy of Ray Bradbury's \"Fahrenheit 451.\""),
        copy_from = "book_fict_soft_scifi_tpl",
        snippet_category = "auto:book_fict_soft_scifi_f451",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 4,
        read_time_turns = 3600,
        fun = 8,
        chapters = 3,
        scannable = true,
    }

    local snippets = content.SnippetCategory { id = "auto:book_fict_soft_scifi_f451" }
    snippets:entry {
        id = "book_fict_soft_scifi_f451_1",
        text = content.text("Some joker has gently burnt the exterior edge of this paperback dystopia.  It's still perfectly readable."),
    }
    snippets:entry {
        id = "book_fict_soft_scifi_f451_2",
        text = content.text("\"It was a pleasure to burn.  It was a special pleasure to see things eaten, to see things blackened and changed.\""),
    }
    snippets:entry {
        id = "book_fict_soft_scifi_f451_3",
        text = content.text("This 1979 softcover edition of Ray Bradbury's \"Fahrenheit 451\" was once a library book.  It still has a light blue checkout card pocketed on the torn back cover.  One \"Suzanne Collins\" borrowed it in 1981."),
    }
    snippets:entry {
        id = "book_fict_soft_scifi_f451_4",
        text = content.text("The red and black paperback novel you hold in your hands is a modern reprint of Ray Bradbury's \"Fahrenheit 451.\""),
    }
    snippets:entry {
        id = "book_fict_soft_scifi_f451_5",
        text = content.text("This sci-fi novel is divided into three parts: \"The Hearth and the Salamander,\" \"The Sieve and the Sand,\", and \"Burning Bright.\""),
    }
    content.add(snippets)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_fict_soft_docu_AWT",
        name = content.plural_text("All Things Weird", "copies of All Things Weird"),
        description = content.text("This is a copy of Felicity Powell's All Things Weird.  It tells the story of a survivor following The Reckoning, interjected with comedy and dramatic twists."),
        copy_from = "book_fict_soft_scifi_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 7,
        read_time_turns = 3600,
        fun = 10,
        chapters = 34,
        scannable = true,
    }
    content.add(book)
end
