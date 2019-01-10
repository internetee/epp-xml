require 'client_transaction_id'

class EppXml
  class Poll
    include ClientTransactionId

    XMLNS = "urn:ietf:params:xml:ns:epp-1.0".freeze

    def req(xml_params = {}, custom_params = {})
      build('req')
    end

    def ack(msg_id)
      build('ack', msgID: msg_id)
    end

    private

    def build(op, custom_params = {})
      xml = Builder::XmlMarkup.new

      xml.instruct!(:xml, standalone: 'no')
      xml.epp('xmlns' => XMLNS) do
        xml.command do
          xml.poll({op: op}.merge(custom_params))
          xml.clTRID(clTRID) if clTRID
        end
      end
    end
  end
end
