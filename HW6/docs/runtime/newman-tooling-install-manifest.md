# Newman Local Tooling External-Install Manifest

Status: `BLOCKED_FOR_EXTERNAL_INSTALL`  
Root blocker: `SANDBOX_PACKAGE_INSTALL_RESTRICTION`  
Workspace: `D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW\HW6`

This handoff installs Newman and the genuine `newman-reporter-htmlextra` package entirely under the ignored `.tools/` directory. It does not install globally or modify the EShop backend dependency graph.

## Agent recovery evidence

| Strategy                        | Result    | Error classification        | Evidence                                                                                                                                                              |
| ------------------------------- | --------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Existing local dependency       | Not found | `LOCAL_DEPENDENCY_ABSENT`   | No HW6 `node_modules/.bin/newman.cmd`, `node_modules/newman`, or `.tools/newman` binary existed.                                                                      |
| Existing cached package         | Failed    | `PACKAGE_NOT_CACHED_USABLY` | Global cache indexed Newman metadata/tarball, but npm offline resolution returned `ENOTCACHED`; a complete usable dependency graph was unavailable.                   |
| Writable local registry install | Failed    | `REGISTRY_DENIED`           | Local npm debug log recorded registry GET attempts failing with `EACCES`; the command was interrupted after repeated built-in npm fetch attempts produced no install. |

Effective isolated paths used by the agent:

```text
CACHE_PATH:  D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW\HW6\.tools\npm-cache
PREFIX_PATH: D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW\HW6\.tools\newman
NPM_PREFIX:  D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW\HW6\.tools\npm-prefix
TEMP_PATH:   D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW\HW6\.tools\tmp
REGISTRY_REACHABLE: NO FROM CURRENT SANDBOX
```

No Newman version or HTML output is claimed until the verification commands below succeed.

## Git Bash commands

Run from a Human terminal with npm registry access:

```bash
cd '/d/Workspace/HCMUS/Software Testing/Homework/Hcmus-Software_Testing-HW/HW6'

mkdir -p .tools/npm-cache .tools/newman .tools/npm-prefix .tools/tmp

npm_config_cache="$PWD/.tools/npm-cache" \
npm_config_prefix="$PWD/.tools/npm-prefix" \
TEMP="$PWD/.tools/tmp" \
TMP="$PWD/.tools/tmp" \
npm install \
  --prefix "$PWD/.tools/newman" \
  --cache "$PWD/.tools/npm-cache" \
  --no-audit \
  --no-fund \
  newman@6.2.2 \
  newman-reporter-htmlextra

./.tools/newman/node_modules/.bin/newman.cmd --version
node -e "console.log(require('./.tools/newman/node_modules/newman-reporter-htmlextra/package.json').version)"
```

## PowerShell commands

```powershell
Set-Location -LiteralPath 'D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW\HW6'

New-Item -ItemType Directory -Force -Path '.tools\npm-cache', '.tools\newman', '.tools\npm-prefix', '.tools\tmp' | Out-Null

$env:npm_config_cache = (Resolve-Path '.tools\npm-cache').Path
$env:npm_config_prefix = (Resolve-Path '.tools\npm-prefix').Path
$env:TEMP = (Resolve-Path '.tools\tmp').Path
$env:TMP = $env:TEMP
$hw6NewmanPrefix = (Resolve-Path '.tools\newman').Path
$hw6NpmCache = (Resolve-Path '.tools\npm-cache').Path

npm.cmd install `
  --prefix $hw6NewmanPrefix `
  --cache $hw6NpmCache `
  --no-audit `
  --no-fund `
  newman@6.2.2 `
  newman-reporter-htmlextra

& '.\.tools\newman\node_modules\.bin\newman.cmd' --version
node -e "console.log(require('./.tools/newman/node_modules/newman-reporter-htmlextra/package.json').version)"
```

## Resume verification command

After the Human installation succeeds, the agent should begin with:

```powershell
Set-Location -LiteralPath 'D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW\HW6'
& '.\.tools\newman\node_modules\.bin\newman.cmd' --version
node -e "console.log(require('./.tools/newman/node_modules/newman-reporter-htmlextra/package.json').version)"
```

Then resume at tooling verification → SUT start → `preflight-003` → smoke. Do not run Newman or start the SUT in the external-install step itself.

## Git/submission boundary

`.tools/` is excluded by `.tools/.gitignore`. Do not stage the local package cache, installed modules, runtime environment, or secrets. The separate repository Git checkpoint remains `PENDING_EXTERNAL_GIT_PERMISSION`.
