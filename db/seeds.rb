# coding: utf-8
User.create!(
  [
    {
      nickname: 'taro',
      email: 't1@taro.com',
      first_name: '太郎',
      last_name: '山田',
      furigana_first: 'タロウ',
      furigana_last: 'ヤマダ',
      birthdate: '2010-07-11',
      tell: '00000000000',
      password: "taro123"
    },
    {
      nickname: 'jiro',
      email: 'te2@jiro.com',
      first_name: '二郎',
      last_name: '山田',
      furigana_first: 'ジロウ',
      furigana_last: 'ヤマダ',
      birthdate: '2010-06-11',
      tell: '00000000000',
      password: "jiro123"
    },
    {
      nickname: 'ichiro',
      email: 'tes3@ichiro.com',
      first_name: '一郎',
      last_name: '山田',
      furigana_first: 'イチロウ',
      furigana_last: 'ヤマダ',
      birthdate: '2010-08-11',
      tell: '00000000000',
      password: "ichiro1"
    },
    {
      nickname: 'saburo',
      email: 'test4@saburo.com',
      first_name: '三郎',
      last_name: '山田',
      furigana_first: 'サブロウ',
      furigana_last: 'ヤマダ',
      birthdate: '2010-07-11',
      tell: '00000000000',
      password: "saburo1"
    },
  ]
)
Brand.create!(
  [
    {
      name: 'NIKE'
    },
    {
      name: 'GUCCI'
    },
    {
      name: 'ADDIDAS'
    },
    {
      name: 'LACOSTE'
    },
    {
      name: 'PUMA'
    },
    {
      name: 'CONVERSE'
    },
  ]
)
require './db/seeds/category.rb'
Item.create!(
  [
    {
      name: 'パーカー',
      description: 'パーカーです',
      price: 1000,
      condition: 1,
      fee: 1,
      area: "長崎県",
      shipping_days: 1,
      purchase_id: 2,
      brand_id: 1,
      user_id: 1,
      category_id: 33,
    },
    {
      name: 'ワンピース',
      description: 'ワンピースです',
      price: 3000,
      condition: 3,
      fee: 2,
      area: "佐賀県",
      shipping_days: 3,
      purchase_id: '',
      brand_id: 2,
      user_id: 1,
      category_id: 78,
    },
    {
      name: '靴',
      description: '靴です',
      price: 4000,
      condition: 2,
      fee: 2,
      area: "福岡県",
      shipping_days: 2,
      purchase_id: 2,
      brand_id: 3,
      user_id: 1,
      category_id: 84,
    },
    {
      name: '子供服',
      description: '子供服です',
      price: 5000,
      condition: 6,
      fee: 1,
      area: "大分県",
      shipping_days: 1,
      purchase_id: '',
      brand_id: 4,
      user_id: 2,
      category_id: 153,
    },
    {
      name: 'スカート',
      description: 'スカートです',
      price: 6000,
      condition: 4,
      fee: 1,
      area: "広島県",
      shipping_days: 3,
      purchase_id: 1,
      brand_id: 5,
      user_id: 3,
      category_id: 73,
    },
    {
      name: 'バッグ',
      description: 'バッグです',
      price: 2000,
      condition: 5,
      fee: 2,
      area: "沖縄県",
      shipping_days: 3,
      purchase_id: '',
      brand_id: 6,
      user_id: 4,
      category_id: 83,
    },
  ]
)

Image.create!(
  [
    {
      content: File.open('app/assets/images/clothes1.jpeg'),
      item_id: 1,
    },
    {
      content: File.open('app/assets/images/clothes3.jpeg'),
      item_id: 2,
    },
    {
      content: File.open('app/assets/images/clothes4.jpeg'),
      item_id: 3,
    },
    {
      content: File.open('app/assets/images/clothes5.jpeg'),
      item_id: 4,
    },
    {
      content: File.open('app/assets/images/clothes6.jpeg'),
      item_id: 5,
    },
    {
      content: File.open('app/assets/images/clothes7.jpeg'),
      item_id: 6,
    },
  ]
)

