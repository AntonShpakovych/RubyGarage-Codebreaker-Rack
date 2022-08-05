# frozen_string_literal: true

module SharedMethod
  def respond(page, status = 200, **args)
    Rack::Response.new(render(page, **args), status)
  end

  def render(template, **args)
    layout = Tilt.new('main/templates/index.html.erb')
    page = Tilt.new("main/templates/partials/_#{template}")
    layout.render { page.render(Object.new, **args) }
  end

  def redirect(path)
    Rack::Response.new { |response| response.redirect(path) }
  end
end
