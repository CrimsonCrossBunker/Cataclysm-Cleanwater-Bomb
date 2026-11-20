local ccb = require("ccb")

-- The pom poms could make use of their own type of tick_action.
ccb.content.define_item {
    id = "pom_poms",
    name = ccb.content.plural_text("pom poms (pair)", "pom poms (pair)"),
    category = "other",
    mass = "150 g",
    color = "red",
    symbol = "O",
    description = ccb.content.text("A pair of red and silver pom poms with plastic handles.  Using them will make you start a cheerleading routine."),
    price = "6 USD",
    survival_price = "20 cent",
    materials = { "plastic" },
    volume = "250 ml",
    length = "10 cm",
    flags = { "SLEEP_IGNORE" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { thickness = 0.1 },
    use_actions = { { kind = "play_instrument" } },
    tick_actions = {
        {
            kind = "musical_instrument",
            speed_penalty = 10,
            volume = 10,
            fun = -5,
            fun_bonus = 2,
            description_interval = 20,
            player_messages = {
                "You make a skillful routine with the pom poms.",
                "You move with refinement while using the pom poms.",
            },
            npc_messages = {
                "makes a skillful routine with the pom poms.",
                "moves with refinement while using the pom poms.",
            },
        },
    },
}
