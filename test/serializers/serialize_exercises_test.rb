require 'test_helper'

class SerializeExercisesTest < ActiveSupport::TestCase
  test "serializes without user_track" do
    concept_exercise = create :concept_exercise
    practice_exercise = create :practice_exercise

    expected = [
      SerializeExercise.(concept_exercise),
      SerializeExercise.(practice_exercise)
    ]

    assert_equal expected, SerializeExercises.(
      [concept_exercise, practice_exercise]
    )
  end

  test "with external user track" do
    exercise = create :concept_exercise

    expected = [
      SerializeExercise.(exercise)
    ]

    assert_equal expected, SerializeExercises.(
      [exercise],
      user_track: UserTrack::External.new(exercise.track)
    )
  end

  test "with user track" do
    user = create :user
    track = create :track
    user_track = create :user_track, user: user, track: track
    concept_exercise = create :concept_exercise, track: track
    practice_exercise = create :practice_exercise, track: track
    create :exercise_prerequisite, exercise: practice_exercise

    create :hello_world_solution, :completed, track: track, user: user

    expected = [
      SerializeExercise.(concept_exercise, user_track:, recommended: true),
      SerializeExercise.(practice_exercise, user_track:)
    ]

    assert_equal expected, SerializeExercises.(
      [concept_exercise, practice_exercise],
      user_track:
    )
  end
end
