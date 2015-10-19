json.role(@user.role)
json.name(@user.name)
json.cell(@user.experience)
json.recent_cell(@user.recent_experience)
json.statuses do
    json.array!(@user.statuses) do |status|
        json.category(status.category.name)
        json.level(status.level)
        json.recent_experience(status.recent_experience)
        json.experience(status.experience)
        json.next_level_required_experience()
    end
end

json.assigns do
    json.array!(@user.assigns) do |assign|
        json.mission_id(assign.mission_id)
        json.category(assign.mission.category)
        json.level(assign.mission.level.value)
        json.description(assign.mission.description)
        json.achievement(assign.achievement)
    end
end