training_plans = TrainingPlan.names.values.map { |value| TrainingPlan.create name: value }

training_plans.each do |training_plan|
   (1..5).each do |i|
      name = "Training-#{i} (#{training_plan.name})"
      Training.create({
        name: name,
        description: "#{name} description",
        start_time: "2018-03-#{i} 10:00:00",
        training_plan: training_plan
      })
   end
end
