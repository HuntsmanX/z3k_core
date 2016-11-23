class ParamsInflector

  def initialize app
    @app = app
  end

  def call env
    inflection = env["HTTP_X_KEY_INFLECTION"]

    if inflection && env["CONTENT_TYPE"] =~ /application\/json/
      underscore_params env
    end

    @app.call(env).tap do |_status, headers, response|
      if inflection && headers["Content-Type"] =~ /application\/json/
        response.each do |body|
          begin
            new_response = JSON.parse body
          rescue JSON::ParserError
            next
          end
          if inflection == "camel"
            if new_response.is_a? Array
              new_response.each{|element| element.deep_transform_keys! { |k| k.camelize(:lower) }}
            else
              new_response.deep_transform_keys! { |k| k.camelize(:lower) }
            end
          elsif inflection == "dash"
            new_response.deep_transform_keys! &:dasherize
          end

          body.replace(new_response.to_json)
        end
      end
    end
  end

  def underscore_params env
    rack_input = env["rack.input"].read
    if rack_input.present?
      request_body = JSON.parse rack_input
      request_body.deep_transform_keys! &:underscore

      req = StringIO.new(request_body.to_json)

      env["rack.input"]     = req
      env["CONTENT_LENGTH"] = req.length
    end
  end

end
