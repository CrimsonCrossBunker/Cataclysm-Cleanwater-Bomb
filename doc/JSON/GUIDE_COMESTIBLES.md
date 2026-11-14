<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.comestibles-placement`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/how-to/json/comestibles/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/how-to/json/comestibles/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
# Guide to add Comestibles

There are a large number of files in `json/items/comestibles`, and this guide will help you decide where to put your new comestible!

## List of special comestibles:
`med.json` -- comestibles with an addiction effect, such as drugstore medicines, tobacco products and caffeine items, plus bandages and antiseptic type items.

`mre.json` -- items and comestibles related to MREs

`mutagen.json` -- comestible that has any mutagen effect

`carnivore.json` -- item that would normally be butchered from an animal or monster, and their cooked versions. examples: chunks of meat, tainted bones, boiled stomach

`protein.json` -- comestibles based on protein powder

`spice.json` -- comestibles that normally do not have nutrients, but are used to flavor a dish. examples: salt, thyme, black pepper

`frozen.json` -- comestibles best eaten frozen

`brewing.json` -- items used in the brewing process

## List of normal comestibles, in order of priority:
When you have a comestible you want to add to the files, just go down this list, and the first filename you see in the list that matches the criteria is your choice!

### Liquid

`alcohol.json` -- "Drink" comestible with alcohol addiction

`soup.json` -- "Drink" comestible which is a soup. This is more of a "food" than a drink - you primarily want the calories from this

`drink.json` -- "Drink" comestible. This is your drink of choice when you're thirsty! examples: tea, juice, water

`drink_other.json` -- "Drink" comestible that does not fit any other criteria. example: vinegar, mustard

### Solid

`junkfood.json` -- comestible with the "junk" material. examples: cake, sugary cereal, nachos

`sandwich.json` -- a "sandwich" is generally two slices of "bread" with something in between. examples: BLT, PB&J sandwich, fish sandwich

`offal_dishes.json` -- comestible made of various offals. the offal types are: liver, brain, kidney, sweetbread, stomach. This must be the primary part of the dish.

`seed.json` -- seeds

`meat_dishes_human.json` -- comestible made of human flesh. examples: hobo helper, tio taco

`meat_dishes.json` -- comestible made with meat.

`raw_veggy.json` -- comestible that is a vegetable in its raw form.

`raw_fruit.json` -- comestible that is a fruit in its raw form.

`veggy_dishes.json` -- comestible made of vegetables.

`bread.json` -- comestible that is either a bread starter, or a cooked bread.

`wheat.json` -- either raw wheat, or made of wheat

`egg.json` -- either an egg, or made of egg

`dairy.json` -- made of milk

`mushroom.json` -- a mushroom or made of mushrooms

`nuts.json` -- a nut or made of nuts

`other.json` -- if you made it here, your comestible doesn't fit any other category!