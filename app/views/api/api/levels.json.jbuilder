json.array!(@levels) do |level|
    json.value(level.value)
    json.required_experience(level.sufficiency)
end
