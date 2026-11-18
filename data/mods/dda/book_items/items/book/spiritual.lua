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

do
    local book = content.Item {
        id = "holybook_east",
        name = content.plural_text("Holy Books of the East", "copies of the Holy Books of the East"),
        description = content.text("It is a monumental 50-volume set of English translations of Asian religious texts.  It incorporates the essential sacred texts of Hinduism, Buddhism, Taoism, Confucianism, Zoroastrianism, Jainism, and Islam."),
        mass_milligrams = 1000000,
        volume_ml = 1500,
        copy_from = "holybook_abstract",
        variant_kind = "generic",
    }
    book:variants {
        {
            id = "holybook_east1",
            name = content.plural_text("Sacred Book of the East Vol. 1", "copies of the first volume of the Sacred Books of the East"),
            description = content.text("It contains The Upanishads, part 1/2: Khândogya Upanishad, Talavakâra (or Kena-Upanishad), Aitareya-Âranyaka, Kaushîtaki-Brâhmana and Vâjasaneyi-Sâmhita Upanishad."),
            append = true,
        },
        {
            id = "holybook_east2",
            name = content.plural_text("Sacred Books of the East Vol. 2", "copies of the second volume of the Sacred Books of the East"),
            description = content.text("It contains The Sacred Laws of the Aryas (Dharmasastra), part 1/2: Âpastamba, Gautama, Vâsishtha and Baudhâyana."),
            append = true,
        },
        {
            id = "holybook_east3",
            name = content.plural_text("Sacred Books of the East Vol. 3", "copies of the third volume of the Sacred Books of the East"),
            description = content.text("It contains The Sacred Books of China, part 1/6, the texts of Confucianism: The Shû King (Classic of History), Book of Thang, Books of Yu, Books of Hsiâ, Books of Shang, Books of Kâu, Shih King, the Book of Odes (Classic of Poetry, I - Odes of the Temple and the Altar, II - Minor Odes of the Kingdom, III - Major Odes of the Kingdom, IV - Lessons from the States) and The Hsiâo King (Classic of Filial Piety)."),
            append = true,
        },
        {
            id = "holybook_east4",
            name = content.plural_text("Sacred Books of the East Vol. 4", "copies of the fourth volume of the Sacred Books of the East"),
            description = content.text("It contains The Zend-Avesta, part 1/3: Vendîdâd."),
            append = true,
        },
        {
            id = "holybook_east5",
            name = content.plural_text("Sacred Books of the East Vol. 5", "copies of the fifth volume of the Sacred Books of the East"),
            description = content.text("It contains the Pahlavi Texts, part 1/5: Bundahis, selections of Zâd-sparam, Bahman Yast, Shâyast lâ-Shâyast."),
            append = true,
        },
        {
            id = "holybook_east6",
            name = content.plural_text("Sacred Books of the East Vol. 6", "copies of the sixth volume of the Sacred Books of the East"),
            description = content.text("It contains The Holy Qur'an part 1/2, from chapters I to XVI."),
            append = true,
        },
        {
            id = "holybook_east7",
            name = content.plural_text("Sacred Books of the East Vol. 7", "copies of the seventh volume of the Sacred Books of the East"),
            description = content.text("It contains The Institutes of Vishnu."),
            append = true,
        },
        {
            id = "holybook_east8",
            name = content.plural_text("Sacred Books of the East Vol. 8", "copies of the eighth volume of the Sacred Books of the East"),
            description = content.text("It contains The Bhagavadgitâ: Sanatsugâtîya and Anugitâ."),
            append = true,
        },
        {
            id = "holybook_east9",
            name = content.plural_text("Sacred Books of the East Vol. 9", "copies of the ninth volume of the Sacred Books of the East"),
            description = content.text("It contains The Holy Qur'an, part 2/2, from chapters XVII to CXIV."),
            append = true,
        },
        {
            id = "holybook_east10",
            name = content.plural_text("Sacred Books of the East Vol. 10", "copies of the tenth volume of the Sacred Books of the East"),
            description = content.text("It contains the Dhammapada: a collection of verses, and the Sutta-Nipâta: a collection of discourses, being one of the canonical books of the Buddhists."),
            append = true,
        },
        {
            id = "holybook_east11",
            name = content.plural_text("Sacred Books of the East Vol. 11", "copies of the eleventh volume of the Sacred Books of the East"),
            description = content.text("It contains the Buddhist Suttas: Mahā-parinibbāna Suttanta, Dhamma-kakka-ppavattana Sutta, Tevigga Sutta'anta, Âkankheyya Sutta'a, Ketokhila Sutta'a, Mahâ-Sudassana Sutta'anta and Sabbâsava Sutta'a."),
            append = true,
        },
        {
            id = "holybook_east12",
            name = content.plural_text("Sacred Books of the East Vol. 12", "copies of the twelfth volume of the Sacred Books of the East"),
            description = content.text("It contains the Satapatha Brahmana, part 1/5: Mâdhyandina Shakha from I to II."),
            append = true,
        },
        {
            id = "holybook_east13",
            name = content.plural_text("Sacred Books of the East Vol. 13", "copies of the thirteenth volume of the Sacred Books of the East"),
            description = content.text("It contains the Vinaya Texts, part 1/3: Pātimokkha and Mahâvagga, from I to IV."),
            append = true,
        },
        {
            id = "holybook_east14",
            name = content.plural_text("Sacred Books of the East Vol. 14", "copies of the fourteenth volume of the Sacred Books of the East"),
            description = content.text("It contains The Sacred Laws of the Aryas, part 2/2: Vâsishtha, Baudhâyana and Parisishta."),
            append = true,
        },
        {
            id = "holybook_east15",
            name = content.plural_text("Sacred Books of the East Vol. 15", "copies of the fifteenth volume of the Sacred Books of the East"),
            description = content.text("It contains The Upanishads, part 2/2: Katha Upanishad, Mundaka Upanishad, Taittiriya Upanishad, Brhadaranyaka Upanishad, Svetasvatara Upanishad, Prasna Upanishad and Maitrayani Upanishad."),
            append = true,
        },
        {
            id = "holybook_east16",
            name = content.plural_text("Sacred Books of the East Vol. 16", "copies of the sixteenth volume of the Sacred Books of the East"),
            description = content.text("It contains The Sacred Books of China, part 2/6, the texts of Confucianism: Yi King (I Ching)."),
            append = true,
        },
        {
            id = "holybook_east17",
            name = content.plural_text("Sacred Books of the East Vol. 17", "copies of the seventeenth volume of the Sacred Books of the East"),
            description = content.text("It contains the Vinaya Texts, part 2/3: Mahavagga, from V to X, and Kullavagga, from I to II."),
            append = true,
        },
        {
            id = "holybook_east18",
            name = content.plural_text("Sacred Books of the East Vol. 18", "copies of the eighteenth volume of the Sacred Books of the East"),
            description = content.text("It contains the Pahlavi Texts, part 2/5: Dâdistân-i Dinik and the Epistles of Mânûskihar."),
            append = true,
        },
        {
            id = "holybook_east19",
            name = content.plural_text("Sacred Books of the East Vol. 19", "copies of the nineteenth volume of the Sacred Books of the East"),
            description = content.text("It contains The Fo-sho-hing-tsan-king: a life of Buddha, by Ashvaghosha, and the Bodhisattva."),
            append = true,
        },
        {
            id = "holybook_east20",
            name = content.plural_text("Sacred Books of the East Vol. 20", "copies of the twenty volume of the Sacred Books of the East"),
            description = content.text("It contains the Vinaya Texts, part 3/3: Kullavagga, from IV to XII."),
            append = true,
        },
        {
            id = "holybook_east21",
            name = content.plural_text("Sacred Books of the East Vol. 21", "copies of the twentieth-first volume of the Sacred Books of the East"),
            description = content.text("It contains The Saddharma-Pundarika (or The Lotus of the True Law)."),
            append = true,
        },
        {
            id = "holybook_east22",
            name = content.plural_text("Sacred Books of the East Vol. 22", "copies of the twenty-second volume of the Sacred Books of the East"),
            description = content.text("It contains the Jaina Sutras, part 1/2: Âkârânga sutra and Kalpa sutra."),
            append = true,
        },
        {
            id = "holybook_east23",
            name = content.plural_text("Sacred Books of the East Vol. 23", "copies of the twenty-third volume of the Sacred Books of the East"),
            description = content.text("It contains The Zend-Avesta, part 2/3: Sîrôzahs, Yasts and Nyâyis."),
            append = true,
        },
        {
            id = "holybook_east24",
            name = content.plural_text("Sacred Books of the East Vol. 24", "copies of the twenty-fourth volume of the Sacred Books of the East"),
            description = content.text("It contains the Pahlavi Texts, part 3/5: Dinai Mainog-i khirad, Sikand-Gümanik Vigar and Sad Dar."),
            append = true,
        },
        {
            id = "holybook_east25",
            name = content.plural_text("Sacred Books of the East Vol. 25", "copies of the twenty-fifth volume of the Sacred Books of the East"),
            description = content.text("It contains The Laws of Manu, with extracts from seven commentaries."),
            append = true,
        },
        {
            id = "holybook_east26",
            name = content.plural_text("Sacred Books of the East Vol. 26", "copies of the twenty-sixth volume of the Sacred Books of the East"),
            description = content.text("It contains the Satapatha Brahmana, part 2/5: Mâdhyandina Shakha from III to IV."),
            append = true,
        },
        {
            id = "holybook_east27",
            name = content.plural_text("Sacred Books of the East Vol. 27", "copies of the twenty-seventh volume of the Sacred Books of the East"),
            description = content.text("It contains The Sacred Books of China, part 3/6, the texts of Confucianism: The Li Ki I (Book of Rites)."),
            append = true,
        },
        {
            id = "holybook_east28",
            name = content.plural_text("Sacred Books of the East Vol. 28", "copies of the twenty-eight volume of the Sacred Books of the East"),
            description = content.text("It contains The Sacred Books of China, part 4/6, the texts of Confucianism: The Li Ki II (Book of Rites)."),
            append = true,
        },
        {
            id = "holybook_east29",
            name = content.plural_text("Sacred Books of the East Vol. 29", "copies of the twenty-ninth volume of the Sacred Books of the East"),
            description = content.text("It contains the Grihya-sutras, part 1/2, rules of Vedic domestic ceremonies: Sankhyayana-Grihya-sutra, Āsvalāyana-Grihya-sutra, Paraskara-Grihya-sutra and Khadia-Grihya-sutra."),
            append = true,
        },
        {
            id = "holybook_east30",
            name = content.plural_text("Sacred Books of the East Vol. 30", "copies of the thirtieth volume of the Sacred Books of the East"),
            description = content.text("It contains the Grihya-sutras, part 2/2, rules of Vedic domestic ceremonies: Gobhila, Hiranyakesin, Apastamba and Yajna Paribhashasutras."),
            append = true,
        },
        {
            id = "holybook_east31",
            name = content.plural_text("Sacred Books of the East Vol. 31", "copies of the thirty-first volume of the Sacred Books of the East"),
            description = content.text("It contains The Zend-Avesta, part 3/3: Yasna, Visparad, Afrinagân, Gâhs and miscellaneous fragments."),
            append = true,
        },
        {
            id = "holybook_east32",
            name = content.plural_text("Sacred Books of the East Vol. 32", "copies of the thirty-second volume of the Sacred Books of the East"),
            description = content.text("It contains the Vedic Hymns, part 1/2: Hymns to the Maruts, Hymns to Rudra, Hymns to Vâyu, Hymns to Vâta and a bibliographical list of the more important publications on the Rigveda."),
            append = true,
        },
        {
            id = "holybook_east33",
            name = content.plural_text("Sacred Books of the East Vol. 33", "copies of the thirty-third volume of the Sacred Books of the East"),
            description = content.text("It contains The Minor Law-Books: Brihaspati."),
            append = true,
        },
        {
            id = "holybook_east34",
            name = content.plural_text("Sacred Books of the East Vol. 34", "copies of the thirty-fourth volume of the Sacred Books of the East"),
            description = content.text("It contains the Vedanta-Sutras, part 1/3: Commentary by Sankaracharya, part 1 of 2, and the Adhyâya I–II (Pâda I–II)."),
            append = true,
        },
        {
            id = "holybook_east35",
            name = content.plural_text("Sacred Books of the East Vol. 35", "copies of the thirty-fifth volume of the Sacred Books of the East"),
            description = content.text("It contains The Questions of King Milinda, part 1/2."),
            append = true,
        },
        {
            id = "holybook_east36",
            name = content.plural_text("Sacred Books of the East Vol. 36", "copies of the thirty-sixth volume of the Sacred Books of the East"),
            description = content.text("It contains The Questions of King Milinda, part 2/2."),
            append = true,
        },
        {
            id = "holybook_east37",
            name = content.plural_text("Sacred Books of the East Vol. 37", "copies of the thirty-seventh volume of the Sacred Books of the East"),
            description = content.text("It contains the Pahlavi Texts, part 4/5: Contents of the Nasks."),
            append = true,
        },
        {
            id = "holybook_east38",
            name = content.plural_text("Sacred Books of the East Vol. 38", "copies of the thirty-eight volume of the Sacred Books of the East"),
            description = content.text("It contains the Vedanta-Sutras, part 2/3: Commentary by Sankaracharya, part 2 of 2, and Adhyâya II to IV (Pâda III to IV)."),
            append = true,
        },
        {
            id = "holybook_east39",
            name = content.plural_text("Sacred Books of the East Vol. 39", "copies of the thirty-ninth volume of the Sacred Books of the East"),
            description = content.text("It contains the Texts of Taoism, part 1/2: The Tao Te Ching of Lao Dze (Lao Tsu) and The Writings of Chuang-tse, from I to XVII."),
            append = true,
        },
        {
            id = "holybook_east40",
            name = content.plural_text("Sacred Books of the East Vol. 40", "copies of the fourtieth volume of the Sacred Books of the East"),
            description = content.text("It contains the Texts of Taoism, part 2/2: The Writings of Chuang-tse, from XVII to XXXIII, The Thai-shang tractate of actions and their retributions, other Taoist texts and the Index to volumes 39 and 40."),
            append = true,
        },
        {
            id = "holybook_east41",
            name = content.plural_text("Sacred Books of the East Vol. 41", "copies of the forty-first volume of the Sacred Books of the East"),
            description = content.text("It contains the Satapatha Brahmana, part 3/5: Mâdhyandina Shakha from V to VII."),
            append = true,
        },
        {
            id = "holybook_east42",
            name = content.plural_text("Sacred Books of the East Vol. 42", "copies of the forty-second volume of the Sacred Books of the East"),
            description = content.text("It contains the Hymns of the Atharvaveda, together With Extracts From the Ritual Books and the Commentaries."),
            append = true,
        },
        {
            id = "holybook_east43",
            name = content.plural_text("Sacred Books of the East Vol. 43", "copies of the forty-third volume of the Sacred Books of the East"),
            description = content.text("It contains the Satapatha Brahmana, part 4/5: the Mâdhyandina Shakha VII, IX and X."),
            append = true,
        },
        {
            id = "holybook_east44",
            name = content.plural_text("Sacred Books of the East Vol. 44", "copies of the forty-fourth volume of the Sacred Books of the East"),
            description = content.text("It contains the Satapatha Brahmana, part 5/5: the Mâdhyandina Shakha from XI to XIV."),
            append = true,
        },
        {
            id = "holybook_east45",
            name = content.plural_text("Sacred Books of the East Vol. 45", "copies of the forty-fifth volume of the Sacred Books of the East"),
            description = content.text("It contains the Jaina Sutras, part 2 of 2: Uttaradhyayana Sutra and Sutrakritânga Sutra."),
            append = true,
        },
        {
            id = "holybook_east46",
            name = content.plural_text("Sacred Books of the East Vol. 46", "copies of the forty-sixth volume of the Sacred Books of the East"),
            description = content.text("It contains the Vedic Hymns, part 2/2: Hymns to Agni (Mandalas I to V)."),
            append = true,
        },
        {
            id = "holybook_east47",
            name = content.plural_text("Sacred Books of the East Vol. 47", "copies of the forty-seventh volume of the Sacred Books of the East"),
            description = content.text("It contains the Pahlavi Texts, part 5/5: The Marvels of Zoroastrianism."),
            append = true,
        },
        {
            id = "holybook_east48",
            name = content.plural_text("Sacred Books of the East Vol. 48", "copies of the forty-eighth volume of the Sacred Books of the East"),
            description = content.text("It contains the Vedanta-Sutras, part 3/3, with the commentary of Râmânuja."),
            append = true,
        },
        {
            id = "holybook_east49",
            name = content.plural_text("Sacred Books of the East Vol. 49", "copies of the forty-ninth volume of the Sacred Books of the East"),
            description = content.text("It contains the Buddhist Mahayana Texts, part 1/2: Buddha-karita of Aśvaghosa, the Buddhist Mahayana Texts, part 2/2: Longer Sukhâvati-vyuha and Shorter Sukhâvati-vyuha, Vagrakkhedika, the longer Pragnâ-pâramitâ-hridaya-sutra, the shorter Pragnâ-pâramitâ-hridaya-sutra and the Amitâyur dhyâna-sutra."),
            append = true,
        },
        {
            id = "holybook_east50",
            name = content.plural_text("Sacred Books of the East Vol. 50", "copies of the fiftieth volume of the Sacred Books of the East"),
            description = content.text("It contains a nice general index to the names and subject-matter of the Sacred Books of the East."),
            append = true,
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_nag_hammadi",
        name = content.plural_text("Nag Hammadi Codex", "Nag Hammadi Codices"),
        description = content.text("A translation of some of the gnostic texts and early biblical apocrypha recovered from the Nag Hammadi library in Egypt.  Obviously heretical, but the zombies aren't the type to discriminate."),
        mass_milligrams = 281000,
        volume_ml = 1000,
        copy_from = "holybook_abstract",
        variant_kind = "generic",
    }
    book:variants {
        {
            id = "holybook_nag_hammadi_01",
            name = content.plural_text("Nag Hammadi Codex I", "copies of the first Nag Hammadi Codex"),
            description = content.text("It contains the Prayer of the Apostle Paul, the Apocryphon of James, the Gospel of Truth, the Treatise on the Resurrection, and the Tripartite Tractate."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_02",
            name = content.plural_text("Nag Hammadi Codex II", "copies of the second Nag Hammadi Codex"),
            description = content.text("It contains the Apocryphon of John (version 1), the Gospel of Thomas, the Gospel of Phillip, the Hypostasis of the Archons, On the Origin of the World, the Exegesis of the Soul, and the Book of Thomas the Contender."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_03",
            name = content.plural_text("Nag Hammadi Codex III", "copies of the third Nag Hammadi Codex"),
            description = content.text("It contains the Apocryphon of John (version 2), Holy Book of the Great Invisible Spirit, Eugnostos the Blessed, The Sophia of Jesus Christ, and the Dialogue of the Savior."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_04",
            name = content.plural_text("Nag Hammadi Codex IV", "copies of the fourth Nag Hammadi Codex"),
            description = content.text("It contains the Apocryphon of John (version 1) and Holy Book of the Great Invisible Spirit."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_05",
            name = content.plural_text("Nag Hammadi Codex V", "copies of the fifth Nag Hammadi Codex"),
            description = content.text("It contains Eugnostos the Blessed, the Apocalypse of Paul, the First Apocalypse of James, the Second Apocalypse of James, and the Apocalypse of Adam."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_06",
            name = content.plural_text("Nag Hammadi Codex VI", "copies of the sixth Nag Hammadi Codex"),
            description = content.text("It contains the Acts of Peter and the Twelve Apostles, The Thunder/Perfect Mind, Authoritative Teaching, the Context of Our Great Power, fragments of Plato's Republic, The Discourse of the Eight and Ninth, the Prayer of Thanksgiving, and Asclepius."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_07",
            name = content.plural_text("Nag Hammadi Codex VII", "copies of the seventh Nag Hammadi Codex"),
            description = content.text("It contains the Paraphrase of Shem, the Second Treatise of the Great Seth, Gnostic Apocalypse of Peter, the Teachings of Sylvanus, and the Three Steles of Seth."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_08",
            name = content.plural_text("Nag Hammadi Codex VIII", "copies of the eighth Nag Hammadi Codex"),
            description = content.text("It contains Zostrianos and the Letter of Peter to Philip."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_09",
            name = content.plural_text("Nag Hammadi Codex IX", "copies of the ninth Nag Hammadi Codex"),
            description = content.text("It contains Melchizedek, the Thought of Norea, and the Testimony of Truth."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_10",
            name = content.plural_text("Nag Hammadi Codex X", "copies of the tenth Nag Hammadi Codex"),
            description = content.text("It contains Marsanes."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_11",
            name = content.plural_text("Nag Hammadi Codex XI", "copies of the eleventh Nag Hammadi Codex"),
            description = content.text("It contains the Interpretation of Knowledge, a Valentinian Exposition, Allogenes, and Hypsiphrone."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_12",
            name = content.plural_text("Nag Hammadi Codex XII", "copies of the twelfth Nag Hammadi Codex"),
            description = content.text("It contains the Sentences of Sextus, the Gospel of Truth, and various fragmented texts."),
            append = true,
        },
        {
            id = "holybook_nag_hammadi_13",
            name = content.plural_text("Nag Hammadi Codex XIII", "copies of the thirteenth Nag Hammadi Codex"),
            description = content.text("It contains Trimorphic Protennoia, On the Origin of the World, and various fragmented texts."),
            append = true,
        },
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_satanic",
        name = content.plural_text("The Satanic Bible", "copies of The Satanic Bible"),
        description = content.text("A collection of essays, observations, and rituals published by Anton LaVey in 1969."),
        mass_milligrams = 130000,
        volume_ml = 250,
        price_cents = 550,
        price_postapoc_cents = 50,
        symbol = "?",
        looks_like = "story_book",
        color = "dark_gray",
        variant_kind = "generic",
    }
    book:material("paper", 1)
    book:clear_flags()
    book:flag("INSPIRATIONAL")
    book:book {
        required_level = 0,
        maximum_level = 0,
        intelligence = 8,
        read_time_turns = 600,
        fun = 1,
        chapters = 0,
        scannable = true,
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "holybook_talmud",
        name = content.plural_text("Talmud", "volumes of the Talmud"),
        description = content.text("One of the central texts of Rabbinic Judaism, the Talmud expounds upon the Hebrew Bible with teachings and opinions of thousands of rabbis."),
        mass_milligrams = 2041000,
        volume_ml = 1500,
        copy_from = "holybook_abstract",
        variant_kind = "generic",
    }
    book:variants {
        {
            id = "holybook_talmud_01",
            name = content.plural_text("Talmud, Vol. 1, Tractate Berakhot (Part 1)", "copies of the Talmud, Vol. 1, Tractate Berakhot (Part 1)"),
            description = content.text("This is volume 1 of 51, containing the first part of Tractate Berakhot.  It is concerned with rules relating to the Shema and the Amidah."),
            append = true,
        },
        {
            id = "holybook_talmud_02",
            name = content.plural_text("Talmud, Vol. 2, Tractate Berakhot (Part 2)", "copies of the Talmud, Vol. 2, Tractate Berakhot (Part 2)"),
            description = content.text("This is volume 2 of 51, containing the second part of Tractate Berakhot.  It discusses rules relating to prayers, primarily those before or after eating but it also touches on prayers that occur on special occasions such as hearing thunder or being unexpectedly delivered from danger."),
            append = true,
        },
        {
            id = "holybook_talmud_03",
            name = content.plural_text("Talmud, Vol. 3, Tractate Pe'ah", "copies of the Talmud, Vol. 3, Tractate Pe'ah"),
            description = content.text("This is volume 3 of 51, containing Tractate Pe'ah.  It discusses agriculture, of harvesting, and providing food for the poor."),
            append = true,
        },
        {
            id = "holybook_talmud_04",
            name = content.plural_text("Talmud, Vol. 4, Tractate Demai", "copies of the Talmud, Vol. 4, Tractate Demai"),
            description = content.text("This is volume 4 of 51, containing Tractate Demai.  It discusses rules for dubiously-tithed produce."),
            append = true,
        },
        {
            id = "holybook_talmud_05",
            name = content.plural_text("Talmud, Vol. 5, Tractate Kilayim", "copies of the Talmud, Vol. 5, Tractate Kilayim"),
            description = content.text("This is volume 5 of 51, containing Tractate Kilayim.  It discusses prohibitions on the mixing of different kinds, such as wearing wool and linen clothing or planting anything other than grapes in a vineyard."),
            append = true,
        },
        {
            id = "holybook_talmud_06",
            name = content.plural_text("Talmud, Vol. 6, Tractate Shevi'it (Part 1)", "copies of the Talmud, Vol. 6, Tractate Shevi'it (Part 1)"),
            description = content.text("This is volume 6a of 51, containing the first part of Tractate Shevi'it.  It discusses the Shemitah year, the seventh year where fields must lie fallow."),
            append = true,
        },
        {
            id = "holybook_talmud_07",
            name = content.plural_text("Talmud, Vol. 7, Tractate Shevi'it (Part 2)", "copies of the Talmud, Vol. 7, Tractate Shevi'it (Part 2)"),
            description = content.text("This is volume 7 of 51, containing the second part of Tractate Shevi'it.  It continues the discussion of the Shemitah year, the seventh year where fields must lie fallow."),
            append = true,
        },
        {
            id = "holybook_talmud_08",
            name = content.plural_text("Talmud, Vol. 8, Tractate Terumot (Part 1)", "copies of the Talmud, Vol. 8, Tractate Terumot (Part 1)"),
            description = content.text("This is volume 8 of 51, containing the first part of Tractate Terumot.  It discusses terumot, portions of agriculture produce that are given directly to the Kohanim priestly class."),
            append = true,
        },
        {
            id = "holybook_talmud_09",
            name = content.plural_text("Talmud, Vol. 9, Tractate Terumot (Part 2)", "copies of the Talmud, Vol. 9, Tractate Terumot (Part 2)"),
            description = content.text("This is volume 9 of 51, containing the second part of Tractate Terumot.  It continues the discussion of terumot, portions of agriculture produce that are given directly to the Kohanim priestly class."),
            append = true,
        },
        {
            id = "holybook_talmud_10",
            name = content.plural_text("Talmud, Vol. 10, Tractate Maasrot", "copies of the Talmud, Vol. 10, Tractate Maasrot"),
            description = content.text("This is volume 10 of 51, containing Tractate Maasrot.  It discusses the separation of the harvest into tithes, and the portions given to the Tribe of Levi, the poor, or the people of Jerusalem."),
            append = true,
        },
        {
            id = "holybook_talmud_11",
            name = content.plural_text("Talmud, Vol. 11, Tractate Maaser Sheni", "copies of the Talmud, Vol. 11, Tractate Maaser Sheni"),
            description = content.text("This is volume 11 of 51, containing Tractate Maaser Sheni.  It discusses the practice of consuming a portion of the yearly harvest in Jerusalem, or exchanging it for money used to buy food in Jerusalem to hold a feast."),
            append = true,
        },
        {
            id = "holybook_talmud_12",
            name = content.plural_text("Talmud, Vol. 12, Tractate Challah", "copies of the Talmud, Vol. 12, Tractate Challah"),
            description = content.text("This is volume 12 of 51, containing Tractate Challah.  It discusses the practice of baking bread with the first portion of harvested grain and tithing it as an offering."),
            append = true,
        },
        {
            id = "holybook_talmud_13",
            name = content.plural_text("Talmud, Vol. 13, Tractates Orlah & Bikkurim", "copies of the Talmud, Vol. 13, Tractates Orlah & Bikkurim"),
            description = content.text("This is volume 13 of 51, containing Tractates Orlah and Bikkurim.  Both tractates discuss the practice of letting a fruit tree grow for three years before harvesting it."),
            append = true,
        },
        {
            id = "holybook_talmud_14",
            name = content.plural_text("Talmud, Vol. 14, Tractate Shabbat (Part 1)", "copies of the Talmud, Vol. 14, Tractate Shabbat (Part 1)"),
            description = content.text("This is volume 14 of 51, containing the first part of Tractate Shabbat.  It discusses the thirty-nine types of prohibited labor."),
            append = true,
        },
        {
            id = "holybook_talmud_15",
            name = content.plural_text("Talmud, Vol. 15, Tractate Shabbat (Part 2)", "copies of the Talmud, Vol. 15, Tractate Shabbat (Part 2)"),
            description = content.text("This is volume 15 of 51, containing the second part of Tractate Shabbat.  It discusses the prohibitions of carrying items or transporting animals on Shabbat."),
            append = true,
        },
        {
            id = "holybook_talmud_16",
            name = content.plural_text("Talmud, Vol. 16, Tractate Shabbat (Part 3)", "copies of the Talmud, Vol. 16, Tractate Shabbat (Part 3)"),
            description = content.text("This is volume 16 of 51, containing the third part of Tractate Shabbat.  It discusses the positive commandments of Shabbat, such as lighting candles and eating a festive meal, and continues the discussion of prohibited types of labor."),
            append = true,
        },
        {
            id = "holybook_talmud_17",
            name = content.plural_text("Talmud, Vol. 17, Tractate Eruvin (Part 1)", "copies of the Talmud, Vol. 17, Tractate Eruvin (Part 1)"),
            description = content.text("This is volume 17 of 51, containing the first part of Tractate Eruvin.  It discusses the ways to expand the allowable areas in which one may carrying items or transport items on Shabbat."),
            append = true,
        },
        {
            id = "holybook_talmud_18",
            name = content.plural_text("Talmud, Vol. 18, Tractate Eruvin (Part 2)", "copies of the Talmud, Vol. 18, Tractate Eruvin (Part 2)"),
            description = content.text("This is volume 18 of 51, containing the second part of Tractate Eruvin.  It continues discussing the ways to expand the allowable areas in which one may carrying items or transport items on Shabbat."),
            append = true,
        },
        {
            id = "holybook_talmud_19",
            name = content.plural_text("Talmud, Vol. 19, Tractate Pesachim (Part 1)", "copies of the Talmud, Vol. 19, Tractate Pesachim (Part 1)"),
            description = content.text("This is volume 19 of 51, containing the first part of Tractate Pesachim.  It discusses laws relating to Passover, such as the proper disposal of leaven and the preparation of unleavened bread."),
            append = true,
        },
        {
            id = "holybook_talmud_20",
            name = content.plural_text("Talmud, Vol. 20, Tractate Pesachim (Part 2)", "copies of the Talmud, Vol. 20, Tractate Pesachim (Part 2)"),
            description = content.text("This is volume 20 of 51, containing the second part of Tractate Pesachim.  It continues the discussion of laws relating to Passover, such as whether servants are allowed to slaughter the Passover sacrifice or what to do if the Seder occurs on a Friday night."),
            append = true,
        },
        {
            id = "holybook_talmud_21",
            name = content.plural_text("Talmud, Vol. 21, Tractate Shekalim", "copies of the Talmud, Vol. 21, Tractate Shekalim"),
            description = content.text("This is volume 21 of 51, containing Tractate Shekalim.  It discusses the taxes paid to maintain the Temple and the priesthood."),
            append = true,
        },
        {
            id = "holybook_talmud_22",
            name = content.plural_text("Talmud, Vol. 22, Tractate Yoma", "copies of the Talmud, Vol. 22, Tractate Yoma"),
            description = content.text("This is volume 22 of 51, containing Tractate Yoma.  It discusses the rituals and laws related to Yom Kippur, primarily concerned with the Temple service."),
            append = true,
        },
        {
            id = "holybook_talmud_23",
            name = content.plural_text("Talmud, Vol. 23, Tractate Sukkah", "copies of the Talmud, Vol. 23, Tractate Sukkah"),
            description = content.text("This is volume 23 of 51, containing Tractate Sukkah.  It discusses the rituals and laws related to Sukkot, such as dwelling in the Sukkah and the four species of plants."),
            append = true,
        },
        {
            id = "holybook_talmud_24",
            name = content.plural_text("Talmud, Vol. 24, Tractate Beitzah", "copies of the Talmud, Vol. 24, Tractate Beitzah"),
            description = content.text("This is volume 24 of 51, containing Tractate Beitzah.  It discusses laws common to all Torah-derived holidays, such as prohibitions on work and the proper preparation of food."),
            append = true,
        },
        {
            id = "holybook_talmud_25",
            name = content.plural_text("Talmud, Vol. 25, Tractate Rosh Hashanah", "copies of the Talmud, Vol. 25, Tractate Rosh Hashanah"),
            description = content.text("This is volume 25 of 51, containing Tractate Rosh Hashanah.  It discusses rituals and laws related to Rosh Hashanah, such as blowing the shofar, as well as the proper way to celebrate the festival of a new month."),
            append = true,
        },
        {
            id = "holybook_talmud_26",
            name = content.plural_text("Talmud, Vol. 26, Tractate Taanit", "copies of the Talmud, Vol. 26, Tractate Taanit"),
            description = content.text("This is volume 26 of 51, containing Tractate Taanit.  It discusses laws related to fasting, as well as proper method of praying for rain to avoid famine."),
            append = true,
        },
        {
            id = "holybook_talmud_27",
            name = content.plural_text("Talmud, Vol. 27, Tractate Megillah", "copies of the Talmud, Vol. 27, Tractate Megillah"),
            description = content.text("This is volume 27 of 51, containing Tractate Megillah.  It discusses laws of reading the Book of Esther on Purim, as well as commentary on the story of Esther itself."),
            append = true,
        },
        {
            id = "holybook_talmud_28",
            name = content.plural_text("Talmud, Vol. 28, Tractate Chagigah", "copies of the Talmud, Vol. 28, Tractate Chagigah"),
            description = content.text("This is volume 28 of 51, containing Tractate Chagigah.  It discusses the practice of offering ritual sacrifices at the Temple on festival days, with frequent interruptions to discuss the Book of Genesis."),
            append = true,
        },
        {
            id = "holybook_talmud_29",
            name = content.plural_text("Talmud, Vol. 29, Tractate Moed Katan", "copies of the Talmud, Vol. 29, Tractate Moed Katan"),
            description = content.text("This is volume 29 of 51, containing Tractate Moed Katan.  It discusses Chol HaMoed, the minor holidays in between the first and last days of Sukkot and Passover.  It also has the famous story of the Oven of Akhnai, from which the principle is derived that \"The Torah is not in heaven\"."),
            append = true,
        },
        {
            id = "holybook_talmud_30",
            name = content.plural_text("Talmud, Vol. 30, Tractate Yevamot (Part 1)", "copies of the Talmud, Vol. 30, Tractate Yevamot (Part 1)"),
            description = content.text("This is volume 30 of 51, containing the first part of Tractate Yevamot.  It deals with the laws of Yibbum, often translated as \"Levirate marriage,\" the requirement of a man to marry his brother's widow."),
            append = true,
        },
        {
            id = "holybook_talmud_31",
            name = content.plural_text("Talmud, Vol. 31, Tractate Yevamot (Part 2)", "copies of the Talmud, Vol. 31, Tractate Yevamot (Part 2)"),
            description = content.text("This is volume 31 of 51, containing the second part of Tractate Yevamot.  It continues the discussion of the laws of Yibbum, often translated as \"Levirate marriage,\" and the circumstances in which it does or does not apply."),
            append = true,
        },
        {
            id = "holybook_talmud_32",
            name = content.plural_text("Talmud, Vol. 32, Tractate Ketubot (Part 1)", "copies of the Talmud, Vol. 32, Tractate Ketubot (Part 1)"),
            description = content.text("This is volume 32 of 51, containing the first part of Tractate Ketubot.  It discusses the marriage contract (Ketubah), and the marital obligations between husband and wife."),
            append = true,
        },
        {
            id = "holybook_talmud_33",
            name = content.plural_text("Talmud, Vol. 33, Tractate Ketubot (Part 2)", "copies of the Talmud, Vol. 33, Tractate Ketubot (Part 2)"),
            description = content.text("This is volume 33 of 51, containing the second part of Tractate Ketubot.  It continues the discussion of the marriage contract, as well as divorce and giving formal testimony."),
            append = true,
        },
        {
            id = "holybook_talmud_34",
            name = content.plural_text("Talmud, Vol. 34, Tractate Nedarim", "copies of the Talmud, Vol. 34, Tractate Nedarim"),
            description = content.text("This is volume 34 of 51, containing Tractate Nedarim.  It deals with the making and breaking of vows and the conditions under which vows are automatically void."),
            append = true,
        },
        {
            id = "holybook_talmud_35",
            name = content.plural_text("Talmud, Vol. 35, Tractate Nazir (Part 1)", "copies of the Talmud, Vol. 35, Tractate Nazir (Part 1)"),
            description = content.text("This is volume 35 of 51, containing the first part of Tractate Nazir.  It deals with Nazirites, who make vows to abstain from wine, cutting their hair, and avoiding contact with the dead."),
            append = true,
        },
        {
            id = "holybook_talmud_36",
            name = content.plural_text("Talmud, Vol. 36, Tractate Nazir (Part 2)", "copies of the Talmud, Vol. 36, Tractate Nazir (Part 2)"),
            description = content.text("This is volume 36 of 51, containing the second part of Tractate Nazir.  It continues the discussion of Nazirite vows, as well as the transmission of ritual impurity between objects."),
            append = true,
        },
        {
            id = "holybook_talmud_37",
            name = content.plural_text("Talmud, Vol. 37, Tractate Sotah (Part 1)", "copies of the Talmud, Vol. 37, Tractate Sotah (Part 1)"),
            description = content.text("This is volume 37 of 51, containing the first part of Tractate Sotah.  It contains a discussion of the sotah, or \"bitter water\", ritual for a woman suspected of adultery by her husband."),
            append = true,
        },
        {
            id = "holybook_talmud_38",
            name = content.plural_text("Talmud, Vol. 38, Tractate Sotah (Part 2)", "copies of the Talmud, Vol. 38, Tractate Sotah (Part 2)"),
            description = content.text("This is volume 38 of 51, containing the second part of Tractate Sotah.  It continues a discussion of the sotah, as well as a long discussion over the entrance of the Israelites into the land of Israel."),
            append = true,
        },
        {
            id = "holybook_talmud_39",
            name = content.plural_text("Talmud, Vol. 39, Tractate Gittin (Part 1)", "copies of the Talmud, Vol. 39, Tractate Gittin (Part 1)"),
            description = content.text("This is volume 39 of 51, containing the first part of Tractate Gittin.  It discusses the Get, the formal document of divorce, and the specifications for its preparation and writing."),
            append = true,
        },
        {
            id = "holybook_talmud_40",
            name = content.plural_text("Talmud, Vol. 40, Tractate Gittin (Part 2)", "copies of the Talmud, Vol. 40, Tractate Gittin (Part 2)"),
            description = content.text("This is volume 40 of 51, containing the second part of Tractate Gittin.  It continues the discussion of the Get, as well the process of  \"Tikkun Olam\", or repairing the world."),
            append = true,
        },
        {
            id = "holybook_talmud_41",
            name = content.plural_text("Talmud, Vol. 41, Tractate Kiddushin", "copies of the Talmud, Vol. 41, Tractate Kiddushin"),
            description = content.text("This is volume 41 of 51, containing Tractate Kiddushin.  It discusses the laws of betrothal and the rules governing interactions between unmarried men and women."),
            append = true,
        },
        {
            id = "holybook_talmud_42",
            name = content.plural_text("Talmud, Vol. 42, Tractate Bava Kamma", "copies of the Talmud, Vol. 42, Tractate Bava Kamma"),
            description = content.text("This is volume 42 of 51, containing Tractate Bava Kamma.  It discusses torts and the proper ways to deal with damages inflicted on people and property."),
            append = true,
        },
        {
            id = "holybook_talmud_43",
            name = content.plural_text("Talmud, Vol. 43, Tractate Bava Metzia", "copies of the Talmud, Vol. 43, Tractate Bava Metzia"),
            description = content.text("This is volume 43 of 51, containing Tractate Bava Metzia.  It discusses interpersonal disputes such as lost property, renting, and obligations of workers and employers, with a digression into how great sages who spend their lives studying Torah are.  It also reiterates the story of the Oven of Akhnai."),
            append = true,
        },
        {
            id = "holybook_talmud_44",
            name = content.plural_text("Talmud, Vol. 44, Tractate Bava Basra", "copies of the Talmud, Vol. 44, Tractate Bava Basra"),
            description = content.text("This is volume 44 of 51, containing Tractate Bava Basra.  It discusses business relationships and the laws of inheritance."),
            append = true,
        },
        {
            id = "holybook_talmud_45",
            name = content.plural_text("Talmud, Vol. 45, Tractate Sanhedrin (Part 1)", "copies of the Talmud, Vol. 45, Tractate Sanhedrin (Part 1)"),
            description = content.text("This is volume 45 of 51, containing the first part of Tractate Sanhedrin.  It discusses the selection of judges and the formation of courts."),
            append = true,
        },
        {
            id = "holybook_talmud_46",
            name = content.plural_text("Talmud, Vol. 46, Tractate Sanhedrin (Part 2)", "copies of the Talmud, Vol. 46, Tractate Sanhedrin (Part 2)"),
            description = content.text("This is volume 46 of 51, containing the first part of Tractate Sanhedrin.  It continues the discussion of judges, the punishments administered by the courts, and ends with a discussion of who will have a place in Olam Haba, the afterlife."),
            append = true,
        },
        {
            id = "holybook_talmud_47",
            name = content.plural_text("Talmud, Vol. 47, Tractate Shevuot", "copies of the Talmud, Vol. 47, Tractate Shevuot"),
            description = content.text("This is volume 47 of 51, containing Tractate Shevuot.  It discusses formal oaths, such as those taken by witnesses in court."),
            append = true,
        },
        {
            id = "holybook_talmud_48",
            name = content.plural_text("Talmud, Vol. 48, Tractate Avodah Zara (Part 1)", "copies of the Talmud, Vol. 48, Tractate Avodah Zara (Part 1)"),
            description = content.text("This is volume 48 of 51, containing the first part of Tractate Avodah Zara.  It discusses forbidden idolatry and the laws regulating contact and commerce with idolators."),
            append = true,
        },
        {
            id = "holybook_talmud_49",
            name = content.plural_text("Talmud, Vol. 49, Tractate Avodah Zara (Part 2)", "copies of the Talmud, Vol. 49, Tractate Avodah Zara (Part 2)"),
            description = content.text("This is volume 49 of 51, containing the second part of Tractate Avodah Zara.  It continues the discussion of contact and commerce with idolators, including the prohibition on buying or consuming wine that may have been used in sacrifices to idols."),
            append = true,
        },
        {
            id = "holybook_talmud_50",
            name = content.plural_text("Talmud, Vol. 50, Tractates Makkot & Horayot", "copies of the Talmud, Vol. 50, Tractates Makkot & Horayot"),
            description = content.text("This is volume 50 of 51, containing Tractates Makkot and Horayot.  Tractate Makkot discusses punishments administered by a court of law and Tractate Horayot discuss redress for errors committed by the court and how to atone for sins committed by kings, high priests, and other officials."),
            append = true,
        },
        {
            id = "holybook_talmud_51",
            name = content.plural_text("Talmud, Vol. 51, Tractate Niddah", "copies of the Talmud, Vol. 51, Tractate Niddah"),
            description = content.text("This is volume 51 of 51, containing Tractate Niddah.  It discusses the ritual status of a menstruating woman, the prohibition on marital relations, and different kinds of bloody discharges."),
            append = true,
        },
    }
    content.add(book)
end
