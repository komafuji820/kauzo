class Priority < ActiveHash::Base
  self.data = [
    { id: 1, name: '至急！' },
    { id: 2, name: '数日以内' },
    { id: 3, name: '何かのついでに' },
    { id: 4, name: 'そのうち' },
    { id: 5, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :items

end