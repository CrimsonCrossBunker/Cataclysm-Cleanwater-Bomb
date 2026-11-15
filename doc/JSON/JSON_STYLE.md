<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `contributing.json-style`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/contributing/json-style/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/contributing/json-style/
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

- [JSON Style Guide](#json-style-guide)
  - [JSON Example](#json-example)
  - [Formatting tool](#formatting-tool)
    - [Visual Studio Code](#visual-studio-code)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# JSON Style Guide

Like in [CODE_STYLE.md](/doc/c++/CODE_STYLE.md), the JSON styling policy is to update JSON as it is added or edited, and in relatively small chunks otherwise in order to prevent undue disruption to development.

We haven't been able to find a decent JSON styling tool, so we wrote our own.  It lives in tools/format/format.cpp and it leverages src/json.cpp to parse and emit JSON.
`json_formatter.cgi` can be found in any released build and is already compiled, see [Formatting tool](#Formatting tool).

## JSON Example

This example outlines most of the styling features:

```jsonc
[
  {
    "type": "foo",
    "id": "example",
    "short_array": [ 1, 2, 3, 4, 5 ],
    "short_object": {
      "item_a": "a",
      "item_b": "b"
    },
    "long_array": [
      "a really long string to illustrate line wrapping, ",
      "which occurs if the line is longer than 120 characters"
    ],
    "nested_array": [
      [
        [ "item1", "value1" ],
        [ "item2", "value2" ],
        [ "item3", "value3" ],
        [ "item4", "value4" ],
        [ "item5", "value5" ],
        [ "item6", "value6" ]
      ]
    ]
  }
]
```
Indention is two spaces.
All JSON delimiters except comma and colon are surrounded by whitespace (either a space or a newline).
Comma and colon are followed by whitespace.
Object entries are always newline-separated.
Array entries are newline-separated if the resulting array would exceed 120 characters otherwise (including indention).
Line breaks occur after open brackets, close brackets, or entries.

## Formatting tool

The formatting tool can be found alongside the releases as `json_formatter.exe` or `json_formatter.cgi`, built via `make style-json`, or accessed at <http://dev.narc.ro/cataclysm/format.html>.  It is recommended to add the formatting tool's location to your `PATH` or (if not already present) put it in your Cataclysm-DDA root directory.

Using `make style-json` will format all files included in the JSON validation test, alternatively:
```sh
# Using git to filter JSON files with uncommitted changes (provided there are no spaces in the file or directory names).
git diff --name-only '*.json' | xargs -P 0 -L 1 json_formatter

# Using git to filter modified JSON files in the current branch.
git diff master --name-only '*.json' | xargs -P 0 -L 1 json_formatter

# Per-folder formatting.
find path/to/desired/folder -name "*.json" -print0 | xargs -P 0 -0 -L 1 json_formatter
```
---
If you're using the Visual Studio solution, you can configure Visual Studio with
commands to format all of the JSON in the project.

1. Build the JsonFormatter project by either building the entire solution or
   just that project. This will create a `tools/format/json_formatter.exe`
   binary.
2. To automatically lint json you need to define an MSBuild variable ( this is similar to setting up ccache in Visual Studio compiling doc ).
If done correctly then trying to build or run the solution will trigger linter and the `Output` and `Error List` windows will show the linted files if any.
One of the easier methods to do so is creating a `Directory.Build.props` file in the root of cataclysm project repository with the following contents:
```xml
<Project>
  <PropertyGroup>
    <CDDA_POST_BUILD_JSON_LINT>true</CDDA_POST_BUILD_JSON_LINT>
  </PropertyGroup>
</Project>
```
3. To add an entry to manually run the json linter tool; Add a new external tool entry ( `Tools` > `External Tools..` > `Add` ) and
   configure it as follows:
   * Title: `Lint All JSON`
   * Command: `C:\windows\system32\windowspowershell\v1.0\powershell.exe`
   * Arguments: `-file $(SolutionDir)\style-json.ps1`
   * Initial Directory: `$(SolutionDir)`
   * Use Output window: *checked*

At this point, you can use the menu ( `Tools` > `Lint All JSON` ) to invoke the
command and can look in the Output Window for the output of running it.
Additionally, you can configure a keybinding for this command by navigating to
`Tools` > `Options` > `Environment` > `Keyboard`, searching for commands
containing `Tools.ExternalCommand` and pick the one that corresponds to the
position of your command in the list (e.g. `Tools.ExternalCommand1` if it's the
top item in the list) and then assign shortcut keys to it.

### Visual Studio Code
If you install the recommended extensions you should have access to the cdda-toys.cdda-json-formatter which will auto format your json.
