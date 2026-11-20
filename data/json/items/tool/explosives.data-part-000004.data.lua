local ccb = require("ccb")

ccb.content.define_item {
    id = "EMPbomb_act",
    copy_from = "EMPbomb",
    description = ccb.content.text("This EMP bomb is active and will shortly detonate, creating a large EMP field that damages robots and drains bionic energy, as well as a sizeable explosion.  You may not want to be holding it much longer."),
    flags = { "DANGEROUS", "WATER_BREAK", "SPAWN_ACTIVE" },
    tool = {},
    use_actions = {
        {
            kind = "message",
            message = ccb.content.text("You've already activated the %s.  Get rid of it and clear out!"),
            menu_text = ccb.content.text_without_extraction("Activate"),
        },
    },
    countdown_action = {
        kind = "explosion",
        draw_radius = 10,
        draw_color = "light_blue",
        emp_radius = 10,
        blast = {
            power = 600,
            light_effect = "emp_blast",
            shrapnel = { casing_mass = 3214, fragment_mass = 0.5 },
        },
    },
    countdown_interval = "50 seconds",
}
