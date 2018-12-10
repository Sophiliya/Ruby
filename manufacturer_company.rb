module ManufacturerCompany
  def set_company=(name)
    self.company_name = name
  end

  def get_company
    self.company_name
  end

  protected

  attr_accessor :company_name
end
