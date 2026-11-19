local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_pupating_psi",
    copy_from = "mon_zombie_pupa",
    name = ccb.content.plural_text("pupating blank", "pupating blanks"),
    description = ccb.content.text("This human corpse is wrapped in sticky black fibers that cover everything from the neck down.  Beneath the wrapping there is a strange rhythmic movement, grotesque to behold.  When you look directly at it, gray static flickers on the edge of your vision and you hear a very low droning hum."),
    species = { "ZOMBIE", "PSI_NULL" },
    emissions = { { id = "emit_anti_psi", delay = "1 s" } },
    color = "dark_gray_white",
    attacks = {
        { cooldown = 3, kind = "bite" },
        {
            spell = { id = "small_psi_raptor_spawn", hit_self = true },
            cooldown = 50,
            casting_message = ccb.content.text("%s bursts, and gore-smeared winged beasts climb out of the corpse!"),
            kind = "spell",
        },
    },
    armor = {
        electric = 1,
        psi_telekinetic_damage = 999,
        psi_telepathic_damage = 999,
        psi_teleporter_teleporting_damage = 999,
        psi_enervation_damage = 999,
    },
    inheritance = {
        add = {
            flags = {
                "ENERVATE_IMMUNE", "PHOTOKIN_MONSTER_IMMUNE", "TELEPORT_IMMUNE", "TEEP_IMMUNE",
                "TELEKIN_IMMUNE", "TELEKIN_PUSH_PULL_IMMUNE",
            },
        },
    },
}
