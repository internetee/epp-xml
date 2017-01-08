require 'client_transaction_id'

class EppXml
  class Domain
    include ClientTransactionId

    XMLNS         = 'https://epp.tld.ee/schema/epp-ee-1.0.xsd'.freeze

    XMLNS_DOMAIN  = 'https://epp.tld.ee/schema/domain-eis-1.0.xsd'.freeze

    XMLNS_SECDNS  = 'urn:ietf:params:xml:ns:secDNS-1.1'.freeze

    XMLNS_EIS     = 'https://epp.tld.ee/schema/ee-1.1.xsd'.freeze

    def info(xml_params = {}, custom_params = {})
      build('info', xml_params, custom_params)
    end

    def check(xml_params = {}, custom_params = {})
      build('check', xml_params, custom_params)
    end

    def renew(xml_params = {}, custom_params = {})
      build('renew', xml_params, custom_params)
    end

    def create(xml_params = {}, dnssec_params = {}, custom_params = {})
      xml = Builder::XmlMarkup.new

      xml.instruct!(:xml, standalone: 'no')
      xml.epp('xmlns' => XMLNS) do
        xml.command do
          xml.create do
            xml.tag!('domain:create', 'xmlns:domain' => XMLNS_DOMAIN) do
              EppXml.generate_xml_from_hash(xml_params, xml, 'domain:')
            end
          end

          xml.extension do
            xml.tag!('secDNS:create', 'xmlns:secDNS' => XMLNS_SECDNS) do
              EppXml.generate_xml_from_hash(dnssec_params, xml, 'secDNS:')
            end if dnssec_params.any?

            xml.tag!('eis:extdata',
              'xmlns:eis' => XMLNS_EIS) do
              EppXml.generate_xml_from_hash(custom_params, xml, 'eis:')
            end if custom_params.any?
          end if dnssec_params.any? || custom_params.any?

          xml.clTRID(clTRID) if clTRID
        end
      end
    end

    def update(xml_params = {}, dnssec_params = {}, custom_params = {})
      xml = Builder::XmlMarkup.new

      xml.instruct!(:xml, standalone: 'no')
      xml.epp('xmlns' => XMLNS) do
        xml.command do
          xml.update do
            xml.tag!('domain:update', 'xmlns:domain' => XMLNS_DOMAIN) do
              EppXml.generate_xml_from_hash(xml_params, xml, 'domain:')
            end
          end

          xml.extension do
            xml.tag!('secDNS:update', 'xmlns:secDNS' => XMLNS_SECDNS) do
              EppXml.generate_xml_from_hash(dnssec_params, xml, 'secDNS:')
            end

            xml.tag!('eis:extdata',
              'xmlns:eis' => XMLNS_EIS) do
              EppXml.generate_xml_from_hash(custom_params, xml, 'eis:')
            end if custom_params.any?
          end if dnssec_params.any? || custom_params.any?

          xml.clTRID(clTRID) if clTRID
        end
      end
    end

    def transfer(xml_params = {}, op = 'query', custom_params = {})
      xml = Builder::XmlMarkup.new

      xml.instruct!(:xml, standalone: 'no')
      xml.epp('xmlns' => XMLNS) do
        xml.command do
          xml.transfer('op' => op) do
            xml.tag!('domain:transfer', 'xmlns:domain' => XMLNS_DOMAIN) do
              EppXml.generate_xml_from_hash(xml_params, xml, 'domain:')
            end
          end

          EppXml.custom_ext(xml, custom_params)
          xml.clTRID(clTRID) if clTRID
        end
      end
    end

    def delete(xml_params = {}, custom_params = {}, verified = false)
      xml = Builder::XmlMarkup.new

      verified_option = verified ?  verified : 'no'

      xml.instruct!(:xml, standalone: 'no')
      xml.epp('xmlns' => XMLNS) do
        xml.command do
          xml.delete do
            xml.tag!("domain:delete", 'xmlns:domain' => XMLNS_DOMAIN, 'verified' => verified_option) do
              EppXml.generate_xml_from_hash(xml_params, xml, 'domain:')
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
      xml.epp('xmlns' => XMLNS) do
        xml.command do
          xml.tag!(command) do
            xml.tag!("domain:#{command}", 'xmlns:domain' => XMLNS_DOMAIN) do
              EppXml.generate_xml_from_hash(xml_params, xml, 'domain:')
            end
          end

          EppXml.custom_ext(xml, custom_params)
          xml.clTRID(clTRID) if clTRID
        end
      end
    end
  end
end
