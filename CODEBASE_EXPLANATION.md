# コードベース詳細解説（ファイル別）

以下は、このリポジトリ内の各ファイルの役割と設定内容の詳細です。Neovim の LazyVim 構成を前提とした設定群で、プラグイン管理・LSP・補完・UI・ユーティリティをカスタマイズしています。

---

## ルート直下

### init.lua
- 起動時エントリポイント。
- `require("config.lazy")` で Lazy.nvim/LazyVim の初期化処理を読み込み。
- `vim.opt.clipboard = "unnamedplus"` で OS クリップボード連携を有効化。

### lazyvim.json
- LazyVim のバージョン/ニュース情報の管理ファイル。
- `install_version` と `version` が 8 で揃っており、LazyVim 8 系のテンプレートに追随。
- `extras` は空配列で、LazyVim の追加プリセットは未使用。

### lazy-lock.json
- Lazy.nvim のロックファイル。
- すべてのプラグインのブランチとコミット SHA を固定し、再現性を担保。
- `nvim-cmp`, `mason.nvim`, `telescope.nvim`, `image.nvim`, `jupytext.nvim` など主要依存が含まれる。

### stylua.toml
- Lua フォーマッタ StyLua の設定。
- スペース 2、カラム幅 120。

### README.md
- LazyVim テンプレートの案内。
- インストールドキュメントへのリンクのみ（本リポジトリ固有の説明はなし）。

### LICENSE
- Apache License 2.0。
- 商用利用・改変・再配布が可能で、免責や著作権表示維持が要求される。

---

## lua/config/

### lua/config/lazy.lua
- Lazy.nvim のブートストラップ処理。
- `lazy.nvim` が未導入の場合は GitHub からクローン。
- LazyVim 本体と `lua/plugins` を `spec` として登録。
- `defaults.lazy=false` でカスタムプラグインは起動時ロード。
- 不要な標準プラグインを `performance.rtp.disabled_plugins` で無効化（gzip/tar/zip 等）。

### lua/config/options.lua
- LazyVim 既定のオプションに追加設定するための空ファイル。
- 現状は追加設定なし。

### lua/config/keymaps.lua
- LazyVim 既定のキーマップに追加設定するための空ファイル。
- 現状は追加設定なし。

### lua/config/autocmds.lua
- LazyVim 既定のオートコマンドに追加設定するための空ファイル。
- 現状は追加設定なし。

---

## lua/plugins/

### lua/plugins/cmp.lua
- 補完エンジン `nvim-cmp` を有効化し、`blink.cmp` を無効化。
- `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path` を依存として追加。
- `opts.sources` を明示的に構成し、`nvim_lsp` と `path` を優先、`buffer` を補助に。
- Copilot 統合のため `copilot` ソースを `group_index=2` で追加。
- `TextChanged` で自動補完をトリガー。
- `Up/Down/Enter/Tab` を補完操作に割当。
- Python/R/シェル系は filetype ごとに専用ソース構成。
- `copilot-cmp` を `InsertEnter` / `LspAttach` でロードし、Copilot 補完を `cmp` に統合。

### lua/plugins/copilot.lua
- GitHub Copilot の設定。
- 既定のパネル/提案 UI を無効化（`copilot-cmp` 経由で補完統合する設計）。
- markdown では有効、help では無効。

### lua/plugins/image.lua
- `3rd/image.nvim` による画像レンダリング。
- `sixel` バックエンド、`magick_cli` を使用。
- Markdown ではカーソル位置だけ描画し、挿入モードでも消さない。
- `neorg`/`typst` を有効、`html`/`css` は無効。
- 画面高さの 50% まで描画、倍率 1.0。

### lua/plugins/jupytext.lua
- `jupytext.nvim` により Jupyter Notebook の Markdown 変換を支援。
- `style=markdown`、拡張子 `.md`、`filetype=markdown` を強制。
- `lazy=false` で起動時にロード。

### lua/plugins/lsp.lua
- `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim` の統合設定。
- `cmp_nvim_lsp.default_capabilities` で補完能力を LSP に伝搬。
- `lua_ls` の `workspace.checkThirdParty=false` と `telemetry.enable=false` を設定。
- `pyright`, `r_language_server`, `bashls` を有効化。
- `mason-lspconfig` の `ensure_installed` で上記 LSP を自動インストール。
- `mason.nvim` UI は `border=rounded`。

### lua/plugins/nvim-tree.lua
- ファイルツリー `nvim-tree` を導入。
- `<leader>e` でトグル。
- 左サイド幅 32、`git` アイコンやハイライトを有効。
- `hijack_netrw=true` で標準 netrw を置き換え。

### lua/plugins/slime.lua
- `vim-slime` で tmux 送信を有効化。
- 送信先は tmux、`{last}` ペインに送信。
- bracketed paste を有効化。

### lua/plugins/smartyank.lua
- `smartyank.nvim` でヤンク時のハイライトとクリップボード/OSC52 を有効化。
- ハイライトは `IncSearch`、200ms。

### lua/plugins/telescope.lua
- `telescope.nvim` を導入。
- `<leader>ff` / `<leader>fg` / `<leader>fb` / `<leader>fh` を設定。
- レイアウトはプロンプト上部、昇順ソート。

---

## まとめ
- LazyVim をベースに、補完（`nvim-cmp` + Copilot）、LSP（`mason` + `lspconfig`）、ファイルツリー（`nvim-tree`）、検索（`telescope`）、画像表示（`image.nvim`）、Notebook 変換（`jupytext.nvim`）を中心に構成。
- `lua/config` は拡張用の空プレースホルダが多く、将来の拡張余地を残した構成。
