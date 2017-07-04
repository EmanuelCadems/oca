class Oca::IngresoOrMultiplesRetiros < Oca::Base

  # o = Oca::IngresoOrMultiplesRetiros.new(calle: 'La Rioja', nro: '300', piso: '', depto: '', cp: '1215', localidad: 'CAPITAL FEDERAL', provincia: 'CAPITAL FEDERAL', contacto: '', email: 'test@oca.com.ar', solicitante: '', observaciones: '', centrocosto: '', idfranjahoraria: '1', idcentroimposicionorigen: '0', fecha: '20151015', idoperativa: '276783', nroremito: 'Envio1', apellido: 'Fernandez', nombre: 'Martin', destinatario_calle: 'BALCARCE', destinatario_nro: '50', destinatario_piso:'', destinatario_depto: '', destinatario_localidad: 'CAPITAL FEDERAL', destinatario_provincia: 'CAPITAL FEDERAL', destinatario_cp: '1214', destinatario_telefono: '49569622', destinatario_email: 'test@oca.com.ar', destinatario_idci: '0', destinatario_celular: '1121877788', destinatario_observaciones: 'Prueba', alto: '10', ancho:'10', largo: '10', peso:'1', valor: '10', cant: '3' )
  def initialize(options = {})
    @nrocuenta                  = ENV['OCA_NROCUENTA']
    @calle                      = options[:calle]
    @nro                        = options[:nro]
    @piso                       = options[:piso]
    @depto                      = options[:depto]
    @cp                         = options[:cp]
    @localidad                  = options[:localidad]
    @provincia                  = options[:provincia]
    @contacto                   = options[:contacto]
    @email                      = options[:email]
    @solicitante                = options[:solicitante]
    @observaciones              = options[:observaciones]
    @centrocosto                = options[:centrocosto]
    @idfranjahoraria            = options[:idfranjahoraria]
    @idcentroimposicionorigen   = options[:idcentroimposicionorigen]
    @fecha                      = options[:fecha]
    @idoperativa                = options[:idoperativa]
    @nroremito                  = options[:nroremito]
    @apellido                   = options[:apellido]
    @nombre                     = options[:nombre]
    @destinatario_calle         = options[:destinatario_calle]
    @destinatario_nro           = options[:destinatario_nro]
    @destinatario_piso          = options[:destinatario_piso]
    @destinatario_depto         = options[:destinatario_depto]
    @destinatario_localidad     = options[:destinatario_localidad]
    @destinatario_provincia     = options[:destinatario_provincia]
    @destinatario_cp            = options[:destinatario_cp]
    @destinatario_telefono      = options[:destinatario_telefono]
    @destinatario_email         = options[:destinatario_email]
    @destinatario_idci          = options[:destinatario_idci] || "0"
    @destinatario_celular       = options[:destinatario_celular]
    @destinatario_observaciones = options[:destinatario_observaciones]
    @alto                       = options[:alto]
    @ancho                      = options[:ancho]
    @largo                      = options[:largo]
    @peso                       = options[:peso]
    @valor                      = options[:valor]
    @cant                       = options[:cant]

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
      h["Envelope"].try(:[], "Body").try(:[], "IngresoORMultiplesRetirosResponse")
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
      <oca:IngresoORMultiplesRetiros>
         <!--Optional:-->
         <oca:usr>#{@usr}</oca:usr>
         <!--Optional:-->
         <oca:psw>#{@pwd}</oca:psw>
         <!--Optional:-->
         <oca:xml_Datos><![CDATA[<?xml version="1.0" encoding="iso-8859-1" standalone="yes"?><ROWS><cabecera ver="2.0" nrocuenta="#{@nrocuenta}" /><origenes><origen calle="#{@calle}" nro="#{@nro}" piso="#{@piso}" depto="#{@depto}" cp="#{@cp}" localidad="#{@localidad}" provincia="#{@provincia}" contacto="#{@contacto}" email="#{@email}" solicitante="#{@solicitante}" observaciones="#{@observaciones}" centrocosto="#{@centrocosto}" idfranjahoraria="#{@idfranjahoraria}" idcentroimposicionorigen="#{@idcentroimposicionorigen}" fecha="#{@fecha}"> <envios><envio idoperativa="#{@idoperativa}" nroremito="#{@nroremito}"><destinatario apellido="#{@apellido}" nombre="#{@nombre}" calle="#{@destinatario_calle}" nro="#{@destinatario_nro}" piso="#{@destinatario_piso}" depto="#{@destinatario_depto}" localidad="#{@destinatario_localidad}" provincia="#{@destinatario_provincia}" cp="#{@destinatario_cp}" telefono="#{@destinatario_telefono}" email="#{@destinatario_email}" idci="#{@destinatario_idci}" celular="#{@destinatario_celular}" observaciones="#{@destinatario_observaciones}" /><paquetes><paquete alto="#{@alto}" ancho="#{@ancho}" largo="#{@largo}" peso="#{@peso}" valor="#{@valor}" cant="#{@cant}" /></paquetes></envio></envios></origen></origenes></ROWS>]]></oca:xml_Datos>
         <oca:ConfirmarRetiro>true</oca:ConfirmarRetiro>
         <!--Optional:-->
         <oca:ArchivoCliente></oca:ArchivoCliente>
         <!--Optional:-->
         <oca:ArchivoProceso></oca:ArchivoProceso>
      </oca:IngresoORMultiplesRetiros>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
