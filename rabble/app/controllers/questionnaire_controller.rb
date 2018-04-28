class QuestionnaireController < ApplicationController
  skip_before_filter :verify_authenticity_token  

  def index
    @personal_questionnaire = Questionnaire.find_by(name: "Personal Details")
    @second_personal_questionnaire = Questionnaire.find_by(name: "Lets get a little more personal")
    
    @available_languages = [
      "Afrikanns", "Albanian", "Arabic", "Armenian",
      "Basque", "Bengali", "Bulgarian", "Catalan",
      "Cambodian", "Mandarin", "Croation", "Czech",
      "Danish", "Dutch", "Estonian", "Fiji", "Finnish",
      "French", "Georgian", "German", "Greek", "Gujarati",
      "Hebrew", "Hindi", "Hungarian", "Icelandic",
      "Indonesian", "Irish", "Italian", "Japanese",
      "Javanese", "Korean", "Latin", "Latvian",
      "Lithuanian", "Macedonian", "Malay", "Malayalam",
      "Maltese", "Maori", "Marathi", "Mongolian",
      "Nepali", "Norwegian", "Persian", "Polish",
      "Portuguese", "Punjabi", "Quechua", "Romanian",
      "Russian", "Samoan", "Serbian", "Slovak",
      "Slovenian", "Spanish", "Swahili", "Swedish",
      "Tamil", "Tatar", "Telugu", "Thai",
      "Tibetan", "Tonga", "Turkish", "Ukranian", "Urdu"]
    render "form.html"
  end

  def create
    debugger
  end

end
