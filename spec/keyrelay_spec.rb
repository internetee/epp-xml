require 'spec_helper'

describe EppXml::Keyrelay do
  it 'generates valid keyrelay xml' do
    expected = Nokogiri::XML('<?xml version="1.0" encoding="UTF-8" standalone="no"?>
      <epp xmlns="urn:ietf:params:xml:ns:epp-1.0"
      xmlns:secDNS="urn:ietf:params:xml:ns:secDNS-1.1"
      xmlns:domain="urn:ietf:params:xml:ns:domain-1.0"
      xmlns:ext="urn:ietf:params:xml:ns:keyrelay-1.0">
        <extension>
          <ext:command>
            <ext:keyrelay>
              <ext:name>example.org</ext:name>
              <ext:keyData>
                 <secDNS:flags>256</secDNS:flags>
                 <secDNS:protocol>3</secDNS:protocol>
                 <secDNS:alg>8</secDNS:alg>
                 <secDNS:pubKey>cmlraXN0aGViZXN0</secDNS:pubKey>
              </ext:keyData>
              <ext:authInfo>
                 <domain:pw>JnSdBAZSxxzJ</domain:pw>
              </ext:authInfo>
              <ext:expiry>
                 <ext:relative>P1M13D</ext:relative>
              </ext:expiry>
            </ext:keyrelay>
            <ext:clTRID>ABC-12345</ext:clTRID>
          </ext:command>
        </extension>
      </epp>
    ').to_s.squish

    xml = EppXml::Keyrelay.keyrelay({
      name: { value: 'example.org' },
      keyData: {
        flags: { value: '256' },
        protocol: { value: '3' },
        alg: { value: '8' },
        pubKey: { value: 'cmlraXN0aGViZXN0' }
      },
      authInfo: {
        pw: { value: 'JnSdBAZSxxzJ' }
      },
      expiry: {
        relative: { value: 'P1M13D' }
      }
    })

    generated = Nokogiri::XML(xml).to_s.squish
    expect(generated).to eq(expected)
  end

  it 'generates minimal keyrelay xml' do
    expected = Nokogiri::XML('<?xml version="1.0" encoding="UTF-8" standalone="no"?>
      <epp xmlns="urn:ietf:params:xml:ns:epp-1.0"
      xmlns:secDNS="urn:ietf:params:xml:ns:secDNS-1.1"
      xmlns:domain="urn:ietf:params:xml:ns:domain-1.0"
      xmlns:ext="urn:ietf:params:xml:ns:keyrelay-1.0">
        <extension>
          <ext:command>
            <ext:keyrelay>
              <ext:name>example.org</ext:name>
              <ext:keyData>
                 <secDNS:flags>256</secDNS:flags>
                 <secDNS:protocol>3</secDNS:protocol>
                 <secDNS:alg>8</secDNS:alg>
                 <secDNS:pubKey>cmlraXN0aGViZXN0</secDNS:pubKey>
              </ext:keyData>
              <ext:authInfo>
                 <domain:pw>JnSdBAZSxxzJ</domain:pw>
              </ext:authInfo>
            </ext:keyrelay>
            <ext:clTRID>ABC-12345</ext:clTRID>
          </ext:command>
        </extension>
      </epp>
    ').to_s.squish

    xml = EppXml::Keyrelay.keyrelay({
      name: { value: 'example.org' },
      keyData: {
        flags: { value: '256' },
        protocol: { value: '3' },
        alg: { value: '8' },
        pubKey: { value: 'cmlraXN0aGViZXN0' }
      },
      authInfo: {
        pw: { value: 'JnSdBAZSxxzJ' }
      }
    })

    generated = Nokogiri::XML(xml).to_s.squish
    expect(generated).to eq(expected)
  end
end