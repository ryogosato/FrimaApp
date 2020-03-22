class Item < ApplicationRecord 
  enum condition: {
    '新品、未使用':1, '未使用に近い':2, '目立った傷や汚れなし':3, 'やや傷や汚れあり':4, '傷や汚れあり':5, '全体的に状態が悪い':6 
  }
  enum fee: {
    '送料込み（出品者が負担）':1, '着払い（購入者が負担）':2
  }
  
  
  enum shipping_days: {
    '１〜２日後に発送':1,  '２〜３日後に発送':2,  '４〜７日後に発送':3
  }
  
  enum prefecture: {
    北海道:1, 青森県:2, 秋田県:3, 岩手県:4, 山形県:5, 宮城県:6, 福島県:7, 栃木県:8, 茨城県:9, 群馬県:10, 
    埼玉県:11, 東京都:12, 千葉県:13, 神奈川県:14, 新潟県:15, 長野県:16, 岐阜県:17, 石川県:18, 福井県:19, 富山県:20, 
    山梨県:21, 静岡県:22, 愛知県:23, 三重県:24, 滋賀県:25, 和歌山県:26, 奈良県:27, 京都府:28, 大阪府:29, 兵庫県:30, 
    岡山県:31, 鳥取県:32, 島根県:33, 広島県:34, 山口県:35, 香川県:36, 徳島県:37, 愛媛県:38, 高知県:39, 福岡県:40, 
    佐賀県:41, 長崎県:42, 大分県:43, 熊本県:44, 宮崎県:45, 鹿児島県:46, 沖縄県:47
  }

  belongs_to :brand, optional: true
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  belongs_to :category, optional: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
end
