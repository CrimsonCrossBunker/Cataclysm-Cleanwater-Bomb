local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_NO_MIND_PROBLEMS",
    copy_from = "IERDE_NO_MIND_PROBLEMS",
    description = ccb.content.text("The Ierde's mind has the resilience of iron, and they cannot be affected by delusions, hallucinations, or other mental problems.  In addition, they are immune to telepathic attack."),
    add = { flags = { "TEEPSHIELD" } },
}
