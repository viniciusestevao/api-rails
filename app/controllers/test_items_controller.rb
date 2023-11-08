class TestItemsController < ApplicationController
    before_action :set_current_test_item, only: [:show, :update, :destroy]
    # GET /test_items
    def index
      @test_items = TestItem.all
  
      render json: @test_items
    end
  
    # GET /test_items/1
    def show
      render json: @test_item
    end
  
    # POST /test_items
    def create
			answers_to_update = params[:answersToUpdate]

			if answers_to_update
					# Itere pelas respostas para atualizar cada uma
					answers_to_update.each do |question_id, answer_data|
						test_item = TestItem.find(question_id)
						if test_item
								# Atualize a resposta da questão
								test_item.update(candidate_answer: answer_data[:candidate_answer])
						end
					end
					render json: { message: 'Respostas atualizadas com sucesso' }
			else
					render json: { error: 'Dados de respostas ausentes' }, status: :bad_request
			end
    end
  
    # PATCH/PUT /test_items/1
    def update
      if @test_item.update(resource_params)
        render json: @test_item
      else
        render json: @test_item.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /test_items/1
    def destroy
      @test_item.destroy
    end
  
    private

    # Use callbacks to share common setup or constraints between actions.
    def set_current_test_item
    @test_item = TestItem.find(params[:id])
    end

    def resource_class
    TestItem
    end

end
