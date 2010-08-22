question = nil
IO.foreach 'run/questions' do |line|
  if line =~ /^q/ 
    question = Question.new(:question => line[1..line.length-1])
    question.save false # disabling validations because there are no answers specified yet.
  elsif line =~ /^t/
    question.answers.create!(:answer => line[1..line.length-1], :correct => true)
  elsif line =~ /^f/
    question.answers.create!(:answer => line[1..line.length-1], :correct => false)
  end
end