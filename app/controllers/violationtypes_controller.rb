class ViolationtypesController < ApplicationController
  before_action :set_violationtype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :super_admin!

  # GET /violationtypes
  # GET /violationtypes.json
  def index
    @violationtypes = Violationtype.all
  end

  # GET /violationtypes/1
  # GET /violationtypes/1.json
  def show
  end

  # GET /violationtypes/new
  def new
    @violationtype = Violationtype.new
  end

  # GET /violationtypes/1/edit
  def edit
  end

  # POST /violationtypes
  # POST /violationtypes.json
  def create
    @violationtype = Violationtype.new(violationtype_params)

    respond_to do |format|
      if @violationtype.save
        format.html { redirect_to @violationtype, notice: 'Violationtype was successfully created.' }
        format.json { render :show, status: :created, location: @violationtype }
      else
        format.html { render :new }
        format.json { render json: @violationtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /violationtypes/1
  # PATCH/PUT /violationtypes/1.json
  def update
    respond_to do |format|
      if @violationtype.update(violationtype_params)
        format.html { redirect_to @violationtype, notice: 'Violationtype was successfully updated.' }
        format.json { render :show, status: :ok, location: @violationtype }
      else
        format.html { render :edit }
        format.json { render json: @violationtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /violationtypes/1
  # DELETE /violationtypes/1.json
  def destroy
    @violationtype.destroy
    respond_to do |format|
      format.html { redirect_to violationtypes_url, notice: 'Violationtype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_violationtype
      @violationtype = Violationtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def violationtype_params
      params.require(:violationtype).permit(:description, :first_offence, :second_offence, :subsiquent_offence, :track)
    end
end
