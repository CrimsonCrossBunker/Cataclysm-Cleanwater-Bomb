local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_ABSTRACT",
    abstract = true,
    name = "",
    description = "",
    points = 0,
    cooldown = 3600,
    on_process = "extra_mut_scen_become_mutant",
    cancels = {
        "MUTAGEN_GLAND_ALPHA",
        "MUTAGEN_GLAND_BATRACHIAN",
        "MUTAGEN_GLAND_BEAST",
        "MUTAGEN_GLAND_BIRD",
        "MUTAGEN_GLAND_CATTLE",
        "MUTAGEN_GLAND_CEPHALOPOD",
        "MUTAGEN_GLAND_CHIMERA",
        "MUTAGEN_GLAND_CHIROPTERAN",
        "MUTAGEN_GLAND_CRUSTACEAN",
        "MUTAGEN_GLAND_ELFA",
        "MUTAGEN_GLAND_FELINE",
        "MUTAGEN_GLAND_FISH",
        "MUTAGEN_GLAND_GASTROPOD",
        "MUTAGEN_GLAND_INSECT",
        "MUTAGEN_GLAND_LAGOMORPH",
        "MUTAGEN_GLAND_LIZARD",
        "MUTAGEN_GLAND_LUPINE",
        "MUTAGEN_GLAND_MEDICAL",
        "MUTAGEN_GLAND_MOUSE",
        "MUTAGEN_GLAND_PLANT",
        "MUTAGEN_GLAND_RAPTOR",
        "MUTAGEN_GLAND_RAT",
        "MUTAGEN_GLAND_SLIME",
        "MUTAGEN_GLAND_SPIDER",
        "MUTAGEN_GLAND_TROGLOBITE",
        "MUTAGEN_GLAND_URSINE",
    },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_ALPHA",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Alpha"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with alpha traits."),
    remove = { cancels = { "MUTAGEN_GLAND_ALPHA" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_BATRACHIAN",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Batrachian"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with batrachian traits."),
    remove = { cancels = { "MUTAGEN_GLAND_BATRACHIAN" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_BEAST",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Beast"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with beast traits."),
    remove = { cancels = { "MUTAGEN_GLAND_BEAST" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_BIRD",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Bird"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with avian traits."),
    remove = { cancels = { "MUTAGEN_GLAND_BIRD" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_CATTLE",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Cattle"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with bovine traits."),
    remove = { cancels = { "MUTAGEN_GLAND_CATTLE" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_CEPHALOPOD",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Cephalopod"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with cephalopod traits."),
    remove = { cancels = { "MUTAGEN_GLAND_CEPHALOPOD" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_CHIMERA",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Chimera"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with chimera traits."),
    remove = { cancels = { "MUTAGEN_GLAND_CHIMERA" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_CHIROPTERAN",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Chiropteran"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with chiropteran traits."),
    remove = { cancels = { "MUTAGEN_GLAND_CHIROPTERAN" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_CRUSTACEAN",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Crustacean"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with crustacean traits."),
    remove = { cancels = { "MUTAGEN_GLAND_CRUSTACEAN" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_ELFA",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Elf-A"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with elven traits."),
    remove = { cancels = { "MUTAGEN_GLAND_ELFA" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_FELINE",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Feline"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with feline traits."),
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_FISH",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Fish"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with fish traits."),
    remove = { cancels = { "MUTAGEN_GLAND_FISH" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_GASTROPOD",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Gastropod"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with gastropod traits."),
    remove = { cancels = { "MUTAGEN_GLAND_GASTROPOD" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_INSECT",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Insect"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with insect traits."),
    remove = { cancels = { "MUTAGEN_GLAND_INSECT" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_LAGOMORPH",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Lagomorph"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with lagomorph traits."),
    remove = { cancels = { "MUTAGEN_GLAND_LAGOMORPH" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_LIZARD",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Lizard"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with lizard traits."),
    remove = { cancels = { "MUTAGEN_GLAND_LIZARD" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_LUPINE",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Lupine"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with lupine traits."),
    remove = { cancels = { "MUTAGEN_GLAND_LUPINE" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_MEDICAL",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Medical"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with medical traits."),
    remove = { cancels = { "MUTAGEN_GLAND_MEDICAL" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_MOUSE",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Mouse"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with mouse traits."),
    remove = { cancels = { "MUTAGEN_GLAND_MOUSE" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_PLANT",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Plant"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with plant traits."),
    remove = { cancels = { "MUTAGEN_GLAND_PLANT" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_RAPTOR",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Raptor"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with raptor traits."),
    remove = { cancels = { "MUTAGEN_GLAND_RAPTOR" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_RAT",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Rat"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with rat traits."),
    remove = { cancels = { "MUTAGEN_GLAND_RAT" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_SLIME",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Slime"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with slime traits."),
    remove = { cancels = { "MUTAGEN_GLAND_SLIME" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_SPIDER",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Spider"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with spider traits."),
    remove = { cancels = { "MUTAGEN_GLAND_SPIDER" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_TROGLOBITE",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Troglobite"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with troglobite traits."),
    remove = { cancels = { "MUTAGEN_GLAND_TROGLOBITE" } },
}

ccb.content.define_mutation {
    id = "MUTAGEN_GLAND_URSINE",
    copy_from = "MUTAGEN_GLAND_ABSTRACT",
    name = ccb.content.text("Mutagen Gland - Ursine"),
    description = ccb.content.text("You were unwittingly subject to next gen CRISPR experimentation that has resulted in you growing a small gland out of your pancreas that gradually mutates you with ursine traits."),
    remove = { cancels = { "MUTAGEN_GLAND_URSINE" } },
}
