<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
*Contents*

- [Contribute](#contribute)
  - [Licensing and Authorship](#licensing-and-authorship)
  - [Using a good text editor](#using-a-good-text-editor)
  - [All PRs must have a "Summary" section](#all-prs-must-have-a-summary-section)
  - [Contributing via GitHub](#contributing-via-github)
  - [Code Style](#code-style)
  - [Translations](#translations)
  - [Doxygen Comments](#doxygen-comments)
    - [Guidelines for adding documentation](#guidelines-for-adding-documentation)
    - [Building the documentation for viewing it locally](#building-the-documentation-for-viewing-it-locally)
  - [Example Workflow](#example-workflow)
      - [Setup your environment](#setup-your-environment)
      - [Update your `master` branch](#update-your-master-branch)
      - [Make your changes](#make-your-changes)
  - [Drafts](#drafts)
    - [Comment requests](#comment-requests)
    - [Keep your PR description relevant](#keep-your-pr-description-relevant)
    - [Closing issues using keywords](#closing-issues-using-keywords)
  - [Tooling support](#tooling-support)
  - [Advanced Techniques](#advanced-techniques)
      - [Using remote tracking branches](#using-remote-tracking-branches)
  - [Unit tests](#unit-tests)
  - [In-game testing, test environment and the debug menu](#in-game-testing-test-environment-and-the-debug-menu)
  - [Frequently Asked Questions](#frequently-asked-questions)
      - [Why does `git pull --ff-only` result in an error?](#why-does-git-pull---ff-only-result-in-an-error)
      - [Oh no! I've made my changes to `master` branch and have pushed it to my repo! What should I do now?](#oh-no-ive-made-my-changes-to-master-branch-and-have-pushed-it-to-my-repo-what-should-i-do-now)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# 贡献 (Contribute)

**提交新议题？** 请先阅读 [ISSUES.md](./ISSUES.md)。也可以通过[社区玩家建议收集表](https://docs.qq.com/sheet/DZVJad2t0SkVFcHB0?tab=BB08J2)提交简单的问题。

《Cataclysm: Cleanwater Bomb》根据知识共享署名-相同方式共享 3.0 许可协议发布。本游戏的代码和内容可出于任何目的自由使用、修改和再分发。详情请参阅 http://creativecommons.org/licenses/by-sa/3.0/。
这意味着您对本项目所做的任何贡献也将受同一许可协议的约束，且该许可不可撤销。

**Opening a new issue?** Please read [ISSUES.md](./ISSUES.md) first. You can also use this [Community Player Suggestions Collection Foam](https://docs.qq.com/sheet/DZVJad2t0SkVFcHB0?tab=BB08J2) to sugget simple issue.

Cataclysm: Cleanwater Bomb is released under the Creative Commons Attribution ShareAlike 3.0 license. The code and content of the game is free to use, modify, and redistribute for any purpose whatsoever. See http://creativecommons.org/licenses/by-sa/3.0/ for details.
This means any contribution you make to the project will also be covered by the same license, and this license is irrevocable.

## 许可与作者信息 (Licensing and Authorship)

贡献内容可由提交者自行创建，也可在大型语言模型（如ChatGPT）的协助下生成，但前提是提交者必须对所有生成的内容进行彻底的人工审查和验证。提交者应对该贡献承担全部责任。

从其他分支移植更改时，您必须通过合理安排提交记录来保留原始作者信息，确保“作者”字段准确反映原始作者，且与源分支中的显示完全一致。此外，您必须确保移植的更改不会引入安全漏洞，且不违反本项目的核心理念。如果移植的更改包含由大型语言模型生成的内容，则同样适用上述人工审核要求。

Contributions may be created by the submitter or developed with the assistance of LLMs (such as ChatGPT), provided that the submitter performs thorough human review and verification of all generated content. The submitter assumes full responsibility for the contribution.

When porting changes from another fork, you must preserve the original authorship by arranging your commits so that the Author field reflects the original author, exactly as they appear in the source fork. In addition, you must ensure that the ported changes do not introduce vulnerabilities and do not violate the core philosophy of this project. If the ported changes contain LLM-generated content, the same human review requirements apply.

## 使用一个好编辑器 (Using a good text editor)

《Cataclysm: Cleanwater Bomb》的大部分游戏数据都定义在 JSON 文件中。

这些文件的设计初衷是便于您编辑，但其中存在一些陷阱。使用 Windows 记事本可能会带来麻烦，因为它会在文件开头插入一个名为 [BOM](https://baike.baidu.com/item/BOM/2790364) 的特殊字符，而 CCBVS 并不需要这个字符。

如果您打算编辑 JSON 文件，建议使用功能更全面的编辑器，例如 [VSCode](https://code.visualstudio.com/) 或 [Zed](https://zed.dev/)。

Most of the Cataclysm: Dark Days Ahead game data is defined in JSON files.

These files are intended to be easy for you to edit, but there are some pitfalls.  Using Windows Notepad can get you into trouble, because it likes to insert a special character called a [BOM](https://en.wikipedia.org/wiki/Byte_order_mark) at the start of the file, which CCB does not want.

If you're going to be editing JSON files consider getting a more fully-featured editor such as [VSCode](https://code.visualstudio.com/) or [Zed](https://zed.dev/).

## 拉取请求的“概述”段落("Summary" section of PR)

“概述”是对您所做更改的一行描述，该描述将被提取并添加到[项目变更日志](./data/changelog.txt)中。格式如下：

Summary is a one-line description of your change that will be extracted and added to [the project changelog](./data/changelog.txt). The format is:

```markdown
#### 概述 (Summary)
Category "描述"
```

可选的分类包括 - The categories to choose from are: Features, Content, Interface, Mods, Balance, Bugfixes, Performance, Infrastructure, Build, I18N.

```markdown
#### 概述 (Summary)
Content "新增突变类别‘Mouse’"
```

若你认为那是一个小更改，无需在变更日志中出现，可删除“概述”段落。

有关各分类的说明，请参阅[CHANGELOG_GUIDELINES](./doc/CHANGELOG_GUIDELINES.md)。

If you want it treated as a minor tweak that doesn't appear in the changelog, you can discard Summary section.

See [the Changelog Guidelines](./doc/CHANGELOG_GUIDELINES.md) for explanations of the categories.

## Contributing via GitHub

***TODO: change needed here for a example workflow***

Contributing to Cataclysm: Dark Days Ahead is easy — simply [fork](https://github.com/CleverRaven/Cataclysm-DDA/fork) the repository here on GitHub, make your changes, and then send us a pull request.

There are a couple of guidelines we suggest sticking to (see [#Example Workflow](#example-workflow)):

* Keep your `master` branch clean. This means you can easily pull changes made to this repository into yours.
* Create a new branch for each new feature or set of related bug fixes.
* Never merge from your local branches into your `master` branch. Only update that by pulling from `upstream/master`. GitHub has a button to update the master branch of your fork, so you do not need to know how to use git for this.

## 代码风格 (Code Style)

整个代码库的代码风格由 `astyle` 强制执行。
详情请参阅 [CODE_STYLE](./doc/c++/CODE_STYLE.md)。
您可以不遵循此风格，但维护者可能会对其进行修正。

Code style is enforced across the codebase by `astyle`.
See [CODE_STYLE](./doc/c++/CODE_STYLE.md) for details.
You are not required to follow this style, but the maintainers may correct it.

## 翻译 (Translations)

***TODO: change needed here, our translation project is't ready yet***

The translation of Cataclysm: DDA is done using Transifex.
Look at the [translation project](https://explore.transifex.com/cataclysm-dda-translators/cataclysm-dda/) for an up-to-date list of supported languages.

See [TRANSLATING.md](./doc/TRANSLATING.md) for more information:

* [For translators](./doc/TRANSLATING.md#translators)
* [For developers](./doc/TRANSLATING.md#developers)
* [For maintainers](./doc/TRANSLATING.md#maintainers)

## Doxygen 注释 (Doxygen Comments)

Extensive documentation of classes and class members will make the code more readable. New Doxygen comments for existing classes are a welcomed contribution.

Use the following template for commenting classes:

```cpp
/**
 * Brief description
 *
 * Lengthy description with many words. (optional)
 */
class foo {
```

Use the following template for commenting functions:

```cpp
/**
 * Brief description
 *
 * Lengthy description with many words. (optional)
 * @param param1 Description of param1 (optional)
 * @return Description of return (optional)
 */
int foo(int param1);
```

Use the following template for commenting member variables:

```cpp
/** Brief description **/
int foo;
```

Helpful pages:

* [Doxygen Manual - Special Commands](https://www.doxygen.nl/manual/commands.html)
* [Doxygen Manual - Standard Markdown](https://www.doxygen.nl/manual/markdown.html#markdown_std)
* [Doxygen Manual - Frequently Asked Questions](https://www.doxygen.nl/manual/faq.html)

### 文档添加指南 (Guidelines for adding documentation)

* Doxygen comments should describe behavior towards the outside, not implementation, but since many classes in Cataclysm are intertwined, it's often necessary to describe implementation.
* Describe things that aren't obvious just from the name.
* Don't describe redundantly: `/** Map **/; map* map;` is not a helpful comment.
* When documenting X, describe how X interacts with other components, not just what X itself does.

### 本地构建以浏览文档 (Building the documentation for viewing it locally)

* Install doxygen
* `doxygen doxygen_doc/doxygen_conf.txt `
* `firefox doxygen_doc/html/index.html` (replace firefox with your browser of choice)

## Example Workflow

***TODO: change needed here for a example workflow***

#### Setup your environment

*(This only needs to be done once.)*

1. [Fork](https://github.com/CleverRaven/Cataclysm-DDA/fork) this repository here on GitHub.

**Note:** Fork is different from branch, branches are covered [later](#make-your-changes).

2. Clone your fork locally.

    ```bash
    # Clones your fork of the repository into the current directory in terminal
    $ git clone https://github.com/YOUR_USERNAME/Cataclysm-DDA.git
    # Alternatively if you don't want to clone an entire big history (5GB!)
    $ git clone --depth=1 https://github.com/YOUR_USERNAME/Cataclysm-DDA.git
    ```

3. Set commit message template.

    ```bash
    # Changes the active directory in the prompt to the newly cloned "Cataclysm-DDA" directory
    $ cd Cataclysm-DDA
    # Set commit message template to the custom one in the repo
    $ git config --local commit.template .gitmessage
    ```

4. Add this repository as a remote.

    ```bash
    # Assigns the original repository to a remote called "upstream"
    $ git remote add -f upstream https://github.com/CleverRaven/Cataclysm-DDA.git
    ```

For further details about commit message guidelines please visit:
- [codeinthehole.com](https://codeinthehole.com/tips/a-useful-template-for-commit-messages/)
- [chris.beams.io](https://chris.beams.io/posts/git-commit/)
- [help.github.com](https://help.github.com/articles/closing-issues-using-keywords/)

#### Update your `master` branch

1. Make sure you have your `master` branch checked out.

```bash
$ git checkout master
```

2. Pull the changes from the `upstream/master` branch.

```bash
$ git pull --ff-only upstream master
# gets changes from "master" branch on the "upstream" remote
```

 * Note: If this gives you an error, it means you have committed directly to your local `master` branch. [Click here for instructions on how to fix this issue](#why-does-git-pull---ff-only-result-in-an-error).

3. Pull new tags from the `upstream` remote repo.

This step is not necessary to compile or contribute, but skipping it can result in outdated version numbers on your builds.

```bash
$ git fetch upstream --tags
# gets new tags from the "upstream" remote
```

4. Optionally, push the synced master state to the `origin/master` branch.

```bash
$ git push origin master
# push the synced master state to your fork
```

#### Make your changes

0. Update your `master` branch, if you haven't already.

1. For each new feature or bug fix, create a new branch.

```bash
# Creates a new branch called "new_feature" and switches to it
$ git checkout -b new_feature
```

2. Once you've committed some changes locally, you need to push them to your fork here on GitHub.

```bash
# origin was automatically set to point to your fork when you cloned it
$ git push origin new_feature
```

3. Once you're finished working on your branch, and have committed and pushed all your changes, submit a pull request from your `new_feature` branch to this repository's `master` branch.

 * Note: any new commits to the `new_feature` branch on GitHub will automatically be included in the pull request, so make sure to only commit related changes to the same branch.

## 草稿 (Drafts)

如果您提交了 PR 但仍在处理中，请将其设为 [草稿](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork)。

If you file a PR but you're still working on it, please make it a [Draft](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request-from-a-fork).

![screenshot](https://docs.github.com/assets/images/help/pull_requests/pullrequest-send.png)

这将告知审阅者你仍计划对 PR 进行补充，我们暂时无需进行审阅。当拉取请求准备好接受合并审核时，只需点击 [`准备审核`](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/changing-the-stage-of-a-pull-request) 按钮。

This will tell the reviewers that you still intend to add more to the PR and we don't need to review it yet. When it's ready to be reviewed for a merger, just click the [`Ready for review`](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/changing-the-stage-of-a-pull-request) button.

![screenshot](https://docs.github.com/assets/images/help/pull_requests/ready-for-review-button.png)

这样可以让我们只审核已准备就绪的内容，从而加快审核流程，并有助于避免合并尚未完全准备好的内容。

This can help speed up our review process by allowing us to only review the things that are ready for it, and will help prevent merging in anything that isn't completely ready.

### 征求意见 (Comment requests)

如果您还希望寻求建议，请在标题前添加 [CR] 或 [征求意见]。当您认为已获得足够信息可以继续时，请随时移除 [CR]。

提交 PR 时，无需解决或引用未解决的问题，但若您这样做了，则需详细说明您的 PR 正在解决的问题。

每次在讨论或进一步思考后更改分支时，请确保您的 PR 描述仍然与当前内容相关。

Make sure your PR description is still relevant every time you change your branch after discussion or additional thought.

If you are also looking for suggestions then add a [CR] or [Comments requested] before the title text. Feel free to remove [CR] when you feel you got enough information to proceed.

It is not required to solve or reference an open issue to file a PR, however, if you do so, you need to explain the problem your PR is solving in full detail.

### 使用关键词关闭问题 (Closing issues using keywords)

当您的 PR 应关闭某个问题时，请包含 [关闭关键词](https://help.github.com/articles/closing-issues-using-keywords/)：

When your PR should close an issue, please include [closing keywords](https://help.github.com/articles/closing-issues-using-keywords/):

* close
* closes
* closed
* fix
* fixes
* fixed
* resolve
* resolves
* resolved

## Tooling support

***TODO: change needed here for a example workflow***

Various tools are available to help you keep your contributions conforming to the appropriate style. See [DEVELOPER_TOOLING.md](./doc/c++/DEVELOPER_TOOLING.md) for more details.

## Advanced Techniques

These guidelines aren't essential, but they can make keeping things in order much easier.

#### Using remote tracking branches

Remote tracking branches allow you to easily stay in touch with this repository's `master` branch, as they automatically know which remote branch to get changes from.

```bash
$ git branch -vv
* master      xxxx [origin/master] ....
  new_feature xxxx ....
```

Here you can see we have two branches; `master` which is tracking `origin/master`, and `new_feature` which isn't tracking any branch. In practice, what this means is that git won't know where to get changes from.

```bash
$ git checkout new_feature
Switched to branch 'new_feature'
$ git pull
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
```

In order to easily pull changes from `upstream/master` into the `new_feature` branch, we can tell git which branch it should track. (You can even do this for your local master branch.)

```bash
$ git branch -u upstream/master new_feature
Branch new_feature set up to track remote branch master from upstream.
$ git pull
Updating xxxx..xxxx
....
```

You can also set the tracking information at the same time as creating the branch.

    $ git branch new_feature_2 --track upstream/master
    Branch new_feature_2 set up to track remote branch master from upstream.

 * Note: Although this makes it easier to pull from `upstream/master`, it doesn't change anything with regards to pushing. `git push` fails because you don't have permission to push to `upstream/master`.

    ```bash
    $ git push
    error: The requested URL returned error: 403 while accessing https://github.com/CleverRaven/Cataclysm-DDA.git
    fatal: HTTP request failed
    $ git push origin
    ....
    To https://github.com/YOUR_USERNAME/Cataclysm-DDA.git
    xxxx..xxxx  new_feature -> new_feature
    ```

## Unit tests

***TODO: change needed here for a example workflow***

There is a suite of tests built into the source tree at tests/  
You should run the test suite after ANY change to the game source.  
An ordinary invocation of `make` will build the test executable at `tests/cata_test`, and it can be invoked like any ordinary executable, or via `make check`.
Running `tests/cata_test` with no arguments will run the entire test suite; running it with `--help` will print a number of invocation options you can use to adjust its operation.

```bash
$ make
... compilation details ...
$ tests/cata_test
Starting the actual test at Fri Nov  9 04:37:03 2018
===============================================================================
All tests passed (1324684 assertions in 94 test cases)
Ended test at Fri Nov  9 04:37:45 2018
The test took 41.772 seconds
```

It is recommended to habitually invoke make like ``make YOUR BUILD OPTIONS && make check``.

If you're working with Visual Studio (and don't have `make`), see [Visual Studio-specific advice](./doc/c++/COMPILING-VS-VCPKG.md#running-unit-tests).

If you want/need to add a test, see [TESTING.md](./doc/c++/TESTING.md)

## In-game testing, test environment and the debug menu

***TODO: change needed here: OUTDATED, waiting for CDDA update this section***

Whether you are implementing a new feature or whether you are fixing a bug, it is always a good practice to test your changes in-game. It can be a hard task to create the exact conditions by playing a normal game to be able to test your changes, which is why there is a debug menu. There is no default key to bring up the menu so you will need to assign one first.

Bring up the keybindings menu (press `Escape` then `1`), scroll down almost to the bottom and press `+` to add a new keybinding. Press the letter that corresponds to the *Debug menu* item, then press the key you want to use to bring up the debug menu. To test your changes, create a new world with a new character. Once you are in that world, press the key you just assigned for the debug menu and you should see:

```
┌───────────────────────────────────────────────────────────────────────────┐
│ Debug Functions - Using these will cheat not only the game, but yourself. │
│ You won't grow. You won't improve.                                        │
│ Taking this shortcut will gain you nothing. Your victory will be hollow.  │
│ Nothing will be risked and nothing will be gained.                        │
├───────────────────────────────────────────────────────────────────────────┤
│ i Info…                                                                   │
│ g Game…                                                                   │
│ s Spawning…                                                               │
│ p Player…                                                                 │
│ c Monster…                                                                │
│ f Faction…                                                                │
│ v Vehicle…                                                                │
│ t Teleport…                                                               │
│ m Map…                                                                    │
│ d Dialogue…                                                               │
│ q Quick setup…                                                            │
└───────────────────────────────────────────────────────────────────────────┘
```

With the commands in this menu, you should be able to recreate the proper conditions to test your changes.  Most commands change one thing at a time.

The last command, "Quick setup", does many things at once:
* Gives you debug traits such as clairvoyance, invincibility, near infinite stamina and mana, etc
* Gives you a nearly infinite backpack
* Maxes your skills (but not your stats!)
* Reveals the map

### Debug names

If you name a character starting with one of "Debug", "Test", "Sandbox", "Staging", "QA", or "UAT", they will spawn with the debug quick setup performed automatically.

If you name a world one of those names, every character will spawn that way.

## Frequently Asked Questions

***TODO: change needed here: who asked? CCB doesn't get asked. Replace by a real asked problem.***

#### Why does `git pull --ff-only` result in an error?

If `git pull --ff-only` shows an error, it means that you've committed directly to your local `master` branch. To fix this, we create a new branch with these commits, find the point at which we diverged from `upstream/master`, and then reset `master` to that point.

```bash
$ git pull --ff-only upstream master
From https://github.com/CleverRaven/Cataclysm-DDA
 * branch            master     -> FETCH_HEAD
fatal: Not possible to fast-forward, aborting.
$ git branch new_branch master          # mark the current commit with a tmp branch
$ git merge-base master upstream/master
cc31d0... # the last commit before we committed directly to master
$ git reset --hard cc31d0....
HEAD is now at cc31d0... ...
```

Now that `master` has been cleaned up, we can easily pull from `upstream/master`, and then continue working on `new_branch`.

```bash
$ git pull --ff-only upstream master
# gets changes from the "upstream" remote for the matching branch, in this case "master"
$ git checkout new_branch
```

#### Oh no! I've made my changes to `master` branch and have pushed it to my repo! What should I do now?
Assuming `upstream` is `CleverRaven/Cataclysm-DDA` and `origin` is your fork, do the commands:
```bash
git reset upstream/master
git push --repo=origin --force
```

For more frequently asked questions, see the [developer FAQ](./doc/DEVELOPER_FAQ.md).
