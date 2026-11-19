local ccb = require("ccb")
local content = ccb.content

local rune = content.Item {
    id = "rune_sorcerer",
    symbol = "=",
    color = "light_red",
    name = ccb.content.text("counterfeit rune"),
    description = ccb.content.text("This magical pebble is infused with a sorcerer's power.  It can trick spells that require runes to cast to think that you have the rune required."),
}
rune:tool():volume_ml(5):mass_grams(1):material("stone"):flag("TRADER_AVOID")
content.add(rune)

content.upsert_spell(content.Spell {
    id = "create_rune_sorcerer",
    name = ccb.content.text("Counterfeit Rune"),
    description = ccb.content.text("This ritual creates a small pebble infused with a sorcerer's power.  It can trick spells that require runes to cast to think that you have the rune required."),
    message = ccb.content.text_without_extraction("You cast %s!"),
    sound_description = ccb.content.text_without_extraction("an explosion."),
    valid_targets = { "self" },
    min_damage = 1,
    max_damage = 1,
    effect = "spawn_item",
    effect_data = "rune_sorcerer",
    shape = "blast",
    base_casting_time = 5000,
    base_energy_cost = 5,
    min_duration = 1,
    max_duration = 2,
    duration_increment = 1,
    difficulty = 0,
    max_level = 0,
    spell_class = "SORCERER",
    energy_source = "HP",
    flags = { "PERMANENT", "NO_LEGS", "CONCENTRATE" },
})

content.upsert_spell(content.Spell {
    id = "convert_sorcerer",
    name = ccb.content.text("Convert"),
    description = ccb.content.text("Kill an ally creature, converting its life energy into a compact rune, that you can use afterwards."),
    valid_targets = { "ally" },
    flags = { "CONCENTRATE", "SOMATIC", "SILENT", "PERCENTAGE_DAMAGE" },
    effect = "attack",
    shape = "blast",
    message = "",
    sound_description = ccb.content.text_without_extraction("an explosion."),
    min_damage = 100,
    max_damage = 100,
    min_range = 10,
    max_range = 10,
    base_energy_cost = 250,
    spell_class = "ANIMIST",
    difficulty = 4,
    max_level = 10,
    base_casting_time = 30000,
    final_casting_time = 1000,
    casting_time_increment = -200,
    energy_source = "MANA",
}:extra_spell { id = "create_rune_sorcerer", hit_self = true })
