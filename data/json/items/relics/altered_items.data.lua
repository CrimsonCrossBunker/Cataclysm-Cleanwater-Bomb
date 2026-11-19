local ccb = require("ccb")

-- delete shirt variants
ccb.content.define_item {
    id = "altered_shirt",
    copy_from = "tshirt",
    name = ccb.content.text("Hawaiian shirt"),
    description = ccb.content.text("A slightly worn button-down shirt with a tropical pattern, straight out of the 80's.  You swear that every time you look away and look back, the pattern changes subtly."),
    variants = {},
    armor = {},
}

ccb.content.define_item {
    id = "altered_badge",
    copy_from = "badge_deputy",
    name = ccb.content.text("defaced badge"),
    description = ccb.content.text("A strange golden badge in the shape of a shield with scratched out lettering.  The faceless figures decorating the badge seem taller and thinner than ordinary humans."),
    armor = {},
}

-- delete sunglass variants
ccb.content.define_item {
    id = "altered_sunglasses",
    copy_from = "sunglasses",
    name = ccb.content.plural_text("strange sunglasses", "strange sunglasses"),
    description = ccb.content.text("A pair of thin, round sunglasses.  The tinted glass seems to reflect the same shade of baleful orange light no matter what light it reflects."),
    variants = {},
    armor = {},
}

ccb.content.define_item {
    id = "altered_necklace",
    copy_from = "silver_necklace",
    name = ccb.content.text("antique silver locket"),
    description = ccb.content.text("A heart-shaped silver locket with an black-and-white image of a smiling woman in it.  Her eyes seem to follow you whenever you look at it."),
    armor = {},
}

-- delete jacket variants
ccb.content.define_item {
    id = "altered_jacket",
    copy_from = "jacket_leather",
    name = ccb.content.text("varsity jacket"),
    description = ccb.content.text("A jacket traditionally worn by school athletes.  The logo of the school has an oddly detailed fractal pattern that draws your eye in whenever you look at it."),
    variants = {},
    armor = {},
}

-- delete apron variants
ccb.content.define_item {
    id = "altered_apron",
    copy_from = "waist_apron_long",
    name = ccb.content.text("ambiguous apron"),
    description = ccb.content.text("A long apron with a plain pattern on it.  Your eyes can't seem to decide what color it is."),
    variants = {},
    armor = {},
}
