class SettingsController < ApplicationController
  before_action :set_setting, only: %i[ show edit update ]

  # GET /settings/1 or /settings/1.json
  def show
  end

  # GET /settings/1/edit
  def edit
  end

  # PATCH/PUT /settings/1 or /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: "Setting was successfully updated." }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_setting
    @setting = Setting.find(params.expect(:id))
    authorize @setting
  end

  # Only allow a list of trusted parameters through.
  def setting_params
    params.expect(setting: [:admin_mode, :insight_prompt, :image_prompt, :reply_prompt, :summary_prompt])
  end
end
