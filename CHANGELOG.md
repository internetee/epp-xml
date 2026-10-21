Unreleased
* Add the optional `auto_renew:` keyword to domain create/update for preference changes and cycle reversal.
* Compose auto-renew with secDNS and EIS in one extension; auto-renew-only updates omit secDNS.
* Add auto-renew and RGP namespace constants and document login service-extension overrides; login defaults are unchanged.

1.2.0
* lib/epp-xml/epp-xml.rb
  - added additional attributes to set prefix and version of schema

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
