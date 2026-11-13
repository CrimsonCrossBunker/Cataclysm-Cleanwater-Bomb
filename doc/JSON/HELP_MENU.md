<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.help-menu`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/help-menu/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/help-menu/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
# Help Menu

The help menu consists of scrollable categorised help pages that would ideally explain everything a new survivor needs to know, as well as any information the game can't convey clearly in an immersive way.

## Categories

Each category is made up of a json object which for mods can be placed anywhere but for vanilla should be placed in `/data/core`.

|    Field     |                                                                                                  Description                                                                                                                                                                                          |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `"type"`     | (required) must be `"help"`                                                                                                                                                                                                                                                                           |
| `"order"`    | (required) integer, where this category should appear in the list relative to others from the same source, with 0 being first. Must be unique per source (Every mod can start from 0). Each mod's categories are appended to the end of the list per their load order.                                 |
| `"name"`     | (required) string, name of the category, can use [color tags](/doc/user-guides/COLOR.md#color-tags)                                                                                                                                                                                                                  |
| `"messages"` | (required) array of strings, each string represents a new line separated paragraph containing information for this category, can use [color tags](/doc/user-guides/COLOR.md#color-tags) and [keybind tags](#keybind-tags). Separated mainly for ease of editing the json as `\n` lets you add newlines within strings |

### Keybind tags

The keybind tags here use a different syntax than elsewhere for now.
Keybind tags take the form <press_keybind> where keybind corresponds to a keybind id, most of which are found in [keybindings.json](/data/raw/keybindings.json) and are automatically colored light blue.

### Special tags

`<DRAW_NOTE_COLORS>` and `<HELP_DRAW_DIRECTIONS>` are special hardcoded tags that can be found in [help.cpp](/src/help.cpp).
`<DRAW_NOTE_COLORS>` displays a list of all the color abbreviations to be used with overmap notes.
`<HELP_DRAW_DIRECTIONS>` displays the <kbd>h</kbd><kbd>j</kbd><kbd>k</kbd><kbd>l</kbd> and numpad movement directions in a nicely rendered way. The movement directions have 3 binds by default with the above keybind tags not letting you specify which to use so unhardcoding it would result in a messier drawing.

### Example

```jsonc
  {
    "type": "help",
    "order": 0,
    "name": "First Category Name",
    "messages": [ "A useful tip.", "<color_red>Some scary warning.</color>", "A list of three keybinds.\n<press_pause> lets you pass one second.\n<press_wait> lets you wait for longer.\n<press_sleep> lets you sleep." ]
  },
```
Which will be displayed as:

![help example](https://github.com/user-attachments/assets/e6d620a0-0123-4beb-afcc-3e68f73597ca)

