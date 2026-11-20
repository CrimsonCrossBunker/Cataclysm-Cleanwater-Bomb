local ccb = require("ccb")
local predicate = ccb.content.dialogue_predicates
local reading = ccb.content.widget_conditions

ccb.content.define_widget {
    id = "zenfs_health_desc",
    style = "text",
    clauses = {
        { id = "horrible", text = ccb.content.text(" Horrible"), color = "h_red", when = reading.compare("health", "<", -100) },
        {
            id = "very_bad",
            text = ccb.content.text("Very poor"),
            color = "red",
            when = predicate.all { reading.compare("health", ">=", -100), reading.compare("health", "<", -50) },
        },
        {
            id = "bad",
            text = ccb.content.text("   Poor"),
            color = "brown",
            when = predicate.all { reading.compare("health", ">=", -50), reading.compare("health", "<", -10) },
        },
        {
            id = "ok",
            text = ccb.content.text("   Okay"),
            color = "light_gray",
            when = predicate.all { reading.compare("health", ">=", -10), reading.compare("health", "<", 10) },
        },
        {
            id = "good",
            text = ccb.content.text("   Good"),
            color = "blue",
            when = predicate.all { reading.compare("health", ">=", 10), reading.compare("health", "<", 50) },
        },
        {
            id = "very_good",
            text = ccb.content.text("Very good"),
            color = "green",
            when = predicate.all { reading.compare("health", ">=", 50), reading.compare("health", "<", 100) },
        },
        {
            id = "excellent",
            text = ccb.content.text("Excellent"),
            color = "light_green",
            when = reading.compare("health", ">=", 100),
        },
    },
    flags = { "W_LABEL_NONE" },
}

ccb.content.define_widget {
    id = "zenfs_weight_health_clause",
    label = ccb.content.text("Weight"),
    style = "text",
    clauses = {
        {
            id = "skeletal",
            text = ccb.content.text(" Skeletal"),
            color = "h_red",
            -- between 1 and 2 points of BMI from bodyfat (4-8% of normal healthy weight is fat)
            when = reading.compare("bmi_permil", "<=", 1000),
        },
        {
            id = "emaciated",
            text = ccb.content.text(" Emaciated"),
            color = "red",
            -- between 0 and 1 points of BMI from bodyfat (0-4% of normal healthy weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 1000), reading.compare("bmi_permil", "<=", 2000) },
        },
        {
            id = "underweight",
            text = ccb.content.text("   Lean"),
            color = "brown",
            -- between 2 and 3 points of BMI from bodyfat (8-12% of normal healthy weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 2000), reading.compare("bmi_permil", "<=", 3000) },
        },
        {
            id = "normal",
            text = " ",
            color = "black",
            -- 3-5 points of BMI from fat (12-20% of body weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 3000), reading.compare("bmi_permil", "<=", 5000) },
        },
        {
            id = "overweight",
            text = ccb.content.text("Overweight"),
            color = "brown",
            -- 5-10 points of BMI from fat (20-33% of body weight is fat)
            when = predicate.all { reading.compare("bmi_permil", ">", 5000), reading.compare("bmi_permil", "<=", 10000) },
        },
        {
            id = "obese",
            text = ccb.content.text("   Obese"),
            color = "yellow",
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
            text = ccb.content.text("Morb.Obese"),
            color = "h_red",
            -- 20+ points of BMI from fat (more than half your bodyweight is fat)
            when = reading.compare("bmi_permil", ">", 20000),
        },
    },
    flags = { "W_LABEL_NONE" },
}
