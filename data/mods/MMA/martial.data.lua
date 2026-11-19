local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "scroll_martial_base",
    abstract = true,
    name = ccb.content.text_without_extraction("scroll abstract"),
    mass = "415 g",
    volume = "250 ml",
    materials = { "paper" },
    symbol = "!",
    looks_like = "manual_dragon",
    color = "white",
    flags = { "NO_SALVAGE" },
    tool = {},
}

ccb.content.define_item {
    id = "ki_strike_scroll",
    copy_from = "scroll_martial_base",
    name = ccb.content.plural_text("dragon hand scroll", "dragon hand scrolls"),
    description = ccb.content.text("Focus your ki into magical attacks."),
    survival_price = "120 USD",
    tool = {},
    use_actions = {
        {
            kind = "transform",
            target = "ki_strike_scroll_act",
            message = ccb.content.text("You unroll the dragon scroll…"),
            target_timer = "1 seconds",
            menu_text = ccb.content.text("Unroll"),
        },
    },
}

ccb.content.define_item {
    id = "ki_strike_scroll_act",
    copy_from = "scroll_martial_base",
    name = ccb.content.plural_text("dragon hand scroll", "dragon hand scrolls"),
    description = ccb.content.text("Focus your ki into magical attacks."),
    survival_price = "120 USD",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    tool = {},
    countdown_action = { kind = "cast_spell", spell = "learn_ki_strike", no_fail = true, level = 0 },
    countdown_interval = "1 second",
}
