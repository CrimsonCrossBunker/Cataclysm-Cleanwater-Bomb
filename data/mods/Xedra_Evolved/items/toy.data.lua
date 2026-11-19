local ccb = require("ccb")

ccb.content.define_item {
    id = "teddy_bear",
    copy_from = "teddy_bear",
    name = ccb.content.plural_text("plush toy", "plush toys"),
    inheritance = {
        add = {
            variants = {
                {
                    id = "toy_alien_pink",
                    name = ccb.content.plural_text("pink alien plushie", "pink alien plushies"),
                    description = ccb.content.text("A pink alien plush with cute antennae and big shiny bright pink eyes.  It also has soft crab claws, a pair of small wings that looked useless and a dress of some kind.  If aliens were to exist, surely they wouldn't look like this, right?"),
                    weight = 1,
                },
            },
        },
    },
}
