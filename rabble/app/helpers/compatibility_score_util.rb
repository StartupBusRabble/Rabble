class CompatibilityScoreUtil < ApplicationController
  MB_WEIGHT = 1
  KTP_WEIGHT = 1
  INTEREST_WEIGHT = 1

  MB_COMPATIBILITY_MAP = Hash[
    "INFP" => ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"],
    "ENFP" => ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"],
    "INFJ" => ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"],
    "INTJ" => ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"],
    "ENTJ" => ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"],
    "ENTP" => ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP"],
    "ENFJ" => ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP", "ISFP"],
    "INTP" => ["INFP", "ENFP", "INFJ", "ENFJ", "INTJ", "ENTJ", "INTP", "ENTP", "ESTJ"],
    "ISFP" => ["ENFJ", "ESFJ", "ESTJ"],
    "ESFP" => ["ISFJ", "ISTJ"],
    "ISTP" => ["ESFJ", "ESTJ"],
    "ESTP" => ["ISFJ", "ISTJ"],
    "ISFJ" => ["ESFP", "ESTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"],
    "ESFJ" => ["ISFP", "ISTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"],
    "ISTJ" => ["ESFP", "ESTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"],
    "ESTJ" => ["INTP", "ISFP", "ISTP", "ISFJ", "ESFJ", "ISTJ", "ESTJ"],
  ]

  def calculate_for(user)
    User.all.where(matched: false).each do |other|
      next if user == other
      score = calculate_score_between(user, other)
      store_score_between_users(user, other, score)
      puts user.email + "->" + other.email + " = " + score.to_s
    end
  end

  private
  def calculate_score_between(user1, user2)
    # Skipping distance score for MVP
    # distance_score = calculate_distance_score(user1, user2)
    mb_score = calculate_mb_score(user1, user2)
    ktp_score = calculate_ktp_score(user1, user2)
    interest_score = calculate_interest_score(user1, user2)

    return (mb_score * MB_WEIGHT) + (ktp_score * KTP_WEIGHT) + (interest_score * INTEREST_WEIGHT)
  end

  def calculate_mb_score(user1, user2)
    if MB_COMPATIBILITY_MAP[user1.mb_value].include? user2.mb_value
      return 1
    end

    return -100
  end

  def calculate_ktp_score(user1, user2)
    # TODO
    return 2
  end

  def calculate_interest_score(user1, user2)
    # TODO
    return 3
  end

  def store_score_between_users(user1, user2, score)
    user1.compatibility_scores.create(compared_user: user2.id, score: score)
    user2.compatibility_scores.create(compared_user: user1.id, score: score)
  end
end
