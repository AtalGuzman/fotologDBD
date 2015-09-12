class AmigosController < ApplicationController
  before_action :set_amigo, only: [:show, :edit, :update, :destroy]
  # GET /amigos
  # GET /amigos.json
  def index
    @amigos = Amigo.all
  end

  # GET /amigos/1
  # GET /amigos/1.json
  def show
  end

  # GET /amigos/new
  def new
    @amigo = Amigo.new
  end

  # GET /amigos/1/edit
  def edit
  end

  # POST /amigos
  # POST /amigos.json
  def create
    @usuario = Usuario.find(params[:usuario_id]) 
    #es_amigo = Amigo.new
    @amigo = current_usuario.amigos.new(:usuario_id => current_usuario.id, :amigo_id=> @usuario.id, :FECHA_AMISTAD=>Date.current())
    #@amigo.amigo = @usuario
    #es_amigo.usuario_id = @amigo.amigo_id
    #es_amigo.amigo_id = @amigo.usuario_id
    #es_amigo.FECHA_AMISTAD = @amigo.FECHA_AMISTAD

    respond_to do |format|
      if @amigo.save# && es_amigo.save
        format.html { redirect_to @amigo, notice: 'Amigo was successfully created.' }
        format.json { render :show, status: :created, location: @amigo}
      else
        format.html { render :new }
        format.json { render json: @amigo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amigos/1
  # PATCH/PUT /amigos/1.json
  def update
    respond_to do |format|
      if @amigo.update(amigo_params)
        format.html { redirect_to @amigo, notice: 'Amigo was successfully updated.' }
        format.json { render :show, status: :ok, location: @amigo }
      else
        format.html { render :edit }
        format.json { render json: @amigo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amigos/1
  # DELETE /amigos/1.json
  def destroy
    
    Amigo.transaction do
      @amigo.destroy
      #@amigo.es_amigo.destroy
    end
    respond_to do |format|
      format.html { redirect_to current_usuario, notice: 'Amigo eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amigo
      @amigo = Amigo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amigo_params
      #Amigo_id, corresponde al valor del id del usuario visitado
      #Usuario_id, corresponde al valor del id del usuario logeado
      params.require(:amigo).permit(:amigo_id,:usuario_id,:FECHA_AMISTAD)
    end
end
