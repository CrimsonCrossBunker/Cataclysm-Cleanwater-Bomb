local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function set_seen_flag(character, key)
    -- Preserve the native RNG draw from choosing a single possible value.
    services.random.native_int(0, 0)
    if character then
        value(services.variables.set(character, key, "yes", { include_before = false }))
    end
    services.native_events.emit("u_var_changed", { key, "yes" })
end

ccb.runtime.handler("study_labyrinth_shard", function(ctx)
    local character = ctx.character
    local seen = character and value(services.variables.get_string(character, "ls_used_holographic_shard")).value == "yes"
    if character and character.subtype == "avatar" then
        local text
        if seen then
            text = ccb.services.translate("You glance into the depths of the shard.  You don't see anything.")
        else
            text = ccb.services.translate("You glance into the depths of the shard and there is a strange sensation, as if you were experiencing someone's memories, forcing their way into your mind.  They are too foreign for you to comprehend, and they quickly pass from your own memory.  But, you realize you now possess a Passcode.  You fail for a moment to reconcile this understanding, because it's no password as you previously understood it.  It is, in fact, the sound of KÁ!")
        end
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        ctx:message(text)
    end
    if not seen then
        if character then
            value(services.mutations.replace(character, id("mutation", "LS_Passcode_string_dimension")))
        end
        set_seen_flag(character, "ls_had_a_passcode")
        set_seen_flag(character, "ls_used_holographic_shard")
    end
    local carried = character and value(services.inventory.contains(character, ctx.item))
    value(services.items.transform(ctx.item, id("item", "ls_sd_passcode_used"), {
        carrier = carried and character or nil,
        active = false,
    }))
    return 0
end)

do
    local item = content.Item {
        id = "ls_sd_passcode",
        name = ccb.content.plural_text("holographic shard", "holographic shards"),
        category = "artifact",
        symbol = ",",
        color = "blue",
        description = ccb.content.text("A palm-sized shard of alien glass, reflecting light in holographic prisms.  You think you can see something in its depths.  Activate it to look closer."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 10000,
        volume_ml = 5,
    }
    item:material("anomaly", 1)
    item:on_use("study_labyrinth_shard", ccb.content.text("Study the shard"), ccb.content.text("Study the shard"))
    content.add(item)
end

do
    local item = content.Item {
        id = "ls_sd_passcode_used",
        name = ccb.content.plural_text("holographic shard (used)", "holographic shards (used)"),
        category = "artifact",
        symbol = ",",
        color = "blue",
        description = ccb.content.text("A palm-sized shard of alien glass, reflecting light in holographic prisms."),
        price_cents = 0,
        price_postapoc_cents = 0,
        mass_milligrams = 10000,
        volume_ml = 5,
    }
    item:material("anomaly", 1)
    content.add(item)
end
