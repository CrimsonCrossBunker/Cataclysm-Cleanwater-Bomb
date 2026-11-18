local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local duration = services.time.duration
local spent_tincture = id("item", "afs_espertech_gain_esper_powers_used")

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function enkindle(effect_name)
    local effect = id("effect", effect_name)
    return function(ctx)
        local character = ctx.character
        if character then
            ctx:message(ccb.services.translate(
                "You feel the pressure of the tincture against your skin and a warmth slowly spreads through your body."
            ), "mixed")
            local turns = 7200 + services.random.native_int(0, 10800)
            value(services.effects.add(character, effect, duration(turns, "turn")))
            value(services.inventory.receive_item(character, spent_tincture, 1))
        end
        return 1
    end
end

local specializations = {
    effect_afs_esper_tincture_geist = {
        trait = "AFS_TELEKINETIC",
        spell = "afs_telekinetic_move_item",
        practice = "practice_afs_telekinetic_move_items",
    },
    effect_afs_esper_tincture_spark = {
        trait = "AFS_ELECTROKINETIC",
        spell = "afs_electrokinetic_see_electric",
        practice = "practice_afs_electrokinetic_see_electric",
    },
    effect_afs_esper_tincture_sybil = {
        trait = "AFS_PRECOG",
        spell = "afs_precog_danger_sense",
        practice = "practice_afs_precog_danger_sense",
    },
    effect_afs_esper_tincture_whisper = {
        trait = "AFS_TELEPATH",
        spell = "afs_telepathic_shield",
        practice = "practice_afs_telepathic_shield",
    },
}

local genemods = {
    "AFS_PHYSICAL_CAPABILITY_GENEMOD",
    "AFS_MENTAL_CAPABILITY_GENEMOD",
    "AFS_HEALTH_CAPABILITY_GENEMOD",
    "AFS_RECOVERY_CAPABILITY_GENEMOD",
    "AFS_BEAUTY_GENEMOD",
}

local function has_trait(character, trait)
    return value(services.mutations.has_id_text(character, trait))
end

local function enkindling_succeeds(character)
    if has_trait(character, "ESPER") or has_trait(character, "CANNOT_GAIN_PSIONICS") then
        return false
    end
    for _, trait in ipairs(genemods) do
        if has_trait(character, trait) then
            return services.random.native_probability(1, 200)
        end
    end

    -- Roll the chance even for an eligible character, matching the native RNG sequence.
    local chance = services.random.native_float(5, 15)
    return has_trait(character, "ESPER_ADVANCEMENT_OKAY") or services.random.native_probability(chance, 100)
end

ccb.runtime.handler("finish_esper_enkindling", function(event)
    local specialization = specializations[event.data.effect]
    if not specialization then return end

    -- Native effect events fall back to the avatar when no event character is resolvable.
    local character = event.actors.character or services.creatures.avatar()
    local avatar = value(services.creatures.snapshot(character)).kind == "avatar"
    if not enkindling_succeeds(character) then
        if avatar then
            services.messages.add(ccb.services.translate(
                "The effects of the enkindling tincture fade, but you don't feel any different."
            ), "mixed")
        end
        return
    end

    if avatar then
        services.messages.add(ccb.services.translate(
            "The effects of the enkindling tincture fade, and then you feel a tingling through your entire body."
        ), "mixed")
    end
    value(services.achievements.complete(id("achievement", "achievement_psion")))
    value(services.activities.cancel(character))
    value(services.mutations.replace(character, id("mutation", "ESPER")))
    if not has_trait(character, "ESPER_ADVANCEMENT_OKAY")
        and not has_trait(character, "ESPER_STARTER_ADVANCEMENT_OKAY") then
        value(services.mutations.replace(character, id("mutation", "ESPER_STARTER_ADVANCEMENT_OKAY")))
    end
    value(services.mutations.replace(character, id("mutation", specialization.trait)))
    value(services.spells.set_level(character, id("spell", specialization.spell), 1))
    value(services.recipes.learn(character, id("recipe", specialization.practice)))
end)
ccb.runtime.on("game:character_loses_effect", "finish_esper_enkindling")

ccb.runtime.handler("use_afs_espertech_gain_esper_powers", function() return 1 end)

