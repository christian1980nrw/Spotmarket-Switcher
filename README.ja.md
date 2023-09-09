<p align="center" width="100%">
    <img width="33%" src="https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/SpotmarketSwitcherLogo.png?raw=true"> 
</p>

[デンマーク語](README.da.md)-[ドイツ人](README.de.md)-[オランダの](README.nl.md)-[英語](README.md)-[スペイン語](README.es.md)-[エストニア語](README.et.md)-[フィンランド語](README.fi.md)-[フランス語](README.fr.md)-[ギリシャ語](README.el.md)-[イタリアの](README.it.md)-[ノルウェー語](README.no.md)-[ポルトガル語](README.pt.md)-[スウェーデンの](README.sv.md)

## Spotmarket-Switcher リポジトリへようこそ!

このソフトウェアは何をしているのでしょうか?
これは Linux シェル スクリプトであり、時間単位の動的エネルギー価格が低い場合に、適切なタイミングでバッテリー充電器や切り替え可能なソケットをオンにします。
ソケットを使用して、はるかに安価に温水タンクをオンにしたり、送電網で安価な風力エネルギーが利用できる夜間に蓄電池を自動的に充電したりできます。
予想される太陽光発電量は、気象 API を介して考慮され、それに応じてバッテリー ストレージが予約されます。
現在サポートされているシステムは次のとおりです。

