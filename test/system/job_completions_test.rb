require "application_system_test_case"

class JobCompletionsTest < ApplicationSystemTestCase
  setup do
    @job_completion = job_completions(:one)
  end

  test "visiting the index" do
    visit job_completions_url
    assert_selector "h1", text: "Job completions"
  end

  test "should create job completion" do
    visit job_completions_url
    click_on "New job completion"

    fill_in "Adapter", with: @job_completion.adapter
    fill_in "Completed at", with: @job_completion.completed_at
    click_on "Create Job completion"

    assert_text "Job completion was successfully created"
    click_on "Back"
  end

  test "should update Job completion" do
    visit job_completion_url(@job_completion)
    click_on "Edit this job completion", match: :first

    fill_in "Adapter", with: @job_completion.adapter
    fill_in "Completed at", with: @job_completion.completed_at
    click_on "Update Job completion"

    assert_text "Job completion was successfully updated"
    click_on "Back"
  end

  test "should destroy Job completion" do
    visit job_completion_url(@job_completion)
    click_on "Destroy this job completion", match: :first

    assert_text "Job completion was successfully destroyed"
  end
end
