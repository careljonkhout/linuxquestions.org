question = nil
IO.foreach '/home/carel/ror/linuxquestions/org/run/questions' do |line|
  if line =~ /^q/ 
    question = Question.new(:question => line[1..line.length])
    question.save false # disabling validations because there are no answers specified yet.
  elsif line =~ /^t/
    question.answers.create!(:answer => line[1..line.length], :correct => true)
  elsif line =~ /^f/
    question.answers.create!(:answer => line[1..line.length], :correct => false)
  end
end