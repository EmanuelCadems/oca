class Oca::PdfUtil
  def initialize(options = {})
    @name    = options[:name]
    @content = options[:content]
  end

  def convert
    File.open("#{@name}.pdf", 'wb') { |file| file.write(Base64.decode64(@content)) }
  end
end
