class Admin::Payment::TransactionsController < Admin::Payment::ApplicationController
  def index
    render template: 'admin/application/index', model: @model
  end
end
