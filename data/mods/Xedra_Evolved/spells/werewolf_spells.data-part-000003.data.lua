local ccb = require("ccb")

ccb.content.define_spell {
    id = "xe_werewolf_summon_shadow_pack_spell",
    skill = "deduction",
    shape = "blast",
    effect = "summon",
    effect_data = "mon_werewolf_shadow_pack",
    spell_class = "WEREWOLF_SPELLS",
    magic_type = "xe_werewolf_powers",
    name = "Summon the Shadow Pack",
    description = "Even death cannot always stop the Hunt.  You may summon the spirits of werewolves long dead back to join you in the Hunt.  You may only call the Shadow Pack once per night.",
    message = "",
    teachable = false,
    flags = { "VERBAL", "NO_HANDS", "RANDOM_DAMAGE", "RANDOM_DURATION" },
    valid_targets = { "ground" },
    min_damage = 3,
    max_damage = 5,
    min_aoe = 2,
    max_aoe = 2,
    min_duration = 173195,
    max_duration = 318512,
    base_energy_cost = 800,
    difficulty = 9,
    base_casting_time = 150,
    caster_when = "wave14a_xedra_evolved_cond_14",
    extra_spells = {
        {
            spell = "xe_werewolf_summon_shadow_pack_limiter_spell",
            self = true,
        },
    },
}
