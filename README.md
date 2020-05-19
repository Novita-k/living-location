# Living-Location

投稿された写真の撮影場所をGoogleMapを使って位置表示する写真投稿SNS Webアプリケーション。

* Ruby version
:ruby 2.5.1

## Description

生き物に関する写真を投稿します。記録されているGPS情報に基づいて被写体の撮影位置をGoogleMapにピン表示します。
位置情報のない写真は地名を入力して頂き位置登録を行います。
indexには投稿画像が５件づつ新規順に表示され画像の右上プルダウンタグの詳細、又は画像右下のaddressリンクより詳細画面に遷移出来ます。
詳細画面では、よりzoomレベルを絞った状態でmap表示されてmapのピンをクリックして頂くとinfoウィンドウのGoogleMapリンクから新たに撮影位置のGoogleMapをひらくことが出来ます。
もちろんSNSらしくコメントで被写体についてやり取りする事や、いいねをつける事も出来ます。

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
