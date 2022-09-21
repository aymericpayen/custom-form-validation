require 'yaml'
class QuestionnairesController < ApplicationController
  def new
    @questionnaire = Questionnaire.new
  end

  def create
    questionnaire_content = YAML.load_file(params[:file])
    questionnaire = Questionnaire.new(reference: questionnaire_content["reference"],
                                      content: questionnaire_content["content"])
    # raise
    if questionnaire.save
      questionnaire.save
      redirect_to :new_questionnaire, notice: "YAML correctly loaded, thank you !"
    else
      redirect_to :new_questionnaire, notice: {errors: questionnaire.errors.full_messages}
    end
  end

  def show
    questionnaire = Questionnaire.where(reference: params[:id])
    render json: questionnaire
  end

end
