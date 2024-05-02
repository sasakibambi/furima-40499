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

<!-- テーブル名にはsがつく。複数のデータが入るから。 -->

<!-- 登録 -->

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name_kana    | string | null: false               |
| date_of_birth      | date   | null: false               |

### Association

- has_many :items
- has_many :purchases
<!-- 複数形の時だけSがつく -->

## items table

<!-- 出品 -->

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| user                   | references | null: false, foreign_key: true |
| product_name           | string     | null: false                    |
| product_description    | text       | null: false                    |
| category_id            | integer    | null: false                    |
| product_condition_id   | integer    | null: false                    |
| shipping_fee_burden_id | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| shipping_day_id        | integer    | null: false                    |
| selling_price          | integer    | null: false                    |

### Association

- belongs_to :user
<!-- １つの商品は1人のユーザーによって出品されている（属している） -->
- has_one :purchase
  <!-- １つの商品は１回だけ購入できる（属している） -->
  <!-- itemがuserに属する　belongs_toに外部キーを書く -->
  <!-- 親の方のテーブルにhas_oneを書く -->

## purchases table

<!-- 購入管理テーブル　誰が何を -->

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

<!-- カラムは１つのデータが入るから単数系 -->

<!-- 外部キー　テーブル同士の結びつき  -->

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address
  <!-- 1対1 親がpurchases子が shipping_addresses -->
  <!-- 外部キーテーブル同士の結びつき　属する側に属される側のテーブル名_id | -->

## shipping_addresses table

<!-- 配送先 -->

| Column           | Type    | Options                        |
| ---------------- | ------- | ------------------------------ |
| purchase         | string  | null: false, foreign_key: true |
| post_code        | string  | null: false                    |
| prefecture_id    | integer | null: false                    |
| city_name        | string  | null: false                    |
| street_address   | string  | null: false                    |
| building_name    | string  |                                |
| telephone_number | string  | null: false                    |

### Association

- belongs_to: purchase
