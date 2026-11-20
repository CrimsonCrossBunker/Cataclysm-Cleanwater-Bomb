local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_SPELLS",
    name = ccb.content.text("Gifts of the Moon"),
    points = 0,
    description = ccb.content.text("The People gain many powers from the Moon, to better survive and hunt the wilds for their prey.\n\nActivate at the appropriate time to learn a new Gift of the Moon when under the moon."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    on_activate = "choose_lunar_gift",
    activation_message = "",
    flags = { "ATTUNEMENT" },
}
