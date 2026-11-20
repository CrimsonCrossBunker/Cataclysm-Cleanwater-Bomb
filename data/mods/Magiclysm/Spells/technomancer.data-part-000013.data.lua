local ccb = require("ccb")

ccb.content.define_spell {
    id = "technomancer_recharge_vehicle",
    name = ccb.content.text("Imbue with Lightning"),
    description = ccb.content.text("This fancifully-named and lengthy spell actually restores power to a battery or power grid.  An esoteric curiosity until electrical power became widespread, and even then, the power efficiency of fossil fuels rendered it a niche spell."),
    valid_targets = { "ground" },
    spell_class = "TECHNOMANCER",
    flags = {
        "CHANNELING_SPELL",
        "RANDOM_DAMAGE",
        "CONCENTRATE",
        "VERBAL",
        "SOMATIC",
        "NO_LEGS",
        "NO_EXPLOSION_SFX",
    },
    extra_spells = { { spell = "eoc_channeling_setup", self = true } },
    difficulty = 5,
    max_level = 20,
    effect = "recharge_vehicle",
    shape = "blast",
    min_damage = { handler = "scaled_technomancer_recharge_vehicle_min_damage", fallback = 1500.0 },
    max_damage = { handler = "scaled_technomancer_recharge_vehicle_max_damage", fallback = 2500.0 },
    min_range = 1,
    magic_type = "magiclysm_channeling_magic",
    base_energy_cost = 500,
    base_casting_time = 720000,
}
