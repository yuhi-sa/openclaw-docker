# OpenClaw Docker Setup

OpenClawをDocker内でセキュアに実行するための構成。
LLMにはGoogle Gemini 2.5 Flash を使用（低コスト・無料枠あり）。

## 初回セットアップ

```bash
# 1. 環境変数を設定
cp .env.example .env
# .env に GEMINI_API_KEY を記入
# 取得先: https://aistudio.google.com/apikey

# 2. Dockerイメージをビルド
make build

# 3. 初回セットアップ（設定ファイルの初期化）
make onboard

# 4. 接続テスト
make test-provider
```

## 起動方法

```bash
# ゲートウェイを起動
make up

# ダッシュボードURLを取得（ブラウザでアクセス）
make dashboard
```

起動後、`make dashboard` で表示されるURLにブラウザからアクセスして利用できます。

### 停止・再起動

```bash
# 停止
make down

# ログ確認
make logs
```

## LLM設定

`openclaw.yaml` でモデルを設定済み:

- **モデル**: `google/gemini-2.5-flash`
- **料金**: 入力 $0.50 / 出力 $3.00 (100万トークンあたり)
- **無料枠**: 1日1,000リクエスト

## セキュリティ設定

- `read_only`: コンテナファイルシステムは読み取り専用
- `cap_drop: ALL`: 全Linuxケイパビリティを除外
- `no-new-privileges`: 権限昇格を防止
- `127.0.0.1` バインド: ローカルホストのみ公開
- メモリ/CPU/PID制限付き
- サンドボックスモード有効
- APIキーは `.env` で管理（gitignore済み）

## コマンド

| コマンド | 説明 |
|---------|------|
| `make build` | イメージをビルド |
| `make up` | ゲートウェイを起動 |
| `make down` | コンテナを停止 |
| `make onboard` | 初回セットアップ |
| `make dashboard` | トークン付きURLを取得 |
| `make test-provider` | Gemini接続テスト |
| `make logs` | ログを表示 |
| `make clean` | コンテナ・ボリューム・イメージを削除 |
