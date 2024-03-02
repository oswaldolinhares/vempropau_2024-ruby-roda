require_relative '../config/application'

class App < Roda
  AppPlugins.register(self)

  route do |r|
    Routes.register(r)
  end 
end
