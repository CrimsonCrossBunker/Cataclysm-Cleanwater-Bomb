local ccb = require("ccb")

ccb.content.define_item {
    id = "anathema_blood_catalyst_unready",
    category = "drug",
    looks_like = "vampire_blood",
    name = ccb.content.plural_text("churning vampire blood mixture", "churning vampire blood mixture"),
    description = ccb.content.text("Vampire blood mixed with blood none would consume and different toxic substances.  The hostile environment is already driving the vampire blood to devour itself.  It will be ready to consume in a few days."),
    materials = { "vampire_blood" },
    phase = "liquid",
    mass = "5360 g",
    color = "red",
    flags = { "TRADER_AVOID", "INEDIBLE" },
    symbol = "~",
    price = "0 cent",
    volume = "6000 ml",
    comestible = { kind = "DRINK", servings = 1 },
    use_actions = {
        {
            kind = "delayed_transform",
            target = "anathema_blood_catalyst",
            message = ccb.content.text("The vampire blood has completely devoured itself, leaving a small dose of very potent vampire blood behind."),
            moves = 50,
            age = 345600,
            not_ready_message = ccb.content.text("The vampire blood is still devouring itself."),
        },
    },
}