do
    local item = content.Item {
        id = "afs_espertech_gain_esper_powers",
        name = ccb.content.plural_text("enkindling tincture", "enkindling tincture"),
        description = ccb.content.text("A palm-sized device with a large Ψ on one side and spiraling text identifying it as treatment for enkindling latent esper powers, should the bearer possess any."),
        mass_milligrams = 250000,
        volume_ml = 150,
        price_cents = 1000000,
        price_postapoc_cents = 1000000,
        symbol = "!",
        color = "blue",
    }
    item:material("alien_liquid", 1)
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:clear_use_actions()
    item:on_use("use_afs_espertech_gain_esper_powers", ccb.content.text("Use the enkindling tincture"), ccb.content.text("You place the enkindling tincture against your bare skin and trigger it."))
    content.add(item)
end

ccb.runtime.handler("use_afs_espertech_gain_esper_powers_used", function(ctx)
    ctx:message(ccb.services.translate(
        "You feel the pressure of the tincture against your skin, but nothing happens."
    ), "neutral")
    return 1
end)

do
    local item = content.Item {
        id = "afs_espertech_gain_esper_powers_used",
        copy_from = "afs_espertech_gain_esper_powers",
        looks_like = "afs_espertech_gain_esper_powers",
        description = ccb.content.text("A palm-sized device with a large Ψ on one side and spiraling text identifying it as treatment for enkindling latent esper powers, should the bearer possess any.  This one has already been activated."),
        price_cents = 1000,
        price_postapoc_cents = 1000,
        name = ccb.content.plural_text("enkindling tincture (spent)", "enkindling tincture (spent)"),
    }
    item:clear_flags()
    item:clear_use_actions()
    item:on_use("use_afs_espertech_gain_esper_powers_used", ccb.content.text("Use the enkindling tincture"), ccb.content.text("You place the enkindling tincture against your bare skin and trigger it."))
    content.add(item)
end

ccb.runtime.handler("use_afs_espertech_gain_esper_powers_geist", enkindle("effect_afs_esper_tincture_geist"))

do
    local item = content.Item {
        id = "afs_espertech_gain_esper_powers_geist",
        copy_from = "afs_espertech_gain_esper_powers",
        looks_like = "afs_espertech_gain_esper_powers",
        name = ccb.content.plural_text("enkindling tincture", "enkindling tincture"),
    }
    item:clear_use_actions()
    item:on_use("use_afs_espertech_gain_esper_powers_geist", ccb.content.text("Use the enkindling tincture"), ccb.content.text("You place the enkindling tincture against your bare skin and trigger it."))
    content.add(item)
end

ccb.runtime.handler("use_afs_espertech_gain_esper_powers_spark", enkindle("effect_afs_esper_tincture_spark"))

do
    local item = content.Item {
        id = "afs_espertech_gain_esper_powers_spark",
        copy_from = "afs_espertech_gain_esper_powers",
        looks_like = "afs_espertech_gain_esper_powers",
        name = ccb.content.plural_text("enkindling tincture", "enkindling tincture"),
    }
    item:clear_use_actions()
    item:on_use("use_afs_espertech_gain_esper_powers_spark", ccb.content.text("Use the enkindling tincture"), ccb.content.text("You place the enkindling tincture against your bare skin and trigger it."))
    content.add(item)
end

ccb.runtime.handler("use_afs_espertech_gain_esper_powers_sybil", enkindle("effect_afs_esper_tincture_sybil"))

do
    local item = content.Item {
        id = "afs_espertech_gain_esper_powers_sybil",
        copy_from = "afs_espertech_gain_esper_powers",
        looks_like = "afs_espertech_gain_esper_powers",
        name = ccb.content.plural_text("enkindling tincture", "enkindling tincture"),
    }
    item:clear_use_actions()
    item:on_use("use_afs_espertech_gain_esper_powers_sybil", ccb.content.text("Use the enkindling tincture"), ccb.content.text("You place the enkindling tincture against your bare skin and trigger it."))
    content.add(item)
end

ccb.runtime.handler("use_afs_espertech_gain_esper_powers_whisper", enkindle("effect_afs_esper_tincture_whisper"))

do
    local item = content.Item {
        id = "afs_espertech_gain_esper_powers_whisper",
        copy_from = "afs_espertech_gain_esper_powers",
        looks_like = "afs_espertech_gain_esper_powers",
        name = ccb.content.plural_text("enkindling tincture", "enkindling tincture"),
    }
    item:clear_use_actions()
    item:on_use("use_afs_espertech_gain_esper_powers_whisper", ccb.content.text("Use the enkindling tincture"), ccb.content.text("You place the enkindling tincture against your bare skin and trigger it."))
    content.add(item)
end
