#encoding=utf-8
class Oca::TarifarEnvioCorporativo < Oca::Base

  # t = Oca::TarifarEnvioCorporativo.new(PesoTotal: 10, VolumenTotal: 1, CodigoPostalOrigen: 5500, CodigoPostalDestino: 5500, CantidadPaquetes: 4 , Cuit: '30-68419570-7', Operativa: '276783')
  def initialize(options = {})
    @PesoTotal           = options[:PesoTotal]
    @VolumenTotal        = options[:VolumenTotal]
    @CodigoPostalOrigen  = options[:CodigoPostalOrigen]
    @CodigoPostalDestino = options[:CodigoPostalDestino]
    @CantidadPaquetes    = options[:CantidadPaquetes]
    @Cuit                = options[:Cuit]
    @Operativa           = options[:Operativa]

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
      h["Envelope"].try(:[], "Body").try(:[], "Tarifar_Envio_CorporativoResponse")
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
      <oca:Tarifar_Envio_Corporativo>
         <!--Optional:-->
         <oca:PesoTotal>#{@PesoTotal}</oca:PesoTotal>
         <!--Optional:-->
         <oca:VolumenTotal>#{@VolumenTotal}</oca:VolumenTotal>
         <oca:CodigoPostalOrigen>#{@CodigoPostalOrigen}</oca:CodigoPostalOrigen>
         <oca:CodigoPostalDestino>#{@CodigoPostalDestino}</oca:CodigoPostalDestino>
         <oca:CantidadPaquetes>#{@CantidadPaquetes}</oca:CantidadPaquetes>
         <!--Optional:-->
         <oca:Cuit>#{@Cuit}</oca:Cuit>
         <!--Optional:-->
         <oca:Operativa>#{@Operativa}</oca:Operativa>
      </oca:Tarifar_Envio_Corporativo>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
