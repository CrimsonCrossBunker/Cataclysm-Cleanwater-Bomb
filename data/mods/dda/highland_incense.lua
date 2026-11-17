local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local state = require("portal_storm_state")
local id = services.types.id

local function has(character, color)
    return state.checked(services.inventory.has_items(character,
        id("item", "highland_" .. color .. "_incense"), 1, 0))
end

local function resonance(character)
    local snapshot = state.checked(services.characters.snapshot(character))
    local value = math.modf(snapshot.combat.artifact_resonance)
    return value
end

local function field(character, name)
    services.gameplay.environment.add_field_area(state.position(character), name, { radius = 2 })
end

local function spell(character, name)
    state.checked(services.characters.cast_spell(character, id("spell", name), { hit_self = true }))
end

local choices = {
    { color = "purple", label = function() return services.translate("Burn purple incense.") end },
    { color = "red", label = function() return services.translate("Burn red incense.") end },
    { color = "yellow", label = function() return services.translate("Burn yellow incense.") end },
    { color = "green", label = function() return services.translate("Burn green incense.") end },
    { color = "black", label = function() return services.translate("Burn black incense.") end },
    { color = "white", label = function() return services.translate("Burn white incense.") end },
    { color = "blue", label = function() return services.translate("Burn blue incense.") end },
    { color = "golden", label = function() return services.translate("Burn golden incense.") end },
}

local function burn(character, color)
    state.message(character, services.translate("You swing the censer in a wide arc."))
    state.checked(services.characters.adjust(character, { moves = -200 }))
    if color == "blue" then
        state.add_effect(character, "invisibility", resonance(character) / 150)
    end
    state.checked(services.inventory.consume_by_type(character,
        id("item", "highland_" .. color .. "_incense"), 1, 0))
    if color == "purple" then
        field(character, "fd_purple_incense")
        return
    end
    if resonance(character) <= 2500 then
        field(character, "fd_incense")
        return
    end
    if color == "yellow" then
        spell(character, "AO_BOOK_SNAP")
        for _, effect in ipairs({ "purple_incense_effect", "red_incense_effect",
            "green_incense_effect", "black_incense_effect", "golden_incense_effect" }) do
            state.checked(services.effects.remove(character, id("effect", effect)))
        end
        field(character, "fd_yellow_incense")
    elseif color == "black" then
        state.message(character, services.translate("The smoke coalesces into a thick, black ring."))
        spell(character, "spell_black_incense")
        state.checked(services.world.transform_radius(state.position(character), 4,
            id("terrain_furniture_transform", "remove_black_incense")))
    elseif color == "white" then
        ccb.runtime.call_character("portal_storm_cycle", character)
        if services.gameplay.environment.dimension() == "default" then
            state.set("ps_str", state.number("ps_base_str") - 1)
        end
        field(character, "fd_incense")
    elseif color == "golden" then
        spell(character, "spell_golden_incense")
        field(character, "fd_incense")
    else
        field(character, "fd_" .. color .. "_incense")
    end
end

ccb.runtime.handler("highland_censer_use", function(context)
    local character = context.character
    if not character then return nil end
    local entries = {}
    for _, choice in ipairs(choices) do
        if has(character, choice.color) then
            entries[#entries + 1] = { id = choice.color, label = choice.label() }
        end
    end
    entries[#entries + 1] = { id = "cancel", label = services.translate("Cancel.") }
    local selected = ccb.presentation.choose(services.translate("Use what incense?"), entries)
    if selected and selected ~= "cancel" and has(character, selected) then
        burn(character, selected)
    end
    return 0
end)

do
    local item = content.Item {
        id = "highland_censer",
        name = content.plural_text("censer", "censers"),
        description = content.text("A small bronze vessel used to burn incense and other aromatic substances.  Its adorned with a variety of natural and knotwork designs."),
        looks_like = "oil_lamp",
        symbol = ";",
        color = "yellow",
        mass_grams = 1720,
        volume_ml = 1000,
        price_cents = 1000,
        price_postapoc_cents = 100,
    }
    item:material("bronze", 1)
    item:flag("MUNDANE")
    item:melee_damage("bash", 5)
    item:tool()
    item:passive_enchantment("ITEM_ENCH_dda_highland_censer_0")
    item:on_use("highland_censer_use", content.text("Burn incense"))
    content.upsert(item)
end

do
    local item = content.Item {
        id = "highland_purple_incense",
        name = content.plural_text("purple incense", "purple incense"),
        description = content.text("Small shards of a crystalline substance.  It has a strange smell, mostly of ozone."),
        category = "other",
        symbol = "*",
        color = "magenta",
        mass_grams = 10,
        volume_ml = 10,
        price_cents = 500,
        price_postapoc_cents = 0,
    }
    item:material("alien_resin", 1)
    content.upsert(item)
end

do
    local item = content.Item {
        id = "highland_yellow_incense",
        copy_from = "highland_purple_incense",
        name = content.plural_text("yellow incense", "yellow incense"),
        description = content.text("Small stones of fragrant resin.  They still maintain a faint scent of citrus and pine."),
        color = "yellow",
    }
    content.upsert(item)
end

do
    local item = content.Item {
        id = "highland_green_incense",
        copy_from = "highland_purple_incense",
        name = content.plural_text("green incense", "green incense"),
        description = content.text("Pearls of glossy green resin are mixed with small leaves and wood chips.  They have a fresh, herbal scent."),
        color = "green",
    }
    content.upsert(item)
end

do
    local item = content.Item {
        id = "highland_black_incense",
        copy_from = "highland_purple_incense",
        name = content.plural_text("black incense", "black incense"),
        description = content.text("A very fine and smooth powder.  It smells like it has already been burnt."),
        color = "black",
    }
    content.upsert(item)
end

do
    local item = content.Item {
        id = "highland_red_incense",
        copy_from = "highland_purple_incense",
        name = content.plural_text("red incense", "red incense"),
        description = content.text("Small branches and dried red flowers.  They have a weak acrid scent, like burnt coffee grounds."),
        color = "red",
    }
    content.upsert(item)
end

do
    local item = content.Item {
        id = "highland_blue_incense",
        copy_from = "highland_purple_incense",
        name = content.plural_text("blue incense", "blue incense"),
        description = content.text("Dead grubs float in some foul smelling blue gel.  They have an unnerving number of legs."),
        color = "blue",
    }
    content.upsert(item)
end

do
    local item = content.Item {
        id = "highland_white_incense",
        copy_from = "highland_purple_incense",
        name = content.plural_text("white incense", "white incense"),
        description = content.text("Milk-white spiral shells of some kind of mollusk.  The dead creatures inside still have a faint salty scent."),
        color = "white",
    }
    content.upsert(item)
end

do
    local item = content.Item {
        id = "highland_golden_incense",
        copy_from = "highland_purple_incense",
        name = content.plural_text("golden incense", "golden incense"),
        description = content.text("The dried remnants of a strange flower that was parasitized by golden mold.  It has a strange chemical scent, like honey mixed with gasoline."),
        color = "yellow",
    }
    content.upsert(item)
end

