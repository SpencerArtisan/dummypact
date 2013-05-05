require 'roar_ext'

class Application
  include RoarExt::Domain::Hypermedia

  attr_accessor :page

  def initialize page = :home
    @page = page
  end

  relative_link :self do
    '/'
  end

end
