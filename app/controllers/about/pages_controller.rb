class About::PagesController < About::ApplicationController
  def show
    @page = model.search(params[:id])

    # render :layout=> @page.layout.present? ? @page.layout : nil
    respond_to do |format|
      format.html {render :layout => @page.layout.present? ? @page.layout : nil}
      format.xml { render json: @page.data }
    end
  end
end
