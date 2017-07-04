# Oca

This is an implementation of OCA web services 1.7 for ruby.

It was tested in ruby 2.1.2 and Rails 4

## Installation

Add this line to your application's Gemfile:

    gem 'oca'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oca

## Usage

Firt of all add the following environment variables:

```ruby
  OCA_EMAIL: your_account_email
  OCA_PASSWORD: your_password
  OCA_NROCUENTA: your_account_number
```
After doing that you can start playing out:

### Tarifar Envío Corporativo

```ruby
t = Oca::TarifarEnvioCorporativo.new(PesoTotal: 10, VolumenTotal: 1, CodigoPostalOrigen: 5500, CodigoPostalDestino: 5500, CantidadPaquetes: 4 , Cuit: '30-68419570-7', Operativa: '276783')

r = t.submit
r["Tarifar_Envio_CorporativoResult"]["diffgram"]["NewDataSet"]["Table"]["Total"].to_f
```

### GetHtmlEtiquetadora

```ruby
e = Oca::GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadora.new(IdOrdenRetiro: 38283012, nroEnvio: 2320800000000000087)
r = e.submit
File.open("mi_etiqueta.html", 'w') { |file| file.write(r["GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadoraResult"]) }
```
Then open in your browser mi_etiqueta.html

### GetPdfDeEtiquetasPorOrdenOrNumeroEnvio

```ruby
p = Oca::GetPdfDeEtiquetasPorOrdenOrNumeroEnvio.new(IdOrdenRetiro: 38283012, nroEnvio: 2320800000000000087, logisticaInversa: false)
r = p.submit
pdf = Oca::PdfUtil.new(name: 'my_pdf', content: r["GetPdfDeEtiquetasPorOrdenOrNumeroEnvioResult"])
pdf.convert
```
Then open my_pdf.pdf in your project's folder

### IngresoOrMultiplesRetiros

```ruby
o = Oca::IngresoOrMultiplesRetiros.new(calle: 'La Rioja', nro: '300', piso: '', depto: '', cp: '1215', localidad: 'CAPITAL FEDERAL', provincia: 'CAPITAL FEDERAL', contacto: '', email: 'test@oca.com.ar', solicitante: '', observaciones: '', centrocosto: '', idfranjahoraria: '1', idcentroimposicionorigen: '0', fecha: '20151015', idoperativa: '276783', nroremito: 'Envio1', apellido: 'Fernandez', nombre: 'Martin', destinatario_calle: 'BALCARCE', destinatario_nro: '50', destinatario_piso:'', destinatario_depto: '', destinatario_localidad: 'CAPITAL FEDERAL', destinatario_provincia: 'CAPITAL FEDERAL', destinatario_cp: '1214', destinatario_telefono: '49569622', destinatario_email: 'test@oca.com.ar', destinatario_idci: '0', destinatario_celular: '1121877788', destinatario_observaciones: 'Prueba', alto: '10', ancho:'10', largo: '10', peso:'1', valor: '10', cant: '3' )

y o.submit
```

### AnularOrdenGenerada

```ruby
a = Oca::AnularOrdenGenerada.new(IdOrdenRetiro: '38259537')
y a.submit
```
### TrackingEnvioEstadoActual

```ruby
t = Oca::TrackingEnvioEstadoActual.new(numeroEnvio: '2320800000000000089')
y t.submit
```

### And so on.

  All the services are similar. Just look for the implementation above the constructor in each class.

## Contributing

1. Fork it ( https://github.com/EmanuelCadems/oca/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request






