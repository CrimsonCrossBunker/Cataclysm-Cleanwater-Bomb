local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "cryosuit_power_graph",
    style = "text",
    label = ccb.content.text("CRYOSUIT POWER"),
    width = 19,
    clauses = {
        {
            id = "empty",
            text = ccb.content.text("<color_red>      OFFLINE      </color>"),
            when = predicate.negate(reading.test("worn_flag", "ACTIVE_CRYOSUIT")),
        },
        {
            id = "full10",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇</color>",
            when = reading.compare("character_variable", ">=", 90, "cryosuit_power"),
        },
        {
            id = "full9",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇  </color>",
            when = reading.compare("character_variable", ">=", 80, "cryosuit_power"),
        },
        {
            id = "full8",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇    </color>",
            when = reading.compare("character_variable", ">=", 70, "cryosuit_power"),
        },
        {
            id = "full7",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇ ▇      </color>",
            when = reading.compare("character_variable", ">=", 60, "cryosuit_power"),
        },
        {
            id = "full6",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇        </color>",
            when = reading.compare("character_variable", ">=", 50, "cryosuit_power"),
        },
        {
            id = "full5",
            text = "<color_red>▇ ▇ ▇ ▇ ▇          </color>",
            when = reading.compare("character_variable", ">=", 40, "cryosuit_power"),
        },
        {
            id = "full4",
            text = "<color_red>▇ ▇ ▇ ▇            </color>",
            when = reading.compare("character_variable", ">=", 30, "cryosuit_power"),
        },
        {
            id = "full3",
            text = "<color_red>▇ ▇ ▇              </color>",
            when = reading.compare("character_variable", ">=", 20, "cryosuit_power"),
        },
        {
            id = "full2",
            text = "<color_red>▇ ▇                </color>",
            when = reading.compare("character_variable", ">=", 10, "cryosuit_power"),
        },
        {
            id = "full1",
            text = "<color_red>▇                  </color>",
            when = reading.compare("character_variable", ">", 0, "cryosuit_power"),
        },
    },
    default_clause = { text = ccb.content.text("      BOOTING      "), color = "red" },
    flags = { "W_NO_PADDING" },
}
