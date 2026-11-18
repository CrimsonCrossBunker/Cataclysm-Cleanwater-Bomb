local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id
local spells = services.spells
local completion = "finish_arvore_treesinging"
local outcomes = {}

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function message(character, text, severity)
    if character.subtype ~= "npc" then
        services.messages.add(text, severity)
    end
end

local function mana(character)
    return checked(spells.mana(character)).current
end

local function receive(character, item, count)
    checked(services.inventory.receive_item(character, id("item", item), count))
end

local function finish_treesinging(character, outcome)
    if mana(character) < outcome.mana then
        message(character, services.translate("You do not have enough mana to treesing the wood properly."), "bad")
        checked(spells.set_mana_raw(character, 0))
        return
    end
    local known = checked(spells.count(character, id("mutation", "ARVORE")))
    local cost = outcome.mana
    if known >= outcome.spells then
        message(character, outcome.success(), "good")
        receive(character, outcome.item, outcome.count or 1)
    else
        message(character, services.translate("Your attempts to sing the wood fail, ruining it!"), "bad")
        local splinters = math.modf(services.random.native_float(outcome.splinters[1], outcome.splinters[2]))
        receive(character, "splinter", splinters)
        local twigs = math.modf(services.random.native_float(outcome.twigs[1], outcome.twigs[2]))
        receive(character, "twig", twigs)
        cost = outcome.failure_mana or cost
    end
    checked(spells.set_mana_raw(character, mana(character) - cost))
end

ccb.runtime.handler(completion, function(payload)
    local outcome = outcomes[payload.recipe_id]
    for _ = 1, payload.batch do
        finish_treesinging(payload.character, outcome)
    end
end, 1)

local function register(options)
    outcomes[options.id] = options.outcome
    local recipe = content.Recipe {
        id = options.id,
        name = options.name,
        description = options.description,
        skill = "gramarye",
        duration_moves = options.minutes * 60 * 100,
        activity_level = 4,
        difficulty = options.difficulty,
        category = "CC_*",
        subcategory = "CSC_*_NESTED",
        autolearn = false,
        flags = { "SECRET", "BLIND_HARD" },
        scripted_output = true,
    }:component("log_treesung", options.logs)
        :proficiency("prof_treesinging")
        :on_complete(completion)
    if options.equipment then
        recipe:proficiency("prof_treesinging_equipment")
    end
    if options.leaves then
        recipe:component_any {
            { id = "leaves", count = options.leaves },
            { id = "young_leaves", count = options.leaves },
            { id = "grape_leaves", count = options.leaves },
        }
    end
    if options.byproduct_splinters then
        recipe:byproduct("splinter", options.byproduct_splinters)
    end
    content.add(recipe)
end

