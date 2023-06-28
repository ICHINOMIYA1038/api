# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        #origins 'http://localhost:8000' # アクセスを許可するオリジンを指定します
        origins '*' # すべてのオリジンを許可します
        resource '*', headers: :any, methods: [:get, :delete ,:post,:patch] # 許可するHTTPメソッドとエンドポイントを指定します
    end
end
