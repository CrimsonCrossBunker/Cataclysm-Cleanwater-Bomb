local ccb = require("ccb")
local services = ccb.services
local E = require("eoc_runtime")
local H = E.H

ccb.content.add(ccb.content.Bionic {
    id = "bio_inventor_calorie_storage",
    name = "Calorie Etherealization System",
    description = "The best place to store calories is inside your own body.  Unfortunately, caloric oversaturation causes issues that impede this perfect storage.  Thanks to magnets, orbital trajectories and your own ingenuity, your calories are now close to you and will be consumed as needed without penalties.  The process is imperfect and the orbit can't be maintained without power, but nothing preserves calories this well.",
    activation_energy_millijoules = 10000000,
    over_time_energy_millijoules = 100000,
    charge_time_turns = 10,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 8 },
    },
    flags = { "BIONIC_TOGGLED", "BIONIC_SLEEP_FRIENDLY" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_inventor_creative_fuel",
    name = "Creative-Electric Converter",
    description = "Blood is fuel?  More like everything is fuel.  This device drains your very creativity to produce power for your bionics.  It's somehow simultaneously among your best and worst ideas.",
    activation_energy_millijoules = 1000,
    occupied_bodyparts = {
        { bodypart = "head", slots = 4 },
    },
    flags = { "BIONIC_FUEL_SOURCE" },
})
ccb.content.add(ccb.content.Bionic {
    id = "bio_inventor_book_burn_boost",
    name = "Book Burner's Buddy",
    description = "Probably the most selfish thing you ever made, constantly burning countless pieces of written media for fleeting knowledge.  You might think it is worth the price, but the false knowledge this so-called buddy fills you with will leave little room to learn anything else, coercing you to burn books further and forevermore for a simulacrum of smarts.",
    activation_energy_millijoules = 15000000,
    occupied_bodyparts = {
        { bodypart = "torso", slots = 6 },
    },
    enchantments = {
        "BIONIC_ENCH_bio_inventor_book_burn_boost_0",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_1",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_2",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_3",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_4",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_5",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_6",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_7",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_8",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_9",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_10",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_11",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_12",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_13",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_14",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_15",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_16",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_17",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_18",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_19",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_20",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_21",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_22",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_23",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_24",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_25",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_26",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_27",
        "BIONIC_ENCH_bio_inventor_book_burn_boost_28",
    },
})
ccb.runtime.handler("w16b_xedra_evolved_on_bionic_activated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "bio_inventor_calorie_storage" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_inventor_calorie_storage_activated", ctx)
    elseif bid == "bio_inventor_creative_fuel" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_inventor_creative_fuel", ctx)
    elseif bid == "bio_inventor_book_burn_boost" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_inventor_book_burn_boost_activated", ctx)
    end
end)
ccb.runtime.hook("on_bionic_activated", "w16b_xedra_evolved_on_bionic_activated")
ccb.runtime.handler("w16b_xedra_evolved_on_bionic_deactivated", function(payload)
    local bid = payload and payload.bionic and payload.bionic.value
    if not bid then return end
    local ch = payload.character
    if bid == "bio_inventor_calorie_storage" then
        local ctx = E.H.ctx_new(ch, nil, {})
        E.H.run_eoc("EOC_bio_inventor_calorie_storage_deactivated", ctx)
    end
end)
ccb.runtime.hook("on_bionic_deactivated", "w16b_xedra_evolved_on_bionic_deactivated")
