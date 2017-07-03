#encoding=utf-8
class Oca::TrackingEnvioEstadoActual < Oca::Base

  # t = Oca::TrackingEnvioEstadoActual.new(numeroEnvio: '2320800000000000089')
  def initialize(options = {})
    @numeroEnvio  = options[:numeroEnvio]

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
      h["Envelope"].try(:[], "Body").try(:[], "TrackingEnvio_EstadoActualResponse")
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
      <oca:TrackingEnvio_EstadoActual>
         <!--Optional:-->
         <oca:numeroEnvio>#{@numeroEnvio}</oca:numeroEnvio>
      </oca:TrackingEnvio_EstadoActual>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
