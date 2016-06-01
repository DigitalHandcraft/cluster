# URL design

## ユーザ登録

	post /user/register

	request body : {

	}

	response body : {

	}

## my profile

	get /user/:user_id

	response body : {
		
	}

## ログイン

	post /user/login

	request body : {

	}

	response body : {

	}

## カテゴリ
### 一覧取得

	get /category

	response body : {

	}

### 追加

	post /category

	request body : {

	}

	response body : {
		
	}

### 個別取得

	get /category/:category_name

	response body : {
		
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
	