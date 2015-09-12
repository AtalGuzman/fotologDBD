class FotosController < ApplicationController
  before_action :set_foto, only: [:show, :edit, :update, :destroy]
  
  def index  
    @foto = Foto.all
  end

  # GET /comentarios/1
  # GET /comentarios/1.json
  def show
    @comentario = Comentario.new
    @calificacion = Calificacion.new 
  end

  # GET /comentarios/new
  def new
    @foto = Foto.new
  end
  # GET /fotos/1/edit
  def edit
  end

  def anonimo
    @foto_anonimo = Foto.all
  end

  # POST /fotos
  # POST /fotos.json
  def create
    if current_usuario.fotos.where(FECHA: Date.current).count <= 5
      if foto_params[:DESCRIPCION].length <200 && foto_params[:TITULO].length<50
        @foto = current_usuario.fotos.new(foto_params)
        @foto.FECHA = Date.current
      
        respond_to do |format|
          if @foto.save
            format.html { redirect_to @foto, notice: 'Foto creada.' }
            format.json { render :show, status: :created, location: @foto }
          else
            format.html { render :new }
            format.json { render json: @foto.errors, status: :unprocessable_entity }
          end
        end 
      else
        redirect_to current_usuario
        flash[:notice] = "La descripcion no puede tener más de 200 caracteres y el titulo no más de 50."
      end
    else
      redirect_to current_usuario
      flash[:notice] = "No puedes subir más de 5 fotos en un día."
    end
  end

  # PATCH/PUT /fotos/1
  # PATCH/PUT /fotos/1.json
  def update
    respond_to do |format|
      if @foto.update(foto_params)
        format.html { redirect_to @foto, notice: 'Foto was successfully updated.' }
        format.json { render :show, status: :ok, location: @foto }
      else
        format.html { render :edit }
        format.json { render json: @foto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fotos/1
  # DELETE /fotos/1.json
  def destroy
    @foto.comentarios.each do |c|
      c.destroy
    end
    #@foto.calificaciones.each do |c|
    #  c.destroy
    #end
    @foto.destroy
    respond_to do |format|
      format.html { redirect_to current_usuario, notice: 'Foto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foto
      @foto = Foto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def foto_params
      params.require(:foto).permit(:usuario_id,:DESCRIPCION, :FECHA, :TITULO, :imagen)
    end
end
