# module StringExtensions
class String
  def slugify
    downcase.gsub('&', 'y').gsub('_', '-').parameterize.gsub(/[^0-9a-z-]+/i, '')
  end
end
