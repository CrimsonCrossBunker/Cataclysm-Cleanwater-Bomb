local ccb = require("ccb")

ccb.content.define_item {
    id = "inactive_frankenstein",
    name = "inactive Frankenstein",
    description = "This stitched together abomination in human form lies still and waiting for you to give it the spark of life.  In all likelihood you are the monster.",
    symbol = ";",
    color = "green",
    mass = "68 kg",
    volume = "62 L",
    price = "6 kUSD",
    flags = { "SINGLE_USE" },
    materials = { "flesh" },
    melee_damage = { bash = 8 },
    accuracy = -3,
    use_actions = {
        {
            kind = "place_npc",
            npc_class_id = "frankenstein",
            moves = 50,
            place_randomly = false,
            summon_msg = "It's alive!",
        },
    },
    tool = {},
}
