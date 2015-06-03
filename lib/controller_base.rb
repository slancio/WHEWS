require 'active_support'
require 'active_support/core_ext'
require 'erb'

class ControllerBase
  attr_reader :req, :res, :params

  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @already_built_response = false
    @params = Params.new(req, route_params)
  end

  def already_built_response?
    @already_built_response
  end

  def redirect_to(url)
    if already_built_response?
      raise Exception
    else
      res.status = 302
      res['location'] = url
      @already_built_response = true
    end

    session.store_session(res)
  end

  def render_content(content, content_type)
    if already_built_response?
      raise Exception
    else
      res.content_type = content_type
      res.body = content
      @already_built_response = true
    end

    session.store_session(res)
  end

  def render(template_name)
    file = ""
    File.foreach("views/#{self.class.name.underscore}/#{template_name}.html.erb") do |line|
      file << "#{line}"
    end

    template = ERB.new(file)
    render_content(template.result(binding), "text/html")
  end

  def session
    @session ||= Session.new(req)
  end

  def invoke_action(name)
    self.send(name)
    render(name) unless already_built_response?

    nil
  end
end
