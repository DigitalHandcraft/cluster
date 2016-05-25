# URL design

## ユーザ登録

	post /user/register

## my profile

	get /user/:user_id

## ログイン

	post /user/login

## カテゴリ
### 一覧取得

	Get /category

### 追加

	post /category

### 個別取得

	Get /category/:category_name

## 興味(趣味)
### 登録

	post /category/:category_name/:interest
   
## チャンネル
### 一覧取得

	get /channel(/:category_name/:interest)
    // 参加しているチャンネルの場合trueを返す

### チャンネル作成

	post /channel

### チャンネル参加

	post /chnnel/:channel_name/join
	