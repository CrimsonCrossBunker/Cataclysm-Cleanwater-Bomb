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
