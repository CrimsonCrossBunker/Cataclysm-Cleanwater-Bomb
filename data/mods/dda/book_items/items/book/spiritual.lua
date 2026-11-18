local content = require("ccb").content

do
    local book = content.Item {
        id = "mycenacean_hymns",
        name = content.plural_text("Mycenacean Hymns", "copies of Mycenacean Hymns"),
        description = content.text("A vellum book containing the hymns central to the Marloss faith.  As the verses lead into each other, the text sings of unity and promised paradise."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible1",
        name = content.plural_text("King James Bible", "copies of the King James Bible"),
        description = content.text("An English translation of the Christian Bible, which originated in England in the early 1600s."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible2",
        name = content.plural_text("Eastern Orthodox Bible", "copies of the Eastern Orthodox Bible"),
        description = content.text("An English copy of the Eastern Orthodox translation of the Christian Bible."),
        mass_milligrams = 428000,
        volume_ml = 1250,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible3",
        name = content.plural_text("Gideon Bible", "copies of the Gideon Bible"),
        description = content.text("An English translation of the Christian Bible, distributed free of charge by Gideons International."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible4",
        name = content.plural_text("New American Bible", "copies of the New American Bible"),
        description = content.text("An English translation of the Bible, first published in 1970.  It is accepted by the Catholic dioceses of the United States of America and the Philippines."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible5",
        name = content.plural_text("The New World Translation of the Holy Scriptures", "copies of the New World Translation of the Holy Scriptures"),
        description = content.text("An English translation of the Bible published by the Watch Tower Bible and Tract Society, used and distributed by Jehovah's Witnesses."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible6",
        name = content.plural_text("Holman Christian Bible", "copies of the Holman Christian Bible"),
        description = content.text("An English translation of the Christian Bible by Holman Bible Publishers, developed by the Southern Baptist Convention.  It is primarily used within Baptist circles."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible7",
        name = content.plural_text("Douay-Rheims Bible", "copies of the Douay-Rheims Bible"),
        description = content.text("An uncommon English translation of the Christian Bible, completed in 1609.  It is based on the Latin Vulgate, and remained popular among traditionalist Catholics."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible8",
        name = content.plural_text("Orthodox Tewahedo Biblical Canon", "copies of the Orthodox Tewahedo Biblical Canon"),
        description = content.text("This is very rare English translation of the Orthodox Tewahedo Biblical Canon, a collection of religious texts that form the basis of the Ethiopian Orthodox Church's faith and doctrine, probably acquired by a immigrant, collector or theologist.  This canon is distinct from the Protestant and Catholic biblical canons, as it contains additional books that are not part of the Hebrew Bible or the Old Testament."),
        mass_milligrams = 850000,
        volume_ml = 2000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bible9",
        name = content.plural_text("The Holy Piby", "copies of The Holy Piby"),
        description = content.text("A compilation of texts and interpretations of the Christian Bible that focus on the history, culture, and religious beliefs of the Rastafarian community.  It aims to provide an alternative perspective on the origins of the world and its people, emphasizing the African roots of the Rastafarian faith."),
        mass_milligrams = 468000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_biblechild_c",
        name = content.plural_text("Children's Catholic Bible", "copies of a Children's Catholic Bibles"),
        description = content.text("A small, lightweight Catholic Bible intended for children, containing a extremely easy to understand English writing and many illustrations."),
        mass_milligrams = 250000,
        volume_ml = 700,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_biblechild_p",
        name = content.plural_text("Children's Protestant Bible", "copies of a Children's Protestant Bibles"),
        description = content.text("A small, lightweight Protestant Bible intended for children, containing a extremely easy to understand English writing and many illustrations."),
        mass_milligrams = 250000,
        volume_ml = 700,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechism",
        name = content.plural_text("The Common Catechism", "copies of The Common Catechism"),
        description = content.text("A hardcover edition of 'The Common Catechism: A Book of Christian Faith', an ecumenical Christian catechism that is the result of Roman Catholic-Protestant dialogue and work."),
        mass_milligrams = 760000,
        volume_ml = 1290,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechism1",
        name = content.plural_text("Catechism of The Catholic Church", "copies of the Catechism of The Catholic Church"),
        description = content.text("A hardcover, updated edition of the 'Catechism of The Catholic Church', a compendium of Catholic doctrine, teachings, beliefs, and moral guidance.  This book serves as a guide for Catholics to understand and deepen their faith, providing a systematic presentation of the essential teachings of the Catholic Church."),
        mass_milligrams = 700000,
        volume_ml = 1140,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechism2",
        name = content.plural_text("Westminster Catechism", "copies of the Westminster Catechism"),
        description = content.text("The Westminster Shorter Catechism and the Westminster Larger Catechism into one single large, hardcover book.  It serves as the doctrinal standard in the Reformed tradition of Protestant Christianity, a concise and systematic summary of Christian beliefs, intended to be used for teaching and instruction (and also one of the Four Forms of Unity, depending on the denomination).  This catechism is also divided into a series of questions and answers, covering various aspects of theology, morality, and Christian living."),
        mass_milligrams = 1100000,
        volume_ml = 2300,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechism3",
        name = content.plural_text("Luther's Catechism", "copies of the Luther's Catechism"),
        description = content.text("The Luther's Small Catechism and the Luther's Large Catechism into one single large, hardcover book.  It contains a summary of Christian doctrine and was intended to be used as a teaching tool for laypeople, particularly parents and pastors, to instruct them in the basic principles of the Christian faith."),
        mass_milligrams = 1100000,
        volume_ml = 2300,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechismbudda",
        name = content.plural_text("Buddhist Catechism", "copies of the Buddhist Catechism"),
        description = content.text("A paperback book written by Henry Steel Olcott and Published in 1881.  It serves as an introductory guide to Buddhism, providing a concise overview of its principles, practices, and history.  The book presents a series of questions and answers that cover various aspects of Buddhism, including the life of the Buddha, the Four Noble Truths, the Eightfold Path, karma, rebirth, meditation, and ethics."),
        mass_milligrams = 400000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechismmuslim",
        name = content.plural_text("Safinatun Najah", "copies of the Safinatun Najah"),
        description = content.text("A hardcover English translation of the Safinatun Najah, a renowned manual of Islamic jurisprudence, specifically focusing on the Shafi'i school of thought.  It serves as a comprehensive guide for Muslims seeking knowledge and understanding of the principles and practices of Islam."),
        mass_milligrams = 630000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechism5",
        name = content.plural_text("Heidelberg Catechism", "copies of the Heidelberg Catechism"),
        description = content.text("A hardcover, updated edition of the 'Heidelberg Catechism', a Protestant confession of faith and also a guide for religious instruction, written in 1563 (and also one of the Three Forms of Unity, or Four Forms of Unity, depending on the denomination).  The contents consists of 129 questions and answers, divided into three main sections: guilt, grace, and gratitude.  Each section addresses a different aspect of the Christian faith and is intended to be memorized and understood by believers."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechism6",
        name = content.plural_text("Philaret Catechism", "copies of the Philaret Catechism"),
        description = content.text("A hardcover English translation of the Philaret Catechism, written by the Metropolitan Philaret of Moscow in the 19th century.  This book serves as a comprehensive guide to the teachings and beliefs of the Eastern Orthodox Church, structured in a question-and-answer format and covers various aspects of Christian doctrine, including theology, morality, sacraments, prayer, and the Ten Commandments."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechism7",
        name = content.plural_text("Keach's Catechism", "copies of the Keach's Catechism"),
        description = content.text("A hardcover edition of the Keach's Catechism, a Reformed Baptist catechism consisting of a set of basic questions and answers from scripture teaching readers the basics of the Baptist faith."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_catechism8",
        name = content.plural_text("Pentecostal Catechism", "copies of the Pentecostal Catechism"),
        description = content.text("A hardcover edition of the Pentecostal Catechism, a comprehensive guide to the beliefs, practices, and teachings of the Pentecostal movement within Christianity."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_dort",
        name = content.plural_text("Canons of Dort", "copies of the Canons of Dort"),
        description = content.text("A rare English translation of the Canons of Dort, a significant theological document within the Reformed tradition.  It consists of five main points: The Corruption of Human Nature, Unconditional Election, Limited Atonement, Irresistible Grace and Perseverance of the Saints.  It is also one of the Three Forms of Unity, or Four Forms of Unity, depending on the denomination."),
        mass_milligrams = 200000,
        volume_ml = 400,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_confession",
        name = content.plural_text("Confession of Faith", "copies of the Confession of Faith"),
        description = content.text("A rare English translation of the Confession of Faith, also known as the Belgic Confession.  It is a collection of documents in Christian theology and written statements of belief or doctrines.  These confessions aim to summarize and articulate the core beliefs of particular Christian denominations and traditions.  It also serve as a guide for the members of the church to understand and uphold the essential teachings of their faith.  It is also one of the Three Forms of Unity, or Four Forms of Unity, depending on the denomination."),
        mass_milligrams = 420000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_orthodox",
        name = content.plural_text("The Orthodox Church", "copies of The Orthodox Church"),
        description = content.text("A paperback edition of 'The Orthodox Church: An Introduction to Eastern Christianity', written by Timothy Ware.  This book provides a comprehensive overview of the history, theology, and practices of the Eastern Orthodox Church, and an introduction to the Orthodox faith for those unfamiliar with it, as well as a deeper exploration for those seeking to deepen their understanding."),
        mass_milligrams = 269000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_didascalia",
        name = content.plural_text("Didascalia Apostolorum", "copies of the Didascalia Apostolorum"),
        description = content.text("A paperback English translation of the Didascalia Apostolorum, an ancient Christian text that provides instructions and guidelines for the organization and governance of the early Christian Church.  The Didascalia Apostolorum is attributed to the Twelve Apostles, and is believed to have been written in the third century AD."),
        mass_milligrams = 400000,
        volume_ml = 800,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_ladder",
        name = content.plural_text("The Ladder of Divine Ascent", "copies of The Ladder of Divine Ascent"),
        description = content.text("A commercial-grade, hardcover English edition of The Ladder of Divine Ascent, a well-known spiritual guidebook written in the 6th century by John Climacus, an Orthodox Christian monk.  This book is composed of many chapters, each representing a rung on the ladder, symbolizing the spiritual journey towards union with God."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_jaiva",
        name = content.plural_text("Jaiva Dharma", "copies of the Jaiva Dharma"),
        description = content.text("A paperback English translation of the Jaiva Dharma, a significant philosophical and devotional book written by Srila Bhaktivinoda Thakura, a prominent spiritual leader and philosopher in the Gaudiya Vaishnava Hindu tradition.  This book delves into the essential teachings of the Bhagavad-gita and the Srimad-Bhagavatam, providing deep insights into the nature of the soul, its relationship with God, and the process of spiritual realization."),
        mass_milligrams = 630000,
        volume_ml = 1004,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_zoro",
        name = content.plural_text("Book of the Counsels of Zoroaster", "copies of the Book of the Counsels of Zoroaster"),
        description = content.text("This is a rare English translation of the 'Book of the Counsels of Zoroaster', also known as 'Pand-namag i Zardust', a post-Sasanian compendium of apothegms intended to instruct every Zoroastrian male, upon his attaining the age of fifteen years, in fundamental religious and ethical principles, as well as in the daily duties incumbent upon him."),
        mass_milligrams = 830000,
        volume_ml = 1500,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_anglican",
        name = content.plural_text("Anglican Book of Common Prayer", "copies of the Anglican Book of Common Prayer"),
        description = content.text("A hardcover edition of the Anglican Book of Common Prayer.  It once held great significance in the Anglican Church, but still contain a collection of liturgical prayers, rites, catechisms and instructions that provide a standardized format for various religious services and ceremonies."),
        mass_milligrams = 720000,
        volume_ml = 1100,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_kebra",
        name = content.plural_text("Kebra Negast", "copies of the Kebra Negast"),
        description = content.text("A hardcover English translation of the Kebra Negast, also known as the Glory of the Kings.  It is an ancient Ethiopian text that holds significant religious and historical value for the Ethiopian Orthodox Church and the Rastafarian movement.  It is a compilation of sacred stories and legends that revolve around the life of King Solomon and the Queen of Sheba, as well as the birth and early life of King Menelik I, the founder of the Ethiopian Empire."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_granth",
        name = content.plural_text("The Guru Granth Sahib", "copies of The Guru Granth Sahib"),
        description = content.text("A single-volume copy of the central religious texts of Sikhism."),
        mass_milligrams = 590000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_hadith",
        name = content.plural_text("Hadith", "copies of Hadith"),
        description = content.text("A Muslim religious text containing an account of the sayings and actions of the prophet Muhammad."),
        mass_milligrams = 398000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_kallisti",
        name = content.plural_text("Principia Discordia", "copies of Principia Discordia"),
        description = content.text("A book that embodies the main beliefs of Discordianism.  It seems to primarily concern chaos, and features a card in the back which informs you that you are now a 'genuine and authorized Pope of Discordia'."),
        mass_milligrams = 292000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_kojiki",
        name = content.plural_text("The Kojiki", "copies of The Kojiki"),
        description = content.text("The oldest extant chronicle of Japan's myths and history, the stories contained in the Kojiki are part of the inspiration behind Shinto practices."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_nihon",
        name = content.plural_text("Nihon Shoki", "copies of the Nihon Shoki"),
        description = content.text("Also known as 'Chronicles of Japan', it is considered one of the two most important and oldest chronicles of ancient Japan, the other being the Kojiki.  The Nihon Shoki covers the history of Japan with a compilation of myths, legends, religious practices, rituals and historical events."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_fudoki",
        name = content.plural_text("Fudoki", "copies of the Fudoki"),
        description = content.text("A somewhat large paperback book containing a extensive compilation of historical records and chronicles that originated in ancient Japan (probably during the Nara and Heian periods).  It covers local legends, folklore, religious beliefs, agricultural practices, dialects, historical events, quantity and quality of resources, boundaries, topography, climate, flora, fauna, and cultural practices of several Japanese provinces at that time."),
        mass_milligrams = 1300000,
        volume_ml = 2000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_ofudekasi",
        name = content.plural_text("Ofudekasi", "copies of the Ofudekasi"),
        description = content.text("A large English translation of the most significant of the three scriptures within the Tenrikyo religious tradition (the other two being the Mikagura-uta and Osashizu).  It serves as an essential text that provides a comprehensive understanding of the fundamental beliefs and doctrines of Tenrikyo."),
        mass_milligrams = 1000000,
        volume_ml = 1500,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_uta",
        name = content.plural_text("Mikagura-uta", "copies of the Mikagura-uta"),
        description = content.text("A English translation of the Mikagura-uta, one of the most significant books within the Tenrikyo Religious Tradition.  It is a collection of hymns and prayers that serve as a guide for the followers of the Tenrikyo."),
        mass_milligrams = 830000,
        volume_ml = 1050,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_osa",
        name = content.plural_text("Osashizu", "copies of the Osashizu"),
        description = content.text("A English translation of the Osashizu, one of the most significant books within the Tenrikyo Religious Tradition.  It serves as a guide for followers of the religion or people wishing to learn about it, providing spiritual teachings, ethical principles, and practical advice on various aspects of life."),
        mass_milligrams = 400000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_tenry",
        name = content.plural_text("Doctrines of Tenrikyo", "copies of the Doctrines of Tenrikyo"),
        description = content.text("A paperback English translation of Tenrikyo's official doctrine.  This book explains the basic teachings of the Tenrikyo Religious Tradition."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_oyasama",
        name = content.plural_text("The Life of Oyasama, Foundress of Tenrikyo", "copies of The Life of Oyasama, Foundress of Tenrikyo"),
        description = content.text("A paperback English translation of Tenrikyo's hagiography of Miki Nakayama, foundress of the Tenrikyo Religious Tradition."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_anecdotes",
        name = content.plural_text("The Anecdotes of Oyasama, Foundress of Tenrikyo", "copies of The Anecdotes of Oyasama, Foundress of Tenrikyo"),
        description = content.text("A paperback English translation of an anthology of anecdotes about Oyasama that were passed down orally by her first followers and later written down and verified."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_mo",
        name = content.plural_text("Buluotuo", "copies of the Buluotuo"),
        description = content.text("This is very rare English translation of the Buluotuo, a sacred epic in Moism, the religion of most Zhuang people, the largest ethnic minority of China.  This book addresses the creation of the Universe and life as well as how to live a religiously meritorious life inside Moism.  This book also contains information on entities, deities, gods, goddesses, prayers, practices and rituals of Moism."),
        mass_milligrams = 370000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_guodian",
        name = content.plural_text("Guodian Texts", "copies of the Guodian Texts"),
        description = content.text("A rare and extensive study and translation of all the manuscripts of The Guodian Chu Slips by Scott Cook.  The original slip-texts include both Taoist and Confucian works that offered fresh information for scholars studying the history of philosophical thought in ancient China."),
        mass_milligrams = 1500000,
        volume_ml = 2300,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_maya",
        name = content.plural_text("Popol Vuh", "copies of the Popol Vuh"),
        description = content.text("A English edition of the Popol Vuh, a sacred book of the K'iche' Maya people, a native group from the Guatemalan highlands.  It is a combination of creation myths, historical narratives, and heroic legends that revolve around the K'iche' people's origins, culture, and the deities that govern their universe."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_aztec",
        name = content.plural_text("Codex Borbonicus", "copies of the Codex Borbonicus"),
        description = content.text("A extremely rare English edition of the Codex Borbonicus, an ancient pre-Columbian Mesoamerican manuscript that provides valuable insights into the religious and ritual practices of the Aztecs.  It contains original pictures, illustrations, detailed information about the tonalpohualli (the sacred 260-day calendar), the xiuhpohualli (the agricultural year), deities, rituals, and ceremonies.  This codex also includes depictions and information of various gods and goddesses, sacrificial rites, and astronomical phenomena."),
        mass_milligrams = 300000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_inca",
        name = content.plural_text("Huarochirí Manuscript", "copies of the Huarochirí Manuscript"),
        description = content.text("A uncommon English edition of the Huarochirí Manuscript, a collection of Quechua narratives that provides valuable insights into the religious beliefs, rituals, and cosmology of the Inca people."),
        mass_milligrams = 450000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_canaanites",
        name = content.plural_text("Ugaritic Texts", "copies of the Ugaritic Texts"),
        description = content.text("A pretty rare English translation of the Ugaritic Texts, a collection of ancient mythological, religious and literature texts regarding the Canaanites.  It contains religious epics such as the Baal Cycle, which recounts the myths surrounding the storm god Baal, as well as hymns, prayers, and rituals that shed light on the religious worldview of the ancient Canaanites and their practices."),
        mass_milligrams = 450000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_kells",
        name = content.plural_text("Book of Kells", "copies of the Book of Kells"),
        description = content.text("A extremely rare English translation of the Book of Kells, a highly decorated and illuminated Celtic manuscript, primarily containing the four Gospels of the New Testament.  This translation mimics perfectly the art and style of the original manuscript, including its elaborate calligraphy, with each letter meticulously designed and adorned with various motifs, including animals, humans, and knotwork patterns."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_leinster",
        name = content.plural_text("Book of Leinster", "copies of the Book of Leister"),
        description = content.text("A incredibly rare English translation of the Book of Leinster, a significant and ancient compilation of Irish literature and history, dating back to the 12th century.  It contains annals, genealogies, historical texts, legal tracts, secular and religious poetry and stories from Irish mythology, such as the epic tale \"Táin Bó Cúailnge\", which tells the story of the legendary warrior Cú Chulainn and the cattle raid of Cooley."),
        mass_milligrams = 1100000,
        volume_ml = 1650,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_welsh",
        name = content.plural_text("Mabinogion", "copies of the Mabinogion"),
        description = content.text("A rare English translation of the Mabinogion, a collection of twelve medieval Welsh tales, dating back to the 11th and 12th centuries.  It provide a valuable insight into the mythology, history, religion and culture of medieval Wales."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_akkadia",
        name = content.plural_text("Atra-Hasis", "copies of the Atra-Hasis"),
        description = content.text("A rare English translation of the Mesopotamian Epic Atra-Hasis.  Named for its protagonist, Atrahasis ('exceedingly wise'), the Atra-Hasis include both a creation myth and one of three surviving Babylonian flood myths."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_sumeria",
        name = content.plural_text("Enki and Ninhursag Myth", "copies of the Enki and Ninhursag Myth"),
        description = content.text("A pretty uncommon English translation of the Enki and Ninhursag Myth, a Sumerian creation myth that explains the origins of the world, humanity, and the gods."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_sumeria1",
        name = content.plural_text("The Descent of Inanna", "copies of The Descent of Inanna"),
        description = content.text("A very rare English translation of the Descent of Inanna, an ancient Sumerian myth that recounts the journey of the goddess Inanna into the underworld, where she seeks to confront her sister Ereshkigal, the Queen of the Underworld."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_helliand",
        name = content.plural_text("Heliand", "copies of the Heliand"),
        description = content.text("A English translation of the Heliand, an Old Saxon epic poem that narrates the life and passion of Jesus Christ.  It begins with the Annunciation to the Virgin Mary and continues with the birth of Jesus.  It then narrates the story of Jesus' childhood, his baptism by John the Baptist, and his public ministry.  This poem also includes various miracles performed by Jesus, such as healing the sick, raising the dead, and calming the storm."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_sirach",
        name = content.plural_text("Alphabet of Sirach", "copies of the Alphabet of Sirach"),
        description = content.text("A rare English translation of the Alphabet of Sirach, a compilation of two lists of proverbs, 22 in Jewish Babylonian Aramaic and 22 in Medieval Hebrew (all translated to English), both arranged as alphabetic acrostics, with each proverb followed by an aggadic commentary."),
        mass_milligrams = 750000,
        volume_ml = 1200,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_navayana",
        name = content.plural_text("The Buddha and His Dhamma", "copies of The Buddha and His Dhamma"),
        description = content.text("A English translation of The Buddha and His Dhamma by B. R. Ambedkar.  It is a interpretation of the Buddhist path and the scripture for those who follow Navayana Buddhism."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_pana",
        name = content.plural_text("Panaturan", "copies of the Panaturan"),
        description = content.text("A extremely rare English translation of the Panaturan, the Holy Scripture of the Kaharingan religion.  It is a guide for its adherents and followers, providing them with spiritual teachings, moral lessons, and principles to live by."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_zhivo",
        name = content.plural_text("Zhivotnaya Kniga", "copies of the Zhivotnaya Kniga"),
        description = content.text("A extremely rare English translation of the Zhivotnaya Kniga (Book of Life).  It is a collection of written and translated Doukhobor oral holy hymns, but this book also has the Russian version alongside the English translations."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_mormon",
        name = content.plural_text("The Book of Mormon", "copies of The Book of Mormon"),
        description = content.text("The sacred text of the Latter Day Saint movement of Christianity, originally published in 1830 by Joseph Smith."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_pastafarian",
        name = content.plural_text("The Gospel of the Flying Spaghetti Monster", "copies of The Gospel of the Flying Spaghetti Monster"),
        description = content.text("A book that embodies the main beliefs of the Church of the Flying Spaghetti Monster.  It seems to involve a lot of pirates and some sort of invisible drunken monster made of pasta."),
        mass_milligrams = 292000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_quran",
        name = content.plural_text("Quran", "copies of Quran"),
        description = content.text("An English translation of the Muslim book of holy scriptures, with explanatory notes and commentaries to aid in understanding."),
        mass_milligrams = 412000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_wicca",
        name = content.plural_text("The Book of Shadows", "copies of The Book of Shadows"),
        description = content.text("A dark hardcover copy of The Book of Shadows.  It serves as a personal journal and reference book for individual witches or covens.  Each practitioner may have their own unique version of The Book of Shadows, which contains their personal rituals, spells, invocations, herbal lore, divination methods, and other magical knowledge.  This one, apart from having a wide range of information directly printed on the pages, also has blank pages for you to write on."),
        mass_milligrams = 300000,
        volume_ml = 1000,
        copy_from = "holybook_satanic",
        looks_like = "holybook_satanic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_wicca1",
        name = content.plural_text("Witchcraft Today", "copies of Witchcraft Today"),
        description = content.text("A hardcover book, written by Gerald Gardner and published in 1954.  It was once considered one of the foundational texts of modern Wicca and played a significant role in popularizing contemporary witchcraft."),
        mass_milligrams = 300000,
        volume_ml = 1000,
        copy_from = "holybook_satanic",
        looks_like = "holybook_satanic",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_wicca2",
        name = content.plural_text("The Spiral Dance", "copies of The Spiral Dance"),
        description = content.text("A hardcover copy of the Spiral Dance, written by Starhawk, a prominent author, and activist in the fields of feminism, spirituality, and environmentalism.  First published in 1979, this book explores the beliefs, practices, and history of the Goddess movement, which is a spiritual and feminist response to patriarchal religions.  The Goddess movement seeks to reclaim and revive the worship of the divine feminine in various forms."),
        mass_milligrams = 300000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_scientology",
        name = content.plural_text("Dianetics", "copies of Dianetics"),
        description = content.text("This book is the canonical text of Scientology.  Written by a science fiction author, it contains self-improvement techniques and musings on psychology called Dianetics."),
        mass_milligrams = 486000,
        volume_ml = 1000,
        price_cents = 550,
        price_postapoc_cents = 550,
        symbol = "?",
        looks_like = "story_book",
        color = "dark_gray",
    }
    book:material("paper", 1)
    book:material("cardboard", 1)
    book:flag("INSPIRATIONAL")
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 600,
        fun = -1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_slack",
        name = content.plural_text("The Book of the SubGenius", "copies of The Book of the SubGenius"),
        description = content.text("A book about the Church of the SubGenius.  It seems to involve a salesman named J. R. \"Bob\" Dobbs and a concept called 'slack'."),
        mass_milligrams = 292000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_mozilla",
        name = content.plural_text("The Book of Mozilla", "copies of The Book of Mozilla"),
        description = content.text("A mysterious deep-red book with the title 'The Book of Mozilla' at the front.  The contents of this book are written in some sort of easy-to-understand computer language and are a collection of prophetic and apocryphal verses of unknown origin."),
        mass_milligrams = 250000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_frog",
        name = content.plural_text("The Blue Book of the Blue Frog", "copies of the Blue Book of the Blue Frog"),
        description = content.text("A curious handwritten blue book of unknown origin.  The contents of this book are complex, regarding stories of the 'Blue Frog', a strange cult called 'The Blue Frog Cult', its prophecies, the rules that the cult's followers must adhere to and also the practices, religious and political hierarchy of this cult.  Not much for a scavenger."),
        mass_milligrams = 320000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_mahayana",
        name = content.plural_text("The Mahayana Sutras", "copies of The Mahayana Sutras"),
        description = content.text("A hardcover English translation of the Mahayana Sutras, a collection of scriptures that form the foundation of Mahayana Buddhism.  Those cover a wide range of topics and teachings, including, but not limited to, discourses on meditation, ethics, philosophy, cosmology, and the nature of reality."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_tibetan",
        name = content.plural_text("Tibetan Buddhist Canon", "copies of the Tibetan Buddhist Canon"),
        description = content.text("A hardcover English translation of the Tibetan Buddhist Canon, also known as the Kangyur and Tengyur, or Vajrayana Canon.  It contains a vast collection of sacred texts that form the basis of the Buddhist teachings in Tibetan Buddhism.  It consists of two main parts: the Kangyur, which contains the translated words of the Buddha, and the Tengyur, which comprises commentaries by Indian and Tibetan scholars."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_gita",
        name = content.plural_text("The Bhagavad Gita", "copies of The Bhagavad Gita"),
        description = content.text("A hardcover English translation of The Bhagavad Gita, a 700-verse Hindu scripture.  It is written in the form of a dialogue between Prince Arjuna and the god Krishna, who serves as his charioteer.  The conversation takes place on the battlefield of Kurukshetra just before the start of a great war between two factions of a royal family."),
        mass_milligrams = 350000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_mahabharata",
        name = content.plural_text("The Mahabharata", "copies of The Mahabharata"),
        description = content.text("A large and complete hardcover English translation of The Mahabharata, the most revered and significant ancient texts in Indian literature and Hindu mythology.  It is an epic narrative that has been passed down through generations and has been a source of inspiration and guidance for millions of people before and possibly during and after the Cataclysm.  The epic is divided into 18 books or parvas, each focusing on different aspects of the story, such as the genealogy of the Pandavas, the education of the Pandavas, and the great war of Kurukshetra."),
        mass_milligrams = 800000,
        volume_ml = 1200,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_ramayana",
        name = content.plural_text("The Ramayana", "copies of The Ramayana"),
        description = content.text("A complete hardcover English translation of The Ramayana, an ancient Indian epic that holds great religious and cultural significance in Hinduism.  It is considered one of the two major Sanskrit epics of ancient Indian literature and tells the story of Prince Rama, an incarnation of Lord Vishnu, who embarks on a journey to rescue his wife Sita from the demon king Ravana.  The epic is divided into seven books, known as Kandas, and presents a narrative that encompasses themes of devotion, righteousness, duty, honor, love, and the triumph of good over evil."),
        mass_milligrams = 800000,
        volume_ml = 1200,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_puranas",
        name = content.plural_text("The Puranas", "copies of The Puranas"),
        description = content.text("A hardcover English translation of The Puranas, a collection of ancient Indian texts that form an integral part of Hindu literature.  They are considered to be among the oldest and most authoritative scriptures in Hinduism, alongside the Vedas.  It consist of a vast collection of narratives, legends, genealogies, cosmology, theology, philosophy, and rituals related to Hinduism, and are classified into two main categories: Mahapuranas (major Puranas) and Upapuranas (minor Puranas)."),
        mass_milligrams = 600000,
        volume_ml = 1150,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_agamas",
        name = content.plural_text("The Agamas", "copies of The Agamas"),
        description = content.text("A paperback English translation of The Agamas, a collection of scriptures in Hinduism that provide detailed guidelines for rituals, temple construction, worship practices, and philosophical teachings, and are considered authoritative texts by several Hindu sects, particularly those that follow the Shaiva and Shakta traditions."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_jagamas",
        name = content.plural_text("The Jain Agamas", "copies of the Jain Agamas"),
        description = content.text("A paperback English translation of the Jain Agamas, the most authoritative and sacred scriptures in Jainism.  The Jain Agamas consist of two main categories: the Angas and the Upangas.  The Angas are considered the primary scriptures, while the Upangas are supplementary texts that provide further explanations and commentaries on various aspects of Jain philosophy and practice."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_sutras",
        name = content.plural_text("The Sutras of the Buddha", "copies of The Sutras of the Buddha"),
        description = content.text("A collection of discourses attributed to the Buddha and his close disciples."),
        mass_milligrams = 496000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_zara",
        name = content.plural_text("The Zara Avesta", "copies of the Zara Avesta"),
        description = content.text("A rare hardcover English translation of the Zara Avesta, a collection of sacred hymns, prayers, and liturgies, which are believed to have been revealed by Zoroaster himself.  It is considered an essential guide to living a righteous life in Zoroastrianism, as it provides moral teachings, ethical principles, and spiritual insights."),
        mass_milligrams = 650000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_theogony",
        name = content.plural_text("Theogony", "copies of the Theogony"),
        description = content.text("A paperback English translation of the Theogony, a Greek epic poem attributed to the ancient poet Hesiod.  It is one of the oldest surviving works of Greek literature and provides a comprehensive account of the origins and genealogies of the Greek gods, as well as the creation of the universe and the establishment of divine order."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_orphic",
        name = content.plural_text("The Orphic Hymns", "copies of The Orphic Hymns"),
        description = content.text("A paperback English translation of The Orphic Hymns, a collection of ancient Greek hymns attributed to the legendary poet Orpheus.  These hymns are a significant source of information about Greek religion, philosophy, and literature.  It is divided in a set of 88 hymns, divided into 10 sections, and the hymns are dedicated to various gods and goddesses in the Greek pantheon, as well as to heroes and abstract concepts."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_golden",
        name = content.plural_text("The Orphic Gold Tablets", "copies of The Orphic Gold Tablets"),
        description = content.text("A paperback English translation of the many texts, hymns and inscriptions found in the Orphic Gold Tablets, a series of ancient Greek texts found on gold leaves, dating back to the 4th century BCE.  This book contain Orphic teachings and rituals, which are believed to have been used by initiates in Orphic mystery cults, offering guidance on purification, initiation, and the afterlife, as well as instructions for living a virtuous life in accordance with the Greek gods' will."),
        mass_milligrams = 300000,
        volume_ml = 900,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_romancult",
        name = content.plural_text("Res Gestae Divi Augusti", "copies of the Res Gestae Divi Augusti"),
        description = content.text("A rare, paperback English translation of the Res Gestae Divi Augusti, or 'Deeds of the Divine Augustus', a inscription commissioned by the Roman Emperor Augustus himself.  It is a list of his accomplishments and claims to divine status, emphasizing his role in the Roman Imperial Cult.  This inscription provides insight into the religious beliefs and practices surrounding the emperor during these stages of the Roman Imperial Cult."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_romancult2",
        name = content.plural_text("Historia Augusta", "copies of the Historia Augusta"),
        description = content.text("A large, rare hardcover English translation of the Historia Augusta, a collection of biographies of Roman emperors.  It also contains information about the Imperial Roman Cult, including its rituals, symbols, and the role of such emperors in the cult."),
        mass_milligrams = 600000,
        volume_ml = 1300,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_corpus",
        name = content.plural_text("The Corpus Hermeticum", "copies of The Corpus Hermeticum"),
        description = content.text("A rare, paperback English translation of The Corpus Hermeticum, a collection of ancient philosophical and religious texts that are attributed to Hermes Trismegistus, a legendary figure in ancient Egyptian and Greek mythology.  The contents of this book consists of a series of dialogues or discourses that explore various philosophical and theological concepts.  These texts cover a wide range of topics, including cosmology, theology, metaphysics, ethics, and spirituality at the time.  The overarching theme throughout the Corpus Hermeticum is the pursuit of spiritual knowledge and the attainment of divine wisdom."),
        mass_milligrams = 620000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_mithraic",
        name = content.plural_text("The Mithraic Inscriptions", "copies of The Mithraic Inscriptions"),
        description = content.text("A commercial-grade, paperback English edition of The Mithraic Inscriptions, a book that explains the ancient Mithraic religion and its various inscriptions, artifacts, characteristics and rituals.  The book, written by a team of scholars and experts in the field, aims to provide a comprehensive understanding of the Mithraism and its significance in the ancient world."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_tengriism",
        name = content.plural_text("Tengriism: The Religion of Ancient Mongolia", "copies of Tengriism: The Religion of Ancient Mongolia"),
        description = content.text("A paperback English edition of the Tengriism: The Religion of Ancient Mongolia.  This book contains epics, oral traditions and everything else related to Tengriism, including information about the Khans of Mongolia, shamanic rituals and folklore."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_chinese",
        name = content.plural_text("Classic of Mountains and Seas", "copies of the Classic of Mountains and Seas"),
        description = content.text("A hardcover English translation of the Classic of Mountains and Seas (Shan Hai Jing).  This book primarily focuses on the description of various mythical creatures, gods, goddesses, rituals and geographical features of ancient China."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_koreantrip",
        name = content.plural_text("Tripitaka Koreana", "copies of the Tripitaka Koreana"),
        description = content.text("An extremely large, huge English translation of the Tripitaka Koreana, a Korean collection of the Tripitaka that can be considered as the Korean Canon."),
        mass_milligrams = 15000000,
        volume_ml = 20000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_hawaii",
        name = content.plural_text("Moʻolelo", "copies of the Moʻolelo"),
        description = content.text("A grass-cover English edition of the Moʻolelo, a collection of traditional Hawaiian stories, texts and oral traditions, that have been compiled, translated, and documented in written form.  This book also includes information on the deities and entities of the traditional religion of Hawaii, alongside rituals and practices."),
        mass_milligrams = 550000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    book:material("paper", 1)
    book:material("dry_plant", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_maori",
        name = content.plural_text("Te Ao Māori", "copies of the Te Ao Māori"),
        description = content.text("A collection of written oral traditions of the religion of the Maori people, including the Whakapapa (genealogy and the relationships between the living, the dead, and the natural world), the Tikanga (customs, traditions, and protocols that govern the daily lives of the Maori people), Waiata (songs that play a significant role in the Traditional Maori Religion), Pepeha (a personal statement that outlines one's whakapapa, or genealogy, and connection to the land) and Taonga Tūtahi (sacred treasures and objects that hold spiritual significance for the Maori people), as well as inscriptions regarding the deities, entities and religious traditions of the Maori Religion."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_native",
        name = content.plural_text("The Native Religion of New England", "copies of The Native Religion of New England"),
        description = content.text("A collection of written oral traditions and written records regarding the religious tradition of the many native groups and tribes of New England (such as the Wampanoag, Narragansett, Mohegan, and Penobscot).  This book also contain information regarding the deities, entities and religious characteristics and hierarchy of these groups, as well as historical, geographical, social, political and cultural information."),
        mass_milligrams = 700000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_cao",
        name = content.plural_text("The Compilation of Divine Messages", "copies of The Compilation of Divine Messages"),
        description = content.text("A hardcover English translation of the Thanh Ngon Hiep Tuyen (Compilation of Divine Messages), a compilation of divine messages received by Cao Dai mediums during séances in Cao Dai temples.  These messages are believed to be communication from various divine beings, including saints, sages, and deities.  The mediums serve as channels through which these messages are transmitted to the followers."),
        mass_milligrams = 700000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_egypt",
        name = content.plural_text("The Pyramid Texts", "copies of The Pyramid Texts"),
        description = content.text("A hardcover, English translation of The Pyramid Texts.  These texts were intended to guide the deceased pharaohs through the Egyptian afterlife, providing them with magical spells, hymns, and instructions for their journey.  The Pyramid Texts contain a wealth of information about ancient Egyptian beliefs in the afterlife, the gods, and the role of the pharaoh as a mediator between the mortal world and the divine."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_egypt1",
        name = content.plural_text("The Coffin Texts", "copies of The Coffin Texts"),
        description = content.text("A hardcover, English translation of The Coffin Texts, a collection of magical spells and texts originally inscribed on the inner surfaces of wooden coffins.  These texts were intended to protect the deceased and ensure their safe passage through the Egyptian afterlife.  The Coffin Texts provide a insight into the religious beliefs of ancient Egyptians and its contemporary revival, Kemeticism."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_egypt2",
        name = content.plural_text("The Book of the Dead", "copies of The Book of the Dead"),
        description = content.text("A hardcover, English translation of the Book of the Dead, a collection of funerary texts dating from the New Kingdom to the Greco-Roman period and contains spells and instructions to help the deceased navigate the Egyptian afterlife."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_umbanda",
        name = content.plural_text("Orishas and Their Deities", "copies of Orishas and Their Deities"),
        description = content.text("A paperwork English edition of the Orishas and Their Deities (Orixás e Suas Divindades), written by José Honorato do Rego.  This book provides an extensive overview of the orishas and their associated deities.  It delves into the history, characteristics, and roles of these divine beings within the Umbanda religion, a syncretic Afro-Brazilian religion that combines elements of African, Native Brazilian, and European traditions."),
        mass_milligrams = 350000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_taoism",
        name = content.plural_text("The Tao Te Ching", "copies of The Tao Te Ching"),
        description = content.text("A stylized, hardcover English translation of the Tao Te Ching, also known as the Dao De Jing.  It is a Chinese philosophical and spiritual text believed to have been written by Laozi, a legendary figure in ancient Chinese history, and is considered one of the most important works in Taoism, an ancient Chinese philosophy and religion that emphasizes living in harmony with the Tao."),
        mass_milligrams = 800000,
        volume_ml = 1200,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_confucian",
        name = content.plural_text("The Four Books and Five Classics", "copies of The Four Books and Five Classics"),
        description = content.text("A large hardcover book containing the two collections of ancient Chinese texts that have played a significant role in shaping Chinese culture, education, and philosophy.  These texts are considered foundational works in Confucianism and have been studied by scholars and students for centuries."),
        mass_milligrams = 1000000,
        volume_ml = 1700,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_daime",
        name = content.plural_text("Cruzeiro", "copies of the Cruzeiro"),
        description = content.text("An English collection of teachings from Raimundo Irineu Serra, the founder of Santo Daime, a syncretic religious movement that combines elements of Christianity, African traditions, and Native Brazilian beliefs.  It is considered a sacred scripture by the movement's followers."),
        mass_milligrams = 350000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_candomble",
        name = content.plural_text("The Ogam and Ipade", "copies of The Ogam and Ipade"),
        description = content.text("A good-sized book containing the Ogam (Ogã, a collection of sacred hymns that praise the Orishas, sung during rituals and ceremonies, an essential part of the worship and devotion to the deities), and the Ipade (Ipadê, a collection of sacred stories, myths, and legends that explain the origins of the Orishas, the creation of the world, and the history of the religion), directly linked to Afro-Brazilian religions such as Umbanda and Candomble."),
        mass_milligrams = 900000,
        volume_ml = 1300,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_siddur",
        name = content.plural_text("Siddur", "Siddurim"),
        description = content.text("This is a lightweight collection of prayers and blessings that are recited by Jews during various parts of their daily lives, religious ceremonies, and festivals."),
        mass_milligrams = 450000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_tanakh",
        name = content.plural_text("Tanakh", "copies of Tanakh"),
        description = content.text("A single-volume book containing the complete canon of the Jewish Bible."),
        mass_milligrams = 512000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_torah_scroll",
        name = content.plural_text("Torah", "copies of the Torah"),
        description = content.text("The five books of Moses, written on animal skin by a trained scribe in accordance with the laws and customs of traditional Jewish calligraphy and bound onto wooden rollers.  Once very expensive, it would now be beyond price, if there are any Jewish communities left to use it."),
        mass_milligrams = 12000000,
        volume_ml = 24000,
        price_cents = 4000000,
        price_postapoc_cents = 200,
        longest_side_mm = 480,
        copy_from = "holybook_abstract",
    }
    book:material("leather", 1)
    book:material("wood", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_tripitaka",
        name = content.plural_text("The Tripitaka", "copies of The Tripitaka"),
        description = content.text("A collection of sacred Buddhist writings describing their canons of scriptures."),
        mass_milligrams = 513000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_upanishads",
        name = content.plural_text("The Upanishads", "copies of The Upanishads"),
        description = content.text("A collection of sacred Hindu writings regarding the nature of reality and describing the character and form of human salvation."),
        mass_milligrams = 482000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_vedas",
        name = content.plural_text("The Four Vedas", "copies of The Four Vedas"),
        description = content.text("A single volume containing all four Vedas, which are the oldest scriptures of Hinduism."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_babylon",
        name = content.plural_text("Enuma Elish", "copies of the Enuma Elish"),
        description = content.text("A paperback English translation of the Enuma Elish, an ancient collection originally written in seven tablets that contain the Babylonian creation myth and cosmology.  It describes the birth of the gods, the formation of the universe, and the struggle for power among various deities."),
        mass_milligrams = 500000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_havamal",
        name = content.plural_text("Hávamál", "copies of Hávamál"),
        description = content.text("An English translation of several Old Norse poems.  The poems contain proverbs and stories attributed to the god Odin, many transcribed from oral history."),
        mass_milligrams = 292000,
        volume_ml = 750,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_ginza",
        name = content.plural_text("Ginza Rabba", "copies of the Ginza Rabba"),
        description = content.text("A large English translation of the Ginza Rabba, also known as The Book of Adam, a scripture Sacred for the Mandaeans.  It is a compilation of various oral teachings and written texts, including literature on a wide variety of topics such as liturgy, hymns, theological texts, didactic texts, as well as both religious and secular poetry."),
        mass_milligrams = 1000000,
        volume_ml = 1500,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_ginza1",
        name = content.plural_text("Qolastā", "copies of the Qolastā"),
        description = content.text("A English translation of the Qolastā, the canonical prayer book of the Mandaeans."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_ginza2",
        name = content.plural_text("Drasa d-Yahya", "copies of the Drasa d-Yahya"),
        description = content.text("A English translation of the Drasa d-Yahya, also known as the Mandaean Book of John.  It contains accounts of John's life and miracles, as well as a number of polemical conversations with Jesus and tractates where Anush Uthra (Enosh) performs miracles in the style of Jesus's deeds in Jerusalem."),
        mass_milligrams = 368000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bahai",
        name = content.plural_text("Kitáb-i-Aqdas", "copies of the Kitáb-i-Aqdas"),
        description = content.text("A hardcover English translation of the Kitáb-i-Aqdas, also known as The Most Holy Book.  Written by Baha'u'llah, the founder of the Baha'i Faith, in a poetic and mystical style.  It encompasses a wide range of topics, including the nature of God, the purpose of human existence, the role of religion in society, and the principles governing human conduct.  It also contains laws and regulations that govern various aspects of Baha'i life, such as marriage, family life, and the administration of the Baha'i community."),
        mass_milligrams = 1130000,
        volume_ml = 1290,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bahai1",
        name = content.plural_text("Kitáb-i-Íqán", "copies of the Kitáb-i-Íqán"),
        description = content.text("A hardcover English translation of the Kitáb-i-Íqán, also known as the Book of Certitude.  It was written by Baha'u'llah, the founder of the Baha'i Faith, and addresses theological and philosophical aspects of religion, provides guidance on understanding spiritual truth and recognizing divine messengers throughout history.  This book also explores themes such as the nature of God, the purpose of religion, the progression of revelation, and the spiritual significance of the Baha'i Faith in relation to other religions."),
        mass_milligrams = 1000000,
        volume_ml = 1035,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bahai2",
        name = content.plural_text("The Hidden Words", "copies of The Hidden Words"),
        description = content.text("A hardcover English translation of the Kalimát-i-Maknúnih, also known as the Hidden Words.  It was written by Baha'u'llah, the founder of the Baha'i Faith, during his exile in Baghdad.  This book covers a wide range of themes, including love, detachment, unity, humility, justice, and the recognition of God.  Each passage is concise and poetic, expressing profound spiritual truths in a simple yet profound manner.  One distinctive feature of this book is its universal appeal: while it was revealed within the context of the Bahá'í Faith, its teachings transcend religious boundaries and are applicable to people from all backgrounds."),
        mass_milligrams = 900000,
        volume_ml = 699,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bahai3",
        name = content.plural_text("Baha'i Prayers", "copies of the Baha'i Prayers"),
        description = content.text("A lightweight, paperback book containing a collection of prayers, meditations, and devotional readings that are used for personal reflection, worship, and spiritual nourishment for followers, adherents or sympathizers of the Baha'i Faith."),
        mass_milligrams = 350000,
        volume_ml = 500,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bahai4",
        name = content.plural_text("The Secret of Divine Civilization", "copies of The Secret of Divine Civilization"),
        description = content.text("A hardcover English translation of the Risali-yi-madaniyyih, also known as The Secret of Divine Civilization.  It was written by 'Abdu'l-Bahá, the son of Bahá'u'lláh, founder of the Bahá'í Faith.  This book addresses various aspects of social and economic development, advocating for progressive reforms and offering guidance on how societies can advance spiritually, intellectually, and materially.  It explores principles that can contribute to the progress and well-being of individuals and societies, emphasizing the importance of education, justice, equality, and unity.  A perfect book for rebuilding society once again."),
        mass_milligrams = 826000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_bahai5",
        name = content.plural_text("'Some Answered Questions'", "copies of 'Some Answered Questions'"),
        description = content.text("A hardcover book containing a collection of transcriptions of table talks given by 'Abdu'l-Bahá in 'Akká between 1904 and 1906 in response to questions posed by Laura Dreyfus-Barney, an American Bahá'í resident in Paris, and first published in 1908.  This book provides clarity, guidance, and understanding to Baha'is and those seeking to learn more about the religion."),
        mass_milligrams = 540000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
    }
    content.add(book)
end
