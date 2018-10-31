1.1.1
* Reverts EPP XML schema namespace to "urn:ietf:params:xml:ns:epp-1.0"
* Reverts EPP XML schema contact-eis-1.0 replaced with contact-ee-1.1
1.1.0
* EPP XML schema namespace "urn:ietf:params:xml:ns:epp-1.0" replaced with "https://epp.tld.ee/schema/epp-ee-1.0.xsd"
* EPP XML schema contact-eis-1.0 replaced with contact-ee-1.1

1.0.5
* lib/epp-xml/domain.rb : all tag strings moved to class constants

* lib/epp-xml/domain.rb (delete method):
  - added extra argument for 'delete' action verification
  - deleted usage of 'build' method
  - added support for verification argument in method
  - added possibility for building 'delete' xml markup in method
