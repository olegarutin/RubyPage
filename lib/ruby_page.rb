require 'nokogiri'

class HtmlGenerator
  def initialize(content: nil, filename: 'index', bypass_html: false)
    @content = content
    @filename = filename
    @bypass_html = bypass_html
  end

  def generate_html
    File.open("#{@filename}.html", 'w') do |file|
      builder = Nokogiri::HTML::Builder.new do |doc|
        doc.html do
          doc.head do
            doc.meta(charset: 'utf-8')
            doc.title('RubyPage')
          end
          doc.body { processed_content(doc) }
        end
      end

      file.write(builder.to_html)
    end
  end

  private

  def processed_content(doc)
    @content.gsub!(/[<>]/, '') if bypass_html
    @content.is_a?(Array) ? @content.each { |content| doc.p(content) } : doc.p(@content)
  end
end
