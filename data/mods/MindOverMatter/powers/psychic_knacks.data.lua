local ccb = require("ccb")

for _, power in ipairs(require("knack_powers")) do
    ccb.content.define_spell {
        id = power .. "_knack",
        copy_from = power,
        spell_class = "PSYCHIC_KNACK",
        difficulty = { handler = power .. "_knack_difficulty", fallback = 1 },
    }
end
