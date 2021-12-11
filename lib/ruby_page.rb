class HtmlGenerator
  HTML_TEMPLATE = "
    <!DOCTYPE html>
    <html lang='en'>
      <head>
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1.0'>
        <title>Document</title>
      </head>
      <body>
        %s
      </body>
    </html>".freeze

  def initialize(content: nil, filename: 'index', bypass_html: false)
    @content = content
    @filename = filename
    @bypass_html = bypass_html
  end

  def generate_html
    File.open('index.html', 'w') { |f| f.write HTML_TEMPLATE % processed_content }
  end

  private

  def processed_content
    @content.gsub!(/[<>]/, '') if @bypass_html
    @content.is_a?(Array) ? @content.join : @content
  end
end
