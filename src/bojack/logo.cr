require "./version"

module BoJack
  class Logo
    def self.render
      logo = <<-'HERE'
             _|\ _/|_,
           ,((\\``-\\\\_
         ,(())      `))\
       ,(()))       ,_ \
      ((())'   |        \
      )))))     >.__     \
      ((('     /    `-. .c|
              /        `-`'
      BoJack VERSION - The unreliable key-value store
      HERE

     puts logo.gsub("VERSION", BoJack::VERSION)
    end
  end
end
