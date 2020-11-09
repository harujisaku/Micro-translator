# Micro-translator
 ![picture](https://raw.githubusercontent.com/harujisaku/readme-image/master/20201109193754.png)  
 英語と日本語双方向翻訳ソフトです。
#インストール 
 こちら↓を参考にgoogle apps scriptでapiを作る必要があります。
https://www.pnkts.net/2019/12/19/gas-google-transrate
↓apiのプログラム
https://github.com/harujisaku/Micro-translator/raw/main/MicroTranslator/code.gs
  
apiを作ったらzipを解凍しurlを``aplication.*****/data/url.txt``に保存します。このときエンコードはUTF-8で保存します。
事前にapiが使えるかチェックしておいてください。

#使い方
上の入力ボックスに翻訳したい文字列を入力しエンターキーを押すと翻訳が開始されます。初めての翻訳のみ時間がかかりますが二回目以降はかなり早くなります。
またウィンドウ内の画像をクリックすることでクリップボードに格納されている文字列を抜き出し翻訳し翻訳結果をクリップボードに格納します。これによって連続した翻訳作業の時間短縮に繋がります。

#環境
jre 8 以降が動く必要があります。

#開発
processing3の開発環境が必要です。
https://processing.org/

MicroTranslator.pdeを開いて実行できます。

#その他

動かなくても知りません。教えてくれると嬉しいです。
自分で直しちゃってください。
