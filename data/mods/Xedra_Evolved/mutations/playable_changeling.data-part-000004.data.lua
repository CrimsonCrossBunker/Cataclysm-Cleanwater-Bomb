local ccb = require("ccb")

ccb.content.define_mutation {
    id = "POOKA_ANTLERS",
    name = ccb.content.text("Antlers (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow an impressive rack of antlers, allowing you to make a headbutt attack but preventing you from wearing a helmet."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_HORNS",
    name = ccb.content.text("Curled Horns (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a set of spiraling curled horns, allowing you to make a headbutt attack but preventing you from wearing a helmet."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_FANGS",
    name = ccb.content.text("Fangs (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a set of sharp fangs, allowing you to make a bite attack."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    replacements = { "POOKA_SABER_TEETH" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_SABER_TEETH",
    name = ccb.content.text("Vicious Fangs (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a set of long, saber-like fangs, preventing you from wearing mouth gear but allowing you to make rending bite attacks."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    prerequisites = { "POOKA_FANGS" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_WOLF_EARS",
    name = ccb.content.text("Wolf Ears (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Change your ears into the ears of a wolf, granting you increased hearing."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_FELINE_EARS",
    name = ccb.content.text("Feline Ears (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Change your ears into the ears of a great cat, granting you increased hearing."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_CLAWS",
    name = ccb.content.text("Claws (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a set of claws, improving your unarmed damage if you aren't wearing gloves."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    replacements = { "POOKA_STAINLESS_CLAWS" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_STAINLESS_CLAWS",
    name = ccb.content.text("Vicious Claws (Shapeshift)"),
    points = 4,
    purifiable = false,
    description = ccb.content.text("Grow a powerful set of claws, nearly as hard as steel, greatly improving your unarmed damage if you aren't wearing gloves."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    prerequisites = { "POOKA_CLAWS" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_BIRD_WINGS",
    name = ccb.content.text("Bird Wings (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Transform your arms into bird wings, allow you to slow your fall when jumping from a high place and glide short distances."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_URSINE_FUR",
    name = ccb.content.text("Thick Fur (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow a coat of thick fur, keeping you warm in the winter and protecting you from attacks."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_CHITIN",
    name = ccb.content.text("Chitin Carapace (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow an armored suit of chitin, protecting you and making your punches hit harder."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}

ccb.content.define_mutation {
    id = "POOKA_QUADRUPED",
    name = ccb.content.text("Quadruped (Shapeshift)"),
    points = 2,
    purifiable = false,
    description = ccb.content.text("Grow paws and animal-like legs, allowing you to run much faster on all fours, but preventing you from wearing shoes or gloves."),
    categories = { "FAIR_FOLK_COMMONER_POOKA" },
    active = true,
    activation_setup_only = true,
    on_activate = "pooka_start_partial_form",
    on_deactivate = "pooka_end_partial_form",
    on_process = "pooka_maintain_partial_form",
}
