local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_ley_energy_blaster",
    copy_from = "bionic_general",
    name = ccb.content.plural_text("Levinbolt Projector CBM", "Levinbolt Projector CBMs"),
    description = ccb.content.text("The ultimate in concealable personal defense, thin filaments are implanted along the ley lines in both of your arms leading to embedded mana crystals in your hands, allowing you to launch blasts of pure magical energy at nearby targets.  The only disadvantage is that it draws on your own personal mana supply rather than bionic power."),
    price = "3 kUSD",
    mass = "500 g",
    bionic = { difficulty = 4 },
}
