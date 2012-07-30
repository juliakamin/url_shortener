require 'sinatra'
require 'sqlite3'

db = SQLite3::Database.new('url.db')


get '/new' do
  "<html>
    <body>
      <form action='/new' method='POST'>
        <input type='url' name='url' placeholder='Enter URL here'>
        <input type='submit' value='GO'>
      </form>
    </body>
  </html>"
end

post '/new' do
  new_url = []
  6.times do 
    new_url << ('A'..'Z').to_a.sample
  end
  db.execute("INSERT into urls values (?,?)", params[:url], new_url.join)
  "Your new URL is #{new_url.join} which redirects to #{params["url"]}"
end

get '/:short_url' do |url|
  result = db.execute("select url from urls where short = ?", url)
  destination_url = result[0][0]
  redirect(destination_url)
end

