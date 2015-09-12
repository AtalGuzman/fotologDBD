class UsuarioController < ApplicationController
  before_action :set_usuario, only: [:show, :edit, :update, :mis_amigos, :mis_fotos] 
  def create
    User.create(user_params)
  end 

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
  end

  def anonimo
    @fotos_anonimo = Foto.all
  end
  #GET /usuarios
  #GET /usuarios.json
  def index
     if params[:search]
      @usuarios = Usuario.search(params[:search]).order("created_at DESC")
    else
      @usuarios = Usuario.order("created_at DESC")
    end
  end


  def mis_amigos
    @mis_amigo = @usuario.amigos
  end

  def mis_fotos
    @mis_fotos = @usuario.fotos   
  end
  
  private
  def set_usuario
      @usuario = Usuario.find(params[:id])
  end

  def user_params
#assumption: user params are coming in params[:user]
    params.require(:user).permit(:name,:id,:search)
  end
end
