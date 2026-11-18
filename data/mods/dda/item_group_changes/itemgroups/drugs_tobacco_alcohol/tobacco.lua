local content = require("ccb").content

do
    local group = content.ItemGroup { id = "pocket_cigar", kind = "collection", container = "case_cigar" }
    group:entry { item = "cigar", count = { 0, 2 } }
    group:entry {
        distribution = {
            { item = "cigar_cutter", probability = 50 },
            { item = "cigar_punch", probability = 50 },
        },
        probability = 50,
    }
    content.add(group)
end

do
    -- Legal smokable item and something to light it with
    local group = content.ItemGroup { id = "misc_smoking_legal", kind = "collection" }
    group:entry {
        distribution = {
            { group = "cigarettes_opened", wrapper = "box_cigarette", probability = 75 },
            {
                collection = {
                    { item = "tobacco", count = { 1, 20 }, wrapper = "bag_plastic", container = "null" },
                    {
                        distribution = {
                            { item = "rolling_paper", charges = { 1, 30 }, probability = 70 },
                            { item = "pipe_tobacco", probability = 30 },
                        },
                    },
                },
                probability = 20,
            },
            { item = "cigar", count = { 1, 1 }, probability = 5 },
        },
    }
    group:entry {
        distribution = {
            { item = "lighter", charges = { 0, 100 } },
            { item = "matches", charges = { 1, 20 } },
            { item = "ref_matches", charges = { 1, 32 } },
        },
    }
    content.add(group)
end
