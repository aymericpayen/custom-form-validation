# README

The code is covering:

* Page to upload YAML file
  * Test covering correct display of the page and correct upload of file
* Questionnaire Validation
  * Custom "Questionnaire::Validator" create to validate slides, questions and answers compliancy
* Endpoint (localhost:3000/questionnaires/:reference) to display in JSON format

# REQUIRED COMMANDS PRIOR LAUNCHING
* bundle install
* rails db:create db:migrate
