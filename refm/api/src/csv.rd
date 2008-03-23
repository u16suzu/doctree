#@since 1.8.0
CSV (Comma Separated Value) を扱うライブラリです。

= class CSV < Object

CSV (Comma Separated Value) を扱うクラスです。

各メソッドの共通パラメタ

  mode
     'r', 'w', 'rb', 'wb' から指定可能です。

     - 'r' 読み込み
     - 'w' 書き込み
     - 'b' バイナリモード
  fs
     フィールドの区切り文字
     デフォルトは ','
  rs
     行区切り文字。nil (デフォルト) で CrLf / Lf。
     Cr で区切りたい場合は ?\r を渡します。

== Class Methods

--- open(path, mode[, fs = nil[, rs = nil]]) {|row| ... } -> nil
--- open(path, mode[, fs = nil[, rs = nil]]) -> CSV::Reader
--- open(path, mode[, fs = nil[, rs = nil]]) -> CSV::Writer

読み込みモード時には path にあるファイルを開き各行を配列として
ブロックに渡します。

@param path パースするファイルのファイル名
@param mode 処理モードの指定
            'r', 'w', 'rb', 'wb' から指定可能です。
            - 'r' 読み込み
            - 'w' 書き込み
            - 'b' バイナリモード
@param fs フィールドセパレータの指定。
          nil (デフォルト) で ',' をセパレータとします。
@param rs 行区切り文字の指定。nil (デフォルト) で CrLf / Lf。
          Cr を行区切りとしたい場合は ?\r を渡します。

例:

  CSV.open("/temp/test.csv", 'r') do |row|
    puts row.join("<>")
  end

tsv(Tab Separated Value)ファイルなどのセパレータをカンマ以外で指定

  CSV.open("/temp/test.tsv", 'r', "\t") do |row|
    puts row.join("<>")
  end

ブロックを渡さなかった場合 CSV::Reader を返します。

書き込みモード時には path にあるファイルを開き CSV::Writer をブロックに渡します。

例:

  CSV.open("/temp/test.csv", 'w') do |writer|
    writer << ["ruby", "perl", "python"]
    writer << ["java", "C", "C++"]
  end

ブロック未指定の場合 CSV::Writer を返します。

#@since 1.8.2

--- foreach(path[, rs = nil]) {|row| ... } -> nil

読み込みモードでファイルを開き、各行を配列でブロックに渡します。

@param path パースするファイルのファイル名
@param rs 行区切り文字の指定。nil (デフォルト) で CrLf / Lf。
          Cr を行区切りとしたい場合は ?\r を渡します。

例:

  CSV.foreach('test.csv'){|row|
    puts row.join(':')
  }

--- read(path[, length = nil[, offset = nil]]) -> [[c:Array]]

path で指定された CSV ファイルを読み込み、配列の配列でデータを返します。

@param path パースするファイルのファイル名
@param length 対象ファイルの読み込みサイズ
@param offset 読み込み開始位置

--- readlines(path[, rs = nil]) -> [[c:Array]]

path で指定された CSV ファイルを読み込み、配列の配列でデータを返します。

@param path パースするファイルのファイル名
@param rs 行区切り文字の指定。nil (デフォルト) で CrLf / Lf。
          Cr を行区切りとしたい場合は ?\r を渡します。

#@end

--- generate(path[, fs = nil[, rs = nil]]) -> [[c:CSV::BasicWriter]]
--- generate(path[, fs = nil[, rs = nil]]) {|writer| ... } -> nil

path で指定されたファイルを書き込みモードで開き、ブロックに渡します。
ブロック未指定の場合は [[c:CSV::BasicWriter]] を返します。

@param path パースするファイルのファイル名
@param fs フィールドセパレータの指定。
          nil (デフォルト) で ',' をセパレータとします。
@param rs 行区切り文字の指定。nil (デフォルト) で CrLf / Lf。
          Cr を行区切りとしたい場合は ?\r を渡します。

例:
  a = ["1","ABC","abc"]
  b = ["2","DEF","def"]
  c = ["3","GHI","ghi"]
  x = [a, b, c]

  CSV.generate("test2.csv"){|writer|
    x.each{|row|
      writer << row
    }
  }

--- parse(str_or_readable[, fs = nil[, rs = nil]]) -> [[c:Array]]
--- parse(str_or_readable[, fs = nil[, rs = nil]]){|rows| ... } -> nil

str_or_readable で指定された文字列をパースし配列の配列に変換、ブロックに渡します。
ブロック未指定の場合は変換された配列の配列を返します。

@param str_or_readable パースする文字列
@param fs フィールドセパレータの指定。
          nil (デフォルト) で ',' をセパレータとします。
@param rs 行区切り文字の指定。nil (デフォルト) で CrLf / Lf。
          Cr を行区切りとしたい場合は ?\r を渡します。

例:
  CSV.parse("A,B,C\nd,e,f\nG,H,I"){|rows|
    p rows
  }

--- generate_line(row[, fs = nil[, rs = nil]]) -> [[c:String]]
--- generate_line(row[, fs = nil[, rs = nil]]){|s| ... } -> nil

row で指定された配列をパースし、fs で指定された文字をフィールドセパレータとして
1行分の文字列をブロックに渡します。
ブロック未指定の場合は変換された文字列を返します。

@param row パースする配列
@param fs フィールドセパレータの指定。
          nil (デフォルト) で ',' をセパレータとします。
@param rs 行区切り文字の指定。nil (デフォルト) で CrLf / Lf。
          Cr を行区切りとしたい場合は ?\r を渡します。

--- parse_line(src[, fs = nil[, rs = nil]]) -> [[c:Array]]
--- parse_line(src[, fs = nil[, rs = nil]]){|row| ... } -> nil

src で指定された文字列を1行分としてパースし配列に変換、ブロックに渡します。
ブロック未指定の場合は変換された配列を返します。

@param src パースする文字列
@param fs フィールドセパレータの指定。
          nil (デフォルト) で ',' をセパレータとします。
@param rs 行区切り文字の指定。nil (デフォルト) で CrLf / Lf。
          Cr を行区切りとしたい場合は ?\r を渡します。

--- generate_row(src, cells, out_dev[, fs = nil[, rs = nil]]) -> Fixnum

src で指定された配列パースして csv形式の文字列として(行区切り文字も含めて) out_dev に出力します。
返り値として fs で区切ったフィールド(cell)の数を返します。

@param src パースする配列
@param cells パースするフィールド数。
@param out_dev csv形式の文字列の出力先。
@param fs フィールドセパレータの指定。
          nil (デフォルト) で ',' をセパレータとします。
@param rs 行区切り文字の指定。nil (デフォルト) で CrLf / Lf。
          Cr を行区切りとしたい場合は ?\r を渡します。
例:
  row1 = ['a', 'b', 'c']
  row2 = ['1', '2', '3']
  row3 = ['A', 'B', 'C']
  src = [row1, row2, row3]
  buf = ''
  src.each do |row|
    parsed_cells = CSV.generate_row(row, 2, buf)
  end
  p buf #=>"a,b\n1,2\n,A,B\n" 

--- parse_row(src, index, out_dev[, fs = nil[, rs = nil]])
#@todo


#@include(csv/CSV__BasicWriter)
#@include(csv/CSV__Cell)
#@include(csv/CSV__IOBuf)
#@include(csv/CSV__IOReader)
#@include(csv/CSV__IllegalFormatError)
#@include(csv/CSV__Reader)
#@include(csv/CSV__Row)
#@include(csv/CSV__StreamBuf)
#@include(csv/CSV__StringReader)
#@include(csv/CSV__Writer)
#@end
