class Priority < ActiveHash::Base
  self.data = [
    { id: 1, name: '至急！' },
    { id: 2, name: '数日以内に買う' },
    { id: 3, name: '他の買い物のついでに' },
    { id: 4, name: 'そのうち買えればOK' },
    { id: 5, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :items

end