# ダウンロード等

## listDL.sh: 動画URLのDL
- `$DIR/list/`を作成する
- YouTubeの再生リスト(のURL)から動画のURLを取得する
- 取得されたURL群は`$DIR/list/url.list`に格納される


## jsonDL.sh: チャットコメント(json形式)のDL
- `$DIR/chat/`, `$DIR/chat/json/`を作成する
- `$DIR/list/url.list`内のURLから`*.live_chat.json`をダウンロードし、`$DIR/chat/json/`に格納する


## soundDL.sh: 動画音声(m4a形式)のダウンロード
- `$DIR/list/soundDL.list`にある動画`$id`から、音声(m4aファイル)をダウンロードする
- 複数あるDLオプションのうち音質が最も良いm4aファイルを選択する


## infoDL.sh: 動画詳細のダウンロード
- `$DIR/list/vvc.list`に記載されたURLから、動画の詳細(*.info.json)をダウンロードし、`$DIR/info_json/`に格納する
- また、動画IDとチャンネル名を*.info.jsonから抽出し、`$DIR/list/channel.list`に格納する。



# jsonファイルの整形

## json2text.sh
- `$DIR/chat/text/`、`$DIR/chat/text/txtX/`を作成する
- jsonファイルから`time󱖢comment`形式のtxtファイルに変換する
- この際、関係のないコメントを削除する


## text2emp.sh
- `$DIR/chat/text/txtX/`以下のtxtファイル群に対して、
    - `$DIR/list/emp1.list` 形態素解析器
    - `$DIR/list/emp2.list` 正規表現
  に最適化した感情表現語彙リストを使ったコメントの抽出を行う
- `$DIR/chat/chat.emp`にその結果を格納する

### chat.emp
- 感情表現語彙を含むコメントのリスト
- 動画URLの行以下に、その動画のコメントが載せられている


## emp2scene.sh
- `$DIR/chat.emp`から、
    1. 前行から3秒以内のコメント
    2. コメント群が3行以上
    3. 最初のコメントから10秒以内のコメント
  であるコメント群(シーン)を抽出する
- 抽出されたシーンは、最初のコメントの10秒前の時刻`$beginTime`を使って、URL及びsceneファイルを生成する
    - `https://youtu.be/${id}?t=${beginTime}`
    - `$DIR/chat/scene/${id}@${beginTime}.scene`



# sceneファイルの選別

## empCounter.sh
- `$DIR/chat/scene/`下のsceneファイルに含まれる感情語彙のうち、ある特定の基本感情を表す感情語彙が40%以上を占める場合、その基本感情のリスト`$DIR/list/*.list`にファイル名を追記する
- そもそも感情語彙が含まれないsceneファイルはerror.logに追記される


## empListSelector.sh
- sceneファイル群から、(秒数の)3桁目以降が一致するファイルをふるいにかける
- empCounter.shで得たリストから、更に篩にかけるときに使う


## check.sh
- 判定するsceneファイル群のリスト(check.list)を作成する
- 1つ1つnvimに流して、以下のキーで判定を行い、vvc.listを作成する
```lua
set('n', 't', ':!echo "expand(\'%:p\')" | sed "s@.*/@@" | sed "s@.)@@" | cat >> del.list<CR>:<C-u>qa!<CR>')
set('n', 'q', ':!echo "expand(\'%:p\')" | sed "s@.*/@@" | sed "s@.)@@" | cat >> vvc.list<CR>:<C-u>qa!<CR>')
```

### vvc.list, del.list
- vvc.listはコーパスに使用するsceneファイルのリスト
- del.listはコーパスには不適格なsceneファイルのリスト



# 教師データの作成

## ogvc2lavel.sh
- `$DIR/OGVC/OGVC_Vol1/Natural/eval/category.txt`から、2名以上の評価者が一致してANG、FEA、JOY、SADの感情ラベルが付いたものを抽出
- ID、感情ラベル、音声ファイルのパスの形でCSVファイルに出力


## vvc2lavel.sh
- あらかじめ感情毎に分類していた感情語彙の医すと`$DIR/list/emp3.list`を用いて、コメントを分類・感情ラベルを作成する
- ID、感情ラベル、音声ファイルのパスの形でCSVファイルに出力
- これがVVC本体となる


# 特徴量データの作成

## ogvcSplitter.sh
- `$DIR/OGVC/OGVC_Vol1/Natural/trans/`内のtxtファイルから、感情音声のユニークID、開始時刻、終了時刻を取得し、`$DIR/OGVC/OGVC_Vol1/Natural/wav/`内のwavファイルを分割するffmpegのスクリプトを作成する。
- `$DIR/sound/ogvc/`を作成する
- 作成された`splitter.sh`を実行し、wavファイルを分割する。また実行後に`splitter.sh`は削除される


## vvcSplitter.sh
- `$DIR/list/scene.list`から、感情音声があった期間を切り分ける
- 同時にOGVCのフォーマットを合わせる


## removeBGM.ipynb
- [vocal-remover](https://github.com/tsurumeso/vocal-remover)を使用して、VVCコーパスの音声に含まれるBGM等を削除する
- Docker + jupyter labでpytorch環境を構築し、`$DIR/sound/vvc/original/`内のwavファイルに処理を施す。


## ogvc2feat.sh, vvc2feat.sh
- [openSMILE](https://www.audeering.com/research/opensmile/)の[The INTERSPEECH 2009 Emotion Challenge feature set](https://audeering.github.io/opensmile/get-started.html#the-interspeech-2009-emotion-challenge-feature-set)(config/is09-13/IS09_emotion.conf)を使用して、特徴量の抽出を行う。
- `$DIR/features/`、`$DIR/features/ogvc/`、`$DIR/features/vvc/`を作成する
- `$DIR/sound/ogvc/`、`$DIR/sound/vvc/nonBGM/`内のwavファイルをopenSMILEにかけることで特徴量を得る。





# 感情音声推定器の作成

## MLP.ipynb
- scikit-learnのMLPClassifier関数によってMLPを作成・訓練する
- 同ライブラリのtrain_test_split関数を用いてコーパスを分割する
- VVCとOGVCで交差実験をし、それぞれの推定結果の適合率、再現率、F値を計算し、表で出力する

