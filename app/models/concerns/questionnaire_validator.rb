#Class for custom validation of the questionnaire
class QuestionnaireValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    errors = questionnaire_errors_computation(@record).flatten.compact
    unless errors.flatten.size == 0
      record.errors.add(:questionnaire, errors)
    end
  end

  private

  #Method to concatenate all errors found in slides, questions, answers
  def questionnaire_errors_computation(record)
    model_errors=[]

    #Extracting content of each slides, questions, answers into dedicated arrays
    slides_array = slides_array(@record.content).flatten.compact
    questions_array = questions_array(slides_array).flatten.compact
    answers_array = answers_array(questions_array).flatten.compact

    #Computing questionnaire, slides, questions, answers errors
    slides_errors = slides_errors(slides_array).flatten.compact
    questions_errors = questions_errors(questions_array).flatten.compact
    answers_errors = answers_errors(answers_array).flatten.compact

    #Concatenating all the errors found throughout slides, questions and answers arrays
    model_errors << slides_errors << questions_errors << answers_errors
    model_errors
  end

  #Method to extract slides present in the questionnaire
  def slides_array(*args)
    slides_array = []
    args.flatten.each do |value|
      slides_array << value
    end
    slides_array
  end

  #Method to extract questions present from each slides
  def questions_array(*args)
    questions_array = []
    args.flatten.each do |value|
      questions_array << extract_nested_arrays_from_hah(value)
    end
    questions_array
  end

  #Method to extract answers options (when applicable) definition for each questions
  def answers_array(*args)
    answers_array = []
    args.flatten.each do |value|
      p value
      answers_array << extract_nested_arrays_from_hah(value)
    end
    answers_array
  end

  #Method to extract array from hash to individually store slides,questions and answers in separated arrays
  def extract_nested_arrays_from_hah(element)
    result_of_arrays =[]
    element.each do |key, value|
      if value.class == Array
        result_of_arrays << value
      end
    end
    result_of_arrays.flatten
  end

  #Method to compute errors applicable for slide's related information
  def slides_errors(*args)
    slides_errors_array=[]
    args.flatten.each_with_index do |slide_content, index|
      slide_content.each do |key, value|
        if value.nil?
          slides_errors_array << is_nil(key,value, index,"slide")
        else
          slides_errors_array << is_empty(key,value, index, "slide")
        end
      end
    end
    slides_errors_array
  end

  #Method to compute errors applicable for questions's related information
  def questions_errors(*args)
    questions_errors_array=[]
    args.flatten.each_with_index do |slide_content, index|
      slide_content.each do |key, value|
        if value.nil?
          questions_errors_array << is_nil(key,value, index,"question")
        else
          questions_errors_array << is_empty(key,value, index, "question")
        end
      end
    end
    questions_errors_array
  end

  #Method to compute errors applicable for answer's related information
  def answers_errors(*args)
    answers_errors_array=[]
    args.flatten.each_with_index do |slide_content, index|
      slide_content.each do |key, value|
        if value.nil?
          answers_errors_array << is_nil(key,value, index,"answer")
        else
          answers_errors_array << is_empty(key,value, index, "answer")
        end
      end
    end
    answers_errors_array
  end

  #Method to verify in arrays (slides, questions, answers) that required datas are not nil
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

  #Method to verify in arrays (slides, questions, answers) that required datas are not empty
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

end
