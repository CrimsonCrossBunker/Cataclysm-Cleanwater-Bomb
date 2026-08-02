<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `json.help-menu`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/help-menu/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/help-menu/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
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

