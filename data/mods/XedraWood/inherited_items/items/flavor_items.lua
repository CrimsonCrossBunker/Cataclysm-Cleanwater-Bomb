local ccb = require("ccb")
local content = ccb.content

do
    -- As the id indicates, this is a triffid spellbook, encoding information using scents and chemical triggers.  There's essentially zero chance of the survivor figuring out how to read it.
    local item = content.Item {
        id = "triffid_spellbook",
        category = "other",
        name = ccb.content.plural_text("chunk of plant matter", "chunks of plant matter"),
        description = ccb.content.text("This strange plant feels slightly oily and smells odd.  The smell seems to change slowly, from loamy earth to a rich vegetal smell to something acrid that burns your nose to an herbal scent, with no discernable pattern.  You're not sure what this is."),
        mass_milligrams = 1219000,
        volume_ml = 2500,
        color = "green",
        symbol = "%",
        price_postapoc_cents = 0,
    }
    item:material("veggy", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    content.upsert_item(item)
end
