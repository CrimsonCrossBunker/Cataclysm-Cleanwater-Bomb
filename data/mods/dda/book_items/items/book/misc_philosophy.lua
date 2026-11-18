local content = require("ccb").content

do
    local book = content.Item {
        id = "book_nonf_hard_phil_mdlogic",
        name = content.plural_text("Modal Logic as Metaphysics", "copies of Modal Logic"),
        description = content.text("A treatise on applying logical tools to questions about that nature of reality, this book contains detailed discussion of metaphysical issues."),
        mass_milligrams = 834000,
        volume_ml = 1249,
        longest_side_mm = 240,
        price_cents = 4895,
        copy_from = "book_nonf_hard_phil_tpl",
    }
    content.add(book)
end

do
    local book = content.Item {
        id = "book_nonf_soft_phil_benoth",
        name = content.plural_text("Being and Nothingness", "copies of Being and Nothingness"),
        description = content.text("This paperback is a copy of Jean-Paul Sartre's \"Being and Nothingness\".  A key work in the existentialist tradition."),
        mass_milligrams = 794000,
        volume_ml = 1000,
        longest_side_mm = 210,
        price_cents = 3400,
        price_postapoc_cents = 50,
        copy_from = "book_nonf_soft_phil_tpl",
    }
    content.add(book)
end
