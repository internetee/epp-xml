require 'client_transaction_id'

class EppXml
  class Contact
    include ClientTransactionId

    DEFAULT_SCHEMA_PREFIX = 'contact-ee'.freeze
    DEFAULT_SCHEMA_VERSION = '1.1'.freeze

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

    def transfer(xml_params = {}, op = 'query', custom_params = {})
      xml = Builder::XmlMarkup.new

      xml.instruct!(:xml, standalone: 'no')
      xml.epp('xmlns' => 'https://epp.tld.ee/schema/epp-ee-1.0.xsd') do
        xml.command do
          xml.transfer('op' => op) do
            xml.tag!('contact:transfer', 'xmlns:contact' => generate_path) do
              EppXml.generate_xml_from_hash(xml_params, xml, 'contact:')
            end
          end

          EppXml.custom_ext(xml, custom_params)
          xml.clTRID(clTRID) if clTRID
        end
      end
    end

    private

    def build(command, xml_params, custom_params)
      xml = Builder::XmlMarkup.new

      xml.instruct!(:xml, standalone: 'no')
      xml.epp('xmlns' => 'https://epp.tld.ee/schema/epp-ee-1.0.xsd') do
        xml.command do
          xml.tag!(command) do
            xml.tag!("contact:#{command}", 'xmlns:contact' => generate_path) do
              EppXml.generate_xml_from_hash(xml_params, xml, 'contact:')
            end
          end

          EppXml.custom_ext(xml, custom_params)
          xml.clTRID(clTRID) if clTRID
        end
      end
    end

    def generate_path
      prefix = schema_prefix || DEFAULT_SCHEMA_PREFIX
      version = schema_version || DEFAULT_SCHEMA_VERSION

      "https://epp.tld.ee/schema/#{prefix}-#{version}.xsd"
    end
  end
end
