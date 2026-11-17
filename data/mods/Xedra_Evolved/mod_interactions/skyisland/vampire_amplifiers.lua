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

local function use_up_recipe_item(character, item_id)
    value(services.inventory.remove_type(character, id("item", item_id)))
    value(services.recipes.forget(character, id("recipe", item_id)))
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

    use_up_recipe_item(character, "upgradekey_vampire4")
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
    use_up_recipe_item(character, "upgradekey_vampire5")
    value(services.mutations.replace(character, id("mutation", "BLOOD_DRINKER")))
    weaknesses.grant(character, 2)
    ascension.gain_post_mortal_potency(character)
    return 0
end)

local function has_trait(character, trait)
    return value(services.mutations.has_id_text(character, trait))
end

local function learn(character, recipe)
    value(services.recipes.learn(character, id("recipe", recipe)))
end

local function knows(character, recipe)
    return value(services.recipes.knows(character, id("recipe", recipe)))
end

local function should_unlock(character, key, trait)
    return value(services.variables.get_string(character, key)).value ~= "yes"
        and has_trait(character, trait)
end

local function remember_unlock(character, key)
    -- The original variable write drew from the shared stream even for a single value.
    services.random.native_int(0, 0)
    value(services.variables.set(character, key, "yes", { include_before = false }))
    services.native_events.emit("u_var_changed", { key, "yes" })
end

local function notify_unlock(message)
    ccb.presentation.notice(message)
    services.activities.offer_interruption("")
    services.messages.add(message, "neutral")
end

local function at_island_core(character)
    local position = value(services.creatures.snapshot(character)).position
    local omt = services.coords.project_to(position, "omt")
    return services.overmap.matches_location(omt, "sky_island_core")
end

ccb.runtime.handler("unlock_sky_island_vampire_recipes", function()
    local character = services.characters.avatar()
    if should_unlock(character, "know_tier_4_recipes", "VAMPIRE3") and at_island_core(character) then
        notify_unlock(ccb.services.translate("Your potent vampirism has been noticed.  The island has given you the knowledge to push your vampirism even further, should you want to.\n\nBe warned that once you use this item, you will remain a vampire forevermore."))
        learn(character, "upgradekey_vampire4")
        remember_unlock(character, "know_tier_4_recipes")
    end
    if should_unlock(character, "know_tier_5_recipes", "VAMPIRE4") and at_island_core(character) then
        learn(character, "upgradekey_vampire5")
        learn(character, "upgradekey_bloodgift_research")
        notify_unlock(ccb.services.translate("You have decided to embrace your new condition, and the island has responded by giving you the knowledge to reach the apex of vampirism, should you find the required components."))
        remember_unlock(character, "know_tier_5_recipes")
    end
end)
ccb.runtime.on("game:avatar_enters_omt", "unlock_sky_island_vampire_recipes")

ccb.runtime.handler("restore_sky_island_vampire_reshuffle_recipe", function()
    local character = services.characters.avatar()
    if knows(character, "xe_vampire_blood_gift_research")
        and not knows(character, "xe_vampire_blood_weaknesses_reshuffle") then
        learn(character, "xe_vampire_blood_weaknesses_reshuffle")
        services.messages.add(ccb.services.translate("You can now reshuffle your weaknesses."), "neutral")
    end
end)
ccb.runtime.on("game:game_load", "restore_sky_island_vampire_reshuffle_recipe")

ccb.runtime.handler("start_sky_island_vampire", function()
    local character = services.characters.avatar()
    if has_trait(character, "START_AS_VAMPIRE") then
        local result = services.effects.add(character, id("effect", "vampire_virus"),
            services.time.duration(1, "turn"), { intensity = 1, permanent = true })
        if not result.ok and result.error.code ~= "rejected" then
            error(result.error.message)
        end
    end
end)
ccb.runtime.on("game:game_start", "start_sky_island_vampire")

ccb.runtime.handler("use_sky_island_vampire_knowledge", function(context)
    local character = context.character
    if not character then
        return 0
    end
    use_up_recipe_item(character, "upgradekey_bloodgift_research")
    learn(character, "xe_vampire_blood_gift_research")
    learn(character, "xe_vampire_blood_gift_refinement_research")
    learn(character, "xe_vampire_blood_weaknesses_reshuffle")
    context:message(ccb.services.translate("You learn how to expand your blood gifts and reshuffle your weaknesses."), "good")
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

content.add(content.Item {
    id = "upgradekey_bloodgift_research",
    name = ccb.content.text("Key of Vampiric Knowledge"),
    description = ccb.content.text("This strange metaphysical artifact will allow you to spend your blood to obtain new blood gifts and reshuffle your weaknesses.\n\nAs per the previous vampiric amplificator, you have to decide to use the crafted item for its effect to apply."),
    category = "spare_parts",
    mass_grams = 150,
    volume_ml = 250,
    longest_side_mm = 90,
    symbol = "V",
    color = "white",
}:material("stone", 1)
    :on_use("use_sky_island_vampire_knowledge", ccb.content.text("Activate"), ccb.content.text("Empower your vampirism.")))

-- Books about blood and things made from blood.
content.add(content.Recipe {
    id = "upgradekey_bloodgift_research",
    result = "upgradekey_bloodgift_research",
    category = "CC_WARP",
    subcategory = "CSC_WARP_UPGRADES",
    skill = "survival",
    difficulty = 0,
    duration_moves = 90000,
    activity_level = 1,
    flags = { "SECRET", "BLIND_EASY" },
    reversible = false,
}:tool("fakeitem_statue", 1)
    :component("warptoken", 20)
    :component_any {
        { id = "blood", count = 10 },
        { id = "demihuman_blood", count = 10 },
        { id = "mutant_human_blood", count = 10 },
        { id = "fae_blood", count = 10 },
    }
    :component("paperback_romance_diodes", 1)
    :component("cookbook_bloodforgood", 1)
    :component("blood_pancakes", 1)
    :component("blood_rice_pudding", 1)
    :component("blutwurst_sausage", 1)
    :component("drink_bloody_mary_blood", 1)
    :component("soup_blood", 1))
