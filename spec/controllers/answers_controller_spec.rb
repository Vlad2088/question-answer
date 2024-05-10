require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:author) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe 'GET #new' do
    before { login(user) }

    before { get :new, params: { question_id: question.id } }

    it 'assings a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { login(user) }

    before { get :edit, params: { question_id: question.id, id: answer } } 

    it 'assings the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end    
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'save a new answer in the database' do
        expect do
          post :create, params: { question_id: question.id, answer: attributes_for(:answer), user: user }
        end.to change(question.answer, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question.id, user: user }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect do
          post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid), user: user }
        end.to_not change(question.answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id, user: user }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid attributes' do
      it 'assings the requested answer to @answer' do
        patch :update, params: { question_id: question.id, id: answer, answer: attributes_for(:answer), user: user }
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, params: { question_id: question.id, id: answer, answer: { body: 'new body' }, user: user }
        answer.reload

        expect(answer.body).to eq 'new body'
      end

      it 'redirects to question updated answer' do
        patch :update, params: { question_id: question.id, id: answer, answer: attributes_for(:answer), user: user }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { question_id: question.id, id: answer, answer: attributes_for(:answer, :invalid), user: user } }

      it 'does not change the answer' do
        answer.reload

        expect(answer.body).to eq 'MyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
     
    let!(:question) { create(:question, user: author) }
    let!(:answer) { create(:answer, question: question, user: author) }

    describe 'Removes by the author' do
      before { login(author) }

      it 'deletes the answer' do
        expect do
           delete :destroy, params: { question_id: question.id, id: answer }
        end.to change(question.answer, :count).by(-1)
      end

      it 'redirects to question index' do
        delete :destroy, params: { question_id: question.id, id: answer }
        expect(response).to redirect_to questions_path
      end
    end

    describe 'Removes not by the author' do
      before { login(user) }

      it 'removing attempt the answer' do
        expect do
           delete :destroy, params: { question_id: question.id, id: answer }
        end.to_not change(question.answer, :count)
      end

      it 'redirects to question show' do
        delete :destroy, params: { question_id: question.id, id: answer }
        expect(response).to redirect_to question_path(question)
      end  
    end
  end
end
