local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "shield_gauge",
    style = "text",
    label = ccb.content.text("INTGR"),
    width = 19,
    clauses = {
        {
            id = "full30",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇</color>",
            when = reading.compare("character_variable", ">=", 96.67, "shield_ratio"),
        },
        {
            id = "full29",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▅</color>",
            when = reading.compare("character_variable", ">=", 93.33, "shield_ratio"),
        },
        {
            id = "full28",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▂</color>",
            when = reading.compare("character_variable", ">=", 90.00, "shield_ratio"),
        },
        {
            id = "full27",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇  </color>",
            when = reading.compare("character_variable", ">=", 86.67, "shield_ratio"),
        },
        {
            id = "full26",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▅  </color>",
            when = reading.compare("character_variable", ">=", 83.33, "shield_ratio"),
        },
        {
            id = "full25",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▂  </color>",
            when = reading.compare("character_variable", ">=", 80.00, "shield_ratio"),
        },
        {
            id = "full24",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇    </color>",
            when = reading.compare("character_variable", ">=", 76.67, "shield_ratio"),
        },
        {
            id = "full23",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▅    </color>",
            when = reading.compare("character_variable", ">=", 73.33, "shield_ratio"),
        },
        {
            id = "full22",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▂    </color>",
            when = reading.compare("character_variable", ">=", 70.00, "shield_ratio"),
        },
        {
            id = "full21",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▇      </color>",
            when = reading.compare("character_variable", ">=", 66.67, "shield_ratio"),
        },
        {
            id = "full20",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▅      </color>",
            when = reading.compare("character_variable", ">=", 63.33, "shield_ratio"),
        },
        {
            id = "full19",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇ ▂      </color>",
            when = reading.compare("character_variable", ">=", 60.00, "shield_ratio"),
        },
        {
            id = "full18",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▇        </color>",
            when = reading.compare("character_variable", ">=", 56.67, "shield_ratio"),
        },
        {
            id = "full17",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▅        </color>",
            when = reading.compare("character_variable", ">=", 53.33, "shield_ratio"),
        },
        {
            id = "full16",
            text = "<color_light_cyan>▇ ▇ ▇ ▇ ▇ ▂        </color>",
            when = reading.compare("character_variable", ">=", 50.00, "shield_ratio"),
        },
        {
            id = "full15",
            text = "<color_yellow>▇ ▇ ▇ ▇ ▇          </color>",
            when = reading.compare("character_variable", ">=", 46.67, "shield_ratio"),
        },
        {
            id = "full14",
            text = "<color_yellow>▇ ▇ ▇ ▇ ▅          </color>",
            when = reading.compare("character_variable", ">=", 43.33, "shield_ratio"),
        },
        {
            id = "full13",
            text = "<color_yellow>▇ ▇ ▇ ▇ ▂          </color>",
            when = reading.compare("character_variable", ">=", 40.00, "shield_ratio"),
        },
        {
            id = "full12",
            text = "<color_yellow>▇ ▇ ▇ ▇            </color>",
            when = reading.compare("character_variable", ">=", 36.67, "shield_ratio"),
        },
        {
            id = "full11",
            text = "<color_yellow>▇ ▇ ▇ ▅            </color>",
            when = reading.compare("character_variable", ">=", 33.33, "shield_ratio"),
        },
        {
            id = "full10",
            text = "<color_yellow>▇ ▇ ▇ ▂            </color>",
            when = reading.compare("character_variable", ">=", 30.00, "shield_ratio"),
        },
        {
            id = "full9",
            text = "<color_yellow>▇ ▇ ▇              </color>",
            when = reading.compare("character_variable", ">=", 26.67, "shield_ratio"),
        },
        {
            id = "full8",
            text = "<color_light_red>▇ ▇ ▅              </color>",
            when = reading.compare("character_variable", ">=", 23.33, "shield_ratio"),
        },
        {
            id = "full7",
            text = "<color_light_red>▇ ▇ ▂              </color>",
            when = reading.compare("character_variable", ">=", 20.00, "shield_ratio"),
        },
        {
            id = "full6",
            text = "<color_light_red>▇ ▇                </color>",
            when = reading.compare("character_variable", ">=", 16.67, "shield_ratio"),
        },
        {
            id = "full5",
            text = "<color_light_red>▇ ▅                </color>",
            when = reading.compare("character_variable", ">=", 13.33, "shield_ratio"),
        },
        {
            id = "full4",
            text = "<color_light_red>▇ ▂                </color>",
            when = reading.compare("character_variable", ">=", 10.00, "shield_ratio"),
        },
        {
            id = "full3",
            text = "<color_light_red>▇                  </color>",
            when = reading.compare("character_variable", ">=", 6.67, "shield_ratio"),
        },
        {
            id = "full2",
            text = "<color_light_red>▅                  </color>",
            when = reading.compare("character_variable", ">=", 3.33, "shield_ratio"),
        },
        {
            id = "full1",
            text = "<color_light_red>▂                  </color>",
            when = reading.compare("character_variable", ">", 0.00, "shield_ratio"),
        },
        {
            id = "empty",
            text = ccb.content.text("<color_red>      OFFLINE      </color>"),
            when = reading.compare("character_variable", "<=", 0.00, "shield_ratio"),
        },
    },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "shield_power_gauge",
    style = "text",
    label = ccb.content.text("POWER"),
    width = 19,
    clauses = {
        {
            id = "full10",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇</color>",
            when = reading.compare("character_variable", ">=", 90, "shield_power_ratio"),
        },
        {
            id = "full9",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇  </color>",
            when = reading.compare("character_variable", ">=", 80, "shield_power_ratio"),
        },
        {
            id = "full8",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇ ▇ ▇    </color>",
            when = reading.compare("character_variable", ">=", 70, "shield_power_ratio"),
        },
        {
            id = "full7",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇ ▇      </color>",
            when = reading.compare("character_variable", ">=", 60, "shield_power_ratio"),
        },
        {
            id = "full6",
            text = "<color_red>▇ ▇ ▇ ▇ ▇ ▇        </color>",
            when = reading.compare("character_variable", ">=", 50, "shield_power_ratio"),
        },
        {
            id = "full5",
            text = "<color_red>▇ ▇ ▇ ▇ ▇          </color>",
            when = reading.compare("character_variable", ">=", 40, "shield_power_ratio"),
        },
        {
            id = "full4",
            text = "<color_red>▇ ▇ ▇ ▇            </color>",
            when = reading.compare("character_variable", ">=", 30, "shield_power_ratio"),
        },
        {
            id = "full3",
            text = "<color_red>▇ ▇ ▇              </color>",
            when = reading.compare("character_variable", ">=", 20, "shield_power_ratio"),
        },
        {
            id = "full2",
            text = "<color_red>▇ ▇                </color>",
            when = reading.compare("character_variable", ">=", 10, "shield_power_ratio"),
        },
        {
            id = "full1",
            text = "<color_red>▇                  </color>",
            when = reading.compare("character_variable", ">", 0, "shield_power_ratio"),
        },
        {
            id = "empty",
            text = ccb.content.text("<color_red>      OFFLINE      </color>"),
            when = reading.compare("character_variable", "<=", 0, "shield_power_ratio"),
        },
    },
    flags = { "W_NO_PADDING" },
}

ccb.content.define_widget {
    id = "shield_rad_warning",
    width = 8,
    style = "text",
    clauses = {
        {
            id = "danger",
            text = ccb.content.text("  ☢DNGR☢"),
            color = "red",
            when = predicate.all { reading.compare("character_variable", "<", 25, "shield_ratio"), reading.compare("character_variable", ">=", 0, "shield_ratio") },
        },
    },
    default_clause = { text = ccb.content.text("  ☢DNGR☢"), color = "dark_gray" },
    flags = { "W_LABEL_NONE", "W_NO_PADDING" },
}
