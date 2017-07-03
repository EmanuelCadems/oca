#encoding=utf-8
class Oca::GetCentroCostoPorOperativa < Oca::Base

  # c = Oca::GetCentroCostoPorOperativa.new(CUIT: '30-68419570-7', Operativa: '276783')
  def initialize(options = {})
    @CUIT      = options[:CUIT]
    @Operativa = options[:Operativa]

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
      h["Envelope"].try(:[], "Body").try(:[], "GetCentroCostoPorOperativaResponse")
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
      <oca:GetCentroCostoPorOperativa>
         <!--Optional:-->
         <oca:CUIT>#{@CUIT}</oca:CUIT>
         <oca:Operativa>#{@Operativa}</oca:Operativa>
      </oca:GetCentroCostoPorOperativa>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
