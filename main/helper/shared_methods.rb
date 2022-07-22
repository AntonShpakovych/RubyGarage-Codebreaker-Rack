# frozen_string_literal: true

module SharedMethod
  private

  def respond(page, status = 200)
    Rack::Response.new(render(page), status)
  end

  def render(template)
    path = File.expand_path("../../templates/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def redirect(page)
    Rack::Response.new { |response| response.redirect(page) }
  end
end
