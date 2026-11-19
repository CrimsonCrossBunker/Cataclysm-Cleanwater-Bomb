local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_security_captain_psychic",
    copy_from = "mon_feral_human_bio3",
    name = ccb.content.plural_text("feral security captain, Ψ Division", "feral security captain, Ψ Divisions"),
    default_faction = "science",
    description = ccb.content.text("A feral security guard with a military-style uniform, bearing the XEDRA logo and some kind of rank insignia.  Their movements are precise, controlled, and inhumanly smooth, and while their eyes are still bloodshot, they have a spark lacking in most ferals you've seen."),
    death = { drops = "feral_security_captain_death_drops_psychic" },
}

ccb.content.define_monster {
    id = "mon_mutant_biokinetic_alpha",
    copy_from = "mon_feral_human_bio2",
    looks_like = "mon_mutant_alpha",
    name = ccb.content.plural_text("project EMERALD VANGUARD participant", "project EMERALD VANGUARD participants"),
    description = ccb.content.text("An experimental subject wearing a surprisingly clean orange jumpsuit.  They look unchanged at a distance, but as you approach their head spins towards you with unnatural speed.  Their face is disconcertingly beautiful, but their eyes shine with an intelligence far beyond human - and a deep disgust directed at you."),
    hp = 120,
    aggression = 40,
    morale = 40,
    aggressive_to_characters = false,
    regenerates_morale = true,
    harvest = "mutant_human",
    dissect = "dissect_alpha_sample_large",
    tracking_distance = 4,
    regenerates = 1,
    inheritance = { add = { attacks = { { id = "feral_weapon_pipe" } } } },
    death = { drops = "mon_mutant_biokinetic_alpha_death_drops" },
}
