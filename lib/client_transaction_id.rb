module ClientTransactionId
  attr_accessor :cl_trid_prefix, :cl_trid, :schema_version, :schema_prefix

  def initialize(args = {})
    self.cl_trid = args[:cl_trid]
    self.cl_trid_prefix = args[:cl_trid_prefix]
    @schema_version = args[:schema_version]
    @schema_prefix = args[:schema_prefix]
  end

  def clTRID
    return nil if cl_trid == false
    return cl_trid if cl_trid
    return "#{cl_trid_prefix}-#{Time.now.to_i}" if cl_trid_prefix
    Time.now.to_i
  end

  def schema_version
    @schema_version
  end

  def schema_prefix
    @schema_prefix
  end
end
