require 'yaml'

def extract_nested_arrays_from_hah(element)
  result_of_arrays =[]
  element.each do |key, value|
    if value.class == Array
      result_of_arrays << value
    end
  end
  result_of_arrays.flatten
  return result_of_arrays.flatten
  raise
end


def is_nil(key, value, index, element_name)
  errors_array =[]
  if key == 'reference' && value.nil?
      errors_array << "There is a #{key} in one of #{element_name} which not defined (nil)"
  elsif key == 'label' && value.nil?
      errors_array << "There is a #{key} in one of #{element_name} which not defined (nil)"
  elsif key == 'content' && value.nil?
    errors_array << "There is a #{key} in one of #{element_name} which not defined (nil)"
    end
end

def is_empty(key, value, index, element_name)
  errors_array =[]
  if key == 'reference' && value.empty?
      errors_array << "There is a #{key} in one of #{element_name} which not defined (empty)"
  elsif key == 'label' && value.empty?
      errors_array << "There is a #{key} in one of #{element_name} which not defined (empty)"
  elsif key == 'content' && (value.empty? || !(value.class == Array))
    errors_array << "There is a #{key} in one of #{element_name} which not defined (empty)"

  end
end
# -----------------------------------------------------

questionnaire_array = []
slides_array = []
questions_array = []
answers_array = []

questionnaires_errors_array = []
slides_errors_array = []
questions_errors_array = []
answers_errors_array = []

questionnaire_content = YAML.load_file(File.open(File.join(Dir.getwd,'questionnaire.yml')))
#p questionnaire_content

#Storing slides present in the questionnaire
def slides_array(questionnaire_content)
  questionnaire_content.each do |key, value|
    if value.class == Array
      slides_array << value
    end
  end
  slides_array
end

#Storing questions present from each slides
def questions_array(slides_array)
  slides_array.flatten.each do |slides|
    questions_array << extract_nested_arrays_from_hah(slides)
  end
  questions_array
end

#Storing answer's options (when applicable) definition for each questions
def answers_array(questions_array)
  questions_array.flatten.each do |question|
    answers_array << extract_nested_arrays_from_hah(question)
  end
  answer_array
end

#Checking coherency of all slides content of reference and label
slides_array.flatten.each_with_index do |slide_content, index|
  slide_content.each do |key, value|
    if value.nil?
      slides_errors_array << is_nil(key,value, index,"slide")
    else
      slides_errors_array << is_empty(key,value, index, "slide")
    end
  end
end

questions_array.flatten.each_with_index do |question_content, index|
  question_content.each do |key, value|
    if value.nil?
      questions_errors_array << is_nil(key,value, index,"question")
    else
      questions_errors_array << is_empty(key,value, index, "question")
    end
  end
end

p answers_array
p answers_array.flatten
answers_array.flatten.each_with_index do |answer_content, index|
  answer_content.each do |key, value|
    if value.nil?
      answers_errors_array << is_nil(key,value, index,"answer")
    else
      answers_errors_array << is_empty(key,value, index, "answer")
    end
  end
end


p slides_errors_array.compact.flatten
p questions_errors_array.compact.flatten
p answers_errors_array.compact.flatten
