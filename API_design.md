# URL design

## ユーザ登録

		post /user/register

		request body :
		{
			"email" : string, // use s.iwate-pu.ac.jp domain
			"password" : string,
			"first_name": string,
			"last_name" : string,
			"public_name": string 	// 公開用の名前
		}

		response body : {
			"status" : bool // true or false
		}

## my profile
### 取得

		get /user/:user_id

		response body :
		{
			"email": string,
			"public_name" : string,
			"user_name" : string,	// concat(last_name, first_name)
			"message" : string, // 自己紹介文
			"registered_interest" : [ // 自分が登録した趣味とそのカテゴリ
				{
					"category_id" : string,
					"category_name" : string,
					"interests" : {
						"interest_id" : int, // 趣味のID
						"interest_name" : string, // 趣味の名前
					}
				}
			]
		}

### 登録

		post /user/:user_id

		request body {
			"message" : string, // 自己紹介文
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
			"category_id" : string,
			"category_name" : string,
			"category_description" : string
		}

### 追加

		post /category

		request body : {
			"category_name" : string,
			"category_description" : string
		}

		response body : {
			"status" : true or false
		}

### 個別取得 (趣味の取得)

		get /category/:category_id

		response body : {
			"interest_id" : int, 	// 趣味id
			"interest_name" : string,	// 趣味の名前
			"interest_description" : string,	// 趣味の概要
			"members" : int 	// 参加人数
		}

## 興味(趣味)
### 登録

		post /category/:category_id/

		request body : {
			"interest_name" : string,	// 趣味の名前
			"interest_description" : string,	// 趣味の概要
		}

		response body : {
			"status" : true or false
		}

## チャンネル
### 一覧取得

		get /channel/:interest_id/
	    // 参加しているチャンネルの場合trueを返す

		response body : [ // array
			"channel_id" : int,
			"channel_name" : string,
			"channel_author" : string
			"belongs" : true or false 	// そのチャンネルに参加しているかしていないか(true or false)
		]

### チャンネル作成

		post /channel/:interest_id/
		// チャンネルを作成したい趣味のidを指定

		request body : {
			"channel_name" : string,
		}

		response body : {
			"status" : true or false
		}

### チャンネル参加

		get /channel/:channel_id/join

		response body : {
			"status" : true or false
		}
