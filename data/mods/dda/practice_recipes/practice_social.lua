local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "prac_speech_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SOCIAL",
    name = content.text("social (beginner)"),
    description = content.text("Practice speaking in front of a mirror or in front of a device with a front-facing camera to improve your poise and eloquence and project confidence."),
    skill = "speech",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_any({
            { id = "mirror", count = 1 },
            { id = "laptop", charges = 10 },
            { id = "smart_phone", charges = 5 }
        })
    :learn_automatically("speech", 2)
    :book("manual_business", 1)
    :book("manual_speech", 1)
)

content.add(content.Recipe {
    id = "prac_speech_int",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SOCIAL",
    name = content.text("social (intermediate)"),
    description = content.text("Practice advanced persuasion and negotiation techniques while acting out both sides of a dialogue in front of a mirror or in front of a device with a front-facing camera to improve your poise and eloquence and project confidence."),
    skill = "speech",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 5, skill_limit = 6 },
    autolearn = true,
}
    :tool_any({
            { id = "mirror", count = 1 },
            { id = "laptop", charges = 10 },
            { id = "smart_phone", charges = 5 }
        })
    :learn_automatically("speech", 5)
    :book("textbook_speech", 4)
)

content.add(content.Recipe {
    id = "prac_unmute_bird",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SOCIAL",
    name = content.text("relearn ape chirps"),
    description = content.text("Debase your beautiful new voice with trying to imitate human speech.  Still more enjoyable than trying to make them sing, in any case."),
    skill = "speech",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = false,
    flags = { "BLIND_EASY" },
}
    :on_complete("finish_prac_unmute_bird")
)

content.add(content.Recipe {
    id = "prac_unmute_ceph",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SOCIAL",
    name = content.text("relearn human speech"),
    description = content.text("Your mantle struggles, and you need to contort your throat in ways that strain even your new, flexible form.  Still, having a shoal is preferable to going it alone."),
    skill = "speech",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = false,
    flags = { "BLIND_EASY" },
}
    :on_complete("finish_prac_unmute_ceph")
)

content.add(content.Recipe {
    id = "prac_unmute_gastropod",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SOCIAL",
    name = content.text("relearn human speech"),
    description = content.text("You don't have any teeth to stop airflow, and with your new tongue even closing your mouth feels unnaturally cramped.  However, rubbing different areas of your radula makes for an interesting cacophony - that might be a solution, if only you get the pitch just right."),
    skill = "speech",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = false,
    flags = { "BLIND_EASY" },
}
    :on_complete("finish_prac_unmute_gastropod")
)

content.add(content.Recipe {
    id = "prac_unmute_insect",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SOCIAL",
    name = content.text("relearn human speech"),
    description = content.text("Maybe you could rub your chitin together?  No, the apes need their vowels."),
    skill = "speech",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = false,
    flags = { "BLIND_EASY" },
}
    :on_complete("finish_prac_unmute_insect")
)

content.add(content.Recipe {
    id = "prac_unmute_slime",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SOCIAL",
    name = content.text("relearn human speech"),
    description = content.text("Couldn't you use some pheromones?  A packet of injected slime rewiring their brain?  Anything less demeaning than trying to ape the apes."),
    skill = "speech",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 0, skill_limit = 1 },
    autolearn = false,
    flags = { "BLIND_EASY" },
}
    :on_complete("finish_prac_unmute_slime")
)
