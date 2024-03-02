module AppPlugins
  def self.register(app)
    app.plugin :default_headers, 'Content-Type' => 'application/json; charset=utf-8'
    app.plugin :all_verbs
    app.plugin :hash_routes
    app.plugin :json
    
    app.plugin :not_found do
      response.status = 404

      { message: "The requested route was not found." }.to_json
    end

    app.plugin :error_handler do |e|
      response.status = 500

      { error: e.class.name, message: e.message }.to_json
    end
  end
end
