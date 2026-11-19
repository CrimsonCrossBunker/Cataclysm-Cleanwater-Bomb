local ccb = require("ccb")

ccb.content.define_technique {
    id = "tec_none",
    name = ccb.content.text("Not a technique at all"),
    attack_vectors = { "vector_null" },
    dummy = true,
}
