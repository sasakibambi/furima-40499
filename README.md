# README

<!--
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ... -->

# DB 設計

## users table

<!-- 登録 -->

| Column        | Type    | Options                   |
| ------------- | ------- | ------------------------- |
| nickname      | string  | null: false               |
| email         | string  | null: false, unique: true |
| password      | string  | null: false               |
| name          | string  | null: false               |
| name(kana)    | string  | null: false               |
| date_of_birth | integer | null: false               |

### Association

- has_many :items
- has_many :purchases
- has_many :shipping_addresses

## items table

<!-- 出品 -->

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user_id             | references | null: false, foreign_key: true |
| product_name        | string     | null: false                    |
| product_description | text       | null: false                    |
| category            | string     | null: false,                   |
| product_condition   | string     | null: false,                   |
| shipping_fee_burden | string     | null: false,                   |
| shipping_area       | string     | null: false,                   |
| shipping_days       | string     | null: false,                   |
| Selling_price       | integer    | null: false,                   |
| sales_commission    | integer    | null: false,                   |
| sales_profit        | integer    | null: false,                   |

### Association

- belongs_to :user
- has_many :purchases
<!-- itemがuserに属する　belongs_toに外部キーを書く -->

## purchase table

<!-- 購入 -->

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false                    |

<!-- 外部キー　テーブル同士の結びつき  -->

### Association

- belongs_to :user
- belongs_to :item
<!-- 外部キーテーブル同士の結びつき　属する側に属される側のテーブル名_id | -->

## shipping_address table

<!-- 配送先 -->

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user_id          | references | null: false, foreign_key: true |
| post_code        | integer    | null: false                    |
| prefectures      | string     | null: false                    |
| municipalities   | string     | null: false                    |
| street_address   | string     | null: false,                   |
| building_name    | string     | null: false,                   |
| street_address   | string     | null: false,                   |
| telephone_number | integer    | null: false,                   |

### Association

- belongs_to :user
