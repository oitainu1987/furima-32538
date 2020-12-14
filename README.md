# テーブル設計

## users テーブル

| Column           | Type   | Options                  |
| ---------------- | ------ | ------------------------ |
| nickname         | string | null: false              |
| email            | string | null: false, unique: true|
| password         | string | null: false              |
| first_name       | string | null: false              |
| family_name      | string | null: false              |
| first_name_kana  | string | null: false              |
| family_name_kana | string | null: false              |
| birth_day        | date   | null: false              |

### Association

- has_many :items
- has_many :addresses

## items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| item_name    | string     | null: false                    |
| overview     | string     | null: false                    |
| category     | integer    | null: false                    |
| status       | integer    | null: false                    |
| delivery_fee | integer    | null: false                    |
| area         | integer    | null: false                    |
| period       | integer    | null: false                    |
| price        | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :purchase_record


## addresses テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefectures     | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| building        | string     |                                |
| tel             | integer    | null: false                    |
| purchase_record | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase

## purchase_records テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| item       | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :purchase_record


