local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_fear_deer",
    copy_from = "mon_deer",
    looks_like = "mon_deer",
    name = ccb.content.plural_text("king of the wood", "kings of the wood"),
    description = ccb.content.text("The northern woodland white-tailed deer, a quick and strong grazing animal.  Favored prey of coyotes, wolves, and giant spider mutants.  This one has an almost regal aura of calm about it and gazes at the forest around it without fear."),
    reproduction = {
        offspring = { monster_group = "GROUP_REPRODUCTION_FEAR_DEER_BABIES" },
        count = 1,
        interval = 330,
    },
    tracking_distance = 9,
    aggression = -10,
    anger_triggers = { "PLAYER_NEAR_BABY", "PLAYER_WEAK", "FRIEND_ATTACKED", "FRIEND_DIED" },
    inheritance = {
        add = {
            attacks = {
                {
                    id = "psi_fear_deer_terror_attack",
                    spell = { id = "telepathic_fear_blast_monster", min_level = 5 },
                    casting_message = ccb.content.text("%1$s turns its head sideways and looks directly at %3$s."),
                    kind = "spell",
                    cooldown = { 9, 27 },
                    when = "monster_attack_psionics_available",
                },
                {
                    id = "psi_fear_deer_empower_herd",
                    spell = { id = "telepathic_network_monster", min_level = 5 },
                    cooldown = 50,
                    casting_message = ccb.content.text("%1$s raises its head with an air of authority."),
                    kind = "spell",
                    when = "monster_attack_psionics_available",
                },
            },
            flags = { "TEEP_IMMUNE", "KEEP_DISTANCE" },
        },
    },
}
