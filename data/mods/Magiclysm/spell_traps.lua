local ccb = require("ccb")
local content = ccb.content

content.add(content.Trap {
    id = "tr_alchemist_mine",
    trigger_weight_grams = 1,
    name = ccb.content.text("alchemical mine"),
    color = "yellow",
    symbol = "^",
    visibility = 1,
    avoidance = 99,
    difficulty = 0,
    action = "spell",
    spell = "alchemist_mine_pull",
}
    :drop("alchemist_mine"))

content.add(content.Trap {
    id = "tr_bear",
    name = ccb.content.text("bear trap"),
    color = "blue",
    symbol = "^",
    action = "spell",
    visibility = 2,
    trap_radius = 2,
    avoidance = 99,
    difficulty = 99,
    spell = "bear_trap",
})

content.add(content.Trap {
    id = "tr_forge_vault",
    name = ccb.content.text("summon hounds"),
    color = "brown",
    symbol = ".",
    visibility = 99,
    avoidance = 99,
    difficulty = 99,
    trap_radius = 2,
    action = "spell",
    spell = "forge_trap",
    benign = false,
})
