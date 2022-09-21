require 'rails_helper'
require 'yaml'
require 'spec_helper'

RSpec.describe Questionnaire, type: :model do

  describe QuestionnaireValidator do
    #Confirming that a valid YAML file is tested ok
    let(:dumy_yaml_folder) {"spec/models/dumy_yamls/"}
    let(:good_yaml) {YAML.load_file(File.open(File.join(dumy_yaml_folder, 'questionnaire_good.yml')))}
    let(:bad_yaml) {YAML.load_file(File.open(File.join(dumy_yaml_folder, 'questionnaire_bad.yml')))}

    describe 'Valid yaml file' do
       it 'is valid with valid attributes' do
        questionnaire = Questionnaire.new(reference: good_yaml["reference"], content: good_yaml["content"])
        expect(questionnaire).to be_valid
      end

      it 'is not returning any errors' do
        questionnaire = Questionnaire.new(reference: good_yaml["reference"], content: good_yaml["content"])
        expect(questionnaire.errors.full_messages).to eq([])
      end
    end

    describe 'Invalid yaml' do
      it 'is invalid with missing attributes' do
        questionnaire = Questionnaire.new(content: bad_yaml["content"])
        expect(questionnaire).to_not be_valid
      end

      it 'is returning 4 errors (missing labels and references in slides/questions/answers)' do
        questionnaire = Questionnaire.new(reference: bad_yaml["reference"], content: bad_yaml["content"])
        questionnaire.valid?
        expect((questionnaire.errors[:questionnaire].flatten).size).to eq(4)
      end

      it 'is missing a reference for questionnaire' do
        questionnaire = Questionnaire.new(reference: bad_yaml["reference"], content: bad_yaml["content"])
        questionnaire.valid?
        expect((questionnaire.errors[:reference].flatten).size).to eq(2)
      end
    end
  end
end
