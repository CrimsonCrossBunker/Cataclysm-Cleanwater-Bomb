local ccb = require("ccb")

ccb.content.define_spell {
    id = "xedra_chronomancer_revert_location_attune",
    name = ccb.content.text("Memorize Location"),
    description = ccb.content.text("Spend time memorizing an area so you can revert your physical location to that spot."),
    teachable = false,
    valid_targets = { "ground" },
    spell_class = "XEDRA_CHRONOMANCER",
    skill = "deduction",
    flags = { "SILENT", "NO_HANDS", "NO_LEGS", "NO_EXPLOSION_SFX", "NO_FAIL", "MUST_HAVE_CLASS_TO_LEARN" },
    difficulty = 0,
    max_level = 0,
    energy_source = "NONE",
    base_energy_cost = 0,
    magic_type = "xedra_chronomancy_magic",
    effect = "ter_transform",
    effect_data = "xedra_chronomancer_memorize_terrain_switch",
    shape = "blast",
    min_range = 0,
}
