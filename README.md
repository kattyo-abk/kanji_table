

# これは何

日本語文字コードの暗黙変換を確認するためのデータ生成用スクリプト類です。


# 日本語文字コードの暗黙変換

例として Windows を出しますが、
Windows では ANSIコードページ cp932 (所謂 Shift_JIS)で
NEC特殊文字、IBM拡張漢字、NEC選定IBM拡張漢字がサポートされています。

これらの文字をクリップボード経由でコピー＆ペーストをするとき、
内部でUnicodeへの変換が行われると、異なる文字コードへ変換されます。
cp932 で同一文字に対して複数の文字コードが割り当てられているためです。

例えばハシゴ髙は以下の通り。

NEC選定IBM拡張漢字：eee0
IBM拡張漢字：fbfc

これを一旦Unicodeを経由するとどちらも fbfc に変換されます。

バイナリ一致が不要ならWindowsで使用上の問題はありません。

ただ、端末ソフトや変換ソフト等の挙動を確認するときに変換済みの文字を表示させても正常動作かわかりません。
ですので、そういった変換前の状態を確認するために、SJISの生文字列を生成するためのスクリプト等になります。

ここでは Windows の挙動を紹介しましたが、同一文字に複数のコードポイントがあるため、
これ以外のソフトウェアでも文字コード変換機能を通すと同様の挙動が発生します。


# 使用方法
## gen_kanji_table.pl

漢字表を出力する Perl スクリプトです。

### 引数に設定できる一覧を表示する
perl gen_kanji_table.pl -l

### NEC特殊文字の表を表示する
perl gen_kanji_table.pl -R nec

### IBM拡張漢字の表を表示する
perl gen_kanji_table.pl -R ibm

### NEC選定IBM拡張漢字の表を表示する
perl gen_kanji_table.pl -R necibm

### 改行コードをCRLFではなくLFにする
perl gen_kanji_table.pl -N raw -R necibm


## nonascii_hex.pl

ASCII 以外の文字を16進数で表示する Perl スクリプトです。
```bash
$ diff sjis_nec.txt Pasted-to-Notepad-sjis_nec.txt
9c9
< 8790:  ≒ ≡ ∫ ∮ ∑ √ ⊥ ∠  ∟ ⊿ ∵ ∩ ∪ <
---
> 8790:  ≒ ≡ ∫ ∮ ∑ √ ⊥ ∠  ∟ ⊿ ∵ ∩ ∪ <
$
$ diff sjis_nec.txt Pasted-to-Notepad-sjis_nec.txt | perl nonascii_hex.pl
9c9
< 8790: 8790 8791 8792 8793 8794 8795 8796 8797 8798 8799 879a 879b 879c <
---
> 8790: 81e0 81df 81e7 8793 8794 81e3 81db 81da 8798 8799 81e6 81bf 81be <
$
```

# サンプルファイル
## sample_text ディレクトリ
|filename|概要|
| ---- | ---- |
|Pasted-to-Notepad-sjis_ibm.txt|sjis_ibm.txt をメモ帳で開いて別のメモ帳にコピー＆ペーストしてANSIコードページで保存したファイル|
|Pasted-to-Notepad-sjis_nec.txt|sjis_nec.txt をメモ帳で開いて別のメモ帳にコピー＆ペーストしてANSIコードページで保存したファイル|
|Pasted-to-Notepad-sjis_necibm.txt|sjis_necibm.txt をメモ帳で開いて別のメモ帳にコピー＆ペーストしてANSIコードページで保存したファイル|
|sjis_ibm.txt|gen_kanji_table.pl で生成した IBM拡張漢字 の表|
|sjis_nec.txt|gen_kanji_table.pl で生成した NEC特殊文字 の表|
|sjis_necibm.txt|gen_kanji_table.pl で生成した NEC選定IBM拡張漢字 の表|

# ライセンス LICENSE
Perl スクリプトのみ MIT ライセンスです。
sample_text ディレクトリのファイルは思想が込められていない著作物とは言えないデータです。CC0 とします。

- SPDX-License-Identifier: MIT
  - README.md
  - gen_kanji_table.pl
  - nonascii_hex.pl

- CC0
  - sample_text/*.txt

