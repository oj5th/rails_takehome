class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]
  before_action :current_activity, only: %i[ edit update ]

  # GET /activities or /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1 or /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    session[:activity_params] = {}
    session[:activity_step] = nil
    @activity = Activity.new(session[:activity_params])
    @activity.current_step = session[:activity_step]
  end

  # GET /activities/1/edit
  def edit
    session[:activity_params] = {}
    session[:activity_step] = nil
    @activity = Activity.new(session[:activity_params])
    @activity.current_step = session[:activity_step]
  end

  # POST /activities or /activities.json
  def create
    saving_wizard

    if @activity.new_record? && !params[:back_button]
      render "new"
    else
      session[:activity_step] = session[:activity_params] = nil
      flash[:notice] = "Activity was successfully created."
    end
  end

  # PATCH/PUT /activities/1 or /activities/1.json
  def update
    saving_wizard

    if @wizard && !params[:back_button]
      render "edit"
    end
  end

  # DELETE /activities/1 or /activities/1.json
  def destroy
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url, notice: "Activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def saving_wizard
      @wizard = true
      session[:activity_params] ||= {}
      session[:activity_params].deep_merge!(activity_params) if activity_params
      @activity = Activity.new(session[:activity_params])
      @activity.current_step = session[:activity_step]

      if params[:back_button]
        @activity.current_step = @activity.previous_step
        session[:activity_step] = @activity.current_step
        render params[:action] == "update" ?  "edit" : "new" and return
      end

      if @activity.valid?
        if @activity.last_step?
          send("#{params[:action]}_activity") if @activity.all_valid?
        else
          @activity.next_step
        end
        session[:activity_step] = @activity.current_step
      end
    end

    def create_activity
      @activity.save
      redirect_to @activity and return
    end

    def update_activity
      @current_activity.update(session[:activity_params])
      @wizard = false
      redirect_to activities_path and return
    end

    def current_activity
      @current_activity = Activity.find(params[:id])
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :address, :starts_at, :ends_at)
    end
end
