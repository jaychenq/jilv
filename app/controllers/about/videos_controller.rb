class About::VideosController < About::ApplicationController
  def show
    @audio = model.f(id)
    send_file %{public#{@audio.file}}, type: @audio.file_content_type, disposition: 'inline'
  end
end
