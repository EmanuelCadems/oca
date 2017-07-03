#encoding=utf-8
class Oca::GetCentrosImposicion < Oca::Base

  # Oca::GetCentrosImposicion.new.submit
  def submit
    if valid?
      result = self.class.post(
        "/oep_tracking/Oep_Track.asmx",
        body: data
        )

      return unless result.body

      h = Hash.from_xml(result.body)
      h["Envelope"].try(:[], "Body").try(:[], "GetCentrosImposicionResponse")
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
      <oca:GetCentrosImposicion/>
   </soap:Body>
</soap:Envelope>
    EOF
    end
end
