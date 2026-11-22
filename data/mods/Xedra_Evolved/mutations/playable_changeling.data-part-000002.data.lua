local ccb = require("ccb")

ccb.content.define_mutation {
    id = "CHANGELING_NOBLE_RIGHT_OF_PASSAGE",
    name = ccb.content.text("Right of Passage"),
    points = 8,
    description = ccb.content.text("The Fair Folk have dealt with many mortal civilizations over the aeons, and have come to mutually beneficial arrangements with some of them.  Activate this trait to make your fae nature obvious, invoking those ancient agreements.  This <color_yellow>may anger</color> some who have especially bad relationships with the fae."),
    prerequisites = { "PRETTY", "BEAUTIFUL", "BEAUTIFUL2", "BEAUTIFUL3" },
    secondary_prerequisites = { "CHANGELING_NOBLE_COMMAND_COMMMONERS" },
    categories = { "FAIR_FOLK_NOBLE" },
    purifiable = false,
    active = true,
    activation_setup_only = true,
    on_activate = "changeling_right_of_passage_on",
    on_deactivate = "changeling_right_of_passage_off",
}
