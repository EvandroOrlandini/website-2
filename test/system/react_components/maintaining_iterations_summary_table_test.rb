require "application_system_test_case"

class MaintainingIterationsSummaryTableTest < ApplicationSystemTestCase
  test "visiting the index" do
    solution = create :concept_solution
    iteration = create :iteration, solution: solution

    visit maintaining_iterations_summary_table_url()
    sleep(0.1) # Set the websocket connection

    iteration.tests_passed!
    iteration.broadcast!

    sleep(0.1) # Wait for websocket to broadcast
    assert_text "#{iteration.id}"
  end
end
