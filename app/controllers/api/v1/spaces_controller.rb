class Api::V1::SpacesController < ApiController
  def index
    @spaces = Space.all

    if @spaces.count(:all) > 0
      render
    else
      render json: { message: 'No Spaces Found' }, status: 200
    end
  end

  def create
    @space = Space.last   # uncertain of this line

    if @space.save
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @space.errors.full_messages
      }, status: 422
    end
  end

  def show
    @space = Space.find(params[:id])
  end

  def update
    @space = Space.last   # uncertain of this line

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
    @space = Space.find(params[:id])

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
    {
      created_at: params[:created_at]
    }
  end
end
