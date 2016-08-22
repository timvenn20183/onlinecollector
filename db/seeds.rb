# some default sample data

site = Site.create(subdomain: 'test')
user = User.create(email: 'test@example.com', password: 'xxx', role: 1, site: site)

Fieldoption.create_from_string("Good,Bad,Excellent", Itemfield.last)
Fieldoption.create_from_string("Game,Book,Application",Itemfield.first)

Item.create(name: 'Thing', site: site, fieldoption_ids: [1,4])
