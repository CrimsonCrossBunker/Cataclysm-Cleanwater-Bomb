local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_emp_act",
    copy_from = "grenade_emp",
    description = ccb.content.text("This EMP grenade is active and will shortly detonate, creating a large EMP field that damages robots and drains bionic energy, as well as a mild electric shock cloud.  You may not want to be holding it much longer."),
    flags = { "DANGEROUS", "WATER_BREAK", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already pulled the pin, try throwing it instead."),
            menu_text = ccb.content.text_without_extraction("Pull pin"),
        },
    },
    countdown_action = {
        kind = "explosion",
        field = "fd_electricity",
        field_radius = 1,
        field_minimum = 2,
        field_maximum = 10,
        emp_radius = 4,
    },
    countdown_interval = "3 seconds",
}
