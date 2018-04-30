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
      store_question_and_answer(questionnaire, "Gender", params[:gender])
      store_multiple_answer_to_question(questionnaire, "Interests", params[:interests])

      # Meyers briggs
      store_question_and_answer(questionnaire, "I enjoy", params[:i_enjoy])
      store_question_and_answer(questionnaire, "I prefer", params[:i_prefer])
      store_question_and_answer(questionnaire, "I make decisions using", params[:i_make_decisiongs_using])
      store_question_and_answer(questionnaire, "I would rather", params[:i_would_rather])

      # Keirsey score
      store_question_and_answer(questionnaire, "In company do you", params[:in_company_do_you])
      store_question_and_answer(questionnaire, "Are you more likely to trust your", params[:are_you_more_likely_to_trust_your])
      store_question_and_answer(questionnaire, "Is it harder for you to", params[:is_it_harder_for_you_to])
      store_question_and_answer(questionnaire, "Are you more often", params[:are_you_more_often])
      store_question_and_answer(questionnaire, "Is it worse to be", params[:is_it_worse_to_be])
      store_question_and_answer(questionnaire, "Are you more", params[:are_you_more])
      store_question_and_answer(questionnaire, "Are you more comfortable", params[:are_you_more_comfortable])
      current_user.update(mb_value: calculate_mb_value(params))
      current_user.update(is_user_ready_for_match: true)
      CompatibilityScoreUtil.new.calculate_for(current_user)
      Matchmaker.new.match_users_based_on(current_user)
      redirect_to root_url
    else
      render "/"
    end
  end

  private
  def calculate_mb_value(params)
    mb_value = ""
    if params[:i_enjoy] == "Meeting new people and doing things"
      mb_value << "E"
    else
      mb_value << "I"
    end

    if i_prefer = params[:i_prefer] == "Tangible objects and valid details"
      mb_value << "S"
    else
      mb_value << "N"
    end

    if params[:i_make_decisions_using] == "Dispassionate viewpoints and logical conclusions"
      mb_value << "T"
    else
      mb_value << "F"
    end

    if params[:i_would_rather] == "Have a set plan"
      mb_value << "J"
    else
      mb_value << "P"
    end

    return mb_value
  end

  def store_question_and_answer(questionnaire, question_name, answer_value)
    if answer_value
      question = questionnaire.questions.find_or_create_by!(name: question_name)
      question.answers.create!(text: answer_value)
    else
      return true
    end
  end

  def store_multiple_answer_to_question(questionnaire, question_name, answer_value)
    answer_value.each do |interest|
      store_question_and_answer(questionnaire, "Interests", interest)
    end
  end
end
