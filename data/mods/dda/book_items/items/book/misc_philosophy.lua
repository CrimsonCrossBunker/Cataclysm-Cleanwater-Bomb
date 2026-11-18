local content = require("ccb").content

do
    local book = content.Item {
        id = "book_nonf_hard_phil_mdlogic",
        name = content.plural_text("Modal Logic as Metaphysics", "copies of Modal Logic"),
        description = content.text("A treatise on applying logical tools to questions about that nature of reality, this book contains detailed discussion of metaphysical issues."),
        mass_milligrams = 834000,
        volume_ml = 1249,
        longest_side_mm = 240,
        price_cents = 4895,
        copy_from = "book_nonf_hard_phil_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_phil_benoth",
        name = content.plural_text("Being and Nothingness", "copies of Being and Nothingness"),
        description = content.text("This paperback is a copy of Jean-Paul Sartre's \"Being and Nothingness\".  A key work in the existentialist tradition."),
        mass_milligrams = 794000,
        volume_ml = 1000,
        longest_side_mm = 210,
        price_cents = 3400,
        price_postapoc_cents = 50,
        copy_from = "book_nonf_soft_phil_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "philosophy_book",
        name = content.plural_text("book of philosophy", "books of philosophy"),
        description = content.text("A deep discussion of morality with an emphasis on epistemology and logic."),
        copy_from = "book_nonf_soft_phil_tpl",
        variant_kind = "generic",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 2160,
        fun = 1,
        chapters = 44,
        scannable = true,
    }
    book:variants {
        {
            id = "philosophy1",
            name = content.plural_text("Beyond Good and Evil", "copies of Beyond Good and Evil"),
            description = content.text("This is a copy of Nietzsche's \"Beyond Good and Evil\".  Its cover is dog-eared and creased."),
        },
        {
            id = "philosophy2",
            name = content.plural_text("The Unique and Its Property", "copies of The Unique and Its Property"),
            description = content.text("This is a copy of \"The Unique and Its Property\" by Max Stirner.  A modern translation by Wolfi Landstreicher."),
        },
        {
            id = "philosophy4",
            name = content.plural_text("Madness and Civilization", "copies of Madness and Civilization"),
            description = content.text("A large, extended version of \"Madness and Civilization\" by Michel Foucault.  The cover features a striking image of a Panopticonic Prison."),
        },
        {
            id = "philosophy5",
            name = content.plural_text("The Postmodern Condition: A Report on Knowledge", "copies of The Postmodern Condition: A Report on Knowledge"),
            description = content.text("This is a copy of \"The Postmodern Condition: A Report on Knowledge\" by Lyotard."),
        },
        {
            id = "philosophy6",
            name = content.plural_text("Jacques Derrida essays", "copies of Jacques Derrida essays"),
            description = content.text("A collection of texts and essays by Jacques Derrida.  Its pages are loose and yellowed - you should probably handle it with care."),
        },
        {
            id = "philosophy7",
            name = content.plural_text("Society of the Spectacle", "copies of Society of the Spectacle"),
            description = content.text("This is a copy of \"Society of the Spectacle\" by Guy Debord.  Its cover shows rows of adults staring placidly into a screen."),
        },
        {
            id = "philosophy8",
            name = content.plural_text("An Ethic of Sexual Difference and This Sex Which Is Not One", "copies of An Ethic of Sexual Difference and This Sex Which Is Not One"),
            description = content.text("This is a split copy of both \"An Ethic of Sexual Difference\" and \"This Sex Which Is Not One\" by Luce Irigaray."),
        },
        {
            id = "philosophy9",
            name = content.plural_text("Simulation and Simulacra", "copies of Simulation and Simulacra"),
            description = content.text("This is a copy of Baudrillard's \"Simulation and Simulacra\".  The cover contains an image of a man holding a colored pill in each hand, with the caption \"Welcome to the Desert of the Real.\".  You think you've seen this movie."),
        },
        {
            id = "philosophy10",
            name = content.plural_text("Existentialism and Humanism", "copies of Existentialism and Humanism"),
            description = content.text("This is a small, pocket version of Sartre's \"Existentialism and Humanism\".  It looks to have been used as a coaster in a past life."),
        },
        {
            id = "philosophy11",
            name = content.plural_text("Practical Ethics", "copies of Practical Ethics"),
            description = content.text("This is a copy of \"Practical Ethics\" by Peter Singer.  From the local university press."),
        },
        {
            id = "philosophy12",
            name = content.plural_text("Industrial Society and Its Future", "copies of Industrial Society and Its Future"),
            description = content.text("This is a photocopied spiral-bound copy of \"Industrial Society and Its Future\" by 'Freedom Club'.  The original looks to have been written on a typewriter before being copied."),
        },
        {
            id = "philosophy13",
            name = content.plural_text("Industrial Society and Its Future", "copies of Industrial Society and Its Future"),
            description = content.text("This is a copy of \"Industrial Society and Its Future\" by Ted Kaczynski.  Its cover is an image of a hand-crafted wooden box filled with wiring and an ominous looking metal tube.  Provocative."),
        },
        {
            id = "philosophy14",
            name = content.plural_text("Reader on Hegel's Dialectics", "copies of Reader on Hegel's Dialectics"),
            description = content.text("This is a small reader on Hegel's Dialectics."),
        },
        {
            id = "philosophy15",
            name = content.plural_text("The State and Revolution", "copies of The State and Revolution"),
            description = content.text("This is a copy of \"The State and Revolution\" by Vladimir Lenin.  In English, thankfully."),
        },
        {
            id = "philosophy16",
            name = content.plural_text("In Defense of Marxism", "copies of In Defense of Marxism"),
            description = content.text("This is a copy of \"In Defense of Marxism\" by Leon Trotsky."),
        },
        {
            id = "philosophy17",
            name = content.plural_text("Steal This Book", "copies of Steal This Book"),
            description = content.text("This is a copy of \"Steal This Book\" by Abbie Hoffman.  There is a security tag on the back cover.  It appears to still be active."),
        },
        {
            id = "philosophy18",
            name = content.plural_text("Walden: Or Life In The Woods", "copies of Walden: Or Life In The Woods"),
            description = content.text("This is a copy of \"Walden: Or Life In The Woods\" by Henry David Thoreau.  It contains a dried and pressed leaf as a bookmark."),
        },
        {
            id = "philosophy19",
            name = content.plural_text("The Female Eunuch", "copies of The Female Eunuch"),
            description = content.text("This is a copy of \"The Female Eunuch\" by Germaine Greer.  A child has scribbled over the contents page in red crayon."),
        },
        {
            id = "philosophy20",
            name = content.plural_text("An Introduction to Metaphysics", "copies of An Introduction to Metaphysics"),
            description = content.text("This is a copy of \"An Introduction to Metaphysics\" by Bergson."),
        },
        {
            id = "philosophy21",
            name = content.plural_text("The Four Fundamental Concepts of Psychoanalysis", "copies of The Four Fundamental Concepts of Psychoanalysis"),
            description = content.text("This is a copy of \"The Four Fundamental Concepts of Psychoanalysis\" by Jacques Lacan."),
        },
        {
            id = "philosophy22",
            name = content.plural_text("The Prince", "copies of The Prince"),
            description = content.text("This is a copy of Machiavelli's \"The Prince\".  With intro by Q. Skinner."),
        },
        {
            id = "philosophy23",
            name = content.plural_text("The Revolution of Everyday Life", "copies of The Revolution of Everyday Life"),
            description = content.text("This is a copy of \"The Revolution of Everyday Life\" by Raoul Vaneigem."),
        },
        {
            id = "philosophy24",
            name = content.plural_text("An Essay on Liberation", "copies of An Essay on Liberation"),
            description = content.text("This is a pocket copy of \"An Essay on Liberation\" by Herbert Marcuse.  The cover contains an image of a pelican."),
        },
        {
            id = "philosophy25",
            name = content.plural_text("Either-Or", "copies of Either-Or"),
            description = content.text("This is a copy of \"Either-Or\" by Søren Kierkegaard."),
        },
        {
            id = "philosophy26",
            name = content.plural_text("Allegory of the Cave", "copies of Allegory of the Cave"),
            description = content.text("This is a copy of \"Allegory of the Cave\" by Plato."),
        },
        {
            id = "philosophy27",
            name = content.plural_text("Leviathan", "copies of Leviathan"),
            description = content.text("This is a copy of \"Leviathan\" by Thomas Hobbes."),
        },
        {
            id = "philosophy28",
            name = content.plural_text("Critique Of Pure Reason", "copies of Critique Of Pure Reason"),
            description = content.text("This is a copy of \"Critique Of Pure Reason\" by Immanuel Kant."),
        },
        {
            id = "philosophy29",
            name = content.plural_text("Principles of Philosophy", "copies of Principles of Philosophy"),
            description = content.text("This is a copy of \"Principles of Philosophy\" by René Descartes."),
        },
        {
            id = "philosophy30",
            name = content.plural_text("On the Genealogy of Morality and The Gay Science", "copies of On the Genealogy of Morality and The Gay Science"),
            description = content.text("This is a copy of both \"On the Genealogy of Morality\" and \"The Gay Science\" by Friederich Nietzsche."),
        },
        {
            id = "philosophy31",
            name = content.plural_text("The Myth of Sisyphus", "copies of The Myth of Sisyphus"),
            description = content.text("This is a copy of \"The Myth of Sisyphus\", and other essays, by Albert Camus.  The cover depicts a bare-chested man and a large boulder."),
        },
        {
            id = "philosophy32",
            name = content.plural_text("The Sickness Unto Death", "copies of The Sickness Unto Death"),
            description = content.text("This is a copy of \"The Sickness Unto Death\" by Søren Kierkegaard.  The pages are dotted with post-it notes."),
        },
        {
            id = "philosophy33",
            name = content.plural_text("The Defence of Terrorism", "copies of The Defence of Terrorism"),
            description = content.text("This is a copy of \"The Defence of Terrorism\" by Leon Trotsky.  Despite the title, it does not actually appear to be defending terrorism."),
        },
        {
            id = "philosophy34",
            name = content.plural_text("Enquiry Concerning Political Justice", "copies of Enquiry Concerning Political Justice"),
            description = content.text("This is a copy of \"Enquiry Concerning Political Justice\" by William Godwin.  This thick book is filled with antiquated phrases."),
        },
        {
            id = "philosophy35",
            name = content.plural_text("The Abolition of Work and Other Essays", "copies of The Abolition of Work and Other Essays"),
            description = content.text("This is a copy of \"The Abolition of Work and Other Essays\" by Bob Black.  It is likely that \"The Abolition of Work\" is the most famous essay in this book."),
        },
        {
            id = "philosophy36",
            name = content.plural_text("What is Property?", "copies of What is Property?"),
            description = content.text("This is a copy of \"What is Property?\" by Pierre-Joseph Proudhon.  It looks like this book has a surprisingly long track record of owners."),
        },
        {
            id = "philosophy37",
            name = content.plural_text("The Conquest of Bread", "copies of The Conquest of Bread"),
            description = content.text("This is a copy of \"The Conquest of Bread\" by Peter Kropotkin.  There is a picture of an old philosopher with magnificent beard, instead of bread, on the cover."),
        },
        {
            id = "philosophy38",
            name = content.plural_text("The Trouble with Being Born", "copies of The Trouble with Being Born"),
            description = content.text("This is a copy of \"The Trouble with Being Born\" by Emil Cioran.  This book might have been printed decades before the Cataclysm since the cover is quite weathered."),
        },
        {
            id = "philosophy39",
            name = content.plural_text("The World as Will and Representation", "copies of The World as Will and Representation"),
            description = content.text("This is a copy of \"The World as Will and Representation\" by Arthur Schopenhauer.  It contains a few undecipherable notes and scribbles."),
        },
        {
            id = "philosophy40",
            name = content.plural_text("Up-Wingers: A Futurist Manifesto", "copies of Up-Wingers: A Futurist Manifesto"),
            description = content.text("This is a copy of \"Up-Wingers: A Futurist Manifesto\" by FM-2030.  It seems that the author's real name is Fereidoun M. Esfandiary."),
        },
        {
            id = "philosophy41",
            name = content.plural_text("The Bastiat Collection", "copies of The Bastiat Collection"),
            description = content.text("This is a copy of \"The Bastiat Collection\", a large collection of essays by Frederic Bastiat."),
        },
        {
            id = "philosophy42",
            name = content.plural_text("Anarchy, State, and Utopia", "copies of Anarchy, State, and Utopia"),
            description = content.text("This is a copy of \"Anarchy, State, and Utopia\" by Robert Nozick, one of the most influential books of modern libertarianism."),
        },
        {
            id = "philosophy43",
            name = content.plural_text("Socialism", "copies of Socialism"),
            description = content.text("This is a copy of \"Socialism\" by Ludwig von Mises, a critical examination of socialism."),
        },
        {
            id = "philosophy44",
            name = content.plural_text("The ABC of Communism", "copies of The ABC of Communism"),
            description = content.text("This is a copy of \"The ABC of Communism\" by Nikolai Bukharin, one of the most influential books of early Marxism-Leninism."),
        },
        {
            id = "philosophy45",
            name = content.plural_text("Anti-Capitalist Mentality", "copies of Anti-Capitalist Mentality"),
            description = content.text("This is a copy of \"Anti-Capitalist Mentality\" by Ludwig von Mises."),
        },
    }
    content.add(book)
