local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
-- extra_effects for shocking_teleport, currently doesn't work, because of various issues in dash/teleport and extra_effects incompabilies.
ccb.content.define_spell {
    id = "shocking_teleport_damage",
    name = ccb.content.text_without_extraction("Shocking Teleport damage"),
    description = ccb.content.text_without_extraction("Deal some damage around the teleportation.  You can see it only in debug mode."),
    valid_targets = { "ally", "hostile", "ground" },
    effect = "attack",
    effect_data = "zapped",
    shape = "blast",
    max_level = 25,
    min_damage = { handler = "scaled_shocking_teleport_damage_min_damage", fallback = 2.0 },
    max_damage = { handler = "scaled_shocking_teleport_damage_max_damage", fallback = 14.0 },
    damage_type = "electric",
    flags = { "CONVEYANCE_SPELL", "RANDOM_DAMAGE", "LOUD", "SPLIT_DAMAGE" },
    min_duration = 100,
    max_duration = 500,
    min_aoe = 1,
    max_aoe = 7,
    aoe_increment = 0.25,
    field = "fd_electricity",
    field_chance = 1,
    min_field_intensity = 1,
    max_field_intensity = 10,
    field_intensity_increment = 0.4,
    field_intensity_variance = 3,
}
