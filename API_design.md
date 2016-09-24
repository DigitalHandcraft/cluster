# URL design

## ユーザ登録

		post /users/register

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

		get /users/:user_id

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

		get /categories

		response body : {
			"id" : int,
			"name" : string,
			"description" : string
		}

### 追加

		post /categories

		request body : {
			"category[name]" : string,
			"category[description]" : string
		}

		response body : {
			"status" : true or false
		}



## 興味(趣味)
### あるカテゴリに所属する興味(趣味)の取得

		get /categories/:id/interests

		response body : [
		{
			"id" : int, 	// 趣味id
			"name" : string,	// 趣味の名前
			"description" : string,	// 趣味の概要
			"members" : int 	// 参加人数
		},
		{ ... },
		{ ... }
		]

### あるカテゴリに所属する興味(趣味)の登録

		post /categories/:id/interests

		request body : {
			"interest_name" : string,	// 趣味の名前
			"interest_description" : string,	// 趣味の概要
		}

		response body : {
			"status" : true or false
		}

## チャンネル
### 一覧取得

	get /interests/:id/channels/
	//  趣味のidをinputし、outputとしてその趣味が持っているチャンネルの一覧を返す

	response body : [
		{ 
			"id" : int,
			"name" : string,	// チャンネルの名前
			"author" : string,	// チャンネルの作成者の名前
			"belongs" : true or false 	// そのチャンネルに参加しているかしていないか(true or false)
		},
		{ ... },
		{ ... }
	]

### チャンネル作成

	post /interests/:id/channels
	// チャンネルを作成したい趣味のidを指定

	request body : {
		"channel_name" : string,
	}

	response body : {
		"status" : true or false
	}

### チャンネル参加

	get /interests/:id/channels/join

	response body : {
		"status" : true or false
	}

## チャット関係 (web socketでもserve)

### 一覧取得(チャット履歴を取得)

	get /channels/:id/messages

	response body : [
		{
			"id" : int,	// メッセージ(チャット内の誰かの発言)自体のid
			"body" : string,	// メッセージ本体
			"user": string,	// 発言したユーザーの名前
			"created_at" : datetime,	// 発言した日時
			"updated_at" : datetime	// 更新された日時
		}
	]

### 登録 (チャットへの書き込み)	

	post /channels/:id/messages

	request body : {
		"body": string,	// 書き込み内容
	}
