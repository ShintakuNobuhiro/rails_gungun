json.name(@category.name)
json.levels do
  json.array!(@category.levels) do |level|
    missions = @category.missions.where(level_id: level.id)
    json.value(level.value)
    json.missions do
      json.array!(missions) do |mission|
        json.id(mission.id)
        json.description(mission.description)
      end
    end
  end
end

