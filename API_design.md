# URL design

## ユーザ登録

	post /user/register

	request body : 
	{
		メールアドレス(s.iwate-pu)
		password
		first.last name
		公開用の名前

	}

	response body : {
		true or false
	}

## my profile
### 取得
	get /user/:user_id

	response body :
	{
		メールアドレス
		公開の名前
		名前
		自分が登録した趣味とそのカテゴリ

	}

### 登録
	post /user/:user_id

	request body {
		カテゴリ名
		カテゴリid
	
	}

	response body {
		"status": true or false
		
	}

## ログイン

	post /user/login

	request body : 
	{
		"email" : string, 
		"password": string
	}

	response body : {
		"status" : bool	// true or false
	}

## カテゴリ
### 一覧取得

	get /category

	response body : {
		カテゴリ名
		カテゴリid
		description

	}

### 追加

	post /category

	request body : {
		name
		discription
	}

	response body : {
		true or false
	}

### 個別取得

	get /category/:category_name

	response body : {
		id
		name
		description
		menmber’s
		(参加人数)
	}

## 興味(趣味)
### 登録

	post /category/:category_name/:interest

	request body : {

	}

	response body : {
		
	}
   
## チャンネル
### 一覧取得

	get /channel(/:category_name/:interest)
    // 参加しているチャンネルの場合trueを返す

	response body : {
		
	}

### チャンネル作成

	post /channel

	request body : {

	}

	response body : {
		
	}

### チャンネル参加

	post /chnnel/:channel_name/join

	request body : {

	}

	response body : {
		
	}
	
