# API design

## ユーザ登録
request bodyに含まれているデータをText Filed等でユーザーに入力してもらい、それを以下のURLにPOSTすることでユーザー登録処理を行う。  
登録に成功した場合は、そのRequestのResponseとして`{status: true}`が返され、失敗した場合は、`{status: false}`が返ってくる。  

		post /users/register

		request body :
		{
			"email" : string, // ログイン時に使用するメールアドレス (use s.iwate-pu.ac.jp domain)
			"password" : string,	// ログイン時に使用するパスワード
			"name": string 	// 公開用(表示)の名前
		}

		response body : {
			"status" : bool // true or false
		}

## my profile
自分のプロフィールや相手のプロフィールを取得したり、登録・更新・削除するためのAPI.  

### 取得

		get /users/:user_id

		response body :
		{
			"email": string,	// 自分が登録したメールアドレス(いずれは公開・非公開の設定もできたほうが良い)
			"name" : string,  // 公開用の名前
			"message" : string, // 自己紹介文(簡単なメッセージ等を任意で設定できる)
			"registered_interest" : [ // 自分が登録した趣味とそのカテゴリの配列
				{
					"id" : string,	// 自分が登録した趣味が属しているカテゴリのid
					"name" : string,	// 自分が登録した趣味が属しているカテゴリの名前
					"interests" : [	// このカテゴリに所属する登録した趣味の配列
						{
							"id" : int, // 趣味のID
							"name" : string, // 趣味の名前
						},
						{ ... },
						{ ... }
					]
				}
			]
		}

### 登録(更新)
初めに、登録した情報を更新するためのAPI  

		post /user/:user_id

		request body {
			"name": string,		// 公開用の名前
			"message" : string, // 自己紹介文
		}

		response body {
			"status": true or false
		}

## ログイン
ログイン時に使用するAPI.  

		post /user/login

		request body :
		{
			"email" : string,		// ログイン時に使用するメールアドレス	
			"password": string	// ログイン時に使用するパスワード
		}

		response body : {
			"status" : bool	// ログイン成功時 : true, ログイン失敗 : false
		}

## カテゴリ
趣味が属しているカテゴリの取得や登録を行うためのAPI.  
ユーザーが自分の趣味を登録したり、他の趣味を閲覧してりするときに使用。  

### 一覧取得
データベースに登録されている趣味のカテゴリの一覧を取得するapi  

		get /categories

		response body : {
			"id" : int,
			"name" : string,
			"description" : string
		}

### 追加
新たにカテゴリを追加するためのAPI  
自分が登録したい趣味のカテゴリが存在しない時などに使用。  

		post /categories

		request body : {
			"category[name]" : string,
			"category[description]" : string
		}

		response body : {
			"status" : true or false
		}


## 興味(趣味)
データベースに格納されている趣味を取得したり、登録・更新・削除するためのAPI.  
ユーザーが、自分の趣味を登録するときや、他の趣味を検索する際に使用。  

### あるカテゴリに所属する興味(趣味)の取得
URLにカテゴリのidを付加させることによって、そのカテゴリに所属する趣味だけをjson形式で返す。  

		get /categories/:id/interests

		response body : [	// objectの配列
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
登録したい趣味が所属するカテゴリを指定するためには、そのカテゴリのidをURLの:idで指定する。  
例えば、`/categories/3/interests`に、interest[name]として "Java", interest[description]として "Java言語全般"というデータをPOSTしたとすると、"Java"という趣味は、IDが3のカテゴリ(プログラミング等)に所属するという意味になる。   

		post /categories/:id/interests

		request body : {
			"interest[name]" : string,	// 趣味の名前
			"interest[description]" : string,	// 趣味の概要
		}

		response body : {
			"status" : true or false
		}

## チャンネル
ある趣味に所属するチャンネルの一覧を取得したり、登録・更新・削除するためのAPI.  
(ここでは、一つの趣味を一つのチャットルームと見て、チャンネルとはさらにそのチャットルーム内におけるトピック等のことを指す(例えば、Javaという趣味の中で、"Androidアプリ開発"について話すチャンネルや"ソフトウェア演習 Java"について話すチャンネルなどがあるイメージ))  

### 一覧取得
趣味のidをinputし、outputとしてその趣味が持っているチャンネルの一覧を返す  

	get /interests/:id/channels/

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
URLで指定したidの趣味(チャットルーム)に新たなチャンネル(トピック)を追加する  

	post /interests/:id/channels
	// チャンネルを作成したい趣味のidを指定

	request body : {
		"channel[name]" : string,
	}

	response body : {
		"status" : true or false
	}

### チャンネル参加
現段階では保留.  

	get /interests/:id/channels/join

	response body : {
		"status" : true or false
	}

## チャット関係 (web socketでもserve)
チャンネル内でのチャット(会話)を保存したり、閲覧したりするためのHTTP API.  
チャットはリアルタイムで進行されるのが望ましいので、それを実現できる Web Socket通信を利用してチャットデータのやり取りを行うが、
ここではテストのため、またチャットの履歴をすべて取得するためなどの用途に対応するためHTTPでも APIを提供する。  

### 一覧取得(チャット履歴を取得)
どのチャンネルのチャット履歴がほしいかは、URLの`:id`で指定する

	get /channels/:id/messages

	response body : [
		{
			"id" : int,	// メッセージ(チャット内の誰かの発言)自体のid
			"body" : string,	// メッセージ本体
			"user": string,	// 発言したユーザーの名前
			"created_at" : datetime,	// 発言した日時
			"updated_at" : datetime	// 更新された日時
		},
		{ ... },
		{ ... }
	]

### 登録 (チャットへの書き込み)	
どのチャンネルに発言するかは、URLの`:id`で指定する。

	post /channels/:id/messages

	request body : {
		"body": string,	// 書き込み内容
	}
