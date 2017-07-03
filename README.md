# Oca

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'oca'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oca

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/oca/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request



Samples:


e = Oca::GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadora.new(IdOrdenRetiro: 38283012, nroEnvio: 2320800000000000087)
r = e.submit
File.open("mi_etiqueta.html", 'w') { |file| file.write(r["GetHtmlDeEtiquetasPorOrdenOrNumeroEnvioParaEtiquetadoraResult"]) }

Then open in your browser mi_etiqueta.html
