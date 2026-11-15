<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.movement-modes`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/movement-modes/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/movement-modes/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
*Contents*

- [Movement Modes](#movement-modes)
  - [definition](#definition)
    - [`type`](#type)
    - [`id`](#id)
    - [`character`](#character)
    - [`panel_char`](#panel_char)
    - [`name`](#name)
    - [`panel_color`](#panel_color)
    - [`symbol_color`](#symbol_color)
    - [`exertion_level`](#exertion_level)
    - [`change_good_x`](#change_good_x)
    - [`change_bad_x`](#change_bad_x)
    - [`move_type`](#move_type)
    - [`stamina_multiplier`](#stamina_multiplier)
    - [`sound_multiplier`](#sound_multiplier)
    - [`move_speed_multiplier`](#move_speed_multiplier)
    - [`mech_power_use`](#mech_power_use)
    - [`swim_speed_mod`](#swim_speed_mod)
    - [`stop_hauling`](#stop_hauling)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Movement Modes

## definition

```jsonc
{
  "type": "movement_mode",
  "id": "fly",
  "character": "f",
  "panel_char": "F",
  "name": "Fly",
  "panel_color": "light_green",
  "symbol_color": "light_green",
  "exertion_level": "EXTRA_EXERCISE",
  "prepare_none": "You eye the ground and wonder how to miss it",
  "prepare_animal": "Your horse is growing some wings",
  "prepare_mech": "Your mechs jetpack is warming up",
  "change_good_none": "You throw yourself at the ground, and miss.",
  "change_good_animal": "You steer your steed into a... fly?",
  "change_good_mech": "You enable your mech's jetpack unit.",
  "change_bad_none": "You throw yourself at the ground, and hit.",
  "change_bad_animal": "Your steed doesn't know how to fly.",
  "change_bad_mech": "Your mech cannot fly.",
  "move_type": "running",
  "stamina_multiplier": 12.0,
  "sound_multiplier": 4.0,
  "move_speed_multiplier": 2.5,
  "mech_power_use": 5,
  "swim_speed_mod": -80,
  "stop_hauling": true
},
```

### `type`
Mandatory. Must be `"movement_mode"`.

### `id`
Mandatory. The id of the movement mode.

### `character`
Mandatory. The character shown in the move mode menu to select this mode.

### `panel_char`
Mandatory. The character shown on the panels when this mode is selected.

### `name`
Mandatory. The name of the move mode displayed whenever it is displayed.

### `panel_color`
Mandatory. The color shown on the panels when this mode is selected.

### `symbol_color`
Mandatory. The color shown in curses when your character is in this move mode.

### `exertion_level`
Mandatory. What exertion level this move mode will put you into. The options are, from least to most exercise:
```
NO_EXERCISE
LIGHT_EXERCISE
MODERATE_EXERCISE
ACTIVE_EXERCISE
EXTRA_EXERCISE
```

### `prepare_x`
Mandatory. The message given when the character switches their desired mode to this move mode, before any action is taken.
There are three values for x: `none`, `animal`, and `mech`.
- `none` is the message given when the character is not mounted.
- `animal` is the message given when riding an animal.
- `mech` is the message given when in a mech.

### `change_good_x`
Mandatory. The message given when the character switches to this move mode.
There are three values for x: `none`, `animal`, and `mech`.
- `none` is the message given when the character is not mounted.
- `animal` is the message given when riding an animal.
- `mech` is the message given when in a mech.

### `change_bad_x`
Optional. The message given when the character fails to switch to this move mode.
Right now, the only move mode that you can fail to switch are `running` type modes.
There are three values for x: `none`, `animal`, and `mech`.
- `none` is the message given when the character is not mounted.
- `animal` is the message given when riding an animal.
- `mech` is the message given when in a mech.

Defaults to `You feel bugs crawl over your skin.`

### `move_type`
Mandatory. The type of move mode - used to determine if the character is in stealth, walking normally, or fleeing.
Valid values are:
- `crouching`
- `walking`
- `running`

### `stamina_multiplier`
Optional. Multiplier on the character's stamina use when in this mode.
All non-negative floating point values are valid.

Defaults to `1.0` (no multiplier).

### `sound_multiplier`
Optional. Multiplier on the sound made when moving in this mode.
All non-negative floating point values are valid.

Defaults to `1.0` (no multiplier).

### `move_speed_multiplier`
Optional. Multiplier on the move speed when moving in this mode.
All non-negative floating point values are valid.

Defaults to `1.0` (no multiplier).

### `mech_power_use`
Optional. Mech power used each step when in this mode.
All integer values are valid.

Defaults to `2`.

### `swim_speed_mod`
Optional. How many additional moves .
All integer values are valid.

Defaults to `0`.

### `stop_hauling`
Optional. Determines whether or not hauling is cancelled switching to this mode.
Valid values are `true` and `false`.

Defaults to false.

