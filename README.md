# Build Awesome Command-Line Applications in Ruby2 読書ログ
## 2015年2月9日（月）

- P55では戻り値を取るための方法が書かれている。`$?`で取れるんだけど、変数名としてはわかりにくいので、これを何とかしたい。
- それを何とかするのが[English](http://docs.ruby-lang.org/ja/2.2.0/library/English.html)ライブラリ。
  - 特殊変数に英語名の別名を付けてくれる。
- 今回の戻り値の例で言えば、`$?`が`$CHILD_STATUS`となる。戻り値は、`exitstatus`で参照できる（[参考](http://docs.ruby-lang.org/ja/2.2.0/method/Kernel/v/=3f.html)）。

## 2015年2月8日（日）

- 今日はP53。Chapter4のPlay Well with Othersから。他のものとうまく動くって感じかな。
- 4.1ではUsing Exit Codes to Resport Success or Failure、終了コードによって成功か失敗かを報告することについて記してある。
- 終了コード（終了ステータス）については、WikiPediaに[解説](http://ja.wikipedia.org/wiki/%E7%B5%82%E4%BA%86%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9)があるのでそれも合わせて読んでおく。
- 慣例的に0が成功でそれ以外を失敗と考えれば良いかなと思う。
- サンプルコードが付いているけど、これまでのものの流れが考慮されていない気がする。

## 2015年2月3日（火）

- P47のWriting Good Help Text and Documentationから。
- 良いヘルプテキストやドキュメントの書き方について。
- usageの書き方とか、そもそもドキュメントに何を書くのかについて。
- `GLI`で生成するとドキュメントはテンプレートとしてある程度生成されるので、それに沿って書けば良さそう。
- P50とP51に書かれているTable2の内容をひと通り書く、つまりは、`ronn`で生成されるドキュメントに沿って書けば良さそう。
- 次回は、第4章 Play Well with Others。

## 2015年2月1日（日）

- P42の3.3 Including a Man Pageから。
- manページを書くには、また独自のフォーマットを覚えなきゃいけないよなぁと思っていたら、Markdownからmanページのフォーマットに変換してくれるツールがGemで配布されているらしい。
- ~~それが、[gem-man](https://github.com/defunkt/gem-man)。~~
- P45でそのmanページの元になっているファイルを作成している。
- 実際にmanページの生成については、P46に記載されている。
- `man man/db_backup.1`って実行するとmanページが表示される。
- って、ここまで書いて違うことに気がついた。
- [gem-man](https://github.com/defunkt/gem-man)は、gemにman表示機能を追加する感じ。
- Markdownからmanページのフォーマットに変換するのは[ronn](https://github.com/rtomayko/ronn)
- 今日はここまで。次回はP47 3.4 Writing Good Help Text and Documentation

## 2015年1月28日（水）

- 久しぶりの再開。多分、P38の「3.2 Documenting a Command Suite」から再開。
- ヘルプメッセージの作り方について。今回はtodoアプリ。
- todoアプリは、GLIというツールを使った。このGLIはヘルプメッセージも丁寧に作ってくれる。
- 詳細は、P40から。`desc`には短めの説明、`long_desc`には長い説明ってな感じで記述していく。
- P42には`arg_name`や`default_value`の設定が書かれている。
  - ここを見ずに、前のソースコードだけで「あれ？default:のところがうまく表示されない」ってなっていろいろと探し回った。
- 次は、P42の3.3 Including a Man Pageから。

## 2015年1月9日（金）

- OptionParserは`parse!`メソッドを実行するとコマンドライン引数である`ARGV`を直接編集し、オプションのものは削除する。
- OptionParserは定義していないオプションが指定された場合は、`parse!`の時点で例外を吐くので、`ARGV`に残るものはデータベース名だけだと考えてよいっぽい。

## 2015年1月8日（木）

- `-h`メッセージにMySQLを対象としているということを明示する。そのためには`banner=`に設定する値を編集する。

## 2015年1月7日（水）

- 3章。`-h`をつけて表示されるヘルプメッセージを作成する。
- ヘルプメッセージは、自分で全部作るんじゃなくて、`optionparser`の`on`メソッドにおいてメッセージを追加することで、オプションのメッセージが作れる。
- これだと、プログラム自身の使い方は表示されないので、`banner=`メソッドで値を指定する。

## 2015年1月4日（日）

- P29では`list`の実装例があるけど、`read_todo`メソッドを実装していないのでこれは動かない。
  - 動かすためには、`read_todo`が返す値のデータ構造も考えないといけない。ちょっと面倒臭い。
- GLIで作成したアプリは動的にヘルプオプションを取れるようになっている。
- 動かしてみると、`_doc`というオプションが出てきた。これ、どこで定義されているのだろう。
- このヘルプページが作られる機能を使って、bashでの補完機能を追加するということをやっている。

## 2015年1月2日（金）

- GLIの`scaffold`で生成されたソースコードの解説がP27から。
- P28から生成されたソースコードに対して手を加えていく。
- グローバルオプションとして、`f`オプション。ファイル名の指定。
- `new`サブコマンドに対して`priority`オプションと`f`スイッチを追加する。
  - グローバルオプションの`f`オプションと`f`スイッチの違いはどうやって判断するんだろう。
    - サブコマンドの前に`f`オプションがあればグローバルオプションとして判断される。
    - サブコマンドの後に`f`オプションがあればスイッチとして判断される。
- `list`サブコマンドに対しては、`s`オプション。
- `done`サブコマンドに対しては、特に何も追加しない。
- P29の実行ログで`p`オプションがあるけど、実際には`priority`ではないかな？

## 2014年12月29日（月）

- P23にてserverオプションを追加。serverオプションの妥当性はハッシュで指定できる。
- ここでserverオプションを追加するときに既存のコードがsyntaxエラーで落ちることがわかった。
  - テストを書かないとあかんなぁ。
  - `end_if_iter`の役割がやっぱりわからない。`true`/`false`なのか、なにか値を取るのか。途中で意味が変わっている気がする。
- todoアプリに対してもオプション解析機能を追加することに。
- オプション解析機能として今回は、GLIというGemを使うらしい。
- GLIで`scaffold`して動かそうとしたら`aruba`っていうGemが追加で必要らしい。これは追加でgem installする。

## 2014年12月27日（土）

- ここらでテストを書こうとしたけど、どうにもこうにも書きにくい。
  - `optparse`の解析結果をテストしようとしたけど、どうやってテストを書けばいいか分からなかった。
  - というわけで、ここでテストを書くのはやめ。
- `opts.on("-u USER", /^.+\..+$/)`でオプションの引数の正規表現validationが可能。
- これにマッチしない引数を指定すると、`invalid argument: -u hoge (OptionParser::InvalidArgument)`と出てくる。

## 2014年12月26日（金）

- オプションの実装は、`optparse`を使うと楽に書ける。
- `optparse`の説明はるりま（http://docs.ruby-lang.org/ja/2.1.0/library/optparse.html）を参照。
- P22では、userオプションの引数にとるUSERのvalidationを追加している。
  - validationはファーストネーム + ピリオド（.） + ラストネームの形とする。

## 2014年12月23日（火）

- db_backup.rbをより使いやすくするために、オプション解析機能をつける。
- `-p`はパスワード、`-u`はユーザ名、`-i`は繰り返すかそうでないかのオプション。end-of-iterationの役割。
- データベース名にはオプション名を付けない

## 2014年12月22日（月）

- P13から第2章。使いやすくするために、まずはコマンドラインのオプションや引数やコマンドなどを実装する
- オプションの指定は様々。オプションごとに一つ一つ分けたり（`-l -a -t`）、一個に統一（`-lat`）したり。
- 短いバージョン以外にも長いバージョンが有る。
- 引数は、オプションではないものって書いてあるんだけど、これだと次のコマンドと区別がつかないような
- コマンドは、executableに対する命令ってな感じかな？`git`コマンドだと`commit`とか`add`とか。
- コマンドというよりかはサブコマンドって言ったほうがしっくり来る。

## 2014年12月19日（金）

- todo-*.rbは3つに分かれているけど、似たようなソースがそれぞれに実装されていたりする。
- そこで、todoというアプリを作ってこの3つをまとめることにする。
- 第一引数でnew、list、doneを取るようにして、処理内容を変えることにする。
- 実装がP9。

## 2014年12月17日（水）

- P5では最初のプログラムを修正して、データベース名、ユーザ名、パスワードなどを引数で取れるようにしている。
- 他のデータベースをバックアップの対象としたいときなどプログラムの修正する必要がなくなる。
- このプログラムはこの本を通して改善を続けるようだ。
- 1.2でタスクマネジメントツール。色々あるけど、すっごくシンプルなものを作る。メモ紙に書き殴る感じのもの。
- そのために3つのプログラムを作る。todo-new.rb、todo-list.rb、todo-done.rbの3つ。

## 2014年12月12日（金）

- コマンドラインのアプリケーションの例として、MySQLのデータバックアッププログラムツールを作っていく。
- end-of-iterationってなんだろう。
- とりあえず、最初の実装がP3にある。


