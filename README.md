# テーブル設計

## users テーブル

| Column              | Type    | Options     |
| ------------------- | ------- | ----------- |
| email               | string  | null: false |
| password            | string  | null: false |
| family_name         | string  | null: false |
| first_name          | string  | null: false |
| family_name_reading | string  | null: false |
| first_name_reading  | string  | null: false |
| nickname            | string  | null: false |
| birthday            | date    | null: false |

### Association

-has_many :items
-has_many :purchase_records


## items テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| item_name | string     | null: false                    |
| price     | integer    | null: false                    |
| describe  | text       | null: false                    |
| category  | integer    | null: false                    |
| status    | integer    | null: false                    |
| area      | integer    | null: false                    |
| day       | integer    | null: false                    |
| fee       | integer    | null: false                    |
| user      | references | null: false, foreign_key: true |

### Association

-belongs_to :user
-has_one :purchase_record


## purchase_records テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

-belongs_to :user
-belongs_to :item
-has_one :address


## addresses テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| postal_code     | string     | null: false                    |
| prefecture      | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| tel_number      | string     | null: false                    |
| purchase_record | references | null: false, foreign_key: true |

### Association

-belongs_to :user
-belongs_to :item
-has_one :address