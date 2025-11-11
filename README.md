# inat-shell-scripts

iNaturalist API から観測データを取得し、種名一覧をテキストファイルとして出力するシェルスクリプトです。

指定した分類群（`iconic_taxa`）と、緯度・経度の範囲（バウンディングボックス）に該当する観測データを取得し、重複を除いたユニークな種名リストを作成します。

---

## ✅ 利用方法

1. 依存コマンドのインストール
```bash
# macOs
brew install jq

# Ubuntu / Debian
sudo apt install jq
```

2. 設定

| 変数名 | 説明 |
|--------|------|
| `NELAT`, `NELNG`, `SWLAT`, `SWLNG` | 抽出範囲（緯度経度） |
| `ICONIC_TAXA` | 対象の分類群 (`Plantae`, `Aves`, `Mammalia` など) |
| `OUTPUT_FILE` | 出力先ファイル名 |

3. 実行
```
bash fetch_inat_taxa.sh
```

4. 結果確認

`OUTPUT_FILE`で指定したファイルに取得結果リストが書き込まれます。
