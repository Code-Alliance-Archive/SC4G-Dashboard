class WebformSubmittedDataFactory
  def initialize()
    @skills = {
        "Product_Management" => 14,
        "Software_Development" => 14
    }

  end
  # To change this template use File | Settings | File Templates.
  def createSkillFromName(sid, name)
    cid = @skills[name]
    WebformSubmittedData.create({:nid=>5, :cid=>cid, :sid=>sid, :no=>0, :data=>name})
  end
end