local ccb = require("ccb")

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Veterinary_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Veterinary1" },
        { trait = "Exp_Veterinary1" },
        { trait = "Exp_Veterinary0Fake1" },
        { trait = "Exp_Veterinary2" },
        { trait = "Exp_Veterinary2" },
        { trait = "Exp_Veterinary1Fake2" },
        { trait = "Exp_Veterinary1Fake2" },
        { trait = "Exp_Veterinary0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Veterinary_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Veterinary1" }, { trait = "Exp_Veterinary1" }, { trait = "Exp_Veterinary2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Veterinary_Group",
    kind = "distribution",
    entries = { { group = "Exp_Veterinary_Nofake" }, { group = "Exp_Veterinary_Any" } },
}

-- This group holds all the general non-science, non-engineering traits that professionals might have.
-- NPCs getting this group still don't have a huge chance of getting any particular profession. This is just for random rolls of the dice.
-- In the future, this might include some non-expertise 'job' flags that just enrich dialogue.
ccb.content.define_trait_group {
    id = "Expertise_Professional_Random",
    kind = "collection",
    entries = {
        { group = "Exp_Agriculture_Group", weight = 10 },
        { group = "Exp_Bookkeeping_Group", weight = 10 },
        { group = "Exp_Culinary_Group", weight = 15 },
        { group = "Exp_Psychology_Group", weight = 5 },
        { group = "Exp_Sanitation_Group", weight = 7 },
        { group = "Exp_Teaching_Group", weight = 10 },
        { group = "Exp_Veterinary_Group", weight = 1 },
    },
}

-- This group holds all the science traits. The chance of just running into a trained scientist at random is quite low.
-- Note that many scientists have some instruction training or at least *think* they can teach, so the chances of running into a teacher or fake teacher are a bit higher.
-- Medicine training is a bit more common than pure sciences, but it's also something people are more likely to try to fake to make themselves seem more valuable.
ccb.content.define_trait_group {
    id = "Expertise_Science_Random",
    kind = "collection",
    entries = {
        { group = "Exp_Biochemistry_Group", weight = 10 },
        { group = "Exp_Biology_Group", weight = 10 },
        { group = "Exp_Botany_Group", weight = 5 },
        { group = "Exp_Chemistry_Group", weight = 10 },
        { group = "Exp_Entomology_Group", weight = 3 },
        { group = "Exp_Geology_Group", weight = 7 },
        { group = "Exp_Medicine_Group", weight = 10 },
        { group = "Exp_Medicine_Any", weight = 10 },
        { group = "Exp_Mycology_Group", weight = 5 },
        { group = "Exp_Physics_Group", weight = 10 },
        { group = "Exp_Teaching_Any", weight = 15 },
    },
}

-- This group holds all the engineering traits.
ccb.content.define_trait_group {
    id = "Expertise_Engineer_Random",
    kind = "collection",
    entries = {
        { group = "Exp_Eng_Electrical_Group", weight = 15 },
        { group = "Exp_Eng_Mechanical_Group", weight = 20 },
        { group = "Exp_Eng_Software_Group", weight = 15 },
        { group = "Exp_Eng_Structural_Group", weight = 15 },
    },
}

-- This trait group guarantees one randomly selected science expertise of level 1 or 2.
ccb.content.define_trait_group {
    id = "Expertise_Science_Given",
    kind = "distribution",
    entries = {
        { group = "Exp_Biochemistry_Nofake" },
        { group = "Exp_Biochemistry_Nofake" },
        { trait = "Exp_Biochemistry1fake2" },
        { group = "Exp_Botany_Nofake" },
        { group = "Exp_Botany_Nofake" },
        { trait = "Exp_Botany1fake2" },
        { group = "Exp_Chemistry_Nofake" },
        { group = "Exp_Chemistry_Nofake" },
        { trait = "Exp_Chemistry1fake2" },
        { group = "Exp_Entomology_Nofake" },
        { group = "Exp_Entomology_Nofake" },
        { trait = "Exp_Entomology1fake2" },
        { group = "Exp_Geology_Nofake" },
        { group = "Exp_Geology_Nofake" },
        { trait = "Exp_Geology1fake2" },
        { group = "Exp_Mycology_Nofake" },
        { group = "Exp_Mycology_Nofake" },
        { trait = "Exp_Mycology1fake2" },
        { group = "Exp_Physics_Nofake" },
        { group = "Exp_Physics_Nofake" },
        { trait = "Exp_Physics1fake2" },
        { group = "Exp_Biology_Nofake" },
        { group = "Exp_Biology_Nofake" },
        { trait = "Exp_Biology 1fake2" },
    },
}

-- This trait group guarantees one randomly selected medical expertise, with a chance that the person is inflating their credentials.
ccb.content.define_trait_group {
    id = "Expertise_Medical_Given",
    kind = "distribution",
    entries = {
        { trait = "Exp_Medicine1Fake2" },
        { trait = "Exp_Medicine1Fake2" },
        { trait = "Exp_Medicine1" },
        { trait = "Exp_Medicine1" },
        { trait = "Exp_Medicine2" },
    },
}
