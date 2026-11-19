local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MARTIAL_ARTS4",
    name = ccb.content.text("Venom Mob Protege"),
    points = 2,
    description = ccb.content.text("You are a pupil of the Venom Clan.  You start with one of the five deadly venoms: Centipede, Viper, Scorpion, Lizard, or Toad."),
    starting_trait = false,
    initial_martial_arts = { "style_centipede", "style_venom_snake", "style_scorpion", "style_lizard", "style_toad" },
    valid = false,
}
