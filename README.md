# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| name               | string | null: false               |
| nickname           | string | null: false               |

### Association

- has_many :user_groups
- has_many :groups, through: :user_groups
- has_many :item_memos
- has_many :order_memos

## groups テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :user_groups
- has_many :users, through: :user_groups
- has_many :items
- has_many :orders

## user-groups テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| group  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :group

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| image       |            |                                |
| content     | text       |                                |
| category_id | integer    | null: false                    |
| group       | references | null: false, foreign_key: true |

### Association

- belongs_to :group
- belongs_to :category
- has_many :item_memos

## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| image       |            |                                |
| content     | text       |                                |
| category_id | integer    | null: false                    |
| group       | references | null: false, foreign_key: true |

### Association

- belongs_to :group
- belongs_to :category
- has_many :order_memos

## item_memos テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| content     | text       |                                |
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## order_memos テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| content     | text       |                                |
| user        | references | null: false, foreign_key: true |
| order       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :order