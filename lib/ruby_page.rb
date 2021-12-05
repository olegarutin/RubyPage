require 'nokogiri'

class HtmlGenerator
  def initialize(content: nil, filename: 'index', bypass_html: false)
    @content = content
    @filename = filename
    @bypass_html = bypass_html
  end

  def generate_html
    p @filename
    File.open("#{@filename}.html", 'w') do |file|
      builder = Nokogiri::HTML::Builder.new do |doc|
        doc.html {
          doc.head {
            doc.meta(charset: 'utf-8')
            doc.title('RubyPage')
          }
          doc.body(processed_content)
        }
      end

      file.write(builder.to_html)
    end
  end

  private

  def processed_content
    @bypass_html ? @content.gsub("<", "&lt;").gsub(">" "&gt;") : @content
  end
end