register {
    id = "create_chair_wood_treesung",
    name = content.text("treesung wooden chair"),
    description = content.text("Use your magick to turn treesung wood into a chair.\n\nYou must know <color_yellow>5 Arvore spells</color> and have at least <color_yellow>300 mana</color> to create the item."),
    difficulty = 3,
    minutes = 60,
    logs = 1,
    outcome = {
        mana = 300,
        spells = 5,
        item = "chair_treesung",
        splinters = { 50, 150 },
        twigs = { 10, 30 },
        success = function()
            return services.translate("As your song fades, you behold a wooden chair all made of a single solid piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_wardrobe_wood_treesung",
    name = content.text("treesung wooden wardrobe"),
    description = content.text("Use your magick to turn treesung wood into a wardrobe.\n\nYou must know <color_yellow>8 Arvore spells</color> and have at least <color_yellow>750 mana</color> to create the item."),
    difficulty = 6,
    minutes = 200,
    logs = 4,
    outcome = {
        mana = 750,
        spells = 8,
        item = "wardrobe_treesung",
        splinters = { 250, 450 },
        twigs = { 20, 50 },
        success = function()
            return services.translate("As your song fades, you behold a wardrobe all made of a single solid piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_table_wood_treesung",
    name = content.text("treesung wooden table"),
    description = content.text("Use your magick to turn treesung wood into a table.\n\nYou must know <color_yellow>6 Arvore spells</color> and have at least <color_yellow>400 mana</color> to create the item."),
    difficulty = 4,
    minutes = 100,
    logs = 1,
    outcome = {
        mana = 400,
        spells = 6,
        item = "table_treesung",
        splinters = { 50, 150 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a table all made of a single solid piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_bedframe_wood_treesung",
    name = content.text("treesung wooden bed frame"),
    description = content.text("Use your magick to turn treesung wood into a bed frame.\n\nYou must know <color_yellow>4 Arvore spells</color> and have at least <color_yellow>200 mana</color> to create the item."),
    difficulty = 2,
    minutes = 45,
    logs = 1,
    outcome = {
        mana = 200,
        spells = 4,
        item = "bedframe_treesung",
        splinters = { 50, 150 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a bed frame all made of a single solid piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_verdant_helm",
    name = content.text("verdant helm"),
    description = content.text("Use your magick to turn treesung wood into a helmet made of living wood.\n\nYou must know <color_yellow>7 Arvore spells</color> and have at least <color_yellow>500 mana</color> to create the item."),
    difficulty = 5,
    minutes = 180,
    logs = 1,
    equipment = true,
    leaves = 20,
    byproduct_splinters = 100,
    outcome = {
        mana = 500,
        spells = 7,
        item = "helmet_verdant",
        splinters = { 25, 75 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a helmet all made of a single solid piece of wood, with a cushioning of moss and green leaves underneath it, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_verdant_cuirass",
    name = content.text("verdant helm"),
    description = content.text("Use your magick to turn treesung wood into a cuirass made of living wood.\n\nYou must know <color_yellow>10 Arvore spells</color> and have at least <color_yellow>950 mana</color> to create the item."),
    difficulty = 7,
    minutes = 300,
    logs = 1,
    equipment = true,
    leaves = 40,
    byproduct_splinters = 15,
    outcome = {
        mana = 950,
        spells = 10,
        item = "armor_verdant_cuirass",
        splinters = { 10, 80 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a cuirass all made of a single solid piece of wood, with a cushioning of moss and green leaves underneath it, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_verdant_gauntlets",
    name = content.text("verdant gauntlets"),
    description = content.text("Use your magick to turn treesung wood into a set of gauntlets made of living wood.\n\nYou must know <color_yellow>9 Arvore spells</color> and have at least <color_yellow>850 mana</color> to create the item."),
    difficulty = 6,
    minutes = 200,
    logs = 1,
    equipment = true,
    leaves = 20,
    byproduct_splinters = 40,
    outcome = {
        mana = 850,
        spells = 9,
        item = "gauntlets_verdant",
        splinters = { 30, 100 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a set of gauntlets all made of a single solid piece of wood, with a cushioning of moss and green leaves underneath it, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_verdant_leg_guards",
    name = content.text("verdant leg guards"),
    description = content.text("Use your magick to turn treesung wood into a set of leg guards made of living wood.\n\nYou must know have <color_yellow>10 Arvore spells</color> and have at least <color_yellow>850 mana</color> to create the item."),
    difficulty = 7,
    minutes = 250,
    logs = 1,
    equipment = true,
    leaves = 30,
    byproduct_splinters = 25,
    outcome = {
        mana = 850,
        spells = 10,
        item = "leg_guards_verdant",
        splinters = { 10, 80 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a set of leg guards all made of a single solid piece of wood, with a cushioning of moss and green leaves underneath it, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_verdant_boots",
    name = content.text("verdant boots"),
    description = content.text("Use your magick to turn treesung wood into a set of boots made of living wood.\n\nYou must know <color_yellow>8 Arvore spells</color> and have at least <color_yellow>750 mana</color> to create the item."),
    difficulty = 6,
    minutes = 180,
    logs = 1,
    equipment = true,
    leaves = 25,
    byproduct_splinters = 35,
    outcome = {
        mana = 750,
        spells = 8,
        item = "boots_verdant",
        splinters = { 25, 90 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a set of boots all made of a single solid piece of wood, with a cushioning of moss and green leaves underneath it, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_verdant_cloak",
    name = content.text("verdant cloak"),
    description = content.text("Use your magick to turn treesung wood into a cloak made of living wood and leaves.\n\nYou must know <color_yellow>7 Arvore spells</color> and have at least <color_yellow>500 mana</color> to create the item."),
    difficulty = 4,
    minutes = 140,
    logs = 1,
    equipment = true,
    leaves = 80,
    byproduct_splinters = 150,
    outcome = {
        mana = 500,
        spells = 7,
        item = "cloak_verdant",
        splinters = { 75, 150 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a cloak all made of a living leaves woven together with thin branches, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_shortbow_treesung",
    name = content.text("treesung shortbow"),
    description = content.text("Use your magick to turn treesung wood into a self bow made of living wood and a thin vine.\n\nYou must know <color_yellow>4 Arvore spells</color> and have at least <color_yellow>350 mana</color> to create the item."),
    difficulty = 1,
    minutes = 120,
    logs = 1,
    equipment = true,
    byproduct_splinters = 150,
    outcome = {
        mana = 350,
        spells = 4,
        item = "treesung_bow",
        splinters = { 75, 150 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a bow all made of a single piece of wood with a thin vine for a string, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_greatbow_treesung",
    name = content.text("treesung greatbow"),
    description = content.text("Use your magick to turn treesung wood into an enormous bow made of living wood and a thin vine.\n\nYou must know <color_yellow>6 Arvore spells</color> and have at least <color_yellow>600 mana</color> to create the item."),
    difficulty = 3,
    minutes = 240,
    logs = 1,
    equipment = true,
    byproduct_splinters = 50,
    outcome = {
        mana = 600,
        spells = 6,
        item = "treesung_greatbow",
        failure_mana = 350,
        splinters = { 40, 80 },
        twigs = { 5, 10 },
        success = function()
            return services.translate("As your song fades, you behold an enormous bow all made of a single piece of wood with a thin vine for a string, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_arrow_treesung",
    name = content.text("treesung arrows"),
    description = content.text("Use your magick to turn treesung wood into a set of arrows made of living wood fletched with leaves.\n\nYou must know <color_yellow>4 Arvore spells</color> and have at least <color_yellow>400 mana</color> to create the item."),
    difficulty = 0,
    minutes = 60,
    logs = 1,
    equipment = true,
    leaves = 20,
    byproduct_splinters = 100,
    outcome = {
        mana = 400,
        spells = 4,
        item = "arrow_treesung",
        count = 20,
        splinters = { 80, 180 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a set of arrows fletched with leaves, as though they had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_spear_treesung",
    name = content.text("treesung spear"),
    description = content.text("Use your magick to turn treesung wood into a spear made of living wood.\n\nYou must know <color_yellow>3 Arvore spells</color> and have at least <color_yellow>200 mana</color> to create the item."),
    difficulty = 0,
    minutes = 30,
    logs = 1,
    equipment = true,
    byproduct_splinters = 150,
    outcome = {
        mana = 200,
        spells = 3,
        item = "treesung_spear",
        splinters = { 75, 150 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a spear all made of a single piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_pike_treesung",
    name = content.text("treesung long spear"),
    description = content.text("Use your magick to turn treesung wood into a long spear made of living wood.\n\nYou must know <color_yellow>5 Arvore spells</color> and have at least <color_yellow>350 mana</color> to create the item."),
    difficulty = 2,
    minutes = 80,
    logs = 1,
    equipment = true,
    byproduct_splinters = 50,
    outcome = {
        mana = 350,
        spells = 5,
        item = "treesung_pike",
        splinters = { 75, 150 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a long spear all made of a single piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_mace_treesung",
    name = content.text("treesung mace"),
    description = content.text("Use your magick to turn treesung wood into a heavy mace made of living wood.\n\nYou must know <color_yellow>5 Arvore spells</color> and have at least <color_yellow>350 mana</color> to create the item."),
    difficulty = 2,
    minutes = 80,
    logs = 1,
    equipment = true,
    byproduct_splinters = 50,
    outcome = {
        mana = 350,
        spells = 5,
        item = "treesung_mace",
        splinters = { 75, 150 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a mace all made of a single piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_q_staff_treesung",
    name = content.text("treesung quarterstaff"),
    description = content.text("Use your magick to turn treesung wood into a quarterstaff made of living wood.\n\nYou must know <color_yellow>3 Arvore spells</color> and have at least <color_yellow>150 mana</color> to create the item."),
    difficulty = 0,
    minutes = 30,
    logs = 1,
    equipment = true,
    byproduct_splinters = 150,
    outcome = {
        mana = 150,
        spells = 3,
        item = "treesung_q_staff",
        splinters = { 75, 150 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a quarterstaff all made of a single piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_warhammer_treesung",
    name = content.text("treesung warhammer"),
    description = content.text("Use your magick to turn treesung wood into a heavy warhammer made of living wood.\n\nYou must know <color_yellow>6 Arvore spells</color> and have at least <color_yellow>400 mana</color> to create the item."),
    difficulty = 3,
    minutes = 100,
    logs = 1,
    equipment = true,
    byproduct_splinters = 40,
    outcome = {
        mana = 400,
        spells = 6,
        item = "treesung_warhammer",
        splinters = { 65, 125 },
        twigs = { 10, 20 },
        success = function()
            return services.translate("As your song fades, you behold a warhammer all made of a single piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_naginata_treesung",
    name = content.text("treesung sword-spear"),
    description = content.text("Use your magick to turn treesung wood into a long spear crowned with a blade made of living wood.\n\nYou must know <color_yellow>7 Arvore spells</color> and have at least <color_yellow>500 mana</color> to create the item."),
    difficulty = 4,
    minutes = 80,
    logs = 1,
    equipment = true,
    byproduct_splinters = 65,
    outcome = {
        mana = 500,
        spells = 7,
        item = "treesung_naginata",
        splinters = { 45, 90 },
        twigs = { 8, 18 },
        success = function()
            return services.translate("As your song fades, you behold a long staff with a sword blade at the end all made of a single piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}

register {
    id = "create_baselard_treesung",
    name = content.text("treesung baselard"),
    description = content.text("Use your magick to turn treesung wood into a large knife made of living wood.\n\nYou must know <color_yellow>4 Arvore spells</color> and have at least <color_yellow>200 mana</color> to create the item."),
    difficulty = 1,
    minutes = 45,
    logs = 1,
    equipment = true,
    byproduct_splinters = 200,
    outcome = {
        mana = 200,
        spells = 4,
        item = "treesung_baselard",
        splinters = { 100, 200 },
        twigs = { 15, 25 },
        success = function()
            return services.translate("As your song fades, you behold a large knife all made of a single piece of wood, as though it had grown that way in the depths of the forest.")
        end,
    },
}
