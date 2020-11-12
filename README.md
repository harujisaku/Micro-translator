# Micro-translator
 ![picture](https://raw.githubusercontent.com/harujisaku/readme-image/master/20201113062217.png)  
英語、フランス語、イタリア語、ロシア語と日本語双方向翻訳ソフトです。  
google apps scripを利用した翻訳ソフトになります。

15文字以上入力すると自動でウィンドウサイズが大きくなり改行等が可能になるモードになります。  
![bigmode](https://raw.githubusercontent.com/harujisaku/readme-image/master/20201113062307.png)  
改行は＜rl＞という文字に置換されるため文字列に＜rl＞があると翻訳後の文字列に改行が追加されます。  
また翻訳してほしくないところを＜nt＞＜/nt＞で囲むことによりgoogle翻訳が自動で翻訳をしなくなります。  

例  
My name is haru.  

↓  

私の名前はハルです。  

My name is ＜nt＞haru＜/nt＞.  

↓  

私の名前はharuです。  

# インストール

できるならcode.gsをgoogle apps scriptにアップロードして自前のapiを作ってください。

↓apiのプログラム  
https://github.com/harujisaku/Micro-translator/raw/main/MicroTranslator/code.gs  

# 使い方
上の入力ボックスに翻訳したい文字列を入力しエンターキーを押すと翻訳が開始されます。初めての翻訳のみ時間がかかりますが二回目以降はかなり早くなります。  
またウィンドウ内の画像をクリックすることでクリップボードに格納されている文字列を抜き出し翻訳し翻訳結果をクリップボードに格納します。これによって連続した翻訳作業の時間短縮に繋がります。  
改行モードになると改行のたびに翻訳されるのはストレスになるので手動でtransボタンを押さないと翻訳できないようになっています。またhtmlモードで翻訳させているためhtmlをコピーすると翻訳されたhtmlが出てきます。

# 環境
java 8 以降が動く必要があります。

# 開発
processing3の開発環境が必要です。
https://processing.org/

MicroTranslator.pdeを開いて実行できます。

# その他

動かなくても知りません。教えてくれると嬉しいです。
自分で直しちゃってください。
