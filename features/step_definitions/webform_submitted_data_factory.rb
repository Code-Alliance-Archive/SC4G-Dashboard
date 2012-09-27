class WebformSubmittedDataFactory
  def initialize()
    @skills = {
        "Product_Management" => 14,
        "Software_Development" => 14
    }

    @orgs = {
        "Benetech" => 18,
        "Code_for_America" => 18
    }

    @causes = {
        "Civic_Engagement" => 11,
        "Disaster_Relief" => 11
    }

    @languages = {
        "Java" => 13,
        "Perl" => 13
    }

    @time_to_commits = {
        "A_few_hours_per_week" => 19,
        "0_to_8_hours" => 19
    }

    @open_source_answers = {
      "yes" => 22,
      "no" => 22
    }


  end
  # To change this template use File | Settings | File Templates.
  def createSkillFromName(sid, name)
    cid = @skills[name]
    WebformSubmittedData.create({:nid=>5, :cid=>cid, :sid=>sid, :no=>0, :data=>name})
  end

  def createOrgFromName(sid, name)
    cid = @orgs[name]
    WebformSubmittedData.create({:nid=>5, :cid=>cid, :sid=>sid, :no=>0, :data=>name})
  end

  def createCauseFromName(sid, name)
    cid = @causes[name]
    WebformSubmittedData.create({:nid=>5, :cid=>cid, :sid=>sid, :no=>0, :data=>name})
  end

  def createLanguageFromName(sid, name)
    cid = @languages[name]
    WebformSubmittedData.create({:nid=>5, :cid=>cid, :sid=>sid, :no=>0, :data=>name})
  end

  def createTimeToCommitFromName(sid, name)
    cid = @time_to_commits[name]
    WebformSubmittedData.create({:nid=>5, :cid=>cid, :sid=>sid, :no=>0, :data=>name})
  end

  def createOpenSourceFromName(sid, name)
    cid = @open_source_answers[name]
    WebformSubmittedData.create({:nid=>5, :cid=>cid, :sid=>sid, :no=>0, :data=>name})
  end


end