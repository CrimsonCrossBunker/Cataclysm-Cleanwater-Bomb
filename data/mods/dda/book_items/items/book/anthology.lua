local ccb = require("ccb")
local content = ccb.content

do
    local book = content.Item {
        id = "book_anthology_moataatgb",
        name = ccb.content.plural_text("The Museum of All Things Awesome and That Go Boom", "copies of The Museum of All Things Awesome and That Go Boom"),
        description = ccb.content.text("The Museum of All Things Awesome and That Go Boom is an anthology of science fiction featuring blunt force trauma, explosions, adventure, derring-do, tigers, Martians, zombies, fanged monsters, dinosaurs (alien and domestic), ray guns, rocket ships, and anthropomorphized marshmallows.  Published by Upper Rubber Boot Books."),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_antho_tpl",
    }
    book:material("paper", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_anthology_sunvault",
        name = ccb.content.plural_text("Sunvault: Stories of Solarpunk & Eco-Speculation", "copies of Sunvault"),
        description = ccb.content.text("Sunvault is the first English-language anthology to broadly collect solarpunk short fiction, artwork, and poetry.  A new genre for the 21st Century, solarpunk is a revolution against despair.  Focusing on solutions to environmental disasters, solarpunk envisions a future of green, sustainable energy used by societies that value inclusiveness, cooperation, and personal freedom.  Published by Upper Rubber Boot Books."),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_antho_tpl",
    }
    book:material("paper", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_anthology_sst",
        name = ccb.content.plural_text("Sharp & Sugar Tooth", "copies of Sharp & Sugar Tooth"),
        description = ccb.content.text("Sharp & Sugar Tooth: Women Up To No Good is a horror anthology of dark fiction and darker appetites, edited by Octavia Cade.  Containing 22 stories of \"bad\" women, and \"good\" women who just haven't been caught yet, it features 22 fearless writers who identify as female, non-binary, or a marginalized sex or gender identity.  Published by Upper Rubber Boot Books."),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_antho_tpl",
    }
    book:material("paper", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_anthology_bk",
        name = ccb.content.plural_text("Broad Knowledge", "copies of Broad Knowledge"),
        description = ccb.content.text("Broad Knowledge: 35 Women Up To No Good is a feminist anthology of dark fiction and darker knowledge, edited by Joanne Merriam.  Containing 35 stories of \"bad\" women, and \"good\" women who just haven't been caught yet.  Published by Upper Rubber Boot Books."),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_antho_tpl",
    }
    book:material("paper", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_anthology_cw",
        name = ccb.content.plural_text("Choose Wisely", "copies of Choose Wisely"),
        description = ccb.content.text("Choose Wisely: 35 Women Up To No Good is a feminist anthology of dark fiction, co-edited by H. L. Nelson and Joanne Merriam.  Containing 35 stories of \"bad\" women, and \"good\" women who just haven't been caught yet, it features Joyce Carol Oates, Aimee Bender, Diane Cook, and 33 other fearless women writers.  Published by Upper Rubber Boot Books."),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_antho_tpl",
    }
    book:material("paper", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_anthology_an",
        name = ccb.content.plural_text("Apocalypse Now", "copies of Apocalypse Now"),
        description = ccb.content.text("Every society and every generation has its version of the apocalypse: swine flu, genetic mutation, global warming, nuclear fallout, the second coming, peak oil, mass extinction, giant irradiated ants, zombies… Apocalypse Now: Poems and Prose from the End of Days is the first anthology of its kind to bring together the poetry and prose of some of America's finest (though not always most well-known) literary voices with an eye for the literary and the popular, for story and lyric, for the past and the future, for the psychological and the physical, for the real and the fantastic.  Published by Upper Rubber Boot Books."),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_antho_tpl",
    }
    book:material("paper", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "book_anthology_htloop",
        name = ccb.content.plural_text("How to Live on Other Planets: A Handbook for Aspiring Aliens", "copies of How to Live on Other Planets"),
        description = ccb.content.text("How to Live on Other Planets: A Handbook for Aspiring Aliens explores the immigrant experience in a science fiction setting, with exciting fiction and poetry from some of the genre's best writers.  Published by Upper Rubber Boot Books."),
        mass_milligrams = 225000,
        volume_ml = 408,
        longest_side_mm = 200,
        copy_from = "book_antho_tpl",
    }
    book:material("paper", 1)
    content.add(book)
end

do
    local book = content.Item {
        id = "poetic_edda",
        name = ccb.content.plural_text("Poetic Edda", "copies of the Poetic Edda"),
        description = ccb.content.text("The Poetic Edda is a collection of Old Norse narrative poems in alliterative verse recounting some of the stories of Norse mythology."),
        mass_milligrams = 672000,
        volume_ml = 1368,
        copy_from = "book_antho_tpl",
    }
    content.add(book)
end
