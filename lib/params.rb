require 'uri'

class Params
  def initialize(req, route_params = {})
    @params = {}

    @params.merge!(route_params)
    @params.merge!(parse_www_encoded_form(req.body)) if req.body
    @params.merge!(parse_www_encoded_form(req.query_string)) if req.query_string
  end

  def [](key)
    @params[key.to_s]
  end

  def to_s
    @params.to_json.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  def parse_www_encoded_form(www_encoded_form)
    params = {}

    paramaters = URI::decode_www_form(www_encoded_form)
    paramaters.each do |key, value|
      scope = params

      this_key = parse_key(key)
      this_key.each_with_index do |key, index|
        if (index + 1) == this_key.count
          scope[key] = value
        else
          scope[key] ||= {}
          scope = scope[key]
        end
      end
    end

    params
  end

  def parse_key(key)
    key.split(/\]\[|\[|\]/)
  end
end
