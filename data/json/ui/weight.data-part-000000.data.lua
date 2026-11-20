local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "weight_desc_label",
    label = ccb.content.text("Weight"),
    style = "text",
    clauses = {
        {
            id = "skeletal",
            text = ccb.content.text("Skeletal"),
            color = "red",
            -- between 1 and 2 points of BMI from bodyfat (4-8% of normal healthy weight is fat)
            when = reading.compare("bmi_permil", "<=", 1000),
        },
        {
            id = "emaciated",
            text = ccb.content.text("Emaciated"),
            color = "light_red",
            -- between 0 and 1 points of BMI from bodyfat (0-4% of normal healthy weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "underweight",
            text = ccb.content.text("Underweight"),
            color = "yellow",
            -- between 2 and 3 points of BMI from bodyfat (8-12% of normal healthy weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "normal",
            text = ccb.content.text("Normal"),
            color = "light_gray",
            -- 3-5 points of BMI from fat (12-20% of body weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "overweight",
            text = ccb.content.text("Overweight"),
            color = "c_light_gray",
            -- 5-10 points of BMI from fat (20-33% of body weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "obese",
            text = ccb.content.text("Obese"),
            color = "light_red",
            -- 10-15 points of BMI from fat (33-43% of body weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 10000), reading.compare("bmi_permil", "<=", 15000) },
        },
        {
            id = "very_obese",
            text = ccb.content.text("Very Obese"),
            color = "red",
            -- 15-20 points of BMI from fat (43-50% of normal healthy body weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 15000), reading.compare("bmi_permil", "<=", 20000) },
        },
        {
            id = "morbidly_obese",
            text = ccb.content.text("Morbidly Obese"),
            color = "red",
            -- 20+ points of BMI from fat (more than half your bodyweight is fat)
            when = reading.compare("bmi_permil", ">", 20000),
        },
    },
}
