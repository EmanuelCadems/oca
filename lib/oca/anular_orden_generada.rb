class Oca::AnularOrdenGenerada < Oca::Base

  # a = Oca::AnularOrdenGenerada.new(IdOrdenRetiro: '38259537')
  def initialize(options = {})
    @IdOrdenRetiro = options[:IdOrdenRetiro]

    super(options)
  end

  def submit
    if valid?
      result = self.class.post(
        "/epak_tracking/Oep_TrackEPak.asmx",
        body: data
        )
      return unless result.body

      h = Hash.from_xml(result.body)
      h["Envelope"].try(:[], "Body").try(:[], "AnularOrdenGeneradaResponse")
    else
      false
    end
  end

  private
    def data
      body = <<-EOF
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:oca="#Oca_e_Pak">
   <soap:Header/>
   <soap:Body>
      <oca:AnularOrdenGenerada>
         <!--Optional:-->
         <oca:usr>#{@usr}</oca:usr>
         <!--Optional:-->
         <oca:psw>#{@pwd}</oca:psw>
         <oca:IdOrdenRetiro>#{@IdOrdenRetiro}</oca:IdOrdenRetiro>
      </oca:AnularOrdenGenerada>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