end

do
    -- isbn13: 9780312003098
    local book = content.Item {
        id = "book_nonf_hard_phil_aesth",
        name = content.plural_text("Aesthetics: A Critical Anthology", "copies of Aesthetics"),
        description = content.text("This hardbound anthology presents a collection of readings, scholarly works, and critical analyses on the subject of beauty."),
        mass_milligrams = 1139000,
        volume_ml = 1625,
        longest_side_mm = 240,
        price_cents = 6499,
        copy_from = "book_nonf_hard_phil_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 2160,
        fun = 1,
        chapters = 48,
        scannable = true,
    }
    content.add(book)
end

do
    -- isbn13: 9780199232383
    local book = content.Item {
        id = "book_nonf_hard_phil_phinfo",
        name = content.plural_text("The Philosophy of Information", "copies of The Philosophy of Information"),
        description = content.text("This university text details a critical investigation of the conceptual nature and basic principles of information.  The student will gain a thorough appreciation of the conceptual frameworks commonly used to describe and advance semantic investigations."),
        mass_milligrams = 800000,
        volume_ml = 1425,
        longest_side_mm = 240,
        price_cents = 8391,
        copy_from = "book_nonf_hard_phil_tpl",
    }
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 9,
        read_time_turns = 2160,
        fun = 1,
        chapters = 18,
        scannable = true,
    }
    content.add(book)
end
