require 'json'
require 'webrick'

class Session
  def initialize(req)
    request_cookie = req.cookies.select { |c| c.name == "_rails_lite_app" }.first
    if request_cookie.nil?
      @cookie = {}
    else
      @cookie = JSON.parse(request_cookie.value)
    end
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new("_rails_lite_app", @cookie.to_json)
  end
end

