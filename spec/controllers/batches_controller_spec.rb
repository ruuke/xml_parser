require 'rails_helper'

describe BatchesController, type: :controller do
  let(:batch) { create :batch }

  describe 'GET#show' do
    before { get :show, params: { id: batch } }

    it 'assigns the requested batch to @batch' do
      expect(assigns(:batch)).to eq batch
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET#new' do
    before { get :new }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST#create' do
    context 'with valid attributes' do
      it 'save a new batch in the database' do
        count = Batch.count

        expect { post :create, params: { batch: attributes_for(:batch)} }.to change(Batch, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { batch: attributes_for(:batch) }
        expect(response).to redirect_to assigns(:batch)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the batch' do
        expect { post :create, params: { batch: attributes_for(:batch, :invalid)} }.to_not change(Batch, :count)
      end

      it 're-renders new view' do
        post :create, params: { batch: attributes_for(:batch, :invalid) }
        expect(response).to render_template :new
      end
    end
  end
end
