class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]

  # GET /entries or /entries.json
  def index
    if params.include? :q
      embedding = Embedding.create(params[:q])
      @entries = policy_scope(Entry).with_rich_text_content.vector_search(embedding: embedding.embedding, limit: nil).order(created_at: :desc)
      @result = Rails.cache.fetch("query-#{params[:q]}-#{@entries.cache_key_with_version}") do
        QueryGenerationJob.perform_now(params[:q], @entries)
      end
    else
      date = Time.current

      entry = policy_scope(Entry).with_rich_text_content.where(created_at: date.beginning_of_day..date.end_of_day).first_or_create do
        ProcessEntriesJob.perform_later(_1.past_entries.last)
      end

      redirect_to entry
    end
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/1/edit
  def edit
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        @entry.embed!
        format.html { redirect_to @entry }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy!

    respond_to do |format|
      format.html { redirect_to entries_path, status: :see_other, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entry
    @entry = policy_scope(Entry).find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def entry_params
    params.require(:entry).permit(:content)
  end
end
