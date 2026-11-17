local ccb = require("ccb")
local services = ccb.services
local content = ccb.content
local id = services.types.id
local ascension = require("vampire_ascension")
local cleanup = require("vampire_power_cleanup")
local remove_drowned_morals = require("vampire_morality")
local weaknesses = require("vampire_weaknesses")

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function spend_amplifier(character, amplifier)
    value(services.inventory.remove_type(character, id("item", amplifier)))
    value(services.recipes.forget(character, id("recipe", amplifier)))
end

ccb.runtime.handler("use_sky_island_ascendant_amplifier", function(context)
    local character = context.character
    if not character then
        return 0
    end
    if not value(services.mutations.has_id_text(character, "VAMPIRE3")) then
        local infected = services.effects.get(character, id("effect", "vampire_virus"), id("body_part", "bp_null"))
        if infected.ok then
            context:message(ccb.services.translate("You lack the vampiric potency to use this."), "bad")
        elseif infected.error.code == "not_found" then
            context:message(ccb.services.translate("You cannot empower your vampirism without being a vampire."), "bad")
        else
            error(infected.error.message)
        end
        return 0
    end

    spend_amplifier(character, "upgradekey_vampire4")
    value(services.mutations.replace(character, id("mutation", "VAMPIRE4")))
    cleanup.remove_dream_magic(character)
    remove_drowned_morals(character)
    cleanup.remove_other_supernatural_powers(character)
    weaknesses.grant(character, 1)
    ascension.gain_ascendant_potency(character)
    return 0
end)

ccb.runtime.handler("use_sky_island_post_mortal_amplifier", function(context)
    local character = context.character
    if not character then
        return 0
    end
    spend_amplifier(character, "upgradekey_vampire5")
    value(services.mutations.replace(character, id("mutation", "BLOOD_DRINKER")))
    weaknesses.grant(character, 2)
    ascension.gain_post_mortal_potency(character)
    return 0
end)

content.add(content.Item {
    id = "upgradekey_vampire4",
    name = ccb.content.text("Vampiric Amplificator"),
    description = ccb.content.text("This strange metaphysical artifact will push your vampirism beyond the point of no return when you will use it.\n\nUnlike most things you can craft out of warp shards, this item won't be used automatically after you made it, so you can create it then take your time to decide if you really want to do this."),
    category = "spare_parts",
    mass_grams = 150,
    volume_ml = 250,
    longest_side_mm = 90,
    symbol = "V",
    color = "white",
}:material("stone", 1)
    :on_use("use_sky_island_ascendant_amplifier", ccb.content.text("Activate"), ccb.content.text("Empower your vampirism.")))

content.add(content.Recipe {
    id = "upgradekey_vampire4",
    result = "upgradekey_vampire4",
    category = "CC_WARP",
    subcategory = "CSC_WARP_UPGRADES",
    skill = "survival",
    difficulty = 0,
    duration_moves = 90000,
    activity_level = 1,
    flags = { "SECRET", "BLIND_EASY" },
    reversible = false,
}:tool("fakeitem_statue", 1)
    :component("warptoken", 25)
    :component_any {
        { id = "blood", count = 10 },
        { id = "demihuman_blood", count = 10 },
        { id = "mutant_human_blood", count = 10 },
        { id = "fae_blood", count = 10 },
    }
    :component("vacutainer", 5)
    :component("sinister_cane", 1)
    :component("cloak_vampire_red", 1)
    :component("cloak_vampire", 1))

content.add(content.Item {
    id = "upgradekey_vampire5",
    name = ccb.content.text("Superior Vampiric Amplificator"),
    description = ccb.content.text("This strange metaphysical artifact will push your vampirism to its absolute limit.\n\nAs per the previous vampiric amplificator, you have to decide to use the crafted item for its effect to apply."),
    category = "spare_parts",
    mass_grams = 150,
    volume_ml = 250,
    longest_side_mm = 90,
    symbol = "V",
    color = "white",
}:material("stone", 1)
    :on_use("use_sky_island_post_mortal_amplifier", ccb.content.text("Activate"), ccb.content.text("Empower your vampirism.")))

content.add(content.Recipe {
    id = "upgradekey_vampire5",
    result = "upgradekey_vampire5",
    category = "CC_WARP",
    subcategory = "CSC_WARP_UPGRADES",
    skill = "survival",
    difficulty = 0,
    duration_moves = 90000,
    activity_level = 1,
    flags = { "SECRET", "BLIND_EASY" },
    reversible = false,
}:tool("fakeitem_statue", 1)
    :component("warptoken", 50)
    :component("blood", 10)
    :component("demihuman_blood", 10)
    :component("mutant_human_blood", 10)
    :component("fae_blood", 10)
    :component("vampire_fangs", 1)
    :component("ruby_silver_ring", 1)
    :component("ruby_silver_tiara", 1)
    :component("ruby_silver_earring", 1)
    :component("ruby_silver_bracelet", 1)
    :component("ruby_silver_pendant_necklace", 1)
    :component("ruby_silver_cufflinks", 1))
