local ccb = require("ccb")
local content = ccb.content

ccb.runtime.handler("mom_chaos_stone_use", function(payload)
    if payload.character then ccb.runtime.call_character("portal_storm_start", payload.character) end
    return 1
end)

local stone = content.Item {
    id = "chaos_stone", name = content.plural_text("compressed chaos", "compressed chaos"),
    description = content.text("This defies easy description, it feels solid but the surface is yielding.  Looking at it you are reminded of the electric tingle in the air before a portal storm."),
    color = "magenta", symbol = "@", mass_grams = 10, volume_ml = 250,
}
stone:tool()
stone:flag("SINGLE_USE")
stone:on_use("mom_chaos_stone_use", content.text("Activate"), content.text("Seems like chaos in solid form."))
content.add(stone)
