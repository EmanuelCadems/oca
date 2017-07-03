#encoding=utf-8
class Oca::TrackingOrdenRetiro < Oca::Base

  # t = Oca::TrackingOrdenRetiro.new(CUIT: '30-68419570-7', OrdenRetiro: '38313006')
  def initialize(options = {})
    @CUIT        = options[:CUIT]
    @OrdenRetiro = options[:OrdenRetiro]

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
      h["Envelope"].try(:[], "Body").try(:[], "Tracking_OrdenRetiroResponse")
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
      <oca:Tracking_OrdenRetiro>
         <!--Optional:-->
         <oca:CUIT>#{@CUIT}</oca:CUIT>
         <oca:OrdenRetiro>#{@OrdenRetiro}</oca:OrdenRetiro>
      </oca:Tracking_OrdenRetiro>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
