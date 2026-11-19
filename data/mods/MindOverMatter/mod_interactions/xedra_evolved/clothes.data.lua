local ccb = require("ccb")

ccb.content.define_item {
    id = "xedra_jumpsuit",
    copy_from = "jumpsuit",
    looks_like = "jumpsuit",
    name = ccb.content.text("OA jumpsuit"),
    description = ccb.content.text("A brown jumpsuit with OA written in big yellow block letters on the back."),
    color = "brown",
    variants = {
        {
            id = "xedra_jumpsuit_offworld",
            name = ccb.content.text("OA jumpsuit"),
            description = ccb.content.text("A brown jumpsuit with OA written in big yellow block letters on the back."),
            weight = 2,
        },
        {
            id = "xedra_jumpsuit_eater",
            name = ccb.content.text("υ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"υ\" on the back."),
            weight = 2,
        },
        {
            id = "xedra_jumpsuit_dreamer",
            name = ccb.content.text("ϴ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"ϴ\" on the back."),
            weight = 2,
        },
        {
            id = "xedra_jumpsuit_inventor",
            name = ccb.content.text("ν jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"ν\" on the back."),
            weight = 2,
        },
        {
            id = "xedra_jumpsuit_dreamsmith",
            name = ccb.content.text("τ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"τ\" on the back."),
            weight = 2,
        },
        {
            id = "xedra_jumpsuit_psi",
            name = ccb.content.text("Ψ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"Ψ\" on the back."),
            weight = 1,
        },
        {
            id = "xedra_jumpsuit_gamma",
            name = ccb.content.text("γ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"γ\" on the back."),
            weight = 1,
        },
        {
            id = "xedra_jumpsuit_chi",
            name = ccb.content.text("χ jumpsuit"),
            description = ccb.content.text("A black jumpsuit with white symbol \"χ\" on the back."),
            weight = 1,
        },
    },
    armor = {},
}
