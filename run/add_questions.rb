question = nil
# must disable validate :must_have_an_answer in question.rb
IO.foreach 'questions' do |line| 
  if line =~ /^q/ 
    question = Question.create!(:question => line[1..line.length])
  elsif line =~ /^t/
    question.answers.create!(:answer => line[1..line.length], :correct => true)
  elsif line =~ /^f/
    question.answers.create!(:answer => line[1..line.length], :correct => false)
  end
end