# some default sample data

site = Site.create(subdomain: 'test', title: 'Test collection')
user = User.create(email: 'test@example.com', password: encrypt('Testing123'), role: 1, site: site)

Fieldoption.create_from_string("Good,Bad,Excellent", Itemfield.last)
Fieldoption.create_from_string("Game,Book,Application",Itemfield.first)

(1..200).each do |i|
    Item.create(name: Faker::Space.star_cluster, site: site, collectionid: Faker::Code.asin, fieldoption_ids: [1,4,2,3], acquired_date: Faker::Date.between_except(20.year.ago, Date.today, Date.today))

end
