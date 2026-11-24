local ccb = require("ccb")

ccb.content.define_mutation {
    id = "Exp_Agriculture1",
    name = ccb.content.text("Agriculture Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in agriculture, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Agriculture0Fake1",
    name = ccb.content.text("Agriculture Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in agriculture, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Agriculture2",
    name = ccb.content.text("Agriculture Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in agriculture."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Agriculture1Fake2",
    name = ccb.content.text("Agriculture Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in agriculture."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Agriculture0Fake2",
    name = ccb.content.text("Agriculture Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in agriculture."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Agriculture_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Agriculture1" },
        { trait = "Exp_Agriculture1" },
        { trait = "Exp_Agriculture0Fake1" },
        { trait = "Exp_Agriculture2" },
        { trait = "Exp_Agriculture2" },
        { trait = "Exp_Agriculture1Fake2" },
        { trait = "Exp_Agriculture1Fake2" },
        { trait = "Exp_Agriculture0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Agriculture_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Agriculture1" },
        { trait = "Exp_Agriculture1" },
        { trait = "Exp_Agriculture2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Agriculture_Group",
    kind = "distribution",
    entries = { { group = "Exp_Agriculture_Nofake" }, { group = "Exp_Agriculture_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Biochemistry1",
    name = ccb.content.text("Biochemistry Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in biochemistry, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Biochemistry0Fake1",
    name = ccb.content.text("Biochemistry Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in biochemistry, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Biochemistry2",
    name = ccb.content.text("Biochemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in biochemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Biochemistry1Fake2",
    name = ccb.content.text("Biochemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in biochemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Biochemistry0Fake2",
    name = ccb.content.text("Biochemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in biochemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Biochemistry_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Biochemistry1" },
        { trait = "Exp_Biochemistry1" },
        { trait = "Exp_Biochemistry0Fake1" },
        { trait = "Exp_Biochemistry2" },
        { trait = "Exp_Biochemistry2" },
        { trait = "Exp_Biochemistry1Fake2" },
        { trait = "Exp_Biochemistry1Fake2" },
        { trait = "Exp_Biochemistry0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Biochemistry_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Biochemistry1" },
        { trait = "Exp_Biochemistry1" },
        { trait = "Exp_Biochemistry2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Biochemistry_Group",
    kind = "distribution",
    entries = { { group = "Exp_Biochemistry_Nofake" }, { group = "Exp_Biochemistry_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Biology1",
    name = ccb.content.text("Biology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in general biology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Biology0Fake1",
    name = ccb.content.text("Biology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in general biology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Biology2",
    name = ccb.content.text("Biology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in general biology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Biology1Fake2",
    name = ccb.content.text("Biology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in general biology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Biology0Fake2",
    name = ccb.content.text("Biology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in general biology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Biology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Biology1" },
        { trait = "Exp_Biology1" },
        { trait = "Exp_Biology0Fake1" },
        { trait = "Exp_Biology2" },
        { trait = "Exp_Biology2" },
        { trait = "Exp_Biology1Fake2" },
        { trait = "Exp_Biology1Fake2" },
        { trait = "Exp_Biology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Biology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Biology1" }, { trait = "Exp_Biology1" }, { trait = "Exp_Biology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Biology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Biology_Nofake" }, { group = "Exp_Biology_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Bookkeeping1",
    name = ccb.content.text("Bookkeeping Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in bookkeeping, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Bookkeeping0Fake1",
    name = ccb.content.text("Bookkeeping Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in bookkeeping, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Bookkeeping2",
    name = ccb.content.text("Bookkeeping Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in bookkeeping."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Bookkeeping1Fake2",
    name = ccb.content.text("Bookkeeping Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in bookkeeping."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Bookkeeping0Fake2",
    name = ccb.content.text("Bookkeeping Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in bookkeeping."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Bookkeeping_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Bookkeeping1" },
        { trait = "Exp_Bookkeeping1" },
        { trait = "Exp_Bookkeeping0Fake1" },
        { trait = "Exp_Bookkeeping2" },
        { trait = "Exp_Bookkeeping2" },
        { trait = "Exp_Bookkeeping1Fake2" },
        { trait = "Exp_Bookkeeping1Fake2" },
        { trait = "Exp_Bookkeeping0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Bookkeeping_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Bookkeeping1" },
        { trait = "Exp_Bookkeeping1" },
        { trait = "Exp_Bookkeeping2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Bookkeeping_Group",
    kind = "distribution",
    entries = { { group = "Exp_Bookkeeping_Nofake" }, { group = "Exp_Bookkeeping_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Botany1",
    name = ccb.content.text("Botany Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in botany, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Botany0Fake1",
    name = ccb.content.text("Botany Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in botany, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Botany2",
    name = ccb.content.text("Botany Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in botany, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Botany1Fake2",
    name = ccb.content.text("Botany Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in botany, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Botany0Fake2",
    name = ccb.content.text("Botany Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in botany, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Botany_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Botany1" },
        { trait = "Exp_Botany1" },
        { trait = "Exp_Botany0Fake1" },
        { trait = "Exp_Botany2" },
        { trait = "Exp_Botany2" },
        { trait = "Exp_Botany1Fake2" },
        { trait = "Exp_Botany1Fake2" },
        { trait = "Exp_Botany0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Botany_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Botany1" }, { trait = "Exp_Botany1" }, { trait = "Exp_Botany2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Botany_Group",
    kind = "distribution",
    entries = { { group = "Exp_Botany_Nofake" }, { group = "Exp_Botany_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Chemistry1",
    name = ccb.content.text("Chemistry Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in inorganic chemistry, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Chemistry0Fake1",
    name = ccb.content.text("Chemistry Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in inorganic chemistry, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Chemistry2",
    name = ccb.content.text("Chemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in inorganic chemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Chemistry1Fake2",
    name = ccb.content.text("Chemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in inorganic chemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Chemistry0Fake2",
    name = ccb.content.text("Chemistry Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in inorganic chemistry, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Chemistry_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Chemistry1" },
        { trait = "Exp_Chemistry1" },
        { trait = "Exp_Chemistry0Fake1" },
        { trait = "Exp_Chemistry2" },
        { trait = "Exp_Chemistry2" },
        { trait = "Exp_Chemistry1Fake2" },
        { trait = "Exp_Chemistry1Fake2" },
        { trait = "Exp_Chemistry0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Chemistry_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Chemistry1" }, { trait = "Exp_Chemistry1" }, { trait = "Exp_Chemistry2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Chemistry_Group",
    kind = "distribution",
    entries = { { group = "Exp_Chemistry_Nofake" }, { group = "Exp_Chemistry_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Culinary1",
    name = ccb.content.text("Culinary Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in culinary arts, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Culinary0Fake1",
    name = ccb.content.text("Culinary Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in culinary arts, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Culinary2",
    name = ccb.content.text("Culinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in culinary arts, a professional chef or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Culinary1Fake2",
    name = ccb.content.text("Culinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in culinary arts, a professional chef or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Culinary0Fake2",
    name = ccb.content.text("Culinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in culinary arts, a professional chef or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Culinary_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Culinary1" },
        { trait = "Exp_Culinary1" },
        { trait = "Exp_Culinary0Fake1" },
        { trait = "Exp_Culinary2" },
        { trait = "Exp_Culinary2" },
        { trait = "Exp_Culinary1Fake2" },
        { trait = "Exp_Culinary1Fake2" },
        { trait = "Exp_Culinary0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Culinary_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Culinary1" }, { trait = "Exp_Culinary1" }, { trait = "Exp_Culinary2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Culinary_Group",
    kind = "distribution",
    entries = { { group = "Exp_Culinary_Nofake" }, { group = "Exp_Culinary_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Eng_Electrical1",
    name = ccb.content.text("Electrical Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in electrical engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Electrical0Fake1",
    name = ccb.content.text("Electrical Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in electrical engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Eng_Electrical2",
    name = ccb.content.text("Electrical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in electrical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Eng_Electrical1Fake2",
    name = ccb.content.text("Electrical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in electrical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Electrical0Fake2",
    name = ccb.content.text("Electrical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in electrical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Electrical_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Electrical1" },
        { trait = "Exp_Eng_Electrical1" },
        { trait = "Exp_Eng_Electrical0Fake1" },
        { trait = "Exp_Eng_Electrical2" },
        { trait = "Exp_Eng_Electrical2" },
        { trait = "Exp_Eng_Electrical1Fake2" },
        { trait = "Exp_Eng_Electrical1Fake2" },
        { trait = "Exp_Eng_Electrical0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Electrical_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Electrical1" },
        { trait = "Exp_Eng_Electrical1" },
        { trait = "Exp_Eng_Electrical2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Electrical_Group",
    kind = "distribution",
    entries = { { group = "Exp_Eng_Electrical_Nofake" }, { group = "Exp_Eng_Electrical_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical1",
    name = ccb.content.text("Mechanical Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in mechanical engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical0Fake1",
    name = ccb.content.text("Mechanical Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in mechanical engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical2",
    name = ccb.content.text("Mechanical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mechanical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical1Fake2",
    name = ccb.content.text("Mechanical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mechanical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Mechanical0Fake2",
    name = ccb.content.text("Mechanical Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mechanical engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Mechanical_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Mechanical1" },
        { trait = "Exp_Eng_Mechanical1" },
        { trait = "Exp_Eng_Mechanical0Fake1" },
        { trait = "Exp_Eng_Mechanical2" },
        { trait = "Exp_Eng_Mechanical2" },
        { trait = "Exp_Eng_Mechanical1Fake2" },
        { trait = "Exp_Eng_Mechanical1Fake2" },
        { trait = "Exp_Eng_Mechanical0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Mechanical_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Mechanical1" },
        { trait = "Exp_Eng_Mechanical1" },
        { trait = "Exp_Eng_Mechanical2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Mechanical_Group",
    kind = "distribution",
    entries = { { group = "Exp_Eng_Mechanical_Nofake" }, { group = "Exp_Eng_Mechanical_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Eng_Software1",
    name = ccb.content.text("Software Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in software engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Software0Fake1",
    name = ccb.content.text("Software Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in software engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Eng_Software2",
    name = ccb.content.text("Software Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in software engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Eng_Software1Fake2",
    name = ccb.content.text("Software Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in software engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Software0Fake2",
    name = ccb.content.text("Software Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in software engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Software_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Software1" },
        { trait = "Exp_Eng_Software1" },
        { trait = "Exp_Eng_Software0Fake1" },
        { trait = "Exp_Eng_Software2" },
        { trait = "Exp_Eng_Software2" },
        { trait = "Exp_Eng_Software1Fake2" },
        { trait = "Exp_Eng_Software1Fake2" },
        { trait = "Exp_Eng_Software0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Software_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Software1" },
        { trait = "Exp_Eng_Software1" },
        { trait = "Exp_Eng_Software2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Software_Group",
    kind = "distribution",
    entries = { { group = "Exp_Eng_Software_Nofake" }, { group = "Exp_Eng_Software_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Eng_Structural1",
    name = ccb.content.text("Structural Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in structural engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Structural0Fake1",
    name = ccb.content.text("Structural Engineering Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in structural engineering, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Eng_Structural2",
    name = ccb.content.text("Structural Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in structural engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Eng_Structural1Fake2",
    name = ccb.content.text("Structural Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in structural engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Eng_Structural0Fake2",
    name = ccb.content.text("Structural Engineering Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in structural engineering: an EngD, extensive field experience, or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Structural_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Structural1" },
        { trait = "Exp_Eng_Structural1" },
        { trait = "Exp_Eng_Structural0Fake1" },
        { trait = "Exp_Eng_Structural2" },
        { trait = "Exp_Eng_Structural2" },
        { trait = "Exp_Eng_Structural1Fake2" },
        { trait = "Exp_Eng_Structural1Fake2" },
        { trait = "Exp_Eng_Structural0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Structural_Nofake",
    kind = "distribution",
    entries = {
        { trait = "Exp_Eng_Structural1" },
        { trait = "Exp_Eng_Structural1" },
        { trait = "Exp_Eng_Structural2" },
    },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Eng_Structural_Group",
    kind = "distribution",
    entries = { { group = "Exp_Eng_Structural_Nofake" }, { group = "Exp_Eng_Structural_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Entomology1",
    name = ccb.content.text("Entomology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in entomology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Entomology0Fake1",
    name = ccb.content.text("Entomology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in entomology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Entomology2",
    name = ccb.content.text("Entomology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in entomology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Entomology1Fake2",
    name = ccb.content.text("Entomology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in entomology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Entomology0Fake2",
    name = ccb.content.text("Entomology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in entomology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Entomology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Entomology1" },
        { trait = "Exp_Entomology1" },
        { trait = "Exp_Entomology0Fake1" },
        { trait = "Exp_Entomology2" },
        { trait = "Exp_Entomology2" },
        { trait = "Exp_Entomology1Fake2" },
        { trait = "Exp_Entomology1Fake2" },
        { trait = "Exp_Entomology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Entomology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Entomology1" }, { trait = "Exp_Entomology1" }, { trait = "Exp_Entomology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Entomology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Entomology_Nofake" }, { group = "Exp_Entomology_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Geology1",
    name = ccb.content.text("Geology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in geology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Geology0Fake1",
    name = ccb.content.text("Geology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in geology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Geology2",
    name = ccb.content.text("Geology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in geology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Geology1Fake2",
    name = ccb.content.text("Geology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in geology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Geology0Fake2",
    name = ccb.content.text("Geology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in geology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Geology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Geology1" },
        { trait = "Exp_Geology1" },
        { trait = "Exp_Geology0Fake1" },
        { trait = "Exp_Geology2" },
        { trait = "Exp_Geology2" },
        { trait = "Exp_Geology1Fake2" },
        { trait = "Exp_Geology1Fake2" },
        { trait = "Exp_Geology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Geology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Geology1" }, { trait = "Exp_Geology1" }, { trait = "Exp_Geology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Geology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Geology_Nofake" }, { group = "Exp_Geology_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Medicine1",
    name = ccb.content.text("Medicine Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in medicine, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Medicine0Fake1",
    name = ccb.content.text("Medicine Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in medicine, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Medicine2",
    name = ccb.content.text("Medicine Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in medicine, an MD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Medicine1Fake2",
    name = ccb.content.text("Medicine Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in medicine, an MD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Medicine0Fake2",
    name = ccb.content.text("Medicine Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in medicine, an MD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Medicine_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Medicine1" },
        { trait = "Exp_Medicine1" },
        { trait = "Exp_Medicine0Fake1" },
        { trait = "Exp_Medicine2" },
        { trait = "Exp_Medicine2" },
        { trait = "Exp_Medicine1Fake2" },
        { trait = "Exp_Medicine1Fake2" },
        { trait = "Exp_Medicine0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Medicine_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Medicine1" }, { trait = "Exp_Medicine1" }, { trait = "Exp_Medicine2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Medicine_Group",
    kind = "distribution",
    entries = { { group = "Exp_Medicine_Nofake" }, { group = "Exp_Medicine_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Mycology1",
    name = ccb.content.text("Mycology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in mycology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Mycology0Fake1",
    name = ccb.content.text("Mycology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in mycology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Mycology2",
    name = ccb.content.text("Mycology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mycology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Mycology1Fake2",
    name = ccb.content.text("Mycology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mycology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Mycology0Fake2",
    name = ccb.content.text("Mycology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in mycology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Mycology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Mycology1" },
        { trait = "Exp_Mycology1" },
        { trait = "Exp_Mycology0Fake1" },
        { trait = "Exp_Mycology2" },
        { trait = "Exp_Mycology2" },
        { trait = "Exp_Mycology1Fake2" },
        { trait = "Exp_Mycology1Fake2" },
        { trait = "Exp_Mycology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Mycology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Mycology1" }, { trait = "Exp_Mycology1" }, { trait = "Exp_Mycology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Mycology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Mycology_Nofake" }, { group = "Exp_Mycology_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Physics1",
    name = ccb.content.text("Physics Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in physics, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Physics0Fake1",
    name = ccb.content.text("Physics Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in physics, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Physics2",
    name = ccb.content.text("Physics Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in physics, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Physics1Fake2",
    name = ccb.content.text("Physics Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in physics, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Physics0Fake2",
    name = ccb.content.text("Physics Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in physics, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Physics_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Physics1" },
        { trait = "Exp_Physics1" },
        { trait = "Exp_Physics0Fake1" },
        { trait = "Exp_Physics2" },
        { trait = "Exp_Physics2" },
        { trait = "Exp_Physics1Fake2" },
        { trait = "Exp_Physics1Fake2" },
        { trait = "Exp_Physics0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Physics_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Physics1" }, { trait = "Exp_Physics1" }, { trait = "Exp_Physics2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Physics_Group",
    kind = "distribution",
    entries = { { group = "Exp_Physics_Nofake" }, { group = "Exp_Physics_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Psychology1",
    name = ccb.content.text("Psychology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in psychology, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Psychology0Fake1",
    name = ccb.content.text("Psychology Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in psychology, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Psychology2",
    name = ccb.content.text("Psychology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in psychology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Psychology1Fake2",
    name = ccb.content.text("Psychology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in psychology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Psychology0Fake2",
    name = ccb.content.text("Psychology Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in psychology, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Psychology_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Psychology1" },
        { trait = "Exp_Psychology1" },
        { trait = "Exp_Psychology0Fake1" },
        { trait = "Exp_Psychology2" },
        { trait = "Exp_Psychology2" },
        { trait = "Exp_Psychology1Fake2" },
        { trait = "Exp_Psychology1Fake2" },
        { trait = "Exp_Psychology0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Psychology_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Psychology1" }, { trait = "Exp_Psychology1" }, { trait = "Exp_Psychology2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Psychology_Group",
    kind = "distribution",
    entries = { { group = "Exp_Psychology_Nofake" }, { group = "Exp_Psychology_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Sanitation1",
    name = ccb.content.text("Sanitation Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in sanitation, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Sanitation0Fake1",
    name = ccb.content.text("Sanitation Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in sanitation, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Sanitation2",
    name = ccb.content.text("Sanitation Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in sanitation."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Sanitation1Fake2",
    name = ccb.content.text("Sanitation Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in sanitation."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Sanitation0Fake2",
    name = ccb.content.text("Sanitation Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in sanitation."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Sanitation_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Sanitation1" },
        { trait = "Exp_Sanitation1" },
        { trait = "Exp_Sanitation0Fake1" },
        { trait = "Exp_Sanitation2" },
        { trait = "Exp_Sanitation2" },
        { trait = "Exp_Sanitation1Fake2" },
        { trait = "Exp_Sanitation1Fake2" },
        { trait = "Exp_Sanitation0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Sanitation_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Sanitation1" }, { trait = "Exp_Sanitation1" }, { trait = "Exp_Sanitation2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Sanitation_Group",
    kind = "distribution",
    entries = { { group = "Exp_Sanitation_Nofake" }, { group = "Exp_Sanitation_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Teaching1",
    name = ccb.content.text("Teaching Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in teaching, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Teaching0Fake1",
    name = ccb.content.text("Teaching Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in teaching, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Teaching2",
    name = ccb.content.text("Teaching Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in teaching, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Teaching1Fake2",
    name = ccb.content.text("Teaching Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in teaching, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Teaching0Fake2",
    name = ccb.content.text("Teaching Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in teaching, a PhD or equivalent."),
    valid = false,
    purifiable = false,
}

-- This trait group guarantees one of the associated traits - any trait, including fakes.
ccb.content.define_trait_group {
    id = "Exp_Teaching_Any",
    kind = "distribution",
    entries = {
        { trait = "Exp_Teaching1" },
        { trait = "Exp_Teaching1" },
        { trait = "Exp_Teaching0Fake1" },
        { trait = "Exp_Teaching2" },
        { trait = "Exp_Teaching2" },
        { trait = "Exp_Teaching1Fake2" },
        { trait = "Exp_Teaching1Fake2" },
        { trait = "Exp_Teaching0Fake2" },
    },
}

-- This trait group guarantees one of the associated traits - valid traits only, no fakes.
ccb.content.define_trait_group {
    id = "Exp_Teaching_Nofake",
    kind = "distribution",
    entries = { { trait = "Exp_Teaching1" }, { trait = "Exp_Teaching1" }, { trait = "Exp_Teaching2" } },
}

-- This trait group guarantees one of the associated traits, distributed in favor of real traits but with a chance of fakes.
ccb.content.define_trait_group {
    id = "Exp_Teaching_Group",
    kind = "distribution",
    entries = { { group = "Exp_Teaching_Nofake" }, { group = "Exp_Teaching_Any" } },
}

ccb.content.define_mutation {
    id = "Exp_Veterinary1",
    name = ccb.content.text("Veterinary Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in veterinary medicine, but not much experience."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Veterinary0Fake1",
    name = ccb.content.text("Veterinary Training"),
    points = 0,
    description = ccb.content.text("This survivor has some formal training in veterinary medicine, but not much experience."),
    valid = false,
    purifiable = false,
}

ccb.content.define_mutation {
    id = "Exp_Veterinary2",
    name = ccb.content.text("Veterinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in veterinary medicine, a DVM or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know more about this subject than they do.
ccb.content.define_mutation {
    id = "Exp_Veterinary1Fake2",
    name = ccb.content.text("Veterinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in veterinary medicine, a DVM or equivalent."),
    valid = false,
    purifiable = false,
}

-- A fake! This survivor will pretend to know about this subject but doesn't.
ccb.content.define_mutation {
    id = "Exp_Veterinary0Fake2",
    name = ccb.content.text("Veterinary Expert"),
    points = 0,
    description = ccb.content.text("This survivor has extensive experience in veterinary medicine, a DVM or equivalent."),
    valid = false,
    purifiable = false,
}

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
