# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| first_name         | string | null: false |
| last_name          | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth              | date   | null: false |

- has_many :items
- has_many :orders

## items テーブル

| Column           | Type    | Options     |
| ---------------- | ------- | ----------- |
| name             | string  | null: false |
| price            | integer  | null: false |
| content          | text    | null: false |
| category_id      | integer | null: false |
| condition_id     | integer | null: false |
| cost_id          | integer | null: false |
| area_id          | integer | null: false |
| shipping_date_id | integer | null: false |
| user             | references | null: false, foreign_key: true |

- belongs_to :user
- has_one :order

## orders テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| item    | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item
- has_one :address

## address　テーブル

| Column       | Type　　 | Options  　 |
| ------------ | ------- | ----------- |
| postal_code  | string  | null: false |
| area_id      | integer | null: false |
| city         | string  | null: false |
| block        | string  | null: false |
| building     | string  |             |
| phone_number | string  | null: false |
| order        | references | null: false, foreign_key: true |

- belongs_to :order
