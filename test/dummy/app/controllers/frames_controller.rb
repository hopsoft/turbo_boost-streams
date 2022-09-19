# frozen_string_literal: true

class FramesController < ApplicationController
  layout false

  def show
    partial = Base64.urlsafe_decode64(params[:id])
    # return head(:ok) unless File.exist?(Rails.root.join("app/views/#{partial}.html.erb"))
    render partial: partial
  end
end
