class QuestionnaireController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    if current_user
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
    else
      redirect_to "/users/login"
    end
  end

  def create
    if current_user
      questionnaire = current_user.questionnaires.create!(name: current_user.email)
      store_question_and_answer(questionnaire, "First Name", params[:first_name])
      store_question_and_answer(questionnaire, "Last Name", params[:last_name])
      store_question_and_answer(questionnaire, "Age", params[:age])
      store_question_and_answer(questionnaire, "Zipcode", params[:zipcode])
      store_question_and_answer(questionnaire, "Willing to Travel Distance", params[:willing_to_travel_distance])
      store_question_and_answer(questionnaire, "Preferred communication", params[:preferred_communication])
      store_question_and_answer(questionnaire, "Gender", params[:gender])
      store_question_and_answer(questionnaire, "Sexual Orientation", params[:sexual_orientation])
      store_question_and_answer(questionnaire, "Education", params[:education])
      store_question_and_answer(questionnaire, "Occupation", params[:occupation])
      store_question_and_answer(questionnaire, "Political Views", params[:political_views])
      store_question_and_answer(questionnaire, "Interests", params[:interests])
      store_question_and_answer(questionnaire, "Languages", params[:languages])
      store_question_and_answer(questionnaire, "Budget per week", params[:budget])

      # Meyers briggs
      store_question_and_answer(questionnaire, "I enjoy", params[:i_enjoy])
      store_question_and_answer(questionnaire, "I prefer", params[:i_prefer])
      store_question_and_answer(questionnaire, "I make decisions using", params[:i_make_decisiongs_using])
      store_question_and_answer(questionnaire, "I would rather", params[:i_would_rather])

      current_user.update(is_user_ready_for_match: true)
      redirect_to root_url
    else
      render "/"
    end
  end

  private
  def store_question_and_answer(questionnaire, question_name, answer_value)
    if answer_value
      question = questionnaire.questions.create!(name: question_name)
      question.answers.create!(text: answer_value)
    else
      return true
    end
  end

end
