local ccb = require("ccb")

ccb.content.define_spell {
    id = "biomancer_pull_items_from_distance",
    name = ccb.content.text("Monstrous Grasp"),
    description = ccb.content.text("Extend a tentacle with a myriad of grasping appendages, grasping an item and dragging it back to you.  This spell is slightly painful due to the rapidity of the transformation."),
    valid_targets = { "ally", "hostile", "item", "ground" },
    spell_class = "BIOMANCER",
    flags = { "TRANSFORMATION_SPELL", "CONCENTRATE", "VERBAL", "SOMATIC", "NO_HANDS" },
    extra_spells = {
        { spell = "eoc_transformation_setup", self = true },
        { spell = "biomantic_pain_caused_light", self = true },
    },
    difficulty = 4,
    max_level = 10,
    effect = "pickup",
    shape = "blast",
    min_damage = { handler = "scaled_biomancer_pull_items_from_distance_min_damage", fallback = 350.0 },
    max_damage = { handler = "scaled_biomancer_pull_items_from_distance_min_damage", fallback = 350.0 },
    min_range = 3,
    max_range = 8,
    range_increment = 0.5,
    magic_type = "magiclysm_transformation_magic",
    base_energy_cost = 100,
    base_casting_time = 150,
}
