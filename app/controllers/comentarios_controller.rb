class ComentariosController < ApplicationController
  before_action :set_comentario, only: [:update, :destroy]
  before_action :set_foto
  # POST /comentarios
  # POST /comentarios.json
  def create
    if current_usuario !=nil #Si el usuario no es el usuario anonimo entonces se hace todo el procedimiento normal
      @comentario = current_usuario.comentarios.new(comentario_params)
      @comentario.foto =  @foto
      @comentario.FECHA = Date.current
      if current_usuario.comentarios.where(foto_id: @foto.id).count < 20
        if @comentario.TEXTO.length < 1000
          if  @comentario.TEXTO.length == 0
              flash[:notice] = "El comentario debe tener texto."
              redirect_to @foto
          else
            respond_to do |format|
              if @comentario.save
                format.html { redirect_to @comentario.foto, notice: 'El comentario fue creado.' }
                format.json { render :show, status: :created, location: @comentario }
              else
                format.html { render :new }
                format.json { render json: @comentario.errors, status: :unprocessable_entity }
              end
            end
          end  
        else
              flash[:notice] = "El comentario no puede tener más de 200 caracteres."
              redirect_to @foto
        end
      else
          flash[:notice] = "Hey! #{current_usuario.NOMBRE_PHOTOLOG} no puedes hacer más de 20 comentarios."
          redirect_to @foto
      end
    #En caso de que el usuario sea anónimo
    else
      @comentario = Comentario.new(comentario_params) #Se busca el usuario anónimo para poder crear
      @comentario.usuario = Usuario.find(1)
      @comentario.foto =  @foto #Se asocia al comentario la foto
      @comentario.FECHA = Date.current  #Se instala la fecha actiual
      if @comentario.TEXTO.length < 200
          respond_to do |format|
            if @comentario.save
              format.html { redirect_to @comentario.foto, notice: 'El comentario fue creado.' }
              format.json { render :show, status: :created, location: @comentario }
            else
              format.html { render :new }
              format.json { render json: @comentario.errors, status: :unprocessable_entity }
            end
          end
        else
              redirect_to @foto
        end
    end
  end

  # PATCH/PUT /comentarios/1
  # PATCH/PUT /comentarios/1.json
  def update
    respond_to do |format|
      if @comentario.update(comentario_params)
        format.html { redirect_to @comentario.foto, notice: 'Comentario was successfully updated.' }
        format.json { render :show, status: :ok, location: @comentario }
      else
        format.html { render :edit }
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.json
  def destroy
    @comentario.destroy
    respond_to do |format|
      format.html { redirect_to @foto, notice: 'Comentario eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_foto
      @foto = Foto.find(params[:foto_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comentario
      @comentario = Comentario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comentario_params
      params.require(:comentario).permit(:usuario_id, :foto_id, :TEXTO, :FECHA)
    end
end
