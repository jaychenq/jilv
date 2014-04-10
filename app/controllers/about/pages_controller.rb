class About::PagesController < About::ApplicationController
  def show
    @page = model.search(id)

    respond_to do |format|
      format.html
      format.xml { render json: @page.data }
    end
  end

  #   {
  #     "continents": [
  #       {
  #         "id": "",
  #         "countries": [
  #           {
  #             "id": "",
  #           }
  #         ] 
  #       }
  #     ]
  #   }
  def _home_1; end
end
