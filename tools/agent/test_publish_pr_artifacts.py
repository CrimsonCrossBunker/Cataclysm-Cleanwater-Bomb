from __future__ import annotations

import copy
import json
import re
import shutil
import subprocess
import textwrap
import unittest
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parents[2]
WORKFLOW_PATH = ROOT / ".github/workflows/publish-pr-artifacts.yml"
TEST_MATRIX_PATH = ROOT / "ai/test-matrix.yml"

OWNER = "CrimsonCrossBunker"
REPOSITORY = "Cataclysm-Cleanwater-Bomb"
CURRENT_REPOSITORY = f"{OWNER}/{REPOSITORY}"
ACTIONS_RUNS_URL = f"https://github.com/{CURRENT_REPOSITORY}/actions/runs"
GENERAL_WORKFLOW = "General build matrix"
GENERAL_WORKFLOW_PATH = ".github/workflows/matrix.yml"
WINDOWS_WORKFLOW = "Cataclysm Windows build"
WINDOWS_WORKFLOW_PATH = ".github/workflows/msvc-full-features.yml"
HEAD_REPOSITORY = "contributor/Cataclysm-Cleanwater-Bomb"
HEAD_SHA = "a" * 40
OTHER_SHA = "b" * 40
FUTURE_EXPIRY = "2999-01-01T00:00:00Z"
PAST_EXPIRY = "2000-01-01T00:00:00Z"
BEGIN_MARKER = "<!-- BEGIN ccb-pr-artifacts -->"
END_MARKER = "<!-- END ccb-pr-artifacts -->"


def extract_publisher_script(workflow: str) -> str:
    """Extract the script from the named github-script step, like YAML does."""

    step_matches = list(
        re.finditer(
            r"(?m)^      - name: Publish fixed artifact links\s*$", workflow
        )
    )
    if len(step_matches) != 1:
        raise ValueError(
            "publish workflow must contain exactly one publisher step"
        )

    step_start = step_matches[0].start()
    script_match = re.search(
        r"(?m)^          script: \|\s*$", workflow[step_start:]
    )
    if script_match is None:
        raise ValueError("publisher step must contain an inline script block")

    block_start = step_start + script_match.end()
    script_lines: list[str] = []
    for line in workflow[block_start:].splitlines():
        if not line.strip():
            script_lines.append("")
            continue
        indentation = len(line) - len(line.lstrip(" "))
        if indentation <= 10:
            break
        if indentation < 12:
            raise ValueError("publisher script has an invalid indentation")
        script_lines.append(line[12:])

    script = "\n".join(script_lines).rstrip()
    if not script:
        raise ValueError("publisher script must not be empty")
    return f"{script}\n"


PUBLISHER_SCRIPT = extract_publisher_script(
    WORKFLOW_PATH.read_text(encoding="utf-8")
)


