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
      BoJack VERSION
      HERE
     
     puts logo.gsub("VERSION", BoJack::VERSION)
    end
  end
end
