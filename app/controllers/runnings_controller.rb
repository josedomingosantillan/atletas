class RunningsController < ApplicationController
  before_action :set_running, only: %i[ show edit update destroy ]

  # GET /runnings or /runnings.json
  def index
    @runnings = Running.all.order('total DESC')
  end

  def dynamic
    @runnings = Running.all.order('total DESC')
    render partial: 'dynamic'
  end

  # GET /runnings/1 or /runnings/1.json
  def show
  end

  # GET /runnings/new
  def new
    @running = Running.new
  end

  # GET /runnings/1/edit
  def edit
  end

  # POST /runnings or /runnings.json
  def create
    @running = Running.new(running_params)

    respond_to do |format|
      if @running.save
        format.html { redirect_to @running, notice: "Running was successfully created." }
        format.json { render :show, status: :created, location: @running }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @running.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runnings/1 or /runnings/1.json
  def update
    respond_to do |format|
      if params[:running][:one_lap].present?
        @running.update_attributes(:one_lap => params[:running][:one_lap], :total => params[:running][:one_lap])
        format.js
        format.json { head :no_content }
      elsif params[:running][:two_lap].present?
        @running.update_attributes(:two_lap => params[:running][:two_lap], :total => params[:running][:one_lap])
        format.js
        format.json { head :no_content }
      elsif params[:running][:three_lap].present?
        @running.update_attributes(:three_lap => params[:running][:three_lap], :total => params[:running][:one_lap])
        format.js
        format.json { head :no_content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @running.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_lap
    id = params[:Id_usuario]
    tiempo = params[:tiempo]
    num_vuelta = params[:num_vuelta].to_i
    if id.present?
      @runs = Running.find(id)
      respond_to do |format|
        if @runs.present?
          if num_vuelta === 1
            @runs.update(:one_lap => tiempo, :total => params[:total])
            format.js
            format.json { head :no_content }
          elsif num_vuelta === 2
            total = @runs.total.to_i + params[:total].to_i
            @runs.update(:two_lap => tiempo, :total => total)
            format.js
            format.json { head :no_content }
          elsif num_vuelta === 3
            total = @runs.total.to_i + params[:total].to_i
            @runs.update(:three_lap => tiempo, :total => total)
            format.js
            format.json { head :no_content }
          end
        end
      end
      @runnings = Running.all.order('total DESC')
    end
  end

  # DELETE /runnings/1 or /runnings/1.json
  def destroy
    @running.destroy
    respond_to do |format|
      format.html { redirect_to runnings_url, notice: "Running was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_running
    @running = Running.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def running_params
    params.require(:running).permit(:name, :one_lap, :two_lap, :three_lap, :total)
  end
end
