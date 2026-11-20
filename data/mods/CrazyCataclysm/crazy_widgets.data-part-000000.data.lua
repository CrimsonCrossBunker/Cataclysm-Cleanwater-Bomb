local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    -- Replaces the vanilla weight_desc widget to change the text descriptions
    id = "weight_desc_label",
    label = ccb.content.text("Weight"),
    style = "text",
    clauses = {
        {
            id = "skeletal",
            text = ccb.content.text("Spooky Scary Skeleton"),
            color = "red",
            when = reading.compare("bmi_permil", "<=", 1000),
        },
        {
            id = "emaciated",
            text = ccb.content.text("Emaciated"),
            color = "light_red",
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "underweight",
            text = ccb.content.text("Bean Pole"),
            color = "yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "normal",
            text = ccb.content.text("Normal"),
            color = "light_gray",
            -- Actually 18.5 - 25
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "overweight",
            text = ccb.content.text("Big"),
            color = "yellow",
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "obese",
            text = ccb.content.text("Healthy"),
            color = "light_red",
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "very_obese",
            text = ccb.content.text("Husky"),
            color = "red",
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        {
            id = "morbidly_obese",
            text = ccb.content.text("Fluffy"),
            color = "red",
            when = predicate.all { reading.compare("bmi_permil", ">", 20000), reading.compare("bmi_permil", "<=", 25000) },
        },
        {
            id = "morbidly_obese_plus_5",
            text = ccb.content.text("DAYUM"),
            color = "red",
            when = predicate.all { reading.compare("bmi_permil", ">", 25000), reading.compare("bmi_permil", "<=", 30000) },
        },
        {
            id = "morbidly_obese_plus_10",
            text = ccb.content.text("AW HELL NAH"),
            color = "red",
            when = reading.compare("bmi_permil", ">", 30000),
        },
    },
}
