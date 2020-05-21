# Living-Location

投稿された写真の撮影場所をGoogleMapを使って位置表示する写真投稿SNS Webアプリケーション。

* Rails version:rails 5.2.4.1
* Ruby version
:ruby 2.5.1

## Description

omniAuthを用いたSNS認証で簡単にログインする事が出来ます。
生き物に関する写真投稿を行い記録されているGPS情報に基づいて被写体の撮影位置をGoogleMap上にピン表示します。
位置情報のない写真は地名を入力して頂き位置情報登録を行います。
indexに投稿画像が一覧表示されます。５件づつ新規順に表示され画像の右上プルダウンタグの詳細、又は画像右下のaddressリンクより詳細画面に遷移する事が出来ます。
詳細画面では、よりzoomレベルを絞った状態でmap表示されます。mapのピンをクリックして頂くとinfoウィンドウのGoogleMapリンクから新たに撮影位置のGoogleMapをひらくことが出来ます。
もちろんSNSらしくコメントで被写体の情報交換、いいねをつける事も出来ます。

## DEMO

![Image](https://cvws.icloud-content.com/B/Ab5txBzed1LYnuG03DmgiTiAGjoWAcQGLGXLm-cGTYqHnMvK0d9Y57FJ/testtest.gif?o=Aq8DTnLu8d-LoIne84RY9q5URZk-FzjgZ_d2wQsrYafk&v=1&x=3&a=CAoggma1bwvzP0HaBu2gvk6gy9sVZIUNwRs0LCTKw6AJtggSbxDgq_W-oy4YgKOsv6MuIgEAUgSAGjoWWgRY57FJaieSuIdVbTrm3bGbTp8d0zoHk8Rj7ULiniQTIcBap4sySdr_jxeBo2xyJ-LZl2cmK7e1WtNq6o38caHEUUzHEOzcLEHaPf_hNhu25i4PR7kkzQ&e=1590076051&fl=&r=4ce5121c-cb85-459c-8306-b2e784e6edab-1&k=yPw_z5duq-5SS8IQqqyNxg&ckc=com.apple.clouddocs&ckz=com.apple.CloudDocs&p=54&s=1QRwPRhzsCZe1uSq4EhIX3-vYxI&cd=i)