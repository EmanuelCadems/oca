#encoding=utf-8
class Oca::GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadora < Oca::Base
  # e = Oca::GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadora.new(IdOrdenRetiro: 38283012, nroEnvio: 2320800000000000087)
  def initialize(options = {})
    @IdOrdenRetiro = options[:IdOrdenRetiro]
    @nroEnvio      = options[:nroEnvio]

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
      h["Envelope"].try(:[], "Body").try(:[], "GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadoraResponse")
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
      <oca:GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadora>
         <oca:idOrdenRetiro>#{@IdOrdenRetiro}</oca:idOrdenRetiro>
         <!--Optional:-->
         <oca:nroEnvio>#{@nroEnvio}</oca:nroEnvio>
      </oca:GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadora>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