# The production step receives these three objects from actions/github-script.
# Keep the harness deliberately small: all publisher decisions remain in the
# extracted workflow script and are exercised through AsyncFunction.
NODE_HARNESS = textwrap.dedent(
    r"""
    (async () => {
    const fs = require('fs');
    const input = JSON.parse(fs.readFileSync(0, 'utf8'));
    const scenario = input.scenario;
    const calls = [];
    const updates = [];
    const creates = [];
    const failures = [];
    const infos = [];
    const debugs = [];

    const pullRequests = scenario.pull_requests || {};
    const artifactsByRun = scenario.artifacts_by_run || {};
    const artifactErrors = scenario.artifact_errors || {};

    const github = {
      rest: {
        pulls: {
          get: async ({ pull_number }) => {
            calls.push({ method: 'pulls.get', pull_number });
            const data = pullRequests[String(pull_number)];
            if (!data) {
              throw new Error(`missing pull request ${pull_number}`);
            }
            return { data };
          },
        },
        repos: {
          listPullRequestsAssociatedWithCommit: async args => {
            calls.push({
              method: 'repos.listPullRequestsAssociatedWithCommit',
              commit_sha: args.commit_sha,
            });
            return { data: scenario.associated_pull_requests || [] };
          },
        },
        actions: {
          listWorkflowRunsForRepo: async args => {
            calls.push({
              method: 'actions.listWorkflowRunsForRepo',
              head_sha: args.head_sha,
            });
            return { data: { workflow_runs: scenario.workflow_runs || [] } };
          },
          listWorkflowRunArtifacts: async args => {
            calls.push({
              method: 'actions.listWorkflowRunArtifacts',
              run_id: args.run_id,
            });
            if (artifactErrors[String(args.run_id)]) {
              throw new Error(artifactErrors[String(args.run_id)]);
            }
            return {
              data: { artifacts: artifactsByRun[String(args.run_id)] || [] },
            };
          },
        },
        issues: {
          listComments: async args => {
            calls.push({
              method: 'issues.listComments',
              issue_number: args.issue_number,
            });
            return { data: scenario.comments || [] };
          },
          updateComment: async args => {
            calls.push({
              method: 'issues.updateComment',
              comment_id: args.comment_id,
            });
            updates.push(args);
          },
          createComment: async args => {
            calls.push({
              method: 'issues.createComment',
              issue_number: args.issue_number,
            });
            creates.push(args);
          },
        },
      },
      paginate: async (_method, args) => {
        calls.push({ method: 'paginate', issue_number: args.issue_number });
        return scenario.comments || [];
      },
    };

    const context = {
      repo: {
        owner: scenario.owner,
        repo: scenario.repo,
      },
      payload: {
        action: scenario.action,
        workflow_run: scenario.workflow_run,
      },
    };

    const core = {
      info: message => infos.push(String(message)),
      debug: message => debugs.push(String(message)),
      setFailed: message => failures.push(String(message)),
    };

    const result = { calls, updates, creates, failures, infos, debugs };
    try {
      const AsyncFunction =
        Object.getPrototypeOf(async function () {}).constructor;
      const execute = new AsyncFunction(
        'github', 'context', 'core', input.script
      );
      await execute(github, context, core);
    } catch (error) {
      result.thrown = String(error && error.stack ? error.stack : error);
    }
    process.stdout.write(JSON.stringify(result));
    })().catch(error => {
      process.stderr.write(String(error && error.stack ? error.stack : error));
      process.exitCode = 1;
    });
    """
).strip()


def make_pull_request(
    number: int = 42,
    *,
    state: str = "open",
    merged: bool = False,
    draft: bool = False,
    base_ref: str = "master",
    base_repo: str = CURRENT_REPOSITORY,
    head_repo: str = HEAD_REPOSITORY,
    head_sha: str = HEAD_SHA,
) -> dict[str, Any]:
    return {
        "number": number,
        "state": state,
        "merged": merged,
        "draft": draft,
        "base": {"ref": base_ref, "repo": {"full_name": base_repo}},
        "head": {"repo": {"full_name": head_repo}, "sha": head_sha},
    }


def make_workflow_run(
    name: str = GENERAL_WORKFLOW,
    path: str = GENERAL_WORKFLOW_PATH,
    *,
    run_id: int = 101,
    pr_numbers: tuple[int, ...] = (42,),
    head_repo: str = HEAD_REPOSITORY,
    head_sha: str = HEAD_SHA,
    status: str = "completed",
    conclusion: str | None = "success",
    updated_at: str = "2026-08-31T00:00:00Z",
) -> dict[str, Any]:
    return {
        "id": run_id,
        "name": name,
        "path": path,
        "event": "pull_request",
        "head_sha": head_sha,
        "head_repository": {"full_name": head_repo},
        "pull_requests": [{"number": number} for number in pr_numbers],
        "status": status,
        "conclusion": conclusion,
        "updated_at": updated_at,
    }


def make_artifact(
    name: str,
    artifact_id: int,
    *,
    expired: bool = False,
    expires_at: str = FUTURE_EXPIRY,
) -> dict[str, Any]:
    return {
        "name": name,
        "id": artifact_id,
        "expired": expired,
        "expires_at": expires_at,
    }


def artifact_names(pr_number: int = 42) -> dict[str, str]:
    return {
        "linux": f"ccb-pr-linux-curses-pr-{pr_number}",
        "macos": f"ccb-pr-macos-tiles-pr-{pr_number}",
        "android": f"ccb-pr-android-arm64-v8a-pr-{pr_number}",
        "windows": f"ccb-pr-windows-tiles-x64-pr-{pr_number}",
    }