-   シェリー製品（など）[シェリープラグS](https://shellyparts.de/products/shelly-plus-plug-s)または[シェリープラス](https://shellyparts.de/products/shelly-plus-1pm)）
-   [AVMフリッツ!DECT200](https://avm.de/produkte/smart-home/fritzdect-200/)そして[２１０](https://avm.de/produkte/smart-home/fritzdect-210/)切り替え可能なソケット
-   [ビクトロン](https://www.victronenergy.com/)Venus OS エネルギー貯蔵システムのような[マルチプラスⅡシリーズ](https://www.victronenergy.com/inverters-chargers)

コードはシンプルなので、Linux シェル コマンドで充電を制御できれば、他のエネルギー貯蔵システムにも簡単に適用できます。
ユーザーが設定できる内容を確認するには、controller.sh ファイルの 100 行目以下を見てください。

## 情報元

このソフトウェアは現在、3 つの無料 API (Tibber、aWATTar、Entso-E) によって提供される EPEX スポットの時間料金を利用しています。
統合された無料の Entso-E API は、次の国のエネルギー価格データを提供します。
アルバニア (AL)、オーストリア (AT)、ベルギー (BE)、ボスニア・ヘルツ。 (BA)、ブルガリア (BG)、クロアチア (HR)、キプロス (CY)、チェコ共和国 (CZ)、デンマーク (DK)、エストニア (EE)、フィンランド (FI)、フランス (FR)、ジョージア (GE)、ドイツ (DE)、ギリシャ (GR)、ハンガリー (HU)、アイルランド (IE)、イタリア (IT)、コソボ (XK)、ラトビア (LV)、リトアニア (LT)、ルクセンブルク (LU)、マルタ (MT)、モルドバ (MD)、モンテネグロ (ME)、オランダ (NL)、北マケドニア (MK)、ノルウェー (NO)、ポーランド (PL)、ポルトガル (PT)、ルーマニア (RO)、セルビア (RS)、スロバキア (SK) 、スロベニア (SI)、スペイン (ES)、スウェーデン (SE)、スイス (CH)、トルコ (TR)、ウクライナ (UA)、英国 (UK) を参照[透明性 Entso-E プラットフォーム](https://transparency.entsoe.eu/transmission-domain/r2/dayAheadPrices/show)。

![grafik](https://user-images.githubusercontent.com/6513794/224442951-c0155a48-f32b-43f4-8014-d86d60c3b311.png)

## インストール

Spotmarket-Switcher のセットアップは簡単なプロセスです。 macOS、Linux、または Linux サブシステムを備えた Windows などの UNIX ベースのマシンをすでに実行している場合は、次の手順に従ってソフトウェアをインストールします。

1.  次を使用して、GitHub リポジトリからインストール スクリプトをダウンロードします。[このハイパーリンク](https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh)、またはターミナルで次のコマンドを実行します。
        wget https://raw.githubusercontent.com/christian1980nrw/Spotmarket-Switcher/main/victron-venus-os-install.sh

2.  追加のオプションを指定してインストーラー スクリプトを実行し、サブディレクトリ内のすべてのものを検査用に準備します。例えば：
        DESTDIR=/tmp/foo sh victron-venus-os-install.sh
    Victron Venus OS を使用している場合、正しい DESTDIR は次のとおりです。`/`(ルートディレクトリ)。にインストールされているファイルを自由に探索してください。`/tmp/foo`。

このソフトウェアは現在 Venus OS 用に最適化されていますが、Raspberry Pi または別の小型ボード上の Debian/Ubuntu など、他の Linux フレーバーにも適応できることに注意してください。最有力候補は間違いなく[OpenWRT](https://www.openwrt.org)。デスクトップ マシンをテスト目的で使用するのは問題ありませんが、24 時間 365 日使用する場合、消費電力が大きくなることが懸念されます。

### Venus OS へのアクセス

Venus OS へのアクセス手順については、以下を参照してください。[ｈっｔｐｓ：／／ｗっｗ。ゔぃｃｔろねねｒｇｙ。こｍ／ぃゔぇ／っｃｇｘ：ろおｔ＿あっせっｓ](https://www.victronenergy.com/live/ccgx:root_access)。

### インストールスクリプトの実行

-   Victron Venus OS を使用している場合:
    -   の実行後、`victron-venus-os-install.sh`のテキストエディタで変数を編集します。`/data/etc/Spotmarket-Switcher/controller.sh`。
    -   ESS 充電スケジュールを設定します (提供されたスクリーンショットを参照)。この例では、バッテリーがアクティブになっている場合、夜間に最大 50% まで充電され、一日の他の充電時間は無視されます。望ましくない場合は、1 日 24 時間すべてのスケジュールを作成します。作成後は忘れずに非アクティブ化してください。システム時刻 (画面の右上に表示) が正確であることを確認します。![grafik](https://user-images.githubusercontent.com/6513794/206877184-b8bf0752-b5d5-4c1b-af15-800b6499cfc7.png)

スクリーンショットは、ユーザーが定義した時間中の自動充電の構成を示しています。デフォルトでは非アクティブ化されていますが、スクリプトによって一時的にアクティブ化される場合があります。

-   別の OS を使用している場合:
    -   シェルスクリプトをコピーします(`controller.sh`) をカスタムの場所に移動し、必要に応じて変数を調整します。
    -   crontab または別のスケジュール方法を作成して、各時間の開始時にこのスクリプトを実行します。
    -   Crontab のサンプル:
          次の crontab エントリを使用して、制御スクリプトを 1 時間ごとに実行します。
          端末を開いて入力してください`crontab -e`に次の行を挿入します。
            0 * * * * /path/to/controller.sh

### 支援と貢献

このプロジェクトに価値があると思われる場合は、次のリンクを通じてスポンサーとなり、さらなる開発をサポートすることを検討してください。

-   [レボリュート](https://revolut.me/christqki2)
-   [ペイパル](https://paypal.me/christian1980nrw)

さらに、ドイツにお住まいで動的な電気料金への切り替えに興味がある場合は、これを使用してサインアップしてプロジェクトをサポートできます。[ティバー (参照リンク)](https://invite.tibber.com/ojgfbx2e)。あなたとプロジェクトの両方がハードウェアに対して 50 ユーロのボーナスを受け取ります。時間料金にはスマートメーターまたはPulse-IRが必要となりますのでご注意ください（[ｈっｔｐｓ：／／ちっべｒ。こｍ／で／ｓとれ／ｐろづｋｔ／ぷｌせーいｒ](https://tibber.com/de/store/produkt/pulse-ir)） 。

天然ガス料金が必要な場合、または従来の電気料金を希望する場合でも、プロジェクトをサポートできます。[オクトパスエナジー（紹介リンク）](https://share.octopusenergy.de/glass-raven-58)。
あなた自身とプロジェクトに対して 50 ユーロのボーナスを受け取ります。
オクトパスには、通常、契約期間が月単位のみであるという利点があります。たとえば、証券取引所の価格に基づいて関税を一時停止する場合に最適です。

## 免責事項

利用規約に注意してください。[ｈっｔｐｓ：／／ぎてゅｂ。こｍ／ｃｈりｓちあん１９８０んｒｗ／Ｓぽｔまｒけｔーすぃｔちぇｒ／ｂぉｂ／まいん／ぃせんせ。ｍｄ](https://github.com/christian1980nrw/Spotmarket-Switcher/blob/main/License.md)