require 'client_transaction_id'

class EppXml
  class DNS
    include ClientTransactionId

    XMLNS_DNS_EXT = "http://www.metaregistrar.com/epp/dns-ext-1.0".freeze

    def create(xml_params = {}, custom_params = {})
      build('create', xml_params, custom_params)
    end

    def check(xml_params = {}, custom_params = {})
      build('check', xml_params, custom_params)
    end

    def info(xml_params = {}, custom_params = {})
      build('info', xml_params, custom_params)
    end

    def delete(xml_params = {}, custom_params = {})
      build('delete', xml_params, custom_params)
    end

    def update(xml_params = {}, custom_params = {})
      build('update', xml_params, custom_params)
    end

    private

    def build(command, xml_params, custom_params)
      xml = Builder::XmlMarkup.new

      xml.instruct!(:xml, standalone: 'no')
      xml.epp do
        xml.command do
          xml.tag!(command) do
            xml.tag!("dns-ext:#{command}", 'xmlns:dns-ext' => XMLNS_DNS_EXT) do
              EppXml.generate_xml_from_hash(xml_params, xml, 'dns-ext:')
            end
          end

          EppXml.custom_ext(xml, custom_params)
          xml.clTRID(clTRID) if clTRID
        end
      end
    end
  end
end
