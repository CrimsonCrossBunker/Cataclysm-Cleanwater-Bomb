local ccb = require("ccb")

ccb.content.define_mutation {
    id = "ILLITERATE",
    name = ccb.content.text("Illiterate"),
    points = 0,
    description = ccb.content.text("You never learned to read!  Books and computers are off-limits to you."),
    starting_trait = false,
    valid = false,
    cancels = { "FASTREADER", "SLOWREADER", "PROF_DICEMASTER", "LOVES_BOOKS", "HATES_BOOKS" },
}

ccb.content.define_mutation {
    id = "HATES_BOOKS",
    name = ccb.content.text("Hates Books"),
    points = 0,
    description = ccb.content.text("Reading is for nerds!  Boring books are more boring, and you can't have fun by reading books."),
    valid = false,
    cancels = { "ILLITERATE", "LOVES_BOOKS" },
}
