# ぐんぐん API仕様書 v.0.1

URL https://xxx.herokuapp.com/ (未定)

## 1.ユーザー個人の情報

トップ画面に必要
```
POST /api/users/:card_number.json
```

送信データ(HTTP)
```
password=qwerty123
```

送信データ(JSON)
```
{ "password": "qwerty123" }
```

curlコマンドの例
```
$ curl -X POST -H "Content-type: application/json" -d '{"password":"qwerty123"}' http://localhost:3000/api/users/abcdef123456.json
```

応答
```
{
    "role":"student",
    "nick_name":"あおもりはなこ",
    "recent_cell": 20,
    "cell": 26,
    "statuses": [
        {
            "category":"健康",
            "level": 1,
            "recent_experience": 10,
            "experience": 16,
            "next_level_required_experience": 50
        },
        {
            "category":"お友達・あいさつ",
            "level": 1,
            "recent_experience": 8,
            "experience": 12,
            "next_level_required_experience": 50
        }
    ],
    "assigns": [
        {
            "mission_id": 1,
            "category":"健康",
            "level": 2,
            "description":"手を洗う"
        },
        {
            "id": 4,
            "category":"お友達・あいさつ",
            "level": 2,
            "description":"あいさつをする"
        }
    ]
}
```

例外

ユーザーが存在しない場合
```
{ "error":"404 Not Found","detail":"user not found with card_number=abcdef123456" }
```
パスワードが間違っている場合
```
{ "error":"404 Not Found","detail":"invalid password" }
```

## 2.ミッションの一覧取得

ミッション小項目設定に必要
```
POST /api/categories/:category_id.json
```

送信データ(HTTP)
```
card_number=abcdef123456
password=qwerty123
```

送信データ(JSON)
```
{ "card_number":"abcdef123456","password":"qwerty123" }
```

curlコマンドの例
```
$ curl -X POST -H "Content-type: application/json" -d '{"card_number":"abcdef123456","password":"qwerty123"}' http://localhost:3000/api/categories/1.json
```

応答
```
{
    "name": "健康",
    "levels": [
        {
            "value": 1,
            "missions": [
                    { "id": 1, "description": "ああああ" },
                    { "id": 2, "description": "いいいい" },
                    { "id": 3, "description": "うううう" },
                    { "id": 4, "description": "ええええ" },
                    ….
                    { "id": 9, "description": "おおおお" }
            ]
        },
        {
            "value": 2,
            "missions": [
                    { "id": 10, "description": "かかかか" },
                    { "id": 11, "description": "きききき" },
                    { "id": 12, "description": "くくくく" },
                    ….
                    { "id": 13, "description": "けけけけ" }
            ]
        }
    ]
}
```

例外

ユーザーが存在しない場合
```
{ "error":"404 Not Found","detail":"user not found with card_number=abcdef123456" }
```
パスワードが間違っている場合
```
{ "error":"404 Not Found","detail":"invalid password" }
```
カテゴリーが存在しない場合
```
{ "error":"404 Not Found","detail":"category not found with category_id=1" }
```

## 3.ミッションの設定
```
POST /api/assigns.json
```

送信データ(HTTP)
```
card_number=abcdef123456
password=qwerty123
mission_ids[]=20
mission_ids[]=18
```

送信データ(JSON)

```
{"card_number":"abcdef123456", "password":"qwerty123", "missions_ids": [20, 18] }
```

curlコマンドの例
```
$ curl -X POST -H "Content-type: application/json" -d '{"card_number":"abcdef123456", "password":"qwerty123", "missions_ids": [20, 18]}' http://localhost:3000/api/assigns.json
```

応答
```
{ "card_number":"abcdef123456", "missions_ids": [20, 18] }
```

例外

ユーザーが存在しない場合
```
{ "error":"404 Not Found","detail":"user not found with card_number=abcdef123456" }
```
パスワードが間違っている場合
```
{ "error":"404 Not Found","detail":"invalid password" }
```
ミッションが存在しない場合
```
{ "error":"404 Not Found","detail":"missions not found with mission_ids=20,18" }
```

## 4.ミッションの達成
```
POST /api/histories.json
```

送信データ(HTTP)
```
card_number=abcdef123456
password=qwerty123
mission_ids[]=20
mission_ids[]=18
```

送信データ(JSON)

```
{"card_number":"abcdef123456", "password":"qwerty123", "missions_ids": [20, 18] }
```

curlコマンドの例
```
$ curl -X POST -H "Content-type: application/json" -d '{"card_number":"abcdef123456", "password":"qwerty123", "missions_ids": [20, 18]}' http://localhost:3000/api/histories.json
```

応答
```
{ "card_number":"abcdef123456", "missions_ids": [20, 18] }
```



例外

ユーザーが存在しない場合
```
{ "error":"404 Not Found","detail":"user not found with card_number=abcdef123456" }
```
パスワードが間違っている場合
```
{ "error":"404 Not Found","detail":"invalid password" }
```
ミッションが割り振られていない場合
```
{ "error":"404 Not Found","detail":"missions are not assigned with mission_ids=20,18" }
```

## 5.ユーザーのすごろく情報(今回分)

ユーザー情報を参照する

## 6.対応したURLが存在しない場合の例外
```
{"error":"404 Not Found","detail":"routing error"}
```

