# Living-Location

投稿された写真の撮影場所をGoogleMapを使って位置表示する写真投稿SNS Webアプリケーション。

・使用技術(開発環境)
* Rails version:rails 5.2.4.1
* Ruby version:ruby 2.5.1

・本番環境(デプロイ先)
* https://living-location.herokuapp.com/
・テストアカウント
* mail: aaa@aaa.com
* pass: 66666666

## Description

omniAuthを用いたSNS認証で簡単にログインする事が出来ます。
生き物に関する写真投稿を行い記録されているGPS情報に基づいて被写体の撮影位置をGoogleMap上にピン表示します。
位置情報のない写真は地名を入力して頂き位置情報登録を行います。
indexに投稿画像が一覧表示されます。５件づつ新規順に表示され画像の右上プルダウンタグの詳細、又は画像右下のaddressリンクより詳細画面に遷移する事が出来ます。
詳細画面では、よりzoomレベルを絞った状態でmap表示されます。mapのピンをクリックして頂くとinfoウィンドウのGoogleMapリンクから新たに撮影位置のGoogleMapをひらくことが出来ます。
もちろんSNSらしくコメントで被写体の情報交換、いいねをつける事も出来ます。

## DEMO

![Image](/app/assets/images/testtest.gif)

## 制作背景
写真を通して生き物を知り、生き物を通して世界の事を知る。そんな場所があったら良いなと思い制作を　始めました。
動物や植物を見て名前が知りたくなった事は誰にでもある体験だと思います。
また、見た事ない世界中の動植物の写真に触れ、そのバックグラウンドに興味が広がる事もあります。
そんな興味や関心を世界中のユーザーと共有し、お互いの知識をリアルタイムで交換する事が出来ます。
wikipediaでは網羅し得ない四方山話を通じて世界の様々な環境、文化、経済、政治動向等を垣間見ること　が出来、更に被写体位置をMAP表示する事でユーザーのバックグラウンドに対する関心を引きだします。

## 工夫したポイント

SNSサインインで登録の手間を減らし、レイアウトデザインをシンプルにする事でパソコンが苦手な方でも直感的に操作が出来る様になっています。
投稿画像と一緒に地図が表示される事で、より世界との繋がりを実感して頂けると共にバックグラウンドに対する好奇心をかき立てます。

## 課題や今後実装したい機能

* 非同期化出来るところを非同期にしてページの表示を軽くする
* SNSログイン連携を増やす
* タグ機能
* 有用コメントに対するお礼機能
* お礼を貰った累積数でコメント信用度ランク表示機能
* 多言語対応

## DB設計

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|int||
|post_id|int||

### Association
- belongs_to :user
- belongs_to :post
- has_many :images, dependent: :destroy

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|str|null: false|
|post_id|int||
|comment_id|int||

### Association
- belongs_to :post
- belongs_to :comment, optional: true

## likesテーブル
|Column|Type|Options|
|------|----|-------|
|post_id|bigint||
|user_id|bigint||

### Association
- belongs_to :post
- belongs_to :user

## postsテーブル
|Column|Type|Options|
|------|----|-------|
|title|str||
|text|text||
|user_id|bigint||
|address|text||
|latitude|float||
|longitude|float||
|date_time|datetime||

### Association
- has_many :images, dependent: :destroy
- accepts_nested_attributes_for :images, allow_destroy: true
- has_many :comments, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :liked_users, through: :likes, source: :user
- belongs_to :user

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|str|default: "", null: false|
|encrypted_password|str|default: "", null: false|
|reset_password_token|str||
|nickname|str||
|provider|str||
|uid|str||

### Association
- has_many :posts
- has_many :comments
- has_many :likes
- has_many :liked_posts, through: :likes, source: :post
