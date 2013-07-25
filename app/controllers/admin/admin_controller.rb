module Admin
  class AdminController < ApplicationController
    layout 'admin'

    before_filter :authorize_admin

    private

      def authorize_admin
        authorize! :manage, :admin
      end
  end
end