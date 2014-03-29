class WeightReadingsController < ApplicationController
  before_action :set_weight_reading, only: [:show, :edit, :update, :destroy]

  # GET /weight_readings
  # GET /weight_readings.json
  def index
    @weight_readings = WeightReading.all
  end

  # GET /weight_readings/1
  # GET /weight_readings/1.json
  def show
  end

  # GET /weight_readings/new
  def new
    @weight_reading = WeightReading.new
  end

  # GET /weight_readings/1/edit
  def edit
  end

  # POST /weight_readings
  # POST /weight_readings.json
  def create
    @weight_reading = WeightReading.new(weight_reading_params)

    respond_to do |format|
      if @weight_reading.save
        format.html { redirect_to @weight_reading, notice: 'Weight reading was successfully created.' }
        format.json { render action: 'show', status: :created, location: @weight_reading }
      else
        format.html { render action: 'new' }
        format.json { render json: @weight_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weight_readings/1
  # PATCH/PUT /weight_readings/1.json
  def update
    respond_to do |format|
      if @weight_reading.update(weight_reading_params)
        format.html { redirect_to @weight_reading, notice: 'Weight reading was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @weight_reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weight_readings/1
  # DELETE /weight_readings/1.json
  def destroy
    @weight_reading.destroy
    respond_to do |format|
      format.html { redirect_to weight_readings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight_reading
      @weight_reading = WeightReading.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weight_reading_params
      params.require(:weight_reading).permit(:patient_id, :weight, :hydration, :reading_time, :created_date, :weight_monitor_id)
    end
end
