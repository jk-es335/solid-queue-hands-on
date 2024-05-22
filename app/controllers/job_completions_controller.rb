class JobCompletionsController < ApplicationController
  before_action :set_job_completion, only: %i[ show edit update destroy ]

  # GET /job_completions or /job_completions.json
  def index
    @job_completions = JobCompletion.all
  end

  # GET /job_completions/1 or /job_completions/1.json
  def show
  end

  # GET /job_completions/new
  def new
    @job_completion = JobCompletion.new
  end

  # GET /job_completions/1/edit
  def edit
  end

  # POST /job_completions or /job_completions.json
  def create
    @job_completion = JobCompletion.new(job_completion_params)

    respond_to do |format|
      if @job_completion.save
        format.html { redirect_to job_completion_url(@job_completion), notice: "Job completion was successfully created." }
        format.json { render :show, status: :created, location: @job_completion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_completion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_completions/1 or /job_completions/1.json
  def update
    respond_to do |format|
      if @job_completion.update(job_completion_params)
        format.html { redirect_to job_completion_url(@job_completion), notice: "Job completion was successfully updated." }
        format.json { render :show, status: :ok, location: @job_completion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_completion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_completions/1 or /job_completions/1.json
  def destroy
    @job_completion.destroy!

    respond_to do |format|
      format.html { redirect_to job_completions_url, notice: "Job completion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_completion
      @job_completion = JobCompletion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_completion_params
      params.require(:job_completion).permit(:adapter, :completed_at)
    end
end
