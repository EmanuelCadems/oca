class Oca::FileConverter
  def initialize(options = {})
    @name    = options[:name]
    @content = options[:content]
    @format  = options[:format] || 'pdf'
  end

  def convert
    File.open("#{@name}.#{@format}", 'wb') { |file| file.write(Base64.decode64(@content)) }
  end
end
