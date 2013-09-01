require 'dbc-ruby'
DBC::token = "4b02bda17d6f8bcb564bf3addc26da75"
all_cohorts = DBC::Cohort.all

def twitter_handle(twitter_string)
  if twitter_string
    return twitter_string.gsub(/(.{20})(.+)/,"@" + '\2')
  else
    return nil
  end
end

all_cohorts.each do |cohort|
  current_cohort = Cohort.new(name: cohort.name, 
             location: cohort.location, 
             email: cohort.email,
             in_session: (1 if cohort.in_session == true) )
  if current_cohort.save
    cohort.students.each do |student|
      current_student = User.new(name: student.name,
                                    email: student.email,
                                    twitter: twitter_handle(student.profile[:twitter]),
                                    cohort_id: current_cohort.id)
      if current_student.save
        puts "#{student.name} added to the database as a member of the #{cohort.name}!"
      else
        puts "#{student.name} failed to save, here's why: #{current_student.errors.full_messages}"
      end
    end

    puts "#{cohort.name} added to database!"
  else
    puts "#{cohort.name} failed to save, here's why: #{current_cohort.errors.full_messages}"
  end
end