def make_scenario(
    workflow_run: dict[str, Any],
    *,
    action: str = "completed",
    pull_requests: dict[int, dict[str, Any]] | None = None,
    workflow_runs: list[dict[str, Any]] | None = None,
    associated_pull_requests: list[dict[str, Any]] | None = None,
    artifacts_by_run: dict[int, list[dict[str, Any]]] | None = None,
    artifact_errors: dict[int, str] | None = None,
    comments: list[dict[str, Any]] | None = None,
) -> dict[str, Any]:
    return {
        "owner": OWNER,
        "repo": REPOSITORY,
        "action": action,
        "workflow_run": workflow_run,
        "pull_requests": {
            str(number): pull_request
            for number, pull_request in (
                pull_requests or {42: make_pull_request()}
            ).items()
        },
        "workflow_runs": workflow_runs or [],
        "associated_pull_requests": associated_pull_requests or [],
        "artifacts_by_run": {
            str(run_id): artifacts
            for run_id, artifacts in (artifacts_by_run or {}).items()
        },
        "artifact_errors": {
            str(run_id): message
            for run_id, message in (artifact_errors or {}).items()
        },
        "comments": comments or [],
    }


def marker_comment(
    comment_id: int,
    body: str,
    *,
    login: str = "github-actions[bot]",
) -> dict[str, Any]:
    return {"id": comment_id, "user": {"login": login}, "body": body}


class PublishPrArtifactsContractTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.workflow = WORKFLOW_PATH.read_text(encoding="utf-8")
        cls.script = PUBLISHER_SCRIPT
        cls.node = shutil.which("node")
        if cls.node is None:
            raise RuntimeError(
                "Node.js is required for publisher contract tests"
            )

    def run_publisher(self, scenario: dict[str, Any]) -> dict[str, Any]:
        request = json.dumps(
            {"script": self.script, "scenario": scenario},
            separators=(",", ":"),
        )
        completed = subprocess.run(
            [self.node, "-e", NODE_HARNESS],
            cwd=ROOT,
            input=request,
            text=True,
            capture_output=True,
            check=False,
            timeout=20,
        )
        self.assertEqual(
            completed.returncode,
            0,
            msg=(
                f"Node harness failed:\n{completed.stderr}\n"
                f"{completed.stdout}"
            ),
        )
        try:
            result = json.loads(completed.stdout)
        except json.JSONDecodeError as error:
            self.fail(
                "Node harness did not return JSON: "
                f"{error}\n{completed.stdout}"
            )
        self.assertNotIn("thrown", result, result.get("thrown"))
        return result

    def body_from_single_write(self, result: dict[str, Any]) -> str:
        writes = result["updates"] + result["creates"]
        self.assertEqual(1, len(writes), result)
        return writes[0]["body"]

    def assert_no_writes(self, result: dict[str, Any]) -> None:
        self.assertEqual([], result["updates"], result)
        self.assertEqual([], result["creates"], result)

    def artifact_calls(self, result: dict[str, Any]) -> list[dict[str, Any]]:
        return [
            call
            for call in result["calls"]
            if call["method"] == "actions.listWorkflowRunArtifacts"
        ]

    def assert_artifact_run_ids(
        self,
        result: dict[str, Any],
        expected_run_ids: set[int],
    ) -> None:
        queried_run_ids = {
            call["run_id"] for call in self.artifact_calls(result)
        }
        self.assertTrue(expected_run_ids.issubset(queried_run_ids), result)
        self.assertTrue(queried_run_ids.issubset(expected_run_ids), result)

    def successful_scenario(
        self,
        *,
        comments: list[dict[str, Any]] | None = None,
        pull_requests: dict[int, dict[str, Any]] | None = None,
    ) -> dict[str, Any]:
        names = artifact_names()
        general = make_workflow_run(run_id=101)
        windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=102,
        )
        return make_scenario(
            general,
            pull_requests=pull_requests,
            workflow_runs=[general, windows],
            artifacts_by_run={
                101: [
                    make_artifact(names["linux"], 1001),
                    make_artifact(names["macos"], 1002),
                    make_artifact(names["android"], 1003),
                ],
                102: [make_artifact(names["windows"], 1004)],
            },
            comments=comments,
        )

    def test_static_workflow_identity_and_pull_request_guards(self) -> None:
        self.assertEqual(
            1,
            self.workflow.count("- name: Publish fixed artifact links"),
        )
        self.assertIn("      - General build matrix", self.workflow)
        self.assertIn("      - Cataclysm Windows build", self.workflow)
        self.assertIn("SOURCE_WORKFLOW_PATHS = Object.freeze({", self.script)
        self.assertIn(
            "'General build matrix': '.github/workflows/matrix.yml'",
            self.script,
        )
        self.assertIn(
            "'Cataclysm Windows build': "
            "'.github/workflows/msvc-full-features.yml'",
            self.script,
        )
        for fragment in (
            "workflowRun.event !== 'pull_request'",
            "pullRequest.state === 'open'",
            "action === 'completed'",
            "pullRequest.state === 'closed'",
            "pullRequest.merged === true",
            "pullRequest.draft === false",
            "pullRequest.base.ref === 'master'",
            "pullRequest.base.repo.full_name === currentRepository",
            "pullRequest.head.repo.full_name === workflowHeadRepository",
            "pullRequest.head.sha === headSha",
            "run.event === 'pull_request'",
            "run.head_sha === headSha",
            "run.head_repository.full_name === pullRequestHeadRepository",
        ):
            self.assertIn(fragment, self.script)
        self.assertRegex(
            self.script,
            r"const isSuccessfulRun = run =>\s*"
            r"run &&\s*run\.status === 'completed' &&\s*"
            r"run\.conclusion === 'success';",
        )
        self.assertLess(
            self.script.index("if (!isSuccessfulRun(run))"),
            self.script.index("listWorkflowRunArtifacts"),
        )

    def test_test_matrix_routes_publisher_contract(self) -> None:
        route_match = re.search(
            r"(?ms)^  - id: publisher-contract\n(?P<body>.*?)(?=^  - id:|\Z)",
            TEST_MATRIX_PATH.read_text(encoding="utf-8"),
        )
        self.assertIsNotNone(route_match)
        route = route_match.group("body")
        self.assertIn(
            ".github/workflows/publish-pr-artifacts.yml",
            route,
        )
        self.assertIn("tools/agent/test_publish_pr_artifacts.py", route)
        self.assertIn(
            "python3 -m unittest discover -s tools/agent "
            "-p 'test_publish_pr_artifacts.py'",
            route,
        )

    def test_four_platform_success_publishes_download_links(self) -> None:
        result = self.run_publisher(self.successful_scenario())
        self.assertEqual([], result["failures"], result)
        body = self.body_from_single_write(result)
        expected = {
            "Linux curses": (
                f"{ACTIONS_RUNS_URL}/101/artifacts/1001"
            ),
            "macOS tiles": (
                f"{ACTIONS_RUNS_URL}/101/artifacts/1002"
            ),
            "Android arm64-v8a": (
                f"{ACTIONS_RUNS_URL}/101/artifacts/1003"
            ),
            "Windows tiles x64": (
                f"{ACTIONS_RUNS_URL}/102/artifacts/1004"
            ),
        }
        for label, url in expected.items():
            self.assertIn(f"| {label} | ✅ [download]({url}) |", body)
        self.assert_artifact_run_ids(result, {101, 102})

    def test_completed_event_updates_artifacts_after_pr_merge(self) -> None:
        pending = (
            f"{BEGIN_MARKER}\n"
            f"<!-- ccb-pr-artifacts-head: {HEAD_SHA} -->\n"
            "pending\n"
            f"{END_MARKER}"
        )
        result = self.run_publisher(
            self.successful_scenario(
                pull_requests={
                    42: make_pull_request(
                        state="closed",
                        merged=True,
                    )
                },
                comments=[marker_comment(4201, pending)],
            )
        )
        self.assertEqual([], result["failures"], result)
        self.assertEqual(
            [4201],
            [item["comment_id"] for item in result["updates"]],
        )
        self.assertEqual([], result["creates"], result)
        body = result["updates"][0]["body"]
        for artifact_id in (1001, 1002, 1003, 1004):
            self.assertIn(f"/artifacts/{artifact_id}", body)
        self.assertNotIn("⏳ pending", body)

    def test_requested_event_does_not_publish_to_merged_pr(self) -> None:
        workflow_run = make_workflow_run(
            run_id=103,
            status="requested",
            conclusion=None,
        )
        result = self.run_publisher(
            make_scenario(
                workflow_run,
                action="requested",
                pull_requests={
                    42: make_pull_request(
                        state="closed",
                        merged=True,
                    )
                },
                workflow_runs=[workflow_run],
            )
        )
        self.assertEqual([], result["failures"], result)
        self.assert_no_writes(result)
        self.assertEqual([], self.artifact_calls(result))

    def test_pending_runs_are_pending_without_artifact_lookup(self) -> None:
        general = make_workflow_run(
            run_id=201,
            status="in_progress",
            conclusion=None,
        )
        windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=202,
        )
        names = artifact_names()
        result = self.run_publisher(
            make_scenario(
                general,
                workflow_runs=[general, windows],
                artifacts_by_run={
                    202: [make_artifact(names["windows"], 2004)],
                },
            )
        )
        body = self.body_from_single_write(result)
        for label in ("Linux curses", "macOS tiles", "Android arm64-v8a"):
            self.assertIn(f"| {label} | ⏳ pending |", body)
        self.assertIn("| Windows tiles x64 | ✅ [download]", body)
        self.assert_artifact_run_ids(result, {202})

    def test_failed_runs_are_failed_and_are_not_looked_up_as_artifacts(
        self,
    ) -> None:
        general = make_workflow_run(
            run_id=211,
            status="completed",
            conclusion="failure",
        )
        windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=212,
        )
        names = artifact_names()
        result = self.run_publisher(
            make_scenario(
                general,
                workflow_runs=[general, windows],
                artifacts_by_run={
                    212: [make_artifact(names["windows"], 2104)],
                },
            )
        )
        body = self.body_from_single_write(result)
        run_url = f"https://github.com/{CURRENT_REPOSITORY}/actions/runs/211"
        for label in ("Linux curses", "macOS tiles", "Android arm64-v8a"):
            self.assertIn(
                f"| {label} | ❌ [workflow failed]({run_url}) |",
                body,
            )
        self.assertIn("| Windows tiles x64 | ✅ [download]", body)
        self.assert_artifact_run_ids(result, {212})

    def test_cancelled_runs_are_failed_and_are_not_looked_up_as_artifacts(
        self,
    ) -> None:
        general = make_workflow_run(run_id=221)
        windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=222,
            status="completed",
            conclusion="cancelled",
        )
        names = artifact_names()
        result = self.run_publisher(
            make_scenario(
                general,
                workflow_runs=[general, windows],
                artifacts_by_run={
                    221: [
                        make_artifact(names["linux"], 2201),
                        make_artifact(names["macos"], 2202),
                        make_artifact(names["android"], 2203),
                    ],
                },
            )
        )
        body = self.body_from_single_write(result)
        self.assertIn(
            "| Windows tiles x64 | ❌ [workflow failed]("
            f"{ACTIONS_RUNS_URL}/222) |",
            body,
        )
        for artifact_id in (2201, 2202, 2203):
            self.assertIn(f"/artifacts/{artifact_id}", body)
        self.assert_artifact_run_ids(result, {221})

    def test_missing_and_expired_artifacts_are_not_downloads(self) -> None:
        names = artifact_names()
        general = make_workflow_run(run_id=231)
        windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=232,
        )
        result = self.run_publisher(
            make_scenario(
                general,
                workflow_runs=[general, windows],
                artifacts_by_run={
                    # macOS is flagged expired; Android is absent.
                    231: [
                        make_artifact(names["linux"], 2301),
                        make_artifact(names["macos"], 2302, expired=True),
                    ],
                    # This candidate has the right name but its expiry is past.
                    232: [
                        make_artifact(
                            names["windows"],
                            2304,
                            expires_at=PAST_EXPIRY,
                        )
                    ],
                },
            )
        )
        body = self.body_from_single_write(result)
        self.assertIn("| Linux curses | ✅ [download]", body)
        for label in ("macOS tiles", "Android arm64-v8a", "Windows tiles x64"):
            self.assertIn(f"| {label} | ➖ not produced |", body)
        self.assertNotIn("/artifacts/2304", body)

    def test_artifact_metadata_error_reports_run_without_download(
        self,
    ) -> None:
        names = artifact_names()
        general = make_workflow_run(run_id=233)
        windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=234,
        )
        result = self.run_publisher(
            make_scenario(
                general,
                workflow_runs=[general, windows],
                artifact_errors={233: "artifact metadata unavailable"},
                artifacts_by_run={
                    234: [make_artifact(names["windows"], 2344)],
                },
            )
        )
        body = self.body_from_single_write(result)
        run_url = f"https://github.com/{CURRENT_REPOSITORY}/actions/runs/233"
        for label in ("Linux curses", "macOS tiles", "Android arm64-v8a"):
            self.assertIn(
                f"| {label} | ⚠️ [metadata unavailable]({run_url}) |",
                body,
            )
        self.assertIn("| Windows tiles x64 | ✅ [download]", body)
        self.assert_artifact_run_ids(result, {233, 234})

    def test_invalid_trigger_workflow_name_path_or_event_is_ignored(
        self,
    ) -> None:
        for description, changes in (
            ("name", {"name": "Unexpected source workflow"}),
            ("path", {"path": ".github/workflows/other.yml"}),
            ("event", {"event": "push"}),
        ):
            with self.subTest(description=description):
                workflow_run = make_workflow_run()
                workflow_run.update(changes)
                result = self.run_publisher(
                    make_scenario(workflow_run, workflow_runs=[workflow_run])
                )
                self.assertEqual([], result["failures"], result)
                self.assert_no_writes(result)
                self.assertEqual([], result["calls"])

    def test_invalid_sha_is_failed_before_pull_request_lookup(self) -> None:
        workflow_run = make_workflow_run(head_sha="not-a-commit-sha")
        result = self.run_publisher(
            make_scenario(workflow_run, workflow_runs=[workflow_run])
        )
        self.assertTrue(
            any(
                "valid commit SHA" in failure
                for failure in result["failures"]
            ),
            result,
        )
        self.assert_no_writes(result)
        self.assertEqual([], result["calls"])

    def test_empty_run_pull_requests_uses_commit_association_fallback(
        self,
    ) -> None:
        context_run = make_workflow_run(run_id=301, pr_numbers=())
        target_general = make_workflow_run(run_id=301, pr_numbers=(42,))
        target_windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=302,
            pr_numbers=(42,),
        )
        names = artifact_names()
        result = self.run_publisher(
            make_scenario(
                context_run,
                pull_requests={
                    # The association response may put an invalid PR first.
                    41: make_pull_request(41, state="closed"),
                    42: make_pull_request(42),
                },
                associated_pull_requests=[{"number": 41}, {"number": 42}],
                workflow_runs=[target_general, target_windows],
                artifacts_by_run={
                    301: [
                        make_artifact(names["linux"], 3001),
                        make_artifact(names["macos"], 3002),
                        make_artifact(names["android"], 3003),
                    ],
                    302: [make_artifact(names["windows"], 3004)],
                },
            )
        )
        self.assertEqual([], result["failures"], result)
        self.assertEqual(
            1,
            sum(
                (
                    call["method"] ==
                    "repos.listPullRequestsAssociatedWithCommit"
                )
                for call in result["calls"]
            ),
        )
        self.assertEqual(
            [41, 42, 42],
            [
                call["pull_number"]
                for call in result["calls"]
                if call["method"] == "pulls.get"
            ],
        )
        self.assertEqual(42, result["creates"][0]["issue_number"])
        self.assertIn(
            f"ccb-pr-artifacts-head: {HEAD_SHA}",
            result["creates"][0]["body"],
        )

    def test_pr_and_run_repository_and_head_guards_reject_wrong_pr(
        self,
    ) -> None:
        baseline_run = make_workflow_run(run_id=241)
        baseline_pr = make_pull_request()
        cases: list[tuple[str, dict[str, Any], dict[str, Any]]] = [
            (
                "closed PR",
                {"state": "closed"},
                baseline_run,
            ),
            (
                "draft PR",
                {"draft": True},
                baseline_run,
            ),
            (
                "wrong base branch",
                {
                    "base": {
                        "ref": "develop",
                        "repo": {"full_name": CURRENT_REPOSITORY},
                    }
                },
                baseline_run,
            ),
            (
                "wrong base repository",
                {
                    "base": {
                        "ref": "master",
                        "repo": {"full_name": "other/repository"},
                    }
                },
                baseline_run,
            ),
            (
                "wrong PR head repository",
                {
                    "head": {
                        "repo": {"full_name": "other/fork"},
                        "sha": HEAD_SHA,
                    }
                },
                baseline_run,
            ),
            (
                "wrong PR head SHA",
                {
                    "head": {
                        "repo": {"full_name": HEAD_REPOSITORY},
                        "sha": OTHER_SHA,
                    }
                },
                baseline_run,
            ),
            (
                "wrong workflow head repository",
                {},
                dict(
                    baseline_run,
                    head_repository={"full_name": "other/fork"},
                ),
            ),
        ]
        for description, pr_changes, workflow_run in cases:
            with self.subTest(description=description):
                pull_request = copy.deepcopy(baseline_pr)
                pull_request.update(copy.deepcopy(pr_changes))
                result = self.run_publisher(
                    make_scenario(
                        workflow_run,
                        pull_requests={42: pull_request},
                        workflow_runs=[workflow_run],
                    )
                )
                self.assertEqual([], result["failures"], result)
                self.assert_no_writes(result)
                self.assertEqual([], self.artifact_calls(result))

    def test_wrong_source_run_path_or_repository_cannot_supply_artifacts(
        self,
    ) -> None:
        names = artifact_names()
        general = make_workflow_run(
            run_id=245,
            updated_at="2026-08-31T00:00:00Z",
        )
        wrong_path = make_workflow_run(
            run_id=246,
            path=".github/workflows/other.yml",
            updated_at="2026-08-31T03:00:00Z",
        )
        wrong_repository = make_workflow_run(
            run_id=247,
            head_repo="other/fork",
            updated_at="2026-08-31T04:00:00Z",
        )
        wrong_name = make_workflow_run(
            run_id=249,
            name="Unexpected source workflow",
            path=GENERAL_WORKFLOW_PATH,
            updated_at="2026-08-31T05:00:00Z",
        )
        wrong_sha = make_workflow_run(
            run_id=250,
            head_sha=OTHER_SHA,
            updated_at="2026-08-31T06:00:00Z",
        )
        wrong_pr = make_workflow_run(
            run_id=251,
            pr_numbers=(41,),
            updated_at="2026-08-31T07:00:00Z",
        )
        windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=248,
        )
        result = self.run_publisher(
            make_scenario(
                general,
                workflow_runs=[
                    wrong_path,
                    wrong_repository,
                    wrong_name,
                    wrong_sha,
                    wrong_pr,
                    general,
                    windows,
                ],
                artifacts_by_run={
                    245: [
                        make_artifact(names["linux"], 2451),
                        make_artifact(names["macos"], 2452),
                        make_artifact(names["android"], 2453),
                    ],
                    246: [make_artifact(names["linux"], 2461)],
                    247: [make_artifact(names["linux"], 2471)],
                    249: [make_artifact(names["linux"], 2491)],
                    250: [make_artifact(names["linux"], 2501)],
                    251: [make_artifact(names["linux"], 2511)],
                    248: [make_artifact(names["windows"], 2484)],
                },
            )
        )
        body = self.body_from_single_write(result)
        for artifact_id in (2451, 2452, 2453, 2484):
            self.assertIn(f"/artifacts/{artifact_id}", body)
        for artifact_id in (2461, 2471, 2491, 2501, 2511):
            self.assertNotIn(f"/artifacts/{artifact_id}", body)

    def test_two_pull_requests_sharing_sha_do_not_cross_publish_artifacts(
        self,
    ) -> None:
        names_41 = artifact_names(41)
        names_42 = artifact_names(42)
        context_run = make_workflow_run(run_id=252, pr_numbers=(42,))
        other_general = make_workflow_run(
            run_id=251,
            pr_numbers=(41,),
            updated_at="2026-08-31T02:00:00Z",
        )
        target_general = make_workflow_run(
            run_id=252,
            pr_numbers=(42,),
            updated_at="2026-08-31T01:00:00Z",
        )
        other_windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=253,
            pr_numbers=(41,),
            updated_at="2026-08-31T02:00:00Z",
        )
        target_windows = make_workflow_run(
            WINDOWS_WORKFLOW,
            WINDOWS_WORKFLOW_PATH,
            run_id=254,
            pr_numbers=(42,),
            updated_at="2026-08-31T01:00:00Z",
        )
        result = self.run_publisher(
            make_scenario(
                context_run,
                pull_requests={
                    41: make_pull_request(41),
                    42: make_pull_request(42),
                },
                workflow_runs=[
                    other_general,
                    target_general,
                    other_windows,
                    target_windows,
                ],
                artifacts_by_run={
                    251: [make_artifact(names_41["linux"], 2501)],
                    253: [make_artifact(names_41["windows"], 2504)],
                    252: [
                        make_artifact(names_42["linux"], 2505),
                        make_artifact(names_42["macos"], 2506),
                        make_artifact(names_42["android"], 2507),
                    ],
                    254: [make_artifact(names_42["windows"], 2508)],
                },
            )
        )
        body = self.body_from_single_write(result)
        for artifact_id in (2505, 2506, 2507, 2508):
            self.assertIn(f"/artifacts/{artifact_id}", body)
        for artifact_id in (2501, 2504):
            self.assertNotIn(f"/artifacts/{artifact_id}", body)
        self.assertEqual(42, result["creates"][0]["issue_number"])

    def test_requested_event_publishes_pending_rows_without_artifact_lookup(
        self,
    ) -> None:
        workflow_run = make_workflow_run(
            run_id=261,
            status="requested",
            conclusion=None,
        )
        result = self.run_publisher(
            make_scenario(
                workflow_run,
                action="requested",
                workflow_runs=[workflow_run],
                artifacts_by_run={
                    261: [make_artifact(artifact_names()["linux"], 2601)]
                },
            )
        )
        body = self.body_from_single_write(result)
        self.assertEqual([], result["failures"], result)
        self.assertEqual([], self.artifact_calls(result))
        self.assertEqual(4, body.count("⏳ pending"))
        self.assertIn(f"ccb-pr-artifacts-head: {HEAD_SHA}", body)

    def test_requested_event_is_idempotent_for_existing_head_marker(
        self,
    ) -> None:
        workflow_run = make_workflow_run(
            run_id=262,
            status="requested",
            conclusion=None,
        )
        existing = (
            f"{BEGIN_MARKER}\n"
            f"<!-- ccb-pr-artifacts-head: {HEAD_SHA} -->\n"
            f"{END_MARKER}"
        )
        result = self.run_publisher(
            make_scenario(
                workflow_run,
                action="requested",
                workflow_runs=[workflow_run],
                comments=[marker_comment(2602, existing)],
            )
        )
        self.assertEqual([], result["failures"], result)
        self.assert_no_writes(result)
        self.assertEqual([], self.artifact_calls(result))

    def test_only_one_existing_bot_marker_comment_is_updated(self) -> None:
        existing = (
            f"{BEGIN_MARKER}\n"
            "<!-- ccb-pr-artifacts-head: old-head -->\n"
            "old content\n"
            f"{END_MARKER}"
        )
        comments = [
            marker_comment(2701, existing),
            marker_comment(2702, "ordinary bot comment without a marker"),
            marker_comment(
                2703,
                f"{BEGIN_MARKER}\nhuman-owned\n{END_MARKER}",
                login="maintainer",
            ),
        ]
        result = self.run_publisher(
            self.successful_scenario(comments=comments)
        )
        self.assertEqual([], result["failures"], result)
        self.assertEqual(
            [2701], [update["comment_id"] for update in result["updates"]]
        )
        self.assertEqual([], result["creates"])

    def test_duplicate_bot_marker_comments_fail_without_writing(self) -> None:
        body = f"{BEGIN_MARKER}\nold\n{END_MARKER}"
        workflow_run = make_workflow_run(
            run_id=281,
            status="requested",
            conclusion=None,
        )
        result = self.run_publisher(
            make_scenario(
                workflow_run,
                action="requested",
                workflow_runs=[workflow_run],
                comments=[
                    marker_comment(2801, body),
                    marker_comment(2802, body),
                ],
            )
        )
        self.assertTrue(
            any(
                "Multiple workflow-owned PR artifact comments" in failure
                for failure in result["failures"]
            ),
            result,
        )
        self.assert_no_writes(result)

    def test_repeated_marker_tokens_fail_without_writing(self) -> None:
        workflow_run = make_workflow_run(
            run_id=291,
            status="requested",
            conclusion=None,
        )
        for description, body in (
            (
                "repeated begin",
                f"{BEGIN_MARKER}\n{BEGIN_MARKER}\n{END_MARKER}",
            ),
            (
                "repeated end",
                f"{BEGIN_MARKER}\n{END_MARKER}\n{END_MARKER}",
            ),
            (
                "missing end",
                f"{BEGIN_MARKER}\nold content",
            ),
        ):
            with self.subTest(description=description):
                result = self.run_publisher(
                    make_scenario(
                        workflow_run,
                        action="requested",
                        workflow_runs=[workflow_run],
                        comments=[marker_comment(2901, body)],
                    )
                )
                self.assertTrue(
                    any(
                        "malformed markers" in failure
                        for failure in result["failures"]
                    ),
                    result,
                )
                self.assert_no_writes(result)


if __name__ == "__main__":
    unittest.main()
