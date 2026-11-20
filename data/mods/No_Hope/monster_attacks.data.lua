local ccb = require("ccb")

ccb.content.define_monster_attack {
    id = "flaming_eye_warming_up",
    cooldown = 0,
    spell = { id = "flaming_eye_warming_up" },
    casting_message = ccb.content.text("Looks like the flaming eye is planning to do something especially nasty to you.  Better watch out!"),
    kind = "spell",
}
