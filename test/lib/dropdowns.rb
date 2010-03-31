class Dropdowns < Intervention::Dropdowns
  
  def priorities
    Priority.find(:all, :order => "name")
  end
  
end