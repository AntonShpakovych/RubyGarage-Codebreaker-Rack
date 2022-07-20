# frozen_string_literal: true

module SharedMethod
  private

  def eror_404_not_found
    respond('404.html')
  end

  def respond(page)
    Rack::Response.new(render(page))
  end

  def render(template)
    path = File.expand_path("../../templates/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def redirect(page)
    Rack::Response.new { |response| response.redirect(page) }
  end
end
