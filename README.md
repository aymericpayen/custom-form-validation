# Required command prior launching the app
* bundle install
* rails db:create db:migrate

The code is covering:

* Page to upload YAML file
* Questionnaire Validation
* Endpoint (localhost:3000/questionnaires/:reference) to display in JSON format



# Explanations
* Show for upload
  * If file is incorrect, upload page is rendered with the list of errors.
* Validation of 'Questionnaire':
  * model/questionnaire : contains basic validation supported by rails. One custom validation is called.
  * model/concerns: contains custom rules to validate the questionnaire, the logic is the following
    1. All slides are extracted and is tested based on customs method, results are stored in one array
    2. All answers are extracted and is tested based on customs method, results are stored in one array
    3. All questions are extracted and is tested based on customs method, results are stored in one array
    4. All arrays (slides, questions, answers) are concatenated to displays all final errors

* Rspec of 'Questionnaire
  * spec/requests: Contains test to aknowledge correct display of the upload page (get) and correct submission of yaml file (post)
  * spec/models: Contains test to confirm questionnaire's model rules
    * A valid file (/spec/models/dumy_yamls/questionnaire_good.yml) is used to confirm correct validation
    * A invalid file (/spec/models/dumy_yamls/questionnaire_bad.yml) is used to confirm incorrect validation

#Notes
* Unicity of reference has been delcared to ensure unique localhost:3000/questionnaires/:reference and avoid same reference name throughout the database
* 'questionnaire.yml' must be loaded from the root of the app
