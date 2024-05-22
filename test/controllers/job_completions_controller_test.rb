require "test_helper"

class JobCompletionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_completion = job_completions(:one)
  end

  test "should get index" do
    get job_completions_url
    assert_response :success
  end

  test "should get new" do
    get new_job_completion_url
    assert_response :success
  end

  test "should create job_completion" do
    assert_difference("JobCompletion.count") do
      post job_completions_url, params: { job_completion: { adapter: @job_completion.adapter, completed_at: @job_completion.completed_at } }
    end

    assert_redirected_to job_completion_url(JobCompletion.last)
  end

  test "should show job_completion" do
    get job_completion_url(@job_completion)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_completion_url(@job_completion)
    assert_response :success
  end

  test "should update job_completion" do
    patch job_completion_url(@job_completion), params: { job_completion: { adapter: @job_completion.adapter, completed_at: @job_completion.completed_at } }
    assert_redirected_to job_completion_url(@job_completion)
  end

  test "should destroy job_completion" do
    assert_difference("JobCompletion.count", -1) do
      delete job_completion_url(@job_completion)
    end

    assert_redirected_to job_completions_url
  end
end
