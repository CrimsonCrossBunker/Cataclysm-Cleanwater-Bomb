local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_chud",
    name = ccb.content.plural_text("feral gamer", "feral gamers"),
    description = ccb.content.text("This person has been without their games for far too long and gone mad, joining the side of the zombies.  With years spent hidden from the sun in the gamer zone having transformed them into some kind of subterranean monster, their hygiene is somehow even worse than that of the undead."),
    copy_from = "mon_chud",
}
