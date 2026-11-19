local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "AO_BOOK_BLAST",
    name = ccb.content.text_without_extraction("Book blast Attack"),
    description = ccb.content.text_without_extraction("A cone AOE cut damage attack."),
    message = ccb.content.text("Razor sharp pages shoot out from the book when you open it."),
    valid_targets = { "self" },
    extra_spells = { { spell = "AO_BOOK_BLAST_ATTACK" } },
    effect = "attack",
    shape = "blast",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
}
