# some default sample data

site = Site.create(subdomain: 'test', title: 'Test collection')
user = User.create(email: 'test@example.com', password: encrypt('Testing123'), role: 1, site: site)

Fieldoption.create_from_string("Good,Bad,Excellent", Itemfield.last)
Fieldoption.create_from_string("Game,Book,Application",Itemfield.first)

Item.create(name: 'Thing 1', site: site, fieldoption_ids: [1,4])
Item.create(name: 'Thing 2', site: site, fieldoption_ids: [1,4])
