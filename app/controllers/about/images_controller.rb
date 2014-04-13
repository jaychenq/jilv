class About::ImagesController < About::ApplicationController
  def show
    @image = model.f(id)
    send_file %{public#{@image.file}}, type: @image.file_content_type, disposition: 'inline'
  end
end
