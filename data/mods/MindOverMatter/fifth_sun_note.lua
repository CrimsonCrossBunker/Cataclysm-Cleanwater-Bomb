local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

ccb.runtime.handler("read_fifth_sun_note", function(ctx)
    local character = ctx.character
    if not character or character.subtype ~= "avatar" then
        return 0
    end
    local fifth_sun = services.mutations.has(character, services.types.id("mutation", "FIFTH_SUN_PEOPLE"))
    if not fifth_sun.ok then error(fifth_sun.error.message) end
    if fifth_sun.value then
        ctx:message(ccb.services.translate("You take a closer look at the note and, with mounting excitement, realize its written in the Imperial Speech!  The blocky Imperial-military-standard characters read, \"I do not know if there are any who will read this, but I am still alive.  I survived the disaster of the Texopapalotl and awakened in a scientific facility filled with demons.  I fought my way out and found a place of some safety.  If you can read this, find me.\nXiuhcozcatl, Squad Leader, Eighth Band\"  Below it is a map of a small building by a lake, though you don't recognize the nearby terrain."))
    else
        ctx:message(ccb.services.translate("The note is written in another language with some kind of pictographic characters.  They look vaguely…Mayan?  Regardless, you can't read them.  There is a crude map drawn below the characters, however, showing a house or similar structure by a lake."))
    end
    return 0
end)

do
    local item = content.Item {
        id = "quest_starter_note_fifth_sun_cuachic",
        name = ccb.content.plural_text("note with strange writing", "notes with strange writing"),
        category = "books",
        description = ccb.content.text("A piece of half-crumpled paper with writing on it.  You'd need to take a closer look to figure out what it says."),
        melee_to_hit = -3,
        color = "white",
        symbol = ",",
        copy_from = "paper",
        looks_like = "paper",
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:clear_use_actions()
    item:on_use("read_fifth_sun_note", ccb.content.text("Activate"), ccb.content.text("Examine the note."))
    content.add(item)
end
