local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_CONVERSATION",
    replies = {
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_RECENT_MUTATION_1_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_RECENT_MUTATION_1"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_1_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_UPLIFTED_ANIMAL_1"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_2_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_UPLIFTED_ANIMAL_2"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_3_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_UPLIFTED_ANIMAL_3"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_4_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_UPLIFTED_ANIMAL_4"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_UPLIFTED_ANIMAL_5_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_UPLIFTED_ANIMAL_5"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_RADIATION_1_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_RADIATION_1"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_RADIATION_2_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_RADIATION_2"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_SELFTEST_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_SELFTEST"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_VATGROWN_1_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_VATGROWN_1"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_CRIMINAL_EXPERIMENT_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_CRIMINAL_EXPERIMENT"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGRS_AFTERLIFE_1_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_RADIATION_1"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGRS_MIGO_1_STORY1",
            when = predicates.has_trait("interlocutor", "BGRS_MIGO_1"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGRS_MIGO_2_STORY1",
            when = predicates.has_trait("interlocutor", "BGRS_MIGO_2"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGRS_MIGO_3_STORY1",
            when = predicates.has_trait("interlocutor", "BGRS_MIGO_3"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGRS_SCHIZO_1_STORY1",
            when = predicates.has_trait("interlocutor", "BGRS_SCHIZO_1"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGRS_SCHIZO_2_STORY1",
            when = predicates.has_trait("interlocutor", "BGRS_SCHIZO_2"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGRS_Dreamer_STORY1",
            when = predicates.has_trait("interlocutor", "BGRS_Dreamer"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGRS_Bonesinger_STORY1",
            when = predicates.has_trait("interlocutor", "BGRS_Bonesinger"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_GANGER_1_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_GANGER_1"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_GANGER_2_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_GANGER_2"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_GANGER_3_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_GANGER_3"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_CYBERNINJA_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_CYBERNINJA"),
            switch = true,
        },
        {
            text = ccb.content.text_without_extraction("<BGSS_intro_question>"),
            next_topic = "BGSS_Sadie_STORY1",
            when = predicates.has_trait("interlocutor", "BGSS_Sadie"),
            switch = true,
        },
    },
}
