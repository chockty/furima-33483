# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization
# DATABASE設計

## usersテーブル

| Column                | Type       | Options                   |
| --------------------- | ---------- | ------------------------- |
| nickname              | string     | null: false               |
| email                 | string     | null: false, unique: true |
| password              | string     | null: false               |
| password_confirmation | string     | null: false               |
| full_name             | string     | null: false               |
| reading_name          | string     | null: false               |

### Association
-- has_many :items
-- has_many :purchases


## itemsテーブル

| Column                     | Type       | Options                        |
| -------------------------- | ---------- | ------------------------------ |
| name                       | string     | null: false                    |
| info                       | text       | null: false                    |
| item_category_id           | integer    | null: false                    |
| item_sales_status_id       | integer    | null: false                    |
| item_shipping_id           | integer    | null: false                    |
| item_prefecture_id         | integer    | null: false                    |
| item_scheduled_delivery_id | integer    | null: false                    |
| price                      | integer    | null: false                    |
| user                       | references | null: false, foreign_key :true |

### Association
-- has_many :purchases
-- belongs_to :user
-- belongs_to_active_hash :item_category_id
-- belongs_to_active_hash :item_shipping_id
-- belongs_to_active_hash :item_prefecture_id
-- belongs_to_active_hash :item_scheduled_delivery_id


## purchasesテーブル

| Column                     | Type       | Options                        |
| -------------------------- | ---------- | ------------------------------ |
| price                      | integer    | null: false                    |
| info                       | text       | null: false                    |
| postal_code                | integer    | null: false                    |
| prefecture_id              | integer    | null: false                    |
| city                       | string     | null: false                    |
| addresses                  | string     | null: false                    |
| building                   | string     | null: false                    |
| phone_number               | integer    | null: false                    |
| user                       | references | null: false, foreign_key :true |
| item                       | references | null: false, foreign_key :true |

### Association
-- belongs_to :item
-- belongs_to :user
-- belongs_to_active_hash :item_prefecture_id


* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
