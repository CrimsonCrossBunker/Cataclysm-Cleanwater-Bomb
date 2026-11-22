local ccb = require("ccb")

ccb.content.define_mutation {
    id = "WEREWOLF_ANIMAL_FORM",
    name = ccb.content.text("Lupine Form"),
    points = 0,
    description = ccb.content.text("You can transform yourself into a wolf and run through the forests."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    activation_message = "",
    on_activate = "werewolf_wolf_form_on",
    on_deactivate = "werewolf_wolf_form_off",
    chargen_allow_npc = false,
}

ccb.content.define_mutation {
    id = "WEREWOLF_HYBRID_FORM",
    name = ccb.content.text("War Form"),
    points = 0,
    description = ccb.content.text("You can transform yourself into a wolf-human hybrid and rip your enemies to shreds.  You also look terrifying, can't hide how terrifying you look, and produce a truly awful musk."),
    starting_trait = false,
    purifiable = false,
    valid = false,
    active = true,
    activation_setup_only = true,
    activation_message = "",
    on_activate = "werewolf_hybrid_form_on",
    on_process = "werewolf_hybrid_form_healing",
    on_deactivate = "werewolf_hybrid_form_off",
    chargen_allow_npc = false,
}
