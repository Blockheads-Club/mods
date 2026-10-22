<h1 align="center">Blockheads Mods</h1>

<p align="center">
  The public list of mods for <b>The Blockheads</b>. Add your mod with a pull request. 🧩
</p>

<p align="center">
  <img src="https://img.shields.io/maintenance/yes/2026?style=for-the-badge" alt="Maintained">
  <a href="https://github.com/Blockheads-Club/mods/actions/workflows/validate.yml"><img src="https://img.shields.io/github/actions/workflow/status/Blockheads-Club/mods/validate.yml?style=for-the-badge&label=Checks" alt="Checks"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-CC0--1.0-blue?style=for-the-badge" alt="License"></a>
</p>

---

## 🚀 Project Status
**Current Status:** Not open yet (milestone M4). The two entries in `mods/` are **drafts** with fake download links,
used to test the tools. Servers and clients can't load mods yet; see the
[mod SDK](https://github.com/Blockheads-Club/mod-sdk) for what works today.

> The `Blockheads-Club/mods` and `Blockheads-Club/mod-sdk` GitHub repos don't exist yet. The workflows here install
> the `bhmod` tool from `Blockheads-Club/mod-sdk`, so they will only run once that repo is public.

Every mod has one file here: `mods/<first letter>/<id>.toml`. CI checks each pull request, a maintainer approves
it, and on merge the list is published as a signed `index.json`. The game, the
[Patcher](https://github.com/Blockheads-Club/blockheads-patcher), the [website](https://blockheads.club/mods) and the
[server](https://github.com/Blockheads-Club/blockheads-server) read that file.

---

## 📦 Submit a mod
1. Make your mod with the [SDK](https://github.com/Blockheads-Club/mod-sdk) and build it: `bhmod pack .`
   (it prints the `sha256`). The package needs a `LICENSE` file.
2. Upload the `.bhmod` somewhere permanent, for example a GitHub release of your mod's repo.
3. Fork this repo and add `mods/<first letter>/<id>.toml`:

```toml
id = "my-mod"                    # same id as in mod.toml
name = "My Mod"
description = "What it does, in one or two sentences."
owners = ["your-github-name"]    # who may send new versions
repo = "https://github.com/you/my-mod"
tags = ["chat", "admin"]

[[versions]]
version = "1.0.0"
url = "https://github.com/you/my-mod/releases/download/v1.0.0/my-mod-1.0.0.bhmod"
sha256 = "…"                     # printed by bhmod pack
size = 12345                     # bytes
sides = ["server"]               # "server", "client" or both
api = "^0.1"
permissions = { players = ["chat"] }
published = 2026-10-21
```

4. Open a pull request. CI comments with the result and the permissions your mod asks for.

**New version:** add another `[[versions]]` block at the end. **Withdraw a version:** add `yanked = true` to it.
Full format: [`index-entry.schema.json`](https://github.com/Blockheads-Club/mod-sdk/blob/dev/schema/index-entry.schema.json).

---

## 📏 Rules
- One mod per pull request.
- Published versions are never edited or removed. You may only add new versions at the end, or `yanked = true`.
- Only people in a mod's `owners` may change it. A new mod is approved by a maintainer.
- The download must stay online and match `sha256` and `size`. On merge, CI keeps a copy as a release asset of this
  repo (`mirror`), in case the original link breaks.
- The `mod.toml` inside the package must say the same as your entry (id, version, sides, dependencies, permissions).
- Ask only for the permissions you need. No malware, no hidden network access, nothing that harms players or
  servers. Maintainers may yank a version that breaks these rules.

---

## 🔍 What CI checks
The [`validate`](.github/workflows/validate.yml) workflow runs `bhmod index validate` from the SDK:

1. The entry matches the schema; file name and folder match the id.
2. One mod changed; versions only appended (except `yanked`); you are an owner (new mods: you are in `owners`).
3. It downloads each new version and checks the SHA-256, the size, the package rules (paths, sizes, entry points,
   `LICENSE`) and that the package's `mod.toml` matches the entry.
4. Dependencies exist in the index; `api` matches a supported API version.
5. Every `.wasm` is valid and imports only the mod API and sandboxed WASI; every `.luau` compiles.
6. It comments the permission list and what changed since the last version.

### Security review
The label **`needs-security-review`** is added when a version asks for `native` (unsandboxed code: native hooks,
`.so` files, JVM), when an update adds a permission, or when a new mod asks for `net-http`. The check
**Security review** then stays red until a maintainer has read the code and adds the label `security-approved`.
New mods also get `new-mod` and need one maintainer approval.

---

## 🧪 Test locally
You need the `bhmod` tool (`cargo install --git https://github.com/Blockheads-Club/mod-sdk bhmod`, or a local build
of the SDK).

```bash
scripts/check-local.sh            # checks the drafts against testdata/packages and builds _site/index.json
BHMOD=../mod-sdk/target/debug/bhmod scripts/check-local.sh
```

Local mode never downloads: packages come from `testdata/packages/<id>-<version>.bhmod` (`--packages`), and drafts
are included. The test packages are the SDK's `hello-lua` and `hello-rust` examples (MIT OR Apache-2.0).

---

## 🔑 Signing
`publish.yml` signs `index.json` with minisign (ed25519) using the repo secret `INDEX_SIGNING_KEY` (the secret key
file's text; optional `INDEX_SIGNING_KEY_PASSWORD`). The public key goes in `keys/index.pub` and is shipped with the
game, Patcher, website and server. Create the pair once with `bhmod index keygen --dir <private folder>`. No key
exists yet.

---

## 👥 Ownership
Mod authors own their entries through the `owners` field, which CI enforces. GitHub's `CODEOWNERS` only accepts
people with write access, so [`CODEOWNERS`](.github/CODEOWNERS) names the maintainers for every file.

---

## ⚖️ License
The index data (this repo) is [CC0-1.0](LICENSE): anyone may copy and reuse the list, including in GPL apps and
mirrors, without having to carry a notice. Each mod keeps its own license, stated in its package.

Not affiliated with Majic Jungle Software or Noodlecake Studios.
