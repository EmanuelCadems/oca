#encoding=utf-8
class Oca::GenerateQrByOrdenDeRetiro < Oca::Base

  # q = Oca::GenerateQrByOrdenDeRetiro.new(IdOrdenRetiro: 38619226)
  def initialize(options = {})
    @IdOrdenRetiro    = options[:IdOrdenRetiro]
    super(options)
  end

  def submit
    if valid?
      result = self.class.post(
        "/oep_tracking/Oep_Track.asmx",
        body: data
        )

      return unless result.body

      h = Hash.from_xml(result.body)
      h["Envelope"].try(:[], "Body").try(:[], "GenerateQrByOrdenDeRetiroResponse")
    else
      false
    end
  end

  private
    def data
      body = <<-EOF
<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:oca="#Oca_Express_Pak">
   <soap:Header/>
   <soap:Body>
      <oca:GenerateQrByOrdenDeRetiro>
         <!--Optional:-->
         <oca:usr>#{@usr}</oca:usr>
         <!--Optional:-->
         <oca:psw>#{@pwd}</oca:psw>
         <!--Optional:-->
         <oca:idOrdenDeRetiro>#{@IdOrdenRetiro}</oca:idOrdenDeRetiro>
      </oca:GenerateQrByOrdenDeRetiro>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
