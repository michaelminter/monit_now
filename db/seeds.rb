# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AccountType.create({
    data_limit: 100000000,
    name: 'Basic - 100 MB',
    price: 9.99,
    stripe_subscription_plan: 'basic-100MB-9-99'
                   })
AccountType.create({
     data_limit: 500000000,
     name: 'Standard - 500 MB',
     price: 39.99,
     stripe_subscription_plan: 'standard-500MB-39-99'
                   })
AccountType.create({
     data_limit: 100000000000,
     name: 'Advance - 1 GB',
     price: 79.99,
     stripe_subscription_plan: 'advance-1GB-79-99'
                   })
AccountType.create({
     data_limit: 200000000000,
     name: 'Professional - 2 GB',
     price: 179.99,
     stripe_subscription_plan: 'professional-2GB-179-99'
                   })
