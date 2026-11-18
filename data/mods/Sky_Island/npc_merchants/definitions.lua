local ccb = require("ccb")
local content = ccb.content
local state = require("raid_state")

local function register_stock_tier(rank)
    ccb.runtime.handler("sky_island_merchant_rank_" .. rank, function()
        return state.number("islandrank") >= rank
    end)
end

register_stock_tier(3)
register_stock_tier(4)

content.add(content.Npc {
    id = "si_exodii_cbm_merchant",
    class = "NC_SKY_ISLAND_EXODII_CBM_MERCHANT",
    faction = "sky_island_traders",
    unique_name = ccb.content.text("┟┰┰┵═┼╧┤"),
    suffix = ccb.content.text("Merchant"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SI_EXODII_MERCHANT",
    personality = {
        aggression = -2,
        bravery = 2,
        collector = 6,
        altruism = -1,
    },
    snippets = {
        snip_bye = ccb.content.text("╄╓══╛, ┚┠┰┤!"),
    },
})

content.add(
    content.TraitGroup { id = "NC_SKY_ISLAND_EXODII_CBM_MERCHANT_TRAITS" }
        :trait("EXODII_BODY_1", 100)
        :trait("IGNORE_SOUND", 100)
        :trait("NO_BASH", 100)
        :trait("RETURN_TO_START_POS", 100)
)

content.add(content.NpcClass {
    id = "NC_SKY_ISLAND_EXODII_CBM_MERCHANT",
    name = ccb.content.text("Cyborg, type 1"),
    job_description = ccb.content.text("I'm a cyborg."),
    common = false,
    sells_belongings = false,
    traits = "NC_SKY_ISLAND_EXODII_CBM_MERCHANT_TRAITS",
    strength = {
        rng = { 0, 6 },
    },
    dexterity = {
        rng = { 0, 6 },
    },
    intelligence = {
        rng = { 0, 2 },
    },
    perception = {
        rng = { 0, 4 },
    },
    consumption_rates = "basic_shop_rates",
    whitelist = "si_exodii_cbm_merchant_whitelist",
    weapon = "si_exodii_cbm_merchant_wield",
    carry = "si_exodii_cbm_merchant_carried",
    worn = "EMPTY_GROUP",
    shop_groups = {
        {
            id = "EXODII_CBM_Store_Tier1",
            rigid = true,
        },
        {
            id = "EXODII_CBM_Store_tier1_extra",
            rigid = true,
        },
        {
            id = "EXODII_CBM_Store_Tier2",
            rigid = true,
        },
        {
            id = "EXODII_CBM_Store_Tier3",
            rigid = true,
            strict = true,
            condition_handler = "sky_island_merchant_rank_3",
        },
        {
            id = "EXODII_CBM_Store_Tier4",
            rigid = true,
            strict = true,
            condition_handler = "sky_island_merchant_rank_4",
        },
    },
    skills = {
        ALL = {
            mul = {
                {
                    one_in = 3,
                },
                {
                    sum = {
                        {
                            dice = { 2, 2 },
                        },
                        {
                            constant = 0,
                        },
                        {
                            one_in = 4,
                        },
                    },
                },
            },
        },
    },
    bonus_skills = {
        mechanics = {
            one_in = 2,
        },
        electronics = {
            rng = { 0, 2 },
        },
        firstaid = {
            rng = { 7, 10 },
        },
        gun = {
            rng = { 2, 4 },
        },
        rifle = {
            rng = { 2, 4 },
        },
        unarmed = {
            rng = { 2, 4 },
        },
        speech = 10,
    },
})

content.add(
    content.ShopkeeperWhitelist {
        id = "si_exodii_cbm_merchant_whitelist",
        message = ccb.content.text("<npcname> jerks their head up and to their right before pointing to a bowl of precious gems."),
    }
        :entry("pearl", "", "", "")
        :entry("ruby", "", "", "")
        :entry("emerald", "", "", "")
        :entry("sapphire", "", "", "")
        :entry("blue_topaz", "", "", "")
        :entry("alexandrite", "", "", "")
        :entry("amethyst", "", "", "")
        :entry("aquamarine", "", "", "")
        :entry("citrine", "", "", "")
        :entry("diamond", "", "", "")
        :entry("garnet", "", "", "")
        :entry("malachite", "", "", "")
        :entry("onyx", "", "", "")
        :entry("opal", "", "", "")
        :entry("peridot", "", "", "")
        :entry("tourmaline", "", "", "")
)

content.add(content.Faction {
    id = "sky_island_traders",
    name = ccb.content.text("The Merchants"),
    description = ccb.content.text("A group of traders following the inscrutable whims of whatever powers are behind this island."),
    likes = 30,
    respects = 30,
    known = false,
    monster_faction = "sky_island_traders",
    size = 5,
    power = 5,
    wealth = 75000000,
    food_calories = 2700000,
    food_vitamins = {
        iron = 86400,
        calcium = 86400,
        vitC = 86400,
    },
    relations = {
        no_faction = { "knows your voice" },
    },
})

content.add(content.Npc {
    id = "si_human_ammo_merchant",
    class = "NC_SKY_ISLAND_HUMAN_AMMO_MERCHANT",
    faction = "sky_island_traders",
    unique_name = ccb.content.text("Tabani"),
    suffix = ccb.content.text("Merchant"),
    gender = "male",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SI_HUMAN_AMMO_MERCHANT",
    personality = {
        aggression = -4,
        bravery = -1,
        collector = 6,
        altruism = -1,
    },
    snippets = {
        snip_bye = ccb.content.text("Far gesund, cuma!"),
    },
})

content.add(
    content.TraitGroup { id = "NC_SKY_ISLAND_HUMAN_AMMO_MERCHANT_TRAITS" }
        :trait("hair_messy", 100, "red")
        :trait("eye_color", 100, "blue")
        :trait("SKIN_DARK", 100)
        :trait("OPTIMISTIC", 100)
        :trait("IGNORE_SOUND", 100)
        :trait("NO_BASH", 100)
        :trait("RETURN_TO_START_POS", 100)
)

content.add(content.NpcClass {
    id = "NC_SKY_ISLAND_HUMAN_AMMO_MERCHANT",
    name = ccb.content.text("Human Ammo Merchant"),
    job_description = ccb.content.text("I sell people ammo in exchange for ammo."),
    common = false,
    sells_belongings = false,
    traits = "NC_SKY_ISLAND_HUMAN_AMMO_MERCHANT_TRAITS",
    strength = {
        rng = { 0, 4 },
    },
    dexterity = {
        rng = { 0, 2 },
    },
    intelligence = {
        rng = { 1, 3 },
    },
    perception = {
        rng = { 0, 2 },
    },
    consumption_rates = "basic_shop_rates",
    whitelist = "si_human_ammo_merchant_whitelist",
    weapon = "si_human_ammo_merchant_wield",
    worn = "si_human_ammo_merchant_worn",
    shop_groups = {
        {
            id = "SI_HUMAN_AMMO_Store",
            rigid = true,
        },
        {
            id = "SI_HUMAN_AMMO_Store_Tier3",
            rigid = true,
            strict = true,
            condition_handler = "sky_island_merchant_rank_3",
        },
        {
            id = "SI_HUMAN_AMMO_Store_Tier4",
            rigid = true,
            strict = true,
            condition_handler = "sky_island_merchant_rank_4",
        },
    },
    skills = {
        ALL = {
            mul = {
                {
                    one_in = 3,
                },
                {
                    sum = {
                        {
                            dice = { 2, 2 },
                        },
                        {
                            constant = 0,
                        },
                        {
                            one_in = 4,
                        },
                    },
                },
            },
        },
    },
    bonus_skills = {
        mechanics = {
            one_in = 2,
        },
        electronics = {
            rng = { 0, 2 },
        },
        gun = {
            rng = { 4, 10 },
        },
        rifle = {
            rng = { 2, 4 },
        },
        unarmed = {
            rng = { 2, 4 },
        },
        speech = 10,
    },
})

-- This is 'We deal in lead, friend'--ploom is from plwm, the Welsh word for lead, and dælath and freond are both from Old English.
content.add(
    content.ShopkeeperWhitelist {
        id = "si_human_ammo_merchant_whitelist",
        message = ccb.content.text("<npcname> consults his book and says, \"We in ploom dælath, freond.\"."),
    }
        :entry("", "ammo", "", "")
)

-- Words of Wisdom in Old English
content.add(
    content.Item {
        id = "si_human_ammo_merchant_phrasebook",
        copy_from = "book_pulp_newage_tpl",
        name = ccb.content.text("wīsdōmes uord"),
        description = ccb.content.text("Some kind of phrasebook."),
        symbol = "?",
        looks_like = "novel_pulp",
        color = "light_cyan",
        mass_grams = 250,
        volume_ml = 662,
        longest_side_mm = 180,
        price_cents = 799,
        price_postapoc_cents = 250,
    }
        :material("paper", 1)
        :melee_damage("bash", 1)
        :book {
            required_level = 0,
            maximum_level = 0,
            intelligence = 4,
            read_time_turns = 900,
            fun = 2,
            chapters = 8,
            scannable = true,
        }
)

content.add(content.Npc {
    id = "si_triffid_decor_merchant",
    class = "NC_SKY_ISLAND_TRIFFID_DECOR_MERCHANT",
    faction = "sky_island_traders",
    unique_name = ccb.content.text("Triffid"),
    suffix = ccb.content.text("Merchant"),
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_SI_TRIFFID_DECOR_MERCHANT",
    personality = {
        aggression = -10,
        bravery = 5,
        collector = 10,
        altruism = -6,
    },
    snippets = {
        snip_bye = ccb.content.text("…"),
    },
})

content.add(
    content.TraitGroup { id = "NC_SKY_ISLAND_TRIFFID_DECOR_MERCHANT_TRAITS" }
        :trait("SI_TRIFFID_DECOR_MUTATION", 100)
        :trait("IGNORE_SOUND", 100)
        :trait("NO_BASH", 100)
        :trait("RETURN_TO_START_POS", 100)
)

content.add(content.NpcClass {
    id = "NC_SKY_ISLAND_TRIFFID_DECOR_MERCHANT",
    name = ccb.content.text("Triffid Decor Merchant"),
    job_description = ccb.content.text("I sell people decor pieces in exchange for seeds."),
    common = false,
    sells_belongings = false,
    traits = "NC_SKY_ISLAND_TRIFFID_DECOR_MERCHANT_TRAITS",
    strength = {
        rng = { 0, 4 },
    },
    dexterity = {
        rng = { 0, 2 },
    },
    intelligence = {
        rng = { 1, 3 },
    },
    perception = {
        rng = { 0, 2 },
    },
    consumption_rates = "basic_shop_rates",
    whitelist = "si_triffid_decor_merchant_whitelist",
    weapon = "si_triffid_decor_merchant_wield",
    worn = "si_triffid_decor_merchant_worn",
    shop_groups = {
        {
            id = "SI_TRIFFID_DECOR_Store",
            rigid = true,
        },
        {
            id = "SI_TRIFFID_DECOR_Store_Tier3",
            rigid = true,
            strict = true,
            condition_handler = "sky_island_merchant_rank_3",
        },
        {
            id = "SI_TRIFFID_DECOR_Store_Tier4",
            rigid = true,
            strict = true,
            condition_handler = "sky_island_merchant_rank_4",
        },
    },
    skills = {
        ALL = {
            mul = {
                {
                    one_in = 3,
                },
                {
                    sum = {
                        {
                            dice = { 2, 2 },
                        },
                        {
                            constant = 0,
                        },
                        {
                            one_in = 4,
                        },
                    },
                },
            },
        },
    },
    bonus_skills = {
        mechanics = {
            one_in = 2,
        },
        electronics = {
            rng = { 0, 2 },
        },
        firstaid = {
            rng = { 1, 2 },
        },
        survival = {
            rng = { 2, 4 },
        },
        swimming = {
            rng = { 2, 4 },
        },
        unarmed = {
            rng = { 2, 4 },
        },
        speech = 10,
    },
    price_rules = {
        {
            category = "seeds",
            premium = 3,
        },
        {
            group = "SI_TRIFFID_DECOR_MERCHANT_CARPETS",
            price = 250,
            fixed_adjustment = 0,
        },
        {
            item = "teddy_bear",
            price = 500,
        },
        {
            item = "shark_plushie",
            price = 500,
        },
    },
})

content.add(
    content.ShopkeeperWhitelist {
        id = "si_triffid_decor_merchant_whitelist",
        message = ccb.content.text("<npcname>'s fronds wave back and forth vigorously."),
    }
        :entry("", "seeds", "", "")
        :entry("apple", "", "", "")
        :entry("orange", "", "", "")
        :entry("banana", "", "", "")
        :entry("blueberries", "", "", "")
        :entry("strawberries", "", "", "")
        :entry("pear", "", "", "")
        :entry("grapefruit", "", "", "")
        :entry("cherries", "", "", "")
        :entry("plums", "", "", "")
        :entry("grapes", "", "", "")
        :entry("pineapple", "", "", "")
        :entry("peach", "", "", "")
        :entry("cranberries", "", "", "")
        :entry("watermelon", "", "", "")
        :entry("melon", "", "", "")
        :entry("raspberries", "", "", "")
        :entry("blackberries", "", "", "")
        :entry("mango", "", "", "")
        :entry("pomegranate", "", "", "")
        :entry("papaya", "", "", "")
        :entry("kiwi", "", "", "")
        :entry("apricot", "", "", "")
        :entry("teddy_bear", "", "", "")
        :entry("shark_plushie", "", "", "")
)
