Item.create({ name: 'Smart Hub', price: 49.99 })
Item.create({ name: 'Motion Sensor', price: 24.99 })
Item.create({ name: 'Wireless Camera', price: 99.99 })
Item.create({ name: 'Smoke Sensor', price: 19.99 })
Item.create({ name: 'Water Leak Sensor', price: 14.99 })

PromoteCode.create({ name: '20%OFF', value: 20, ratio: true, promo_type: :uniq })
PromoteCode.create({ name: '5%OFF', value: 5, ratio: true, promo_type: :all })
PromoteCode.create({ name: '20POUNDSOFF', value: 20, ratio: false, promo_type: :all })