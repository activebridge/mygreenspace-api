class Api::V1::SpacesController < ApiController
  doorkeeper_for :all
  before_action :find_space, only: [:show, :update, :destroy]

  def index
    @spaces = current_user.spaces

    if @spaces.present?
      render
    else
      render json: { message: 'No Spaces Found' }, status: 200
    end
  end

  def create
    @space = current_user.spaces.build(space_params)

    if @space.save
      render :show
    else
      render json: {
        message: 'Validation Failed',
        errors: @space.errors.full_messages
      }, status: 422
    end
  end

  def show
  end

  def update
    if @space.update(space_params)
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @space.errors.full_messages
      }, status: 422
    end
  end

  def destroy
    if @space.destroy
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @space.errors.full_messages
      }, status: 422
    end
  end

  private

  def space_params
    params.require(:space).permit(:width, :length)
  end

  def find_space
    @space = current_user.spaces.find(params[:id])
  end
end
