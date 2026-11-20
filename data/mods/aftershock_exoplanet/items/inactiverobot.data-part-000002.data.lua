local ccb = require("ccb")

ccb.content.define_item {
    id = "bot_milbot_308",
    copy_from = "bot_milbot_base",
    name = ccb.content.plural_text("inactive military robot", "inactive military robots"),
    description = ccb.content.text("An unpowered military robot fitted with an integrated 7.62 firearm and electric prod.  Activate this item, with ammo in your inventory, to load and deploy the robot."),
    color = "green",
    tool = {},
    use_actions = {
        {
            kind = "place_monster",
            monster = "mon_milbot_308",
            difficulty = 0,
            moves = 100,
            skills = { "electronics", "computer" },
        },
    },
}
