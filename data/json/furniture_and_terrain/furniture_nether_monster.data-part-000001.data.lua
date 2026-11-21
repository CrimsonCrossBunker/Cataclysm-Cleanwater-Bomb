local ccb = require("ccb")

-- Its thing is making itself irresistible to the PC. TODO: Make this effect more obvious
ccb.content.define_furniture {
    id = "f_nm_nether_lily",
    name = ccb.content.text("beautiful nether lily"),
    description = ccb.content.text("A very tall, mesmerizing blood red flower.  Its beautiful, pristine form is rooted firmly on the innards of the beast.  The flesh around it is decayed, being consumed to feed its ornate, magnanimous body.  You feel an urge to sit and admire this priceless miracle of life."),
    looks_like = "f_black_eyed_susan",
    symbol = "P",
    color = "red",
    move_cost_mod = 2,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 61,
        sound = ccb.content.text("a chilling scream!"),
        failure_sound = ccb.content.text("squish!"),
        drops = {
            { item = "withered", chance = 50, count = { 1, 2 } },
        },
    },
    examine_handler = "examine_f_nm_nether_lily",
}
